//
//  FriendsTableViewController.swift
//  SocialProject
//
//  Created by Irina Kuligina on 11.06.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchView: UISearchBar!
    
    var sections: [Character] = []             // Массив букв для выделения секций
    var userData: [Character: [User]] = [:]    // Словарь для получения массива пользователей по букве секции
    var searchData: [Character: [User]] = [:]  // Такой же как и userData, только при использовании UISearchBar
    var searchSections: [Character] = []       // Такой же как и sections, используется при UISearchBar
    
    private let reuseIdentifier = "CustomTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.delegate = self
        
        view.backgroundColor = Colors.palePurplePantone
        tableView.sectionIndexBackgroundColor = Colors.palePurplePantone
        
        getUserData()
        resetSearchTableViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserData()
        resetSearchTableViewData()
    }
    
    func getUserData() {
        userData = [:]
        var sectionSet: Set<Character> = []
        for user in User.database {
            if let letter = user.name.first {
                sectionSet.insert(letter)
                
                if userData[letter] == nil {
                    userData[letter] = []
                }
                
                userData[letter]?.append(user)
            }
        }
        sections = sectionSet.sorted()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionLetter = searchSections[section]
        let users = searchData[sectionLetter] ?? []
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(searchSections[section])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CustomTableViewCell
        
        let sectionLetter = searchSections[indexPath.section]
        let user = searchData[sectionLetter]![indexPath.row]
        cell.setValues(item: user)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //if #available(iOS 13.0, *) {
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FriendsCollectionViewController") as! FriendsCollectionViewController
//    
//        
//        let sectionLetter = searchSections[indexPath.section]
//    var _ = searchData[sectionLetter]![indexPath.row]
//        

//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return searchSections.map { String($0) }
//    }
//    
    // MARK: - SearchBar setup
    
    func resetSearchTableViewData() {
        searchSections = sections
        searchData = userData
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchData = [:]
        searchSections = []
        var sectionSearchSet: Set<Character> = []
        
        if searchText.isEmpty {
            resetSearchTableViewData()
        } else {
            for section in sections {
                let userArray = userData[section] ?? []
                
                for user in userArray {
                    if user.name.lowercased().contains(searchText.lowercased()) {
                        if searchData[section] == nil {
                            searchData[section] = []
                        }
                        sectionSearchSet.insert(section)
                        searchData[section]?.append(user)
                    }
                }
            }
            
            searchSections = Array(sectionSearchSet).sorted()
         }

        self.tableView.reloadData()
    }}
