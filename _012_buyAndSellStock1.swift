//
//  _012_buyAndSellStock1.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/19.
//

import Foundation

/*
 给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格
 如果你最多只允许完成一笔交易(即买入和卖出一支股票)， 设计一个算法来计算你所能获取的最大利润。
 注意你不能在买入股票前卖出股票。

 示例1:
 输入: [7,1,5,3,6,4]
 输出: 5
 解释:在第2天(股票价格=1)的时候买入，在第5天(股票价格=6)的时候卖出，最大利润= 6-1 = 5
 注意利润不能是7-1 = 6，因为卖出价格需要大于买入价格。

 示例2:
 输入: [7,6,4,3,1]
 输出: 0
 解释:在这种情况下，没有交易完成，所以最大利润为0。
 */

func buyAndSellStock_v1(_ prices: [Int]) -> Int {
    var res = 0
    for buy in 0..<prices.count {
        for sell in buy+1..<prices.count {
            res = max(res, prices[sell] - prices[buy])
        }
    }
    return res
}

func buyAndSellStock_v2(_ prices: [Int]) -> Int {
    var res = 0
    var cur = prices[0]
    for sell in 1..<prices.count {
        cur = min(cur, prices[sell])
        res = max(res, prices[sell] - cur)
    }
    return res
}
