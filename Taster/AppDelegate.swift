//
//  AppDelegate.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        // Inicialização antes de exibir a aplicação ao utilizador.
        FoodRepository.repository.populate()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Invocado quando a aplicação transita para o estado inativo,
        // a caminho do estado em background.
        // Pode ser causado por interrupções temporárias como receber chamada.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // App deve libertar os recursos e guardar os dados de forma a
        // poder reiniciar a aplicação caso esta seja terminada.
        // Apps que suportem execução em background execution, executam este
        // método em vez do applicationWillTerminate: quando o utilizador sai.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Invocado quando app está no estado inativo,
        // em transição de background para ativo.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // (Re)iniciar tarefas que ainda não foram iniciadas ou suspensas
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // A app irá terminar e dados devem ser guardados.
        // Este método não é invocado se a app estiver suspensa.
    }
    
}

