"
I am an abstract {{gtClass:DiCollectionToModelBuilder}} part.
I hold the builder in {{gtMethod:DiCollectionToModelBuilderPart>>#builder}} and I offer some common methods to access and build model.

See {{gtClass:DiCollectionToModelBuilderPart|expanded=true|show=gtSubclassesFor:}} for specific builder parts.


"
Class {
	#name : #DiCollectionToModelBuilderPart,
	#superclass : #DiBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #enumerating }
DiCollectionToModelBuilderPart >> collectionNamed: aString [
	<return: #DiMetaCollection or: nil>
	^ self builder collectionNamed: aString
]

{ #category : #accessing }
DiCollectionToModelBuilderPart >> collections [
	<return: #Collection>
	^ self builder collections
]

{ #category : #'building - model' }
DiCollectionToModelBuilderPart >> ensureModelPackageForBehavior: aRGBehavior [
	^ self builder ensureModelPackageForBehavior: aRGBehavior
]

{ #category : #'building - model' }
DiCollectionToModelBuilderPart >> ensurePackageAndTagForBehavior: aRGBehavior [
	^ self builder ensurePackageAndTagForBehavior: aRGBehavior
]

{ #category : #'accessing - model' }
DiCollectionToModelBuilderPart >> existingCollectionBehaviorOrNil: aDiMetaCollection [
	^ self builder existingCollectionBehaviorOrNil: aDiMetaCollection
]

{ #category : #accessing }
DiCollectionToModelBuilderPart >> filters [
	<return: #Collection>
	^ self builder filters
]

{ #category : #accessing }
DiCollectionToModelBuilderPart >> modelBuilder [
	<return: #DiModelBuilder>
	^ self builder
]

{ #category : #'accessing - model' }
DiCollectionToModelBuilderPart >> modelPackage [
	<return: #RGPackageDefinition>
	^ self builder modelPackage
]

{ #category : #'accessing - model' }
DiCollectionToModelBuilderPart >> modelRootClass [
	<return: #RGClass>
	^ self builder modelRootClass
]

{ #category : #'accessing - model' }
DiCollectionToModelBuilderPart >> modelRootClassName [
	<return: #String>
	^ self builder modelRootClassName
]

{ #category : #accessing }
DiCollectionToModelBuilderPart >> naming [
	<return: #DiModelNamingStrategy>
	^ self builder naming
]

{ #category : #'accessing - model' }
DiCollectionToModelBuilderPart >> packageTagName [
	<return: #String>
	^ self builder packageTagName
]
