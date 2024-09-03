import UIKit

class UserSession{
    
    static let shared = UserSession()
    var UserName:String?
    private init(){}
}

class UserOrder
{
    static let shared = UserOrder()
    var UserName = UserSession.shared.UserName
    var UserText:String?
    var UserPhoto1:Data?
    var UserPhoto2:Data?
    var UserPhoto3:Data?
    var UserPhoto4:Data?
    var UserType:Int?
    
}



class ViewController: UIViewController {
    
   
    
    let registrationLabel = UILabel()
    let loginTextField = UITextField()
    let successButton = UIButton(type: .system)
    let passwordTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sqlManager = SQL()
        
        sqlManager.db = sqlManager.openDatabase()
        
        if sqlManager.db != nil{
            // Создаем таблицу users
            let createUsersTableString = """
            CREATE TABLE IF NOT EXISTS users(
            Id INTEGER PRIMARY KEY,
            Name TEXT,
            password TEXT,
            phone TEXT);
            """
            
            // Создаем таблицу orders
            let createOrdersTableString = """
            CREATE TABLE IF NOT EXISTS orders(
                id INTEGER PRIMARY KEY,
                UserName TEXT,
                date TEXT,
                UserText TEXT,
                photo1 TEXT,
                photo2 TEXT,
                photo3 TEXT,
                photo4 TEXT,
                typeExpertiz INTEGER,
                pay INTEGER,
                answerExpert TEXT,
                result TEXT
            );
            """

            
            sqlManager.createTable(query: createUsersTableString)
            sqlManager.createTable(query: createOrdersTableString)
        }
        
        // Создаем слой градиента
        view.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        
        // Добавляем логотип
        let mainLogo = UIImageView()
        mainLogo.image = UIImage(named: "logo_final")
        mainLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainLogo)
        
        // Центрируем логотип по горизонтали
        NSLayoutConstraint.activate([
            mainLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            mainLogo.widthAnchor.constraint(equalToConstant: 100),
            mainLogo.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Создаем UITextField для логина
        loginTextField.placeholder = "Логин"
        loginTextField.borderStyle = .roundedRect
        loginTextField.backgroundColor = .black
        loginTextField.textColor = .white
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Логин", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginTextField)
        
        // Создаем UITextField для пароля
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = .black
        passwordTextField.textColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        // Создаем кнопку "Войти"
        successButton.setTitle("Войти", for: .normal)
        successButton.backgroundColor = UIColor(red: 251/255, green: 109/255, blue: 16/255, alpha: 1.0)
        successButton.setTitleColor(.white, for: .normal)
        successButton.layer.cornerRadius = 10
        successButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(successButton)
        
        successButton.isUserInteractionEnabled = true
        
        //Обработчик нажатия на кнопку
        let tapButton = UITapGestureRecognizer(target: self, action:#selector(buttonentryTapped))
        successButton.addGestureRecognizer(tapButton)
        
        // Создаем UILabel для регистрации
        registrationLabel.textColor = UIColor.white
        registrationLabel.text = "Зарегестрироваться"
        registrationLabel.font = UIFont.systemFont(ofSize: 14)
        registrationLabel.textAlignment = .center
        registrationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registrationLabel)
        
        // Включаем взаимодействие с пользователем для UILabel
        registrationLabel.isUserInteractionEnabled = true
        
        // Создаем распознаватель жестов нажатия
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(registrationLabelTapped))
        registrationLabel.addGestureRecognizer(tapGesture)
        
        
        // Устанавливаем констрейнты
        NSLayoutConstraint.activate([
            // UITextField для логина
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: 20),
            loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // UITextField для пароля
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Кнопка "Войти"
            successButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            successButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            successButton.heightAnchor.constraint(equalToConstant: 50),
            
            // UILabel для регистрации
            registrationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationLabel.topAnchor.constraint(equalTo: successButton.bottomAnchor, constant: 20),
            registrationLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            registrationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    // Функция-обработчик нажатия на UILabel
    @objc func registrationLabelTapped() {
        let storyboard = UIStoryboard(name: "RegViewController", bundle: nil)
        let vs = storyboard.instantiateViewController(withIdentifier: "RegViewController") as! RegViewController
        present(vs, animated: true)
    }
    
    // Функция-обработчик нажатия на UILabel
    @objc func buttonentryTapped() {
        if let passwordText = passwordTextField.text, !passwordText.isEmpty,
           let loginText = loginTextField.text, !loginText.isEmpty {
            let sql = SQL()
            sql.db = sql.openDatabase()
            if sql.db != nil {
                let authResult = sql.checkAuthorization(name: loginText, password: passwordText)
                if authResult != 1 {
                    self.dismiss(animated: true)
                    print("Вход в аккаунт выполнен")
                    UserSession.shared.UserName = loginText
                    
                    
                    // Переход на следующий экран
                    let storyboard = UIStoryboard(name: "EntrViewController", bundle: nil)
                    if let vsa = storyboard.instantiateViewController(withIdentifier: "EntrViewController") as? EntrViewController {
                        present(vsa, animated: true)
                    } else {
                        print("Не удалось найти EntrViewController")
                    }
                    
                } else {
                    // Если пользователь не найден
                    let errorAlert = UIAlertController(title: "Ошибка", message: "Неправильный логин или пароль", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
                    errorAlert.addAction(OKAction)
                    present(errorAlert, animated: true, completion: nil)
                }
            } else {
                // Если база данных не открыта
                let error = UIAlertController(title: "Ошибка", message: "Ошибка подключения к базе данных", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
                error.addAction(OKAction)
                present(error, animated: true, completion: nil)
            }
        } else {
            // Если одно или оба поля пустые
            let error = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
            error.addAction(OKAction)
            present(error, animated: true, completion: nil)
        }
    }

        
}

