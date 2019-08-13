"
I hold a collection of ${class:DiMetaField}$. 
I am used by ${class:DiMetaCollection}$.

An example with two ${class:DiMetaField}$ objects: ${example:DiExamples>>#metaFieldsOfNameAndDescription|noCode=true}$


"
Class {
	#name : #DiMetaFields,
	#superclass : #DiMetaModel,
	#instVars : [
		'fields'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #enumerating }
DiMetaFields >> collectFieldsRelatedToCollection: aDiMetaCollection [
	<return: #Array of: #DiMetaField>
	^ self fields select: [ :eachField | 
		eachField isRelatedToCollection: aDiMetaCollection ]
]

{ #category : #enumerating }
DiMetaFields >> fieldNamed: aString [
	<return: #DiMetaField>
	^ self fields detect: [ :eachField | eachField name = aString ]
]

{ #category : #accessing }
DiMetaFields >> fields [
	^ fields
]

{ #category : #accessing }
DiMetaFields >> fields: anObject [
	fields := anObject
]

{ #category : #'gt-extension' }
DiMetaFields >> gtFieldsFor: aView [
	<gtView>
	self fields ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Fields';
		items: [ self fields ];
		column: 'Name' item: [ :aField | aField name ];
		column: 'Type' item: [ :aField | aField type ifNotNil: #name ]
]

{ #category : #testing }
DiMetaFields >> includesFieldOfType: aType [
	<return: #Boolean>
	^ self fields anySatisfy: [ :eachField | eachField type = aType ]
]

{ #category : #initialization }
DiMetaFields >> initialize [
	super initialize.
	fields := #().
]

{ #category : #convenience }
DiMetaFields >> numberOfFields [
	<return: #Integer>
	^ self fields size
]
