//
//  LoginFormController.swift
//  SocialProject
//
//  Created by Irina Kuligina on 31.01.2021.
//

import UIKit

class LoginFormViewController: UIViewController {
   
  
    @IBOutlet weak var SocialProjLabel: UILabel!
     
    @IBOutlet weak var emailPhoneTextField: UITextField!
 
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    lazy var loadingView: UIView = {
        return LoadingView(frame: CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.maxX, height: view.frame.maxY))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.backgroundColor = Colors.palePurplePantone
        view.backgroundColor = Colors.palePurplePantone
        
        setupLabel()
        setupButton()
        setupTextFields()
        setupLoadingView()
        
      
    }
    
    // MARK: - Настройки элементов UI
    func setupButton() {
        
        loginButton?.layer.cornerRadius = 5
        loginButton?.backgroundColor = Colors.baseVK
        loginButton?.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 25)
        loginButton?.setTitleColor(Colors.darkPalePurplePantone, for: .normal)
    }
    
    func setupTextFields() {
        [emailPhoneTextField, passwordTextField].forEach { (textField) in
            textField?.layer.cornerRadius = 20.0
            textField?.backgroundColor = .lightGray
        }
    }
    func setupLabel(){
        SocialProjLabel?.textColor = Colors.oxfordBlue
    }
    
    func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        // Подписка на уведомления
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Отписка от уведомлений
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    // MARK: - Настройки использования клавиатуры
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)

        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }

    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    // MARK: - Нажатие на кнопку "Войти"
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        print(#function)
        loadingWhileEnter()
    }
    
    func isLoginSuccesfull() -> Bool {
        guard let login = emailPhoneTextField.text,
              let password = passwordTextField.text else { return false }

        var loginResult: Bool = false
        
        if login == "admin" &&
           password == "admin" {
            loginResult = true
        }
        
        return loginResult
    }
    
    // MARK: - Отображение alert о неверных данных
    func showLoginErrorAlert() {
        let alertContoller = UIAlertController(title: "Ошибка!", message: "Введены неверные данные пользователя. Подсказка: логин - admin, пароль - admin", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertContoller.addAction(action)
        present(alertContoller, animated: true, completion: nil)
        
    }
    
    // MARK: - Переход к TabBarController при успешной авторизации
    
    func tryToEnter() {
        if isLoginSuccesfull() {
            print("Успешный вход!")
           
        } else {
            print("Неудачный вход! Подсказка: логин - admin, пароль - admin")
            showLoginErrorAlert()
        }
    }
    
    func loadingWhileEnter() {
        loadingView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 2...6)) {
            self.loadingView.isHidden = true
            self.tryToEnter()
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            
        }
        
    }
}
