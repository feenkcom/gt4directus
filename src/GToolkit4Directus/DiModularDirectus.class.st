Class {
	#name : #DiModularDirectus,
	#superclass : #DiProtoDirectus,
	#instVars : [
		'options'
	],
	#category : #'GToolkit4Directus-Importer'
}

{ #category : #authentication }
DiModularDirectus >> authenticate [
	| aCommand |
	aCommand := self authenticateCommand.
	self 
		assert: [ aCommand isNotNil ]
		description: [ 'Authentication method must be initialized first' ].
	aCommand execute
]

{ #category : #authentication }
DiModularDirectus >> authenticateCommand [
	<return: #DiAuthenticateCommand>
	^ self optionsAt: #authenticate
]

{ #category : #authentication }
DiModularDirectus >> authenticateWith: aDiAuthenticateCommand [
	self optionsAt: #authenticate put: aDiAuthenticateCommand.
	aDiAuthenticateCommand execute
]

{ #category : #authentication }
DiModularDirectus >> authenticateWithEmail: anEmail password: aPassword [
	| aCommand |
	aCommand := DiAuthenticateByEmailAndPasswordCommand new
		directus: self;
		email: anEmail;
		password: aPassword.
	self authenticateWith: aCommand.
]

{ #category : #executing }
DiModularDirectus >> executeCommand: aDiResponseCommand [
	<return: #DiCommand>
	| aWrapperCommand |
	aWrapperCommand := self wrapperCommand.
	^ aWrapperCommand 
		ifNil: [ aDiResponseCommand execute ] 
		ifNotNil: [ (aWrapperCommand copy deepCommand: aDiResponseCommand) execute ]
]

{ #category : #reading }
DiModularDirectus >> getCollection: aCollectionName itemId: anItemId [
	| aCommand |
	aCommand := DiGetItemCommand new
		directus: self;
		collectionName: aCollectionName;
		itemId: anItemId.
	self executeCommand: aCommand.
	^ aCommand
]

{ #category : #reading }
DiModularDirectus >> getCollection: aCollectionName itemIds: aCollectionOfIds [
	| aCommand |
	aCommand := DiGetItemsCommand new
		directus: self;
		collectionName: aCollectionName;
		itemIds: aCollectionOfIds.
	self executeCommand: aCommand.
	^ aCommand
]

{ #category : #reading }
DiModularDirectus >> getModel: aModelClass itemId: anItemId [
	"Return a model object"
	| aCommand |
	aCommand := DiGetModelItemCommand new
		directus: self;
		modelClass: aModelClass;
		itemId: anItemId.
	self executeCommand: aCommand.
	^ aCommand model
]

{ #category : #reading }
DiModularDirectus >> getModel: aModelClass itemIds: aCollectionOfIds [
	"Return a model object"
	| aCommand |
	aCommand := DiGetModelItemsCommand new
		directus: self;
		modelClass: aModelClass;
		itemIds: aCollectionOfIds.
	self executeCommand: aCommand.
	^ aCommand model
]

{ #category : #options }
DiModularDirectus >> options [
	^ options ifNil: [ options := Dictionary new ]
]

{ #category : #options }
DiModularDirectus >> optionsAt: aKey [
	^ self optionsAt: aKey ifPresent: [ :aValue | aValue ] ifAbsent: [ nil ]
]

{ #category : #options }
DiModularDirectus >> optionsAt: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self options at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : #options }
DiModularDirectus >> optionsAt: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [
	^ self options at: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock
]

{ #category : #options }
DiModularDirectus >> optionsAt: aKey put: aValue [
	^ self options at: aKey put: aValue
]

{ #category : #writing }
DiModularDirectus >> patchEntity: aZnEntity at: anEndPoint [
	<return: #ZnResponse>
	
	self 
		assert: [ aZnEntity isNotNil ] 
		description: [ 'Entity must be non-nil' ].
	self 
		assert: [ anEndPoint isCollection and: [ anEndPoint isNotEmpty ] ] 
		description: [ 'End point must be a non-empty collection' ].
	
	^ ZnClient new
		url: self projectURL;
		addPath: anEndPoint;
		headerAt: 'Authorization:' put: 'Bearer ', accessToken;
		entity: aZnEntity;
		patch;
		response.
]

{ #category : #writing }
DiModularDirectus >> patchJson: aJsonString at: anEndPoint [
	<return: #ZnResponse>
	| anEntity |
	self 
		assert: [ aJsonString isString and: [ aJsonString isNotEmpty ] ] 
		description: [ 'JSON content must be a non-empty string' ].
	anEntity := ZnEntity json: aJsonString.
	^ self patchEntity: anEntity at: anEndPoint.
]

{ #category : #writing }
DiModularDirectus >> postCollection: aCollectionName jsonContent: aJsonItem [
	^ DiStoreNewItemsCommand new
		directus: self;
		collectionName: aCollectionName;
		jsonContent: aJsonItem;
		execute
]

{ #category : #writing }
DiModularDirectus >> postEntity: aZnEntity at: anEndPoint [
	<return: #ZnResponse>
	
	self 
		assert: [ aZnEntity isNotNil ] 
		description: [ 'Entity must be non-nil' ].
	self 
		assert: [ anEndPoint isCollection and: [ anEndPoint isNotEmpty ] ] 
		description: [ 'End point must be a non-empty collection' ].
	
	ZnConnectionTimeout 
		value: 2 * 60 
		during: [
			^ ZnClient new
				url: self projectURL;
				addPath: anEndPoint;
				headerAt: 'Authorization:' put: 'Bearer ', accessToken;
				entity: aZnEntity;
				post;
				response ].
]

{ #category : #writing }
DiModularDirectus >> postJson: aJsonString at: anEndPoint [
	<return: #ZnResponse>
	| anEntity |
	self 
		assert: [ aJsonString isString and: [ aJsonString isNotEmpty ] ] 
		description: [ 'JSON content must be a non-empty string' ].
	anEntity := ZnEntity json: aJsonString.
	^ self postEntity: anEntity at: anEndPoint.
]

{ #category : #writing }
DiModularDirectus >> postModel: aModel [
	^ DiStoreNewModelItemCommand new
		directus: self;
		model: aModel;
		execute
]

{ #category : #writing }
DiModularDirectus >> postModels: aCollectionOfModels [
	^ DiBatchModelItemsCommands new
		beStoreNewItems;
		directus: self;
		models: aCollectionOfModels;
		execute
]

{ #category : #printing }
DiModularDirectus >> printOn: aStream [
	self projectURL ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Directus at: ';
		print: self projectURL.
	self isAuthenticated ifTrue: [ 
		aStream nextPutAll: ' (authenticated)' ].
]

{ #category : #executing }
DiModularDirectus >> reauthenticateOnForbiddenResponse [
	| aWrapperCommand aCommand |
	self 
		assert: [ self authenticateCommand isNotNil ]
		description: [ 'Authenticate command must be defined' ].
	aWrapperCommand := self wrapperCommand.
	aCommand := DiRepeateOnFailure new.
	aCommand authenticateCommand: self authenticateCommand.
	aWrapperCommand ifNotNil: [ aCommand command: aWrapperCommand ].
	self wrapperCommand: aCommand.
]

{ #category : #writing }
DiModularDirectus >> updateCollection: aCollectionName itemId: anItemId jsonContent: aJsonItem [
	^ DiUpdateItemCommand new
		directus: self;
		collectionName: aCollectionName;
		jsonContent: aJsonItem;
		itemId: anItemId;
		execute
]

{ #category : #writing }
DiModularDirectus >> updateModel: aModel [
	^ DiUpdateModelItemCommand new
		directus: self;
		model: aModel;
		execute
]

{ #category : #writing }
DiModularDirectus >> updateModels: aCollectionOfModels [
	^ DiBatchModelItemsCommands new
		beUpdateExistingItems;
		directus: self;
		models: aCollectionOfModels;
		execute
]

{ #category : #writing }
DiModularDirectus >> updateModels: aCollectionOfModels consideringSlots: aCollectionOfSlotNames [
	^ DiBatchModelItemsCommands new
		beUpdateSomeSlots: aCollectionOfSlotNames;
		directus: self;
		models: aCollectionOfModels;
		execute
]

{ #category : #executing }
DiModularDirectus >> wrapperCommand [
	<return: #DiDecoratedCommand>
	^ self optionsAt: #wrapperCommand
]

{ #category : #executing }
DiModularDirectus >> wrapperCommand: aDiDecoratedCommand [
	^ self optionsAt: #wrapperCommand put: aDiDecoratedCommand
]
