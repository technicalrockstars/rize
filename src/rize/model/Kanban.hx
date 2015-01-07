package rize.model;

using Kanban.StateUtil;

enum State{
	Regist;
	Work;
	Finish;
}

class StateUtil{
	public static function toState(string:String) : State {
		return switch(string){
			case "regist" : Regist;
			case "work" : Work;
			case "Finish" : Finish;
			case _ : throw "this string " + string +  "can't change state" ;
		}
	}

	public static function toString(state:State){
		return switch(state){
			case Regist : "regist";
			case Work : "work";
			case Finish : "finish";
		}
	}

}


class Kanban{
	public var title:String;
	public var author:String;
	public var state:State;
	
	private var id:String;

	private var startDate:Date;
	private var endDate:Date;
	private var entryDate:Date;


	public function new(title:String, comment:String, author:String){
		this.entryDate = Date.now();
		this.title = title;
		this.state = State.Regist;
		this.auth  = author;
	}

	public function work()
		return if(this.state == State.Regist){
			this.start = Date.now();
			this.state = State.Work;
			true;
		}else false;

	public function isWork(){
		return State.Work == this.state;
	}

	public function finish()
		return if(this.state == State.Work){
			this.end = Date.now();
			this.state = State.Finish;
			true;
		}else false;
	

	public function isFinish(){
		return State.Finish == this.state;
	}

	public function caluculateWip(){
		return DateTools.hours(Math.abs( start.getTime()-end.getTime() ) );
	}
}