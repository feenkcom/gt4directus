"
I communicate with [Directus](https://directus.io) using RESTful API.
You can find the API documentation at <https://docs.directus.io>.

I am an abstract class. Subclasses must implement {{gtMethod:DiProtoDirectus>>#email}} and {{gtMethod:DiProtoDirectus>>#password}} methods.

{{gtClass:DiProtoDirectus|show=#gtSubclassesFor:|height=200|expanded=true}} subclasses:


"
Class {
	#name : 'DiProtoDirectus',
	#superclass : 'Object',
	#instVars : [
		'accessToken',
		'projectURL'
	],
	#category : 'GToolkit4Directus-Importer'
}

{ #category : 'accessing' }
DiProtoDirectus >> accessToken [
	<return: #String>
	^ accessToken
]

{ #category : 'accessing' }
DiProtoDirectus >> accessToken: aString [
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Access token must be non-empty string' ].
	^ accessToken := aString
]

{ #category : 'reading' }
DiProtoDirectus >> get: endpoint [
	<return: #Dictionary or: nil>
	
	| aResponse |
	aResponse := self getResponse: endpoint.
	^ aResponse isSuccess
   		ifTrue: [ STONJSON fromString: aResponse contents ]
		ifFalse: [ nil ].
]

{ #category : 'reading' }
DiProtoDirectus >> getCollections [
	<return: #DiMetaCollections>
	<return: #ZnResponse>
	| aResponse |
	aResponse := self getResponse: 'collections'.
	aResponse isSuccess ifFalse: [ ^ aResponse ].
	^ DiMetaModelMapping uniqueInstance readCollections: aResponse contents.
]

{ #category : 'reading' }
DiProtoDirectus >> getCollectionsWithRelations [
	<return: #DiMetaCollectionsWithRelations>
	<return: #ZnResponse>
	| aCollectionOrResponse aRelationOrResponse |
	aCollectionOrResponse := self getCollections.
	aCollectionOrResponse isSuccess ifFalse: [ ^ aCollectionOrResponse ].
	aRelationOrResponse := self getRelations.
	aRelationOrResponse isSuccess ifFalse: [ ^ aRelationOrResponse ].
	^ DiMetaCollectionsWithRelations new
		collections: aCollectionOrResponse;
		relations: aRelationOrResponse;
		buildRelations
]

{ #category : 'reading' }
DiProtoDirectus >> getElementsInCollection: name [
	| aResponse |
	aResponse := self getResponse: {#items. name}.
	^ aResponse contents.

]

{ #category : 'reading' }
DiProtoDirectus >> getElementsInCollection: name withQuery: keyedCollection [
	| aResponse |
	aResponse := self getResponse: {#items. name} withQuery: keyedCollection.
	^ aResponse contents.

]

{ #category : 'reading' }
DiProtoDirectus >> getRelations [
	<return: #DiMetaRelations>
	<return: #ZnResponse>
	| aResponse |
	aResponse := self getResponse: 'relations'.
	aResponse isSuccess ifFalse: [ ^ aResponse ].
	^ DiMetaModelMapping uniqueInstance readRelations: aResponse contents.
]

{ #category : 'reading' }
DiProtoDirectus >> getResponse: endpoint [
	<return: #ZnResponse>
	
	^ ZnClient new
		url: self projectURL;
		addPath: endpoint;
		headerAt: 'Authorization:' put: 'Bearer ', self accessToken asString;
		get;
		response.
]

{ #category : 'reading' }
DiProtoDirectus >> getResponse: endpoint withQuery: keyedCollection [
	<return: #ZnResponse>
	
	^ ZnClient new
		url: projectURL;
		addPath: endpoint;
		queryAddAll: keyedCollection;
		headerAt: 'Authorization:' put: 'Bearer ', accessToken;
		get;
		response.
]

{ #category : 'testing' }
DiProtoDirectus >> isAuthenticated [
	<return: #Boolean>
	^ accessToken isNotNil.
]

{ #category : 'accessing' }
DiProtoDirectus >> projectURL [
	<return: #ZnUrl>
	^ projectURL
]

{ #category : 'accessing' }
DiProtoDirectus >> projectURL: aZnUrl [
	self 
		assert: [ aZnUrl isNotNil ] 
		description: [ 'Project URL must be non-nil' ].
	projectURL := aZnUrl asZnUrl
]

{ #category : 'authentication' }
DiProtoDirectus >> resetToken [
	accessToken := nil
]
