import SwiftUI

struct PostView: View {
    
    @Bindable var vm: DataViewModel
    
    var body: some View {
        NavigationStack {
            List(vm.posts) { post in
                NavigationLink {
                    PostDetailView(post: post)
                } label: {
                    PostRow(post: post)
                }
            }
            .navigationTitle("Posts")
        }
    }
}

struct PostRow: View {
    
    let post: PostModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(post.title)
                .font(.headline)
            
            Text(post.body)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(3)
            
                // Tags
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(post.tags, id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.caption2)
                            .padding(4)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
            }
            Spacer()
            
            HStack(alignment: .top) {
                Label("\(post.views)", systemImage: "eye")
                    .font(.caption2)
                    .foregroundStyle(.blue)
                
                Label("\(post.reactions.likes)", systemImage: "hand.thumbsup")
                    .font(.caption2)
                    .foregroundStyle(.green)
                
                Label("\(post.reactions.dislikes)", systemImage: "hand.thumbsdown")
                    .font(.caption2)
                    .foregroundStyle(.red)
                Spacer()
                Text("User: \(post.userID)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 6)
    }
}


#Preview {
    let vm = DataViewModel()
    vm.posts = [
        PostModel(
            id: 1,
            title: "Swift Concurrency",
            body: "Learn how async/await works in Swift and how to use TaskGroups effectively.",
            tags: ["Swift", "Concurrency", "AsyncAwait"],
            reactions: Reactions(likes: 12, dislikes: 1),
            views: 120,
            userID: 101
        ),
        PostModel(
            id: 2,
            title: "SwiftUI Lists",
            body: "How to create dynamic lists in SwiftUI using ForEach and NavigationLink.",
            tags: ["SwiftUI", "List", "Navigation"],
            reactions: Reactions(likes: 25, dislikes: 0),
            views: 200,
            userID: 102
        )
    ]
    return PostView(vm: vm)
}
