Class {
	#name : #CellPattern,
	#superclass : #Pattern,
	#instVars : [
		'initialPosition'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #creation }
CellPattern class >> at: aPoint [

	| pattern |
	pattern := self new.
	pattern setInitialPoint: aPoint.
	^ pattern.
]

{ #category : #accessing }
CellPattern >> positions [
			
	| x y |
	x := initialPosition x.
	y := initialPosition y.
	^ {  (Point x: x y: y    ).
	  }
]

{ #category : #private }
CellPattern >> setInitialPoint: aPoint [
	
	initialPosition := aPoint 
]
