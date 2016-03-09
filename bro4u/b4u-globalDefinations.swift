//
//  b4u-globalDefinations.swift
//  bro4u
//
//  Created by Mahesh Bajaj
//  Copyright (c) All rights reserved.
//

import Foundation

//Base URL
let b4uBaseUrl:String = "http://v2.20160301.testing.bro4u.com/api_v2/"

// Location search URL 

let kLocationSearchUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?radius=50&components=country:Ind&sensor=false&key=AIzaSyBSW-tlNvpkH2NiXl17nxIfXqIv27oZNKs"

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
