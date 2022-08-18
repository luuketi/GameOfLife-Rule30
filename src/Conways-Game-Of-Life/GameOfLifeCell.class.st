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
	cell bounds: (Rectangle point: 0@0 point: 5@5).
	cell isAlive: false.
	cell aliveNeighbours: 0.
	^cell.
]

{ #category : #public }
GameOfLifeCell >> aliveNeighbours: aLiveNeighbours [

	aliveNeighbours := aLiveNeighbours
]

{ #category : #public }
GameOfLifeCell >> awake [

	^ self isAlive: true.
]

{ #category : #public }
GameOfLifeCell >> isAlive [

	^ isAlive 
]

{ #category : #public }
GameOfLifeCell >> isAlive: isAliveBoolean [


	self color: 	(isAliveBoolean ifTrue: [Color white] ifFalse: [Color black]).
	isAlive := isAliveBoolean.
	^ self
]

{ #category : #public }
GameOfLifeCell >> kill [

	^ self isAlive: false.
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
