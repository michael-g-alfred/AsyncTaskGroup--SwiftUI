import SwiftUI

struct UserProfileCard: View {
    let user: UserModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                    // Header Section - Extended from top
                ZStack(alignment: .center) {
                    LinearGradient(
                        colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 280)
                    .ignoresSafeArea(edges: .top)
                    
                    VStack(spacing: 12) {
                        AsyncImage(url: URL(string: user.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 40))
                                )
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        
                        VStack(spacing: 4) {
                            Text("\(user.firstName) \(user.lastName)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("@\(user.username)")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                }
                
                VStack(spacing: 16) {
                        // Role Badge
                    HStack {
                        Spacer()
                        RoleBadge(role: user.role)
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                        // Personal Info Section
                    InfoSection(title: "Personal Information", icon: "person.fill", color: .blue) {
                        InfoRow(icon: "calendar", label: "Age", value: "\(user.age) years")
                        InfoRow(icon: "figure.stand", label: "Gender", value: user.gender.capitalized)
                        InfoRow(icon: "drop.fill", label: "Blood Type", value: user.bloodGroup)
                        InfoRow(icon: "eye.fill", label: "Eye Color", value: user.eyeColor)
                        InfoRow(icon: "scissors", label: "Hair", value: "\(user.hair.color) • \(user.hair.type)")
                    }
                    
                        // Contact Section
                    InfoSection(title: "Contact", icon: "envelope.fill", color: .green) {
                        InfoRow(icon: "envelope", label: "Email", value: user.email)
                        InfoRow(icon: "phone.fill", label: "Phone", value: user.phone)
                    }
                    
                        // Location Section
                    InfoSection(title: "Location", icon: "map.fill", color: .orange) {
                        InfoRow(icon: "house.fill", label: "Address", value: user.address.address)
                        InfoRow(icon: "building.2.fill", label: "City", value: "\(user.address.city), \(user.address.stateCode)")
                        InfoRow(icon: "mappin.circle.fill", label: "Postal", value: user.address.postalCode)
                    }
                    
                        // Professional Section
                    InfoSection(title: "Professional", icon: "briefcase.fill", color: .purple) {
                        InfoRow(icon: "building.2", label: "Company", value: user.company.name)
                        InfoRow(icon: "person.badge.key.fill", label: "Title", value: user.company.title)
                        InfoRow(icon: "folder.fill", label: "Department", value: user.company.department)
                        InfoRow(icon: "graduationcap.fill", label: "University", value: user.university)
                    }
                    
                        // Banking Section
                    InfoSection(title: "Banking", icon: "creditcard.fill", color: .indigo) {
                        InfoRow(icon: "creditcard", label: "Card Type", value: user.bank.cardType)
                        InfoRow(icon: "dollarsign.circle.fill", label: "Currency", value: user.bank.currency)
                        InfoRow(icon: "calendar.badge.clock", label: "Expires", value: user.bank.cardExpire)
                    }
                    
                        // Crypto Section
                    InfoSection(title: "Cryptocurrency", icon: "bitcoinsign.circle.fill", color: .yellow) {
                        InfoRow(icon: "bitcoinsign.circle", label: "Coin", value: user.crypto.coin)
                        InfoRow(icon: "network", label: "Network", value: user.crypto.network)
                    }
                }
                .padding()
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

    // MARK: - Supporting Views

struct RoleBadge: View {
    let role: String
    
    var roleColor: Color {
        switch role.lowercased() {
            case "admin": return .red
            case "moderator": return .orange
            default: return .gray
        }
    }
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: roleIcon)
                .font(.caption)
            Text(role.uppercased())
                .font(.caption)
                .fontWeight(.semibold)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(roleColor)
        .clipShape(Capsule())
    }
    
    var roleIcon: String {
        switch role.lowercased() {
            case "admin": return "star.fill"
            case "moderator": return "shield.fill"
            default: return "person.fill"
        }
    }
}

struct InfoSection<Content: View>: View {
    let title: String
    let icon: String
    let color: Color
    let content: Content
    
    init(title: String, icon: String, color: Color, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.headline)
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .padding(.bottom, 4)
            
            VStack(spacing: 12) {
                content
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

struct InfoRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 20)
            
            Text(label)
                .foregroundColor(.secondary)
                .frame(width: 80, alignment: .leading)
            
            Text(value)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
        }
        .font(.subheadline)
    }
}

    // MARK: - Preview

struct UserProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileCard(user: sampleUser)
    }
    
    static let sampleUser = UserModel(
        id: 1,
        firstName: "Emily",
        lastName: "Johnson",
        maidenName: "Smith",
        age: 28,
        gender: "female",
        email: "emily.johnson@x.dummyjson.com",
        phone: "+81 965-431-3024",
        username: "emilys",
        password: "emilyspass",
        birthDate: "1996-5-30",
        image: "https://dummyjson.com/icon/emilys/128",
        bloodGroup: "O-",
        height: 193.24,
        weight: 63.16,
        eyeColor: "Green",
        hair: Hair(color: "Brown", type: "Curly"),
        ip: "42.48.100.32",
        address: Address(
            address: "626 Main Street",
            city: "Phoenix",
            state: "Mississippi",
            stateCode: "MS",
            postalCode: "29112",
            coordinates: Coordinates(lat: -77.16213, lng: -92.084824),
            country: "United States"
        ),
        macAddress: "47:fa:41:18:ec:eb",
        university: "University of Wisconsin--Madison",
        bank: Bank(
            cardExpire: "03/26",
            cardNumber: "9289760655481815",
            cardType: "Elo",
            currency: "CNY",
            iban: "YPUXISOBI7TTHPK2BR3HAIXL"
        ),
        company: Company(
            department: "Engineering",
            name: "Dooley, Kozey and Cronin",
            title: "Sales Manager",
            address: Address(
                address: "263 Tenth Street",
                city: "San Francisco",
                state: "Wisconsin",
                stateCode: "WI",
                postalCode: "37657",
                coordinates: Coordinates(lat: 71.814525, lng: -161.150263),
                country: "United States"
            )
        ),
        ein: "977-175",
        ssn: "900-590-289",
        userAgent: "Mozilla/5.0",
        crypto: Crypto(
            coin: "Bitcoin",
            wallet: "0xb9fc2fe63b2a6c003f1c324c3bfa53259162181a",
            network: "Ethereum (ERC20)"
        ),
        role: "admin"
    )
}
