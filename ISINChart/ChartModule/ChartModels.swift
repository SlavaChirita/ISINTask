//
//  ChartModels.swift
//  ISINChart
//
//  Created by Veaceslav Chirita on 11/14/19.
//  Copyright (c) 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit
import Charts

struct ChartData {
    var lineData: LineChartData?
    var xAxisLabels: [String]?
}

enum ChartPeriod {
    case oneWeek
    case oneMonth
    case threeMonths
    case sixMonths
    case oneYear
    case twoYears
}
