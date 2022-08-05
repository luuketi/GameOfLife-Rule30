Class {
	#name : #GameOfLifeWorld,
	#superclass : #Object,
	#instVars : [
		'height',
		'width',
		'world'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #'instance creation' }
GameOfLifeWorld class >> withHeight: aHeight withWidth: aWidth [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
	| world |
	world := 	self new.	
	world setHeight: aHeight. 
	world setWidth: aWidth.
	world createWorld.
	^world
	
]

{ #category : #creation }
GameOfLifeWorld >> addPattern: aPattern [
			
	(aPattern positions) do: [ :position | world at: position put: true ].
	


]

{ #category : #private }
GameOfLifeWorld >> assertValidPoint: aPoint [

	| x y |
	x := aPoint x.
	y := aPoint y.
	
	(y > height) | (x > width) | (y <= 0) | (x <= 0)
		ifTrue: [ ^ AssertionFailure  new signal: 'Invalid Point' ]
]

{ #category : #private }
GameOfLifeWorld >> countLiveNeighbours: aCell [

	| count x y |
	
	count := 0.
	x := aCell x.
	y := aCell y.
	(world at: ((x-1)@(y-1)) ifAbsent: [false]) ifTrue: [count := count + 1].		
	(world at: ((x-1)@y) ifAbsent: [false]) 	 ifTrue: [count := count + 1].
	(world at: ((x-1)@(y+1)) ifAbsent: [false]) ifTrue: [count := count + 1].
	(world at: (x@(y-1)) ifAbsent: [false]) 	 ifTrue: [count := count + 1].
	(world at: (x@(y+1)) ifAbsent: [false]) 	 ifTrue: [count := count + 1].	
	(world at: ((x+1)@(y-1)) ifAbsent: [false]) ifTrue: [count := count + 1].		
	(world at: ((x+1)@y) ifAbsent: [false])     ifTrue: [count := count + 1].
	(world at: ((x+1)@(y+1)) ifAbsent: [false]) ifTrue: [count := count + 1].
	
	^ count		

]

{ #category : #private }
GameOfLifeWorld >> createWorld [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	world := Dictionary new.
]

{ #category : #accessing }
GameOfLifeWorld >> isAlive: aPoint [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
		
		self assertValidPoint: aPoint.
		^ (world at: aPoint ifAbsent: [ false ]).
]

{ #category : #execution }
GameOfLifeWorld >> moveToNextGeneration [
			
	world keysDo: [ :k | self updateCell: k ].
]

{ #category : #private }
GameOfLifeWorld >> setHeight: aHeight [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	height := aHeight 
]

{ #category : #private }
GameOfLifeWorld >> setWidth: aWidth [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	width := aWidth 
]

{ #category : #private }
GameOfLifeWorld >> updateCell: aCell [

	| isAlive |
	
	isAlive := world at: aCell .
	isAlive ifTrue: [ self updateLiveCell: aCell ]
			  ifFalse:[ self updateDeadCell: aCell ]
]

{ #category : #private }
GameOfLifeWorld >> updateDeadCell: aCell [

	| liveNeighbours |
	
	liveNeighbours := self countLiveNeighbours: aCell.
	(liveNeighbours = 3)
		ifTrue: [ world at: aCell put: true ]
]

{ #category : #private }
GameOfLifeWorld >> updateLiveCell: aCell [

	| liveNeighbours |
	
	liveNeighbours := self countLiveNeighbours: aCell.
	(liveNeighbours < 2 | (liveNeighbours > 3))
		ifTrue: [ world at: aCell put: false ]
]
