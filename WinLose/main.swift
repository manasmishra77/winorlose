//
//  main.swift
//  WinLose
//
//  Created by Mohammed4 Shaikh on 04/05/19.
//  Copyright © 2019 Mohammed4 Shaikh. All rights reserved.
//

import Foundation
//
//print("Hello, World!")
//
//func solveMefirst(firstNo: Int , secondNo: Int) -> Int {
//    return firstNo + secondNo
//}
//func checkforWinLose( numberOfPlayerAndVillan:Int,villanPower:[Int],playerPower:[Int])
//{
//
//    for i in 0...numberOfPlayerAndVillan-1{
//        if villanPower[i] >= playerPower [i]
//        {
//            print("LOSE")
//        }
//    }
//    print("WIN")
//}
////func input() -> String {
////    let keyboard = FileHandle.standardInput
////    let inputData = keyboard.availableData
////    return NSString(data: inputData, encoding:String.Encoding.utf8.rawValue) as! String
////}
//
//
//
//let numberOfTestCase = Int(readLine()!)!
//
//
//
//var gameData:[(Int,[Int],[Int])] = []
//for _ in 0...numberOfTestCase-1{
//    let numberOfPlayerAndVillan = Int(readLine()!)!
//    let villanPowers = readLine()!
//    let playerPower = readLine()!
//    let strArray = villanPowers.components(separatedBy: " ")
//
//    let villanArray = villanPowers.components(separatedBy: " ").map { Int($0) ?? 0}
//    let playerArray = playerPower.components(separatedBy: " ").map { Int($0) ?? 0}
//    gameData.append((numberOfPlayerAndVillan,villanArray,playerArray))
//}
//
//for testCase in 0...numberOfTestCase-1{
//    let sortedVillan = gameData[testCase].1.sorted()
//    let sortedPlayer = gameData[testCase].2.sorted()
//    let numberOfPlayerAndVillan = gameData[testCase].0
//    checkforWinLose(numberOfPlayerAndVillan: numberOfPlayerAndVillan, villanPower: sortedVillan, playerPower: sortedPlayer)
//
//}
//
//
//import Swift

/**
 * Read input from STDIN. Print your output to STDOUT
 * Use readLine() to read input from STDIN
 * use print to write your output to STDOUT
 */
// Below is an example on how to take integer input and print it.
// a = parse(Int,readline(STDIN))
// print(a)


let numberOfTestCase = Int(readLine()!)!
//var newYearTuple:[(Int,[Int])] = []
var myArray:[[Int]] = []
for _ in 0...numberOfTestCase-1{
    let ticketDistributedInHouse = Int(readLine()!)!
    let ticketValueInput = readLine()!
    let ticketValue:[Int] = ticketValueInput.components(separatedBy: " ").map { Int($0) ?? 0}
    myArray.append(ticketValue)
}



for eachArray in myArray{
    var arr = eachArray
    var largestSumArr: [(p: Int?, c: Int?, s: Int?)] = []
    var prevIndexLargestSum: Int!
    var prev2ndIndexLargestSum: Int!
    var largestIndex: [Int] = []
    
    func printElements() {
        var greatestIndex: Int!
        if largestIndex.count == 0 {
            return
        } else {
            greatestIndex = largestIndex[0]
        }
        for each in largestIndex {
            if arr[each] > arr[greatestIndex] {
                greatestIndex = each
            }
        }
        var continueLoop = true
        var index: Int! = greatestIndex
        var output = ""
        while continueLoop {
            let current = largestSumArr[index].c
            let previous = largestSumArr[index].p
            if current != nil {
                output.append("\(arr[current!])")
            }
            if previous != nil {
                index = previous!
            } else {
                continueLoop = false
            }
        }
        print(output)
    }
    
    func findLargestSum() {
        for (index, each) in arr.enumerated() {
            if prevIndexLargestSum == nil {
                if each == 0 {
                    largestSumArr.append((p: nil, c: nil, s: nil))
                } else {
                    prevIndexLargestSum = each
                    largestSumArr.append((p: nil, c: index, s: prevIndexLargestSum))
                    decideLargestIndex(index: index)
                }
            } else if prev2ndIndexLargestSum == nil {
                if each == 0 {
                    prev2ndIndexLargestSum = prevIndexLargestSum
                    largestSumArr.append((p: largestIndex[0], c: nil, s: nil))
                } else {
                    prev2ndIndexLargestSum = prevIndexLargestSum
                    if each >= prevIndexLargestSum {
                        prevIndexLargestSum = each
                        largestSumArr.append((p: nil, c: index, s: prevIndexLargestSum))
                        decideLargestIndex(index: index)
                    } else {
                        largestSumArr.append((p: largestIndex[0], c: nil, s: prevIndexLargestSum))
                    }
                }
            } else {
                if each == 0 {
                    if prevIndexLargestSum > prev2ndIndexLargestSum {
                        prev2ndIndexLargestSum = prevIndexLargestSum
                    }
                    largestSumArr.append((p: index-1, c: nil, s: prevIndexLargestSum))
                    continue
                }
                let nextSum = each + prev2ndIndexLargestSum
                prev2ndIndexLargestSum = prevIndexLargestSum
                if nextSum > prevIndexLargestSum, nextSum > each {
                    prevIndexLargestSum = nextSum
                    largestSumArr.append((p: index-2, c: index, s: prevIndexLargestSum))
                    decideLargestIndex(index: index)
                } else if each >= prevIndexLargestSum {
                    prevIndexLargestSum = each
                    largestSumArr.append((p: nil, c: index, s: prevIndexLargestSum))
                    decideLargestIndex(index: index)
                } else {
                    largestSumArr.append((p: index-1, c: nil, s: prevIndexLargestSum))
                }
            }
        }
        printElements()
    }
    
    func decideLargestIndex(index: Int) {
        if let firstLargeIndex = largestIndex.first {
            if prevIndexLargestSum > (largestSumArr[firstLargeIndex].s)! {
                largestIndex.removeAll()
                largestIndex.append(index)
            } else if prevIndexLargestSum == largestSumArr[firstLargeIndex].s {
                largestIndex.append(index)
            }
        } else {
            largestIndex.append(index)
        }
    }
    
    
    findLargestSum()
}



