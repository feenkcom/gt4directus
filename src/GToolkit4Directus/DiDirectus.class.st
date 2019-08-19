"
I communicate with *Directus>https://directus.io* using RESTful API.
You can find the API documentation at *https://docs.directus.io*.

!! API Examples

- ${method:DiProtoDirectus>>#getCollections}$ - get the ${class:DiMetaCollections}$ meta-model: ${example:DiExamples>>#importCompanyMetaModel|codeExpanded=false|previewExpanded=true}$

- ${method:DiProtoDirectus>>#getRelations}$ - get the ${class:DiMetaRelations}$ meta-model: ${example:DiExamples>>#importCompanyRelations|codeExpanded=false|previewExpanded=true}$

- ${method:DiProtoDirectus>>#getCollectionsWithRelations}$ - get ${class:DiMetaCollectionsWithRelations}$ with computed one-to-many and many-to-one field types: ${example:DiExamples>>#importCompanyCollectionsWithRelations|codeExpanded=false|previewExpanded=true}$

Notice, that the last example includes exact one-to-many and many-to-one data types, while the first example does include only one-to-many and many-to-one information.

"
Class {
	#name : #DiDirectus,
	#superclass : #DiProtoDirectus,
	#instVars : [
		'email',
		'password'
	],
	#category : #'GToolkit4Directus-Importer'
}

{ #category : #accessing }
DiDirectus >> email [
	^ email
]

{ #category : #accessing }
DiDirectus >> email: anObject [
	email := anObject
]

{ #category : #accessing }
DiDirectus >> password [
	^ password
]

{ #category : #accessing }
DiDirectus >> password: anObject [
	password := anObject
]
