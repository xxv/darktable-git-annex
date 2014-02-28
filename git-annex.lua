dt = require "darktable"

-- add
dt.register_event("shortcut", function()
    git_annex("add", dt.gui.action_images, "adding")
end, "git annex: add images")

-- get
dt.register_event("shortcut", function()
    git_annex("get", dt.gui.action_images, "getting")
end, "git annex: get images")

-- drop
dt.register_event("shortcut", function()
    git_annex("drop", dt.gui.action_images, "dropping")
end, "git annex: drop images")

-- executes git annex with the given subcommand on the selected files
--   cmd - string, the git annex subcommand
--   images - table, of dt_lua_image_t
--   msg - string, the verb to be displayed to the user
function git_annex(cmd, images, msg)
    for _,image in pairs(images) do
        esc_path = string.gsub(image.path, "\"", "\\\"")
        esc_filename = string.gsub(image.filename, "\"", "\\\"")
        command = "cd \""..esc_path.."\" && git annex "..cmd.." \""..esc_filename.."\""
        dt.print_error(command)
        notice=msg.." "..esc_filename.." from git annex"
        dt.print(notice)
        result = os.execute(command)

        if result then
            dt.print("finished "..notice)
            if cmd == "get" or cmd == "add" then
                dt.tags.attach(dt.tags.create("git-annex|here"), image)
                dt.tags.detach(dt.tags.create("git-annex|dropped"), image)
            elseif cmd == "drop" then
                dt.tags.detach(dt.tags.create("git-annex|here"), image)
                dt.tags.attach(dt.tags.create("git-annex|dropped"), image)
            end

            dt.tags.attach(dt.tags.create("git-annex|annexed"), image)
        else
            dt.print("failed "..notice)
        end
    end
end
