//
//  StaticticsVM.swift
//  GroceryPal
//
//  Created by Aparna Prasad on 1/16/21.
//  Copyright © 2021 iit. All rights reserved.
//

import Foundation


class StaticticsVM {
    
    var delegate: StatisticsViewControllerDelegate?
    let dispatch = DispatchGroup()
    var fireStoreStatisticsQueries = FireStoreStatisticsQueries()

    func getStockQueries()
    {
        var reStockCountMain : Double = 0
        var inStockCountMain: Double = 0
        var expiredCountMain: Double = 0

        dispatch.enter()
        fireStoreStatisticsQueries.fetchRestockItems(){
            restockCount in
            reStockCountMain = restockCount
            self.dispatch.leave()
        }
        
        dispatch.enter()
        fireStoreStatisticsQueries.fetchActiveItems(){
            activeCount in
            inStockCountMain = activeCount
            self.dispatch.leave()
        }
        
        dispatch.enter()
        fireStoreStatisticsQueries.fetchExpiredItems(){
            expiredCount in
            expiredCountMain = expiredCount
            self.dispatch.leave()
        }
        
        dispatch.notify(queue: DispatchQueue.main) {
            self.delegate?.displayStockReleatedData(reStockCount: reStockCountMain, expiredCount: expiredCountMain, inStockCount: expiredCountMain+inStockCountMain)
        }
    }
    
    
    func getCategoryUsageQueries()
    {
        fireStoreStatisticsQueries.fetchCategoryUsage(){
            categoryUsage in
            self.delegate?.displayCatgeoryUsageData(categoryUsage: categoryUsage)
        }
    }
}
