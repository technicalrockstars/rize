package rize.controller;

import rize.model.Account;
import rize.view.AccountView;

class AccountController{
	public var model(default, null) : Account;
	public var view : AccountView;
	public var onLogin : Void -> Void;
	public var onNotLogined : Void -> Void;

	public function new(view, ?model){
		this.view = view;
		this.model = model;

		var signInView = this.view.signInView;
		var signUpView = this.view.signUpView;

		signInView.submitBtn.addEventListener("click",function(event){
			var email = signInView.email.value;
			var password = signInView.pass.value;
			if( email != null && password != null){
				Account.signIn(email,password,function(account){
					if( account !=  null ){
						js.Browser.window.location.reload();
					}else{
						js.Browser.window.alert("なんかおかしい");
					}
				});
			}else{
				js.Browser.window.alert("なんかおかしい");
			}
		});

		signUpView.submitBtn.addEventListener("click",function(event){
			var email = signUpView.email.value;
			var password = signUpView.pass.value;
			var comfirm = signUpView.confirm.value;
			var username = signUpView.username.value;
			if( email != null && password != null && comfirm != null && username != null && password == comfirm ){
				Account.signUp(email,password,username,function(ok){
					if( ok ){
						js.Browser.window.alert("メール送ったぽい");
					}else{
						js.Browser.window.alert("なんかおかしい");
					}
				});
			}else{
				js.Browser.window.alert("なんかおかしい");
			}
		});
	}

	public function getCurrentUser(){
		Account.getCurrentUser(function(account){
			if( account != null ){
				this.model = account;
				this.logined();
			}else{
				onNotLogined();
			}
		});
	}

	private function logined(){
		var node : js.html.Element = cast this.view.nodes[0];
		node.remove();
		var logoutBtn : js.html.ButtonElement = cast js.Browser.document.createElement("button");
		logoutBtn.innerHTML = "ログアウト";
		js.Browser.document.body.appendChild(logoutBtn);

		var tokenText : js.html.InputElement = cast js.Browser.document.createElement("input");
		tokenText.type = "text";
		js.Browser.document.body.appendChild(tokenText);
		var tokenBtn : js.html.ButtonElement = cast js.Browser.document.createElement("button");
		tokenBtn.innerHTML = "トークンをセットする";
		js.Browser.document.body.appendChild(tokenBtn);

		tokenBtn.addEventListener("click",function(event){
			var token = tokenText.value;
			Account.milkcocoa.dataStore(this.model.id).push({token:token},function(data : Dynamic){
				if( data.error == null ){
					js.Browser.window.alert("トークンをセットしました");
					js.Browser.window.location.reload();
				}
			});
		});

		logoutBtn.addEventListener("click",function(logout){
			Account.logout(function(){
				logoutBtn.remove();
				tokenText.remove();
				tokenBtn.remove();
				this.model = null;
				this.onNotLogined();
			});
		});
		

		this.onLogin();

	}

}