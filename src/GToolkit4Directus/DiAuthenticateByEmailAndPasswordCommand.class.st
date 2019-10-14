Class {
	#name : #DiAuthenticateByEmailAndPasswordCommand,
	#superclass : #DiAuthenticateCommand,
	#instVars : [
		'email',
		'password'
	],
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #accessing }
DiAuthenticateByEmailAndPasswordCommand class >> endPoint [
	^ #(auth authenticate)
]

{ #category : #'accessing - directus' }
DiAuthenticateByEmailAndPasswordCommand >> accessToken: aString [
	self directus accessToken: aString
]

{ #category : #asserting }
DiAuthenticateByEmailAndPasswordCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self email isString and: [ self email isNotEmpty ] ] 
		description: [ 'Email must be a non-empty string' ].
	self 
		assert: [ self password isString and: [ self password isNotEmpty ] ] 
		description: [ 'Password must be a non-empty string' ].

]

{ #category : #authentication }
DiAuthenticateByEmailAndPasswordCommand >> authenticate [
	self authenticateWithEmail: self email password: self password
]

{ #category : #authentication }
DiAuthenticateByEmailAndPasswordCommand >> authenticateWithEmail: anEmail password: aPassword [
	| aJsonObject aJsonContent |
	aJsonContent := self
		jsonContentWithEmail: anEmail
		password: aPassword.
	self response: (self clientWithEndPoint
		entity: (ZnEntity json: aJsonContent);
		post;
		response).
	self directus resetToken.
	self response isSuccess ifFalse: [ ^ self ].
	aJsonObject := NeoJSONObject fromString: self responseContents.
	self accessToken: (aJsonObject atPath: #('data' 'token')).
]

{ #category : #accessing }
DiAuthenticateByEmailAndPasswordCommand >> email [
	<return: #String>
	^ email
]

{ #category : #accessing }
DiAuthenticateByEmailAndPasswordCommand >> email: aString [
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Email must be a non-empty string' ].
	email := aString
]

{ #category : #authentication }
DiAuthenticateByEmailAndPasswordCommand >> jsonContentWithEmail: anEmail password: aPassword [
	<return: #String>
	| aContent |
	aContent := Dictionary new
		at: 'email' put: anEmail;
		at: 'password' put: aPassword;
		yourself.
	^ STONJSON toString: aContent
]

{ #category : #accessing }
DiAuthenticateByEmailAndPasswordCommand >> password [
	<return: #String>
	^ password
]

{ #category : #accessing }
DiAuthenticateByEmailAndPasswordCommand >> password: aString [
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Password must be a non-empty string' ].
	password := aString
]
