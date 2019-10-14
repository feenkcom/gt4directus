Class {
	#name : #DiRepeateOnFailure,
	#superclass : #DiDecoradedCommand,
	#instVars : [
		'authenticateCommand'
	],
	#category : #'GToolkit4Directus-Commands'
}

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

{ #category : #execution }
DiRepeateOnFailure >> execute [
	"Perform a command action. 
	The command may return a result."
	self isDirectusAuthenticated ifFalse: [ self authenticate ].
	self command execute.
	self command isForbiddenResponse ifTrue: [ self authenticate ].
	self command execute. 
]
