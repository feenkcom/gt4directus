Trait {
	#name : #TDiCommandDirectus,
	#category : 'GToolkit4Directus-Commands'
}

{ #category : #'accessing - directus' }
TDiCommandDirectus >> directus [
	<return: #DiDirectus>
	^ self explicitRequirement
]

{ #category : #'testing - directus' }
TDiCommandDirectus >> isDirectusAuthenticated [
	<return: #Boolean>
	^ self directus isAuthenticated
]

{ #category : #'accessing - directus' }
TDiCommandDirectus >> projectURL [
	<return: #ZnUrl>
	^ self directus projectURL
]
