//
//  _001_fib.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/10.
//  斐波那契数列

import Foundation

/*
 从第3项开始，每一项都等于前两项之和
 求出第 n 项是多少？
 
 1，1，2，3，5，8，13，21......
 
 */

// 暴力递归
// 存在大量重复计算
func fib_v1(_ n: Int) -> Int {
    if n == 1 || n == 2 {
        return 1
    }
    return fib_v1(n - 1) + fib_v1(n - 2)
}

// 带备忘录的递归
// 通过缓存，减少了重复计算
func fib_v2(_ n: Int) -> Int {
    if n < 1 { return 0 }
    
    var cache = [Int](repeating: 0, count: n+1)
    func subFib(_ n: Int) -> Int {
        if n == 1 || n == 2 { return 1 }
        
        let res = cache[n]
        if res != 0 { return res }
        
        cache[n] = subFib(n - 1) + subFib(n - 2)
        return cache[n]
    }
    
    return subFib(n)
}

// 数组的迭代解法，自底向上
// 空间复杂度：O(N)
func fib_v3(_ n: Int) -> Int {
    var cache = [Int](repeating: 0, count: n+1)
    cache[1] = 1
    cache[2] = 1
    for i in 3...n {
        cache[i] = cache[i - 1] + cache[i - 2]
    }
    return cache[n]
}

// 进一步优化，当前状态只和之前的 2 个状态有关
func fib_v4(_ n: Int) -> Int {
    if n == 1 || n == 2 {
        return 1
    }
    
    var pre = 1, cur = 1
    for _ in 3...n {
        let sum = pre + cur
        pre = cur
        cur = sum
    }
    return cur
}
