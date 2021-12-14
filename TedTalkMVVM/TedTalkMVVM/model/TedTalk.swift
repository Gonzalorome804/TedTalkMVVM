//
//  TedTalk.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 09/12/2021.
//

import Foundation

struct TedTalk: Decodable{
    
    var comments: Int
    var description: String
    var duration: Int
    var event: String
    var film_date: Int
    var languages: Int
    var main_speaker: String
    var name: String
    var num_speaker: Int
    var published_date: Int
    var speaker_occupation: String
    var tags: [String]
    var title: String
    var url: String
    var views: Int
    
    func isFiltered(_ filterBy: String, input: String) -> Bool{
        
        switch filterBy {
        case "Event":
            return self.event.contains(input)
        case "Main Speaker":
            return self.main_speaker.contains(input)
        case "Title":
            return self.title.contains(input)
        case "Name":
            return self.name.contains(input)
        case "Description":
            return self.description.contains(input)
        case "Any":
            return self.event.contains(input) || self.main_speaker.contains(input) ||   self.title.contains(input) || self.name.contains(input) || self.description.contains(input)
        default:
            return true
        }
    }
    
    func ParseDisplay() -> TedTalkDisplay{
        return TedTalkDisplay(main_speaker: main_speaker, description: description, name: name, tags: tags, title: title, url: url, views: views)
    }
}

