# Comparaison Bernasconi PROD vs TEST — 2026-09-18

Retrieve complet des deux orgs via Salesforce CLI (`sf project retrieve start` avec manifest généré depuis chaque org), puis `diff -rq` entre `prod/` et `test/`.

- **prod** (`bernasconi-prod`, https://efficiency-drive-4031.my.salesforce.com) : 3108 fichiers
- **test** (`bernasconi-test`, sandbox `testupmind`) : 2950 fichiers

## Résumé

| Catégorie | Nombre |
|---|---|
| Fichiers uniquement en PROD | 197 |
| Fichiers uniquement en TEST | 196 |
| Fichiers présents des deux côtés mais **contenu différent** | 332 |

## Point notable : développement Simap en cours dans TEST

Le sandbox `test` contient des composants absents de `prod`, cohérents avec un développement en cours (interface Simap) :

- **Classes Apex** (test only) : `SimapService`, `SimapService2`, `SimapServiceTest`, `SimapQueueable`, `QueueJob`, `MockHttpResponseGenerator`
- **Flows** (test only) : `FL_OffreSimap`, `Fl_SimapOffre`, `Fl_SendAfaireCloseLost`
- **Trigger** (test only) : `AccountTrigger`
- Champs spécifiques : `objects/Simap_Federal_Entities__c`, `objects/Simap_Cantons__c`, `objects/Publication_Simap__c`

➜ Ce sont probablement les composants à déployer vers prod dans le cadre du projet Simap.

## Répartition par type — uniquement en PROD (absent de test)

| Type | Nombre |
|---|---|
| contentassets | 22 |
| permissionsets | 20 |
| objects (dont Opportunity/fields: 16) | 18 |
| layouts | 11 |
| forecastingTypes | 8 |
| flexipages | 8 |
| sharingRules | 7 |
| reportTypes | 5 |
| dashboards | 5 |
| autres (reports, territory2Types, pathAssistants, profiles, applications, animationRules...) | ~40 |

## Répartition par type — uniquement en TEST (absent de prod)

| Type | Nombre |
|---|---|
| permissionsets | 29 |
| objects/Opportunity/fields | 21 |
| flexipages | 18 |
| contentassets | 16 |
| objects | 12 |
| **classes (Apex)** | 12 |
| layouts | 11 |
| topicsForObjects | 9 |
| forecastingTypes | 8 |
| sharingRules | 7 |
| flows | 3 |
| flowDefinitions | 3 |
| triggers | 2 |
| autres | ~15 |

## Répartition par type — contenu différent (présent des deux côtés)

| Type | Nombre |
|---|---|
| objects (fields, validation rules, etc.) | 172 |
| settings | 22 |
| permissionsets | 21 |
| applications | 20 |
| flowDefinitions | 14 |
| tabs | 13 |
| flows | 12 |
| reportTypes / flexipages | 6 chacun |
| profiles | 5 |
| standardValueSets | 3 |
| permissionsetgroups | 2 |
| quickActions, notificationTypeConfig, emailservices, dashboards, cleanDataServices, brandingSets, appMenus | 1 chacun |

## Note

- Le fichier brut complet (liste ligne par ligne, ~757 lignes) a été utilisé pour produire ce résumé ; il n'est pas versionné (trop volumineux/redondant avec le contenu déjà présent dans `prod/` et `test/`).
- Pour un diff détaillé d'un composant précis, comparer directement les fichiers dans `prod/<type>/...` et `test/<type>/...`.

## Liste complète — uniquement en PROD
```
/actionPlanTemplates
/objectTranslations
animationRules/Affaires.animationRule-meta.xml
animationRules/Projet.animationRule-meta.xml
applications/standard__DigitalWallet.app-meta.xml
applications/standard__LightningInstrumentation.app-meta.xml
contentassets/AfBad2.asset
contentassets/AfBad2.asset-meta.xml
contentassets/AfGood1.asset
contentassets/AfGood1.asset-meta.xml
contentassets/Lead_generation.asset
contentassets/Lead_generation.asset-meta.xml
contentassets/LogoBernasconi.asset
contentassets/LogoBernasconi.asset-meta.xml
contentassets/LogoBernasconiProd.asset
contentassets/LogoBernasconiProd.asset-meta.xml
contentassets/Sales.asset
contentassets/Sales.asset-meta.xml
contentassets/Sales_leadersship.asset
contentassets/Sales_leadersship.asset-meta.xml
contentassets/Sales_operation.asset
contentassets/Sales_operation.asset-meta.xml
contentassets/bernasconi_1.asset
contentassets/bernasconi_1.asset-meta.xml
contentassets/relationship_management.asset
contentassets/relationship_management.asset-meta.xml
contentassets/renditionDownloadV1.asset
contentassets/renditionDownloadV1.asset-meta.xml
dashboards/Activities
dashboards/Activities.dashboardFolder-meta.xml
dashboards/Administration
dashboards/Administration.dashboardFolder-meta.xml
dashboards/CRM_180925_HVS_Sample_Dashboard_Folder
dashboards/Sales_and_Marketing_Dashboards/BySvyrhQmsjromKTMeckKTdvVscuJa.dashboard-meta.xml
dashboards/Sales_and_Marketing_Dashboards/YTdFdUrKzCzlLdXlWSClEjuoaalUmH.dashboard-meta.xml
dashboards/Sales_and_Marketing_Dashboards/arVLdYLcGUZRkUfDRfljZNJHnGBMFs.dashboard-meta.xml
documents/SalesTools
flexipages/AccountRecordPage.flexipage-meta.xml
flexipages/AdminStageUpdateRecordPage.flexipage-meta.xml
flexipages/AffaireRecordPage.flexipage-meta.xml
flexipages/ContactRecordPage.flexipage-meta.xml
flexipages/LeadRecordPage.flexipage-meta.xml
flexipages/Publication_simap_record_page.flexipage-meta.xml
flexipages/RecordPageAdminSetup.flexipage-meta.xml
flexipages/Referentiel_Record_Page.flexipage-meta.xml
forecastingTypes/Gestion_Affaires_Bernasconi.forecastingType-meta.xml
forecastingTypes/Gestion_Affaires_Bernasconi1.forecastingType-meta.xml
forecastingTypes/Gestion_Affaires_Bernasconi2.forecastingType-meta.xml
forecastingTypes/Gestion_Affaires_Bernasconi3.forecastingType-meta.xml
forecastingTypes/Gestion_Affaires_Bernasconi4.forecastingType-meta.xml
forecastingTypes/Gestion_Affaires_Bernasconi5.forecastingType-meta.xml
forecastingTypes/Gestion_Affaires_Bernasconi6.forecastingType-meta.xml
forecastingTypes/Gestion_Affaires_Bernasconi7.forecastingType-meta.xml
globalValueSets/Secteur_d_activite.globalValueSet-meta.xml
installedPackages/efl.installedPackage-meta.xml
installedPackages/sf_chttr_apps.installedPackage-meta.xml
layouts/'AccountPlan-Présentation Plan de compte.layout-meta.xml'
layouts/'AccountPlanObjective-Présentation Objectif du plan de compte.layout-meta.xml'
layouts/'AccountPlanObjectiveMeasure-Présentation Mesure de l%E2%80%99objectif du plan de compte.layout-meta.xml'
layouts/'ActionPlan-Présentation Plan d%27action.layout-meta.xml'
layouts/'ActionPlanItemDependency-Présentation Dépendance d%27élément de plan d%27action.layout-meta.xml'
layouts/'ActionPlanTemplate-Présentation Modèle de plan d%27action.layout-meta.xml'
layouts/'ActionPlanTemplateItem-Présentation �'$'\211''lément de modèle de plan d%27action.layout-meta.xml'
layouts/'ActionPlanTemplateItemValue-Présentation Valeur d%27élément de modèle de plan d%27action.layout-meta.xml'
layouts/'ActionPlanTemplateVersion-Présentation Version de modèle de plan d%27action.layout-meta.xml'
layouts/'ActionPlnTmplItmDependency-Présentation Dépendance d%27élément de modèle de plan d%27action.layout-meta.xml'
layouts/'OpportunityContactRole-Présentation Rôle de contacts de l%27opportunité.layout-meta.xml'
lwc/fileUploadImproved
objects/Account/fields/Nature_juridique__c.field-meta.xml
objects/Account/fields/Numero_Compte__c.field-meta.xml
objects/Account/fields/Secteur_d_activite__c.field-meta.xml
objects/AccountPlan
objects/AccountPlanObjMeasRela
objects/AccountPlanObjective
objects/AccountPlanObjectiveMeasure
objects/ActionPlan
objects/ActionPlanItemDependency
objects/ActionPlnTmplItmDependency
objects/ApprovalSubmission/listViews
objects/ApprovalSubmissionDetail/listViews
objects/ApprovalWorkItem/listViews
objects/AssociatedLocation/fields/AssociatedLocationNumber.field-meta.xml
objects/BatchJob
objects/BatchJobPart
objects/BatchJobPartFailedRecord
objects/CollaborationGroup/listViews
objects/ContactRequest/listViews
objects/ContentDocument/listViews
objects/Event/listViews
objects/FlowOrchestrationInstance/listViews
objects/FlowOrchestrationWorkItem/listViews
objects/Idea/listViews
objects/Lead/fields/Nature_juridique__c.field-meta.xml
objects/Lead/fields/Secteur_d_activite__c.field-meta.xml
objects/LearningAssignment
objects/LearningAssignmentProgress
objects/LearningItem
objects/LearningLinkProgress
objects/LocationTrustMeasure/listViews
objects/MessagingEndUser/fields/AuthenticatedEndUserId.field-meta.xml
objects/MessagingSession/fields/ConversationId.field-meta.xml
objects/Opportunity/businessProcesses/Projet.businessProcess-meta.xml
objects/Opportunity/fields/CalculateurNom__c.field-meta.xml
objects/Opportunity/fields/ChefProjetNom__c.field-meta.xml
objects/Opportunity/fields/Depot_de_l_offre__c.field-meta.xml
objects/Opportunity/fields/ImageNotematrice__c.field-meta.xml
objects/Opportunity/fields/Note_matrice__c.field-meta.xml
objects/Opportunity/fields/Note_reference_1er__c.field-meta.xml
objects/Opportunity/fields/Note_reference_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Note_soumissionnaire_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Objet_et_etendu_du_marche__c.field-meta.xml
objects/Opportunity/fields/Periode_de_realisation__c.field-meta.xml
objects/Opportunity/fields/Position__c.field-meta.xml
objects/Opportunity/fields/Prix_adjuge_HT__c.field-meta.xml
objects/Opportunity/fields/Prix_rendu_du_1er_HT__c.field-meta.xml
objects/Opportunity/fields/Statu__c.field-meta.xml
objects/Opportunity/fields/Terrassements__c.field-meta.xml
objects/Opportunity/fields/UpdateOpp__c.field-meta.xml
objects/Opportunity/listViews/A_statuer.listView-meta.xml
objects/Opportunity/listViews/Affaires.listView-meta.xml
objects/Opportunity/listViews/Copie_de_Toutes_les_opportunit_s.listView-meta.xml
objects/Opportunity/listViews/Copie_de_Toutes_les_opportunit_s1.listView-meta.xml
objects/Opportunity/listViews/Perdues.listView-meta.xml
objects/Opportunity/listViews/Repondues.listView-meta.xml
objects/Opportunity/recordTypes/Affaire.recordType-meta.xml
objects/ProcessException/listViews
objects/Quote/listViews
objects/Recommendation/listViews
objects/Referentiel__c/listViews/All1.listView-meta.xml
objects/RequestsForAccessSIQ
objects/Scorecard/listViews
objects/SocialPersona/listViews
objects/SocialPost/listViews
objects/Task/listViews
objects/VideoCall/listViews
objects/VideoCallRecordingStructure
objects/VideoCallTranscript
objects/VoiceCall/fields/CallerId.field-meta.xml
objects/VoiceCall/fields/RecipientId.field-meta.xml
objects/VoiceCall/listViews
objects/VoiceCallRecordingStructure
objects/WorkOrder/listViews
pathAssistants/Affaires.pathAssistant-meta.xml
pathAssistants/Default_Opportunity.pathAssistant-meta.xml
pathAssistants/Projet.pathAssistant-meta.xml
permissionsets/BernasconiApp.permissionset-meta.xml
permissionsets/CRED_Account.permissionset-meta.xml
permissionsets/CRED_Contact.permissionset-meta.xml
permissionsets/CRED_Lead.permissionset-meta.xml
permissionsets/CRED_ObjetSetupStage.permissionset-meta.xml
permissionsets/CRED_Opportunite.permissionset-meta.xml
permissionsets/CRED_OpportuniteReferentiel.permissionset-meta.xml
permissionsets/CRED_Referentiel.permissionset-meta.xml
permissionsets/Cartographie.permissionset-meta.xml
permissionsets/MFA_Skipped.permissionset-meta.xml
permissionsets/Pset_FlowConvert.permissionset-meta.xml
permissionsets/Pset_R_ponse.permissionset-meta.xml
permissionsets/READ_Account.permissionset-meta.xml
permissionsets/READ_Contact.permissionset-meta.xml
permissionsets/READ_Lead.permissionset-meta.xml
permissionsets/READ_ObjetSetupAdmin.permissionset-meta.xml
permissionsets/READ_ObjetSetupStage.permissionset-meta.xml
permissionsets/READ_Opportunite.permissionset-meta.xml
permissionsets/READ_OpportuniteReferentiel.permissionset-meta.xml
permissionsets/READ_Referentiel.permissionset-meta.xml
profilePasswordPolicies/Administrateur_Bernasconi_profilePasswordPolicy1738254371655.profilePasswordPolicy-meta.xml
profilePasswordPolicies/Bernasconi_User_Profile_profilePasswordPolicy1732116061241.profilePasswordPolicy-meta.xml
profileSessionSettings/null_profileSessionSetting1732116061304.profileSessionSetting-meta.xml
profileSessionSettings/null_profileSessionSetting1738254371698.profileSessionSetting-meta.xml
profiles/'Administrateur Bernasconi.profile-meta.xml'
profiles/'Bernasconi User Profile.profile-meta.xml'
remoteSiteSettings/SIMAP.remoteSite-meta.xml
reportTypes/AP_Accounts_with_Activities_2024_07_02.reportType-meta.xml
reportTypes/AP_Opportunities_with_Activities_2024_07_02.reportType-meta.xml
reportTypes/AP_Opptys_2024_07_02.reportType-meta.xml
reportTypes/AP_User_Activities_2024_07_02.reportType-meta.xml
reportTypes/Contact.reportType-meta.xml
reports/ActivityReports
reports/ActivityReports.reportFolder-meta.xml
reports/DashboardReportsAdoption/Administration
reports/DashboardReportsAdoption/Administration.reportFolder-meta.xml
reports/GENEVE.reportFolder-meta.xml
reports/SEANCEACQUISTION.reportFolder-meta.xml
settings/AccountPlan.settings-meta.xml
settings/ConversationServiceIntegration.settings-meta.xml
sharingRules/AccountPlan.sharingRules-meta.xml
sharingRules/ActionPlan.sharingRules-meta.xml
sharingRules/ActionPlanTemplate.sharingRules-meta.xml
sharingRules/BatchJob.sharingRules-meta.xml
sharingRules/DialerCallUsage.sharingRules-meta.xml
sharingRules/LearningItem.sharingRules-meta.xml
sharingRules/RequestsForAccessSIQ.sharingRules-meta.xml
tabs/SimapOffre.tab-meta.xml
territory2Models/Gestion_Affaires_Bernasconi
territory2Types/GE.territory2Type-meta.xml
territory2Types/NE.territory2Type-meta.xml
territory2Types/VD.territory2Type-meta.xml
```

## Liste complète — uniquement en TEST
```
/uiFormatSpecificationSets
animationRules/StatutOpportunity.animationRule-meta.xml
animationRules/StatutOpportunityProjet.animationRule-meta.xml
classes/MockHttpResponseGenerator.cls
classes/MockHttpResponseGenerator.cls-meta.xml
classes/QueueJob.cls
classes/QueueJob.cls-meta.xml
classes/SimapQueueable.cls
classes/SimapQueueable.cls-meta.xml
classes/SimapService.cls
classes/SimapService.cls-meta.xml
classes/SimapService2.cls
classes/SimapService2.cls-meta.xml
classes/SimapServiceTest.cls
classes/SimapServiceTest.cls-meta.xml
contentassets/ImageBadAffaire.asset
contentassets/ImageBadAffaire.asset-meta.xml
contentassets/ImageBadAffaireV2.asset
contentassets/ImageBadAffaireV2.asset-meta.xml
contentassets/ImageGoodAffaire.asset
contentassets/ImageGoodAffaire.asset-meta.xml
contentassets/NoBad.asset
contentassets/NoBad.asset-meta.xml
contentassets/bernasconi.asset
contentassets/bernasconi.asset-meta.xml
contentassets/goodbon.asset
contentassets/goodbon.asset-meta.xml
contentassets/logo.asset
contentassets/logo.asset-meta.xml
contentassets/logo1.asset
contentassets/logo1.asset-meta.xml
dashboards/Sales_and_Marketing_Dashboards/EhdOfDGKfOVRCDJTwyOgJdTJLwGjKL.dashboard-meta.xml
dashboards/Sales_and_Marketing_Dashboards/VWAHaAjVBihxrfdBDRQkFYOUndnDpL.dashboard-meta.xml
dashboards/Sales_and_Marketing_Dashboards/ozvHikUcHwipOVtDDQmKkYdTsuYfHK.dashboard-meta.xml
dashboards/Sales_and_Marketing_Dashboards/swDAdIqkYsQgwcKqAeuvlybDYJrlte.dashboard-meta.xml
flexipages/Account_Record_Page.flexipage-meta.xml
flexipages/Admin_Object_Setup_Record_Page.flexipage-meta.xml
flexipages/Contact_Record_Page.flexipage-meta.xml
flexipages/Lead_Record_Page.flexipage-meta.xml
flexipages/OpportunitiesRecordPage.flexipage-meta.xml
flexipages/Opportunity_Record_Page.flexipage-meta.xml
flexipages/Opportunity_Record_Page1.flexipage-meta.xml
flexipages/Publication_Simap_Detail_Record_Page.flexipage-meta.xml
flexipages/Publication_Simap_Detail_Record_Page1.flexipage-meta.xml
flexipages/Publication_Simap_Record_Page.flexipage-meta.xml
flexipages/Publication_Simap_Record_Page1.flexipage-meta.xml
flexipages/R_f_rentiel_Record_Page.flexipage-meta.xml
flexipages/RecordPageAffaire.flexipage-meta.xml
flexipages/Secteur_Record_Page.flexipage-meta.xml
flexipages/Simap_Canton_Record_Page.flexipage-meta.xml
flexipages/SiteOpportunit_Record_Page.flexipage-meta.xml
flexipages/Site_Record_Page.flexipage-meta.xml
flexipages/TrustedServicesPrivacyAgent_UtilityBar.flexipage-meta.xml
flowDefinitions/FL_OffreSimap.flowDefinition-meta.xml
flowDefinitions/Fl_SendAfaireCloseLost.flowDefinition-meta.xml
flowDefinitions/Fl_SimapOffre.flowDefinition-meta.xml
flows/FL_OffreSimap.flow-meta.xml
flows/Fl_SendAfaireCloseLost.flow-meta.xml
flows/Fl_SimapOffre.flow-meta.xml
forecastingTypes/Gestion_Opportunit_s_Bernasconi.forecastingType-meta.xml
forecastingTypes/Gestion_Opportunit_s_Bernasconi1.forecastingType-meta.xml
forecastingTypes/Gestion_Opportunit_s_Bernasconi2.forecastingType-meta.xml
forecastingTypes/Gestion_Opportunit_s_Bernasconi3.forecastingType-meta.xml
forecastingTypes/Gestion_Opportunit_s_Bernasconi4.forecastingType-meta.xml
forecastingTypes/Gestion_Opportunit_s_Bernasconi5.forecastingType-meta.xml
forecastingTypes/Gestion_Opportunit_s_Bernasconi6.forecastingType-meta.xml
forecastingTypes/Gestion_Opportunit_s_Bernasconi7.forecastingType-meta.xml
globalValueSets/Secteur_d_activit.globalValueSet-meta.xml
layouts/'BrowserPolicyViolation-Browser Policy Violation Layout.layout-meta.xml'
layouts/'FlowRecordVersionOccurrence-%5F%5FMISSING LABEL%5F%5F PropertyFile - val FlowRecordVersionOccurrence not found in section StandardLayouts.layout-meta.xml'
layouts/'OpportunityContactRole-Opportunity Contact Role Layout.layout-meta.xml'
layouts/'Secteur__c-Secteur Layout.layout-meta.xml'
layouts/'SiteOpportunit__c-SiteOpportunité Layout.layout-meta.xml'
layouts/'Site__c-Site Layout.layout-meta.xml'
layouts/'WorkPlan-Work Plan Layout.layout-meta.xml'
layouts/'WorkPlanTemplate-Work Plan Template Layout.layout-meta.xml'
layouts/'WorkPlanTemplateEntry-Work Plan Template Entry Layout.layout-meta.xml'
layouts/'WorkStep-Work Step Layout.layout-meta.xml'
layouts/'WorkStepTemplate-Work Step Template Layout.layout-meta.xml'
lwc/simap_publication_page_detail
objects/Account/fields/Nature_Juridique__c.field-meta.xml
objects/Account/fields/Numero_de_compte__c.field-meta.xml
objects/Account/fields/Secteur_d_activit__c.field-meta.xml
objects/Account/validationRules
objects/Admin_Objet_Update_Stage__c/listViews/All1.listView-meta.xml
objects/ApprovalWorkItem/fields/OwnerId.field-meta.xml
objects/Event/fields/MeetingUrl.field-meta.xml
objects/Lead/fields/Nature_Juridique__c.field-meta.xml
objects/Lead/fields/Secteur_d_activit__c.field-meta.xml
objects/MessagingSessionClient
objects/Opportunity/businessProcesses/OpportunitéProjet.businessProcess-meta.xml
objects/Opportunity/fields/Calculateur_Last_Name__c.field-meta.xml
objects/Opportunity/fields/Calculateur_first_name__c.field-meta.xml
objects/Opportunity/fields/D_p_t_d_offre_par__c.field-meta.xml
objects/Opportunity/fields/ImageNoteMatrice__c.field-meta.xml
objects/Opportunity/fields/LastSyncTime.field-meta.xml
objects/Opportunity/fields/Montant_adjug_HT_Total__c.field-meta.xml
objects/Opportunity/fields/Note_Matrice__c.field-meta.xml
objects/Opportunity/fields/Note_References_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Note_Soumissionnaire_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Note_references_1_er__c.field-meta.xml
objects/Opportunity/fields/Objet_et_tendu_du_march__c.field-meta.xml
objects/Opportunity/fields/P_riode_de_r_alisation__c.field-meta.xml
objects/Opportunity/fields/Position_Pilote__c.field-meta.xml
objects/Opportunity/fields/Pr_qualification__c.field-meta.xml
objects/Opportunity/fields/Prix_adjug_HT__c.field-meta.xml
objects/Opportunity/fields/Prix_rendu_du_1_er_HT__c.field-meta.xml
objects/Opportunity/fields/Secteur__c.field-meta.xml
objects/Opportunity/fields/Status__c.field-meta.xml
objects/Opportunity/fields/TechNumeroDossier__c.field-meta.xml
objects/Opportunity/fields/Terrassements_M__c.field-meta.xml
objects/Opportunity/fields/UBDZone__c.field-meta.xml
objects/Opportunity/listViews/Affaire.listView-meta.xml
objects/Opportunity/listViews/AffaireParTerritoireCanton.listView-meta.xml
objects/Opportunity/listViews/Copy_of_Affaire.listView-meta.xml
objects/Opportunity/recordTypes/Affaires.recordType-meta.xml
objects/OpportunityLineItem/fields/LastSyncTime.field-meta.xml
objects/OutboundEngagementTemplate
objects/OutboundEngmtContentRsrc
objects/Publication_Simap__c/listViews/Test.listView-meta.xml
objects/Referentiel__c/listViews/All.listView-meta.xml
objects/Secteur__c
objects/SimapProcessingComplete__e
objects/Simap_Cantons__c/fields/simap_canton_id__c.field-meta.xml
objects/Simap_Federal_Entities__c/fields/simap_federal_entity_id__c.field-meta.xml
objects/SiteOpportunit__c
objects/Site__c
objects/WorkPlan
objects/WorkPlanTemplate
objects/WorkPlanTemplateEntry
objects/WorkStep
objects/WorkStepTemplate
pathAssistants/StatutOpportunity.pathAssistant-meta.xml
pathAssistants/StatutOpportunityProjet.pathAssistant-meta.xml
permissionsets/Cartographie_Opportunit.permissionset-meta.xml
permissionsets/FlowPset.permissionset-meta.xml
permissionsets/Permission_Set_Convertir_les_pistes.permissionset-meta.xml
permissionsets/Pset_App_Benasconi.permissionset-meta.xml
permissionsets/Pset_CRED_Account.permissionset-meta.xml
permissionsets/Pset_CRED_AdminObjectSetup.permissionset-meta.xml
permissionsets/Pset_CRED_AdminObjetUpdateStage.permissionset-meta.xml
permissionsets/Pset_CRED_Contact.permissionset-meta.xml
permissionsets/Pset_CRED_Lead.permissionset-meta.xml
permissionsets/Pset_CRED_Opportunity.permissionset-meta.xml
permissionsets/Pset_CRED_Opportunity_R_f_rentiel.permissionset-meta.xml
permissionsets/Pset_CRED_R_f_rentiel.permissionset-meta.xml
permissionsets/Pset_CRED_Secteur.permissionset-meta.xml
permissionsets/Pset_CRED_SimapProcessingComplete_e.permissionset-meta.xml
permissionsets/Pset_CRED_Site.permissionset-meta.xml
permissionsets/Pset_CRED_SiteOpportunity.permissionset-meta.xml
permissionsets/Pset_Only_Read_Opportunity_R_f_rentiel.permissionset-meta.xml
permissionsets/Pset_Only_Referentiel.permissionset-meta.xml
permissionsets/Pset_READ_ONLY_AdminObjetUpdateStage.permissionset-meta.xml
permissionsets/Pset_READ_ONLY_Admin_Object_Setup.permissionset-meta.xml
permissionsets/Pset_Read_Only_Account.permissionset-meta.xml
permissionsets/Pset_Read_Only_Contact.permissionset-meta.xml
permissionsets/Pset_Read_Only_Lead.permissionset-meta.xml
permissionsets/Pset_Read_Opportunity.permissionset-meta.xml
permissionsets/Pset_Read_Secteur.permissionset-meta.xml
permissionsets/Pset_Read_Site.permissionset-meta.xml
permissionsets/Pset_Read_SiteOpportunity.permissionset-meta.xml
permissionsets/Pset_Reponse.permissionset-meta.xml
permissionsets/TestCustomSettings.permissionset-meta.xml
profilePasswordPolicies/Bernasconi_User_Profil_profilePasswordPolicy1718267341113.profilePasswordPolicy-meta.xml
profilePasswordPolicies/UserProfilBernasconi_profilePasswordPolicy1722344907181.profilePasswordPolicy-meta.xml
profileSessionSettings/null_profileSessionSetting1718267341156.profileSessionSetting-meta.xml
profileSessionSettings/null_profileSessionSetting1722344907211.profileSessionSetting-meta.xml
profiles/'Bernasconi User Profil.profile-meta.xml'
quickActions/Publication_Simap__c.SimapOffre.quickAction-meta.xml
remoteSiteSettings/simap.remoteSite-meta.xml
sharingRules/OutboundEngagementTemplate.sharingRules-meta.xml
sharingRules/OutboundEngmtContentRsrc.sharingRules-meta.xml
sharingRules/SiteOpportunit__c.sharingRules-meta.xml
sharingRules/Site__c.sharingRules-meta.xml
sharingRules/WorkPlan.sharingRules-meta.xml
sharingRules/WorkPlanTemplate.sharingRules-meta.xml
sharingRules/WorkStepTemplate.sharingRules-meta.xml
tabs/Secteur__c.tab-meta.xml
tabs/Simap.tab-meta.xml
tabs/SiteOpportunit__c.tab-meta.xml
tabs/Site__c.tab-meta.xml
territory2Models/Gestion_Opportunit_s_Bernasconi
territory2Types/A.territory2Type-meta.xml
territory2Types/AGENCE_NE.territory2Type-meta.xml
territory2Types/AGENCE_VD.territory2Type-meta.xml
topicsForObjects/AssociatedLocation.topicsForObjects-meta.xml
topicsForObjects/Secteur__c.topicsForObjects-meta.xml
topicsForObjects/SiteOpportunit__c.topicsForObjects-meta.xml
topicsForObjects/Site__c.topicsForObjects-meta.xml
topicsForObjects/WorkPlan.topicsForObjects-meta.xml
topicsForObjects/WorkPlanTemplate.topicsForObjects-meta.xml
topicsForObjects/WorkPlanTemplateEntry.topicsForObjects-meta.xml
topicsForObjects/WorkStep.topicsForObjects-meta.xml
topicsForObjects/WorkStepTemplate.topicsForObjects-meta.xml
triggers/AccountTrigger.trigger
triggers/AccountTrigger.trigger-meta.xml
```

## Liste complète — contenu différent (présent des deux côtés)
```
Files prod/layouts/Account-Account Layout.layout-meta.xml and test/layouts/Account-Account Layout.layout-meta.xml differ
Files prod/layouts/Admin_Objet_Update_Stage__c-Admin Objet Update Stage Layout.layout-meta.xml and test/layouts/Admin_Objet_Update_Stage__c-Admin Objet Update Stage Layout.layout-meta.xml differ
Files prod/layouts/CaseInteraction-Case Feed Layout.layout-meta.xml and test/layouts/CaseInteraction-Case Feed Layout.layout-meta.xml differ
Files prod/layouts/Contact-Contact Layout.layout-meta.xml and test/layouts/Contact-Contact Layout.layout-meta.xml differ
Files prod/layouts/FlowTableViewDefinition__c-FlowTableViewDefinition Layout.layout-meta.xml and test/layouts/FlowTableViewDefinition__c-FlowTableViewDefinition Layout.layout-meta.xml differ
Files prod/layouts/Global-Global Layout.layout-meta.xml and test/layouts/Global-Global Layout.layout-meta.xml differ
Files prod/layouts/Lead-Lead Layout.layout-meta.xml and test/layouts/Lead-Lead Layout.layout-meta.xml differ
Files prod/layouts/Opportunity-Opportunity Layout.layout-meta.xml and test/layouts/Opportunity-Opportunity Layout.layout-meta.xml differ
Files prod/layouts/Publication_Simap__c-Publication Simap Layout.layout-meta.xml and test/layouts/Publication_Simap__c-Publication Simap Layout.layout-meta.xml differ
Files prod/layouts/Simap_Cantons__c-Simap Canton Layout.layout-meta.xml and test/layouts/Simap_Cantons__c-Simap Canton Layout.layout-meta.xml differ
Files prod/layouts/Simap_Code_CPV__c-Simap Code CPV Layout.layout-meta.xml and test/layouts/Simap_Code_CPV__c-Simap Code CPV Layout.layout-meta.xml differ
Files prod/layouts/Simap_Federal_Entities__c-Simap Federal Entity Layout.layout-meta.xml and test/layouts/Simap_Federal_Entities__c-Simap Federal Entity Layout.layout-meta.xml differ
Files prod/layouts/Simap_Type_de_Contrat__c-Simap Type de Contrat Layout.layout-meta.xml and test/layouts/Simap_Type_de_Contrat__c-Simap Type de Contrat Layout.layout-meta.xml differ
Files prod/profiles/Analytics Cloud Integration User.profile-meta.xml and test/profiles/Analytics Cloud Integration User.profile-meta.xml differ
Files prod/profiles/Analytics Cloud Security User.profile-meta.xml and test/profiles/Analytics Cloud Security User.profile-meta.xml differ
Files prod/profiles/Anypoint Integration.profile-meta.xml and test/profiles/Anypoint Integration.profile-meta.xml differ
Files prod/profiles/CPQ Integration User.profile-meta.xml and test/profiles/CPQ Integration User.profile-meta.xml differ
Files prod/profiles/Chatter External User.profile-meta.xml and test/profiles/Chatter External User.profile-meta.xml differ
Files prod/profiles/Chatter Free User.profile-meta.xml and test/profiles/Chatter Free User.profile-meta.xml differ
Files prod/profiles/Chatter Moderator User.profile-meta.xml and test/profiles/Chatter Moderator User.profile-meta.xml differ
Files prod/profiles/End User.profile-meta.xml and test/profiles/End User.profile-meta.xml differ
Files prod/profiles/Executive Sponsor.profile-meta.xml and test/profiles/Executive Sponsor.profile-meta.xml differ
Files prod/profiles/Guest License User.profile-meta.xml and test/profiles/Guest License User.profile-meta.xml differ
Files prod/profiles/Identity User.profile-meta.xml and test/profiles/Identity User.profile-meta.xml differ
Files prod/profiles/Minimum Access - API Only Integrations.profile-meta.xml and test/profiles/Minimum Access - API Only Integrations.profile-meta.xml differ
Files prod/profiles/Minimum Access - Salesforce.profile-meta.xml and test/profiles/Minimum Access - Salesforce.profile-meta.xml differ
Files prod/profiles/Read Only.profile-meta.xml and test/profiles/Read Only.profile-meta.xml differ
Files prod/profiles/Sales Insights Integration User.profile-meta.xml and test/profiles/Sales Insights Integration User.profile-meta.xml differ
Files prod/profiles/Salesforce API Only System Integrations.profile-meta.xml and test/profiles/Salesforce API Only System Integrations.profile-meta.xml differ
appMenus/AppSwitcher.appMenu-meta.xml
applications/BERNASCONI.app-meta.xml
applications/Inside_Sales.app-meta.xml
applications/Sales_Leader.app-meta.xml
applications/Sales_Operations.app-meta.xml
applications/Success_Manager.app-meta.xml
applications/standard__AppLauncher.app-meta.xml
applications/standard__Chatter.app-meta.xml
applications/standard__Community.app-meta.xml
applications/standard__FlowsApp.app-meta.xml
applications/standard__HVSConsole.app-meta.xml
applications/standard__LightningBolt.app-meta.xml
applications/standard__LightningSales.app-meta.xml
applications/standard__LightningSalesConsole.app-meta.xml
applications/standard__Marketing.app-meta.xml
applications/standard__OnlineSales.app-meta.xml
applications/standard__Platform.app-meta.xml
applications/standard__Sales.app-meta.xml
applications/standard__SalesforceCMS.app-meta.xml
applications/standard__Service.app-meta.xml
applications/standard__ServiceConsole.app-meta.xml
brandingSets/LEXTHEMINGBernasconiSA.brandingSet-meta.xml
cleanDataServices/DataCloudGeoLocation.cleanDataService-meta.xml
dashboards/CRM_180925_HVS_Sample_Dashboard_Folder.dashboardFolder-meta.xml
emailservices/EmailToSalesforce.xml-meta.xml
flexipages/Account_Record_Page_Three_Column.flexipage-meta.xml
flexipages/Getting_Started_Home.flexipage-meta.xml
flexipages/Home_Page_Default.flexipage-meta.xml
flexipages/Opportunit_R_f_rentiel_Record_Page.flexipage-meta.xml
flexipages/Opportunity_Record_Page_Three_Column.flexipage-meta.xml
flexipages/ProjetRecordPage.flexipage-meta.xml
flowDefinitions/FL_ScreenNoteOpportunite.flowDefinition-meta.xml
flowDefinitions/Fl_CreateNumeroDossierOpportunityAffaire.flowDefinition-meta.xml
flowDefinitions/Fl_CreateOpportunityR_f_rentiel.flowDefinition-meta.xml
flowDefinitions/Fl_DisplayOpportunityName.flowDefinition-meta.xml
flowDefinitions/Fl_GestionNumerotation.flowDefinition-meta.xml
flowDefinitions/Fl_OpportuityStatutUpdate.flowDefinition-meta.xml
flowDefinitions/Fl_ScreenConvertOpp.flowDefinition-meta.xml
flowDefinitions/Fl_UpdateAmontFieldEstimation_MontantBernasconi.flowDefinition-meta.xml
flowDefinitions/Fl_UpdateCloseDate.flowDefinition-meta.xml
flowDefinitions/Fl_UpdateOppFieldSimapPublication.flowDefinition-meta.xml
flowDefinitions/Fl_UpdateProbaliteObtentionAffaire.flowDefinition-meta.xml
flowDefinitions/Fl_UpdatePublicationSimap.flowDefinition-meta.xml
flowDefinitions/TestSendEmail.flowDefinition-meta.xml
flowDefinitions/TestSubflow.flowDefinition-meta.xml
flows/Fl_CreateNumeroDossierOpportunityAffaire.flow-meta.xml
flows/Fl_GestionNumerotation.flow-meta.xml
flows/Fl_OpportuityStatutUpdate.flow-meta.xml
flows/Fl_ScreenConvertOpp.flow-meta.xml
flows/Fl_UpdateAmontFieldEstimation_MontantBernasconi.flow-meta.xml
flows/Fl_UpdateCloseDate.flow-meta.xml
flows/Fl_UpdateProbaliteObtentionAffaire.flow-meta.xml
flows/Fl_UpdatePublicationSimap.flow-meta.xml
flows/Fl_UpdateTechTerritoryField.flow-meta.xml
flows/SendEmail.flow-meta.xml
flows/TestSendEmail.flow-meta.xml
flows/TestSubflow.flow-meta.xml
notificationTypeConfig/NotificationTypeConfig.config-meta.xml
objects/Account/Account.object-meta.xml
objects/Account/listViews/AllAccounts.listView-meta.xml
objects/Admin_Object_Setup__c/Admin_Object_Setup__c.object-meta.xml
objects/Admin_Objet_Update_Stage__c/Admin_Objet_Update_Stage__c.object-meta.xml
objects/Admin_Objet_Update_Stage__c/fields/StageName__c.field-meta.xml
objects/Admin_Objet_Update_Stage__c/fields/Status__c.field-meta.xml
objects/AssociatedLocation/AssociatedLocation.object-meta.xml
objects/Contact/Contact.object-meta.xml
objects/Contact/listViews/AllContacts.listView-meta.xml
objects/Contact/listViews/MyContacts.listView-meta.xml
objects/Lead/Lead.object-meta.xml
objects/Lead/listViews/AllOpenLeads.listView-meta.xml
objects/Opportunit_R_f_rentiel__c/Opportunit_R_f_rentiel__c.object-meta.xml
objects/Opportunit_R_f_rentiel__c/fields/Resultat__c.field-meta.xml
objects/Opportunity/Opportunity.object-meta.xml
objects/Opportunity/compactLayouts/New_Awesome_Companct_Layout.compactLayout-meta.xml
objects/Opportunity/fields/AccountId.field-meta.xml
objects/Opportunity/fields/Aciers_To__c.field-meta.xml
objects/Opportunity/fields/Activit__c.field-meta.xml
objects/Opportunity/fields/Adresse__c.field-meta.xml
objects/Opportunity/fields/Affaire__c.field-meta.xml
objects/Opportunity/fields/Affaire_termin_e__c.field-meta.xml
objects/Opportunity/fields/Agence__c.field-meta.xml
objects/Opportunity/fields/Amount.field-meta.xml
objects/Opportunity/fields/Assistante_ACQ__c.field-meta.xml
objects/Opportunity/fields/Autres_membres_Consortium__c.field-meta.xml
objects/Opportunity/fields/B_ton_M__c.field-meta.xml
objects/Opportunity/fields/Bamo__c.field-meta.xml
objects/Opportunity/fields/Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Budget_Confirmed__c.field-meta.xml
objects/Opportunity/fields/Bureau_Architecte_2__c.field-meta.xml
objects/Opportunity/fields/Bureau_Architecte_3__c.field-meta.xml
objects/Opportunity/fields/Bureau_Architecte__c.field-meta.xml
objects/Opportunity/fields/Bureau_Ing_nieur_DT__c.field-meta.xml
objects/Opportunity/fields/Ca_r_alis_march_de_base__c.field-meta.xml
objects/Opportunity/fields/Calculateur__c.field-meta.xml
objects/Opportunity/fields/CampaignId.field-meta.xml
objects/Opportunity/fields/Canton__c.field-meta.xml
objects/Opportunity/fields/Chiffre_d_affaire_r_alis__c.field-meta.xml
objects/Opportunity/fields/Cible__c.field-meta.xml
objects/Opportunity/fields/Classement_l_ouverture__c.field-meta.xml
objects/Opportunity/fields/CloseDate.field-meta.xml
objects/Opportunity/fields/Coef_sur_D_S__c.field-meta.xml
objects/Opportunity/fields/Commentaires__c.field-meta.xml
objects/Opportunity/fields/Conducteur_de_travaux__c.field-meta.xml
objects/Opportunity/fields/Cons__c.field-meta.xml
objects/Opportunity/fields/ContractId.field-meta.xml
objects/Opportunity/fields/Credit_d_heures_h__c.field-meta.xml
objects/Opportunity/fields/Crit_res_prix__c.field-meta.xml
objects/Opportunity/fields/D_but_Travaux__c.field-meta.xml
objects/Opportunity/fields/Date_adjudication__c.field-meta.xml
objects/Opportunity/fields/Date_de_cr_ation__c.field-meta.xml
objects/Opportunity/fields/Date_de_remise_offre__c.field-meta.xml
objects/Opportunity/fields/Date_de_visite__c.field-meta.xml
objects/Opportunity/fields/Date_fin_des_travaux__c.field-meta.xml
objects/Opportunity/fields/Date_ouverture_Offre__c.field-meta.xml
objects/Opportunity/fields/Date_remise_questions__c.field-meta.xml
objects/Opportunity/fields/Date_transmission_ouverture_des_offres__c.field-meta.xml
objects/Opportunity/fields/Delta_prix_adjudication_HT__c.field-meta.xml
objects/Opportunity/fields/Description.field-meta.xml
objects/Opportunity/fields/Discovery_Completed__c.field-meta.xml
objects/Opportunity/fields/Dossier__c.field-meta.xml
objects/Opportunity/fields/Dur_e_des_travaux__c.field-meta.xml
objects/Opportunity/fields/Ecart_Montant_Laur_at_V_S_montant_offre__c.field-meta.xml
objects/Opportunity/fields/Ecart_avec_notre_offre_en__c.field-meta.xml
objects/Opportunity/fields/Enrob_s_To__c.field-meta.xml
objects/Opportunity/fields/Estimation_HT_Connu__c.field-meta.xml
objects/Opportunity/fields/Estimation_HT__c.field-meta.xml
objects/Opportunity/fields/Files_Ids__c.field-meta.xml
objects/Opportunity/fields/Int_r_t__c.field-meta.xml
objects/Opportunity/fields/IsPrivate.field-meta.xml
objects/Opportunity/fields/Laur_at_Adjug_del__c.field-meta.xml
objects/Opportunity/fields/LeadSource.field-meta.xml
objects/Opportunity/fields/Lien_PDF__c.field-meta.xml
objects/Opportunity/fields/Lien_Simap__c.field-meta.xml
objects/Opportunity/fields/Loss_Reason__c.field-meta.xml
objects/Opportunity/fields/M_thode__c.field-meta.xml
objects/Opportunity/fields/Ma_tre_Ouvrage_1__c.field-meta.xml
objects/Opportunity/fields/Ma_tre_Ouvrage_2__c.field-meta.xml
objects/Opportunity/fields/Maitre_d_ouvrage_3__c.field-meta.xml
objects/Opportunity/fields/Maitre_d_uvre_1__c.field-meta.xml
objects/Opportunity/fields/Maitre_d_uvre_2__c.field-meta.xml
objects/Opportunity/fields/Maitre_d_uvre_3__c.field-meta.xml
objects/Opportunity/fields/Marge_Brut__c.field-meta.xml
objects/Opportunity/fields/Marge_Net__c.field-meta.xml
objects/Opportunity/fields/Marge_objectif_en__c.field-meta.xml
objects/Opportunity/fields/Mntant_r_pondu_variante_3__c.field-meta.xml
objects/Opportunity/fields/Montant_D_Attribution__c.field-meta.xml
objects/Opportunity/fields/Montant_Offre_si_Montant_Laur_at_renseig__c.field-meta.xml
objects/Opportunity/fields/Montant_Repondu_HT_Base_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Montant_adjug_HT_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Montant_de_l_offre_Base__c.field-meta.xml
objects/Opportunity/fields/Montant_de_l_offre_QP_en_K__c.field-meta.xml
objects/Opportunity/fields/Montant_du_laur_at_en_Ke__c.field-meta.xml
objects/Opportunity/fields/Montant_r_pondu_variante_3__c.field-meta.xml
objects/Opportunity/fields/Montant_repondu_HT_Part_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Montant_repondu_HT_Variante_1_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Montant_repondu_HT_Variante_2_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/N_SIMAP_OLMERO_mail__c.field-meta.xml
objects/Opportunity/fields/N_d_affaire_Chantier__c.field-meta.xml
objects/Opportunity/fields/Name.field-meta.xml
objects/Opportunity/fields/Nature_travaux__c.field-meta.xml
objects/Opportunity/fields/NextStep.field-meta.xml
objects/Opportunity/fields/Nom_Architecte__c.field-meta.xml
objects/Opportunity/fields/Nom_Concurrent_1__c.field-meta.xml
objects/Opportunity/fields/Nom_Concurrent_2__c.field-meta.xml
objects/Opportunity/fields/Nom_Concurrent_3__c.field-meta.xml
objects/Opportunity/fields/Nom_Etude__c.field-meta.xml
objects/Opportunity/fields/Nom_Responsable_MO_1__c.field-meta.xml
objects/Opportunity/fields/Nom_de_l_attributaire__c.field-meta.xml
objects/Opportunity/fields/Nom_du_Bamo__c.field-meta.xml
objects/Opportunity/fields/Nom_du_responsable_chef_de_projet__c.field-meta.xml
objects/Opportunity/fields/Nom_du_responsable_ma_tre_d_ouvrage_2__c.field-meta.xml
objects/Opportunity/fields/Notation__c.field-meta.xml
objects/Opportunity/fields/Note_Developpement_durable_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Note_Environnement_Securite_1er__c.field-meta.xml
objects/Opportunity/fields/Note_Environnement_Securite_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Note_Formation_1_er__c.field-meta.xml
objects/Opportunity/fields/Note_Formation_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Note_Organisation_1_er__c.field-meta.xml
objects/Opportunity/fields/Note_Organisation_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Note_Organisation_du_Soumissionnaire_1er__c.field-meta.xml
objects/Opportunity/fields/Note_Planning_1_er__c.field-meta.xml
objects/Opportunity/fields/Note_Planning_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Note_Qualite_Technique_1_er__c.field-meta.xml
objects/Opportunity/fields/Note_Qualite_Technique_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Note_developpement_durable_1_er__c.field-meta.xml
objects/Opportunity/fields/Note_prix_1er__c.field-meta.xml
objects/Opportunity/fields/Note_prix_Bernasconi__c.field-meta.xml
objects/Opportunity/fields/Numero_Simap__c.field-meta.xml
objects/Opportunity/fields/Numero_dossier__c.field-meta.xml
objects/Opportunity/fields/OwnerId.field-meta.xml
objects/Opportunity/fields/Prix_rendu_concurrent_1__c.field-meta.xml
objects/Opportunity/fields/Prix_rendu_concurrent_2__c.field-meta.xml
objects/Opportunity/fields/Prix_rendu_concurrent_3__c.field-meta.xml
objects/Opportunity/fields/Probabilit_d_obtention__c.field-meta.xml
objects/Opportunity/fields/Probability.field-meta.xml
objects/Opportunity/fields/Projet__c.field-meta.xml
objects/Opportunity/fields/ROI_Analysis_Completed__c.field-meta.xml
objects/Opportunity/fields/R_u_le__c.field-meta.xml
objects/Opportunity/fields/StageName.field-meta.xml
objects/Opportunity/fields/SyncedQuoteId.field-meta.xml
objects/Opportunity/fields/TECH_BERNASCONI__c.field-meta.xml
objects/Opportunity/fields/TechAutoAffaire__c.field-meta.xml
objects/Opportunity/fields/TechEstilation_HT__c.field-meta.xml
objects/Opportunity/fields/TechTerritoire__c.field-meta.xml
objects/Opportunity/fields/TestV1__c.field-meta.xml
objects/Opportunity/fields/TotalOpportunityQuantity.field-meta.xml
objects/Opportunity/fields/Type.field-meta.xml
objects/Opportunity/fields/Visite_Obligatoire__c.field-meta.xml
objects/Opportunity/fields/is_processed__c.field-meta.xml
objects/Opportunity/fields/latitude__c.field-meta.xml
objects/Opportunity/fields/longitude__c.field-meta.xml
objects/Opportunity/listViews/AllOpportunities.listView-meta.xml
objects/Opportunity/listViews/Projet.listView-meta.xml
objects/Opportunity/listViews/Won.listView-meta.xml
objects/Opportunity/recordTypes/Projet.recordType-meta.xml
objects/Opportunity/validationRules/ChampsObligatoireEtapeRepondue.validationRule-meta.xml
objects/OrderItem/OrderItem.object-meta.xml
objects/Publication_Simap__c/Publication_Simap__c.object-meta.xml
objects/Referentiel__c/Referentiel__c.object-meta.xml
objects/Referentiel__c/fields/TechFormuleCalculR_sultat__c.field-meta.xml
objects/SfdcPartnerSbscrOffer/fields/ContractTerm.field-meta.xml
objects/Simap_Adjudications_et_mises_a_jour__c/listViews/All.listView-meta.xml
objects/Simap_Code_CPV__c/listViews/All.listView-meta.xml
objects/Simap_Federal_Entities__c/listViews/All.listView-meta.xml
objects/Simap_Type_de_Contrat__c/fields/Nom_API_param__c.field-meta.xml
objects/Simap_Type_de_Contrat__c/listViews/All.listView-meta.xml
objects/Simap_Type_de_Publication__c/listViews/All.listView-meta.xml
objects/Simap_Type_de_procedure__c/listViews/All.listView-meta.xml
objects/UserProvisioningRequest/UserProvisioningRequest.object-meta.xml
objects/VideoCallRecording/VideoCallRecording.object-meta.xml
permissionsetgroups/PsetGroupCRED.permissionsetgroup-meta.xml
permissionsetgroups/PsetGroupREAD.permissionsetgroup-meta.xml
permissionsets/CRED_ObjetSetupAdmin.permissionset-meta.xml
permissionsets/CRED_Reponse.permissionset-meta.xml
permissionsets/Pset_CRED_Publication_Simap_Detail_c.permissionset-meta.xml
permissionsets/Pset_CRED_Publication_Simap_c.permissionset-meta.xml
permissionsets/Pset_CRED_Simap_Adjudications_et_mises_a_jour_c.permissionset-meta.xml
permissionsets/Pset_CRED_Simap_Cantons_c.permissionset-meta.xml
permissionsets/Pset_CRED_Simap_Code_CPV_c.permissionset-meta.xml
permissionsets/Pset_CRED_Simap_Federal_Entities_c.permissionset-meta.xml
permissionsets/Pset_CRED_Simap_Type_de_Contrat_c.permissionset-meta.xml
permissionsets/Pset_CRED_Simap_Type_de_Publication_c.permissionset-meta.xml
permissionsets/Pset_Read_Publication_Simap_Detail_c.permissionset-meta.xml
permissionsets/Pset_Read_Publication_Simap_c.permissionset-meta.xml
permissionsets/Pset_Read_Simap_Adjudications_et_mises_a_jour_c.permissionset-meta.xml
permissionsets/Pset_Read_Simap_Cantons_c.permissionset-meta.xml
permissionsets/Pset_Read_Simap_Code_CPV_c.permissionset-meta.xml
permissionsets/Pset_Read_Simap_Federal_Entities_c.permissionset-meta.xml
permissionsets/Pset_Read_Simap_Type_de_Contrat_c.permissionset-meta.xml
permissionsets/Pset_Read_Simap_Type_de_Publication_c.permissionset-meta.xml
permissionsets/Pset_Read_Simap_Type_de_procedure_c.permissionset-meta.xml
permissionsets/Sales_User.permissionset-meta.xml
permissionsets/sfdcInternalInt__sfdc_activityplatform.permissionset-meta.xml
profiles/Admin.profile-meta.xml
profiles/ContractManager.profile-meta.xml
profiles/MarketingProfile.profile-meta.xml
profiles/SolutionManager.profile-meta.xml
profiles/Standard.profile-meta.xml
quickActions/NewAccount.quickAction-meta.xml
reportTypes/Accounts_with_Contacts_with_Daily_Engagements.reportType-meta.xml
reportTypes/Leads_With_or_Without_Sales_Cadence_Trackers.reportType-meta.xml
reportTypes/Leads_and_Sales_Cadence_Trackers.reportType-meta.xml
reportTypes/Leads_with_Daily_Engagements.reportType-meta.xml
reportTypes/Leads_with_Monthly_Engagements.reportType-meta.xml
reportTypes/Opportunities_with_Historical_Trending.reportType-meta.xml
settings/Address.settings-meta.xml
settings/Analytics.settings-meta.xml
settings/ConversationalIntelligence.settings-meta.xml
settings/Deployment.settings-meta.xml
settings/DevHub.settings-meta.xml
settings/EAC.settings-meta.xml
settings/EmailAdministration.settings-meta.xml
settings/EmailIntegration.settings-meta.xml
settings/Flow.settings-meta.xml
settings/Forecasting.settings-meta.xml
settings/ForecastingObjectList.settings-meta.xml
settings/HighVelocitySales.settings-meta.xml
settings/LightningExperience.settings-meta.xml
settings/MapsAndLocation.settings-meta.xml
settings/MyDomain.settings-meta.xml
settings/Opportunity.settings-meta.xml
settings/Search.settings-meta.xml
settings/Security.settings-meta.xml
settings/Territory2.settings-meta.xml
settings/Trailhead.settings-meta.xml
settings/UserInterface.settings-meta.xml
settings/UserManagement.settings-meta.xml
standardValueSets/Industry.standardValueSet-meta.xml
standardValueSets/OpportunityStage.standardValueSet-meta.xml
standardValueSets/ProcessExceptionCategory.standardValueSet-meta.xml
tabs/Admin_Object_Setup__c.tab-meta.xml
tabs/Admin_Objet_Update_Stage__c.tab-meta.xml
tabs/Opportunit_R_f_rentiel__c.tab-meta.xml
tabs/Publication_Simap_Detail__c.tab-meta.xml
tabs/Publication_Simap__c.tab-meta.xml
tabs/Referentiel__c.tab-meta.xml
tabs/Simap_Adjudications_et_mises_a_jour__c.tab-meta.xml
tabs/Simap_Cantons__c.tab-meta.xml
tabs/Simap_Code_CPV__c.tab-meta.xml
tabs/Simap_Federal_Entities__c.tab-meta.xml
tabs/Simap_Type_de_Contrat__c.tab-meta.xml
tabs/Simap_Type_de_Publication__c.tab-meta.xml
tabs/Simap_Type_de_procedure__c.tab-meta.xml
```
