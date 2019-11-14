//
//  ISINChartTests.swift
//  ISINChartTests
//
//  Created by Veaceslav Chirita on 11/14/19.
//  Copyright © 2019 Veaceslav Chirita. All rights reserved.
//

import XCTest
@testable import ISINChart

class ISINChartTests: XCTestCase {

    let viewController = TestChartViewController()
    var viewModel: ChartData?

    func testViewModel() {
        viewModel = ChartData(lineData: nil, xAxisLabels: ["Jan", "Feb"])
        viewController.displayData(viewModel: viewModel!)
        
        XCTAssertFalse(viewController.getViewModel().xAxisLabels == nil)
        XCTAssertTrue(viewController.getViewModel().xAxisLabels![0] == "Jan")
        XCTAssertTrue(viewController.getViewModel().xAxisLabels![1] == "Feb")
    }
}
