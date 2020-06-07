table.insert(config.spaces, {
  text = "Weekly Review",
  subText = "Groom and evaluate Things 3",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  setup = 'weeklyreview',
  toggl_proj = config.projects.planning,
  toggl_desc = "Weekly Review",
  never = {'#communication', '#distraction'}
})

config.setup.weeklyreview = function()
  local buildThingsProjectUrl = function()
    return hs.osascript.javascript([[
    (function() {
      let review_proj = {
        "type": "project",
          "operation": "create",
        "attributes": {
          "title": "Weekly Review",
          "notes": "1. Do a brain dump. Add any tasks or projects you come up with to the Things inbox.\n2. Process your physical inbox. Create tasks in Things for each item in your physical inbox that you want to take action on.\n3. Process your email inbox. Use Mail to Things to forward emails you need or want to take action on to your Things inbox.\n4. Process your Things inbox. Assign each task to an area or to a project.\n5. Go through each of your projects. One by one, ask:\n6. Identify what’s due soon. Use the Upcoming view.\n7. Identify which tasks are available for you to work on. Use the Anytime view.\n8. Plan what to work on next. Assign “when” dates, as you learned in the section on planning your days and weeks. Choose important tasks as well as urgent ones.",
          "when": "today",
          "items": []
        },
      };

      let Things = Application("Things");
      Things.launch();
      for (proj of Things.projects()) {
        if (proj.status() == "open" ) {
          review_proj["attributes"]["items"].push(
            {
              "type": "to-do",
              "attributes": {
                "title": proj.name(),
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
      let url = "things:///json?data=" + encodeURI(JSON.stringify([review_proj]));
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

  config.setup.review() -- use the same format as the Daily review?
end
