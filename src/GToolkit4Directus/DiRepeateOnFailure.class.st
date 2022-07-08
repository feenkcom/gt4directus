Class {
	#name : #DiRepeateOnFailure,
	#superclass : #DiDecoradedCommand,
	#instVars : [
		'authenticateCommand'
	],
	#category : 'GToolkit4Directus-Commands'
}

{ #category : #asserting }
DiRepeateOnFailure >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self authenticateCommand isNotNil ] 
		description: [ 'Authentication command must be non-nil' ].
]

{ #category : #authentication }
DiRepeateOnFailure >> authenticate [
	self authenticateCommand execute
]

{ #category : #accessing }
DiRepeateOnFailure >> authenticateCommand [
	<return: #DiAuthenticateCommand>
	^ authenticateCommand
]

{ #category : #accessing }
DiRepeateOnFailure >> authenticateCommand: aDiAuthenticateCommand [
	self 
		assert: [ aDiAuthenticateCommand isNotNil ] 
		description: [ 'Authenticate command must be non-nil' ].
	authenticateCommand := aDiAuthenticateCommand
]

{ #category : #accessing }
DiRepeateOnFailure >> deepCommand: aDiCommand [
	"Put the command at the bottom"
	self deepCommand: aDiCommand parent: self.
]

{ #category : #accessing }
DiRepeateOnFailure >> deepCommand: aDiCommand parent: aDiParentCommand [
	"Put the command at the bottom"
	self command 
		ifNotNil: [ self command deepCommand: aDiCommand parent: self ]
		ifNil: [ self command: aDiCommand ].
]

{ #category : #execution }
DiRepeateOnFailure >> execute [
	self assertReadyForExecution.
	self isDirectusAuthenticated ifFalse: [ self authenticate ].
	self isDirectusAuthenticated ifFalse: [ ^ self ].
	self command execute.
	self command isForbiddenResponse ifFalse: [ ^ self ].
	self authenticate.
	self isDirectusAuthenticated ifFalse: [ ^ self ].
	self command execute. 
]
