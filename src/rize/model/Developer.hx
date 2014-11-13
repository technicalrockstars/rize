package rize.model;

class Developer{
	public var id :String;
	public var name(default,null):String;
	public var tags:Array<rize.model.Tag>;
	public var kanbans:Array<rize.model.Kanban>;

	public static function restore(d:{name:String,tags:Array<Dynamic>,kanbans:Array<Dynamic>}){
		var res = new Developer(d.name);
		res.tags = new Array<rize.model.Tag>();
		for(i in 0...d.tags.length){
			res.tags.push(Tag.restore(d.tags[i]));
		}
		res.kanbans = new Array<rize.model.Kanban>();
		for(i in 0...d.kanbans.length){
			res.kanbans.push(rize.model.Kanban.restore(d.kanbans[i]));
		}
		return res;
	}

	public function new(n:String){
		name = n;
	}

	public function addTag(tag:rize.model.Tag){
		tags.push(tag);
	}

	public function addKanban(kanban:rize.model.Kanban){
		kanbans.push(kanban);
	}
}
