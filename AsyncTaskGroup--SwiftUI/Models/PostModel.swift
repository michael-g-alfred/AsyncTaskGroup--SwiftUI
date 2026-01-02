import Foundation

struct PostsResponse: Codable {
    let posts: [PostModel]
    let total, skip, limit: Int
}

struct PostModel: Codable, Identifiable {
    let id: Int
    let title, body: String
    let tags: [String]
    let reactions: Reactions
    let views, userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, body, tags, reactions, views
        case userID = "userId"
    }
}

struct Reactions: Codable {
    let likes, dislikes: Int
}
