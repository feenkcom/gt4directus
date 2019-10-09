Extension { #name : #RGBehaviorStrategyUser }

{ #category : #'*GToolkit4DirectusRing2' }
RGBehaviorStrategyUser >> allSubclassesDo: aBlock [ 
	"Evaluate the argument, aBlock, for each of the receiver's subclasses."

	self subclassesDo: 
		[:cl | 
		aBlock value: cl.
		cl allSubclassesDo: aBlock]
]

{ #category : #'*GToolkit4DirectusRing2' }
RGBehaviorStrategyUser >> findGlobalVariable: lookupBlock ifNone: notFoundBlock [ 
	| var |
	var := OCLiteralVariable new.
	var scope: self.
			
	self classPool associationsDo: [ :assoc |
		var assoc: assoc.
		(lookupBlock value: var) ifTrue: [ ^ var ]].
	
	self sharedPools do: [ :pool |
		pool classPool associationsDo: [ :assoc | 
			var assoc: assoc.
			(lookupBlock value: var) ifTrue: [ ^ var ]]].

	self environment associationsDo: [ :assoc |
		var assoc: assoc.
		(lookupBlock value: var) ifTrue: [ ^ var ] ].
	
	^ notFoundBlock value
]

{ #category : #'*GToolkit4DirectusRing2' }
RGBehaviorStrategyUser >> subclassesDo: aBlock [
	"Evaluate the argument, aBlock, for each of the receiver's immediate subclasses."
	self subclasses do: aBlock
]
