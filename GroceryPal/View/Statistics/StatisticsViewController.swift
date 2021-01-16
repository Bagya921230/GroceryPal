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
    func displayStockReleatedData(reStockCount: Double, expiredCount: Double, inStockCount: Double, nonExpiredCount: Double)
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
    var pieChartEntryDairyUsage = PieChartDataEntry(value: 0)
    var pieChartEntryGrainsUsage = PieChartDataEntry(value: 0)
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
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    func  setChartData( _ expredCount:Double, _ notExpiredCount:Double, _ instockCount:Double , _ outStockCount:Double)  {
        
        print("chamil",expredCount,notExpiredCount,instockCount,outStockCount)
        expiredItemCount = expredCount
        notExpiredItemCount = notExpiredCount
        inStockItemCount = instockCount
        outStockItemCount = outStockCount
        
        meatUsage = 10
        vegetableUsage = 40
        fruitUsage = 20
        beverageUsage = 10
        bakeryUsage = 20
        
    }
    func setCategoryUsage( _ categoryUsageData: Dictionary<String, Double> )
    {
         let meatUsage:Double? = categoryUsageData["Meat"]
         let vegetableUsage:Double? = categoryUsageData["Vegetables"]
         let fruitUsage:Double? = categoryUsageData["Fruits"]
         let dairyeUsage:Double? = categoryUsageData["Dairy"]
         let grainsUsage:Double? = categoryUsageData["Grains"]
     
        //Category usage of month
        pieChartEntryMeatUsage.value = meatUsage!
        pieChartEntryMeatUsage.label = "Meat"
        pieChartEntryVegetableUsage.value = vegetableUsage!
        pieChartEntryVegetableUsage.label = "Vegetable"
        pieChartEntryFruitUsage.value = fruitUsage!
        pieChartEntryFruitUsage.label = "Fruit"
        pieChartEntryDairyUsage.value = dairyeUsage!
        pieChartEntryDairyUsage.label = "Dairy"
        pieChartEntryGrainsUsage.value = grainsUsage!
        pieChartEntryGrainsUsage.label = "Grains"
        pieChartEntryCategoryUsage = [pieChartEntryMeatUsage,pieChartEntryVegetableUsage,pieChartEntryFruitUsage,pieChartEntryDairyUsage,pieChartEntryGrainsUsage]
        
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
    
    func setData(_ expredCount:Double, _ notExpiredCount:Double, _ instockCount:Double , _ outStockCount:Double ) {
        
        
        
        //Stock data
        pieChartEntryInstock.value = instockCount
        pieChartEntryInstock.label = "InStock"
        pieChartEntryOutOfStock.value = outStockCount
        pieChartEntryOutOfStock.label = "OutStock"
        pieChartTotalStockDataEntry = [pieChartEntryInstock,pieChartEntryOutOfStock]
        
        
        //Expired data
        pieChartEntryNotExpired.value = notExpiredCount
        pieChartEntryNotExpired.label = "NotExpired"
        pieChartEntryExpired.value = expredCount
        pieChartEntryExpired.label = "Expired"
        pieChartTotalExpiredDataEntry = [pieChartEntryNotExpired,pieChartEntryExpired]
        
        
        
        
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
        
        
        
        
    }
    
    //Dummy data for monthly expenses
    let yValues2: [BarChartDataEntry] = [
        BarChartDataEntry(x: 1, y: 30000, data: "Jan"),
        BarChartDataEntry(x: 2, y: 35000, data: "Feb"),
        BarChartDataEntry(x: 3, y: 33000, data: "Mar"),
        BarChartDataEntry(x: 4, y: 25000, data: "Apr"),
        BarChartDataEntry(x: 5, y: 40000, data: "May"),
        BarChartDataEntry(x: 6, y: 36000, data: "Jun"),
        BarChartDataEntry(x: 7, y: 34000, data: "Jul"),
        BarChartDataEntry(x: 8, y: 38000, data: "Aug"),
        BarChartDataEntry(x: 9, y: 41000, data: "Sep"),
        BarChartDataEntry(x: 10, y: 29000, data: "Oct"),
        BarChartDataEntry(x: 11, y: 31000, data: "Nov"),
        BarChartDataEntry(x: 12, y: 37000, data: "Dec")
        
    ]
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func displayStockReleatedData(reStockCount: Double, expiredCount: Double, inStockCount: Double, nonExpiredCount: Double) {
        print("Restock Count",reStockCount,expiredCount,inStockCount, nonExpiredCount)
        //setChartData(reStockCount,inStockCount,nonExpiredCount,expiredCount)
        //setData(_ expredCount:Double, _ notExpiredCount:Double, _ instockCount:Double , _ outStockCount:Double )
        setData(expiredCount,expiredCount,inStockCount,reStockCount)
    }
    
    func displayCatgeoryUsageData(categoryUsage: Dictionary<String, Double>) {
        print("Catgeory Usage",categoryUsage)
        setCategoryUsage(categoryUsage)
        
    }

}
