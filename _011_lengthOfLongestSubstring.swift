//
//  _011_lengthOfLongestSubstring.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/18.
//

import Foundation

/*
 给定一个字符串，请你找出其中不含有重复字符的最长子串的长度。
 示例1:
 输入: "abcabcbb"
 输出: 3
 解释:因为无重复字符的最长子串是"abc", 所以其长度为3。
 
 示例2:
 输入: "bbbb"
 输出: 1
 解释:因为无重复字符的最长子串是"b"， 所以其长度为1。
 
 示例3:
 输入: "pwwkew"
 输出: 3
 解释:因为无重复字符的最长子串是"wke", 所以其长度为3。
 请注意，你的答案必须是子串的长度，"pwke"是一个子序列，不是子串。
 */

func lengthOfLongestSubstring(_ s: String) -> Int {
    var window: [Character:Int] = [:]
    var left = 0
    var right = 0
    var res = 0 // 记录结果
    while right < s.count {
        let index = s.index(s.startIndex, offsetBy: right)
        let c = s[index]
        right += 1
        
        if window[c] != nil {
            window[c]! += 1
        }else{
            window[c] = 1
        }
        // 判断左侧窗口是否要收缩
        while window[c]! > 1 {
            let index = s.index(s.startIndex, offsetBy: left)
            let d = s[index]
            left += 1
            
            window[d]! -= 1
        }
        // 在这里更新答案
        res = max(res, right - left)
    }
    return res
}
