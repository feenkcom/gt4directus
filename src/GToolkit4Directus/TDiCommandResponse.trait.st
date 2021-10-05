Trait {
	#name : 'TDiCommandResponse',
	#category : 'GToolkit4Directus-Commands'
}

{ #category : 'accessing - response' }
TDiCommandResponse >> commandResponse [
	<return: #ZnResponse>
	^ self explicitRequirement
]

{ #category : 'testing - response' }
TDiCommandResponse >> isForbiddenResponse [
	<return: #Boolean>
	^ self commandResponse code = 403
]

{ #category : 'testing - response' }
TDiCommandResponse >> isNoContentResponse [
	<return: #Boolean>
	^ self commandResponse isNoContent
]

{ #category : 'testing - response' }
TDiCommandResponse >> isSuccessResponse [
	<return: #Boolean>
	^ self commandResponse isSuccess
]

{ #category : 'accessing - response' }
TDiCommandResponse >> responseContents [
	^ self commandResponse contents
]
