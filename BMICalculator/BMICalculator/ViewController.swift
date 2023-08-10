//
//  ViewController.swift
//  BMICalculator
//
//  Created by 이재희 on 2023/08/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    var bmi: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    func makeUI() {
        // 텍스트필드들에 대한 대리자를 ViewController로 설정해주는 코드
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        mainLabel.text = "키와 몸무게를 입력해주세요"
        
        // 버튼 모양 둥글게 변경
        calculateButton.layer.cornerRadius = 5
        calculateButton.clipsToBounds = true
        
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        
        heightTextField.placeholder = "cm 단위로 입력해주세요"
        weightTextField.placeholder = "kg 단위로 입력해주세요"
    }

    @IBAction func caculateButtonTapped(_ sender: UIButton) {
        // BMI 결과값을 생성
        bmi = calculateBMI(height: heightTextField.text!, weight: weightTextField.text!)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력하셔야만 합니다!"
            mainLabel.textColor = UIColor.red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해주세요"
        mainLabel.textColor = UIColor.black
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController
            secondVC.bmi = self.bmi
            secondVC.bmiColor = getBackgroundColor()
            secondVC.adviceString = getBMIAdviceString()
        }
        // 데이터 전달 후 다음 화면으로 가기전에 텍스트필드 비우기 (뒤로가기 해서 오면 비워져있도록)
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    func calculateBMI(height: String, weight: String) -> Double {
        guard let h = Double(height), let w = Double(weight) else {return 0}
        var bmi = w / (h * h) * 10000
        bmi = round(bmi * 10) / 10
        return bmi
    }
    
    func getBackgroundColor() -> UIColor {
        guard let bmi = bmi else { return UIColor.black }
        switch bmi {
        case ..<18.6:
            return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
    
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "" }
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    // 모든 텍스트필드 숫자만 입력되게 설정
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 만약 텍스트필드별로 조건 부여하려면 이런 식으로 설정 가능
        // if textField == heightTextField { }
        
        if Int(string) != nil || string == "" {
            return true // 글자 입력 허용
        }
        return false // 글자 입력 허용하지 않음
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if heightTextField.text != "", weightTextField.text != "" {
            // 두개의 텍스트필드를 모두 입력되었으면 허용 (키보드 내림)
            weightTextField.resignFirstResponder()
            return true
        } else if heightTextField.text != "" {
            // height만 입력 되었으면 weight로 이동시킴
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
}
