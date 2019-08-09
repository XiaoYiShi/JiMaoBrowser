//
//  extension_UserDefaults.swift
//  browser
//
//  Created by 史晓义 on 2018/5/24.
//  Copyright © 2018年 Yi. All rights reserved.
//

import UIKit

extension UserDefaults {
    struct Ex {
        struct name {
            static let searchHistory = "ex_searchHistory"
            static let browseHistory = "ex_browseHistory"
            static let morePages     = "ex_morePages"
            static let pornographicFilm     = "pornographicFilm"//色情
        }
        struct object {
            //搜索历史
            static var searchHistorys = UserDefaults.standard.array(forKey: UserDefaults.Ex.name.searchHistory) as! [String]? ?? []
            {
                didSet
                {
                    UserDefaults.standard.set(searchHistorys, forKey: UserDefaults.Ex.name.searchHistory)
                }
            }
            //浏览历史
            static var browseHistorys = UserDefaults.standard.array(forKey: UserDefaults.Ex.name.browseHistory) as [AnyObject]? ?? []
            {
                didSet
                {
                    UserDefaults.standard.set(browseHistorys, forKey: UserDefaults.Ex.name.browseHistory)
                }
            }
            //分页
            static var morePages = UserDefaults.standard.array(forKey: UserDefaults.Ex.name.morePages) as [AnyObject]? ?? []
            {
                didSet
                {
                    UserDefaults.standard.set(morePages, forKey: UserDefaults.Ex.name.morePages)
                }
            }
            static var pornographicFilm = UserDefaults.standard.bool(forKey: UserDefaults.Ex.name.pornographicFilm)
            {
                didSet
                {
                    UserDefaults.standard.set(pornographicFilm, forKey: UserDefaults.Ex.name.pornographicFilm)
                }
            }
        }
    }
}

