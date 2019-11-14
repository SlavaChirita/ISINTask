//
//  ChartPresenter.swift
//  ISINChart
//
//  Created by Veaceslav Chirita on 11/14/19.
//  Copyright (c) 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit
import Charts

protocol ChartPresentationLogic {
    func presentData(response: ChartData)
}

class ChartPresenter: ChartPresentationLogic {
    weak var viewController: ChartDisplayLogic?
  
    func presentData(response: ChartData) {
        viewController?.displayData(viewModel: response)
    }
  
}
