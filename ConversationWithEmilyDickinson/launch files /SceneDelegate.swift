//
//  SceneDelegate.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 09/10/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        // TODO:  Handle dark mode
        window.overrideUserInterfaceStyle = .light
        
   //     window.rootViewController = settingsViewController() // Your initial view controller.
     //   window.makeKeyAndVisible()
     //   self.window = window
        
       
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "chevron.left")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "chevron.left")
        UINavigationBar.appearance().barTintColor = UIColor(.gray1)
        UINavigationBar.appearance().tintColor = UIColor(.gray1)

        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
       // let launchedBefore = false

        if launchedBefore{

            let logins = UserDefaults.standard.integer(forKey: "launchedBefore")
            UserDefaults.standard.set(logins + 1, forKey: "LoginCount")
            window.rootViewController = ViewController() // Your initial view controller.
            window.makeKeyAndVisible()
            self.window = window
        }  else
        {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            UserDefaults.standard.set(1, forKey: "LoginCount")
            window.rootViewController = introViewController() // Your initial view controller.
            window.makeKeyAndVisible()
            self.window = window

        }
       
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

