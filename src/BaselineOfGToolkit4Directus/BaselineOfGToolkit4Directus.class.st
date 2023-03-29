Class {
	#name : #BaselineOfGToolkit4Directus,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4Directus
}

{ #category : #baselines }
BaselineOfGToolkit4Directus >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec 
			package: 'GToolkit4Directus';
			package: 'GToolkit4DirectusRing2' with: [
				spec requires: #( 'GToolkit4Directus' ) ] 
	]

]
