package rize;

class Wip{
	public function culiculate(table:Array<rize.Kanban>){
		var res : Float;
		res = 0;
		for(i in 0...table.length){
			res += table[i].caluculateWip();
		}
		return res;
	}
}