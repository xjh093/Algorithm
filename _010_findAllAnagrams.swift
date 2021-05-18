//
//  _010_findAllAnagrams.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/18.
//

import Foundation

/*
 给定一个字符串s和一个非空字符串p,找到s中所有是p的字母异位词的子串，返回这些子
 串的起始索引。
 字符串只包含小写英文字母，并且字符串s和p的长度都不超过20100。
 说明:
 ●字母异位词指字母相同，但排列不同的字符串。
 ●不考虑答案输出的顺序。
 示例1:
 输入:
 s: "cbaebabacd" p: "abc"
 输出:
 [0，6]
 解释:
 起始索引等于0的子串是"cba", 它是"abc" 的字母异位词。
 起始索引等于6的子串是"bac"， 它是"abc" 的字母异位词。
 */

func findAllAnagrams(_ s: String, _ t: String) -> [Int] {
    if s.isEmpty || t.isEmpty { return [] }
    
    // 子串中字符个数
    var need: [String:Int] = [:]
    // 窗口
    var window: [String:Int] = [:]
    // 窗口左、右
    var left = 0
    var right = 0
    // 当 valid 与 need 个数相同时，找到可行解
    var valid = 0
    
    for c in t {
        let key = String(c)
        if need[key] != nil {
            need[key]! += 1
        }else{
            need[key] = 1
        }
    }
    
    var res: [Int] = []
    while right < s.count {
        // c 是将移入窗口的字符
        let index = s.index(s.startIndex, offsetBy: right)
        let c = String(s[index])
        // 右移窗口
        right += 1
        // 数据更新，子串中存在
        if need[c] != nil {
            if window[c] != nil {
                window[c]! += 1
            }else{
                window[c] = 1
            }
            // 窗口中的数量 满足 需要数量时，满足 1 个
            if window[c] == need[c] {
                valid += 1
            }
        }
        // 是否收缩窗口，所有的都满足了
        while right - left >= t.count {
            // 当窗口符合条件时，把起始索引加入 res
            if valid == need.count {
                res.append(left)
            }
            // d 是将移出窗口的字符
            let index = s.index(s.startIndex, offsetBy: left)
            let d = String(s[index])
            // 左移窗口
            left += 1
            
            if need[d] != nil {
                // 满足时, 减少
                if window[d] == need[d] {
                    valid -= 1
                }
                // 移除
                window[d]! -= 1
            }
        }
    }
    return res
}
