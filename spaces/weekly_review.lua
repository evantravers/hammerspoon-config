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
            "notes": "obsidian://advanced-uri?vault=wiki&commandname=Periodic%20Notes%3A%20Open%20weekly%20note",
            "tags": ["Rituals: Weekly"],
            "when": "today",
            "items": [
            { "type": "heading", "attributes": { "title": "📓 Prep" } },
            {
              "type": "to-do",
              "attributes": {
                "title": "📓: Review journal."
              }
            },
            {
              "type": "to-do",
              "attributes": {
                "title": "✅: What did you accomplish?",
                "notes": "things:///show?id=logbook"
              }
            },
            {
              "type": "to-do",
              "attributes": {
                "title": "💭: What can you learn from last week?"
              }
            },
            {
              "type": "to-do",
              "attributes": {
                "title": "Do a brain dump. Add any tasks or projects you come up with to the Things inbox."
              }
            },
            {
              "type": "to-do",
              "attributes": {
                "title": "Process your physical inbox. Create tasks in Things for each item in your physical inbox that you want to take action on."
              }
            },
            {
              "type": "to-do",
              "attributes": {
                "title": "Process your email inbox. Use Mail to Things to forward emails you need or want to take action on to your Things inbox."
              }
            },
            {
              "type": "to-do",
              "attributes": {
                "title": "Process your Things inbox. Assign each task to an area or to a project. Tag appropriately. (:estimate, $focus, !categorize, priority)"
              }
            },
            {
              "type": "to-do",
              "attributes": {
                "title": "Go through each of your projects. Use the checklists below."
              }
            },
            ]
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
        review_proj["attributes"]["items"].push(
        { "type": "heading", "attributes": { "title": "📅 Plan" } },
        {
          "type": "to-do",
          "attributes": {
            "title": "Look ahead at the week.",
            "notes": "Using Deadlines and Upcoming, examine the week and month to find tasks that need to be done, and space them out through the week."
          }
        },
        {
          "type": "to-do",
          "attributes": {
            "title": "Make time for important work.",
            "notes": "Create 4 hour strategic blocks and identify some buffer blocks."
          }
        },
        {
          "type": "to-do",
          "attributes": {
            "title": "Schedule in the most important task for the day.",
            "notes": "Using Upcoming, schedule the important task for the day. things:///show?id=upcoming&filter=%40Meazure%20Learning%2CEstimates"
          }
        },
        {
          "type": "to-do",
          "attributes": {
            "title": "🖊: Build spread for next week"
          }
        },
        {
          "type": "to-do",
          "attributes": {
            "title": "⭐️: Set Goals in BuJo. What is essential for next week?"
          }
        }
        )
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
  end
}
