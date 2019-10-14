Class {
	#name : #DiCommand,
	#superclass : #Object,
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #execution }
DiCommand >> execute [
	"Perform a command action. 
	The command may return a result."
	self subclassResponsibility
]
