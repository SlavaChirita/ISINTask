//
//  ChartViewController.swift
//  ISINChart
//
//  Created by Veaceslav Chirita on 11/14/19.
//  Copyright (c) 2019 Veaceslav Chirita. All rights reserved.
//

import UIKit
import Charts

protocol ChartDisplayLogic: class {
  func displayData(viewModel: ChartData)
}

class ChartViewController: UIViewController, ChartDisplayLogic, ChartViewDelegate {
    
    @IBOutlet weak var strategyButton: UIButton!
    @IBOutlet weak var dateSegment: UISegmentedControl!
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var strategyView: UIView!
    @IBOutlet weak var strategyLabel: UILabel!
    
    private var chosenPeriod = ChartPeriod.oneWeek
    var interactor: ChartBusinessLogic?
    var router: (NSObjectProtocol & ChartRoutingLogic)?
      
    private func setup() {
        let viewController        = self
        let interactor            = ChartInteractor()
        let presenter             = ChartPresenter()
        let router                = ChartRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showStrategy))
        strategyView.addGestureRecognizer(tapGesture)
        strategyView.isUserInteractionEnabled = true
        
        strategyButton.layer.borderWidth = 1
        strategyButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.52)
        strategyButton.layer.masksToBounds = true
        strategyButton.layer.cornerRadius = 20
        
        strategyView.layer.borderWidth = 1
        strategyView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.52)
        strategyView.layer.masksToBounds = true
        strategyView.layer.cornerRadius = 20
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        strategyView.isHidden = true
        
        strategyButton.setTitle("Yield", for: .normal)
        
        interactor?.requestData(for: chosenPeriod, strategy: strategyButton.title(for: .normal)!)
    }
  
    func displayData(viewModel: ChartData) {
        chartView.data = viewModel.lineData
        
        chartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Medium", size: 10)!
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: viewModel.xAxisLabels ?? [])
        chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chartView.xAxis.granularity = 0.5
        
        chartView.notifyDataSetChanged()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {

    }
    
    @IBAction func dateSegmentValueDidChange(_ sender: UISegmentedControl) {
        
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0:
            chosenPeriod = .oneWeek
            interactor?.requestData(for: chosenPeriod, strategy: strategyButton.title(for: .normal)!)
        case 1:
            chosenPeriod = .oneMonth
            interactor?.requestData(for: chosenPeriod, strategy: strategyButton.title(for: .normal)!)
        case 2:
            chosenPeriod = .threeMonths
            interactor?.requestData(for: chosenPeriod, strategy: strategyButton.title(for: .normal)!)
        case 3:
            chosenPeriod = .sixMonths
            interactor?.requestData(for: chosenPeriod, strategy: strategyButton.title(for: .normal)!)
        case 4:
            chosenPeriod = .oneYear
            interactor?.requestData(for: chosenPeriod, strategy: strategyButton.title(for: .normal)!)
        case 5:
            chosenPeriod = .twoYears
            interactor?.requestData(for: chosenPeriod, strategy: strategyButton.title(for: .normal)!)
        default:
            break
        }
    }
    
    @IBAction func strategyButtonDidTap(_ sender: UIButton) {
        print(sender.titleLabel?.text ?? "")
        strategyView.isHidden = strategyView.isHidden ? false : true
    }
    
    @objc func showStrategy() {
        let temp = strategyLabel.text
        strategyLabel.text = strategyButton.titleLabel?.text
        strategyButton.setTitle(temp, for: .normal)
        strategyView.isHidden = true
        
        interactor?.requestData(for: chosenPeriod, strategy: strategyButton.title(for: .normal)!)
    }
}
