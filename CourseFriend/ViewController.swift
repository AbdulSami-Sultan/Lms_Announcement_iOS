//
//  ViewController.swift
//  CourseFriend
//
//  Created by Abdul Sami Sultan on 08/09/2020.
//  Copyright © 2020 Sami. All rights reserved.
//

import UIKit
import SwiftSoup
import WebKit
import CoreData
class ViewController: UIViewController, UITextFieldDelegate{
    let website = "https://www.google.com/"
    let lms = "http://lms.dsu.edu.pk"
    let youtube = "http://apple.com"
    var data = ""
    var webView : WKWebView!
    var urls : URL!
    var student = UserData()
    
    var linkImage = ""
    
    @IBOutlet weak var appearButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var secodView: UIView!
    var name = ""
    var pass = ""
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
//    let image = UIImageView()
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewColor()
//        userNameTextField.text = "CS171054"
//        passwordTextField.text = "looks171054"
        data = lms
        screenSetup()
//        image.isHidden = true
//        image.frame = CGRect(x: 260, y: 480, width: 194, height: 194)
//        view.addSubview(image)
        
        
        userNameTextField.frame = CGRect(x: 20, y: 400, width: 374, height: 34)
        passwordTextField.frame = CGRect(x: 20, y: 440, width: 374, height: 34)
        loginButton.frame = CGRect(x: 160, y: 480, width: 94, height: 34)
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        userNameTextField.becomeFirstResponder()
        passwordTextField.becomeFirstResponder()
        
        secodView.isHidden = true
        secodView.backgroundColor = .clear
        webView.isHidden = true
        appearButton.isHidden = true
        webView.alpha = 0.0
        
        loginButton.layer.cornerRadius = 5
        appearButton.layer.cornerRadius = 5
        appearButton.titleLabel?.text = "View Courses"
        
          
//        getData(name: data )
        // Do any additional setup after loading the view.
    }
    func viewColor(){
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [
            UIColor(red: 48/255, green: 62/255, blue: 103/255, alpha: 1).cgColor,
            UIColor(red: 244/255, green: 88/255, blue: 53/255, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
//        self.view.layer.addSublayer(gradient)
        view.backgroundColor = UIColor(red: 244/255, green: 88/255, blue: 53/255, alpha: 1)
    }
    func animationForWebView(){
       
        UIView.animate(withDuration: 2) {
            self.secodView.isHidden = false
            self.webView.isHidden = false
            self.appearButton.isHidden = false
            self.webView.alpha = 1.0
        }
    }
    func moment(){
        UIView.animate(withDuration: 1) {
               self.userNameTextField.frame = CGRect(x: 20, y: 53, width: 374, height: 34)
            self.passwordTextField.frame = CGRect(x: 20, y: 95, width: 374, height: 34)
            self.loginButton.frame = CGRect(x: 20, y: 137, width: 94, height: 34)
            
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animationForWebView()
        }
       }
    
    func screenSetup(){
        let webconfig = WKWebViewConfiguration()
         webView = WKWebView(frame: .zero, configuration: webconfig)
         webView.navigationDelegate = self
         
         let url = URL(string: data)!
         let request = URLRequest(url: url)
         webView.backgroundColor = .lightGray
         webView.frame = CGRect(x: 0, y: 0, width: 384, height: 683)
         webView.load(request)
         secodView.addSubview(webView)
    
//         view.backgroundColor = .systemGray2
        
//         button.backgroundColor = .green
    }
    func loadWeb(){
        
    }
    @IBAction func loginButton(_ sender: Any) {
        name = userNameTextField.text!
        pass = passwordTextField.text!
        moment()
        print("\(name) -> \(pass)")
        data = lms
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        screenSetup()
        
        
    }
    
    @IBAction func lmsLogin(_ sender: Any) {
////        let webLink = webView.url
////        print(urls!)
//       // getData(name: urls!)
//        let historySize = webView.backForwardList.backList.count
//        let lastItem = webView.backForwardList.item(at: -historySize)
//           // go to it!
//        print(webView.backForwardList.currentItem)
//        print(webView.url!)
//        let url = URL(string: "ttps://lms.dsu.edu.pk/login/index.php")!
//        let request = URLRequest(url: url)
//        print("---------idhar-----------")
//        webView.load(request)
//        getData(name: url)
//          // webView.go(to: lastItem!)
        
        performSegue(withIdentifier: "info", sender: nil)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info"{
            let controller = segue.destination as? StudentDataViewController
            controller?.studentData = student
        }
    }
    
    
    func getData(name:URL){
        let url = name
        print("function called")
        let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            if err != nil{
                print(err!)
            }else{
                if let html = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                debugPrint("--------------")
                    print(html)


                }
            }
        }
        task.resume()


    }
  
    
    
}
extension ViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("alert")
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void){
        let user = name
        let password = pass
        let credential = URLCredential(user: user, password: password, persistence: URLCredential.Persistence.forSession)
        
       
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
        print("completion handler")
//        self.animationForWebView()
        var number = webView.backForwardList.backList.count - 1
        let last = webView.backForwardList.item(at: number)
        print("\(number + 1) -> \(String(describing: last))")
        print(webView.backForwardList.currentItem ?? "")
        
        urls = webView.url
        print(urls ?? "nil")
        print(urls.absoluteString)
        let st = urls.absoluteString
        if st == "http://lms.dsu.edu.pk/"{
           print("in")
             print("--------------new data------------")
                        let url = URL(string: "https://lms.dsu.edu.pk/login/index.php")!
                        let request = URLRequest(url: url)
                        webView.load(request)
            print(url.absoluteString)
            if url.absoluteString == "https://lms.dsu.edu.pk/login/index.php"{
                print("data input")
               
            }
            
        }
        //
        print("------images--------")
    
        
        
        

    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let scriptSource = "document.body.style.backgroundColor = `red`;"
        let secondScript = "document.getElementsByTagName('html')[0].innerHTML"
        let click = "document.getElementById('action-menu-0-menubar').value"
        print(scriptSource)
        webView.evaluateJavaScript(secondScript, completionHandler: { (object, error) in
        print(object)
           
        })
         webInjection()
    }
    
    func webInjection() {
        let step_1 = "document.getElementById('username').value='\(name)'"
        let step_2 = "document.getElementById('password').value='\(pass)'"
        let step_3 = "document.getElementById('rememberusername').value='\(pass)'"
        let step_4 = "document.getElementById('login').submit();"
//         let secondScript = "document.getElementsByTagName('html')[0].innerHTML"
         webView.evaluateJavaScript(step_1, completionHandler: { (object, error) in
//               print(object)
            self.webView.evaluateJavaScript(step_2, completionHandler: { (object, error) in
//                  print(object)
                     self.webView.evaluateJavaScript(step_4, completionHandler: { (object, error) in
                                     print(object)
                        self.dataEntry()
                                          print("successfull")
//                        self.performSegue(withIdentifier: "info", sender: nil)
                     })
                  })
               })
        
        print("inject function")
    }
    func dataEntry(){
                 let secondScript = "document.getElementsByTagName('html')[0].innerHTML"
        webView.evaluateJavaScript(secondScript) { (object, err) in
            print(object!)
            do{
                let doc = try SwiftSoup.parse(object as! String)
                let authors = try doc.getElementsByClass("fa fa-graduation-cap").array()
                let tag = try doc.select("ul").first()
                let div = try doc.getElementsByClass("dropdown")
                print("----========----------------")
                guard let photo = tag else{return}
//              print(try photo.html())
                let imgAtt = try photo.select("a").array()
                let att = try imgAtt.first
                let link = try att?.select("img")
                if let last = try link?.attr("src"){
                    print(att)
                    print(last)
                    let imageLink = last
                    print(imageLink)
//                    self.linkImage = imageLink
//                    let url = URL(string: self.linkImage)!
//                    let request = URLRequest(url: url)
//                    self.webView.load(request)
//                    let current = self.webView.url
//                    print("current - > \(current!.absoluteString)")
//                    if let data = try? Data(contentsOf: current!){
//                         if let image = UIImage(data: data){
//                            self.image.image = image
//                                 self.webView.isHidden = true
//                             print("successfull")
//
//                         }else{
//                            
//                        }
//                     }
                    
                }
                

                
             
                
              
                print("_____________----------------")
                let links = try doc.getElementsByClass("dropdown-menu")

                guard let name = try links.select("em").first()?.text() else{return}
                print(name)
                 print("_____________----------------")
               // print(try links.html())
                let course = try links.select("ul").last()
                //print(try course?.html())
                let numberOfCourses = try course?.select("li").array()
                for i in 0..<numberOfCourses!.count{
                    let names = try numberOfCourses?[i].text()
                    self.student.Courses.append(names!)
                    print(names!)
                }
                self.student.Courses.remove(at: 0)
                self.student.Name = name
                
                
//                let name = try doc.getElementsByClass("fa fa-user").html()
//                print(name)
//                let dash = try doc.getElementsByClass("fa fa-home").html()
//                print(dash)
            }catch{
                print(error)
            }
           
            
//            let titles = try doc.getElementsByClass(" Mg Kl").array()
            print("drop down")
//            let _ = self.student.Courses.remove(at: 0)
//            print("\(self.student.Name) -> \(self.student.Courses) -> \(self.student.Image)")
          
            self.coreData()
        }
    }
    
    func coreData(){
       guard let appDeleagte = UIApplication.shared.delegate as? AppDelegate else {return}
       let manageContext = appDeleagte.persistentContainer.viewContext
       let entity = NSEntityDescription.entity(forEntityName: "StudentDataBase", in: manageContext)!
       let newUser = NSManagedObject(entity: entity, insertInto: manageContext)
        newUser.setValue(student.Name, forKey: "name")
        newUser.setValue(student.Image, forKey: "image")
        newUser.setValue(student.Courses, forKey: "courses")
               do{
                   try manageContext.save()
//                   people.append(newUser)
               }catch let error as NSError{
                   print("Could not save.\(error), \(error.userInfo)")
               }
               
           

        
    }
   
    
}
