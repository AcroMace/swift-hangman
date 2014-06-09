//
//  SwiftInput.swift
//  SwiftHangman
//
//  Created by Andy Cho on 2014-06-07.
//  Copyright (c) 2014 Andy Cho. All rights reserved.
//

import Foundation

// Input function from StackOverflow:
// http://stackoverflow.com/questions/24004776/input-from-the-keyboard-in-command-line-application

func input() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    return NSString(data: inputData, encoding: NSUTF8StringEncoding)
}
