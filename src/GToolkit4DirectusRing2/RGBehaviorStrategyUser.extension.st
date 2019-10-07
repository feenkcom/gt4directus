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
RGBehaviorStrategyUser >> subclassesDo: aBlock [
	"Evaluate the argument, aBlock, for each of the receiver's immediate subclasses."
	self subclasses do: aBlock
]
