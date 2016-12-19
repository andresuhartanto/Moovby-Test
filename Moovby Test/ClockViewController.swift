//
//  ViewController.swift
//  Moovby Test
//
//  Created by Andre Suhartanto on 12/18/16.
//  Copyright © 2016 EndeJeje. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ClockViewController: UIViewController {
    
    var countdown = 600
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTime()
        Timer.scheduledTimer(timeInterval: 600, target: self, selector: #selector(ClockViewController.loadTime), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ClockViewController.countdownFunc), userInfo: nil, repeats: true)
    }
    
    func loadTime(){
        Alamofire.request("http://api.timezonedb.com/v2/get-time-zone?key=5HHSK5B7NCLT&format=json&by=position&lat=3.1385036&lng=101.6169489").responseJSON(completionHandler: { (JSONResponse) in
            switch JSONResponse.result{
            case .success(let responseValuse):
                let jsonValue = JSON(responseValuse)
                
                guard let timeURL = jsonValue["formatted"].string else { return }
                    self.timeLabel.text = timeURL
                
            case .failure(let error):
                print(error.localizedDescription)

            }
        }
        )
    }
    
    func countdownFunc(){
        if self.countdown > 0{
            self.timerLabel.text = "\(String(self.countdown)) seconds to referesh"
            self.countdown -= 1
        }else{
            self.countdown = 600
        }
    }
    
    @IBAction func onRefreshButtonPressed(_ sender: UIButton) {
        loadTime()
        self.countdown = 600
    }
    
    
    
}

