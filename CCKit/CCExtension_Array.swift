//
//  CCKit_Array_Extension.swift
//  CCKitDemo
//
//  Created by 史晓义 on 2019/7/12.
//  Copyright © 2019 Tomas. All rights reserved.
//

import UIKit

extension Array
{
    //切牌，从0到n切到末尾，只循环切换首尾，前后相邻顺序不变，O(n^2)
    @inlinable mutating func cutTopToLast(in cutIndex:Int)
    {
        if self.count <= 0
            || cutIndex == 0
        {
            return
        }
        for _ in 0...cutIndex {
            self.append(self.first!)
            self.removeFirst()
        }
    }
}
