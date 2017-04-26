//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Yamano Takafumi on 2017/04/25.
//  Copyright © 2017 takafumi.yamano. All rights reserved.
//

import UIKit
import Expression

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

    @IBAction func clearCalculation(_ sender: UIButton) {
        // `C`ボタンが押されたら式と答えをクリアする
        formulaLabel.text = ""
        answerLabel.text = ""
    }

    @IBAction func calculateAnswer(_ sender: UIButton) {
        // `=`ボタンが押されたら答えを計算して表示する
        guard let formulaText = formulaLabel.text else {
            return
        }
        let formula: String = formatFormula(formulaText)
        answerLabel.text = evalFormula(formula)
    }

    private func formatFormula(_ formula: String) -> String {
        // 入力された整数には`.0`を追加して小数として評価する
        // また`÷`を`/`に、`×`を`*`に置換する
        let formattedFormula: String = formula.replacingOccurrences(
                of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
                with: "$1.0",
                options: NSString.CompareOptions.regularExpression,
                range: nil
            ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        return formattedFormula
    }

    private func evalFormula(_ formula: String) -> String {
        do {
            // Expressionで文字列の計算式を評価して答えを求める
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch {
            // 計算式が不当だった場合
            return "式を正しく入力してください"
        }
    }

    private func formatAnswer(_ answer: String) -> String {
        // 答えの小数点以下が`.0`だった場合は、`.0`を削除して答えを整数で表示する
        let formattedAnswer: String = answer.replacingOccurrences(
                of: "\\.0$",
                with: "",
                options: NSString.CompareOptions.regularExpression,
                range: nil)
        return formattedAnswer
    }
}
