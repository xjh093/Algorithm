//
//  _016_removeCoveredIntervals.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/31.
//

import Foundation

/*
 删除被覆盖的区间

 给你一个区间列表，请你删除列表中被其他区间所覆盖的区间
 只有当 c<=a且b<=d时，我们才认为区间[a,b)被左闭右开区
 间[c,d) 覆盖
 在完成所有删除操作后，请你返回列表中剩余区间的数目

 示例:
 输入: intervals = [[1,4],[3,6], [2,8]]
 输出: 2
 解释:区间[3,6] 被区间[2,8] 覆盖，所以它被删除了
 */

func removeCoverdIntervals(_ intvs: [[Int]]) -> Int {
    // 按照起点升序排列，起点相同时降序排列
    var array = Array(intvs)
    array.sort { (a, b) -> Bool in
        if a[0] == b[0] {
            return b[1] < a[1]
        }
        return a[0] < b[0]
    }
    
    // 记录合并区间的起点和终点
    var left = array[0][0]
    var right = array[0][1]
    
    var res = 0
    for i in 1..<array.count {
        let sub = array[i]
        // 情况一，找到覆盖区间
        if left <= sub[0] && right >= sub[1] {
            res += 1
        }
        // 情况二，找到相交区间，合并
        if right >= sub[0] && right <= sub[1] {
            right = sub[1]
        }
        // 情况三，完全不相交，更新起点和终点
        if right < sub[0] {
            left = sub[0]
            right = sub[1]
        }
    }
    
    return array.count - res
}

func test_16() {
    let arr = [[1,4],[3,6],[2,8]]
    
    print(removeCoverdIntervals(arr))
}
