//
//  Review.swift
//  ModernLayout
//
//  Created by 황민채 on 7/14/24.
//

import Foundation

struct ReviewListModel: Decodable {
    let page: Int
    let results: [ReviewModel]
}


struct ReviewModel: Decodable, Hashable {
    
    public let id: String
    public let author: Reviewer
    public let createdDate: Date?
    public let content: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case author = "author_details"
        case createdDate = "created_at"
        case rating
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.author = try container.decode(Reviewer.self, forKey: .author)
        let dateString = try container.decode(String.self, forKey: .createdDate)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        createdDate = dateFormatter.date(from: dateString)
        self.content = try container.decode(String.self, forKey: .content)
    }
}

struct Reviewer: Decodable, Hashable {
    public let name: String
    public let username: String
    public let rating: Int
    public let imageURL: String
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case rating
        case imageURL = "avatar_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.username = try container.decode(String.self, forKey: .username)
        self.rating = try container.decode(Int.self, forKey: .rating)
        if let path = try container.decodeIfPresent(String.self, forKey: .imageURL) {
            self.imageURL = "https://image.tmdb.org/t/p/w500\(path)"
        } else {
            self.imageURL = ""
        }

    }
}
