local helperLib = {}

function helperLib.isInside(x, y, bx1, by1, bx2, by2)
  if (x >= bx1 and x <= bx2 and y >= by1 and y <= by2) then
    return true
  else
    return false
  end
end

return helperLib