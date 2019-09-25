Class {
	#name : #DiRing2Examples,
	#superclass : #Object,
	#instVars : [
		'modelExamples'
	],
	#category : #'GToolkit4DirectusRing2-Examples'
}

{ #category : #initialization }
DiRing2Examples >> initialize [
	super initialize.
	modelExamples := DiCompanyModelExamples new.
]

{ #category : #'examples - model names and values' }
DiRing2Examples >> modelPrefix [
	^ 'DiDemo'
]

{ #category : #'examples - model names and values' }
DiRing2Examples >> packageName [
	^ self modelPrefix, 'Package'
]

{ #category : #'examples - building models' }
DiRing2Examples >> ring2BuilderWithCleanedRootModelClassHavingSuperclass [
	<gtExample>
	| aBuilder aClass |
	aBuilder := self ring2BuilderWithRootModelClass.
	aClass := aBuilder ensureClassAndMetaClassNamed: self rootModelClassName.
	aBuilder clean.
	self assert: aClass isRingResolved.
	self assert: aClass superclass isRingResolved.
	self assert: aClass superclass name equals: 'Object'.
	self assert: aClass metaclass isRingResolved.
	^ aBuilder 
]

{ #category : #'examples - building models' }
DiRing2Examples >> ring2BuilderWithCleanedRootModelClassHavingSuperclassAndPackage [
	<gtExample>
	| aBuilder aClass aPackage |
	aBuilder := self ring2BuilderWithCleanedRootModelClassHavingSuperclass.
	aClass := aBuilder ensureClassAndMetaClassNamed: self rootModelClassName.
	aPackage := aBuilder ensureAllBehaviorsWithPackageNamed: self packageName.
	self assert: aPackage name equals: self packageName.
	self assert: aClass package equals: aPackage.
	self assert: aClass metaclass package equals: aPackage.
	self assert: aClass superclass package isRingResolved not.
	self assert: aClass metaclass metaclass package isRingResolved not.
	^ aBuilder
]

{ #category : #'examples - building models' }
DiRing2Examples >> ring2BuilderWithRootModelClass [
	<gtExample>
	| aBuilder aClass |
	aBuilder := self ring2ModelBuilder.
	aClass := aBuilder ensureClassAndMetaClassNamed: self rootModelClassName.
	self assert: aClass name equals: self rootModelClassName.
	self assert: aClass isRingResolved.
	self assert: aClass superclass isRingResolved not.
	self assert: aClass metaclass isRingResolved.
	^ aBuilder 
]

{ #category : #'examples - building models' }
DiRing2Examples >> ring2BuilderWithRootModelClassHavingSuperclass [
	<gtExample>
	| aBuilder aClass |
	aBuilder := self ring2BuilderWithRootModelClass.
	aClass := aBuilder ensureClassAndMetaClassNamed: self rootModelClassName.
	aBuilder ensureObjectAsSuperclass.
	self assert: aClass isRingResolved.
	self assert: aClass superclass isRingResolved.
	self assert: aClass superclass name equals: 'Object'.
	self assert: aClass metaclass isRingResolved.
	^ aBuilder 
]

{ #category : #'examples - building models' }
DiRing2Examples >> ring2ModelBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := DiRing2ModelBuilder new.
	self assert: aBuilder isNotNil.
	^ aBuilder
]

{ #category : #'examples - model names and values' }
DiRing2Examples >> rootModelClassName [
	^ self modelPrefix, 'Model'
]
