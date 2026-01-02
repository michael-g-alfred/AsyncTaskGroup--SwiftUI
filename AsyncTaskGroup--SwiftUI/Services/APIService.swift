import Foundation

final class APIService {
    
    func fetchPosts(url: String) async throws -> [PostModel] {
        let url = try makeURL(from: url)
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(PostsResponse.self, from: data)
        return response.posts
    }
    
    func fetchUsers(url: String) async throws -> [UserModel] {
        let url = try makeURL(from: url)
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(UsersResponse.self, from: data)
        return response.users
    }
    
        // DRY
    private func makeURL(from string: String) throws -> URL {
        guard let url = URL(string: string) else {
            throw URLError(.badURL)
        }
        return url
    }
}
