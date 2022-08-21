Class {
	#name : #GameOfLifeCell,
	#superclass : #BorderedMorph,
	#instVars : [
		'isAlive',
		'neighbours',
		'aliveNeighbours'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #initialization }
GameOfLifeCell class >> new [
	
	|cell|
	
	cell := super new.
	cell borderStyle: (SimpleBorder width: 0 color: Color transparent). 
	cell bounds: (Rectangle point: 0@0 point: 3@3).
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
"(	 '''' join: { 'Awaking cell' } ) record."
	self color: 	Color white.
	isAlive := true.
	^ self
]

{ #category : #public }
GameOfLifeCell >> isAlive [

	^ isAlive 
]

{ #category : #public }
GameOfLifeCell >> kill [
"(	 '''' join: { 'Killing cell' } ) record."
	self color: 	Color black.
	isAlive := false.
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
GameOfLifeCell >> updateLiveNeighboursCount [

	aliveNeighbours := self numberOfLiveNeighbours.
]

{ #category : #public }
GameOfLifeCell >> updateStatus [
	
	isAlive
		ifTrue: [ (aliveNeighbours  < 2 | (aliveNeighbours > 3)) ifTrue: [ self kill ] ]
		ifFalse: [ (aliveNeighbours = 3) ifTrue: [ self awake ] ]
		
]
