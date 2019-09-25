Extension { #name : #RGObject }

{ #category : #'*GToolkit4DirectusRing2' }
RGObject >> gtPropertiesFor: aView [
	<gtView>
	self hasProperties ifFalse: [ ^ aView empty ].
	^ (self properties gtItemsFor: aView)
		title: 'Properties';
		priority: 40
]
