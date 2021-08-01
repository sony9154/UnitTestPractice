//
//  ValidationServiceSpec.swift
//  Just Start Testing Tests
//
//  Created by Hsu Hua on 2021/8/1.
//  Copyright © 2021 Kilo Loco. All rights reserved.
//

import Quick
import Nimble

@testable import Just_Start_Testing

class ValidationServiceSpec: QuickSpec {
    
    var validation: ValidationService!
    
    override func spec() {
        describe("基本加減乘除") {
            xit("to equal three") {
                expect(1 + 1).to(equal(3))
                // failed - expected to equal <3>, got <2>

                expect(1 + 1).to(equal(3), description: "Make sure libKindergartenMath is loaded")
            }
            
            it("is great") {
                expect(3).to(beGreaterThan(2))
                expect(3) > 2
            }
        }
        
        describe("ValidationService") {
            beforeEach {
                self.validation = ValidationService()
            }
            xit("is vaild username") {
                expect(try self.validation.validateUsername("a")).to(throwError())
                expect(try self.validation.validateUsername("kk")).to(throwError())
                expect(try self.validation.validateUsername("kkkk")).to(equal("kkkk"))
            }
            
            it("is invaild password") {
                expect(try self.validation.validatepassword(nil)).to(throwError())
            }
            
            it("is vaild password") {
                expect(try self.validation.validatepassword("12345678")).to(equal("12345678"))
            }
            
            it("is short password") {
                expect(try self.validation.validatepassword("123")).to(throwError())
            }
            
            it("is too long password") {
                let expectedError = ValidationError.passwordTooLong
                var error: ValidationError?
                let longPwd = "1234567890_1234567890_1234567890"
                expect(try self.validation.validatepassword(longPwd)).to(throwError { thrownError in
                    error = thrownError as? ValidationError
                })
                expect(error?.errorDescription).to(equal(expectedError.errorDescription))
            }
        }
        
    }
}
