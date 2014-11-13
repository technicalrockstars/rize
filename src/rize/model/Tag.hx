package rize.model;

class Tag{
	public var title:String;
	public function new(title:String){
		this.title = title;
	}
	public static function restore(data:{title:String}){
		return new Tag(data.title);
	}
}