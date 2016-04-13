//
//  b4u-globalDefinations.swift
//  bro4u
//
//  Created by Mahesh Bajaj
//  Copyright (c) All rights reserved.
//

import Foundation

let b4uNumber = "08030323232"

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


let orderRaiseIssueReasons = ["No Response":"no_response","Re-Schedules":"re_schedules","Price":"price","Issues":"issues","Others":"other"]

let orderCancelReasons = ["Price issue":"price_issue","No response":"no_response","I'm unavailable":"im_unavailable","Better deal":"better_deal","Others":"other"]

/******Base URL*******/

let b4uBaseUrl:String = "http://v2.20160301.testing.bro4u.com/api_v2/"


/*****Splash Screen*****/

///index.php/apitoken/add_device?device_id=34234234&gcm_id=23434fser34f&token_request=alsdkfjaklsdjf
let kSplashIndex = "index.php/apitoken/add_device?"

/*************Left Menu**********************/

//1.Fetch Referral Settings
//index.php/referral/fetch_referral_settings?user_id=1
//Refer And Earn
let kReferAndEarnIndex = "index.php/referral/fetch_referral_settings"



//2.My Wallet - Process Referral / Coupon
//index.php/referral/process_referral?user_id=1&device_id=359299050718035&referral_code=6
//Apply Wallet Coupon
let kApplyWalletCouponIndex = "index.php/referral/process_referral"


//3.My Wallet - Wallet balance and transactions items
//index.php/wallet?user_id=1
//My wallet balance
let kMyWalletIndex = "index.php/wallet"


//4.My Orders - Browse
//index.php/order/my_orders?user_id=1
//My Orders
let kMyOrdersIndex = "index.php/order/my_orders"


//5.My Orders - Cancel Order API
//index.php/order/cancel_order?order_id=14348&user_id=1626&vendor_id=132&cancel_message=test+message
//Cancel Order
let kCancelOrderIndex = "index.php/order/cancel_order"


//6.My Orders - Get Time SLots used with Reschedule order
//index.php/order/preferred_time?vendor_id=87&item_id=1710&date=2015-10-5
//Time Slots of Order
let kReScheduleOrderTimeSlotIndex = "index.php/order/preferred_time"


//7.My Order - Reschedule order with new date and time
//index.php/order/reschedule_order?order_id=23810&user_id=1626&date=2016-01-24&service_time=9AM-11AM
let kReScheduleOrderApi = "/index.php/order/reschedule_order"



//8.Re-Orders
//index.php/order/re_orders?user_id=1
//Reorder Order
let kReOrderIndex = "index.php/order/re_orders"

//9.Re-Orders Thrash / Delete
//index.php/order/thrash_reorder/13555
let kReOrderDeleteIndex = "index.php/order/thrash_reorder"

//10.My Account - Get user data
//index.php/my_account/get_user?user_id=8
//My Account Window
let kMyAccountIndex = "index.php/my_account/get_user"


//11.My Account - Update Profile
//index.php/my_account/update_user_account?user_id=1&email=akshay.hh@gmail.com&mobile=34564564&name=test&dob=2015-12-13&gender=male
//Update My Info Window
let kMyAccountUpdateProfileIndex = "index.php/my_account/update_user_account"





//12.My Account - Fetch user data
//index.php/my_account/user_details?user_id=1
//My Info Window inside My Account
let kMyInfoIndex = "index.php/my_account/user_details"

//13.Notification Data
//index.php/my_account/get_notifications?device_id=asdkfi&user_id=1626
//Notification Window
let kOrderNotificationIndex = "index.php/my_account/get_notifications"


//
//?order_id=29686&issue_type=no_response&message=jasdfl%20alskfj%20lskdf

let kOrderRaiseIssueApi = "index.php/order/raise_issue"
/*************Right Menu**********************/

//1.About Us web view url
//About Us Window
let kAboutUsIndex = "index.php/page/about"

//2.Offer Zone
//index.php/coupon/offer_zone?device_id=kdsflasdf&user_id=1
let kOfferZoneIndex = "index.php/coupon/offer_zone"


//3.Have a referral code
//on click open/take it to my wallet screen

/****** Order rating and Review ******/
//1.Rate and review your order
//index.php/order/add_order_review/14348?user_id=1626&service_quality=good&on_time=yes&rating=4&feedback=34
let kRateAndReviewOrderIndex = "index.php/order/add_order_review/"

/****** Login Activity ******/

//1.Social Login
///index.php/my-account?req_id=3&email=harshal.zope1990%40gmail.com&first_name=Harshal&last_name=Zope&image=%22https%3A%2F%2Fgraph.facebook.com%2F836148279808264%2Fpicture%3Ftype%3Dlarge%22
//Using Social Login
let kSocialLogin = "index.php/my-account"

//2.OTP Login
///index.php/my-account?req_id=10&device_id=asdfasdf&mobile=9740201846
let kOTPlogin = "/index.php/my-account"

/****** Home Screen ******/

//1.Store Location API
///index.php/home_screen/location_store?latitude=12.9718915&longitude=77.6411545&device_id=4353
let kStoreLocationApiIndex = "index.php/home_screen/location_store"

//2.Search API
///index.php/home_screen/search?latitude=12.9718915&longitude=77.6411545&search_keyword=ve
//Parematers
// latitude=12.9718915  ,  longitude=77.6411545  , search_keyword=ve
let kSearchApi = "index.php/home_screen/search"

//3.Home Banner + Main Categories
///index.php/home_screen/home_banner
let kHomeSCategory = "index.php/home_screen/home_banner"

/****** Category Screen ******/

//1.Category Screen Api - To fetch categories, icons and sub options
///index.php/categories/catAttr
let kCategoryAndSubOptions = "index.php/categories/catAttr"

/****** InterMediatory Screen ******/

//1.Intermediatory Screen API when coupon code
///index.php/categories/intermediatory?cat_id=7&user_id=15&device_id==351867064476283
let intermediateScreenAPi = "index.php/categories/intermediatory"

//2.Intermediatory Screen API when no coupon code
//index.php/categories/intermediatory?cat_id=7&field_name=&option_id=&user_id=15&device_id==351867064476283
let intermediateScreenWhenNoCP = "index.php/categories/intermediatory"

/****** Filter Screen ******/

//1.Filter Screen API - to fetch filter attributes & options dynamically
///index.php/catalog/filter_v2?cat_id=3&option_id=&field_name=
//Parematers

// cat_id=7 // user_id=15 // device_id==351867064476283

//cat_id=3  // option_id= //field_name=

let filterApi = "index.php/catalog/filter_v2"

//2."Category Timeslots send cat_id Example: 3"
///index.php/categories/get_category_timeslots/3?date=29-01-2016
//date = 29-01-2016
let kTimeSlotApi = "index.php/categories/get_category_timeslots/3"


//3.Custom Enquiry API - Used when no results on applying filters
///index.php/order/fast_enquiry?name=Harshal&mobile=9740201846&address=kasturi+nagar+bangalore&latitude=33.4534&longitude=23.34434&service_date=21-1-2016&service_time=12PM-2PM&imei=398454&cat_id=12&user_id=3&selection=[{%22field_name%22:%22option_value%22,%22field_name%22:%22option_value%22}]
let kQuickOrderBook = "/index.php/order/fast_enquiry"

/****** List View Browse Result ******/

//1."API for List View / Map Viewpage 1"
///index.php/catalog/browse?cat_id=2&latitude=12.9718915&longitude=77.6411545

//cat_id=2&latitude=12.9718915&longitude=77.6411545
let kShowServicePatnerApi = "index.php/catalog/browse/"

//2."API for List View / Map View page 2 etc"
///index.php/catalog/browse/1?cat_id=2&latitude=12.9718915&longitude=77.6411545
//?cat_id=2&latitude=12.9718915&longitude=77.6411545
let kShowServicePatnerApi1 = "index.php/catalog/browse/1"

/****** Catalog View Profile ******/

//1.View Catalog/Profile

//http://v2.20160301.testing.bro4u.com/api_v2/index.php/catalog/view/1973?cake_egg_eggless=136&cake_weight=366&service_date=29-01-2016&service_time=5PM-7PM&unit_quantity=1

//index.php/catalog/view/1973?cake_egg_eggless=136&cake_weight=366&service_date=29-01-2016&service_time=5PM-7PM&unit_quantity=1
let kViewProfileIndex = "index.php/catalog/view"


//2.Item Description web view link

//http://v2.20160301.testing.bro4u.com/api_v2/index.php/catalog/description_view?item_id=2999
///index.php/catalog/description_view?item_id=2999
let kItemDescriptionIndex = "index.php/catalog/description_view"


//3.Price chart web view link

//http://v2.20160301.testing.bro4u.com/api_v2/index.php/catalog/price_chart_view?item_id=2999
///index.php/catalog/price_chart_view?item_id=2999
let kPriceChartIndex = "index.php/catalog/price_chart_view"

/****** Booking Screen ******/
//1.Get Address List
///index.php/address/view_all_address?user_id=5
let kGetAddress = "index.php/address/view_all_address"

//2.Add Address
///index.php/address/insert_address?user_id=5&street_name=test_street&locality=test_locality&latitude=12.4435&longitude=23.34556&city_id=5&name=test&mobile=9896969696&email=test@test.com
let kSaveAddress = "index.php/address/insert_address"

//3.Delete Address
///index.php/address/delete_address?address_id=5&user_id=1
let kDeleteAddress = "index.php/address/delete_address"

//4.Get Cities
///index.php/location/get_cities
let kGetCities = "index.php/location/get_cities"


/****** CheckOut Screen ******/

//1.Coupon code validate
//index.php/coupon/ajax_validate_coupon?coupon_code=APP100&user_id=1
let kCouponCodeValidateIndex = "index.php/coupon/ajax_validate_coupon"

//2.API to Get booking details & payment methods offers
//index.php/order/book_v2/1565?sub_total=1000&user_id=3&coupon=MAKEMOMHAPPY&cake_egg_eggless=136&cake_weight=144&unit_quantity=2&service_time=11pm-12am&service_date=2015-12-27

let kGetBookingDetailIndex = "index.php/order/book_v2/"


//3.Place COD Order
//index.php/order/place_cod_order?user_id=1626&total_cost=98&service_time=12pm-2pm&service_date=2-09-2015&selection=[{%22option_112%22%3A%222%22%2C%22option_105%22%3A%221%22%2C%22user_id%22%3A%221626%22%2C%22item_id%22%3A%221928%22%2C%22vendor_id%22%3A%22132%22%2C%22unit_quantity%22%3A%221%22%2C%22grand_total%22%3A98%2C%22sub_total%22%3A98%2C%22delivery_charge%22%3A%220.00%22%2C%22deducted_from_wallet%22%3A0%2C%22deducted_using_coupon%22%3A0}]&grand_total=98.0&night_delivery_charge=0.00&customer_name=Harshal+Zope&vendor_id=132&custom_message=ihih&address_id=2&email=harshal.zope1990%40gmail.com&mobile=8149881090&item_id=1928&payment_wallet=0&coupon=bash200&imei=359296054612743&cat_id=13&latitude=23.344543&longitude=49878428
let kPlaceCashOnDeliveryIndex = "index.php/order/place_cod_order"



//4.Place Online Order
//index.php/order/place_online_order?user_id=1626&total_cost=98&service_time=12pm-2pm&service_date=2-09-2015&selection=[{%22option_112%22%3A%222%22%2C%22option_105%22%3A%221%22%2C%22user_id%22%3A%221626%22%2C%22item_id%22%3A%221928%22%2C%22vendor_id%22%3A%22132%22%2C%22unit_quantity%22%3A%221%22%2C%22grand_total%22%3A98%2C%22sub_total%22%3A98%2C%22delivery_charge%22%3A%220.00%22%2C%22deducted_from_wallet%22%3A0%2C%22deducted_using_coupon%22%3A0}]&grand_total=98.0&night_delivery_charge=0.00&customer_name=Harshal+Zope&vendor_id=132&custom_message=ihih&address_id=2&email=harshal.zope1990%40gmail.com&mobile=8149881090&item_id=1928&payment_wallet=0&coupon=bash200&imei=359296054612743&cat_id=13&latitude=23.344543&longitude=49878428
let kPlaceOnlineOrderIndex = "index.php/order/place_online_order"


//5.PayTM Gateway Post URL
//index.php/order/paytm_payment_form?order_id=1733&total_cost=1617&payment_status=firstmile
let kPaytmPostIndex = "index.php/order/paytm_payment_form"


//6.Payu Gateway Post URL
//index.php/order/payu_payment_form?order_id=1733&total_cost=1617&payment_status=firstmile
let kPayUGateWayPostIndex = "index.php/order/payu_payment_form"


//7.PayuMoney Wallet Gateway Post
//index.php/order/payu_payment_form?order_id=1733&total_cost=1617&payment_status=firstmile&payment_gateway_type=payu_money
let kPayUMoneyWalletPostIndex = "index.php/order/payu_payment_form"


//8.Order Status Check for Online order
//index.php/order/order_response?order_id=1734&user_id=15
let kOrderStatusCheckIndex = "index.php/order/order_response"

//9.Update Online Payment Status as Pending
//index.php/order/update_payment_pending/14555
let kUpdateOnlineStatuspendingIndex = "index.php/order/update_payment_pending/14555"


//10.Update COD status Pending
//index.php/order/update_cod_status/13455
let kUpdateCODStatuspendingIndex = "index.php/order/update_cod_status/13455"

/****** Thanks Screen ******/

///index.php/order/view_order?order_id=8765&user_id=15
//Order Confirmed
let kOrderConfirmedIndex = "index.php/order/view_order"


// Location search URL
let kLocationSearchUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?radius=50&components=country:Ind&sensor=false&key=AIzaSyBSW-tlNvpkH2NiXl17nxIfXqIv27oZNKs"


//// About US URL
//
let kAboutUsUrl = "http://v2.20160301.testing.bro4u.com/api_v2/index.php/page/about"


// Notification 

let kPushServicesScreen = "categoryScreenPush"

let kLoginDismissed = "kLoginDismissed"

let kUserDataReceived = "UserDataReceived"

//Payment Type
let kCODPayment = "CODPayment"
let kNetBankingPayment = "NetBankingPayment"
let kCardPayment = "CardPayment"
let kPaytmPayment = "PaytmPayment"







