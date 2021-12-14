//
//  ViewModelDetail.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 13/12/2021.
//

import Foundation

class viewModelDetail: ViewModelProtocolDetail {
    
    internal var indexTedTalkDisplay: Int = 0
    internal var observerTedTalkDetailDisplay: ((ViewModelProtocolDetail) -> ())
    var tedTalkManager: DisplayManagerTedTalk
    
    init(tedTalkManager: DisplayManagerTedTalk, observerTedTalk: @escaping (ViewModelProtocolDetail) -> ()) {
        self.tedTalkManager = tedTalkManager
        self.observerTedTalkDetailDisplay = observerTedTalk
    }
    
    func getPreviousTedTalkDetail() {
        if indexTedTalkDisplay > 0 {
            indexTedTalkDisplay-=1
        }
        observerTedTalkDetailDisplay(self)
    }
    
    func getNextTedTalkDetail() {
        if indexTedTalkDisplay < tedTalkManager.getTedTalkDisplayCount() - 1 {
            indexTedTalkDisplay+=1
        }
        observerTedTalkDetailDisplay(self)    }
    
    func getTedTalkDetailsDisplay() -> TedTalkDisplay {
        tedTalkManager.getTedTalkDisplayDetail(tedTalkDisplayDetailIndex: indexTedTalkDisplay)
    }
}

