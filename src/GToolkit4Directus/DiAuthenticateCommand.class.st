Class {
	#name : #DiAuthenticateCommand,
	#superclass : #DiResponseCommand,
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #authentication }
DiAuthenticateCommand >> authenticate [
	^ self subclassResponsibility
]

{ #category : #execution }
DiAuthenticateCommand >> execute [
	self assertReadyForExecution.
	self authenticate.
]
