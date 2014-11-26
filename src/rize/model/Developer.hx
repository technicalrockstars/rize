package rize.model;

class Developer{
	public var id :String;
	public var name(default,null):String;
	public var tags:Array<String>;
	public var kanbans:Array<String>;

	public static function restore(d:{name:String,id:String,tags:Array<Dynamic>,kanbans:Array<Dynamic>}){
		var res = new Developer(d.name);
		res.id = d.id;
		res.tags = new Array<String>();
		if(d.tags != null) for(i in 0...d.tags.length){
			res.tags.push(d.tags[i]);
		}
		res.kanbans = new Array<String>();
		if(d.kanbans != null)for(i in 0...d.kanbans.length){
			res.kanbans.push(d.kanbans[i]);
		}
		return res;
	}

	public function new(n:String){
		name = n;
	}

	public function addTag(tag:rize.model.Tag){
		tags.push(tag.id);
	}

	public function removeTag(id:String){
		tags.remove(id);
	}

	public function addKanban(kanban:rize.model.Kanban){
		kanbans.push(kanban.id);
	}

	public function removeKanban(id:String){
		kanbans.remove(id);
	}
}
