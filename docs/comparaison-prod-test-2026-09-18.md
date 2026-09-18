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
