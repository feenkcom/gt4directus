Extension { #name : #SystemDictionary }

{ #category : #'*GToolkit4DirectusRing2' }
SystemDictionary >> gtBehaviorNamed: aString ifAbsent: aBlockClosure [ 
	<return: #Behavior>
	^ self at: aString ifAbsent: aBlockClosure
]
