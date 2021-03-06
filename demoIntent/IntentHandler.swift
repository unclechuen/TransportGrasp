//
//  IntentHandler.swift
//  DemoIntent
//
//  Created by Johnny on 20/8/2021.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any? {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        guard intent is ETAIntent else{
            return .none
        }
        
        return ETAIntentHandler()
    }
    
}
