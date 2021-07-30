//
//  Checker.swift
//  StudyProject
//
//  Created by  Matvey on 22.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class Checker {

    // MARK: - Properties

    static var instance = Checker()

    // MARK: - Private properties

    private let login = "Matvey"
    private let password = "qwerty"

    // MARK: - Construction

    private init () {}

	// MARK: - Function

	func loginCheck(_ login: String) -> CheckResult {
		return login == self.login ? .success : .error
	}

	func passwordCheck(_ password: String) -> CheckResult {
		return password == self.password ? .success : .error
	}
}
