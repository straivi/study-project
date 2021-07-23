//
//  LoginInspector.swift
//  StudyProject
//
//  Created by  Matvey on 22.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {

    // MARK: - Functions

    func loginCheck(_ login: String) -> CheckResult {
        return login == Checker.instance.login ? .success : .error
    }

    func passwordCheck(_ password: String) -> CheckResult {
        return password == Checker.instance.password ? .success : .error
    }


}
