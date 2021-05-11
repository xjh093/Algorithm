//
//  _003_permute.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/11.
//  全排列，输出1个数组的全排列，数组中没有重复的数

import Foundation

var res:[[Int]] = []

func permute(_ nums: [Int]) -> [[Int]] {
    var track: [Int] = [] // 记录
    backtrack(nums, &track)
    return res
}

func backtrack(_ nums: [Int], _ track: inout [Int]) {
    if track.count == nums.count {
        var tmp = [Int]()
        tmp.append(contentsOf: track)
        res.append(tmp)
        return
    }
    
    for i in nums {
        if track.contains(i) { // 排除
            continue
        }
        
        track.append(i) // 做选择
        backtrack(nums, &track) // 进入下一层
        track.removeLast() // 取消选择
    }
}
