//
//  ChatTableViewCell.swift
//  chatapp
//
//  Created by Goel, Archit on 19/07/18.
//  Copyright © 2018 Goel, Archit. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var messageText: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageText.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateMessageText(text: String){
        messageText.text = text
    }

}
