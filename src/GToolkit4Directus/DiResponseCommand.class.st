Class {
	#name : #DiResponseCommand,
	#superclass : #DiCommand,
	#traits : 'TDiCommandResponse + TDiCommandDirectus',
	#classTraits : 'TDiCommandResponse classTrait + TDiCommandDirectus classTrait',
	#instVars : [
		'directus',
		'response'
	],
	#category : 'GToolkit4Directus-Commands'
}

{ #category : #accessing }
DiResponseCommand class >> endPoint [
	<return: #Array of: #Symbol>
	^ self subclassResponsibility
]

{ #category : #testing }
DiResponseCommand class >> isAbstract [
	^ self name = #DiResponseCommand 
]

{ #category : #asserting }
DiResponseCommand >> assertReadyForExecution [
	"Subclasses may assert if a command is ready for execution."
	super assertReadyForExecution.
	self 
		assert: [ self directus isNotNil ]
		description: [ 'Directus must be non-nil' ]
]

{ #category : #'accessing - directus' }
DiResponseCommand >> clientWithEndPoint [
	^ ZnClient new
		url: self projectURL;
		addPath: self endPoint
]

{ #category : #'accessing - response' }
DiResponseCommand >> commandResponse [
	<return: #ZnResponse>
	^ self response
]

{ #category : #accessing }
DiResponseCommand >> directus [
	<return: #DiProtoDirectus>
	^ directus
]

{ #category : #accessing }
DiResponseCommand >> directus: aDiProtoDirectus [
	self
		assert: [ aDiProtoDirectus isNotNil ] 
		description: [ 'Directus must be non-nil' ].
	directus := aDiProtoDirectus
]

{ #category : #accessing }
DiResponseCommand >> endPoint [
	"Return a end point URL path used for the communication with the Directus server."
	<return: #Array>
	^ self class endPoint
]

{ #category : #'reading - directus' }
DiResponseCommand >> getResponse [
	<return: #ZnResponse>
	^ self getResponse: self endPoint
]

{ #category : #'reading - directus' }
DiResponseCommand >> getResponse: anEndPoint [
	<return: #ZnResponse>
	^ self directus getResponse: anEndPoint
]

{ #category : #'gt-extension' }
DiResponseCommand >> gtJsonFor: aView [
	<gtView>
	self response ifNil: [ ^ aView empty ].
	^ (self response gtJsonFor: aView)
		actionButtonLabel: 'Details' action: [ :aBrTab | 
			aBrTab phlow spawnObject: self response ]
]

{ #category : #'gt-extension' }
DiResponseCommand >> gtResponseFor: aView [
	<gtView>
	self response ifNil: [ ^ aView empty ].
	^ (self response gtResponseFor: aView)
		actionButtonLabel: 'Details' action: [ :aBrTab | 
			aBrTab phlow spawnObject: self response ]
]

{ #category : #'writing - directus' }
DiResponseCommand >> patchEntity: anEntity at: anEndPoint [
	^ self directus patchEntity: anEntity at: anEndPoint
]

{ #category : #'writing - directus' }
DiResponseCommand >> patchJson: aJsonString at: anEndPoint [
	^ self directus patchJson: aJsonString at: anEndPoint
]

{ #category : #'writing - directus' }
DiResponseCommand >> postEntity: anEntity at: anEndPoint [
	^ self directus postEntity: anEntity at: anEndPoint
]

{ #category : #'writing - directus' }
DiResponseCommand >> postJson: aJsonString at: anEndPoint [
	^ self directus postJson: aJsonString at: anEndPoint
]

{ #category : #accessing }
DiResponseCommand >> response [
	<return: #ZnResponse>
	^ response
]

{ #category : #accessing }
DiResponseCommand >> response: aZnResponse [
	self
		assert: [ aZnResponse isNotNil ]
		description: [ 'Response must be non-nil' ].
	response := aZnResponse
]
