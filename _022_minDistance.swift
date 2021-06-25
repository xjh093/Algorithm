//
//  _022_minDistance.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/6/25.
//

import Foundation

/*
 编辑距离

 给定两个字符串 s1 和 s2, 计算出将 s1 转换成 s2 所使用的最少操作数

 你可以对一个字符串进行如下三种操作:
 1.插入一个字符
 2.删除一个字符
 3.替换一个字符

 示例1:
 输入: s1 = "horse", s2 ="ros"
 输出:3
 解释:
 horse -> rorse ('h'替换为'r')
 rorse -> rose (删除'r')
 rose -> ros (删除'e')

 示例2:
 输入: s1="intention", s2 = "execution"
 输出: 5
 解释:
 intention -> inention (删除't')
 inention -> enention (将'i'替换为'e')
 enention -> exention (将'n'替換为'x')
 exention-> exection (将'n'替换为'c')
 exection -> execution (插入'u')
 
 */

// 递归方式
func minDistance_v1(_ s1: String, _ s2: String) -> Int {
    var cache = [String: Int]()
    
    func dp(_ i: Int, _ j: Int) -> Int {
        let key = "\(i),\(j)"
        let val = cache[key]
        if val != nil {
            return val!
        }
        
        if i == -1 { return j + 1 }
        if j == -1 { return i + 1 }
        
        let index1 = s1.index(s1.startIndex, offsetBy: i)
        let index2 = s2.index(s2.startIndex, offsetBy: j)
        if s1[index1] == s2[index2] {
            cache[key] = dp(i - 1, j - 1)
        }else{
            cache[key] = min(dp(i, j - 1) + 1,
                             dp(i - 1, j) + 1,
                             dp(i - 1, j - 1) + 1)
        }
        return cache[key]!
    }
    
    return dp(s1.count - 1, s2.count - 1)
}

// 迭代方式
func minDistance_v2(_ s1: String, _ s2: String) -> Int {
    let m = s1.count, n = s2.count
    // base case
    let sub = [Int](repeating: 0, count: n + 1)
    var arr = [[Int]](repeating: sub, count: m + 1)
    for i in 1...m { arr[i][0] = i }
    for j in 1...n { arr[0][j] = j }
    
    // 自底向上求解
    for i in 1...m {
        for j in 1...n {
            let idx1 = s1.index(s1.startIndex, offsetBy: i-1)
            let idx2 = s2.index(s2.startIndex, offsetBy: j-1)
            
            if s1[idx1] == s2[idx2] {
                arr[i][j] = arr[i-1][j-1]
            }else{
                arr[i][j] = min(arr[i-1][j] + 1,
                                arr[i][j-1] + 1,
                                arr[i-1][j-1] + 1)
            }
        }
    }
    return arr[m][n]
}

func test22() {
    do {
        let s1 = "horse", s2 = "ros"
        print(minDistance_v1(s1, s2))
        print(minDistance_v2(s1, s2))
    }
    do {
        let s1 = "intention", s2 = "execution"
        print(minDistance_v1(s1, s2))
        print(minDistance_v2(s1, s2))
    }
}
