//
//  ChartInteractor.swift
//  ISINChart
//
//  Created by Veaceslav Chirita on 11/14/19.
//  Copyright (c) 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit
import Charts

protocol ChartBusinessLogic {
    func requestData(for period: Int, strategy: String)
}

class ChartInteractor: ChartBusinessLogic {
    var presenter: ChartPresentationLogic?
    
    private var weekDataPrice: ChartData?
    private var monthDataPrice: ChartData?
    private var threeMonthsDataPrice: ChartData?
    private var sixMonthsDataPrice: ChartData?
    private var oneYearDataPrice: ChartData?
    private var twoYearsDataPrice: ChartData?
    
    private var weekDataYield: ChartData?
    private var monthDataYield: ChartData?
    private var threeMonthsDataYield: ChartData?
    private var sixMonthsDataYield: ChartData?
    private var oneYearDataYield: ChartData?
    private var twoYearsDataYield: ChartData?
    
    func requestData(for period: Int, strategy: String) {
        switch period {
        case 0:
            presenter?.presentData(response: getDataForWeek(strategy: strategy))
        case 1:
            presenter?.presentData(response: getDataForMonth(strategy: strategy))
        case 2:
            presenter?.presentData(response: getDataForThreeMonths(strategy: strategy))
        case 3:
            presenter?.presentData(response: getDataForSixMonths(strategy: strategy))
        case 4:
            presenter?.presentData(response: getDataForYear(strategy: strategy))
        case 5:
            presenter?.presentData(response: getDataForTwoYears(strategy: strategy))
        default:
            break
        }
    }
    
    private func getDataForWeek(strategy: String) -> ChartData {
        let months = ["25.09", "26.09", "27.09", "28.09", "29.09", "30.09", "31.09"]
        if strategy == "Yield" {
            getDataAccordingToStrategy(periodDataStrategy: &weekDataYield, strategy: "Yield", xAxisLabels: months)
            return weekDataYield!
        } else {
            getDataAccordingToStrategy(periodDataStrategy: &weekDataPrice, strategy: "Price", xAxisLabels: months)
            return weekDataPrice!
        }
    }
    
    private func getDataForMonth(strategy: String) -> ChartData {
        var months = [String]()
        for i in 0...30 {
            months.append("\(i+1).09")
        }
        if strategy == "Yield" {
            getDataAccordingToStrategy(periodDataStrategy: &monthDataYield, strategy: "Yield", xAxisLabels: months)
            return monthDataYield!
        } else {
            getDataAccordingToStrategy(periodDataStrategy: &monthDataPrice, strategy: "Price", xAxisLabels: months)
            return monthDataPrice!
        }
    }
    
    private func getDataForThreeMonths(strategy: String) -> ChartData {
        let months = ["Jul", "Sep", "Aug"]
        
        if strategy == "Yield" {
            getDataAccordingToStrategy(periodDataStrategy: &threeMonthsDataYield, strategy: "Yield", xAxisLabels: months)
            return threeMonthsDataYield!
        } else {
            getDataAccordingToStrategy(periodDataStrategy: &threeMonthsDataPrice, strategy: "Price", xAxisLabels: months)
            return threeMonthsDataPrice!
        }
    }
    
    private func getDataForSixMonths(strategy: String) -> ChartData {
        let months = ["Apr", "May", "Jun", "Jul", "Sep", "Aug"]
        
        if strategy == "Yield" {
            getDataAccordingToStrategy(periodDataStrategy: &sixMonthsDataYield, strategy: "Yield", xAxisLabels: months)
            return sixMonthsDataYield!
        } else {
            getDataAccordingToStrategy(periodDataStrategy: &sixMonthsDataPrice, strategy: "Price", xAxisLabels: months)
            return sixMonthsDataPrice!
        }
    }
    
    private func getDataForYear(strategy: String) -> ChartData {
        let months = ["Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug"]
        
        if strategy == "Yield" {
            getDataAccordingToStrategy(periodDataStrategy: &oneYearDataYield, strategy: strategy, xAxisLabels: months)
            return oneYearDataYield!
        } else {
            getDataAccordingToStrategy(periodDataStrategy: &oneYearDataPrice, strategy: strategy, xAxisLabels: months)
            return oneYearDataPrice!
        }
    }
    
    private func getDataForTwoYears(strategy: String) -> ChartData {
        let months = [
            "Sep 17", "Oct 17", "Nov 17", "Dec 17", "Jan 18", "Feb 18", "Mar 18", "Apr 18", "May 18", "Jun 18", "Jul 18", "Aug 18",
            "Sep 18", "Oct 18", "Nov 18", "Dec 18", "Jan 19", "Feb 19", "Mar 19", "Apr 19", "May 19", "Jun 19", "Jul 19", "Aug 19"
        ]
        
        if strategy == "Yield" {
            getDataAccordingToStrategy(periodDataStrategy: &twoYearsDataYield, strategy: strategy, xAxisLabels: months)
            return twoYearsDataYield!
        } else {
            getDataAccordingToStrategy(periodDataStrategy: &twoYearsDataPrice, strategy: strategy, xAxisLabels: months)
            return twoYearsDataPrice!
        }
    }
    
    private func getDataAccordingToStrategy(periodDataStrategy: inout ChartData?, strategy: String, xAxisLabels: [String]) {
        if periodDataStrategy == nil {
            periodDataStrategy = ChartData(lineData: generateData(dataVolume: xAxisLabels.count, strategy: strategy), xAxisLabels: xAxisLabels)
        }
    }
    
    private func generateData(dataVolume: Int, strategy: String) -> LineChartData {
        var dataArray = [Double]()
        var lineChartEntry = [ChartDataEntry]()
        
        for _ in 0..<dataVolume {
            dataArray.append(Double.random(in: 2.0..<40.0))
        }
        
        for i in 0..<dataVolume {
            let value = ChartDataEntry(x: Double(i),y: Double(dataArray[i]))
            lineChartEntry.append(value)
        }
        
        let dataSet = LineChartDataSet(entries: lineChartEntry, label: strategy)
        dataSet.circleColors = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)]
        let data = LineChartData()
        dataSet.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
        data.addDataSet(dataSet)
        
        return data
    }
}
