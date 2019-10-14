Class {
	#name : #DiCommonImporterExamples,
	#superclass : #Object,
	#instVars : [
		'delegate',
		'zincExamples'
	],
	#category : #'GToolkit4Directus-Examples'
}

{ #category : #importer }
DiCommonImporterExamples >> basicImporter [
	<gtExample>
	| anImporter |
	anImporter := DiDirectus new.
	self assert: anImporter projectURL isNil.
	self assert: anImporter email isNil.
	self assert: anImporter password isNil.
	self assert: anImporter isAuthenticated not.
	^ anImporter
]

{ #category : #server }
DiCommonImporterExamples >> delegate [
	<gtExample>
	delegate ifNotNil: [ :aDelegate | ^ aDelegate ].
	delegate := ZnDispatcherDelegate new.
	self initializeDelegate.
	^ delegate
]

{ #category : #server }
DiCommonImporterExamples >> email [
	^ 'my@email.com'
]

{ #category : #importer }
DiCommonImporterExamples >> importer [
	<gtExample>
	| anImporter |
	anImporter := self importer_NotAuthenticated.
	anImporter authenticate.
	self assert: anImporter isAuthenticated.
	^ anImporter
]

{ #category : #importer }
DiCommonImporterExamples >> importer_NotAuthenticated [
	<gtExample>
	| anUrl anImporter |
	anUrl := self serverUrl.
	anImporter := self basicImporter.
	anImporter projectURL: anUrl.
	anImporter email: self email.
	anImporter password: self password.
	self assert: anImporter projectURL equals: anUrl.
	self assert: anImporter isAuthenticated not.
	^ anImporter
]

{ #category : #initialization }
DiCommonImporterExamples >> initialize [
	super initialize.
	zincExamples := GtZnServerExamples new.
]

{ #category : #server }
DiCommonImporterExamples >> initializeDelegate [
	delegate
		map: '/auth/authenticate'
		to: [ :aRequest :aResponse | aResponse entity: (ZnEntity json: '{"data":{"token":"my-token"}}') ]
]

{ #category : #'reading - meta model' }
DiCommonImporterExamples >> mapping [
	<gtExample>
	| aMapping |
	aMapping := DiMetaModelMapping uniqueInstance.
	self assert: aMapping isNotNil.
	^ aMapping
]

{ #category : #'company - json data' }
DiCommonImporterExamples >> metaFieldOfCompanyNameJsonString [
	^ '{"note":"Name of the company including legal form","type":"string","field":"name"}'
]

{ #category : #'company - json data' }
DiCommonImporterExamples >> metaFieldOfIdJsonString [
	^ '{"note":"Collection ID","type":"integer","field":"id"}'
]

{ #category : #'company - json data' }
DiCommonImporterExamples >> metaFieldOfParentCompanyJsonString [
	^ '{"note":"Company who owns this company","type":"m2o","field":"parent_company"}'
]

{ #category : #server }
DiCommonImporterExamples >> password [
	^ 'my-password'
]

{ #category : #server }
DiCommonImporterExamples >> serverUrl [
	<gtExample>
	self startServer.
	^ zincExamples serverUrl
]

{ #category : #server }
DiCommonImporterExamples >> startServer [
	<gtExample>
	<after: #stopServer>
	| aServer |
	aServer := zincExamples server.
	self assert: aServer isListening.
	aServer delegate = self delegate ifFalse: [ 
		aServer delegate: self delegate ].
	self assert: aServer delegate equals: self delegate.
	^ aServer
]

{ #category : #server }
DiCommonImporterExamples >> stopServer [
	^ zincExamples stopServer
]
