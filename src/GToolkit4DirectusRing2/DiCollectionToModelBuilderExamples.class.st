Class {
	#name : #DiCollectionToModelBuilderExamples,
	#superclass : #Object,
	#instVars : [
		'metaModelExamples'
	],
	#category : #'GToolkit4DirectusRing2-Examples'
}

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> basicCollectionToModelBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := DiCollectionToModelBuilder new.
	self assert: aBuilder modelBuilder isNotNil.
	self assert: aBuilder modelBuilder class equals: DiRing2ModelBuilder.
	self assert: aBuilder packageName isString.
	self assert: aBuilder modelClassPrefix isString.
	^ aBuilder
]

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> buildModel [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithMetaModel.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass isNotNil.
	self assert: aModelClass isClass.
	self assert: aModelClass package name equals: self dummyPackageName.
	"self assert: aModelClass selectors size equals: 9."
	^ aBuilder
]

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> buildModelWithAllInstanceAndAccessorsVariables [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithMetaModel.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 3.
	self assert: aModelClass localMethods size equals: 6.
	^ aBuilder
]

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> buildModelWithAllInstanceVariables [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithMetaModel.
	aBuilder useInstanceVariableBuilder.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 3.
	^ aBuilder
]

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> collectionToModelBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self basicCollectionToModelBuilder.
	aBuilder packageName: self dummyPackageName.
	aBuilder modelClassPrefix: self dummyModelClassPrefix.
	self assert: aBuilder packageName equals: self dummyPackageName.
	self assert: aBuilder modelClassPrefix equals: self dummyModelClassPrefix.
	^ aBuilder
]

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> collectionToModelBuilderWithMetaModel [
	<gtExample>
	| aBuilder |
	aBuilder := self collectionToModelBuilder.
	aBuilder metaModel: self metaModel.
	self assert: aBuilder metaModel isNotNil.
	^ aBuilder
]

{ #category : #'examples - common names' }
DiCollectionToModelBuilderExamples >> dummyModelClassPrefix [
	^ 'DiDummy'
]

{ #category : #'examples - common names' }
DiCollectionToModelBuilderExamples >> dummyPackageName [
	^ 'Dummy-Package-For' , self class package name
]

{ #category : #initialization }
DiCollectionToModelBuilderExamples >> initialize [
	super initialize.
	metaModelExamples := DiCompanyMetaModelExamples new.
]

{ #category : #'examples - meta model' }
DiCollectionToModelBuilderExamples >> metaModel [
	<gtExample>
	| aModel |
	aModel := metaModelExamples metaModel.
	self assert: aModel isNotNil.
	^ aModel
]
