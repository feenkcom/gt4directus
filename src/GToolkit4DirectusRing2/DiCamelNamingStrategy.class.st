Class {
	#name : #DiCamelNamingStrategy,
	#superclass : #DiModelNamingStrategy,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #accessing }
DiCamelNamingStrategy >> collectionBasicModelName: aDiMetaCollection [
	"A model (class) name without a possible prefix"
	<return: #String>
	^ aDiMetaCollection modelClassName
]

{ #category : #accessing }
DiCamelNamingStrategy >> collectionModelName: aDiMetaCollection [ 
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: self modelClassPrefix;
			nextPutAll: (self collectionBasicModelName: aDiMetaCollection)
		]
]

{ #category : #accessing }
DiCamelNamingStrategy >> fieldName: aDiMetaField [ 
	^ aDiMetaField getter
]
