//
//  Constants.swift
//  Afra_Driver
//
//  Created by Macbook on 6/4/19.
//  Copyright © 2019 Macbook. All rights reserved.
//


import Foundation
import UIKit

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "http://my-money.ir/farazist/public/api/"
let URL_TRASHES_TYPE = "\(BASE_URL)v1/trash?userType=1"
let URL_REGISTER = "\(BASE_URL)v1/users/register"
let URL_ACTIVATION = "\(BASE_URL)v1/users/activate"
let URL_LOGIN = "\(BASE_URL)v1/users/login"
let URL_USER_PROFILE = "\(BASE_URL)v1/users/user"
let URL_RESET_PASSWORD = "\(BASE_URL)v1/users/reset_pass"
let URL_CHANGE_PASSWORD = "\(BASE_URL)v1/users/change_pass"
let URL_CHECK_TOKEN = "\(BASE_URL)v1/user/token"
let URL_UPDATE_PROFILE = "\(BASE_URL)v1/users/profile"
let URL_GET_SAVED_ADDRESSES = "\(BASE_URL)v1/users/saved_addresses"
let URL_TRANSACTIONS = "\(BASE_URL)v1/users/transactions"
let URL_UPDATE_FIREBASE_TOKEN = "\(BASE_URL)v1/users/update_firebase_token"
let URL_TRASHES = "\(BASE_URL)v1/trash"
let URL_RECYCLING_TRASH_REQUEST = "\(BASE_URL)v1/user_request"
let URL_UPDATE_RECYCLE_REQUEST_STATUS = "\(BASE_URL)v1/user_request/update_status"
let URL_CANCEL_RECYCLE_REQUEST = "\(BASE_URL)v1/user_request/cancel_request"
let URL_ACCEPT_DELIVERED_TRASHES_TO_DRIVER = "\(BASE_URL)v1/user_request/accept_deliver"
let URL_GET_ALL_CANCEL_REASONS = "\(BASE_URL)v1/cancel_reasons"
let URL_GET_ALL_USER_MESSAGES = "\(BASE_URL)v1/messages?userCategory=user"
let URL_GET_ALL_DRIVER_MESSAGES = "\(BASE_URL)v1/messages?userCategory=driver"
let URL_DELETE_SAVED_ADDRESS = "\(BASE_URL)v1/saved_address"

let MESSAGE_INCORRECT_PHONE_NUMBER = "فرمت شماره همراه اشتباه است!"
let MESSAGE_PHONE_NUMBER_NOT_INTERED = "شماره همراه وارد نشده است!"
let MESSAGE_DUPLICATE_PHONE_NUMBER = "شماره همراه تکراری است!"
let MESSAGE_INTERNAL_SERVER_ERROR = "در سرور خطایی رخ داده است!"
let MESSAGE_ACTIVATION_CODE_NOT_INERED = "کد فعالسازی وارد نشده است!"
let MESSAGE_USER_NOT_FOUND = "کاربری با این مشخصات وجود ندارد!"
let MESSAGE_USER_WITH_THISPHONENUMBER_NOT_FOUND = "کاربری با این شماره همراه ثبت نشده است!"
let MESSAGE_INVALID_ACTIVATION_CODE = "کد فعالسازی نا معتبر است!"
let MESSAGE_PASSWORD_NOT_INERED = "رمز عبور وارد نشده است!"
let MESSAGE_INCORRECT_PASSWORD = "رمز عبور اشتباه است!"
let MESSAGE_USER_NOT_ACCESS_THIS_OPERATION = "کاربر به این عملیات دسترسی ندارد!"
let MESSAGE_INPUT_IS_LOW = "اطلاعات ورودی ناقص است!"
let MESSAGE_NOT_ENOUTH_BALANCE = "میزان اعتبار شما کافی نیست!"
let MESSAGE_NOT_ALLOWED_OPERATION = "شما مجاز به انجام این عملیات نیست!"
let MESSAGE_SENDER_NOT_SPECIFIED = "فرستنده مشخص نیست!"
let MESSAGE_RECEIVER_NOT_SPECIFIED = "گیرنده مشخص نیست!"
let MESSAGE_MUST_SPECIFIED_CUSTOMER_ID = "شما باید شناسه مشتری را مشخص کنید!"
let MESSAGE_MUST_SPECIFIED_RECEIVER_ID = "شما باید شناسه گیرنده را مشخص کنید!"
let MESSAGE_MUST_SPECIFIED_TRASH_AMOUNT = "باید مقدار را مشخص کنید!"
let MESSAGE_MUST_SPECIFIED_TRASH_TYPE = "باید نوع ضایعات را مشخص کنید!"
//TODO
let MESSAGE_MUST_ENTER_DEVIDED_TYPE = ""
//TODO
let MESSAGE_MUST_ENTER_DEVIDED_AMOUNTS = ""
let MESSAGE_INCORRECT_SENDED_PARAMETERS = "پارامترهای ارسالی اشتباه است!"
//TODO
let MESSAGE_INCORRECT_TRASH_AMOUNT = "وزن زباله نادرست است!"
let MESSAGE_CHANGES_SAVED_SUCCESSFULLY =  "تغییرات با موفقیت ثبت شد!"
let MESSAGE_SEND_REQUEST_SUCCESSFULLY =  "درخواست با موفقیت ارسال شد!"
let MESSAGE_CANCEL_REQUEST_SUCCESSFULLY =  "درخواست با موفقیت لغو شد!"
let MESSAGE_SEND_NEW_PASSWORD_SUCCESSFULLY =  "رمز عبور جدید ارسال شد"
let MESSAGE_UNKNOWN_ERROR =  "خطایی نامعلوم رخ داده است!"
let MESSAGE_ADDRESS_TITLE_NOT_INERED = "عنوان آدرس وارد نشده است!"
let MESSAGE_DRIVER_NOT_FOUND = "راننده‌ای یافت نشد!"
let MESSAGE_DRIVER_REQUEST_IDENTIFIRE_IS_EMPTY = "شناسه درخواست راننده خالی است!"
let MESSAGE_USER_REQUEST_IDENTIFIRE_IS_EMPTY = "شناسه درخواست کاربر خالی است!"
let MESSAGE_BAD_REQUEST = "درخواست http نامناسب است!"
let VIP_CUSTOMER_MESSAGE = "تمامی شرکت‌ها، سازمان‌ها، نهادها و ادارات دولتی جزء مشترکین ويژه محسوب می‌شوند"
let HOME_CUSTOMER_MESSAGE = "مشترکینی که در واحدهای مسکونی اقامت دارند و ضایعات خود را برای بازیافت تحویل می‌دهند"
let MESSAGE_LOGIN_AGAIN = "مجددا وارد سامانه شوید"
let SHARE_APP_MESSAGE = "سلام، به شما پیشنهاد می‌کنم اپ فرازیست را نصب کنی. فوق العاده‌اس. با این اپ میتونی تمام ضایعات بازیافتی خودت را بفروشی و کسب درآمد کنی. این هم لینک دانلودش: \n https://bit.ly/2Vxen0U"
let MESSAGE_NOT_CONNECTED_TO_INTERNET = "اتصال به اینترنت برقرار نیست"

// Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")

//color
let PRIMARY_COLOR = UIColor(red: 33.0/255.0,
                            green: 173.0/255.0,
                            blue: 138.0/255.0, alpha: 1.0)
let PRIMARY_COLOR_DISABLE = UIColor(red: 33.0/255.0,
                                    green: 173.0/255.0,
                                    blue: 138.0/255.0, alpha: 0.3)

let ACCENT_COLOR = UIColor(red: 212.0/255.0,
                           green: 27.0/255.0,
                           blue: 94.0/255.0, alpha: 1.0)

let ACCENT_COLOR_DISABLE = UIColor(red: 212.0/255.0,
                                   green: 27.0/255.0,
                                   blue: 94.0/255.0, alpha: 0.3)

let TEXT_COLOR = UIColor(red: 82.0/255.0,
                         green: 83.0/255.0,
                         blue: 113.0/255.0, alpha: 1.0)

let TEXT_COLOR_DISABLE = UIColor(red: 82.0/255.0,
                                 green: 83.0/255.0,
                                 blue: 113.0/255.0, alpha: 0.3)

let WARNING_COLOR = UIColor(red: 234.0/255.0,
                            green: 142.0/255.0,
                            blue: 142.0/255.0, alpha: 1.0)

let BLUE_COLOR = UIColor(red: 22.0/255.0,
                         green: 139.0/255.0,
                         blue: 170.0/255.0, alpha: 1.0)

let BLUE_COLOR_DISABLE = UIColor(red: 22.0/255.0,
                                 green: 139.0/255.0,
                                 blue: 170.0/255.0, alpha: 0.3)

//Titles
let APP_TITLE = " فرازیست "
let BACK_TITLE = "بازگشت"
let LOGIN_REGISTERـTITLE = "ورود/ثبت نام"
let GOOGLE_API_KEY = "AIzaSyA-_18HOcWTYgDEHhTjEE00dP4lBBPRl5k"
let ACTIVATION_CODE_LENGTH = 5
let MINIMUM_NAME_LENGTH = 3
let MINIMUM_PASSWORD_LENGTH = 6
let RECYCLE_REQUEST_WAIT_TIME = 301//5 min
let TELEGRAM_URL = "https://t.me/plant_green"
let SUPPORT_TEL = "+989122052325"


// Segues
let TO_REGISTER_SEGUE = "goToRegisterSegue"
let TO_LOGIN_SEGUE = "goToLoginSegue"
let TO_REGISTER_FROM_LOGIN_SEGUE = "goToRegisterFromLoginSegue"
let TO_MAIN_VIEW_SEGUE  = "goToMainViewSegue"
let TO_ACTIVATION_VIEW_SEGUE = "goToActivationCodeSegue"
let TO_PROFILE_SEGUE = "goToProfileSegue"
let TO_PROFILE_FROM_MAIN_SEGUE = "goToProfileFromMainSegue"
let TO_DRIVER_SEGUE = "goToDriverSegue"
let TO_DRIVER_ACCEPTANCE_SEGUE = "goToDriverAceptanceSegue"
let TO_MAIN_FROM_REGISTER_SEGUE = "goToMainFromRegisterSegue"
let TO_MAIN_FROM_LOGIN_SEGUE = "goToMainFromLoginSegue"
let TO_MIAN_FROM_DRIVER_ACCEPTANCE_SEGUE = "goToMainFromDriverAcceptanceSegue"
let TO_MAIN_FROM_DRIVER_SEGUE = "goToMainFromDriverSegue"
let TO_REGISTER_FROM_ACTIVATION_CODE_SEGUE = "toRegisterFromActivationCodeSegue"
let TO_MAIN_FROM_ADDRESS_SEGUE = "toMainFromAddressSegue"
let TO_MAIN_FROM_TRASHES_SEGUE  = "toMainFromTrashesSegue"
let TO_MAP_FROM_ADDRESS_SEGUE  = "goToMapFromAddressSegue"
let TO_ADDRESS_FROM_MAP_SEGUE = "goToAddressFromMapSegue"
let TO_MAIN_FROM_PROFILE_SEGUE  = "toMainFromProfileSegue"
let TO_MESSAGES_SEGUE = "goToMessagesSegue"
let TO_ABOUTUS_SEGUE = "goToAboutUsSegue"
let TO_CONTACT_WITH_SUPPORT_SEGUE = "goToContactWithSupportSegue"
let TO_SHARE_APP_SEGUE = "goToShareAppSegue"
let TO_REPORT_ACTIVITIES_SEGUE = "goToReportActivitiesSegue"
let TO_SPEND_COINS_SEGUE = "goToSpendCoinsSegue"
let TO_ACCOUNT_SEGUE = "goToAccountSegue"
let TO_LOGIN_FROM_SLIDE_SEGUE = "goToLoginFromSlideSegue"
let TO_LOGIN_FROM_MESSAGES_SEGUE = "goToLoginFromMessagesSegue"
let TO_LOGIN_FROM_ADDRESS_SEGUE = "goToLoginFromAddressSegue"
let TO_DRIVER_CONFIRMTION_FROM_ADDRESS_SEGUE = "goToDriverConfirmtionFromAddressSegue"
let TO_LOGIN_FROM_TRASHES_SEGUE = "goToLoginFromTrashesSegue"
let TO_LOGIN_FROM_ACCOUNT_SEGUE = "goToLoginFromAccountSegue"
let TO_FORGET_PASSWORD_FROM_LOGIN_SEGUE = "goToForgetPasswordFromLoginSegue"
let TO_LOGIN_FROM_FORGET_PASSWORD_SEGUE = "goToLoginFromForgetPasswordSegue"
let TO_MAIN_FROM_ACTIVATION_CODE_SEGUE  = "toMainFromActivationCodeSegue"
let TO_MESSAGES_DETAIL_SEGUE = "toMessageDetailSegue"
let TO_DISPLAY_USER_TRASH_SEGUE =  "goToDisplayUserTrashViewSegue"
let TO_ACTIVE_REQUESTS_VIEW_FROM_MAIN_SEGUE = "goToActiveRequestsViewFromMainSegue"
let TO_WAITING_REQUESTS_VIEW_FROM_MAIN_SEGUE  = "goToWaitingRequestsViewFromMainSegue"
let TO_CANCELED_REQUESTS_VIEW_FROM_MAIN_SEGUE = "goToCanceledRequestsViewFromMainSegue"
let TO_FINISHED_REQUESTS_VIEW_FROM_MAIN_SEGUE = "goToFinishedRequestViewFromMainSegue"
let TO_ABOUT_US_VIEW_FROM_MAIN_SEGUE = "goToAboutUsViewFromMainSegue"
let TO_CONTACT_WITH_US_VIEW_FROM_MAIN_SEGUE = "goToContactWithSupportViewFromMainSegue"

//StoryBoard
let DRIVER_CONFIRMTION_STORY_BOARD = "DriverConfirmtionViewStoryBoard"
let START_VIEW_STORY_BOARD = "StartViewStoryBoard"
let MAIN_VIEW_STORY_BOARD = "MainViewStoryBoard"
let MENU_VIEW_STORY_BOARD = "MenuViewStoryBoard"
let SIDE_VIEW_STORY_BOARD = "SideViewStoryBoard"
let DRIVER_ACCEPTANCE_VIEW_STORY_BOARD = "DriverAcceptanceViewStoryBoard"
let TRASHES_VIEW_STORY_BOARD = "TrashesViewStoryBoard"
let LOGIN_VIEW_STORY_BOARD = "LoginViewStoryBoard"
let REGISTER_VIEW_STORY_BOARD = "RegisterViewStoryBoard"
let ACTIVATION_CODE_VIEW_STORY_BOARD = "ActivationCodeViewStoryBoard"
let SAVEP_ROFILE_VIEW_STORY_BOARD = "SaveProfileViewStoryBoard"
let ADDRESS_VIEW_STORY_BOARD = "AddressViewStoryBoard"
let MAP_VIEW_STORY_BOARD  = "MapViewStoryBoard"
let EDIT_TRASH_STORY_BOARD = "EditTrashStoryBoard"
let ADD_ADDRESS_STORY_BOARD = "AddAddressStoryBoard"
let ABOUTUS_STORY_BOARD = "AboutUsStoryBoard"
let REQUESTS_HISTORY_STORY_BOARD = "RequestsHistoryStoryBoard"
let REQUESTS_CANCELATION_STORY_BOARD = "RequestCancelationStoryBoard"
let MESSAGES_STORY_BOARD = "MessagesViewStoryBoard"
let CONTACT_WITH_SUPPORT_STORY_BOARD = "ContactWithSupportStoryBoard"
let SHARE_APP_STORY_BOARD = "ShareAppStoryBoard"
let REPORT_ACTIVITY_STORY_BOARD = "ReportActivityStoryBoard"
let SPEND_COINS_STORY_BOARD = "SpendCoinsStoryBoard"
let ACCOUNT_STORY_BOARD = "AccountStoryBoard"
let CHANGE_PASSWORD_STORY_BOARD = "ChangePasswordStoryBoard"
let MESSAGES_DETAIL_STORY_BOARD = "MessageDetailStoryBoard"
let CANCEL_REASON_STORY_BOARD = "CancelReasonStoryBoard"
let DRIVER_TRASH_REVIEW_STORY_BOARD = "DriverTrashReviewStoryBoard"
let ACTIVE_REQUESTS_STORY_BOARD = "ActiveRequestsStoryBoard"
let WAITING_REQUESTS_STORY_BOARD = "WaitingRequestsStoryBoard"
let DISPLAY_USER_TRASHES_STORY_BOARD = "DisplayUserTrashesStoryBoard"

// User Defaults
let TOKEN_KEY = "token"
let SHARE_CODE_KEY = "shareCode"
let IS_ACTIVE_KEY = "isActive"
let FIRST_NAME_KEY = "firstName"
let LAST_NAME_KEY = "lastName"
let FULL_NAME_KEY = "fullName"
let PHONE_NUMBER_KEY = "phoneNumber"
let EMAIL_KEY = "email"
let USER_TYPE_KEY = "userType"// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]


