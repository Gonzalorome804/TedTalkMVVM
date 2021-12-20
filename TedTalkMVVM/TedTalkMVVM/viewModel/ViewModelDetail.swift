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
    internal var observerPreviousAndNextTedTalkDetail: ((Bool, Bool) -> ())
    
    init(tedTalkManager: DisplayManagerTedTalk, observerTedTalk: @escaping (ViewModelProtocolDetail) -> (),observerTedTalkButtons: @escaping (Bool, Bool) -> ()) {
        self.tedTalkManager = tedTalkManager
        self.observerTedTalkDetailDisplay = observerTedTalk
        self.observerPreviousAndNextTedTalkDetail = observerTedTalkButtons
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
        if indexTedTalkDisplay == tedTalkManager.getTedTalkDisplayCount(){
            observerPreviousAndNextTedTalkDetail(true, false)
        }
        if indexTedTalkDisplay == 0{
            observerPreviousAndNextTedTalkDetail(false,true)        }
        else {
            observerPreviousAndNextTedTalkDetail(true,true)
        }
        return tedTalkManager.getTedTalkDisplayDetail(tedTalkDisplayDetailIndex: indexTedTalkDisplay)
    }
}

