//
//  ChatViewController.swift
//  chatapp
//
//  Created by Goel, Archit on 18/07/18.
//  Copyright © 2018 Goel, Archit. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var selectedUser: ChatUser?
    var cellHeight = 44

    @IBOutlet weak var chatTableView: UITableView!

    @IBOutlet weak var userMessageInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.estimatedRowHeight = 88.0
        chatTableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PostManager.fillPosts(uid: FirebaseManager.currentUser?.uid, toId:(selectedUser?.uid)!) {  (result:String) in
            DispatchQueue.main.async {
                self.chatTableView.reloadData()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PostManager.posts = []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PostManager.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatcell", for: indexPath) as! ChatTableViewCell
        
        cell.messageText.delegate = self
        let post = PostManager.posts[indexPath.row]
        cellHeight = Int(cell.messageText.contentSize.height)
        cell.messageText.text = post.text
        cell.messageText.isScrollEnabled = false
        cell.messageText.layoutIfNeeded()

        cell.messageText.endEditing(true)
        return cell
    }
    
   
    @IBAction func sendBtn_Clicked(_ sender: Any) {
        PostManager.addPost(username: (selectedUser?.username)!, text: userMessageInput.text!, toId: (selectedUser?.uid)!, fromId: (FirebaseManager.currentUser?.uid)!)
        userMessageInput.text = ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = chatTableView.contentOffset
        UIView.setAnimationsEnabled(false)
        chatTableView.beginUpdates()
        chatTableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        chatTableView.setContentOffset(currentOffset, animated: false )
        
    }
}


