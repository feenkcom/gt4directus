"
I communicate with [Directus](https://directus.io) using RESTful API.
You can find the API documentation at <https://docs.directus.io>.

## API Examples

- {{gtMethod:DiProtoDirectus>>#getCollections}} - get the {{gtClass:DiMetaCollections}} meta-model: {{gtExample:DiExamples>>#importCompanyMetaModel|codeExpanded=false|previewExpanded=true}}

- {{gtMethod:DiProtoDirectus>>#getRelations}} - get the {{gtClass:DiMetaRelations}} meta-model: {{gtExample:DiExamples>>#importCompanyRelations|codeExpanded=false|previewExpanded=true}}

- {{gtMethod:DiProtoDirectus>>#getCollectionsWithRelations}} - get {{gtClass:DiMetaCollectionsWithRelations}} with computed one-to-many and many-to-one field types: {{gtExample:DiExamples>>#importCompanyCollectionsWithRelations|codeExpanded=false|previewExpanded=true}}

Notice, that the last example includes exact one-to-many and many-to-one data types, while the first example does include only one-to-many and many-to-one information.


"
Class {
	#name : 'DiDirectus',
	#superclass : 'DiMonoliteDirectus',
	#instVars : [
		'email',
		'password'
	],
	#category : 'GToolkit4Directus-Importer'
}

{ #category : 'accessing' }
DiDirectus >> email [
	^ email
]

{ #category : 'accessing' }
DiDirectus >> email: anObject [
	email := anObject
]

{ #category : 'accessing' }
DiDirectus >> password [
	^ password
]

{ #category : 'accessing' }
DiDirectus >> password: anObject [
	password := anObject
]
