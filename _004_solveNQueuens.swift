//
//  _004_solveNQueuens.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/11.
//  N 皇后问题
//  给你一个 N×N 的棋盘，让你放置 N 个皇后，使得它们不能互相攻击。皇后可以攻击同一行、同一列、左上左下右上右下四个方向的任意单位。

import Foundation

var result: [[Int]] = []

func solveNQueuens(_ n: Int) -> [[Int]] {
    // 数量为 n 的数组
    let row = [Int](repeating: 0, count: n)
    // NxN 的二维数组
    var board = [[Int]](repeating: row, count: n)
    _backTrack(&board, 0)
    return result
}

func _backTrack(_ board: inout [[Int]], _ row: Int) {
    // 触发结束条件
    if row == board.count {
        result.append(contentsOf: board)
        return
    }
    
    let n = board[row].count
    for col in 0..<n {
        if !isValid(&board, row, col) {
            continue
        }
        
        board[row][col] = 1 // 做选择
        _backTrack(&board, row+1) // 进入下一层
        board[row][col] = 0 // 撤消选择
    }
}

func isValid(_ board: inout [[Int]], _ row: Int, _ col: Int) -> Bool {
    let n = board.count
    
    // 检查列冲突
    for i in 0..<n {
        if board[i][col] == 1 { return false }
    }
    
    // 检查右上方是否冲突
    var i = row - 1
    var j = col + 1
    while i >= 0 && j < n {
        if board[i][j] == 1 { return false }
        i -= 1
        j += 1
    }
    
    // 检查左上方是否冲突
    i = row - 1
    j = col - 1
    while  i >= 0 && j >= 0 {
        if board[i][j] == 1 { return false }
        i -= 1
        j -= 1
    }
    
    return true
}
