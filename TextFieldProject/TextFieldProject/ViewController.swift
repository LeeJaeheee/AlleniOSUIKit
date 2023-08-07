//
//  ViewController.swift
//  TextFieldProject
//
//  Created by 이재희 on 2023/08/06.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // textField의 대리자가 ViewController라고 설정하는 것
        textField.delegate = self
        setup()
    }
    
    func setup() {
        view.backgroundColor = UIColor.gray
        textField.keyboardType = .emailAddress
        textField.clearButtonMode = .always
        textField.becomeFirstResponder()
    }
    
    // 뷰컨트롤러에 있는 화면의 탭을 감지하는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        // textField.resignFirstResponder()
    }
    
    // 사용자가 텍스트 필드의 텍스트 편집을 시작하는 작업을 수행할 때 이 메서드를 호출 (편집 허락 여부 판단)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // 해당 함수의 이름을 출력
        print(#function)
        return true
    }
    
    // 지정된 텍스트 필드가 첫 번째 응답자가 되었음을 대리자에게 알림
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("유저가 입력 시작한 시점!")
    }
    
    // 사용자가 내장 지우기 버튼을 누르는 것에 대한 응답으로 이 메서드를 호출
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    // 사용자 작업으로 인해 텍스트가 변경될 때마다 이 메서드를 호출, 이 메서드를 사용하여 사용자가 입력한 텍스트의 유효성 검사
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        return true
    }
    
    // 사용자가 리턴 버튼을 누를 때마다 이 메서드를 호출, 이 메서드를 사용하여 버튼을 누를 때 사용자 지정 동작을 구현
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            textField.placeholder = "Type Something!"
            return false
        } else {
            return true
        }
    }
    
    // 텍스트 필드가 첫 번째 응답자 상태를 사임하라는 요청을 받았을 때 이 메서드를 호출, 사용자의 입력이 끝날 때 허락 여부 판단
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    // 텍스트 필드가 첫 번째 응답자 상태를 포기한 후에 호출, 이 메서드를 사용하여 대리인의 상태 정보를 업데이트
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("입력이 끝난 시점!")
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        textField.resignFirstResponder()
    }
    
}

