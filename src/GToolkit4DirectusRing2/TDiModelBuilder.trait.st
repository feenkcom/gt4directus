Trait {
	#name : #TDiModelBuilder,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #'accessing - model' }
TDiModelBuilder >> behaviorNamed: aString [
	^ self modelBuilder behaviorNamed: aString
]

{ #category : #'building - model' }
TDiModelBuilder >> ensureClassAndMetaClassNamed: aString [ 
	^ self modelBuilder ensureClassAndMetaClassNamed: aString 
]

{ #category : #'building - model' }
TDiModelBuilder >> ensureClassComment: aString forBehavior: aBRBehavior [
	^ self modelBuilder ensureClassComment: aString forBehavior: aBRBehavior
]

{ #category : #'building - model' }
TDiModelBuilder >> ensureInstanceVariable: aString inBehavior: aRGBehavior [
	^ self modelBuilder ensureInstanceVariable: aString inBehavior: aRGBehavior
]

{ #category : #'building - model' }
TDiModelBuilder >> ensureInstanceVariables: aCollection inBehavior: aRGBehavior [
	^ self modelBuilder ensureInstanceVariables: aCollection inBehavior: aRGBehavior
]

{ #category : #'building - model' }
TDiModelBuilder >> ensureLocalMethodNamed: aMethodName withSourceCode: aSourceCode andProtocol: aProtocolName inBehavior: aRGBehavior [
	^ self modelBuilder ensureLocalMethodNamed: aMethodName withSourceCode: aSourceCode andProtocol: aProtocolName inBehavior: aRGBehavior
]

{ #category : #'building - model' }
TDiModelBuilder >> ensureObjectAsSuperclassForBehavior: aRGBehavior [ 
	^ self modelBuilder ensureObjectAsSuperclassForBehavior: aRGBehavior 
]

{ #category : #'building - model' }
TDiModelBuilder >> ensureTraitNamed: aTraitName inBehavior: aRGBehavior [
	^ self modelBuilder ensureTraitNamed: aTraitName inBehavior: aRGBehavior
]

{ #category : #'model builder' }
TDiModelBuilder >> modelBuilder [
	<return: #DiModelBuilder>
	^ self explicitRequirement
]
