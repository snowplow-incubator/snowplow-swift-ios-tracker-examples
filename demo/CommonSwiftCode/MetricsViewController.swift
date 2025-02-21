//
//  SecondViewController.swift
//  SnowplowSwiftDemo
//
//  Copyright (c) 2015-2020 Snowplow Analytics Ltd. All rights reserved.
//
//  This program is licensed to you under the Apache License Version 2.0,
//  and you may not use this file except in compliance with the Apache License
//  Version 2.0. You may obtain a copy of the Apache License Version 2.0 at
//  http://www.apache.org/licenses/LICENSE-2.0.
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the Apache License Version 2.0 is distributed on
//  an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
//  express or implied. See the Apache License Version 2.0 for the specific
//  language governing permissions and limitations there under.
//
//  Authors: Michael Hadam
//  Copyright: Copyright (c) 2015-2020 Snowplow Analytics Ltd
//  License: Apache License Version 2.0
//

import UIKit
import SnowplowTracker

class MetricsViewController: UIViewController, UITextFieldDelegate, PageObserver {

    @IBOutlet weak var uriField: UITextField!
    @IBOutlet weak var trackingSwitch: UISegmentedControl!
    @IBOutlet weak var protocolSwitch: UISegmentedControl!
    @IBOutlet weak var methodSwitch: UISegmentedControl!
    @IBOutlet weak var isRunningLabel: UILabel!
    @IBOutlet weak var isBackgroundLabel: UILabel!
    @IBOutlet weak var sessionCountLabel: UILabel!
    @IBOutlet weak var isOnlineLabel: UILabel!
    @IBOutlet weak var madeLabel: UILabel!
    @IBOutlet weak var dbCountLabel: UILabel!
    @IBOutlet weak var sentLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    var updateTimer : Timer?
    weak var tracker : TrackerController?

    @objc dynamic var snowplowId: String! = "metrics view"

    func updateToken(_ token: String) {
        tokenLabel.text = String(format: "Token: %@", token)
    }

    var parentPageViewController: PageViewController!
    func getParentPageViewController(parentRef: PageViewController) {
        parentPageViewController = parentRef
        tracker = parentRef.tracker
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateMetrics), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    @objc func updateMetrics() {
        madeLabel.text = String(format: "Made: %lld", parentPageViewController.madeCounter)
        dbCountLabel.text = String(format: "DB Count: %lu", CUnsignedLong(self.tracker?.emitter?.dbCount ?? 0))
        sessionCountLabel.text = String(format: "Session Count: %lu", CUnsignedLong(self.tracker?.session?.sessionIndex ?? 0))
        isRunningLabel.text = String(format: "Running: %@", self.tracker?.emitter?.isSending ?? false ? "yes" : "no")
        isBackgroundLabel.text = String(format: "Background: %@", self.tracker?.session?.isInBackground ?? false ? "yes" : "no")
        sentLabel.text = String(format: "Sent: %lu", CUnsignedLong(parentPageViewController.sentCounter))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
