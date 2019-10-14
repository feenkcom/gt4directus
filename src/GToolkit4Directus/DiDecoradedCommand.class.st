Class {
	#name : #DiDecoradedCommand,
	#superclass : #DiCommand,
	#traits : 'TDiCommandResponse + TDiCommandDirectus',
	#classTraits : 'TDiCommandResponse classTrait + TDiCommandDirectus classTrait',
	#instVars : [
		'command'
	],
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #testing }
DiDecoradedCommand class >> isAbstract [
	^ self name = #DiDecoradedCommand
]

{ #category : #accessing }
DiDecoradedCommand >> command [
	<return: #DiCommand>
	^ command
]

{ #category : #accessing }
DiDecoradedCommand >> command: aDiCommand [
	self
		assert: [ aDiCommand isNotNil ]
		description: [ 'Command must be non-nil' ].
	command := aDiCommand
]

{ #category : #'accessing - response' }
DiDecoradedCommand >> commandResponse [
	<return: #ZnResponse>
	^ self command commandResponse
]

{ #category : #'accessing - directus' }
DiDecoradedCommand >> directus [
	<return: #DiDirectus>
	^ self command directus
]

{ #category : #'accessing - directus' }
DiDecoradedCommand >> directus: aDiProtoDirectus [
	self command directus: aDiProtoDirectus
]

{ #category : #'gt-extension' }
DiDecoradedCommand >> gtDecoratedCommands [
	<return: #Array of: #DiCommand>
	^ Array streamContents: [ :aStream | 
		self putDecoratedCommandInto: aStream ]
]

{ #category : #'gt-extension' }
DiDecoradedCommand >> gtDecoratedCommandsFor: aView [
	<gtView>
	self command ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Commands';
		items: [ self gtDecoratedCommands ]
]

{ #category : #'gt-extension' }
DiDecoradedCommand >> putDecoratedCommandInto: aStream [
	self command ifNil: [ ^ self ].
	aStream nextPut: self command.
	self command putDecoratedCommandInto: aStream.
]
