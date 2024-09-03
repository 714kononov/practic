import UIKit

class RegViewController: UIViewController {
    
    let usernameForm = UITextField()
    let H2 = UILabel()
    let userpasswordForm = UITextField()
    let userphoneForm = UITextField()
    let button1 = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Устанавливаем градиентный фон
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.gray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Создаем первый заголовок
        let H1 = UILabel()
        H1.text = "Добро пожаловать!"
        H1.textColor = .white
        H1.font = UIFont.systemFont(ofSize: 16)
        H1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(H1)
        
        // Создаем второй заголовок
        H2.textColor = .white
        H2.font = UIFont.systemFont(ofSize: 14)
        H2.translatesAutoresizingMaskIntoConstraints = false
        
        // Атрибутированный текст с оранжевым словом "все"
        let text = "Заполните все поля для регистрации"
        let attributedString = NSMutableAttributedString(string: text)
    
        
        // Находим диапазон слова "все" и окрашиваем его в оранжевый
        if let range = text.range(of: "все") {
            let nsRange = NSRange(range, in: text)
            attributedString.addAttribute(.foregroundColor, value: UIColor.orange, range: nsRange)
        }
        
        H2.attributedText = attributedString
        view.addSubview(H2)
        
        //Поля ввода
        // Создаем поле ввода для имени пользователя
        usernameForm.backgroundColor = .black
        usernameForm.textColor = .white
        usernameForm.borderStyle = .roundedRect
        usernameForm.translatesAutoresizingMaskIntoConstraints = false
        usernameForm.attributedPlaceholder = NSAttributedString(string: "Имя пользователя", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        view.addSubview(usernameForm)
        
        //Ввод пароля
        userpasswordForm.backgroundColor = .black
        userpasswordForm.textColor = .white
        userpasswordForm.borderStyle = .roundedRect
        userpasswordForm.translatesAutoresizingMaskIntoConstraints = false
        userpasswordForm.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        view.addSubview(userpasswordForm)
        
        //Номер телефона
        //Ввод пароля
        userphoneForm.backgroundColor = .black
        userphoneForm.textColor = .white
        userphoneForm.borderStyle = .roundedRect
        userphoneForm.translatesAutoresizingMaskIntoConstraints = false
        userphoneForm.attributedPlaceholder = NSAttributedString(string: "Номер телефона", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        view.addSubview(userphoneForm)
        
        //Кнопка зарегестрироваться
        button1.setTitle("Зарегестрироваться", for:.normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button1.backgroundColor = UIColor.orange
        button1.setTitleColor(.white, for: .normal)
        button1.layer.cornerRadius = 10
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)
        button1.isUserInteractionEnabled = true
        let tapButton = UITapGestureRecognizer(target: self, action: #selector(safedatabase))
        button1.addGestureRecognizer(tapButton)
        
        // Устанавливаем Auto Layout Constraints
        NSLayoutConstraint.activate([
            // Центрируем H1 по горизонтали и вертикали
            H1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            H1.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -150),
            
            // Центрируем H2 по горизонтали и располагаем под H1
            H2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            H2.topAnchor.constraint(equalTo: H1.bottomAnchor, constant: 10),
            
            // Центрируем usernameForm по горизонтали и располагаем его под H2
            usernameForm.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameForm.topAnchor.constraint(equalTo: H2.bottomAnchor, constant: 10),
            usernameForm.widthAnchor.constraint(equalToConstant: 250), // Ширина поля ввода
            usernameForm.heightAnchor.constraint(equalToConstant: 40),  // Высота поля ввода
            
            //Поле ввода пароля
            userpasswordForm.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userpasswordForm.topAnchor.constraint(equalTo: usernameForm.bottomAnchor, constant: 10),
            userpasswordForm.widthAnchor.constraint(equalToConstant: 250), // Ширина поля ввода
            userpasswordForm.heightAnchor.constraint(equalToConstant: 40),  // Высота поля ввода
            
            //Поле ввода телефона
            userphoneForm.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userphoneForm.topAnchor.constraint(equalTo: userpasswordForm.bottomAnchor,constant: 10),
            userphoneForm.widthAnchor.constraint(equalToConstant: 250),
            userphoneForm.heightAnchor.constraint(equalToConstant: 40),
            
            //Кнопка регистрации
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button1.topAnchor.constraint(equalTo: userphoneForm.bottomAnchor,constant: 10),
            button1.widthAnchor.constraint(equalToConstant: 170),
            button1.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    @objc func safedatabase()
    {
        if let usernameText = usernameForm.text, !usernameText.isEmpty,
           let userpasswordText = userpasswordForm.text, !userpasswordText.isEmpty,
           let userphoneText = userphoneForm.text, !userphoneText.isEmpty
        {
            let successReg = UIAlertController(title: "Успешно!", message: "Вы успешно зарегестрировались!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "ОК", style: .default){ _ in
                // Закрываем текущее окно
                self.dismiss(animated: true, completion: nil)
            }
            successReg.addAction(OKAction)
            present(successReg, animated: true)
            
            let sql = SQL()
            sql.db = sql.openDatabase()
            
            if sql.db != nil
            {
                sql.safeToDB(username: usernameText, password: userpasswordText, phone: userphoneText)
            }

            
        }else
        {
            let error = UIAlertController(title: "Ошибка", message: "Вы заполнили не все поля", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Ок", style: .default)
            error.addAction(OKAction)
            present(error, animated: true)
        }
           
    }
    
}
