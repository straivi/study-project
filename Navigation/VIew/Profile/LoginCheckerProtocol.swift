//
//  LoginCheckerProtocol.swift
//  StudyProject
//
//  Created by  Matvey on 22.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol LoginCheckerProtocol {

    // MARK: - Functions

    func loginCheck(_ login: String) -> CheckResult

    func passwordCheck(_ password: String) -> CheckResult
}
