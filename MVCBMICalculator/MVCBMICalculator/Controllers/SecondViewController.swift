//
//  SecondViewController.swift
//  BMICalculator
//
//  Created by 이재희 on 2023/08/10.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var bmi: Double?
    var bmiColor: UIColor?
    var adviceString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
    }
    
    func makeUI() {
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.clipsToBounds = true
        
        backButton.layer.cornerRadius = 5
        backButton.clipsToBounds = true
        
        guard let bmi = bmi else { return }
        bmiNumberLabel.text = String(bmi)
        
        // 둘다 어차피 옵셔널 타입이므로 바인딩 필요 없음
        adviceLabel.text = adviceString
        bmiNumberLabel.backgroundColor = bmiColor
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

}
