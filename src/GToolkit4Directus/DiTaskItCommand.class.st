Class {
	#name : 'DiTaskItCommand',
	#superclass : 'DiDecoradedCommand',
	#instVars : [
		'onSuccess',
		'onFailure'
	],
	#category : 'GToolkit4Directus-Commands'
}

{ #category : 'execution' }
DiTaskItCommand >> execute [
	"Perform a command action. 
	The command may return a result."

	| aFuture |
	self assertReadyForExecution.
	aFuture := BlTktWorkerProvider highUICPUBoundPool
		future: [ self command execute ].
	self initializeFutureCallbacksFor: aFuture
]

{ #category : 'initialization' }
DiTaskItCommand >> initialize [
	super initialize.
	onFailure := OrderedCollection new: 2.
	onSuccess := OrderedCollection new: 2.
]

{ #category : 'initialization' }
DiTaskItCommand >> initializeFutureCallbacksFor: aFuture [
	self onSuccess
		do: [ :eachCallback | aFuture onSuccessDo: eachCallback ].
	self onSuccess
		do: [ :eachCallback | aFuture onFailureDo: eachCallback ]
]

{ #category : 'accessing' }
DiTaskItCommand >> onFailure [
	^ onFailure
]

{ #category : 'callbacks' }
DiTaskItCommand >> onFailureDo: aCallback [
	onFailure add: aCallback
]

{ #category : 'accessing' }
DiTaskItCommand >> onSuccess [
	^ onSuccess
]

{ #category : 'callbacks' }
DiTaskItCommand >> onSuccessDo: aCallback [
	onSuccess add: aCallback
]
