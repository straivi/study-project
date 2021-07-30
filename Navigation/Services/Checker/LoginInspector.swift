//
//  LoginInspector.swift
//  StudyProject
//
//  Created by  Matvey on 22.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class LoginInspector: LoginCheckerProtocol {

    // MARK: - Functions

    func loginCheck(_ login: String) -> CheckResult {
        return Checker.instance.loginCheck(login)
    }

    func passwordCheck(_ password: String) -> CheckResult {
        return Checker.instance.passwordCheck(password)
    }


}
