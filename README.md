# Find nearest distance between two elements

Note that I don't update the Read me file often. Please check my Medium, there you may have updates in any matter about this problem: https://medium.com/@Alcivanio/how-to-write-an-algorithm-to-find-the-shortest-distance-between-two-elements-of-an-array-in-swift-a405aded3304

Today I was presented to this problem. Basically given a list of elements, I'd have to find the nearest distance between two elements of that list. 

You can see an example of given list. Notice that we're not talking about a set. which means that elements could possibly repeat.

```swift
let list = ["dog", "house", "winner", "dog", "star", "beach"]
```

Let's go through some possibly situations an answers now.  

```swift
"dog" & "house" = 1
"dog" & "dog" = 0
"house" & "beach" = 4
```
Ok so let's go to the algorithm. First of all we're going to create a class wrapper to contain our information. We'll call it `NearestIndexFinder`. The initializer of this class will receive the list of elements. Here's where our algorithm will start work. But before let's thing a little about the problem.

The computation time for this algorithm, if we have only the list to deal with, will be of an average of o(n), because we'll have to compare all the elements of the array with each other and pick the nearest distance. We may also have cases where the distance would be 0 in the first iteration of our comparitions. We could possibily return and the computation time will be o(1). But this case isn't supposed to happen all the time and we can't count on that. 

My first idea to solve this problem in the fastest way possible would be to create a cache dictionary, where the keys are going to be the array elements, and the value of this dictionary will be the position of those elements on that original array. Our init will take a o(1) time to be initialized, but after that we can have results for our algorithm in a o(1) basis. Let's see would we can implement the init

```swift
private var cache: [String: [Int]] = [:]//key: name value: index

init(elements: [String]) {
    for i in 0..<elements.count {
        if cache[elements[i]] == nil {
            cache[elements[i]] = [i]
        } else {
            cache[elements[i]]?.append(i)
        }
    }
}
```

Good. Now we have the cache/dictionary of elements. The next step would be to create a function to check the distance. 

```swift
func distanceBetween(firstString first: String, andSecondString second: String) -> Int 
```

First we have to check some edge cases for this function. The one I have on top of my mind now would be to see if the given strings are in that array. If that string isn't there, we can just return -1, meaning that the distance can't be computed. Instead of going over the array, we can just check if our dictionary contains a value for that given string. If not, it means that the given string wasn't in the original list. This operation is executed in o(1). That's great.

```swift
if cache[first] == nil || cache[second] == nil { return -1 }
```
Another way to do it would be just getting those dictionaries of index and assigning them to a `let` using a `guard let`, as can be seen below:

```swift
guard let distancesFirst = cache[first] else { return -1 }
guard let distancesSecond = cache[second] else { return -1 }
```
Good. Now there's not much secret, we must compare the distances between all the elements of the arrays.

```swift
for i in 0..<distancesFirst.count {
    for j in 0..<distancesSecond.count {
        let distance = abs(distancesFirst[i] - distancesSecond[j])
    }
}
```

Basically the distance will be the absolute value of a subtraction between the first index and the second. We found it. But what can we do with that? Maybe put those distances in a list? Let's say a `let distances: [Int] = []`? Sounds fair, but at the end we'd have to compare which is the lowerst number of that list. Which means something like o(n)? We don't want that. We can though just store the lowerst number, after all, is the only thing we're interest in, right? So let's do it. 

```swift
var shortest: Int = -1
var distanceAux: Int

for i in 0..<distancesFirst.count {
    for j in 0..<distancesSecond.count {
		distanceAux abs(distancesFirst[i] - distancesSecond[j])
		if shortest == -1 || distanceAux < shortest {
            shortest = distanceAux
        }
    }
}
```
I made a few changes here. I created a `shortest` variable. It will have initial value -1, and will be replaced everytime i found a nubmer and that shortest var still being -1 or when that new number is lower than the current one stored in `shorters`. Also, I moved the declaration of `let distance` to outside the loop and renamed it to `distanceAux`. So then we don't instantiate this guy everytime, instead will just reuse. 

We have pretty much everything. At the end of the loop we'll have the shortest distance between the indexes of two given strings. Maybe we could just return immediately if the shortest becomes 0. After all, 0 is the shortest possible distance, meaning that those strings are the same. Obviously that we could also only check before the for loop if the strings are equal. If yes we just return 0. Let's keep the last option, because our if statement will be executed only once for sure.



```swift
func distanceBetween(firstString first: String, andSecondString second: String) -> Int  {
	guard let distancesFirst = cache[first] else { return -1 }
	guard let distancesSecond = cache[second] else { return -1 }
	if first == second { return 0 }
	
	var shortest: Int = -1
	var distanceAux: Int
	
	for i in 0..<distancesFirst.count {
	    for j in 0..<distancesSecond.count {
			distanceAux abs(distancesFirst[i] - distancesSecond[j])
			if shortest == -1 || distanceAux < shortest {
	            shortest = distanceAux
	        }
	    }
	}
}
```
I guess that's it. In a good case scenario our algorithm will be executed on o(1), worst case scenario, where most part of the strings of the list are repated, our algorithm will be executed on something closer to o(n).









