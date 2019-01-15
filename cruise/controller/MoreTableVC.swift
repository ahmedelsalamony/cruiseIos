//
//  MoreTableVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/30/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit

class MoreTableVC: UITableViewController  {

    
    @IBOutlet var moreTableView: UITableView!
    
    //vars
    let moreTableDataSource = ["الملف الشخصى","طلباتى","تواصل معنا","الشروط والاحكام","تسجيل الخروج"]
    
    
    override func viewWillAppear(_ animated: Bool) {
        if ((UserDefaults.standard.string(forKey: "userId")) == nil){
            let alert = UIAlertController(title: "كروز", message: "من فضلك سجل الدخول اولا", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    guard let window = UIApplication.shared.keyWindow else {return}
                    let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginvc")
                    window.rootViewController = sb
                    UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                    
                }}))
            alert.addAction(UIAlertAction(title: "تخطى", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "homeVC") as! ClientHomeController
                    self.navigationController?.pushViewController(newViewController, animated: true)
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        ////////////////////
        self.moreTableView.delegate = self
        self.moreTableView.dataSource = self
        
        self.moreTableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moreTableDataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreCell", for: indexPath)
        cell.textLabel?.text = moreTableDataSource[indexPath.row]
        return cell
    }
   
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "profilevc") as! ProfileVC
            newViewController.hidesBottomBarWhenPushed = false
            navigationController?.pushViewController(newViewController, animated: true)
        }else if (indexPath.row == 1){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "purchases") as! PurchasesVC
            newViewController.hidesBottomBarWhenPushed = false
            navigationController?.pushViewController(newViewController, animated: true)
        }else if (indexPath.row == 2){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "contactus") as! ContactUs
            newViewController.hidesBottomBarWhenPushed = false
            navigationController?.pushViewController(newViewController, animated: true)
        }else if (indexPath.row == 3){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "terms") as! TermsVC
            newViewController.hidesBottomBarWhenPushed = false
            navigationController?.pushViewController(newViewController, animated: true)
        }else if (indexPath.row == 4){
            LoginServices.instance.logout { (success) in
                if success {
                    guard let window = UIApplication.shared.keyWindow else {return}
                    let sb = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                    window.rootViewController = sb
                    UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
                }
            }
        }
    }
   

}
