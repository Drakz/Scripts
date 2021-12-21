if not app.activeSprite then return app.alert "There is no active sprite" end

local dlg = Dialog("Animation Speed Exporter")

dlg:button{ text = "Export Animation Speeds", 
  onclick = function() 
    do
      local s = app.activeSprite
      local filename = string.gsub(s.filename, ".ase", "")
      local file = io.open(filename..".txt", "a")
      for i,frame in ipairs(s.frames) do
        file:write(frame.frameNumber.." - "..math.floor((frame.duration*1000)).."\n")
      end
      file:close()
      dlg:close{}
    end
  end 
}

dlg:show{}