//
//  iRecipeApp.swift
//  iRecipe
//
//  Created by Meng Li on 07/02/2026.
//

import SwiftUI
import SwiftData
import Swinject

@main
struct iRecipeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
        initEagerObjects()
        
        return true
    }
    
    private func registerManagers() {
        AppDelegate.container.register(RecipeServiceProtocol.self) { _ in
            return RecipeService()
        }.inObjectScope(.container)
//
//        AppDelegate.container.register(AdsManagerProtocol.self) { resolver in
//            return AdsManager(userSettingManager: resolver.resolve(UserSettingManagerProtocol.self)!,
//                              remoteConfigService: resolver.resolve(RemoteConfigServiceProtocol.self)!)
//        }.inObjectScope(.container)
//
//        AppDelegate.container.register(TimeServiceProtocol.self) { _ in
//            return TimeService()
//        }.inObjectScope(.container)
    }
    
    private func initEagerObjects() {
//        _ = AppDelegate.container.resolve(RemoteConfigServiceProtocol.self)
//        _ = AppDelegate.container.resolve(AdsManagerProtocol.self)
    }
}
