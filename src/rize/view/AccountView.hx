package rize.view;



@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<dl>
		<dt>email</dt>
		<dd><input type=text mage-var=email /></dd>
		<dt>password</dt>
		<dd><input type=password mage-var=pass ></dd>
		<dt>comfirm</dt>
		<dd><input type=password mage-var=confirm ></dd>
		<dt>username</dt>
		<dd><input type=text mage-var=username/></dd>
		
		<button mage-var=submitBtn>送信</button>
	</dl>
</div>"
))
class SignUp{}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<dl>
		<dt>email</dt>
		<dd><input type=text mage-var=email /></dd>
		<dt>password</dt>
		<dd><input type=password mage-var=pass ></dd>

		<button mage-var=submitBtn>送信</button>
	</dl>
</div>"
))
class SignIn{}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>

	<div mage-var=signup></div>
	<div mage-var=signin></div>
</div>"
))
class AccountViewFrame{}

class AccountView extends AccountViewFrame{
	public var signInView: SignIn;
	public var signUpView : SignUp;

	public function new(){
		super();
		this.signInView = new SignIn();
		this.signUpView = new SignUp();
		this.signin.appendChild(this.signInView.nodes[0]);
		this.signup.appendChild(this.signUpView.nodes[0]);
	}
}