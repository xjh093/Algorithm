//
//  _20_ invertTree.swift
//  AlgorithmNotes
//
//  Created by HaoCold on 2021/6/18.
//

import Foundation

/*
 输入一个二叉树根节点 root，把整棵树镜像翻转
 
 只要把二叉树上的每一个节点的左右子节点进行交换，最后的结果就是完全翻转之后的二叉树
 */

func invertTree(_ root: TreeNode?) -> TreeNode? {
    guard let root = root else {
        return nil
    }
    
    // 前序遍历
    // 交换左右节点
    (root.left, root.right) = (root.right, root.left)
    
    // 递归操作子节点
    invertTree(root.left)
    invertTree(root.right)
    
    return root
}

/*
 
 将二叉树展开为链表
 
 操作流程：
 a、将 root 的左子树和右子树拉平
 b、将 root 的右子树接到左子树下方，然后将整个左子树作为右子树
 
 */
func flatten(_ root: TreeNode?) {
    guard let root = root else {
        return
    }
    
    flatten(root.left)
    flatten(root.right)
    
    // 后序遍历
    // 左右子树已经被拉平成一条链表
    let left = root.left
    let right = root.right
    
    // 将左子树作为右子树
    root.left = nil
    root.right = left
    
    // 将原先的右子树接到当前右子树的末端
    var t = root
    while t.right != nil {
        t = t.right!
    }
    t.right = right
}
