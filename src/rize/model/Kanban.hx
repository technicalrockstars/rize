package rize.model;


enum State{
	Regist;
	Work;
	Finish;
}

class Kanban{
	public var start:Date;
	public var end:Date;
	public var title:String;
	public var auth(default,default):rize.model.Developer;
	public var entry:Date;
	public var state:State;

	public function new(title:String,?auth:rize.model.Developer){
		this.entry = Date.now();
		this.title = title;
		this.state = State.Regist;
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