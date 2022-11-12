//
//  ResponseResultType.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

enum ResponseResultType {
    case Success
    case DuplicatePhoneNumber
    case EmptyPhoneNumber
    case EmptyPassword
    case EmptyAddress
    case EmptyActivationCode
    case EmptyDriverId
    case EmptyDriverRequestId
    case EmptyUserRequestId
    case InvalidActivationCode
    case InvalidParameters
    case IncorrectPhoneNumber
    case IncorrectPassword
    case InputsNotComplete
    case UserNotFound
    case DriverNotFound
    case ServerError
    case NotEnoughBalance
    case NotAllowedOperation
    case SenderNotDefined
    case ReceiverNotDefined
    case CustomerIdNotDefined
    case ReceiverIdNotDefined
    case TrashAmountNotDefined
    case TrashTypeNotDefined
    case DevidedTypeNotDefined
    case BadRequest
    case Unauthorized
    case UnknownError
}
