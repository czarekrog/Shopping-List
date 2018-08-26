//
//  ShoppingListViewController.swift
//  Shopping List
//
//  Created by Cezary Róg on 23.08.2018.
//  Copyright © 2018 Cezary Róg. All rights reserved.
//

import UIKit
import RealmSwift

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    
    @IBOutlet weak var shoppingListElementsTableView: UITableView!
    @IBOutlet weak var suggestionsTableView: UITableView!
    @IBOutlet weak var suggestionsView: UIView!
    @IBOutlet weak var addNewElementView: UIView!
    
    @IBOutlet weak var addNewElementViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var suggestionsViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var newListElementTextField: UITextField!
    
    var selectedList = ShoppingList()
    
    let suggestions = ["milk", "bread", "something", "mąka", "dupa", "dildo", "dres", "drewno do kominka"]
    
    var filteredSuggestions = [""]
    
    var shoppingListElements : [ShoppingListElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shoppingListElementsTableView.delegate = self
        shoppingListElementsTableView.dataSource = self
        
        suggestionsTableView.delegate = self
        suggestionsTableView.dataSource = self
        
        navigationItem.title = selectedList.title

        suggestionsViewHeightConstraint.constant = 0
        suggestionsView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        suggestionsView.layer.shadowOpacity = 0.5
        suggestionsView.layer.shadowOffset = CGSize(width: 0, height: -2)
        
        addNewElementView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        addNewElementView.layer.shadowOpacity = 0.5
        addNewElementView.layer.shadowOffset = CGSize(width: 0, height: -2)
        
        shoppingListElementsTableView.register(UINib(nibName: "ListElementTableViewCell", bundle: nil), forCellReuseIdentifier: "ListElementCell")
        
        suggestionsTableView.register(UINib(nibName: "SuggestionTableViewCell", bundle: nil), forCellReuseIdentifier: "SuggestionCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        loadListElements()
    }
    
    
    func loadListElements() {
        shoppingListElements = Array(realm.objects(ShoppingListElement.self))
        
    }
    
    
    @IBAction func newListElementTextFieldEdited(_ sender: Any) {
        
        filteredSuggestions.removeAll()
        
        let suggestionPrefix = newListElementTextField.text!
        
        for suggestion in suggestions {
            if suggestion.hasPrefix(suggestionPrefix) && !suggestionPrefix.isEmpty {
                filteredSuggestions.append(suggestion)
            }
        }
        
        if filteredSuggestions.isEmpty {
            suggestionsViewHeightConstraint.constant = 0
        } else {
            if filteredSuggestions.count == 1 {
                suggestionsViewHeightConstraint.constant = 40
            } else if filteredSuggestions.count == 2 {
                suggestionsViewHeightConstraint.constant = 80
            } else {
                suggestionsViewHeightConstraint.constant = 120
            }
        }
        
        suggestionsTableView.reloadData()
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.addNewElementViewBottomConstraint.constant = keyboardHeight
            
            self.view.layoutIfNeeded()
        }
    }

    
    
    //Set Up Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == shoppingListElementsTableView {
            return shoppingListElements.count
        } else {
            return filteredSuggestions.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == shoppingListElementsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListElementCell") as! ListElementTableViewCell
            
            cell.listElementName.text = shoppingListElements[indexPath.row].name
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath) as! SuggestionTableViewCell
            
            cell.suggestionLabel.text = filteredSuggestions[indexPath.row]
            
            cell.addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
            
            return cell
        }
        
    }
    
    @objc func addButtonTapped(_ sender : Any) {
//        shoppingListElements.append(filteredSuggestions[0])

        shoppingListElementsTableView.reloadData()
        
        
        //hide keyboard
        //slide down add element
        //hide suggestions
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == shoppingListElementsTableView {
            return 50
        } else {
            return 40
        }
    }

}
