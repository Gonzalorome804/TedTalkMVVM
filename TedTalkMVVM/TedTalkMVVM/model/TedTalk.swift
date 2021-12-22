//
//  TedTalk.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 09/12/2021.
//

import Foundation
import RealmSwift

class TedTalk: Object, Decodable{
    
    @objc dynamic var comments = 0
    @objc dynamic var descrip = ""
    @objc dynamic var duration = 0
    @objc dynamic  var event = ""
    @objc dynamic var film_date = 0
    @objc dynamic var languages = 0
    @objc dynamic var main_speaker = ""
    @objc dynamic var name = ""
    @objc dynamic var num_speaker = 0
    @objc dynamic var published_date = 0
    @objc dynamic var speaker_occupation = ""
    var tags = List<String>()
    @objc dynamic var title = ""
    @objc dynamic var url = ""
    @objc dynamic var views = 0
    
    enum CodingKeys: String, CodingKey{
        case comments, duration, event,tags, film_date,languages,main_speaker,name,num_speaker,published_date,speaker_occupation,title,url,views
        case descrip = "description"
    }
    
    convenience init(_ comments: Int, _ duration: Int, _ event: String, _ descrip: String, _ film_date: Int, _ languages: Int, _ main_speaker: String, _ name: String, _ num_speaker: Int, _ published_date: Int, _ speaker_occupation: String, _ tags: String, _ title: String, _ url: String, _ views: Int ) {
        self.init()
        self.comments = comments
        self.descrip = descrip
        self.duration = duration
        self.event = event
        self.film_date = film_date
        self.languages = languages
        self.main_speaker = main_speaker
        self.name = name
        self.num_speaker = num_speaker
        self.published_date = published_date
        self.speaker_occupation = speaker_occupation
        self.tags.append(tags)
        self.title = title
        self.url = url
        self.views = views
        
    }
    
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
            return self.descrip.contains(input)
        case "Any":
            return self.event.contains(input) || self.main_speaker.contains(input) ||   self.title.contains(input) || self.name.contains(input) || self.descrip.contains(input)
        default:
            return true
        }
    }
    
    func ParseDisplay() -> TedTalkDisplay{
        return TedTalkDisplay(main_speaker: main_speaker, name: name,descrip: descrip, tags: Array(tags),title: title, url: url, views: views)
    }
}

