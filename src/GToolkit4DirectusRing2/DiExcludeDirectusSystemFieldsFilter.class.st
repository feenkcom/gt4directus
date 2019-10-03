Class {
	#name : #DiExcludeDirectusSystemFieldsFilter,
	#superclass : #DiCollectionToModelBuilderFilter,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #filtering }
DiExcludeDirectusSystemFieldsFilter >> canIncludeCollection: aDiMetaCollection [
	<return: #Boolean>
	^ true.
]

{ #category : #filtering }
DiExcludeDirectusSystemFieldsFilter >> canIncludeCollection: aDiMetaCollection field: aDiMetaField [
	<return: #Boolean>
	^ (self systemFieldNames includes: aDiMetaField name) not
]

{ #category : #accessing }
DiExcludeDirectusSystemFieldsFilter >> systemFieldNames [
	^ #( 'created_by' 'created_on' 'modified_by' 'modified_on' 'updated_on' 'updated_by' )
]
