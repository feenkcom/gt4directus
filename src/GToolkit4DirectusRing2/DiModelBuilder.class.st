"
I am an abstract model builder.
I define common inteface for all model builders.
My concrete subclasses knows how to build a Pharo code in an environment.
My concrete subclasses are used by ${class:DiCollectionToModelBuilder}$.

See my subclasses for specific examples: ${class:DiModelBuilder|show=gtSubclassesFor:|expanded=true}$


"
Class {
	#name : #DiModelBuilder,
	#superclass : #Object,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #'instance creation' }
DiModelBuilder class >> ring2 [ 
	^ DiRing2ModelBuilder new
]

{ #category : #cleaning }
DiModelBuilder >> clean [
	"Clean an existing environment.
	For different builders it might mean different think.
	In general the intention of the method is to analyze the existing model and define what is missing."
]

{ #category : #model }
DiModelBuilder >> ensureAllBehaviorsWithPackageNamed: aString [
	"Ensure that all behaviors with resolved name and superclass have a package. 
	It a behavior does not have a package, set the package named aString.
	Return the package named aString."
	^ self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensureClassAndMetaClassNamed: aString [
	"Ensure a class and its metaclass (class side) of the given name aString.
	Return the class with the given name aString."
	^ self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensureClassComment: aString forBehavior: aBRBehavior [
	"Ensure a class comment aString of the given behavior."
	self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensureClassNamed: aString [
	"Ensure a class of the given name aString.
	Return the existing or newly created class."
	^ self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensureInstanceVariable: aString inBehavior: aRGBehavior [
	"Return collection of existing behavior instance variables"
	<return: #Array of: #String>
	^ self ensureInstanceVariables: { aString } inBehavior: aRGBehavior
]

{ #category : #accessing }
DiModelBuilder >> ensureInstanceVariables: aCollection inBehavior: aRGBehavior [
	"Ensure that the given behavior aRGBehavior has aCollection instance variables.
	Return collection of all existing behavior instance variables"
	<return: #Array of: #String>
	^ self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensureLocalMethodNamed: aMethodName withSourceCode: aSourceCode andProtocol: aProtocolName inBehavior: aRGBehavior [
	"Ensure a local method of the given name, source code, protocol name in the aRGBehavior.
	Return the object representing the method."
	^ self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensureObject [
	"Ensure Object class and its meta class.
	Return the behavior object representing Object."
	^ self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensureObject: aSuperclassRGBehavior asSuperClassFor: aRGBehavior [
	"Ensure that the given aRGBehavior has a superclass. 
	If not, set anObjectRGBehavior as the superclass.
	Set the superclass only if aRGBehavior defined name."
	self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensureObjectAsSuperclass [
	"Ensure that behaviors with resolved name and package have a superclass. 
	If not, set Object as their superclass.
	Return the model represeting Object"
	^ self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensureObjectAsSuperclassForBehavior: aRGBehavior [
	"Ensure that the aRGBehavior has superclass. 
	If not and aRGBehavior has resolved name, set Object as its superclass."
	self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensurePackage: aPackage forBehavior: aRGBehavior [
	"Ensure that aRGBehavior has a package.
	If not and aRGBehavior has resolve named, set the given package."
	self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensurePackageNamed: aString [
	"Ensure a package of the given name aString.
	Return the existing or newly created package."
	^ self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensurePackageTagNamed: aPackageTagName forBehavior: aRGBehavior [
	"Ensure that aRGBehavior has a package tag. 
	If it does not have and aRGBehavior has resolved named and package, set the tag."
	self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensureTraitNamed: aString [
	"Ensure a Trait of the given name aString.
	Return the existing or newly created Trait."
	^ self subclassResponsibility
]

{ #category : #model }
DiModelBuilder >> ensureTraitNamed: aTraitName inBehavior: aRGBehavior [
	"Ensure that aRGBehavior uses a Trait of the given name aTraitName."
	self subclassResponsibility
]
