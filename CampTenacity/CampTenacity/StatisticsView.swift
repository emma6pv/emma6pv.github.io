//
//  StatisticsView.swift
//  CampTenacity
//
//  Created by Emma & Mandy on 2/4/20.
//  Copyright © 2020 Tenacity. All rights reserved.
//

import Foundation
import UIKit
import Charts


/////////////////////////////////////////////
////////Extensions used in this class////////
/////////////////////////////////////////////
extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    //returns the first day of the week
    var startOfWeek: Date? {
        return Calendar.gregorian.date(from: Calendar.gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }

    //returns the last day of the week
    var endOfWeek: Date? {
        if let start = startOfWeek {
            return daysFromNow(days: 6, toDate: start)//Calendar.gregorian.date(byAdding: .day, value: 6, to: start)
        }
        return nil
    }

    /**
        this functions gives me a Date object that represents a date prior to or after a given date

        - parameter days: the number of days before (negative) or after (positive) the given date
        - parameter toDate: the given date

        - returns: a date
    **/
    func daysFromNow(days: Int, toDate: Date) -> Date? {
         return Calendar.gregorian.date(byAdding: .day, value: days, to: toDate)
    }

    /**
        this functions gives me a Date object that represents the same day of the week prior to or after the week of a given date

        - parameter weeks: the number of weeks before (negative) or after (positive) the given date
        - parameter toDate: the given date

        - returns: a date
    **/
    func weeksFromNow(weeks: Int, toDate: Date) -> Date? {
        return daysFromNow(days: 7 * weeks, toDate: toDate)
    }

    /**
        this functions tells me whether a given date is in a future week

        - parameter date: the given date

        - returns: bool
    **/
    func isInFutureWeek(date: Date) -> Bool {
        var today = Date()
        if date > today.endOfWeek! {
            return true
        }
        return false
    }
}




///////////////////////////////
////////StatsView Class////////
///////////////////////////////
class StatisticsView: UIView {
    var barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: 340, height: 340))
    var shownDate = Date() //default is today

    //initWithFrame to init view from code
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
     
    // ** MANDY ** This is where you'll write your code.
    // Inside this setupView function
    // feel free to add helper functions if you need
    // this is just the main function that runs when the class is initialized
    private func setupView() {
        let heightOfView = CGFloat(380) // this is just a random height, you can adjust as needed
        
        self.heightAnchor.constraint(equalToConstant: heightOfView).isActive = true
        
        self.backgroundColor = .white // background color for container view
        barChart.backgroundColor = .white // background color for the chart itself

        updateBarChart()
        self.addSubview(barChart)
    }
    
    /**
        this is where the x- and y-values are defined
    
        - parameter weeksFromNow: an integer that represents the number of weeks from the current week 
                default is 0 = the current week
    **/
    func updateBarChart(weeksFromNow: Int = 0) {
        if Date().isInFutureWeek(date: shownDate.weeksFromNow(weeks: weeksFromNow, toDate: shownDate)!) {
            //prevents users from going to future weeks
            return
        }

        if weeksFromNow != 0 {
        //updates shownDate to represent one of the days of the week to be shown on interface
        //not sure how to use them yet
            shownDate = shownDate.weeksFromNow(weeks: weeksFromNow, toDate: shownDate)!
        }
        
        let playLog = [ ("2/5/20", 55), ("2/4/20", 40), ("2/3/20", 13), ("2/2/20", 5), ("2/1/20", 3) ] //should be retrieved from User
        var dates = getWeekDates(weeksFromNow: weeksFromNow, toDate: shownDate)
        //cycleData should have cycle count in chronological order. 
        //using the playLog above with weeksFromNow = -2, cycleData should be 5.0, 13.0, 40.0, 55.0, 0.0, 0.0, 0.0
        let cycleData = getCycleData(dates: dates, playLog: playLog)
        
        let dummyDates = ["2/2/20", "2/3/20", "2/4/20", "2/5/20", "2/6/20", "2/7/20", "2/8/20"]
        let dummyCycleData = [5.0, 13.0, 40.0, 55.0, 0.0, 0.0, 0.0]
        let dummyXAxisLabels = getDays(dates: dummyDates)
        
        setChartData(dataPoints: dummyDates, values: dummyCycleData)
        setChartStyle(xAxisLabels: dummyXAxisLabels)
        barChart.notifyDataSetChanged()
    }

    /**
        this sets up the BarChartView object with the values inputted

        - parameter dataPoints: this is a list of x-values
        - parameter values: this is a list of y-values
    **/
    private func setChartData(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let dataSet = BarChartDataSet(entries: dataEntries, label: "")
        dataSet.colors = [UIColor(named: "orangeColor")!]
        dataSet.valueFont = (UIFont.chartDrawValue() as NSUIFont)
        dataSet.valueColors = [NSUIColor.gray]

        let data = BarChartData(dataSet: dataSet)
        //data.setDrawValues(false)
        data.barWidth = 0.5
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        barChart.data = data
    }

    private func setChartStyle(xAxisLabels: [String]) {
        //Overall
        barChart.backgroundColor = .white

        
        //No data setup
        barChart.noDataTextColor = .white
        barChart.noDataText = "no data :("
        
        
        //Interactions
        barChart.highlightFullBarEnabled = false
        barChart.doubleTapToZoomEnabled = false
        barChart.highlightPerTapEnabled = false
        barChart.highlightPerDragEnabled = false
        
        
        //Grid format
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.leftAxis.drawGridLinesEnabled = false
        
        
        //Axis formats
                //x-axis
        barChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barChart.xAxis.labelTextColor = .gray
        barChart.xAxis.labelFont = UIFont.chartXAxis()
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisLabels)
        
                //left y-axis
        barChart.leftAxis.enabled = true
        barChart.leftAxis.labelTextColor = .gray
        barChart.leftAxis.labelFont = UIFont.smallText()
        barChart.leftAxis.axisMinimum = 0
        barChart.leftAxis.axisMaximum = 60
        barChart.leftAxis.granularityEnabled = true
        barChart.leftAxis.granularity = 10
        
                //right y-axis
        barChart.rightAxis.enabled = false
        
        
        //Others
        barChart.chartDescription?.enabled = false
        barChart.legend.enabled = false
    }

    private func formatDate(date: Date) -> String {
        let format = DateFormatter()
        format.dateStyle = .short 
        return format.string(from: date)
    }

    /**
        this functions returns all of the dates in a specified week

        - parameter weeksFromNow: the number of weeks before (negative) or after (positive) the given date
        - parameter toDate: the given date

        - returns: an Array of formatted dates in chronological order
    **/
    private func getWeekDates(weeksFromNow: Int, toDate: Date) -> [String] {
        var date = Date().weeksFromNow(weeks: weeksFromNow, toDate: toDate)!
        var start = date.startOfWeek!
        var end = date.endOfWeek!
        var datesOfTargetWeek = [String]()
        
        var dateIterator = start
        
        while dateIterator <= end {
            datesOfTargetWeek.append(formatDate(date: dateIterator))
            dateIterator = Calendar.gregorian.date(byAdding: .day, value: 1, to: dateIterator)!
        }
        
        return datesOfTargetWeek
    }

    /**
        this gives a list of cycle counts as recorded in User's playLog in chronological order for the week requested

        - parameter dates: an Array of String variables that represent formatted dates sorted chronologically
        - parameter playLog: the playLog retrieved from User

        - return: a list of cycle counts
    **/
    private func getCycleData(dates: [String], playLog: [ (String, Int) ]) -> [Double] {
        var workingCopyOfDates = dates
        var datesIndex = 0
        var playLogIndex = 0
        var cycleData = [Double]()

        workingCopyOfDates.sort(by: >) //saturday, friday, thursday, wednesday, tuesday, monday, sunday

        while datesIndex < workingCopyOfDates.count {
            if playLogIndex < playLog.count {
                if workingCopyOfDates[datesIndex] < playLog[playLogIndex].0 {
                    //moves down the play log to find the correct slice we want
                    playLogIndex += 1
                    continue
                }
                else if workingCopyOfDates[datesIndex] == playLog[playLogIndex].0 {
                    //takes the recorded cycles completed in the log if the record exists
                    cycleData.insert(Double(playLog[playLogIndex].1), at: 0)
                    playLogIndex += 1
                }
                else {
                    //otherwise, fills in the blank with 0 (cycles completed)
                    cycleData.insert(0.0, at: 0)
                }
            }
            else {
                //enters here if the date is earlier than the very first record in the play log
                cycleData.insert(0.0, at: 0)
            }
            datesIndex += 1
        }

        return cycleData 
    }

    /**
        this function returns all of the days in the week inputted

        - parameter dates: an Array of formatted String that represents all of the dates in a week

        - return: an Array of String that represents the days of each date given
    **/
    private func getDays(dates: [String]) -> [String] {
        var days = [String]()

        for date in dates {
            let d = String(date).split(whereSeparator: {$0 == "/"} )
            days.append(String(d[1]))
        }
        
        return days
    }
}
