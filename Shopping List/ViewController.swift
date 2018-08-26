//
//  ViewController.swift
//  Shopping List
//
//  Created by Cezary Róg on 20.08.2018.
//  Copyright © 2018 Cezary Róg. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    
    //Notification
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var notificationViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var shoppingListsTableView: UITableView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var addNewShoppingListButton: UIButton!
    @IBOutlet weak var addShoppingListView: UIView!
    @IBOutlet weak var addShoppingListViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var shoppingListTitleTextField: UITextField!
    @IBOutlet weak var shoppingListIconScrollView: UIScrollView!
    @IBOutlet weak var saveShoppingListButton: UIButton!
    
    var addNewShoppingListViewOpen = false
    
    var icons = ["default", "something", "default", "something", "default", "something", "default", "something"]
    
    var lists : [ShoppingList] = []
    
    var selectedList = ShoppingList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoppingListsTableView.delegate = self
        shoppingListsTableView.dataSource = self
        
        
        //title
        navigationItem.titleView = UIImageView(image: UIImage(named: "NavbarLogo"))
        
        setupCategoryIconsScrollView()
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.layer.opacity = 0.7
//        blurView.frame = self.view.bounds
//        self.view.addSubview(blurView)
        
        saveShoppingListButton.layer.cornerRadius = saveShoppingListButton.frame.height/2
        
        blurView.layer.opacity = 0
        addShoppingListView.layer.opacity = 0
        
        //Set padding in listTitleTextField
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 2.0))
        shoppingListTitleTextField.leftView = leftView
        shoppingListTitleTextField.leftViewMode = .always
        let bottomLine = UIView(frame: CGRect(x: 0, y: shoppingListTitleTextField.frame.height-1, width: view.frame.width, height: 1))
        bottomLine.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.2)
        shoppingListTitleTextField.addSubview(bottomLine)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        shoppingListsTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        
        //notification view
        notificationView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        notificationView.layer.shadowOpacity = 0.5
        notificationView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        notificationView.isHidden = true
        notificationViewHeightConstraint.constant = 0
        
        notificationButton.layer.cornerRadius = notificationButton.frame.height/2
        
        
        
//        setupRealms()
        
        lists = Array(realm.objects(ShoppingList.self))
    }
    
    //setup realms
    func setupRealms() {
        let list1 = ShoppingList()
        list1.title = "list1"
        
        let list2 = ShoppingList()
        list2.title = "list2"
        
        let element1 = ShoppingListElement()
        element1.name = "element 1"
        list1.elements.append(element1)
        list2.elements.append(element1)
        
        let element2 = ShoppingListElement()
        element2.name = "element 2"
        list1.elements.append(element2)
        list2.elements.append(element1)
        
        let element3 = ShoppingListElement()
        element3.name = "element 3"
        list1.elements.append(element3)
        list2.elements.append(element1)
        
        // Get the default Realm
        let realm = try! Realm()
        
        // Persist your data easily
        try! realm.write {
            realm.add(list1)
            realm.add(list2)
        }
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            addShoppingListViewBottomConstraint.constant = keyboardHeight
            
            self.view.layoutIfNeeded()
            
        }
    }
    
    
    func setupCategoryIconsScrollView() {
        var shoppingListIndex = 0
        
        let numberOfIcons = icons.count-1
        
        let scrollViewWidth = 48 + numberOfIcons * 50 + 20 * numberOfIcons
        shoppingListIconScrollView.contentSize = CGSize(width: scrollViewWidth, height: 50)
        
        for shoppingListIcon in icons {
            
            let button = UIButton(frame: CGRect(x: 16 + shoppingListIndex*65, y: 10, width: 50, height: 50))
            button.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.7921568627, blue: 0.8549019608, alpha: 1)
            button.layer.cornerRadius = button.frame.height/2
            shoppingListIconScrollView.addSubview(button)
            
            shoppingListIndex += 1
        }
    }
    
    
    @IBAction func shoppingListTitleTextFieldEdited(_ sender: Any) {
        if (shoppingListTitleTextField.text?.count)! > 0 {
            saveShoppingListButton.isHidden = false
        } else {
            saveShoppingListButton.isHidden = true
        }
    }
    
    func hideAddShoppingListView() {
        UIView.animate(withDuration: 0.3) {
            self.addNewShoppingListButton.transform = self.addNewShoppingListButton.transform.rotated(by: -CGFloat(Double.pi / 4))
            
            self.blurView.layer.opacity = 0
            self.addShoppingListView.layer.opacity = 0
        }
    }
    
    func showAddShoppingListView() {
        UIView.animate(withDuration: 0.3) {
            self.addNewShoppingListButton.transform = self.addNewShoppingListButton.transform.rotated(by: CGFloat(Double.pi / 4))
            
            self.blurView.layer.opacity = 1
            self.addShoppingListView.layer.opacity = 1
        }
    }
    
    
    
    @IBAction func saveShoppingListButtonPressed(_ sender: Any) {
        hideAddShoppingListView()
        
        addNewShoppingListViewOpen = !addNewShoppingListViewOpen
        
//        if let newList = shoppingListTitleTextField.text {
//            lists.append(newList)
//            shoppingListsTableView.reloadData()
//        }
        
        self.view.endEditing(true)
        
        addShoppingListViewBottomConstraint.constant = 80
    }
    
    
    @IBAction func addNewShoppingListButtonPressed(_ sender: Any) {
        if addNewShoppingListViewOpen {
            hideAddShoppingListView()
        } else {
            showAddShoppingListView()
        }
        
        addNewShoppingListViewOpen = !addNewShoppingListViewOpen
    }
    
    
    
    //MARK:- Setting up lists table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shoppingListsTableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        
        cell.selectionStyle = .none
        
        cell.shoppingListTitleLabel.text = lists[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedList = lists[indexPath.row]
        performSegue(withIdentifier: "goToShoppingList", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
    //prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToShoppingList" {
            let viewController = segue.destination as! ShoppingListViewController
            viewController.selectedList = selectedList
        }
    }

}

