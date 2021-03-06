//
//  ViewController.swift
//  GSDeomo
//
//  Created by 石川大輔 on 2021/04/08.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var contentArray = [Content]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        print("Git test")
        print("Git test1")
        loadContent()
        
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print("!!!!!!!!!!!!")
        print(paths)
        print("!!!!!!!!!!!!")
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        print("!!!!!!!!!!!!")
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        let paths2 = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths2[0])
        print()
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
         print(urls[urls.count-1] as URL)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadContent()
        tableView.reloadData()
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //        let newContent = Content(context: self.context)
        //        newContent.date = Date()
        //        newContent.memo = "サンプルメモ"
        //        //        self.contentArray.append(newContent)
        //                self.contentArray.insert(newContent, at: 0)
        //        self.saveContents()
        
        tableView.reloadData()
        
        self.performSegue(withIdentifier: "captureVideo", sender: self)
    }
    
    //MARK: - Model Manupulation Method
    
    func loadContent() {
        let request: NSFetchRequest<Content> = Content.fetchRequest()
        do {
            contentArray = try context.fetch(request)
            contentArray.sort{ $0.date! > $1.date!}
        } catch {
            print("Error fetching data from context \(error) ")
        }
    }
    
}

//MARK: - TableView Datasource Methods

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.label.text = contentArray[indexPath.row].memo
        
        //        Load Date data from CoreData
        
        let newDate = contentArray[indexPath.row].date
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "ja_JP")
        
        cell.rightBottomLabel.text = formatter.string(from: newDate!)
        
        return cell
    }
    
    
}

//MARK: - TableView Delegate Methods

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "PlayVideo", sender: indexPath.row)
    }
}
