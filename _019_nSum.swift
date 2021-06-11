//
//  _019_nSum.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/6/3.
//

import Foundation

/*
 如果假设输入一个数组 nums 和一个目标和 target，请你返回 nums 中能够凑出 target 的两个元素的值
 比如输入 nums = [5,3,1,6], target = 9，那么算法返回两个元素 [3,6]
 可以假设只有且仅有一对儿元素可以凑出 target
 */

func twoSum_v1(_ nums: [Int], _ target: Int) -> [Int] {
    // 对数组进行升序排序
    let array = nums.sorted { (a, b) -> Bool in
        a < b
    }
    
    var lo = 0, hi = array.count - 1
    while lo < hi {
        let sum = array[lo] + array[hi]
        if sum < target {
            lo += 1
        }else if sum > target {
            hi -= 1
        }else if sum == target {
            return [array[lo], array[hi]]
        }
    }
    return []
}

/*
 nums 中可能有多对儿元素之和都等于 target，请你的算法返回所有和为 target 的元素对儿，其中不能出现重复
 */

func twoSum_v2(_ nums: [Int], _ target: Int) -> [[Int]] {
    // 对数组进行升序排序
    let array = nums.sorted { (a, b) -> Bool in
        a < b
    }
    
    var res = [[Int]]()
    var lo = 0, hi = array.count - 1
    while lo < hi {
        let sum = array[lo] + array[hi]
        if sum < target {
            lo += 1
        }else if sum > target {
            hi -= 1
        }else{
            res.append([array[lo], array[hi]])
            lo += 1; hi -= 1
        }
    }
    return res
}

/*
 去除重复的元素对
 */
func twoSum_v3(_ nums:[Int], _ target: Int) -> [[Int]] {
    // 对数组进行升序排序
    let array = nums.sorted { (a, b) -> Bool in
        a < b
    }
    
    var res = [[Int]]()
    var lo = 0, hi = array.count - 1
    while lo < hi {
        let sum = array[lo] + array[hi]
        let left = array[lo], right = array[hi]
        if sum < target {
            while lo < hi && array[lo] == left {
                lo += 1
            }
        }else if sum > target {
            while lo < hi && array[hi] == right {
                hi -= 1
            }
        }else{
            res.append([left, right])
            while lo < hi && array[lo] == left {
                lo += 1
            }
            while lo < hi && array[hi] == right {
                hi -= 1
            }
        }
    }
    return res
}

// 3Sum，3数之和为 target
func threeSumTarget(_ nums: [Int], _ target: Int) -> [[Int]] {
    // 对数组进行升序排序
    let array = nums.sorted { (a, b) -> Bool in
        a < b
    }
    
    var i = 0, count = array.count
    var res = [[Int]]()
    while i < count {
        let tmp = twoSumTarget(array, i + 1, target - array[i])
        // 存在满足条件的二元组
        for two in tmp {
            var r = Array(two)
            r.append(array[i])
            res.append(r)
        }
        // 跳过第一个数字重复的情况
        while i < count - 1 && array[i] == array[i + 1] {
            i += 1
        }
        i += 1
    }
    
    return res
}

func twoSumTarget(_ nums: [Int], _ start: Int, _ target: Int) -> [[Int]] {
    // 对数组进行升序排序
//    let array = nums.sorted { (a, b) -> Bool in
//        a < b
//    }
    
    let array = nums
    var res = [[Int]]()
    var lo = start, hi = array.count - 1
    while lo < hi {
        let left = array[lo], right = array[hi]
        let sum = left + right
        if sum < target {
            while lo < hi && array[lo] == left {
                lo += 1
            }
        }else if sum > target {
            while lo < hi && array[hi] == right {
                hi -= 1
            }
        }else{
            res.append([left, right])
            while lo < hi && array[lo] == left {
                lo += 1
            }
            while lo < hi && array[hi] == right  {
                hi -= 1
            }
        }
    }
    return res
}

// nSum
func nSum(_ nums: [Int], _ n: Int, _ start: Int,
          _ target: Int) -> [[Int]] {
    let sz = nums.count
    var res = [[Int]]()
    // 至少是 2Sum，且数组大小不应该小于 n
    if n < 2 || sz < n { return res }
    // 2Sum 问题
    if n == 2 {
        var lo = start, hi = sz - 1
        while lo < hi {
            let left = nums[lo], right = nums[hi]
            let sum = left + right
            if sum < target {
                while lo < hi && nums[lo] == left { lo += 1 }
            }else if sum > target {
                while lo < hi && nums[hi] == right { hi -= 1 }
            }else{
                res.append([left, right])
                while lo < hi && nums[lo] == left { lo += 1 }
                while lo < hi && nums[hi] == right { hi -= 1 }
            }
        }
    }else{
        // n > 2, 递归计算 (n-1)Sum 的结果
        var i = start
        while i < sz {
            let sub = nSum(nums, n-1, i+1, target-nums[i])
            for arr in sub {
                var r = Array(arr)
                r.append(nums[i])
                res.append(r)
            }
            
            while i < sz - 1 && nums[i] == nums[i+1] {
                i += 1
            }
            i += 1
        }
    }
    return res
}

func test19() {
    print(twoSum_v1([5,3,1,6], 9))
    print(twoSum_v2([1,3,1,2,2,3], 4))
    print(twoSum_v3([1,3,1,2,2,3], 4))
 
    print(threeSumTarget([-1,0,1,2,-1,-4], 0))
    
    let array = [-1,0,1,2,-1,-4]
    let nums = array.sorted { (a, b) -> Bool in
        a < b
    }
    print(nSum(nums, 3, 0, 0))
}
