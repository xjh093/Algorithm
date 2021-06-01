//
//  _018_intervalIntersection.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/6/1.
//

import Foundation

/*
 给定两个由一些闭区间组成的列表，每个区间列表都是成对不相交的，并且已经排序
 返回这两个区间列表的交集
 形式上，闭区间[a，b](其中a<=b)表示实数X的集合,而a<=
 X <= b。两个闭区间的交集是一组实数，要么为空集，要么为闭区间。例如,
 [1, 3]和[2, 4]的交集为[2, 3]

 示例:

 输入:A = [[0,2],[5, 10],[13, 23],[24,25]]，
 B = [[1,5],[8,12], [15, 24], [25,26]]
 输出: [[1,2],[5,5],[8,10], [15,23], [24, 24], [25, 25]]
 注意:输入和所需的输出都是区间对象组成的列表，而不是数组或列表
 */

func intervalIntersection(_ A: [[Int]], _ B: [[Int]]) -> [[Int]] {
    var i = 0, j = 0, countA = A.count, countB = B.count
    var res = [[Int]]()
    
    while i < countA && j < countB {
        let a1 = A[i][0], a2 = A[i][1]
        let b1 = B[j][0], b2 = B[j][1]
        // 两个区间存在交集
        if b2 >= a1 && a2 >= b1 {
            res.append([max(a1, b1), min(a2, b2)])
        }
        // 指针前进
        if b2 < a2 { j += 1}
        else { i += 1}
    }
    return res
}

func test_18() {
    let A = [[0,2],[5, 10],[13, 23],[24,25]]
    let B = [[1,5],[8,12], [15, 24], [25,26]]
    
    print(intervalIntersection(A, B))
}
