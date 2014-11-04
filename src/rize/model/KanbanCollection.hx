package rize.model;


class KanbanCollection {
	public var data:Array<rize.model.Kanban>;
	public function new(){
		data = new Array<rize.model.Kanban>();
		for(i in 0...3){
			var kanban = new Kanban("test"+i);
			for(j in 0...i){
				kanban.toNextState();
			}
			data.push(kanban);
		}
	}
	public function push(k:rize.model.Kanban){
		data.push(k);
	}
}