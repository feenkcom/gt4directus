Class {
	#name : #DiModelBuilder,
	#superclass : #Object,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #'instance creation' }
DiModelBuilder class >> ring2 [ 
	^ DiRing2ModelBuilder new
]

{ #category : #accessing }
DiModelBuilder >> modelEnvironment [
	<return: #RGEnvironment>
	^ self subclassResponsibility
]
