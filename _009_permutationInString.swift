//
//  _009_permutationInString.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/18.
//

import Foundation

/*
 给定两个字符串s1和s2,写一个函数来判断s2是否包含s1的排列。
 换句话说，第一个字符串的排列之一是第二个字符串的子串。
 示例1:
 输入: s1 = "ab" s2 = "eidbaooo"
 输出: True
 解释: s2包含s1的排列之一("ba").
 示例2:
 输入: s1= "ab" s2 = "eidboaoo"
 输出: False
 */

// 判断 s 中是否存在 t 的排列

func permutationInString(_ t: String, _ s: String) -> Bool {
    if s.isEmpty || t.isEmpty { return false }
    
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
            // 找到了合法的子串
            if valid == need.count {
                return true
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
    
    return false
}
