import SwiftUI

struct DashboardCard: View {
    var title: String
    var value: Int
    var icon: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.system(size: 28))
                .frame(width: 44, height: 44)
                .background(Color.indigo)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.85))
                Text("\(value)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }

            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.9), Color.blue.opacity(0.7)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
        )
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}
