//
//  _021_canPartition.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/6/21.
//

import Foundation

/*
 给定一个只包含正整数的非空数组。是否可以将这个数组分割成两个子集,使得两个子集的元素和相等

 注意:
 1,每个数组中的元素不会超过100
 2.数组的大小不会超过200

 示例1:
 输入: [1, 5, 11, 5]
 输出: true
 解释: 数组可以分割成 [1, 5, 5] 和 [11]

 示例2:
 输入: [1, 2, 3, 5]
 输出: false
 解释: 数组不能分割成两个元素和相等的子集
 */

func canPartition_v1(_ nums: [Int]) -> Bool {
    var sum = 0
    for num in nums {
        sum += num
    }
    // 和为奇数时，不可能划分成两个和相等的集合
    if sum % 2 != 0 { return false }
    
    let n = nums.count
    sum = sum / 2
    let sub = [Bool](repeating: false, count: sum+1)
    var arr = [[Bool]](repeating: sub, count: n+1)
    // base case
    for i in 0...n { arr[i][0] = true }
    //
    for i in 1...n {
        for j in 1...sum {
            // 容量不足，不能装入
            if j - nums[i-1] < 0 {
                arr[i][j] = arr[i-1][j]
            }else{
                // 装入或者不装入背包
                arr[i][j] = arr[i-1][j-nums[i-1]] ||
                            arr[i-1][j]
            }
        }
    }
    //print(arr)
    return arr[n][sum]
}

/*
 进行状态压缩
 
 dp[i][j] 都是通过上一行 dp[i-1][...] 转移过来的，之前的数据不会再使用了
 */

func canPartition_v2(_ nums: [Int]) -> Bool {
    var sum = 0
    for num in nums {
        sum += num
    }
    // 和为奇数时，不可能划分成两个和相等的集合
    if sum % 2 != 0 { return false }
    
    let n = nums.count
    sum = sum / 2
    var arr = [Bool](repeating: false, count: sum+1)
    arr[0] = true
    
    for i in 0..<n {
        var j = sum
        while j >= 0 {
            if j - nums[i] >= 0 {
                arr[j] = arr[j] || arr[j-nums[i]]
            }
            j -= 1
        }
    }
    return arr[sum]
}

func test21() {
    let nums = [1, 5, 11, 5]
    print(canPartition_v1(nums))
    print(canPartition_v2(nums))
    
    do {
        let nums = [1, 2, 3, 5]
        print(canPartition_v1(nums))
        print(canPartition_v2(nums))
    }
}
