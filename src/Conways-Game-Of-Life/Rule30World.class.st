Class {
	#name : #Rule30World,
	#superclass : #Object,
	#instVars : [
		'height',
		'width',
		'world',
		'window',
		'deadCell',
		'lastRow',
		'wholeLastRow'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #'instance creation' }
Rule30World class >> withHeight: aHeight withWidth: aWidth [

	| w |
	
	w := self new.
	w height: aHeight.
	w width: aWidth.
	w createWindow.
	w createWorld.
	^ w.
]

{ #category : #private }
Rule30World >> at: x at: y [

	^ (world at: y) at: x
]

{ #category : #private }
Rule30World >> at: x at: y put: aValue [

	 (world at: y) at: x put: aValue 
]

{ #category : #private }
Rule30World >> computeLastRow [

	| newX newWholeLastRow |
	
	newWholeLastRow := Array new: wholeLastRow size + 2 withAll: false.
	1 to: (wholeLastRow size) do: [ :w | 
		newX := self computeNewXAt: w from: wholeLastRow .
		newWholeLastRow at: w + 1 put: newX.
		 ].

	wholeLastRow := newWholeLastRow.
]

{ #category : #private }
Rule30World >> computeLastStep [

	self computeLastRow.
	self updateLastRowInWorld.


]

{ #category : #private }
Rule30World >> computeNewXAt: aPosition from: aRow [ 

	| beforeX x afterX |
	
	beforeX := wholeLastRow at: aPosition - 1 ifAbsent: [ false ].
	x := wholeLastRow at: aPosition.
	afterX := wholeLastRow at: aPosition + 1 ifAbsent: [ false ].

	^ beforeX xor: (x | afterX).
]

{ #category : #private }
Rule30World >> createWindow [
			
	window := GameOfLifeWindow withHeight: height  withWidth: width.
]

{ #category : #private }
Rule30World >> createWorld [
	
	wholeLastRow := Array new: width withAll:false.
	deadCell := GameOfLifeCell at: 1@1 window: (GameOfLifeWindow withHeight: 1  withWidth: 1).
	world := Dictionary new.
	self initializeWorld.
]

{ #category : #private }
Rule30World >> height: aHeight [

	height := aHeight.
]

{ #category : #private }
Rule30World >> initializeWorld [

	| newRow |
	
	1 to: height do: [ :h | 
		newRow := Array new: width.
		1 to: width do: [ :w | newRow at: w put: (GameOfLifeCell at: (w@h) window: window) ].
		world at: h put: newRow ].
	
	(self at: ((width/2) ceiling) at: height) awake.
	(wholeLastRow at: ((width/2) ceiling) put:true).
]

{ #category : #public }
Rule30World >> play: aNumberOfSteps [

	| time timeSpent timeToWait |
	
	window show.

	[ 1 to: aNumberOfSteps do: 
		[ :step | 
	time := DateAndTime now.     	
	self rotatePositions.
	self computeLastStep. 
	window draw.
			

			timeSpent := (DateAndTime now - time) asMilliSeconds.
			timeSpent record.
			timeToWait := 150 - timeSpent.
			timeToWait > 0 ifTrue: [ (Delay forMilliseconds: timeToWait) wait. ]		
			
			
		]
	] fork.
 
	
]

{ #category : #private }
Rule30World >> rotatePositions [

	| previousCell currentCell currentIsAlive |
	1 to: height - 1 do: [ :h | 
		1 to: width do: [ :w | 
			currentCell := world at: h at: w.
			previousCell := world at: h + 1 at: w.
			currentIsAlive := currentCell isAlive.
			(currentIsAlive ~= previousCell isAlive) 
				ifTrue: [ 
					currentIsAlive
						ifTrue: [ currentCell kill ]
						ifFalse: [ currentCell awake ] ] ] ].

]

{ #category : #public }
Rule30World >> topPositions [

	^ world at: 1 .
]

{ #category : #private }
Rule30World >> updateLastRowInWorld [

	| newX offset newCell |
	
	offset := (wholeLastRow size - width) / 2.
	1 to: width do: [ :w |
		newX := wholeLastRow at: (w + offset).
		newCell := world at: height at: w.
		newX ifTrue: [ newCell awake ] ifFalse: [ newCell kill ].
		 ].


]

{ #category : #private }
Rule30World >> width: aWidth [

	width := aWidth.
]
