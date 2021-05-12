//
//  _006_openLock.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/12.
//  打开转盘锁

/*
 你有一个带有四个圆形拨轮的转盘锁。每个拨轮都有10个数字: '0'， '1'， '2'， '3'， ‘4', '5','6'，'7'，'8'，'9'
 每个拨轮可以自由旋转:例如把'9'变为'0'， '0'变为'9'
 每次旋转都只能旋转一个拨轮的一位数字
 锁的初始数字为'0000' ，一个代表四个拨轮的数字的字符串
 列表deadends 包含了一组死亡数字，一旦拨轮的数字和列表里的任何一个元素相同，这个锁将会被永久锁定，无法再被旋转
 字符串 target 代表可以解锁的数字，你需要给出最小的旋转次数，如果无论如何不能解锁，返回-1
 */

import Foundation

func openLock(_ deadends: [String], _ target: String) -> Int {
    // 需要跳过的死亡密码
    let deads = Set(deadends)
    // 记录穷举过的密码，防止走回头路
    var visited = Set<String>()
    visited.insert("0000")
    
    var queue = [String]()
    queue.append("0000")
    
    var step = 0
    
    while !queue.isEmpty {
        var tmp = [String]()
        
        // 向所有节点扩散
        for cur in queue {
            // 是否到达终点
            if deads.contains(cur) { continue }
            if cur == target { return step }
            
            // 将一个节点未遍历相信节点加入队列
            for i in 0..<4 {
                let up = plusOne(cur, i)
                if !visited.contains(up) {
                    tmp.append(up)
                    visited.insert(up)
                }
                
                let down = minusOne(cur, i)
                if !visited.contains(down) {
                    tmp.append(down)
                    visited.insert(down)
                }
            }
        }
        queue = tmp
        step += 1
    }
    // 穷举完都找不到
    return -1
}

func plusOne(_ s: String, _ i: Int) -> String {
    var arr = [Int]()
    for c in s { arr.append(c.hexDigitValue!) }
    if arr[i] == 9 { arr[i] = 0 }
    else { arr[i] += 1}
    var out = ""
    for i in arr { out += "\(i)"}
    return out
}

func minusOne(_ s: String, _ i: Int) -> String {
    var arr = [Int]()
    for c in s { arr.append(c.hexDigitValue!) }
    if arr[i] == 0 { arr[i] = 9 }
    else { arr[i] -= 1 }
    var out = ""
    for i in arr { out += "\(i)"}
    return out
}
