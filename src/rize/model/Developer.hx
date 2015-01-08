package rize.model;


class Developer{
	public var id :String;
	public var name(default,null):String;
	public var kanbans:Array<Kanban>;


	public function new(n:String){
		this.name = n;
	}

	public function addKanban(kanban:Kanban){
		this.kanbans.push(kanban);
	}

	public function removeKanban(kanban:Kanban){
		this.kanbans.remove(kanban);
	}
}
