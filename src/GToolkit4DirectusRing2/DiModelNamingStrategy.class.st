Class {
	#name : #DiModelNamingStrategy,
	#superclass : #DiCollectionToModelBuilderPart,
	#category : #'GToolkit4DirectusRing2-Model Builders'
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
	^ self subclassResponsibility
]

{ #category : #accessing }
DiModelNamingStrategy >> fieldName: aDiMetaField [
	^ self subclassResponsibility
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
DiModelNamingStrategy >> readingProtocolName [
	^ 'reading'
]

{ #category : #accessing }
DiModelNamingStrategy >> testingProtocolName [
	^ 'testing'
]
