Class {
	#name : #DiRing2ModelBuilderExamples,
	#superclass : #Object,
	#category : #'GToolkit4DirectusRing2-Examples'
}

{ #category : #'examples - model names and values' }
DiRing2ModelBuilderExamples >> modelPrefix [
	^ 'DiDemo'
]

{ #category : #'examples - model names and values' }
DiRing2ModelBuilderExamples >> packageName [
	^ self modelPrefix, 'Package'
]

{ #category : #'examples - building models' }
DiRing2ModelBuilderExamples >> ring2BuilderWithCleanedRootModelClassHavingSuperclass [
	<gtExample>
	| aBuilder aClass |
	aBuilder := self ring2BuilderWithRootModelClass.
	aClass := aBuilder ensureClassAndMetaClassNamed: self rootModelClassName.
	aBuilder clean.
	self assert: aClass isRingResolved.
	self assert: aClass superclass isRingResolved.
	self assert: aClass superclass name equals: 'Object'.
	self assert: aClass metaclass isRingResolved.
	self assert: aClass metaclass name equals: self rootModelClassName, ' class'.
	self assert: aClass instanceSide equals: aClass.
	self assert: aClass classSide equals: aClass metaclass.
	^ aBuilder 
]

{ #category : #'examples - building models' }
DiRing2ModelBuilderExamples >> ring2BuilderWithRootModelClass [
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
DiRing2ModelBuilderExamples >> ring2BuilderWithRootModelClassHavingSuperclass [
	<gtExample>
	| aBuilder aClass anObject |
	aBuilder := self ring2BuilderWithRootModelClass.
	aClass := aBuilder ensureClassAndMetaClassNamed: self rootModelClassName.
	anObject := aBuilder ensureObjectAsSuperclass.
	self assert: aClass isRingResolved.
	self assert: aClass superclass isRingResolved.
	self assert: aClass superclass name equals: 'Object'.
	self assert: aClass superclass equals: anObject.
	self assert: aClass metaclass isRingResolved.
	self assert: aClass metaclass superclass isRingResolved.
	self assert: aClass metaclass superclass name equals: 'Object class'.
	self assert: aClass metaclass superclass equals: anObject metaclass.
	aBuilder instanceSideBehaviorsDo: [ :eachBehavior | 
		eachBehavior isRingResolved
			ifFalse: [ 
				self assert: eachBehavior superclass isRingResolved not.
				self assert: eachBehavior metaclass superclass isRingResolved not ]
	].
	^ aBuilder 
]

{ #category : #'examples - building models' }
DiRing2ModelBuilderExamples >> ring2BuilderWithRootModelClassHavingSuperclassAndPackage [
	<gtExample>
	| aBuilder aClass aPackage |
	aBuilder := self ring2BuilderWithRootModelClassHavingSuperclass.
	aClass := aBuilder ensureClassAndMetaClassNamed: self rootModelClassName.
	aPackage := aBuilder ensureAllBehaviorsWithPackageNamed: self packageName.
	self assert: aPackage name equals: self packageName.
	self assert: aClass package equals: aPackage.
	self assert: aClass metaclass package equals: aPackage.
	self assert: aClass superclass package isRingResolved not.
	self assert: aClass metaclass metaclass package isRingResolved not.
	aBuilder instanceSideBehaviorsDo: [ :eachBehavior | 
		(eachBehavior isRingResolved not or: [ eachBehavior superclass isRingResolved not ])
			ifTrue: [ self assert: eachBehavior package isRingResolved not ]
	].
	^ aBuilder
]

{ #category : #'examples - building models' }
DiRing2ModelBuilderExamples >> ring2ModelBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := DiRing2ModelBuilder new.
	self assert: aBuilder isNotNil.
	^ aBuilder
]

{ #category : #'examples - model names and values' }
DiRing2ModelBuilderExamples >> rootModelClassName [
	^ self modelPrefix, 'Model'
]
