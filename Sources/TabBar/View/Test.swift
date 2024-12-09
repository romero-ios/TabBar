import SwiftUI

public struct ButtonTabBarStyle: TabBarStyle {
    public init() {}
    
    public func tabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        itemsContainer()
            .frame(height: 50)
            .padding(.top, 12)
            .padding(.horizontal, 20)
            .padding(.bottom, geometry.safeAreaInsets.bottom)
            .background(.ultraThinMaterial)
    }
}

public struct ButtonTabItemStyle: TabItemStyle {
    public init() {}
    
    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        TabBarItem(image: Image(systemName: icon), title: title, isSelected: isSelected)
    }
}

struct TabBarItem: View {
    @Environment(\.colorScheme) var colorScheme
    
    let image: Image
    let title: String
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            image
                .offset(x: isSelected ? 0 : 4)
            
            Text(title)
                .font(.body)
                .opacity(isSelected ? 1 : 0)
                .rotationEffect(isSelected ? .zero : .degrees(-120))
                .offset(x: isSelected ? .zero : -40)
        }
        .frame(width: isSelected ? 100 : 30)
        .frame(height: 40)
        .padding(8)
        .background(isSelected ? Color.blue : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundStyle(foregroundColor)
        .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.4), value: isSelected)
    }
    
    private var foregroundColor: Color {
        switch colorScheme {
        case .dark:
            return isSelected ? .black : .white
        default:
            return isSelected ? .white : .black
        }
    }
}

private enum DemoTab: Tabbable {
    case one, two, three, four, five
    
    var icon: String {
        switch self {
        case .one:
            "person"
        case .two:
            "gear"
        case .three:
            "chart.bar"
        case .four:
            "chart.pie"
        case .five:
            "chart.bar.fill"
        }
    }
    
    var title: String {
        switch self {
        case .one:
            return "Profile"
        case .two:
            return "Settings"
        case .three:
            return "Analytics"
        case .four:
            return "Categories"
        case .five:
            return "Reports"
        }
    }
}

#Preview {
    @Previewable @State var selectedTab: DemoTab = .one
    
    TabBar(selection: $selectedTab) {
        Form {
            Text("Hello")
            Text("Cool")
        }
        .tabItem(for: DemoTab.one)
        
        List(0..<30) { index in
            Text("Index: \(index)")
        }
        .tabItem(for: DemoTab.two)

        Rectangle()
            .tabItem(for: DemoTab.three)

        List(0..<30) { index in
            Text("Index shit: \(index)")
        }
        .tabItem(for: DemoTab.four)

        List(0..<30) { index in
            Text("Index fuck: \(index)")
        }
        .tabItem(for: DemoTab.five)
    }
    .tabBar(style: ButtonTabBarStyle())
    .tabItem(style: ButtonTabItemStyle())
}

