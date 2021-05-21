//
//  _014_rob.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/21.
//

import Foundation

/*
 你是一个专业的盗贼，计划偷打劫街的房屋。每间房内都藏有一定的现金， 影响你的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被盗贼闯入，系统会自动报警。
 给定一个代表每个房屋存放金额的非负整数数组，计算你在不触动警报装置的情况下，能够偷窃到的最高金额。

 示例1:
 输入: [1,2,3,1]
 输出: 4
 解释:偷窃1号房屋(金额=1)，然后偷窃3号房屋(金额=3)。
 偷窃到的最高金额=1 +3=4

 示例2:
 输入: [2,7,9,3,1]
 输出: 12
 解释:偷窃1号房屋(金额=2)，偷窃3号房屋(金额=9)，接着偷窃5号房屋(金额=1)
 偷窃到的最高金额=2+9+1=12
 */

func rob_v1(_ nums: [Int]) -> Int {
    func dp(_ nums: [Int], _ start: Int) -> Int {
        if start >= nums.count { return 0 }
        
        // 不抢，去下家
        let res1 = dp(nums, start + 1)
        // 抢，去下下家
        let res2 = nums[start] + dp(nums, start + 2)
        
        let res = max(res1, res2)
        return res
    }
    return dp(nums, 0)
}

func rob_v2(_ nums: [Int]) -> Int {
    let count = nums.count
    var cache = [Int](repeating: -1, count:count)
    
    func dp(_ nums: [Int], _ start: Int) -> Int {
        if start >= nums.count { return 0 }
        if cache[start] != -1 { return cache[start] }
        
        // 不抢，去下家
        let res1 = dp(nums, start + 1)
        // 抢，去下下家
        let res2 = nums[start] + dp(nums, start + 2)
        
        let res = max(res1, res2)
        cache[start] = res
        return res
    }
    return dp(nums, 0)
}

func rob_v3(_ nums: [Int]) -> Int {
    let n = nums.count
    var dp = [Int](repeating: 0, count: n+2)
    var i = n - 1
    while i >= 0 {
        dp[i] = max(dp[i+1], nums[i] + dp[i+2])
        i -= 1
    }
    return dp[0]
}

func rob_v4(_ nums: [Int]) -> Int {
    let n = nums.count
    var dp_i_1 = 0
    var dp_i_2 = 0
    var dp_i   = 0
    var i = n - 1
    while i >= 0 {
        dp_i = max(dp_i_1, nums[i] + dp_i_2)
        dp_i_2 = dp_i_1
        dp_i_1 = dp_i
        i -= 1
    }
    return dp_i
}
