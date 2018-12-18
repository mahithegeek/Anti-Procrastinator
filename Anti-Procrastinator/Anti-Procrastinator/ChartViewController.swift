//
//  ChartViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 11/12/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import UIKit
import SwiftCharts

class ChartViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.chartView?.noDataText = "Nothing to show Yet!!!"

        // Do any additional setup after loading the view.
        setChart()
    }
    
    func setChart(){
        //var data : [BarChartDataEntry] = []
        
        let pomos = StorageLayer.sharedInstance.getPomodoroRecords()
        var pomodoroDict = [String:Int]()
        
        
        for pomodoro in pomos {
            //let dataEntry = BarChartDataEntry(
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let date = dateFormatter.string(from: pomodoro.dateCompleted!)
            
            guard let value = pomodoroDict[date]
                else{
                pomodoroDict[date] = 1
                    continue
            }
            
            pomodoroDict[date] = value + 1
            
        }
        
        let chartConfig = BarsChartConfig(valsAxisConfig: ChartAxisConfig(from: 0, to: 16, by: 1))
        
        let frame = CGRect(x:0,y:70,width : 300,height:500)
        let chart = BarsChart(frame: frame, chartConfig: chartConfig, xTitle: "Month", yTitle: "No. of Pomodoros", bars: [
            ("A", 2),
            ("B", 4.5),
            ("C", 3),
            ("D", 5.4),
            ("E", 6.8),
            ("F", 0.5)
            ], color: UIColor.red, barWidth: 20
        )
        
        self.view.addSubview(chart.view)
        
//        var i = 0.0
//        var dates : [String] = []
//        for (date,count) in pomodoroDict {
//
//           // let dataEntry = BarChartDataEntry(x: i, yValues: Double(exactly: count))
//            let dataEntry = BarChartDataEntry(x: i, y: Double(exactly: count)!)
//            data.append(dataEntry)
//            dates.append(date)
//            i += 1
//        }
//
//        let chartDataSet = BarChartDataSet(values: data, label: "Pomodoro completed")
//        let chartData = BarChartData(dataSets: [chartDataSet])
//        self.chartView?.data = chartData
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
