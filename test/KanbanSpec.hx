package ;

import rize.model.*;

import buddy.Buddy;
import buddy.BuddySuite;
using buddy.Should;



class KanbanSpec extends BuddySuite implements Buddy{
	public function new(){
		describe("KanbanSpec",{
			var dev : rize.model.Kanban;
			it("when constructing Kanban",{
				dev = new rize.model.Kanban("test");
				dev.entry.getSeconds().should.be(Date.now().getSeconds());
				dev.title.should.be("test");
			});

			it("Kanban transition spec",{
				dev = new rize.model.Kanban("test");

				dev.isWork().should.be(false);
				dev.isFinish().should.be(false);

				dev.work().should.be(true);
				
				dev.isWork().should.be(true);
				dev.isFinish().should.be(false);
				
				dev.finish().should.be(true);
				
				dev.isWork().should.be(false);
				dev.isFinish().should.be(true);
			});

			it("Kanban transition faled spec",{
				dev = new rize.model.Kanban("test");

				dev.finish().should.be(false);
				dev.work().should.be(true);
				dev.finish().should.be(true);
				dev.work().should.be(false);
				dev.finish().should.be(false);
			});

		});
	}
}