//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didSuccedWithResult(_ result: Double)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    // MARK: - Properties:
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "90ED5AD2-E529-463D-9B3B-A21ADA329BA4"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    // MARK: - Methods:
    
   func getCoinPrice(for currency: String) {
        if let url = URL(string: "\(baseURL)/\(currency)?apikey=90ED5AD2-E529-463D-9B3B-A21ADA329BA4") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error!)
                    return
                }
                if let data = data {
                    if let result = parseJSON(data) {
                        delegate?.didSuccedWithResult(result)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double?{
        let jsonDecoder = JSONDecoder()
        do {
            let decodeData = try jsonDecoder.decode(CoinData.self, from: data)
            let price = decodeData.rate
            return price
        } catch {
            return nil
        }
    }
    
    
}

