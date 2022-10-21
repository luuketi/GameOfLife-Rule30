Class {
	#name : #BothWorlds,
	#superclass : #Object,
	#instVars : [
		'width',
		'height',
		'gameOfLife',
		'rule30'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #creation }
BothWorlds class >> withHeight: aHeight withWidth: aWidth [

	| w |
	
	w := self new.
	w setHeight: aHeight.
	w setWidth: aWidth.
	w createWorlds.
	^ w.
]

{ #category : #creation }
BothWorlds >> createWorlds [

	gameOfLife := GameOfLifeWorld withHeight: height withWidth: width at:(50@50).
	rule30 := Rule30World withHeight: height withWidth: width at:(50@(50+(height*2))).
]

{ #category : #execution }
BothWorlds >> play: aNumberOfSteps [

	| time timeSpent timeToWait |

	[ 1 to: aNumberOfSteps do: 
		[ :step | 

			time := DateAndTime now.

			gameOfLife play.
			rule30 play.
			gameOfLife addPattern: (rule30 topPositionsAsPattern).
			
			timeSpent := (DateAndTime now - time) asMilliSeconds.
			timeSpent record.
			timeToWait := 100 - timeSpent.
			timeToWait > 0 ifTrue: [ (Delay forMilliseconds: timeToWait) wait. ]
		]
	] fork.
]

{ #category : #private }
BothWorlds >> setHeight: aHeight [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	height := aHeight
]

{ #category : #private }
BothWorlds >> setWidth: aWidth [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	width := aWidth 
]
