//
//  b4u-globalDefinations.swift
//  bro4u
//
//  Created by Mahesh Bajaj
//  Copyright (c) All rights reserved.
//

import Foundation


enum orderTypes
{
    case kOnGoingOrders
    case kCompetedOrders
}

enum loginFormScreen
{
    case kRightMenu
    case kPaymentScreen
    case kNone
}
//Base URL
let b4uBaseUrl:String = "http://v2.20160301.testing.bro4u.com/api_v2/"

// Location search URL 

let kLocationSearchUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?radius=50&components=country:Ind&sensor=false&key=AIzaSyBSW-tlNvpkH2NiXl17nxIfXqIv27oZNKs"


// About US URL

let kAboutUsUrl = "http://v2.20160301.testing.bro4u.com/api_v2/index.php/page/about"

// REST APIS FUNCTIONS

let kHomeSCategory = "index.php/home_screen/home_banner"

let kCategoryAndSubOptions = "index.php/categories/catAttr"

//Parematers
// latitude=12.9718915  ,  longitude=77.6411545  , search_keyword=ve
let kSearchApi = "index.php/home_screen/search"

//Parematers

// cat_id=7 // user_id=15 // device_id==351867064476283
let intermediateScreenAPi = "index.php/categories/intermediatory"

//cat_id=3  // option_id= //field_name=

let filterApi = "index.php/catalog/filter_v2"

//date = 29-01-2016
let kTimeSlotApi = "index.php/categories/get_category_timeslots/3"


//?cat_id=2&latitude=12.9718915&longitude=77.6411545
let kShowServicePatnerApi1 = "index.php/catalog/browse/1"

//cat_id=2&latitude=12.9718915&longitude=77.6411545
let kShowServicePatnerApi = "index.php/catalog/browse"

// OPT Login

// ?req_id=10&device_id=asdfasdf&mobile=9740201846

let kOTPlogin = "/index.php/my-account"

//?req_id=3&email=harshal.zope1990%40gmail.com&first_name=Harshal&last_name=Zope&image=%22https%3A%2F%2Fgraph.facebook.com%2F836148279808264%2Fpicture%3Ftype%3Dlarge%22

let kSocialLogin = "/index.php/my-account"

//user_id=5&street_name=test_street&locality=test_locality&latitude=12.4435&longitude=23.34556&city_id=5&name=test&mobile=9896969696&email=test@test.com
let kSaveAddress = "/index.php/address/insert_address"

//?user_id=5
let kGetAddress = "index.php/address/view_all_address"


//?name=Harshal&mobile=9740201846&address=kasturi+nagar+bangalore&latitude=33.4534&longitude=23.34434&service_date=21-1-2016&service_time=12PM-2PM&imei=398454&cat_id=12&user_id=3&selection=[{%22field_name%22:%22option_value%22,%22field_name%22:%22option_value%22}]

let kQuickOrderBook = "/index.php/order/fast_enquiry"

//Rahul Added

//Splash Screen
let kSplashIndex = "/index.php/apitoken/add_device?device_id=34234234&gcm_id=23434fser34f&token_request=alsdkfjaklsdjf"

//My Info Window inside My Account
let kMyInfoIndex = "index.php/my_account/user_details?user_id=1"

//My wallet balance
let kMyWalletIndex = "index.php/wallet?user_id=1"

//Apply Wallet Coupon
let kApplyWalletCouponIndex = "index.php/referral/process_referral?user_id=1&device_id=359299050718035&referral_code=6"

//My Account Window
let kMyAccountIndex = "index.php/my_account/get_user?user_id=8"

//Update My Info Window
let kMyAccountUpdateProfileIndex = "index.php/my_account/update_user_account?user_id=1&email=akshay.hh@gmail.com&mobile=34564564&name=test&dob=2015-12-13&gender=male"

let kOfferZoneIndex = "index.php/coupon/offer_zone?device_id=kdsflasdf&user_id=1"

//My Orders
let kMyOrdersIndex = "index.php/order/my_orders"

//Refer And Earn
let kReferAndEarnIndex = "index.php/referral/fetch_referral_settings"

let kOrderConfirmedIndex = "index.php/order/view_order"

//Notification Window
let kOrderNotificationIndex = "index.php/my_account/get_notifications"

//About Us Window
let kAboutUsIndex = "index.php/page/about"

//Reorder Order
let kReOrderIndex = "index.php/order/re_orders?user_id=1"

//Reorder Delete
let kReOrderDeleteIndex = "index.php/order/thrash_reorder"


//ReSchedule Order
let kReScheduleOrderIndex = "index.php/order/reschedule_order?order_id=23810&user_id=1626&date=2016-01-24&service_time=9AM-11AM"

//Time Slots of Order
let kReScheduleOrderTimeSlotIndex = "index.php/order/preferred_time?vendor_id=87&item_id=1710&date=2015-10-5"

//Cancel Order

//order_id=14348&user_id=1626&vendor_id=132&cancel_message=test+message
let kCancelOrderIndex = "index.php/order/cancel_order"

//



// Notification 

let kPushServicesScreen = "categoryScreenPush"

let kLoginDismissed = "kLoginDismissed"

