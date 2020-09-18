//
//  StudentDataViewController.swift
//  CourseFriend
//
//  Created by Abdul Sami Sultan on 10/09/2020.
//  Copyright © 2020 Sami. All rights reserved.
//

import UIKit
import CoreData
class StudentDataViewController: UIViewController{
    
   var people : [NSManagedObject] = []
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var studentImageView: UIImageView!
    @IBOutlet weak var StudentNameLabel: UILabel!
    
    
    var studentData = UserData()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Abdul Sami Sultan"
       
        tableView.delegate = self
        tableView.dataSource  = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetched()
    }
    
    func setupScreen(){
        
        StudentNameLabel.text = studentData.Name
        let radius = studentImageView.frame.height
        studentImageView.layer.cornerRadius = 30
//        studentImageView.image = UIImage(systemName: )
    }
    
    func fetched(){
              print("fetched")
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                  return
              }
              
              let managedContext = appDelegate.persistentContainer.viewContext
              
              let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StudentDataBase")
              
              do{
                  people = try managedContext.fetch(fetchRequest)
                  print(people.count)
              }catch let error as NSError{
                   print("Could not save.\(error), \(error.userInfo)")
              }
        
        studentData.Name = people.last?.value(forKeyPath: "name") as! String
        print(studentData.Name)
//        studentData.Courses = people.last?.value(forKeyPath: "courses") as! [String]
        studentData.Image = people.last?.value(forKeyPath: "image") as! String
        print(studentData.Courses)
       }

}
extension StudentDataViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        setupScreen()
        return "Courses List"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = studentData.Courses.count
        return list
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
//        cell.textLabel?.text = studentData.Courses[indexPath.row]
        cell.detailTextLabel?.text = "No Announcement Yet"
     
      
        return cell
    }
}
