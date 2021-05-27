//
//  _015_rob2.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/24.
//

import Foundation

/*
 强盗依然不能抢劫相邻的房子，输入依然是一个数组，但是告诉你这些房子不是一排，而是围成了一个圈
 */

func rob_v5(_ nums: [Int]) -> Int {
    let n = nums.count
    if n == 1 { return nums[0] }
    return max(rob(nums, 0, n-2), rob(nums, 1, n-1))
}

func rob(_ nums: [Int], _ start: Int,
         _ end: Int) -> Int{
    var dp_i_1 = 0
    var dp_i_2 = 0
    var dp_i = 0
    var i = end
    while i >= start {
        dp_i = max(dp_i_1, nums[i] + dp_i_2)
        dp_i_2 = dp_i_1
        dp_i_1 = dp_i
        i -= 1
    }
    return dp_i
}

/*
 此强盗发现现在面对的房子不是一排，不是一圈，而是一棵二叉树！房子在二叉树的节点上，相连的两个房子不能同时被抢劫：
 */

extension TreeNode: Hashable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs === rhs
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
    }
}

var cache: [TreeNode:Int] = [:]
func rob_(_ root: TreeNode?) -> Int {
    guard let r = root else {
        return 0
    }
    // 缓存
    if cache[r] != nil {
        return cache[r]!
    }
    // 抢
    let le = r.left == nil ? 0 :
        rob_(r.left?.left) + rob_(r.left?.right)
    let ri = r.right == nil ? 0 :
        rob_(r.right?.left) + rob_(r.right?.right)
    let do_it = r.val + le + ri
    // 不抢
    let not = rob_(r.left) + rob_(r.right)
    let res = max(do_it, not)
    cache[r] = res
    return res
}

func test_rob_() {
    do {
        let t1 = TreeNode(3)
        let t2 = TreeNode(2)
        let t3 = TreeNode(3)
        let t4 = TreeNode(3)
        let t5 = TreeNode(1)
        
        t1.left = t2
        t1.right = t3
        t2.right = t4
        t3.right = t5
        
        print(rob_(t1))
        print(rob_v6(t1))
    }
    
    do {
        let t1 = TreeNode(3)
        let t2 = TreeNode(4)
        let t3 = TreeNode(5)
        let t4 = TreeNode(1)
        let t5 = TreeNode(3)
        let t6 = TreeNode(1)
        
        t1.left = t2
        t1.right = t3
        t2.left = t4
        t2.right = t5
        t3.right = t6
        
        print(rob_(t1))
        print(rob_v6(t1))
    }
}

/*
 arr[0] 表示不抢 root 的话，得到的最大钱数
 arr[1] 表示抢 root 的话，得到的最大钱数
 */
func rob_v6(_ root: TreeNode) -> Int {
    func dp(_ root: TreeNode?) -> [Int] {
        guard let r = root else {
            return [0, 0]
        }
        
        let left = dp(r.left)
        let right = dp(r.right)
        // 抢，下家就不能抢了
        let rob = r.val + left[0] + right[0]
        // 不抢，下家可抢可不抢，取决于收益大小
        let not = max(left[0], left[1]) +
                  max(right[0], right[1])
        
        return [not, rob]
    }
    
    let res = dp(root)
    return max(res[0], res[1])
}


