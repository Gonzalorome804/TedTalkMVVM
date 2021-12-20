//
//  ViewModelDetailProtocol.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 13/12/2021.
//

import Foundation

protocol ViewModelProtocolDetail {
    
    var indexTedTalkDisplay: Int { get set }
    var observerTedTalkDetailDisplay: ((ViewModelProtocolDetail) -> ()) { get set }
    var tedTalkManager: DisplayManagerTedTalk { get set }
    
    func getPreviousTedTalkDetail()
    func getNextTedTalkDetail()
    func getTedTalkDetailsDisplay() -> TedTalkDisplay
}

