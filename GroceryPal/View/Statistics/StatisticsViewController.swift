//
//  StatisticsViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 12/28/20.
//  Copyright © 2020 iit. All rights reserved.
//

import UIKit
import Charts

protocol StatisticsViewControllerDelegate {
    func displayStockReleatedData(reStockCount: Double, expiredCount: Double, inStockCount: Double)
    func displayCatgeoryUsageData(categoryUsage: Dictionary<String, Double>)
}

class StatisticsViewController: UIViewController, StatisticsViewControllerDelegate {
    
    @IBOutlet weak var chartView1: PieChartView!
    
    @IBOutlet weak var chartView2: PieChartView!
    
    @IBOutlet weak var chartView3: BarChartView!
    
    @IBOutlet weak var chartView4: PieChartView!
    
    
    //Stock and Expired chart data
    var pieChartEntryInstock = PieChartDataEntry(value: 0)
    var pieChartEntryOutOfStock = PieChartDataEntry(value: 0)
    var pieChartEntryExpired = PieChartDataEntry(value: 0)
    var pieChartEntryNotExpired = PieChartDataEntry(value: 0)
    var inStockItemCount:Double = 0
    var outStockItemCount:Double = 0
    var expiredItemCount:Double = 0
    var notExpiredItemCount:Double = 0
    
    
    var pieChartTotalStockDataEntry = [PieChartDataEntry]()
    var pieChartTotalExpiredDataEntry = [PieChartDataEntry]()
    
    //Category usage chart data
    var pieChartEntryMeatUsage = PieChartDataEntry(value: 0)
    var pieChartEntryVegetableUsage = PieChartDataEntry(value: 0)
    var pieChartEntryFruitUsage = PieChartDataEntry(value: 0)
    var pieChartEntryBeverageUsage = PieChartDataEntry(value: 0)
    var pieChartEntryBakeryUsage = PieChartDataEntry(value: 0)
    var meatUsage:Double = 0
    var vegetableUsage:Double = 0
    var fruitUsage:Double = 0
    var beverageUsage:Double = 0
    var bakeryUsage:Double = 0
    
    
    var pieChartEntryCategoryUsage = [PieChartDataEntry]()
    let staticticsVM = StaticticsVM()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        staticticsVM.delegate = self
        staticticsVM.getStockQueries()
        staticticsVM.getCategoryUsageQueries()
        setData()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    func  setChartData()  {
        
        expiredItemCount = 2
        notExpiredItemCount = 20
        inStockItemCount = 30
        outStockItemCount = 10
        
        meatUsage = 10
        vegetableUsage = 40
        fruitUsage = 20
        beverageUsage = 10
        bakeryUsage = 20
        
    }
    
    func setData( ) {
        
        setChartData()
        
        //Stock data
        pieChartEntryInstock.value = inStockItemCount
        pieChartEntryInstock.label = "InStock"
        pieChartEntryOutOfStock.value = outStockItemCount
        pieChartEntryOutOfStock.label = "OutStock"
        pieChartTotalStockDataEntry = [pieChartEntryInstock,pieChartEntryOutOfStock]
        
        
        //Expired data
        pieChartEntryNotExpired.value = expiredItemCount
        pieChartEntryNotExpired.label = "NotExpired"
        pieChartEntryExpired.value = notExpiredItemCount
        pieChartEntryExpired.label = "Expired"
        pieChartTotalExpiredDataEntry = [pieChartEntryNotExpired,pieChartEntryExpired]
        
        //Category usage of month
        pieChartEntryMeatUsage.value = meatUsage
        pieChartEntryMeatUsage.label = "Meat"
        pieChartEntryVegetableUsage.value = vegetableUsage
        pieChartEntryVegetableUsage.label = "Vegetable"
        pieChartEntryFruitUsage.value = fruitUsage
        pieChartEntryFruitUsage.label = "Fruit"
        pieChartEntryBeverageUsage.value = beverageUsage
        pieChartEntryBeverageUsage.label = "Beverage"
        pieChartEntryBakeryUsage.value = bakeryUsage
        pieChartEntryBakeryUsage.label = "Bakery"
        pieChartEntryCategoryUsage = [pieChartEntryMeatUsage,pieChartEntryVegetableUsage,pieChartEntryFruitUsage,pieChartEntryBeverageUsage,pieChartEntryBakeryUsage]
        
        
        //Set chart data stocks
        let stockDataSet = PieChartDataSet(entries: pieChartTotalStockDataEntry, label: nil)
        let stockData = PieChartData(dataSet: stockDataSet)
        
        let colors = [UIColor.green,UIColor.red]
        stockDataSet.colors = colors
        chartView1.data = stockData
        chartView1.animate(xAxisDuration: 2.5)
        chartView1.entryLabelFont = .boldSystemFont(ofSize: 10)
        chartView1.entryLabelColor = .black
        chartView1.data?.setValueTextColor( .black)
        
       let expiredDataSet = PieChartDataSet(entries: pieChartTotalExpiredDataEntry,label: nil)
       let expiredData = PieChartData(dataSet: expiredDataSet)
        let colors2 = [UIColor.blue,UIColor.orange]
        expiredDataSet.colors = colors2
        chartView2.data = expiredData
        chartView2.animate(xAxisDuration: 3)
        chartView2.entryLabelFont = .boldSystemFont(ofSize: 10)
        chartView2.entryLabelColor = .black
        chartView2.data?.setValueTextColor(.black)
        
        
        let set3 = BarChartDataSet(entries: yValues2,label: "Monthly Grocery Expenses")
        set3.colors = [UIColor.purple]
        let data3 = BarChartData(dataSet: set3)
        chartView3.data = data3
        chartView3.xAxis.labelPosition = .bottom
        chartView3.rightAxis.enabled = false
        chartView3.animate(xAxisDuration: 3.1)
        
        let categoryUsageDataSet = PieChartDataSet(entries: pieChartEntryCategoryUsage, label: nil)
        let categoryUsageData = PieChartData(dataSet: categoryUsageDataSet)
        let colors5 = [UIColor.red,UIColor.green,UIColor.yellow,UIColor.blue,UIColor.orange]
        categoryUsageDataSet.colors = colors5
        chartView4.data = categoryUsageData
        chartView4.animate(xAxisDuration: 3.2)
        chartView4.entryLabelFont = .boldSystemFont(ofSize: 10)
        chartView4.entryLabelColor = .black
        chartView4.data?.setValueTextColor(.black)
        
        
    }
    
    
    let yValues2: [BarChartDataEntry] = [
        BarChartDataEntry(x: 1, y: 100, data: "Jan"),
        BarChartDataEntry(x: 2, y: 99, data: "Feb"),
        BarChartDataEntry(x: 3, y: 80, data: "Mar"),
        BarChartDataEntry(x: 4, y: 90, data: "Apr"),
        BarChartDataEntry(x: 5, y: 101, data: "May"),
        BarChartDataEntry(x: 6, y: 105, data: "Jun"),
        BarChartDataEntry(x: 7, y: 100, data: "Jul"),
        BarChartDataEntry(x: 8, y: 99, data: "Aug"),
        BarChartDataEntry(x: 9, y: 80, data: "Sep"),
        BarChartDataEntry(x: 10, y: 90, data: "Oct"),
        BarChartDataEntry(x: 11, y: 101, data: "Nov"),
        BarChartDataEntry(x: 12, y: 105, data: "Dec")
        
    ]
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func displayStockReleatedData(reStockCount: Double, expiredCount: Double, inStockCount: Double) {
        print("Restock Count",reStockCount,expiredCount,inStockCount)
    }
    
    func displayCatgeoryUsageData(categoryUsage: Dictionary<String, Double>) {
        print("Catgeory Usage",categoryUsage)
    }

}
