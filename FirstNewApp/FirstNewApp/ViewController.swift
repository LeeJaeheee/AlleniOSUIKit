//
//  ViewController.swift
//  FirstNewApp
//
//  Created by 이재희 on 2023/07/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    // Timer 클래스의 인스턴스 -> heap영역에 저장됨
    
    /* weak으로 선언하지 않으면, 방법 2로 구현 시
       힙 영역에서 timer -> Timer -> 클로저 -> timer -> Timer ... (강한 참조 사이클)
       메모리 해제되지 않을 가능성도 발생 */
    
    // weak으로 선언했기 때문에 클로저에서 [weak self]가 아닌 [self]로 참조해도 문제 없음
    weak var timer: Timer?
    
    var number = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        slider.value = 0.5
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        // slider의 value를 사용해 mainLabel의 텍스트 설정
        // number = Int(slider.value * 60)
        
        // slider와 sender가 동일하지만 이 경우 sender를 쓰는 것이 더 바람직
        number = Int(sender.value * 60)
        mainLabel.text = "\(number) 초"
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        /* 방법 1: Timer로 다른 함수를 실행시킴 */
        // 기존에 존재하는 타이머 비활성화 (if not: start버튼 2번 누르는 경우 타이머 2개 활성화될 수 있음)
        timer?.invalidate()

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(doSomethingAfter1Second), userInfo: nil, repeats: true)
        
        /* 방법 2: Timer로 클로저를 실행시킴 */
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self] _ in
//            if number > 0 {
//                number -= 1
//                slider.value = Float(number) / Float(60)
//                mainLabel.text = "\(number) 초"
//            } else if number == 0 {
//                number = -1
//                mainLabel.text = "초를 선택하세요"
//                // 타이머 반복 사용 위해서 비활성화 필요
//                timer?.invalidate()
//                // 시스템 사운드 재생
//                AudioServicesPlayAlertSound(SystemSoundID(1322))
//            }
//
//        })
    }
    
    @objc func doSomethingAfter1Second() {
        if number > 0 {
            number -= 1
            slider.value = Float(number) / Float(60)
            mainLabel.text = "\(number) 초"
        } else if number == 0 {
            number = -1
            mainLabel.text = "초를 선택하세요"
            // 타이머 반복 사용 위해서 비활성화 필요
            timer?.invalidate()
            // 시스템 사운드 재생
            AudioServicesPlayAlertSound(SystemSoundID(1322))
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        mainLabel.text = "초를 선택하세요"
        slider.setValue(0.5, animated: true)
        number = -1
        timer?.invalidate()
    }
    
    
    
}

