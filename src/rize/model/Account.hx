package rize.model;

import mlkcca.MilkCocoa;

class Account extends Model{
	public var logined : Bool;
	public var id : String;
	public var mlkcca : MilkCocoa;

	public function new(mlkcca : MilkCocoa){
		super();
		this.mlkcca = mlkcca;
		this.logined = false;
		this.mlkcca.getCurrentUser(function(i,userdata){
			this.logined = userdata != null;
			if( this.logined ){
				this.id = userdata.id;
			}
			this.changed();
		});
	}

	public function signIn(email : String, password : String){
		this.mlkcca.login(email,password,function(i,userdata){
			this.logined = userdata != null;
			this.id = if( userdata != null ) userdata.id else null;
			this.changed();
			if( !this.logined ){
				js.Browser.window.alert("なんかおかしい");
			}
		});
	}

	public function signUp(email : String, password : String, username : String){
		this.mlkcca.addAccount(email,password,username,function(i,userdata){
			if( userdata != null ){
				js.Browser.window.alert("メール送ったぽい");
			}else{
				js.Browser.window.alert("なんかおかしい");
			}
		});
	}

	public function logout(){
		this.mlkcca.logout(function(i){
			this.logined = false;
			this.id = null;
			this.changed();
		});
	}

	public function setToken(token){
		this.mlkcca.dataStore(this.id).push({token:token},function(data){
			js.Browser.window.alert("トークンがセットされたっぽい");
			js.Browser.window.location.reload();
		});
	}
}