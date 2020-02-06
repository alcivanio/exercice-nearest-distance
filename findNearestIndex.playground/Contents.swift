import UIKit





/*
 Given a list of strings, this class is supposed to find the nearest distance between two strings
 This algorithm works in a best case scenario in a o(1), worst case scenario in o(n), where n is the size of the given array
 */

class NearestIndexFinder {
    
    private var cache: [String: [Int]] = [:]//key: name value: index
    
    init(elems: [String]) {
        for i in 0..<elems.count {
            if cache[elems[i]] == nil {
                cache[elems[i]] = [i]
            } else {
                cache[elems[i]]?.append(i)
            }
        }
    }
    
    func distanceBetween(first: String, andSecond second: String) -> Int {
        if cache[first] == nil || cache[second] == nil { return -1 }//o(1)
        
        guard let distancesFirst = cache[first] else { return -1 }
        guard let distancesSecond = cache[second] else { return -1 }
        
        var shortest: Int = -1
        
        //here best case is o(1), worst case is o(n), where n is the size of the elements list
        var distanceAux: Int
        for i in 0..<distancesFirst.count {
            for j in 0..<distancesSecond.count {
                distanceAux = abs(distancesFirst[i] - distancesSecond[j])
                if shortest == -1 || distanceAux < shortest {
                    shortest = distanceAux
                }
                if shortest == 0 { return 0 }// in this case we can return, it's the minimum distance
            }
        }
        
        return shortest
    }
      
}


let list = ["dog", "house", "winner", "dog", "star", "beach"]
let finder = NearestIndexFinder(elems: list)
finder.distanceBetween(first: "house", andSecond: "beach")//4
finder.distanceBetween(first: "dog", andSecond: "dog")//0
