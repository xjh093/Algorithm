//
//  _008_minWindow.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/17.
//

/*
 给你一个字符串S、一个字符串T,请在字符串S里面找出包含T所有字母的最小子串
 示例:
 输入: S ="ADOBECODEBANC"，T = "ABC"
 输出: "BANC"
 说明:
 如果S中不存这样的子串，则返回空字符串""
 如果S中存在这样的子串，我们保证它是唯一的答案
 */

import Foundation

func minWindow(_ s: String, _ t: String) -> String {
    if s.isEmpty || t.isEmpty { return "" }
    
    // 子串中字符个数
    var need: [String: Int] = [:]
    // 窗口
    var window: [String: Int] = [:]
    // 窗口左、右
    var left = 0
    var right = 0
    // 当 valid 与 need 个数相同时，找到可行解
    var valid = 0
    // 子串索引
    var start = 0
    var length = Int.max
    
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
        if (need[c] != nil) {
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
        while valid == need.count {
            // 更新最小覆盖子串
            if (right - left < length) {
                start = left
                length = right - left
            }
            
            // d 是将移出窗口的字符
            let index = s.index(s.startIndex, offsetBy: left)
            let d = String(s[index])
            // 左移窗口
            left += 1
            // 数据更新
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
    
    let startIndex = s.index(s.startIndex, offsetBy: start)
    let endIndex = s.index(startIndex, offsetBy: length)
    return String(length == Int.max ? "" : s[startIndex..<endIndex])
}
