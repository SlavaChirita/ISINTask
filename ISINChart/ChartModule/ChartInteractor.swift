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
    func requestData(for period: ChartPeriod, strategy: String)
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
    
    func requestData(for period: ChartPeriod, strategy: String) {
        switch period {
        case .oneWeek:
            presenter?.presentData(response: getDataForWeek(strategy: strategy))
        case .oneMonth:
            presenter?.presentData(response: getDataForMonth(strategy: strategy))
        case .threeMonths:
            presenter?.presentData(response: getDataForThreeMonths(strategy: strategy))
        case .sixMonths:
            presenter?.presentData(response: getDataForSixMonths(strategy: strategy))
        case .oneYear:
            presenter?.presentData(response: getDataForYear(strategy: strategy))
        case .twoYears:
            presenter?.presentData(response: getDataForTwoYears(strategy: strategy))
        @unknown default:
            break
        }
    }
    
    private func getDataForWeek(strategy: String) -> ChartData {
        let months = ["25.09", "26.09", "27.09", "28.09", "29.09", "30.09", "31.09"]
        if strategy == "Yield" {
            guard let data = weekDataYield else {
                weekDataYield = ChartData(lineData: generateData(dataVolume: months.count, strategy: strategy), xAxisLabels: months)
                return weekDataYield!
            }
            return data
        } else {
            guard let data = weekDataPrice else {
                weekDataPrice = ChartData(lineData: generateData(dataVolume: months.count, strategy: strategy), xAxisLabels: months)
                return weekDataPrice!
            }
            return data
        }
    }
    
    private func getDataForMonth(strategy: String) -> ChartData {
        var months = [String]()
        for i in 0...30 {
            months.append("\(i+1).09")
        }
        if strategy == "Yield" {
            guard let data = monthDataYield else {
                monthDataYield = ChartData(lineData: generateData(dataVolume: months.count, strategy: strategy), xAxisLabels: months)
                return monthDataYield!
            }
            return data
        } else {
            guard let data = monthDataPrice else {
                monthDataPrice = ChartData(lineData: generateData(dataVolume: months.count, strategy: strategy), xAxisLabels: months)
                return monthDataPrice!
            }
            return data
        }
    }
    
    private func getDataForThreeMonths(strategy: String) -> ChartData {
        let months = ["Jul", "Sep", "Aug"]
        
        if strategy == "Yield" {
            guard let data = threeMonthsDataYield else {
                threeMonthsDataYield = ChartData(lineData: generateData(dataVolume: months.count, strategy: strategy), xAxisLabels: months)
                return threeMonthsDataYield!
            }
            return data
        } else {
            guard let data = threeMonthsDataPrice else {
                threeMonthsDataPrice = ChartData(lineData: generateData(dataVolume: months.count, strategy: strategy), xAxisLabels: months)
                return threeMonthsDataPrice!
            }
            return data
        }
    }
    
    private func getDataForSixMonths(strategy: String) -> ChartData {
        let months = ["Apr", "May", "Jun", "Jul", "Sep", "Aug"]
        
        if strategy == "Yield" {
            guard let data = sixMonthsDataYield else {
                sixMonthsDataYield = ChartData(lineData: generateData(dataVolume: months.count, strategy: strategy), xAxisLabels: months)
                return sixMonthsDataYield!
            }
            return data
        } else {
            guard let data = sixMonthsDataPrice else {
                sixMonthsDataPrice = ChartData(lineData: generateData(dataVolume: months.count, strategy: strategy), xAxisLabels: months)
                return sixMonthsDataPrice!
            }
            return data
        }
    }
    
    private func getDataForYear(strategy: String) -> ChartData {
        let months = ["Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug"]
        
        if strategy == "Yield" {
            guard let data = oneYearDataYield else {
                oneYearDataYield = ChartData(lineData: generateData(dataVolume: months.count, strategy: strategy), xAxisLabels: months)
                return oneYearDataYield!
            }
            return data
        } else {
            guard let data = oneYearDataPrice else {
                oneYearDataPrice = ChartData(lineData: generateData(dataVolume: months.count, strategy: strategy), xAxisLabels: months)
                return oneYearDataPrice!
            }
            return data
        }
    }
    
    private func getDataForTwoYears(strategy: String) -> ChartData {
        let months = [
            "Sep 17", "Oct 17", "Nov 17", "Dec 17", "Jan 18", "Feb 18", "Mar 18", "Apr 18", "May 18", "Jun 18", "Jul 18", "Aug 18",
            "Sep 18", "Oct 18", "Nov 18", "Dec 18", "Jan 19", "Feb 19", "Mar 19", "Apr 19", "May 19", "Jun 19", "Jul 19", "Aug 19"
        ]
        
        if strategy == "Yield" {
            guard let data = twoYearsDataYield else {
                twoYearsDataYield = ChartData(lineData: generateData(dataVolume: months.count, strategy: strategy), xAxisLabels: months)
                return twoYearsDataYield!
            }
            return data
        } else {
            guard let data = twoYearsDataPrice else {
                twoYearsDataPrice = ChartData(lineData: generateData(dataVolume: months.count, strategy: strategy), xAxisLabels: months)
                return twoYearsDataPrice!
            }
            return data
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
