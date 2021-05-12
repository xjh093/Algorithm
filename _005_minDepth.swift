//
//  _005_minDepth.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/5/12.
//  二叉树的最小高度

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

func minDepth(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    
    var depth = 1 // 深度
    var queue: [TreeNode] = []
    queue.append(root)
    
    while !queue.isEmpty {
        var tmp: [TreeNode] = []
        
        for node in queue {
            if node.left == nil && node.right == nil {
                return depth
            }
            
            if let left = node.left {
                tmp.append(left)
            }
            if let right = node.right {
                tmp.append(right)
            }
        }
        
        queue = tmp
        depth += 1
    }
    
    return depth
}
