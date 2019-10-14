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
