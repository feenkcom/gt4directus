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
			baseline: 'NeoJSON' with: [
				spec repository: 'github://svenvc/NeoJSON:master/repository' ];
			package: 'GToolkit4Directus' with: [
				spec requires: #( 'NeoJSON' ) ];
			package: 'GToolkit4DirectusRing2' with: [
				spec requires: #( 'GToolkit4Directus' ) ]
	].

	spec for: 'Ring2' do: [ 
		spec
			baseline: 'Ring2' with: [ 
				spec repository: 'github://pavel-krivanek/Ring2/src' ];
			package: 'GToolkit4DirectusRing2' with: [
				spec requires: #( 'GToolkit4Directus' 'Ring2' ) ]
	].

]

{ #category : #accessing }
BaselineOfGToolkit4Directus >> customProjectAttributes [
	SystemVersion current major = 7 ifTrue: [ ^ #( Ring2 ) ].
	^ super customProjectAttributes 
]
