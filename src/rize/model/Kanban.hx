package rize.model;

import mlkcca.DataStore;
import haxe.Serializer;
import haxe.Unserializer;
import haxe.Http;
import haxe.Json;
import haxe.Template;
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
	?state:State,
	?wip:String,
	?id:String,
	?developer:Developer
};

typedef SerializedObject = {
	id:String,
	title:String,
	author:String,
	state:State,
	comment:String,
	entryDate:Date,
	?developer:Developer,
	?startDate:Date,
	?endDate:Date,
	?wip:String
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


class Kanban extends Model{
	private var dataStore : DataStore;
	public var id : String;
	public var title:String;
	public var author:String;
	public var state:State;
	public var comment:String;
	public var developer:Developer;
	public var wip:String;

	public var startDate(default, null):Date;
	public var endDate(default, null):Date;
	public var entryDate(default, null):Date;


	public function new(dataStore:DataStore,title:String, comment:String, author:String, ?options : KanbanOptionalField){
		this.title = title;
		this.comment = comment;
		this.author  = author;
		this.dataStore = dataStore;

		if( options != null ){
			this.id = options.id;
			this.developer = options.developer;
			this.state = options.state;
			this.wip = options.wip;
			this.entryDate = options.entryDate;
			this.startDate = options.startDate;
			this.endDate = options.endDate;
		}

		if( this.id == null )
			this.id = Std.string(Date.now().getTime()) + Std.string(Std.random(10000));

		if( this.entryDate == null )
			this.entryDate = Date.now();

		if( this.state == null )
			this.state = State.Regist;
	}

	public function getSerialized() : String{
		var serializer = new Serializer();
		var seralizedObject : SerializedObject = {
			id:this.id,
			title:this.title,
			author:this.author,
			developer:this.developer,
			state:this.state,
			comment:this.comment,
			entryDate:this.entryDate,
			startDate:this.startDate,
			endDate:this.endDate,
			wip:this.wip
		};
		serializer.serialize(seralizedObject);
		return serializer.toString();
	}

	public static function unserialized(string:String){
		var unserializer = new Unserializer(string);
		return unserializer.unserialize();
	}

	public static function toKanban(dataStore,object:SerializedObject){
		return new Kanban(dataStore,object.title,object.comment,object.author,
		{
			id : object.id,
			developer : object.developer,
			state : object.state,
			entryDate : object.entryDate,
			startDate : object.startDate,
			endDate : object.endDate,
			wip : object.wip
		});
	}

	public function set(data : SerializedObject){
		this.title = data.title;
		this.author = data.author;
		this.comment = data.comment;
		this.developer = data.developer;
		this.state = data.state;
		this.entryDate = data.entryDate;
		this.endDate = data.endDate;
		this.startDate = data.startDate;
		this.wip = data.wip;
		this.changed();
	}

	public function save(){
		this.dataStore.set(this.id,{kanban:this.getSerialized()});
		this.slackPost();
	}

	private function slackPost(){
		var http = new Http(rize.Main.config.slack.url);
		http.setPostData(this.getSlackPostText());
		http.setHeader( "Content-Type", "application/x-www-form-urlencoded" );
		http.request(true);
	}

	private function getSlackPostText(){
		var template  = new Template( 
"カンバンが更新されました。
タイトル : ::title:: 
作成者 : ::author::
状態 : ::state::
url : <http://kanban-technicalrockstars.bitballoon.com|rizeへ>");
		var string = template.execute({
			title : this.title,
			comment : this.comment,
			author : this.author,
			state : this.state.toString()
			});
		var json = {
			text : string,
			channel: rize.Main.config.slack.channel,
			username: rize.Main.config.slack.url
		};
		return "payload=" + Json.stringify(json);
	}


	public function setDeveloper(name:String){
		this.developer = new Developer(name);
	}

	public function nextState(){
		switch(this.state){
			case Regist : this.work();
			case Work : this.finish(); 
			case _ : 
		}
		this.save();
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