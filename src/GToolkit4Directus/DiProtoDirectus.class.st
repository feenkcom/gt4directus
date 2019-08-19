"
I communicate with *Directus>https://directus.io* using RESTful API.
You can find the API documentation at *https://docs.directus.io*.

I am an abstract class. Subclasses must implement ${method:DiProtoDirectus>>#email}$ and ${method:DiProtoDirectus>>#password}$ methods.

${class:DiProtoDirectus|show=#gtSubclassesFor:|height=200|expanded=true}$ subclasses:


"
Class {
	#name : #DiProtoDirectus,
	#superclass : #Object,
	#instVars : [
		'accessToken',
		'projectURL'
	],
	#category : #'GToolkit4Directus-Importer'
}

{ #category : #authentication }
DiProtoDirectus >> authenticate [
	self authenticateWithEmail: self email password: self password
]

{ #category : #authentication }
DiProtoDirectus >> authenticateWithEmail: anEmail password: aPassword [
	| aClient aResponse |
	accessToken ifNil: [ 
		| aContent aJsonContent |
		aContent := Dictionary new
			at: 'email' put: anEmail;
			at: 'password' put: aPassword;
			yourself.
		aJsonContent := STONJSON toString: aContent.
		aClient := ZnClient new
			url: projectURL;
			addPath: #(auth authenticate);
    		entity: (ZnEntity 
        		with: aJsonContent
        		type: ZnMimeType applicationJson);
			post;
			response.
		
		aClient isSuccess
   			ifTrue: [ 
				aResponse := STONJSON fromString: aClient contents.
				accessToken := (aResponse at: 'data') at: 'token'.
		].
	].
]

{ #category : #accessing }
DiProtoDirectus >> email [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #reading }
DiProtoDirectus >> get: endpoint [
	<return: #Dictionary or: nil>
	
	| aResponse |
	aResponse := self getResponse: endpoint.
	^ aResponse isSuccess
   		ifTrue: [ STONJSON fromString: aResponse contents ]
		ifFalse: [ nil ].
]

{ #category : #reading }
DiProtoDirectus >> getCollections [
	<return: #DiMetaCollections>
	<return: #ZnResponse>
	| aResponse |
	aResponse := self getResponse: 'collections'.
	aResponse isSuccess ifFalse: [ ^ aResponse ].
	^ DiMetaModelMapping uniqueInstance readCollections: aResponse contents.
]

{ #category : #reading }
DiProtoDirectus >> getCollectionsWithRelations [
	<return: #DiMetaCollections>
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

{ #category : #reading }
DiProtoDirectus >> getElementsInCollection: name [
	| aResponse |
	aResponse := self getResponse: {#items. name}.
	^ aResponse contents.

]

{ #category : #reading }
DiProtoDirectus >> getElementsInCollection: name withQuery: keyedCollection [
	| aResponse |
	aResponse := self getResponse: {#items. name} withQuery: keyedCollection.
	^ aResponse contents.

]

{ #category : #reading }
DiProtoDirectus >> getElementsInCollection: name withStatus: status [
	| aResponse |
	aResponse := self getResponse: {#items. name}.
	^ aResponse contents.

]

{ #category : #reading }
DiProtoDirectus >> getRelations [
	<return: #DiMetaRelations>
	<return: #ZnResponse>
	| aResponse |
	aResponse := self getResponse: 'relations'.
	aResponse isSuccess ifFalse: [ ^ aResponse ].
	^ DiMetaModelMapping uniqueInstance readRelations: aResponse contents.
]

{ #category : #reading }
DiProtoDirectus >> getResponse: endpoint [
	<return: #ZnResponse>
	
	^ ZnClient new
		url: projectURL;
		addPath: endpoint;
		headerAt: 'Authorization:' put: 'Bearer ', accessToken;
		get;
		response.
]

{ #category : #reading }
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

{ #category : #accessing }
DiProtoDirectus >> password [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
DiProtoDirectus >> projectURL [
	<return: #ZnUrl>
	^ projectURL
]

{ #category : #accessing }
DiProtoDirectus >> projectURL: aZnUrl [
	projectURL := aZnUrl asZnUrl
]

{ #category : #authentication }
DiProtoDirectus >> resetToken [
	accessToken := nil
]