//
//  Result.swift
//  NeonTest
//
//  Created by Sean Tee on 09/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import Foundation
public enum Result<T> {
    case failure(Error)
    case success(T)
    
}
