//
//  _017_merge.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/6/1.
//

import Foundation

/*
 给出一个区间的集合，请合并所有重叠的区间

 示例1:
 输入: [[1,3],[2,6],[8,10], [15,18]]
 输出:
 [[1,6],[8, 10],[15, 18]]
 解释:区间[1,3]和[2,6] 重叠，将它们合并为[1,6]

 示例2:
 输入:
 [[1,4],[4,5]]
 输出: [[1,5]]
 解释:区间[1,4]和[4,5] 可被视为重叠区间
 */

func merge(_ intervals: [[Int]]) -> [[Int]] {
    // 按照区间起点升序，排序
    var array = Array(intervals)
    array.sort { (a, b) -> Bool in
        return a[0] < b[0]
    }
    
    var res = [[Int]]()
    res.append(array[0])
    
    for i in 1..<array.count {
        let cur = array[i]
        var last = res.last
        // 起点小于终点
        if cur[0] <= last![1] {
            // 找到最大的 end
            last![1] = max(last![1], cur[1])
            res.removeLast()
            res.append(last!)
        }else{
            // 下一个待合并区间
            res.append(cur)
        }
    }
    
    return res
}

func test_17() {
    let array = [[1,3],[2,6],[8,10], [15,18]]
    print(merge(array))
    
    do{
        let array = [[1,4],[4,5]]
        print(merge(array))
    }
}
