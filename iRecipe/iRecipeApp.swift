//
//  iRecipeApp.swift
//  iRecipe
//
//  Created by Meng Li on 07/02/2026.
//

import SwiftUI
import SwiftData
import Swinject

enum AppEnvironment {
    static func configureForUITests() {
        AppDelegate.container.removeAll()

        AppDelegate.container.register(RecipeServiceProtocol.self) { _ in
            MockRecipeService()
        }
    }
}

@main
struct iRecipeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        if ProcessInfo.processInfo.arguments.contains("-ui-testing") {
            AppEnvironment.configureForUITests()
        }
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    static let container = Container()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        registerManagers()
        
        return true
    }
    
    private func registerManagers() {
        guard ProcessInfo.processInfo.arguments.contains("-ui-testing") == false else { return }
        
        // Dependency Injection
        
        AppDelegate.container.register(APIConfigProtocol.self) { _ in
            return APIConfig()
        }.inObjectScope(.container)
        
        AppDelegate.container.register(NetworkClientProtocol.self) { resolver in
            return NetworkClient(apiConfig: resolver.resolve(APIConfigProtocol.self)!)
        }.inObjectScope(.container)
        
        AppDelegate.container.register(RecipeServiceProtocol.self) { resolver in
            return RecipeService(networkClient: resolver.resolve(NetworkClientProtocol.self)!)
        }.inObjectScope(.container)
    }
}
