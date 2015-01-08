package rize.model;

using Kanban.StateUtil;

enum State{
	Regist;
	Work;
	Finish;
}

typedef KanbanOptionalField =  {
	?startDate:Date, 
	?endDate:Date, 
	?entryDate:Date, 
	?id:String,
	?developer:String
};

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




class Kanban extends Model{
	public var title:String;
	public var author:String;
	public var state:State;
	public var comment:String;
	public var developer:Developer;
	public var wip:String;
	
	private var id:String;

	public var startDate(default, null):Date;
	public var endDate(default, null):Date;
	public var entryDate(default, null):Date;


	public function new(title:String, comment:String, author:String, ?options : KanbanOptionalField){
		this.entryDate = Date.now();
		this.title = title;
		this.comment = comment;
		this.state = State.Regist;
		this.author  = author;
		if( options != null && options.developer != null && options.developer != "" )
			this.developer = new Developer(options.developer);
	}

	public function nextState(){
		switch(this.state){
			case Regist : this.work();
			case Work : this.finish(); 
			case _ : 
		}
		this.changed();
	}

	private function work(){
		this.startDate = Date.now();
		this.state = State.Work;
	}

	private function finish(){
		this.endDate = Date.now();
		this.state = State.Finish;
		this.wip = Std.string(this.caluculateWip());
	}

	private function caluculateWip(){
		return this.endDate.getTime() - this.startDate.getTime();
	}
}