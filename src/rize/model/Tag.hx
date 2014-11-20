package rize.model;

class Tag{
	public var id:String;
	public var title:String;
	public function new(title:String){
		this.title = title;
	}
	public static function restore(data:{title:String,id:String}){
		var res = new Tag(data.title);
		res.id = data.id;
		return res;
	}
}