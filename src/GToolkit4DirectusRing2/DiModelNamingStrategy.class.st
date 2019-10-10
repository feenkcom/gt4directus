"
I am an abstract strategy used by ${class:DiCollectionToModelBuilder}$. 
My subclasses implement naming strategies, e.g., building a model (class) name from a ${class:DiMetaCollection}$ object.

"
Class {
	#name : #DiModelNamingStrategy,
	#superclass : #DiCollectionToModelBuilderPart,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #'accessing - method names' }
DiModelNamingStrategy >> accessorName: aDiMetaField [
	<return: #String>
	^ self fieldName: aDiMetaField
]

{ #category : #'accessing - protocol names' }
DiModelNamingStrategy >> accessorProtocolName [ 
	^ 'accessing'
]

{ #category : #'accessing - protocol names' }
DiModelNamingStrategy >> cleanupProtocolName [ 
	^ 'cleanup'
]

{ #category : #'accessing - model names' }
DiModelNamingStrategy >> collectionModelName: aDiMetaCollection [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #'accessing - protocol names' }
DiModelNamingStrategy >> convertingProtocolName [
	^ 'converting'
]

{ #category : #'accessing - variable names' }
DiModelNamingStrategy >> fieldName: aDiMetaField [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #'accessing - protocol names' }
DiModelNamingStrategy >> initializationProtocolName [
	^ 'initialization'
]

{ #category : #'accessing - protocol names' }
DiModelNamingStrategy >> mappingCollectionsProtocolName [
	^ 'mappings - collections'
]

{ #category : #'accessing - protocol names' }
DiModelNamingStrategy >> mappingDataProtocolName [
	^ 'mappings - data'
]

{ #category : #'accessing - protocol names' }
DiModelNamingStrategy >> mappingModelsProtocolName [
	^ 'mappings - models'
]

{ #category : #'accessing - model names' }
DiModelNamingStrategy >> modelClassPrefix [
	<return: #String>
	^ self builder modelClassPrefix
]

{ #category : #'accessing - variable names' }
DiModelNamingStrategy >> modelInstanceName: aModelName [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #'accessing - protocol names' }
DiModelNamingStrategy >> printingProtocolName [
	^ 'printing'
]

{ #category : #'accessing - protocol names' }
DiModelNamingStrategy >> readingProtocolName [
	^ 'reading'
]

{ #category : #'accessing - method names' }
DiModelNamingStrategy >> setterName: aDiMetaField [
	<return: #String>
	^ (self accessorName: aDiMetaField), ':'
]

{ #category : #'accessing - protocol names' }
DiModelNamingStrategy >> testingProtocolName [
	^ 'testing'
]

{ #category : #'accessing - protocol names' }
DiModelNamingStrategy >> writingProtocolName [
	^ 'writing'
]
