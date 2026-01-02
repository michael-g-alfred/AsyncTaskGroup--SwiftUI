import SwiftUI

struct UserView: View {
    
    @Bindable var vm: DataViewModel
    
    var body: some View {
        NavigationStack {
            List(vm.users) { user in
                NavigationLink {
                    UserProfileCard(user: user)
                } label: {
                    UserRow(user: user)
                }
            }
            .navigationTitle("Users")
        }
    }
}
struct UserRow: View {
    
    let user: UserModel
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "person.circle.fill")
                .font(.title2)
                .foregroundStyle(.tint)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(user.firstName) \(user.lastName)")
                    .font(.headline)
                
                Text(user.email)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    UserView(vm: DataViewModel())
}
