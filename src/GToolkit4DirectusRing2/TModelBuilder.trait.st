Trait {
	#name : #TModelBuilder,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #'accessing - model' }
TModelBuilder >> behaviorNamed: aString [
	^ self modelBuilder behaviorNamed: aString
]

{ #category : #'building - model' }
TModelBuilder >> ensureClassAndMetaClassNamed: aString [ 
	^ self modelBuilder ensureClassAndMetaClassNamed: aString 
]

{ #category : #'building - model' }
TModelBuilder >> ensureClassComment: aString forBehavior: aBRBehavior [
	^ self modelBuilder ensureClassComment: aString forBehavior: aBRBehavior
]

{ #category : #'building - model' }
TModelBuilder >> ensureInstanceVariable: aString inBehavior: aRGBehavior [
	^ self modelBuilder ensureInstanceVariable: aString inBehavior: aRGBehavior
]

{ #category : #'building - model' }
TModelBuilder >> ensureInstanceVariables: aCollection inBehavior: aRGBehavior [
	^ self modelBuilder ensureInstanceVariables: aCollection inBehavior: aRGBehavior
]

{ #category : #'building - model' }
TModelBuilder >> ensureLocalMethodNamed: aMethodName withSourceCode: aSourceCode andProtocol: aProtocolName inBehavior: aRGBehavior [
	^ self modelBuilder ensureLocalMethodNamed: aMethodName withSourceCode: aSourceCode andProtocol: aProtocolName inBehavior: aRGBehavior
]

{ #category : #'building - model' }
TModelBuilder >> ensureObjectAsSuperclassForBehavior: aRGBehavior [ 
	^ self modelBuilder ensureObjectAsSuperclassForBehavior: aRGBehavior 
]

{ #category : #'building - model' }
TModelBuilder >> ensureTraitNamed: aTraitName inBehavior: aRGBehavior [
	^ self modelBuilder ensureTraitNamed: aTraitName inBehavior: aRGBehavior
]

{ #category : #'model builder' }
TModelBuilder >> modelBuilder [
	<return: #DiModelBuilder>
	^ self explicitRequirement
]
