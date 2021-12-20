//
//  ViewModelTedTalkProtocol.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 09/12/2021.
//

import Foundation

protocol ViewModelTedTalkProtocol {
    
    var tedTalks: [TedTalkDisplay]? {get set}
    var tedTalksDisplay: [TedTalkDisplay] {get set}
    var reloadData: (([TedTalkDisplay]) -> ()) { get set }
    var getPickerRows: (([String]) -> ()) { get set }
    
    func filterTalk(filter: String, text: String)
}

