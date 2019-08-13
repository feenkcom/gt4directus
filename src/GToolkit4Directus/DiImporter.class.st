"
I communicate with *Directus>https://directus.io* using RESTful API.
You can find the API documentation at *https://docs.directus.io*.

"
Class {
	#name : #DiImporter,
	#superclass : #Object,
	#instVars : [
		'accessToken',
		'projectURL'
	],
	#category : #'GToolkit4Directus-Importer'
}

{ #category : #authentication }
DiImporter >> authenticate [
	self authenticateWithEmail: self email password: self password
]

{ #category : #authentication }
DiImporter >> authenticateWithEmail: anEmail password: aPassword [
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
DiImporter >> email [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #importing }
DiImporter >> get: endpoint [
	<return: #Dictionary or: nil>
	
	| aResponse |
	aResponse := self getResponse: endpoint.
	^ aResponse isSuccess
   		ifTrue: [ STONJSON fromString: aResponse contents ]
		ifFalse: [ nil ].
]

{ #category : #importing }
DiImporter >> getCollections [
	<return: #DiMetaCollections>
	<return: #ZnResponse>
	| aResponse |
	aResponse := self getResponse: 'collections'.
	aResponse isSuccess ifFalse: [ ^ aResponse ].
	^ DiMetaModelMapping uniqueInstance readMetaDescriptions: aResponse contents.
]

{ #category : #importing }
DiImporter >> getElementsInCollection: name [
	| aResponse |
	aResponse := self getResponse: {#items. name}.
	^ aResponse contents.

]

{ #category : #importing }
DiImporter >> getRelations [
	<return: #DiMetaRelations>
	<return: #ZnResponse>
	| aResponse |
	aResponse := self getResponse: 'relations'.
	aResponse isSuccess ifFalse: [ ^ aResponse ].
	^ DiMetaModelMapping uniqueInstance readRelations: aResponse contents.
]

{ #category : #importing }
DiImporter >> getResponse: endpoint [
	<return: #ZnResponse>
	
	^ ZnClient new
		url: projectURL;
		addPath: endpoint;
		headerAt: 'Authorization:' put: 'Bearer ', accessToken;
		get;
		response.
]

{ #category : #accessing }
DiImporter >> password [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
DiImporter >> projectURL [
	<return: #ZnUrl>
	^ projectURL
]

{ #category : #accessing }
DiImporter >> projectURL: aZnUrl [
	projectURL := aZnUrl asZnUrl
]

{ #category : #authentication }
DiImporter >> resetToken [
	accessToken := nil
]
