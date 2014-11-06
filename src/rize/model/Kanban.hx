package rize.model;


enum State{
	Regist;
	Work;
	Finish;
	Undifine;
}

class Kanban{
	public var start:Date;
	public var end:Date;
	public var title:String;
	public var auth:rize.model.Developer;
	public var entry:Date;
	public var state:State;
	public var id:Int;

	public static function restore(data:Dynamic){
		trace(data);
		var res = new Kanban(data.title);
		res.start = data.start;
		res.end = data.end;
		res.auth = data.auth;
		res.entry = data.entry;
		res.state = stateInt(data.state[0]);
		res.id = data.id;
		return res;
	}

	public function new(title:String,?auth:rize.model.Developer){
		this.entry = Date.now();
		this.title = title;
		this.state = State.Regist;
		this.auth  = new rize.model.Developer("undefine");
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

	public function stateString(){
		if(state == State.Regist){
			return "Regist";
		}else if(state == State.Finish){
			return "Finish";
		}else if(state == State.Work){
			return "Work";
		}
		return "Err";
	}
	
	public static function stateInt(s:String){
		if(s == "Regist"){
			return State.Regist;
		}else if(s == "Finish"){
			return State.Finish;
		}else if(s == "Work"){
			return State.Work;
		}
		return State.Undifine;
	}

	public function toNextState(){
		if(state == State.Regist){
			state = State.Work;
		}else{
			state = State.Finish;
		}
	}

}