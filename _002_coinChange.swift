//
//  _002_coinChange.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/10.
//  凑零钱问题

import Foundation

/*
 给你 k 种面值的硬币，面值分别为c1, c2 ... ck，
 每种硬币的数量无限，再给一个总金额amount，
 问你最少需要几枚硬币凑出这个金额，如果不可能凑出，算法返回 -1
 */

// 暴力递归
func coinChange_v1(_ coins: [Int], amount: Int) -> Int {
    func recursion(_ n: Int) -> Int {
        if n == 0 { return 0 }
        if n < 0 { return -1 }
        
        var res = Int.max
        for coin in coins {
            let sub = recursion(n - coin)
            if sub == -1 { continue }
            res = min(res, sub + 1)
        }
        
        if res != Int.max {
            return res
        }else{
            return -1
        }
    }
    
    return recursion(amount)
}

// 带备忘录的递归
func coinChange_v2(_ coins: [Int], amount: Int) -> Int {
    var cache = [Int:Int]()
    
    func recursion(_ n: Int) -> Int {
        if let res = cache[n] { return res }
        
        if n == 0 { return 0 }
        if n < 0 { return -1 }
        
        var res = Int.max
        for coin in coins {
            let sub = recursion(n - coin)
            if sub == -1 { continue }
            res = min(res, sub + 1)
        }
        
        if res != Int.max {
            cache[n] = res
        }else{
            cache[n] = -1
        }
        return cache[n]!
    }
    
    return recursion(amount)
}

// 迭代算法
func coinChange_v3(_ coins: [Int], amount: Int) -> Int {
    var cache = [Int](repeating: amount+1, count: amount+1)
    cache[0] = 0
    
    for i in 0..<cache.count {
        for coin in coins {
            if i - coin < 0 { continue }
            cache[i] = min(cache[i], cache[i - coin] + 1)
        }
    }
    
    if cache[amount] == amount + 1 {
        return -1
    }
    
    return cache[amount]
}
