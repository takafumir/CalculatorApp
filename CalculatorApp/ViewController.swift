//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Yamano Takafumi on 2017/04/25.
//  Copyright © 2017 takafumi.yamano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // ビューがロードされた時点で式と答えのラベルは空にする
        formulaLabel.text = ""
        answerLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func inputFormula(_ sender: UIButton) {
        // ボタン（Cと=以外）が押されたら式を表示する
        guard let formulaText = formulaLabel.text else {
            return
        }
        guard let senderedText = sender.titleLabel?.text else {
            return
        }
        formulaLabel.text = formulaText + senderedText
    }

    @IBAction func calculateAnswer(_ sender: UIButton) {
    }

    @IBAction func clearCalculation(_ sender: UIButton) {
    }
}

