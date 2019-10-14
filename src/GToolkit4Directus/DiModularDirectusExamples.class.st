Class {
	#name : #DiModularDirectusExamples,
	#superclass : #Object,
	#traits : 'TGtZnServerExamples',
	#classTraits : 'TGtZnServerExamples classTrait',
	#instVars : [
		'zincExamples',
		'delegate'
	],
	#category : #'GToolkit4Directus-Examples'
}

{ #category : #'example - commands' }
DiModularDirectusExamples >> authenticateUsingEmailAndPassword [
	<gtExample>
	| aDirectus aCommand |
	aDirectus := self localDirectus.
	aCommand := DiAuthenticateByEmailAndPasswordCommand new.
	aCommand email: self email.
	aCommand password: self password.
	aCommand directus: aDirectus.
	aCommand execute.
	self assert: aCommand response isNotNil.
	self assert: aCommand response isSuccess.
	self assert: aDirectus accessToken isNotNil.
	self assert: aDirectus accessToken equals: 'my-token'.
	^ aCommand
]

{ #category : #'example - directus' }
DiModularDirectusExamples >> basicDirectus [
	<gtExample>
	| aDirectus |
	aDirectus := DiModularDirectus new.
	self assert: aDirectus accessToken isNil.
	self assert: aDirectus projectURL isNil.
	^ aDirectus
]

{ #category : #accessing }
DiModularDirectusExamples >> email [
	^ 'my@email.com'
]

{ #category : #initialization }
DiModularDirectusExamples >> initialize [
	super initialize.
	zincExamples := GtZnServerExamples new.
]

{ #category : #initialization }
DiModularDirectusExamples >> initializeDelegate [
	delegate
		map: '/auth/authenticate'
		to: [ :aRequest :aResponse | aResponse entity: (ZnEntity json: '{"data":{"token":"my-token"}}') ]
]

{ #category : #'example - directus' }
DiModularDirectusExamples >> localDirectus [
	<gtExample>
	| aDirectus |
	aDirectus := self basicDirectus.
	aDirectus projectURL: self serverUrl.
	self assert: aDirectus accessToken isNil.
	self assert: aDirectus projectURL equals: self serverUrl.
	^ aDirectus
]

{ #category : #accessing }
DiModularDirectusExamples >> password [
	^ 'my-password'
]

{ #category : #server }
DiModularDirectusExamples >> zincDelegate [
	"Return a locally stored server delegate (not by accessing a ZnServer)"
	<return: #ZnDispatcherDelegate>
	^ delegate
]

{ #category : #server }
DiModularDirectusExamples >> zincDelegate: aZnDispatcherDelegate [
	"Store the server delegate locally to an instance variable"
	delegate := aZnDispatcherDelegate
]

{ #category : #server }
DiModularDirectusExamples >> zincExamples [
	<return: #GtZnServerExamples>
	^ zincExamples
]
