table.insert(config.spaces, {
  text = "Weekly Review",
  subText = "Groom and evaluate projects in Things 3.",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  funcs = 'weeklyreview',
  toggl_proj = config.projects.planning,
  toggl_desc = "Weekly Review",
  launch = {'planning'},
  blacklist = {'distraction', 'communication'}
})

config.funcs.weeklyreview = {
  setup = function()
    local buildThingsProjectUrl = function()
      return hs.osascript.javascript([[
      (function() {
        let datestamp = new Date().toLocaleDateString("en-US")

        let review_proj = {
          "type": "project",
          "operation": "create",
          "attributes": {
            "title": `Weekly Review: ${datestamp}` ,
            "notes": "",
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
                "title": "📄: Journal a one sentence summary of the week."
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
            "title": "Create Focus Budget for next week.",
            "notes": "Start 'Scheduling' headspace. Create 45 minute Focus Blocks."
          }
        },
        {
          "type": "to-do",
          "attributes": {
            "title": "Schedule in the most important task for the day.",
            "notes": "Using Upcoming, schedule the important task for the day. things:///show?id=upcoming&filter=%40ProctorU%2CEstimates"
          }
        },
        {
          "type": "to-do",
          "attributes": {
            "title": "🖊: Build spread for next week."
          }
        },
        {
          "type": "to-do",
          "attributes": {
            "title": "⭐️: Set Goals in BuJo. What is essential for next week?"
          }
        }
        )
        let url = "things:///json?data=" + encodeURIComponent(JSON.stringify([review_proj]));
        return url;
      })();
      ]])
    end

    local ok, url = buildThingsProjectUrl()
    if ok then
      hs.urlevent.openURL(url)
    else
      print(result)
      print("something wrong with the jxa to build a review project.")
    end

    config.funcs.review.setup() -- use the same format as the Daily review?
  end
}
