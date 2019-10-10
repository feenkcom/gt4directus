Class {
	#name : #DiNullModelBuilder,
	#superclass : #DiModelBuilder,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #cleanup }
DiNullModelBuilder class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
DiNullModelBuilder class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
DiNullModelBuilder class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #model }
DiNullModelBuilder >> ensureAllBehaviorsWithPackageNamed: aString [
	"Ensure that all behaviors with resolved name and superclass have a package. 
	It a behavior does not have a package, set the package named aString.
	Return the package named aString."
	^ self shouldNotImplement
]

{ #category : #model }
DiNullModelBuilder >> ensureClassAndMetaClassNamed: aString [
	"Ensure a class and its metaclass (class side) of the given name aString.
	Return the class with the given name aString."
	^ self shouldNotImplement
]

{ #category : #model }
DiNullModelBuilder >> ensureClassComment: aString forBehavior: aBRBehavior [
	"Ensure a class comment aString of the given behavior."
	self shouldNotImplement
]

{ #category : #model }
DiNullModelBuilder >> ensureClassNamed: aString [
	"Ensure a class of the given name aString.
	Return the existing or newly created class."
	^ self shouldNotImplement
]

{ #category : #accessing }
DiNullModelBuilder >> ensureInstanceVariables: aCollection inBehavior: aRGBehavior [
	"Ensure that the given behavior aRGBehavior has aCollection instance variables.
	Return collection of all existing behavior instance variables"
	<return: #Array of: #String>
	^ self shouldNotImplement
]

{ #category : #model }
DiNullModelBuilder >> ensureLocalMethodNamed: aMethodName withSourceCode: aSourceCode andProtocol: aProtocolName inBehavior: aRGBehavior [
	"Ensure a local method of the given name, source code, protocol name in the aRGBehavior.
	Return the object representing the method."
	^ self shouldNotImplement
]

{ #category : #model }
DiNullModelBuilder >> ensureObject [
	"Ensure Object class and its meta class.
	Return the behavior object representing Object."
	^ self shouldNotImplement
]

{ #category : #model }
DiNullModelBuilder >> ensureObject: aSuperclassRGBehavior asSuperClassFor: aRGBehavior [
	"Ensure that the given aRGBehavior has a superclass. 
	If not, set anObjectRGBehavior as the superclass.
	Set the superclass only if aRGBehavior defined name."
	self shouldNotImplement
]

{ #category : #model }
DiNullModelBuilder >> ensureObjectAsSuperclass [
	"Ensure that behaviors with resolved name and package have a superclass. 
	If not, set Object as their superclass.
	Return the model represeting Object"
	^ self shouldNotImplement
]
