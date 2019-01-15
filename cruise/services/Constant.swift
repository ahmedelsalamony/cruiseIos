//
//  Constant.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/16/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation

//URLs
let Base_Url = "http://croze.tansiq.net/"
let DisplaySuperMarket_Url = "\(Base_Url)Api/SuperMarket"
let DisplayMiniMarket_Url = "\(Base_Url)Api/MinMarket"
let Images_Url = "\(Base_Url)uploads/images/"
let search_Url = "\(Base_Url)Api/SearchProduct"
let addSuperMarketOrder = "\(Base_Url)Api/AddSuperOrder"
let createClientAccount_Url = "\(Base_Url)Api/ClientRegistration"
let DepartmentProducts_Url = "\(Base_Url)Api/AllDepartProduct"
let DriverRegistration_Url = "\(Base_Url)Api/DriverRegistration"
let GroceryRegistration_Url = "\(Base_Url)Api/GroceryRegistration"
let Login_Url = "\(Base_Url)Api/Login"
let addSuperOrder_Url = "\(Base_Url)Api/AddSuperOrder"
let ResetPassword_Url = "\(Base_Url)Api/RestMyPass"
let UpdateTokenId_Url = "\(Base_Url)Api/UpdateTokenId"
let ClientAlerta_Url = "\(Base_Url)Api/ClientAlerts/"
let GroceryAlert_Url = "\(Base_Url)Api/GroceryAlerts/"
let DriverAlert_Url = "\(Base_Url)Api/MyDeliveryOrders/"
let GroceryReply_Url = "\(Base_Url)Api/GroceryReply/"
let ClientReply_Url = "\(Base_Url)Api/ClientReply/"
let EndBill_Url = "\(Base_Url)Api/BillEnd"
let CurrentClientOrders_Url = "\(Base_Url)Api/ClientOrders/1/"
let PreviousClientOrders_Url = "\(Base_Url)Api/ClientOrders/2/"
let DriverGrocery_Url = "\(Base_Url)Api/MyOrders/"
let Logout_Url = "\(Base_Url)Api/Logout/"
let ChatRoom_Url = "\(Base_Url)Chating/ChatRoom/"
let SendMsg_Url = "\(Base_Url)Chating/SendMessage/"
let ContactUs_Url = "\(Base_Url)Api/ContactUs"
let Terms_Url = "\(Base_Url)Api/AppDetails/3"
let CityArea_Url = "\(Base_Url)Api/CitesAreas"



//typealias
typealias completionHandler = (_ success : Bool) -> ()
typealias completionhandlerVC = (_ success : Bool ,_ vc : UIViewController ) -> ()

//headers
let URLEncodHeader = ["Content-type":"application/x-www-form-urlencoded"]

extension Notification.Name {

static let superCategoriesNotification = Notification.Name(rawValue: "superCategoriesNotification")
static let miniMarketNotification = Notification.Name(rawValue: "miniMarketNotification")
static let categoriesOfMiniMarket = Notification.Name(rawValue: "categoriesOfMiniMarket")
static let subsuperCategoriesNotification = Notification.Name(rawValue: "subsuperCategoriesNotification")
static let fromsupermarkethometodetails = Notification.Name(rawValue: "fromsupermarkethometodetails")
static let addToCartNotification = Notification.Name(rawValue: "addToCartNotification")
static let searchResultNotification = Notification.Name(rawValue: "searchResultNotification")
static let DepartCategoriesNotification = Notification.Name(rawValue: "DepartCategoriesNotification")
static let DeprtSubCategoriesNotification  = Notification.Name(rawValue : "DeprtSubCategoriesNotification")
static let ValueOfFirstCityNotification = Notification.Name(rawValue : "ValueOfFirstCityNotification")
static let ValueOfSecondCityNotification = Notification.Name(rawValue : "ValueOfSecondCityNotification")
static let ValueOfFirstAreaNotification = Notification.Name(rawValue: "ValueOfFirstAreaNotification")
static let ValueOfSecondAreaNotification = Notification.Name(rawValue: "ValueOfSecondAreaNotification")
static let resetPassResultNotification = Notification.Name(rawValue: "resetPassResultNotification")
static let ClientAlertsNotification = Notification.Name(rawValue: "ClientAlertsNotification")
static let GroceryAlertNotification = Notification.Name(rawValue: "GroceryAlertNotification")
static let DriverAlertNotification = Notification.Name(rawValue: "DriverAlertNotification")
static let ClientCurrentOrdersNotification = Notification.Name(rawValue: "ClientCurrentOrdersNotification")
static let ClientPreviousOrdersNotification = Notification.Name(rawValue: "ClientPreviousOrdersNotification")
static let DriverGroceryNotification = Notification.Name(rawValue: "DriverGroceryNotification")
static let ChatRoomNotification = Notification.Name(rawValue: "ChatRoomNotification")
static let SendMsgNotification = Notification.Name(rawValue : "SendMsgNotification")
static let TermsNotification = Notification.Name(rawValue : "TermsNotification")
static let CityAreaNotification = Notification.Name(rawValue: "CityAreaNotification")
}
