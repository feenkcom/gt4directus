"
I am an abstract strategy used by ${class:DiCollectionToModelBuilder}$. 
My subclasses implement naming strategies, e.g., building a model (class) name from a ${class:DiMetaCollection}$ object.

"
Class {
	#name : #DiModelNamingStrategy,
	#superclass : #DiCollectionToModelBuilderPart,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #accessing }
DiModelNamingStrategy >> accessorName: aDiMetaField [
	^ self fieldName: aDiMetaField
]

{ #category : #accessing }
DiModelNamingStrategy >> accessorProtocolName [ 
	^ 'accessing'
]

{ #category : #accessing }
DiModelNamingStrategy >> cleanupProtocolName [ 
	^ 'cleanup'
]

{ #category : #accessing }
DiModelNamingStrategy >> collectionModelName: aDiMetaCollection [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
DiModelNamingStrategy >> fieldName: aDiMetaField [
	^ self subclassResponsibility
]

{ #category : #accessing }
DiModelNamingStrategy >> initializationProtocolName [
	^ 'initialization'
]

{ #category : #accessing }
DiModelNamingStrategy >> mappingCollectionsProtocolName [
	^ 'mappings - collections'
]

{ #category : #accessing }
DiModelNamingStrategy >> mappingDataProtocolName [
	^ 'mappings - data'
]

{ #category : #accessing }
DiModelNamingStrategy >> mappingModelsProtocolName [
	^ 'mappings - models'
]

{ #category : #accessing }
DiModelNamingStrategy >> modelClassPrefix [
	<return: #String>
	^ self builder modelClassPrefix
]

{ #category : #accessing }
DiModelNamingStrategy >> modelInstanceName: aModelName [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
DiModelNamingStrategy >> printingProtocolName [
	^ 'printing'
]

{ #category : #accessing }
DiModelNamingStrategy >> readingProtocolName [
	^ 'reading'
]

{ #category : #accessing }
DiModelNamingStrategy >> testingProtocolName [
	^ 'testing'
]

{ #category : #accessing }
DiModelNamingStrategy >> writingProtocolName [
	^ 'writing'
]
