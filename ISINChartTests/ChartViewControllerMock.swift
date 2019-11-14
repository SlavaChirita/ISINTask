//
//  ChartViewControllerMock.swift
//  ISINChartTests
//
//  Created by Veaceslav Chirita on 11/14/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit
@testable import ISINChart

class TestChartViewController: UIViewController, ChartDisplayLogic {
    var viewModel: ChartData!
    
    func displayData(viewModel: ChartData) {
        self.viewModel = viewModel
    }
    
    func getViewModel() -> ChartData {
        return self.viewModel
    }
}


