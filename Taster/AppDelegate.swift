//
//  AppDelegate.swift
//  Taster
//
//  Copyright © 2015 Empresa Imaginada. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Inicialização antes de exibir a aplicação ao utilizador.
        FoodRepository.repository.populate()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Invocado quando a aplicação transita para o estado inativo,
        // a caminho do estado em background.
        // Pode ser causado por interrupções temporárias como receber chamada.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // App deve libertar os recursos e guardar os dados de forma a
        // poder reiniciar a aplicação caso esta seja terminada.
        // Apps que suportem execução em background execution, executam este
        // método em vez do applicationWillTerminate: quando o utilizador sai.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Invocado quando app está no estado inativo,
        // em transição de background para ativo.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // (Re)iniciar tarefas que ainda não foram iniciadas ou suspensas
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // A app irá terminar e dados devem ser guardados.
        // Este método não é invocado se a app estiver suspensa.
    }
    
}

