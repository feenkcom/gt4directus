Class {
	#name : #DiMetaFieldTypeManyToOne,
	#superclass : #DiMetaFieldType,
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldTypeManyToOne class >> matchesName: aString [
	<return: #Boolean>
	^ aString = 'M2O' or: [ aString = 'm2o' ]
]

{ #category : #accessing }
DiMetaFieldTypeManyToOne >> name [
	<return: #String>
	^ 'M2O'
]
