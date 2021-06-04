"
I exemplify meta models, subclasses of {{gtClass:DiMetaModel}}. 
 

"
Class {
	#name : #DiCompanyMetaModelExamples,
	#superclass : #Object,
	#category : #'GToolkit4DirectusRing2-Examples'
}

{ #category : #'examples - meta models' }
DiCompanyMetaModelExamples >> collectionsAndRelationsWithCompany [
	<gtExample>
	| aCollections aField |
	aCollections := self collectionsAndRelationsWithCompany_NotInitialized.
	aCollections buildRelations.
	aField := (aCollections collections data first fieldNamed: 'parent_company').
	self assert: aField type collection isNotNil.
	self assert: aField type relation isNotNil.
	^ aCollections
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> collectionsAndRelationsWithCompany_NotInitialized [
	<gtExample>
	| aCollections aField |
	aCollections := self emptyCollectonsWithRelations.
	aCollections collections: self collectionsWithCompany.
	aCollections relations: self relationsWithParentCompany.
	self assert: aCollections collections isNotNil.
	self assert: aCollections relations isNotNil.
	aField := (aCollections collections data first fieldNamed: 'parent_company').
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	^ aCollections
]

{ #category : #'examples - meta models' }
DiCompanyMetaModelExamples >> collectionsAndRelationsWithCountryAndCompany [
	<gtExample>
	| aCollections aField |
	aCollections := self collectionsAndRelationsWithCountryAndCompany_NotInitialized.
	aCollections buildRelations.
	aField := (aCollections collections data first fieldNamed: 'parent_company').
	self assert: aField type collection isNotNil.
	self assert: aField type relation isNotNil.
	aField := (aCollections collections data first fieldNamed: 'subsidiary_companies').
	self assert: aField type collection isNotNil.
	self assert: aField type relation isNotNil.
	aField := (aCollections collections data first fieldNamed: 'country').
	self assert: aField type collection isNotNil.
	self assert: aField type relation isNotNil.
	aField := (aCollections collections data second fieldNamed: 'companies').
	self assert: aField type collection isNotNil.
	self assert: aField type relation isNotNil.
	^ aCollections
]

{ #category : #'examples - meta models' }
DiCompanyMetaModelExamples >> collectionsAndRelationsWithCountryAndCompanyAndDirectusUser [
	<gtExample>
	| aCollections aField |
	aCollections := self collectionsAndRelationsWithCountryAndCompanyAndDirectusUser_NotInitialized.
	aCollections buildRelations.
	aField := (aCollections collections data first fieldNamed: 'parent_company').
	self assert: aField type collection isNotNil.
	self assert: aField type relation isNotNil.
	aField := (aCollections collections data first fieldNamed: 'subsidiary_companies').
	self assert: aField type collection isNotNil.
	self assert: aField type relation isNotNil.
	aField := (aCollections collections data first fieldNamed: 'country').
	self assert: aField type collection isNotNil.
	self assert: aField type relation isNotNil.
	aField := (aCollections collections data second fieldNamed: 'companies').
	self assert: aField type collection isNotNil.
	self assert: aField type relation isNotNil.
	^ aCollections
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> collectionsAndRelationsWithCountryAndCompanyAndDirectusUser_NotInitialized [
	<gtExample>
	| aCollections aField |
	aCollections := self emptyCollectonsWithRelations.
	aCollections collections: self collectionsWithCountryAndCompanyAndDirectusUser.
	aCollections relations: self relationsWithCountriesAndParentAndSubsidiaryCompanies.
	self assert: aCollections collections isNotNil.
	self assert: aCollections relations isNotNil.
	aField := (aCollections collections data first fieldNamed: 'parent_company').
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	^ aCollections
]

{ #category : #'examples - meta models' }
DiCompanyMetaModelExamples >> collectionsAndRelationsWithCountryAndCompanyAndSystemFields [
	<gtExample>
	| aModel |
	aModel := self collectionsAndRelationsWithCountryAndCompany.
	aModel collectionsDo: [ :eachCollection | 
		| anOriginalFieldSize theSystemFields |
		anOriginalFieldSize := eachCollection numberOfFields.
		theSystemFields := DiMetaField systemFieldNames collect: [ :eachFieldName | 
			DiMetaField new
				name: eachFieldName;
				note: 'System field';
				type: (DiMetaFieldType typeNamed: eachFieldName) ].
		eachCollection fields: (eachCollection fields, theSystemFields).
		self assert: eachCollection numberOfFields equals: anOriginalFieldSize + theSystemFields size.
		theSystemFields do: [ :eachField | self assert: eachField isSystemField ].
	].
	^ aModel
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> collectionsAndRelationsWithCountryAndCompany_NotInitialized [
	<gtExample>
	| aCollections aField |
	aCollections := self emptyCollectonsWithRelations.
	aCollections collections: self collectionsWithCountryAndCompany.
	aCollections relations: self relationsWithCountriesAndParentAndSubsidiaryCompanies.
	self assert: aCollections collections isNotNil.
	self assert: aCollections relations isNotNil.
	aField := (aCollections collections data first fieldNamed: 'parent_company').
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	aField := (aCollections collections data first fieldNamed: 'subsidiary_companies').
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	aField := (aCollections collections data first fieldNamed: 'country').
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	aField := (aCollections collections data second fieldNamed: 'companies').
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	^ aCollections
]

{ #category : #'examples - meta models' }
DiCompanyMetaModelExamples >> collectionsAndRelationsWithSubsidiaryCompaniesField [
	<gtExample>
	| aCollections aField |
	aCollections := self collectionsAndRelationsWithSubsidiaryCompanyField_NotInitialized.
	aCollections buildRelations.
	aField := (aCollections collections data first fieldNamed: 'parent_company').
	self assert: aField type collection isNotNil.
	self assert: aField type relation isNotNil.
	aField := (aCollections collections data first fieldNamed: 'subsidiary_companies').
	self assert: aField type collection isNotNil.
	self assert: aField type relation isNotNil.
	^ aCollections
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> collectionsAndRelationsWithSubsidiaryCompanyField_NotInitialized [
	<gtExample>
	| aCollections aField |
	aCollections := self emptyCollectonsWithRelations.
	aCollections collections: self collectionsWithSubsidiaryCompaniesField.
	aCollections relations: self relationsWithParentAndSubsidiaryCompanies.
	self assert: aCollections collections isNotNil.
	self assert: aCollections relations isNotNil.
	aField := (aCollections collections data first fieldNamed: 'parent_company').
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	aField := (aCollections collections data first fieldNamed: 'subsidiary_companies').
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	^ aCollections
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> collectionsWithCompany [
	<gtExample>
	| aCollections |
	aCollections := self emptyCollections.
	aCollections data: { self companyCollection }.
	self assert: aCollections data size equals: 1.
	^ aCollections
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> collectionsWithCountryAndCompany [
	<gtExample>
	| aCollections |
	aCollections := self emptyCollections.
	aCollections data: { self companyCollectionWithSubsidiaryCompaniesField. self countryCollection }.
	self assert: aCollections data size equals: 2.
	^ aCollections
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> collectionsWithCountryAndCompanyAndDirectusUser [
	<gtExample>
	| aCollections |
	aCollections := self emptyCollections.
	aCollections data: { self companyCollectionWithSubsidiaryCompaniesField. self countryCollection. self directusUserCollection }.
	self assert: aCollections data size equals: 3.
	^ aCollections
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> collectionsWithSubsidiaryCompaniesField [
	<gtExample>
	| aCollections |
	aCollections := self emptyCollections.
	aCollections data: { self companyCollectionWithSubsidiaryCompaniesField }.
	self assert: aCollections data size equals: 1.
	^ aCollections
]

{ #category : #'examples - collection' }
DiCompanyMetaModelExamples >> companyCollection [
	<gtExample>
	| aCollection |
	aCollection := self emptyCollection.
	aCollection name: 'company'.
	aCollection note: 'I represent a legal company'.
	aCollection fields: { self idField. self companyNameField. self parentCompanyField }.
	self assert: aCollection name equals: 'company'.
	self assert: aCollection numberOfFields equals: 3.
	^ aCollection
]

{ #category : #'examples - collection' }
DiCompanyMetaModelExamples >> companyCollectionWithSubsidiaryCompaniesField [
	<gtExample>
	| aCollection |
	aCollection := self emptyCollection.
	aCollection name: 'company'.
	aCollection note: 'I represent a legal company'.
	aCollection fields: { self idField. self companyNameField. self parentCompanyField. self subsidiaryCompaniesField. self countryField }.
	self assert: aCollection name equals: 'company'.
	self assert: aCollection numberOfFields equals: 5.
	^ aCollection
]

{ #category : #'examples - field' }
DiCompanyMetaModelExamples >> companyNameField [
	<gtExample>
	| aField |
	aField := self emptyField.
	aField name: 'name'.
	aField note: 'Name of the company including legal form'.
	aField type: self stringType.
	self assert: aField name equals: 'name'.
	self assert: aField note equals: 'Name of the company including legal form'.
	self assert: aField type class equals: self stringType class.
	^ aField
]

{ #category : #'examples - relation' }
DiCompanyMetaModelExamples >> countryAndCompaniesRelation [
	<gtExample>
	| aRelation |
	aRelation := self emptyRelation.
	aRelation collectionOne: 'country'.
	aRelation fieldOne: 'companies'.
	aRelation collectionMany: 'company'.
	aRelation fieldMany: 'country'.
	self assert: aRelation collectionOne equals: 'country'.
	self assert: aRelation fieldOne equals: 'companies'.
	self assert: aRelation collectionMany equals: 'company'.
	self assert: aRelation fieldMany equals: 'country'.
	^ aRelation
]

{ #category : #'examples - collection' }
DiCompanyMetaModelExamples >> countryCollection [
	<gtExample>
	| aCollection |
	aCollection := self emptyCollection.
	aCollection name: 'country'.
	aCollection fields: { self idField. self countryNameField. self countryCompaniesField. }.
	self assert: aCollection name equals: 'country'.
	self assert: aCollection numberOfFields equals: 3.
	^ aCollection
]

{ #category : #'examples - field' }
DiCompanyMetaModelExamples >> countryCompaniesField [
	<gtExample>
	| aField |
	aField := self emptyField.
	aField name: 'companies'.
	aField note: 'Companies belonging to the country.'.
	aField type: self oneToManyType.
	self assert: aField name equals: 'companies'.
	self assert: aField note equals: 'Companies belonging to the country.'.
	self assert: aField type class equals: self oneToManyType class.
	^ aField
]

{ #category : #'examples - field' }
DiCompanyMetaModelExamples >> countryField [
	<gtExample>
	| aField |
	aField := self emptyField.
	aField name: 'country'.
	aField note: 'Belonging to the country'.
	aField type: self manyToOneType.
	self assert: aField name equals: 'country'.
	self assert: aField note equals: 'Belonging to the country'.
	self assert: aField type class equals: self manyToOneType class.
	^ aField
]

{ #category : #'examples - field' }
DiCompanyMetaModelExamples >> countryNameField [
	<gtExample>
	| aField |
	aField := self emptyField.
	aField name: 'name'.
	aField note: 'Name of the country'.
	aField type: self stringType.
	self assert: aField name equals: 'name'.
	self assert: aField note equals: 'Name of the country'.
	self assert: aField type class equals: self stringType class.
	^ aField
]

{ #category : #'examples - collection' }
DiCompanyMetaModelExamples >> directusUserCollection [
	<gtExample>
	| aCollection |
	aCollection := self emptyCollection.
	aCollection name: 'directus_user'.
	aCollection fields: { self userNameField. self userEmailField. }.
	self assert: aCollection name equals: 'directus_user'.
	self assert: aCollection numberOfFields equals: 2.
	self assert: aCollection isSystemCollection.
	^ aCollection
]

{ #category : #'examples - collection' }
DiCompanyMetaModelExamples >> emptyCollection [
	<gtExample>
	| aCollection |
	aCollection := DiMetaCollection new.
	self assert: aCollection fields isArray.
	self assert: aCollection fields isEmpty.
	^ aCollection
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> emptyCollections [
	<gtExample>
	| aCollections |
	aCollections := DiMetaCollections new.
	self assert: aCollections data size isZero.
	^ aCollections
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> emptyCollectonsWithRelations [
	<gtExample>
	| aMeta |
	aMeta := DiMetaCollectionsWithRelations new.
	self assert: aMeta collections isNil.
	self assert: aMeta relations isNil.
	^ aMeta
]

{ #category : #'examples - field' }
DiCompanyMetaModelExamples >> emptyField [
	<gtExample>
	| aField |
	aField := DiMetaField new.
	self assert: aField name isNil.
	self assert: aField note isNil.
	self assert: aField type isNil.
	^ aField
]

{ #category : #'examples - relation' }
DiCompanyMetaModelExamples >> emptyRelation [
	<gtExample>
	| aRelation |
	aRelation := DiMetaRelation new.
	self assert: aRelation collectionMany isNil.
	self assert: aRelation fieldMany isNil.
	self assert: aRelation collectionOne isNil.
	self assert: aRelation fieldOne isNil.
	self assert: aRelation junctionField isNil.
	^ aRelation
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> emptyRelations [
	<gtExample>
	| aRelations |
	aRelations := DiMetaRelations new.
	self assert: aRelations data size isZero.
	^ aRelations
]

{ #category : #'examples - field' }
DiCompanyMetaModelExamples >> idField [
	<gtExample>
	| aField |
	aField := self emptyField.
	aField name: 'id'.
	aField note: 'Collection ID'.
	aField type: self integerType.
	self assert: aField name equals: 'id'.
	self assert: aField note equals: 'Collection ID'.
	self assert: aField type class equals: self integerType class.
	^ aField
]

{ #category : #'examples - type' }
DiCompanyMetaModelExamples >> integerType [
	<gtExample>
	^ DiMetaFieldTypeInteger new.
	
]

{ #category : #'examples - type' }
DiCompanyMetaModelExamples >> manyToOneType [
	<gtExample>
	| aType |
	aType := DiMetaFieldTypeManyToOne new.
	self assert: aType collection isNil.
	self assert: aType relation isNil.
	^ aType
]

{ #category : #'examples - type' }
DiCompanyMetaModelExamples >> oneToManyType [
	<gtExample>
	| aType |
	aType := DiMetaFieldTypeOneToMany new.
	self assert: aType collection isNil.
	self assert: aType relation isNil.
	^ aType
]

{ #category : #'examples - relation' }
DiCompanyMetaModelExamples >> parentAndSubsidiaryCompaniesRelation [
	<gtExample>
	| aRelation |
	aRelation := self parentCompanyRelation.
	aRelation fieldOne: 'subsidiary_companies'.
	self assert: aRelation fieldOne equals: 'subsidiary_companies'.
	^ aRelation
]

{ #category : #'examples - field' }
DiCompanyMetaModelExamples >> parentCompanyField [
	<gtExample>
	| aField |
	aField := self emptyField.
	aField name: 'parent_company'.
	aField note: 'Company who owns this company'.
	aField type: self manyToOneType.
	self assert: aField name equals: 'parent_company'.
	self assert: aField note equals: 'Company who owns this company'.
	self assert: aField type class equals: self manyToOneType class.
	^ aField
]

{ #category : #'examples - relation' }
DiCompanyMetaModelExamples >> parentCompanyRelation [
	<gtExample>
	| aRelation |
	aRelation := self emptyRelation.
	aRelation collectionMany: 'company'.
	aRelation fieldMany: 'parent_company'.
	aRelation collectionOne: 'company'.
	self assert: aRelation collectionMany equals: 'company'.
	self assert: aRelation fieldMany equals: 'parent_company'.
	self assert: aRelation collectionOne equals: 'company'.
	^ aRelation
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> relationsWithCountriesAndParentAndSubsidiaryCompanies [
	<gtExample>
	| aRelations |
	aRelations := self emptyRelations.
	aRelations data: { self parentAndSubsidiaryCompaniesRelation. self countryAndCompaniesRelation }.
	self assert: aRelations data size equals: 2.
	^ aRelations
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> relationsWithParentAndSubsidiaryCompanies [
	<gtExample>
	| aRelations |
	aRelations := self emptyRelations.
	aRelations data: { self parentAndSubsidiaryCompaniesRelation }.
	self assert: aRelations data size equals: 1.
	^ aRelations
]

{ #category : #'examples - collections and relations' }
DiCompanyMetaModelExamples >> relationsWithParentCompany [
	<gtExample>
	| aRelations |
	aRelations := self emptyRelations.
	aRelations data: { self parentCompanyRelation }.
	self assert: aRelations data size equals: 1.
	^ aRelations
]

{ #category : #'examples - type' }
DiCompanyMetaModelExamples >> stringType [
	<gtExample>
	^ DiMetaFieldTypeString new.
	
]

{ #category : #'examples - field' }
DiCompanyMetaModelExamples >> subsidiaryCompaniesField [
	<gtExample>
	| aField |
	aField := self emptyField.
	aField name: 'subsidiary_companies'.
	aField note: 'Companies that are owned by this company.'.
	aField type: self oneToManyType.
	self assert: aField name equals: 'subsidiary_companies'.
	self assert: aField note equals: 'Companies that are owned by this company.'.
	self assert: aField type class equals: self oneToManyType class.
	^ aField
]

{ #category : #'examples - field' }
DiCompanyMetaModelExamples >> userEmailField [
	<gtExample>
	| aField |
	aField := self emptyField.
	aField name: 'email'.
	aField note: 'Email of the Directus user'.
	aField type: self stringType.
	self assert: aField name equals: 'email'.
	self assert: aField note equals: 'Email of the Directus user'.
	self assert: aField type class equals: self stringType class.
	^ aField
]

{ #category : #'examples - field' }
DiCompanyMetaModelExamples >> userNameField [
	<gtExample>
	| aField |
	aField := self emptyField.
	aField name: 'name'.
	aField note: 'Name of the Directus user'.
	aField type: self stringType.
	self assert: aField name equals: 'name'.
	self assert: aField note equals: 'Name of the Directus user'.
	self assert: aField type class equals: self stringType class.
	^ aField
]
