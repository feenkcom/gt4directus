Class {
	#name : #DiCollectionToModelBuilderPart,
	#superclass : #Object,
	#traits : 'TCollectionIterator + TModelBuilder',
	#classTraits : 'TCollectionIterator classTrait + TModelBuilder classTrait',
	#instVars : [
		'builder'
	],
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #accessing }
DiCollectionToModelBuilderPart >> builder [
	^ builder
]

{ #category : #accessing }
DiCollectionToModelBuilderPart >> builder: anObject [
	builder := anObject
]

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
DiCollectionToModelBuilderPart >> modelBuilder [
	<return: #DiModelBuilder>
	^ self builder
]

{ #category : #accessing }
DiCollectionToModelBuilderPart >> modelEnvironment [
	<return: #RGEnvironment>
	^ self builder modelEnvironment 
]

{ #category : #'accessing - model' }
DiCollectionToModelBuilderPart >> modelRootClass [
	<return: #RGClass>
	^ self builder modelRootClass
]

{ #category : #accessing }
DiCollectionToModelBuilderPart >> naming [
	<return: #DiModelNamingStrategy>
	^ self builder naming
]
