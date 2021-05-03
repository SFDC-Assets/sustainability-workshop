# Authenticate to an org and make it the default. Deploy to that org.
sfdx force:auth:web:login -s
# https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3k000001YOKKAA4
sfdx force:package:install --package 04t3k0000027CZ1AAM -w 20


# Special perm/license stuff for SustCloud
sfdx shane:user:psl -l User -g User -n sustain_app_SustainabilityCloudPsl
sfdx force:user:permset:assign -n SustainabilityAnalytics
sfdx force:user:permset:assign -n SustainabilityAppAuditor
sfdx force:user:permset:assign -n SustainabilityAppManager
sfdx force:user:permset:assign -n SustainabilityCloud
sfdx shane:user:psl -l User -g Integration -n InsightsBuilderPsl
sfdx shane:user:permset:assign -l User -g Integration -n EinsteinAnalyticsUser
sfdx shane:user:permset:assign -l User -g Integration -n SustainabilityAnalytics

sfdx automig:load -d automig --concise --mappingobjects RecordType:DeveloperName
#sfdx automig:load -d data --concise --mappingobjects RecordType:DeveloperName

sfdx analytics:app:create -f assets/analyticsAppCreateDef.json -w 60
sfdx shane:analytics:app:share -n Sustainability --org
sfdx force:source:deploy --sourcepath ./force-app 

sfdx force:user:permset:assign -n SustainabilityCustom

sfdx force:org:open -p /lightning/app/c__Sustainability_Console