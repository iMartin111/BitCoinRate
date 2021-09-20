//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties:
    
    var coinManager = CoinManager()
    
    // MARK: - IBOutlets:
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    // MARK: - View LifeCycle:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }


}


// MARK: - PickerView DataSource:

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.coinManager.currencyArray.count
    }
    
}

// MARK: - PickerView Delegate:

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurency = self.coinManager.currencyArray[row]
        self.coinManager.getCoinPrice(for: selectedCurency)
        self.currencyLabel.text = selectedCurency
    }
}

// MARK: - CoinManager Delegate:

extension ViewController: CoinManagerDelegate {
    func didSuccedWithResult(_ result: Double) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", result)
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    
}




