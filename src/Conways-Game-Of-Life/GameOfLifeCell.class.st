Class {
	#name : #GameOfLifeCell,
	#superclass : #Object,
	#instVars : [
		'isAlive',
		'neighbours',
		'aliveNeighbours',
		'color',
		'window',
		'point'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #initialization }
GameOfLifeCell class >> at: aPoint [
	
	|cell|
	
	cell := super new.
	cell point: aPoint.
	cell kill.
	cell aliveNeighbours: 0.
	^cell.
]

{ #category : #initialization }
GameOfLifeCell class >> at: aPoint window: aWindow [
	
	|cell|
	
	cell := super new.
	cell point: aPoint.
	cell window: aWindow .
	cell kill.
	cell aliveNeighbours: 0.
	^cell.
]

{ #category : #initialization }
GameOfLifeCell class >> new [
	
	|cell|
	
	cell := super new.
	cell kill.
	cell aliveNeighbours: 0.
	^cell.
]

{ #category : #public }
GameOfLifeCell >> aliveNeighbours: aLiveNeighbours [

	aliveNeighbours := aLiveNeighbours
]

{ #category : #public }
GameOfLifeCell >> awake [

	color := 	Color white.
	isAlive := true.
	window updateCell: point color: color.
	^ self
]

{ #category : #public }
GameOfLifeCell >> color [

	^color
]

{ #category : #public }
GameOfLifeCell >> isAlive [

	^ isAlive 
]

{ #category : #public }
GameOfLifeCell >> kill [

	color := 	Color black.
	isAlive := false.
	window updateCell: point color: color.
	^ self
]

{ #category : #public }
GameOfLifeCell >> neighbours: aListOfNeighbours [

	neighbours := aListOfNeighbours
]

{ #category : #private }
GameOfLifeCell >> numberOfLiveNeighbours [

	^ (neighbours select: [ :cell | cell isAlive ]) size.
]

{ #category : #public }
GameOfLifeCell >> point: aPoint [

	point := aPoint
]

{ #category : #public }
GameOfLifeCell >> updateLiveNeighboursCount [

	aliveNeighbours := self numberOfLiveNeighbours.
]

{ #category : #public }
GameOfLifeCell >> updateStatus [
	
	isAlive
		ifTrue: [ (aliveNeighbours  < 2 | (aliveNeighbours > 3)) ifTrue: [ self kill ] ]
		ifFalse: [ (aliveNeighbours = 3) ifTrue: [ self awake ] ]
		
]

{ #category : #private }
GameOfLifeCell >> window: aWindow [

	window := aWindow.
]
