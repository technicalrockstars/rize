package ;

import rize.model.*;
import buddy.Buddy;
import buddy.BuddySuite;
using buddy.Should;



class KanbanCollectionSpec extends BuddySuite implements Buddy{
	public function new(){
		describe("DeveloperSpec",{
			var collection : rize.model.KanbanCollection;

			it("KanbanCollection add and remove",{
				collection = new rize.model.KanbanCollection();
				var kanban = new rize.model.Kanban("test");

				collection.push(kanban);
				collection.remove(kanban);

				collection.toString().should.be((new rize.model.KanbanCollection()).toString());

			});
		});
	}
}