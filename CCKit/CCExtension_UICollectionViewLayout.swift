//
//  CCExtension_UICollectionViewLayout.swift
//  CCKitDemo
//
//  Created by 史晓义 on 2019/8/9.
//  Copyright © 2019 Tomas. All rights reserved.
//

import UIKit



extension UICollectionViewLayout
{
    /// - 获取竖向布局的最后一个下标(可见视图内)
    // 只有一个section时有效，多个section需要根据业务逻辑重新扩展
    func cc_indexPathForLast(in line:Int) -> Int
    {
        var currentLine = 1
        var lastIndex = 0
        // 获取系统帮我们计算好的Attributes
        let rectItems = layoutAttributesForElements(in: collectionView?.bounds ?? .zero) ?? []
        if rectItems.count > 1 {
            //超过1
        } else {
            return lastIndex
        }
        // 遍历结果
        for item in 1..<rectItems.count {
            //head直接过滤
            if rectItems[item].representedElementKind == UICollectionView.elementKindSectionHeader
            {
                continue
            }
            
            let preY = rectItems[item - 1].frame.origin.y
            let curY = rectItems[item].frame.origin.y
            // 如果当前cell和precell在同一行
            if(preY == curY)
            {
                lastIndex = item
            } else {
                currentLine += 1
                if currentLine > line {
                    return lastIndex
                }
            }
        }
        return lastIndex
    }
}
