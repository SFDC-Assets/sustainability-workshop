sfdx force:org:create -f config/project-scratch-def.json -d 1 -s -a sustainabilityref2
# https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3k000001YOKKAA4
sf package install --package 04t3k0000027CZ1AAM -w 20


# Special perm/license stuff for SustCloud
sf org assign permset-n sustain_app_SustainabilityCloudPsl
sf org assign permset -n SustainabilityAnalytics
sf org assign permset -n SustainabilityAppAuditor
sf org assign permset -n SustainabilityAppManager
sf org assign permset -n SustainabilityCloud
sf org assign permset -b integ -n InsightsBuilderPsl
sf org assign permset -b integ -n EinsteinAnalyticsUser
sf org assign permset -b integ -n SustainabilityAnalytics

sf automig load -d automig --concise --mappingobjects RecordType:DeveloperName
#sfdx automig:load -d data --concise --mappingobjects RecordType:DeveloperName

sf analytics app create -f assets/analyticsAppCreateDef.json -w 60
sfdx shane:analytics:app:share -n Sustainability --org
sf project deploy start
sf org assign permset -n SustainabilityCustom

sf org open -p /lightning/app/c__Sustainability_Console
