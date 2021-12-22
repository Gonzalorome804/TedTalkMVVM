//
//  TableCustomCellTedTalk.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 09/12/2021.
//

import UIKit

class TableCustomCellTedTalk : UITableViewCell {
    
    @IBOutlet weak var mainSpeakerCellLabel: UILabel!
    @IBOutlet weak var descriptionCellLabel: UILabel!
    
    func configureCell(_ talk: TedTalkDisplay){
        mainSpeakerCellLabel.text = "Main Speaker: \(talk.main_speaker)"
        descriptionCellLabel.text = talk.descrip
    }
}

