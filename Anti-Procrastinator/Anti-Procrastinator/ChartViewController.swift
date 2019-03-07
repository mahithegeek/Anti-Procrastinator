//
//  ChartViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 11/12/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    
    @IBOutlet weak var barChartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.chartView?.noDataText = "Nothing to show Yet!!!"

        // Do any additional setup after loading the view.
        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(dataPoints: months, values: unitsSold)
    }
    
    
    func setChart(dataPoints : [String], values : [Double]){
        
        
        let xAxis  = self.barChartView.xAxis
        xAxis.labelPosition = .bottom
       
        //xAxis.labelFont = //[UIFont systemFontOfSize:10.f];
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 1.0; // only intervals of 1 day
        xAxis.granularityEnabled = true
        xAxis.labelCount = 7;
        xAxis.valueFormatter = DayAxisValueFormatter(chart: self.barChartView)
        
        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: self.barChartView.xAxis.valueFormatter!)
        marker.chartView = self.barChartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        self.barChartView.marker = marker
        
        var dataEntries : [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: values[i], y: Double(exactly: i) ?? 0)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSets: [chartDataSet])
        chartData.barWidth = 0.9
        self.barChartView.data = chartData
        
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
