//
//  CommonRequestConst.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/7.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  通用请求链接前缀
/// 微信版 http://mj.ie1e.com/weixin/index

/// 薛世中  10:25:40
//JS调Native：toLoginApp()登录、getUidApp()获取Uid、shareApp()分享、shareSuccessApp()分享成功、outLoginApp()
//薛世中  10:25:57
//然后界面已http://mj.ie1e.com/wx_user/mysetting这个为准

import Foundation

/// 比较的域名
var PREFIX = "http://mj.ie1e.com"

/// 通用的请求前缀
var COMMON_PREFIX = "http://mj.ie1e.com/api/app"

/// 登录 请求参数 tel  password
var LOGIN_URL = COMMON_PREFIX + "/login"

/// 注册    tel  yzm   password1  password2
var REG_URL = COMMON_PREFIX + "/reg"

/// 发送验证码   mobile
var SENDSMS_URL = COMMON_PREFIX + "/sendsms"

/// 获取用户信息
var USER_INFO_URL = COMMON_PREFIX + "/info"

/// 找回密码
var FINDPWD_URL = COMMON_PREFIX + "/findpwd"

/// 修改登录密码 oldpwd pwd1 pwd2 uid
var UPDLOGINGPWD_URL = COMMON_PREFIX + "/updloginpwd"

/// 修改个人信息 nickname sex province city province
var UPDINFO_URL = COMMON_PREFIX + "/updinfo"

/// 修改支付密码  uid pwd pwd1 icon yzm
var UPDPAYPWD_URL = COMMON_PREFIX + "/updpaypwd"

/// 绑定手机号 icon tel yzm----icon 验证码返回值
var BINDPHONE_URL = COMMON_PREFIX + "/bindphone"

/// 头像上传
var UPLOADHEADINMG_URL = COMMON_PREFIX + "/uploadheadimg"

/// 获取APP最新版本信息  apptype(android  ios)
var CHECK_UPDATE_URL = COMMON_PREFIX + "/appversion"

/// 签到
var SIGNMENT_URL = COMMON_PREFIX + "/sign"

/// 微信登录
//wxlogin
// openid
var WXLOGIN_URL = COMMON_PREFIX + "/wxlogin"

// 绑定微信 //bindopenid  uid+openid
var BINDWXOPENID_URL = COMMON_PREFIX + "/bindopenid"

//首页
var WEB_VIEW_HOME_URL = "http://mj.ie1e.com/weixin/index";

//发现
var WEB_VIEW_FIND_URL = "http://mj.ie1e.com/wx_find/article";

//玩乐
var WEB_VIEW_PLAY_URL = "http://mj.ie1e.com/wx_fun/fun";

// 购物车
var WEB_VIEW_SHOPCAR_URL = "http://mj.ie1e.com/wx_cart/cart"

//反馈
var WEB_VIEW_MY_FEEDBACK = "http://mj.ie1e.com/wx_user/myfeedback";

//收藏
var WEB_VIEW_MY_COLLECT = "http://mj.ie1e.com/wx_user/mycollect";

//评论
var WEB_VIEW_MY_COMMENT = "http://mj.ie1e.com/wx_user/mycomment";

//优惠券
var WEB_VIEW_MY_COUPON = "http://mj.ie1e.com/wx_user/mycoupon";

//地址
var WEB_VIEW_MY_ADDRESS = "http://mj.ie1e.com/wx_user/myaddress";

//全部订单
var WEB_VIEW_ORDER_LIST = "http://mj.ie1e.com/wx_order/product_orderlist";

//待付款订单
var WEB_VIEW_ORDER_LIST_WAIT_PAYMENT = "http://mj.ie1e.com/wx_order/product_orderlist?show_type=1";

//待收货订单
var WEB_VIEW_ORDER_LIST_WAIT_RECEIVER = "http://mj.ie1e.com/wx_order/product_orderlist?show_type=2";

//带评论订单
var WEB_VIEW_ORDER_LIST_WAIT_COMMENT = "http://mj.ie1e.com/wx_order/product_orderlist?show_type=3";

//退款订单
var WEB_VIEW_ORDER_REFUNE = "http://mj.ie1e.com/wx_order/product_refund";

// 购买代理商品
var AGENT_ORDERLIST_URL = "http://mj.ie1e.com/wx_order/agent_orderlist"

/// 充值下单接口  money  paytype(0,微信 1,支付宝)   pwd
var WEB_VIEW_CHARGE = COMMON_PREFIX + "/recharge"


/// 数字接口
var CARTCOUNT_URL = COMMON_PREFIX + "/cartcount"


/// 订单数字
var ORDERCOUNT_URL = COMMON_PREFIX + "/ordercount"


/// 佣金接口
var shareearn_url = COMMON_PREFIX + "/shareearn"


/// 关于我们
var ABOUT_US_URL = "http://mj.ie1e.com/weixin/aboutus"

/// 积分
var SCORES_URL = "http://mj.ie1e.com/wx_user/scoresdetail"


/// 签到
var SIGN_URL = "http://mj.ie1e.com/wx_user/mysign"

/// 是否签到
var ISSIGN_URL = "http://mj.ie1e.com/wx_user/issign"

//// 注册协议
var USERAGREEMENT_URL = "http://mj.ie1e.com/weixin/info?id=e6e6afff0d4d410e97b24608a8b60a06&it=1"



