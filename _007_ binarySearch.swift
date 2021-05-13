//
//  _007_ binarySearch.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/13.
//

import Foundation

// 搜索一个数，如果存在，返回其索引，否则返回 -1
func binarySearch_v1(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var right = nums.count - 1
    while left <= right {
        let mid = left + (right - left) / 2
        if nums[mid] == target {
            return mid
        }else if (nums[mid] < target) { // 小于目标
            left = mid + 1  // 往右侧找
        }else if (nums[mid] > target) { // 大于目标
            right = mid - 1 // 往左侧找
        }
    }
    return -1
}

// 寻找左侧边界
func binarySearch_v2(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var right = nums.count - 1
    while left <= right {
        let mid = left + (right - left) / 2
        if nums[mid] == target { // 找到目标
            right = mid - 1  // 收缩右侧边界
        }else if nums[mid] < target { // 小于目标
            left = mid + 1 // 往右侧找
        }else if nums[mid] > target { // 大于目标
            right = mid - 1 // 往左侧找
        }
    }
    // 检查出界
    if (left >= nums.count || nums[left] != target) {
        return -1
    }
    return left
}

// 寻找右侧边界
func binarySearch_v3(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var right = nums.count - 1
    while left <= right {
        let mid = left + (right - left) / 2
        if nums[mid] == target { // 找到目标
            left = mid + 1  // 收缩左侧边界
        }else if nums[mid] < target { // 小于目标
            left = mid + 1  // 往右侧找
        }else if nums[mid] > target { // 大于目标
            right = mid - 1 // 往左侧找
        }
    }
    //
    if right < 0 || nums[right] != target {
        return -1
    }
    return right
}

