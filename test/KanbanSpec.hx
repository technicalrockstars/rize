package ;

import rize.model.Kanban;
import rize.model.Kanban.State;

import buddy.Buddy;
import buddy.BuddySuite;
import haxe.Timer;
using buddy.Should;



class KanbanSpec extends BuddySuite implements Buddy{
	public function new(){
		describe("KanbanSpec",{

			it("state spec",function(done){
				var kanban : Kanban = new Kanban("title","comment","nobkz");
				kanban.state.should.be(State.Regist);
				kanban.work();
				kanban.state.should.be(State.Work);

				Timer.delay(function(){
					kanban.finish();
					kanban.state.should.be(State.Finish);
					var result = kanban.caluculateWip();
					Std.int(result/1000).should.be(1);
					done();
					},1000);
			});
		});
	}
}