package rize;


class Kanban{
	public var start:Date;
	public var end:Date;
	public var title:String;
	public var auth:rize.Developer;
	public var entry:Date;
	
	public function new(entry:Date,title:String,?auth:rize.Developer,?start:Date){
		this.entry = entry;
		this.title = title;
		this.auth = auth;
		this.start = start;
	}

	public function caluculateWip(){
		return DateTools.days(Math.abs( start.getTime()-end.getTime() ) );
	}

}