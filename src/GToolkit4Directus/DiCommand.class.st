Class {
	#name : #DiCommand,
	#superclass : #Object,
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #accessing }
DiCommand >> deepCommand: aDiCommand parent: aDiParentCommand [
	"Put the command at the bottom"
	self 
		assert: [ aDiParentCommand command isNil ]
		description: [ 'Parent command must have uninitialized sub-command' ].
	aDiParentCommand command: aDiCommand.
]

{ #category : #execution }
DiCommand >> execute [
	"Perform a command action. 
	The command may return a result."
	self subclassResponsibility
]

{ #category : #'gt-extension' }
DiCommand >> putDecoratedCommandInto: aStream [
	"do nothing"
]
