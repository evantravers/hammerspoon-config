table.insert(Config.spaces, {
  text = "Weekly Review",
  subText = "Groom and evaluate projects in Things 3.",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  funcs = 'weeklyreview',
  togglProj = Config.projects.planning,
  togglDesc = "Weekly Review",
  launch = {'planning'},
  blacklist = {'distraction', 'communication'},
  layouts = {
    {"Obsidian", nil, hs.screen.primaryScreen():name(), hs.layout.left70, 0, 0},
    {"Things", nil, hs.screen.primaryScreen():name(), hs.layout.left70, 0, 0},
    {"Things", "Today", hs.screen.primaryScreen():name(), hs.layout.right30, 0, 0},
    {"Things", "Weekly Review", hs.screen.primaryScreen():name(), hs.layout.right30, 0, 0}
  }
})

Config.funcs.weeklyreview = {
  setup = function()
    local buildThingsProjectUrl = function()
      return hs.osascript.javascript([[
      (function() {
        let notes = `Live _coram deo_. Plan this week in the presence of God.

obsidian://open?vault=wiki&file=templates%2Frituals%2FWeekly%20Review`
        let d = new Date();
        let datestamp = `${d.getFullYear()}-${((d.getMonth()+1).toString()).padStart(2, '0')}-${d.getDate().toString().padStart(2, '0')}`;

        Date.prototype.getWeek = function() {
          var date = new Date(this.getTime());
          date.setHours(0, 0, 0, 0);
          // Thursday in current week decides the year.
          date.setDate(date.getDate() + 3 - (date.getDay() + 6) % 7);
          // January 4 is always in week 1.
          var week1 = new Date(date.getFullYear(), 0, 4);
          // Adjust to Thursday in week 1 and count number of weeks from date to week1.
          return 1 + Math.round(((date.getTime() - week1.getTime()) / 86400000 - 3 + (week1.getDay() + 6) % 7) / 7);
        }

        let review_proj = {
          "type": "project",
          "operation": "create",
          "attributes": {
            "title": `Weekly Review: ${datestamp}` ,
            "notes": notes,
            "tags": ["Rituals: Weekly"],
            "when": "today",
            "items": []
          },
        };

        let Things = Application("Things");
        Things.launch();
        for (area of Things.areas()) {
          review_proj["attributes"]["items"].push(
          { "type": "heading", "attributes": { "title": "📂 Projects: " + area.name() } },
          )
          for (proj of Things.projects().filter(p => p.area() != null && p.area().id() === area.id())) {
            if (proj.status() == "open" ) {
              review_proj["attributes"]["items"].push(
              {
                "type": "to-do",
                "attributes": {
                  "title": "Review: " + proj.name(),
                  "notes": "things:///show?id=" + proj.id(),
                  "checklist-items": [
                  {
                    "type": "checklist-item",
                    "attributes": {
                      "title": "Is this project still relevant?"
                    }
                  },
                  {
                    "type": "checklist-item",
                    "attributes": {
                      "title": "Can I delegate this project?"
                    }
                  },
                  {
                    "type": "checklist-item",
                    "attributes": {
                      "title": "Should I move this project to Someday?"
                    }
                  },
                  {
                    "type": "checklist-item",
                    "attributes": {
                      "title": "Are there are tasks I have already completed?"
                    }
                  },
                  {
                    "type": "checklist-item",
                    "attributes": {
                      "title": "Are there any tasks I want to delete?"
                    }
                  },
                  {
                    "type": "checklist-item",
                    "attributes": {
                      "title": "Am I happy with the structure of the project? E.g., should I add or change headings?"
                    }
                  },
                  {
                    "type": "checklist-item",
                    "attributes": {
                      "title": "Do all tasks with deadlines have the correct deadline set?"
                    }
                  },
                  {
                    "type": "checklist-item",
                    "attributes": {
                      "title": "Could I add useful notes to any tasks or to the project itself?"
                    }
                  },
                  {
                    "type": "checklist-item",
                    "attributes": {
                      "title": "Are any new tasks for this project not yet in Things?"
                    }
                  },
                  {
                    "type": "checklist-item",
                    "attributes": {
                      "title": "Should I convert any tasks to separate projects?"
                    }
                  },
                  {
                    "type": "checklist-item",
                    "attributes": {
                      "title": "Is there a clear 'next action' for this project? (If not, break down your projects or tasks into smaller tasks until there is a clear next action.)"
                    }
                  },
                  {
                    "type": "checklist-item",
                    "attributes": {
                      "title": "How can you serve and surprise in this area?"
                    }
                  }
                  ]
                }
              }
              )
            }
          }
          review_proj["attributes"]["items"].push(
            { "type": "to-do", "attributes": { "title": "Are your projects in correct priority order?" } },
          )
        }
        let json = JSON.stringify([review_proj]);
        let url = "things:///json?data=" + encodeURIComponent(json)
                                             .replace("(", "%28")
                                             .replace(")", "%29")
        return url;
      })();
      ]])
    end

    local ok, url = buildThingsProjectUrl()
    if ok then
      hs.urlevent.openURL(url)
    else
      print("something wrong with the jxa to build a review project.")
    end

    local things = hs.application.find('com.culturedcode.ThingsMac')
    hs.fnutils.imap(things:allWindows(), function(v) v:close() end)
    hs.urlevent.openURL("things:///show?id=inbox")
    things:selectMenuItem("Show Sidebar")

    things:selectMenuItem("New Things Window")
    hs.urlevent.openURL("things:///show?id=today")
    things:selectMenuItem("Hide Sidebar")

    hs.urlevent.openURL("obsidian://advanced-uri?vault=wiki&commandname=Periodic%20Notes%3A%20Open%20weekly%20note")
  end
}
