package rize.model;

typedef Observer = { function update() : Void; }

class Model{
	private var observers: Array<Observer> = [];

	public function addObserver(o){
		this.observers.push(o);
	}

	public function changed(){
		for( o in this.observers ){
			o.update();
		}
	}
}