local C = terralib.includecstring [[
#include <stdio.h>
#include <stdlib.h>
]]

local terra main()
  var buff: int8[32]
  var pbuff = [&int8](buff)
  var bufflen: uint64 = 32
  var rlut: bool[2020]
  for i = 0, 200 do
    C.getline(&pbuff, &bufflen, C.stdin)
    var x = C.atoi(pbuff)
    if x >= 0 and x < 2020 then
      rlut[x] = true
      if rlut[2020 - x] then
        C.printf("%d", x * (2020 - x))
        return 0
      end
    end
  end
  return 0
end

terralib.saveobj("report-repair", {main = main})
