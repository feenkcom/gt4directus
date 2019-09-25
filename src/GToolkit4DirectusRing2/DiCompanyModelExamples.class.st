Class {
	#name : #DiCompanyModelExamples,
	#superclass : #Object,
	#category : #'GToolkit4DirectusRing2-Examples'
}

{ #category : #'examples - collections and relations' }
DiCompanyModelExamples >> collectionsWithCompany [
	<gtExample>
	| aCollections |
	aCollections := self emptyCollections.
	aCollections data: { self companyCollection }.
	self assert: aCollections data size equals: 1.
	^ aCollections
]

{ #category : #'examples - collections and relations' }
DiCompanyModelExamples >> collectonsAndRelationsWithCompany [
	<gtExample>
	| aCollections |
	aCollections := self emptyCollectonsWithRelations.
	aCollections collections: self collectionsWithCompany.
	aCollections relations: self relationsWithParentCompany.
	self assert: aCollections collections isNotNil.
	self assert: aCollections relations isNotNil.
	^ aCollections
]

{ #category : #'examples - collection' }
DiCompanyModelExamples >> companyCollection [
	<gtExample>
	| aCollection |
	aCollection := self emptyCollection.
	aCollection name: 'company'.
	aCollection fields: { self idField. self nameField. self parentCompanyField }.
	self assert: aCollection name equals: 'company'.
	self assert: aCollection numberOfFields equals: 3.
	^ aCollection
]

{ #category : #'examples - collection' }
DiCompanyModelExamples >> emptyCollection [
	<gtExample>
	| aCollection |
	aCollection := DiMetaCollection new.
	self assert: aCollection fields isArray.
	self assert: aCollection fields isEmpty.
	^ aCollection
]

{ #category : #'examples - collections and relations' }
DiCompanyModelExamples >> emptyCollections [
	<gtExample>
	| aCollections |
	aCollections := DiMetaCollections new.
	self assert: aCollections data size isZero.
	^ aCollections
]

{ #category : #'examples - collections and relations' }
DiCompanyModelExamples >> emptyCollectonsWithRelations [
	<gtExample>
	| aMeta |
	aMeta := DiMetaCollectionsWithRelations new.
	self assert: aMeta collections isNil.
	self assert: aMeta relations isNil.
	^ aMeta
]

{ #category : #'examples - field' }
DiCompanyModelExamples >> emptyField [
	<gtExample>
	| aField |
	aField := DiMetaField new.
	self assert: aField name isNil.
	self assert: aField note isNil.
	self assert: aField type isNil.
	^ aField
]

{ #category : #'examples - relation' }
DiCompanyModelExamples >> emptyRelation [
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
DiCompanyModelExamples >> emptyRelations [
	<gtExample>
	| aRelations |
	aRelations := DiMetaRelations new.
	self assert: aRelations data size isZero.
	^ aRelations
]

{ #category : #'examples - field' }
DiCompanyModelExamples >> idField [
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
DiCompanyModelExamples >> integerType [
	<gtExample>
	^ DiMetaFieldTypeInteger new.
	
]

{ #category : #'examples - type' }
DiCompanyModelExamples >> manyToOneType [
	<gtExample>
	| aType |
	aType := DiMetaFieldTypeManyToOne new.
	self assert: aType collection isNil.
	self assert: aType relation isNil.
	^ aType
]

{ #category : #'examples - field' }
DiCompanyModelExamples >> nameField [
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

{ #category : #'examples - field' }
DiCompanyModelExamples >> parentCompanyField [
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
DiCompanyModelExamples >> parentCompanyRelation [
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
DiCompanyModelExamples >> relationsWithParentCompany [
	<gtExample>
	| aRelations |
	aRelations := self emptyRelations.
	aRelations data: { self parentCompanyRelation }.
	self assert: aRelations data size equals: 1.
	^ aRelations
]

{ #category : #'examples - type' }
DiCompanyModelExamples >> stringType [
	<gtExample>
	^ DiMetaFieldTypeString new.
	
]
