Class {
	#name : #LastRowPattern,
	#superclass : #Pattern,
	#instVars : [
		'initialPosition',
		'positions'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #creation }
LastRowPattern class >> at: aPoint [

	| pattern |
	pattern := self new.
	pattern setInitialPoint: aPoint.
	^ pattern.
]

{ #category : #creation }
LastRowPattern class >> at: aPoint with: anArrayOfPositions [

	| pattern |
	pattern := self new.
	pattern setInitialPoint: aPoint.
	pattern setPositions: anArrayOfPositions.
	^ pattern.
]

{ #category : #accessing }
LastRowPattern >> positions [
			
	| x points |
	
	points := Bag new.
	x := initialPosition y.
	
	1 to: positions size do: [ :w |
		(positions at: w) isAlive
			ifTrue: [ points add: (Point x: w y: x) ].
		 ].
	
	^ points.
]

{ #category : #private }
LastRowPattern >> setInitialPoint: aPoint [
	
	initialPosition := aPoint 
]

{ #category : #private }
LastRowPattern >> setPositions: anArrayOfPositions [

	positions := anArrayOfPositions.
]
