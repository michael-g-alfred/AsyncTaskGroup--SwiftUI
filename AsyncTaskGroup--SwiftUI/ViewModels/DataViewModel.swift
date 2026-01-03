//import Foundation
//
//@Observable
//@MainActor
//final class DataViewModel {
//    
//    private let apiService = APIService()
//    
//    var users: [UserModel] = []
//    var posts: [PostModel] = []
//    
//    func fetchData() async throws {
//        let (users, posts) = try await fetchUsersAndPosts()
//        self.users = users
//        self.posts = posts
//    }
//    
//    private func fetchUsersAndPosts() async throws -> ([UserModel], [PostModel]) {
//        try await withThrowingTaskGroup(of: Result.self) { group in
//            group.addTask {
//                let users = try await self.apiService.fetchUsers(
//                    url: "https://dummyjson.com/users"
//                )
//                return .users(users)
//            }
//            
//            group.addTask {
//                let posts = try await self.apiService.fetchPosts(
//                    url: "https://dummyjson.com/posts"
//                )
//                return .posts(posts)
//            }
//            
//            var users: [UserModel] = []
//            var posts: [PostModel] = []
//            
//            for try await result in group {
//                switch result {
//                    case .users(let fetchedUsers):
//                        users = fetchedUsers
//                    case .posts(let fetchedPosts):
//                        posts = fetchedPosts
//                }
//            }
//            
//            return (users, posts)
//        }
//    }
//}
//
//    // MARK: - Helper Enum
//
//private enum Result {
//    case users([UserModel])
//    case posts([PostModel])
//}
//

    // MARK: -  Improvement 01
//import Foundation
//
//@Observable
//@MainActor
//final class DataViewModel {
//    
//    private let apiService = APIService()
//    
//    var users: [UserModel] = []
//    var posts: [PostModel] = []
//    
//    func fetchData() async throws {
//        
//        async let usersTask = apiService.fetchUsers(
//            url: "https://dummyjson.com/users"
//        )
//        
//        async let postsTask = apiService.fetchPosts(
//            url: "https://dummyjson.com/posts"
//        )
//        
//        let (users, posts) = try await (usersTask, postsTask)
//        
//        self.users = users
//        self.posts = posts
//    }
//}

    // MARK: - Improvement 02
import Foundation

@Observable
final class DataViewModel {
    
    private let apiService = APIService()
    
    @MainActor
    var users: [UserModel] = []
    
    @MainActor
    var posts: [PostModel] = []
    
    func fetchData() async throws {
        
        async let usersTask = apiService.fetchUsers(
            url: "https://dummyjson.com/users"
        )
        
        async let postsTask = apiService.fetchPosts(
            url: "https://dummyjson.com/posts"
        )
        
        let (users, posts) = try await (usersTask, postsTask)
        
        await MainActor.run {
            self.users = users
            self.posts = posts
        }
    }
}

