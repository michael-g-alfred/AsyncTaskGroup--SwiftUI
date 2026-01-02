import Foundation

@Observable
@MainActor
final class DataViewModel {
    
    private let apiService = APIService()
    
    var users: [UserModel] = []
    var posts: [PostModel] = []
    
    func fetchData() async throws {
        let (users, posts) = try await fetchUsersAndPosts()
        self.users = users
        self.posts = posts
    }
    
    private func fetchUsersAndPosts() async throws -> ([UserModel], [PostModel]) {
        try await withThrowingTaskGroup(of: Result.self) { group in
            group.addTask {
                let users = try await self.apiService.fetchUsers(
                    url: "https://dummyjson.com/users"
                )
                return .users(users)
            }
            
            group.addTask {
                let posts = try await self.apiService.fetchPosts(
                    url: "https://dummyjson.com/posts"
                )
                return .posts(posts)
            }
            
            var users: [UserModel] = []
            var posts: [PostModel] = []
            
            for try await result in group {
                switch result {
                    case .users(let fetchedUsers):
                        users = fetchedUsers
                    case .posts(let fetchedPosts):
                        posts = fetchedPosts
                }
            }
            
            return (users, posts)
        }
    }
}

    // MARK: - Helper Enum

private enum Result {
    case users([UserModel])
    case posts([PostModel])
}
