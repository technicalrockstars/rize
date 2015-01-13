package rize.model;

import mlkcca.MilkCocoa;

class Account{
	public var id : String;
	public var username : String;
	public var onlogin : Void -> Void;
	public var onlogout : Void -> Void;

	public function new(id, username){
		this.id = id;
		this.username = username;
	}

	public static var milkcocoa : MilkCocoa;

	public static function getCurrentUser(callback : Account -> Void){
		milkcocoa.getCurrentUser(function(err,userdata){
			if( userdata != null ){
				var id = userdata.id;
				var username = userdata.option.username;
				callback(new Account(id,username));
			}else{
				callback(null);
			}
		});
	}

	public static function signIn(email,password,callback : Account -> Void){
		milkcocoa.login(email,password,function(err,userdata){
			if( userdata != null ){
				var id = userdata.id;
				var username = userdata.option.username;
				callback(new Account(id,username));
			}else{
				callback(null);
			}
		});
	}

	public static function signUp(email,password,username,callback : Bool -> Void){
		milkcocoa.addAccount(email,password,{username:username},function(err,userdata){
			if(err == null){
				callback(true);
			}else{
				callback(false);
			}
		});
	}

	public static function logout(callback){
		milkcocoa.logout(function(_){
			callback();
		});
	}
}