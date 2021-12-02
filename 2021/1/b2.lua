do
  local function MkSome(a)
    return function(b)
      return { __tag = "MkSome", a, b }
    end
  end
  local Proxy = { __tag = "Proxy" }
  local Nil = { __tag = "Nil" }
  local None = { __tag = "None" }
  local function Some(a)
    return { __tag = "Some", a }
  end
  local function _TypeRep(x)
    return {
      {
        name = x.name .. "#" .. x.fingerprint
      },
      __tag = "TypeRep"
    }
  end
  local function __eq_type_rep(tr_a, tr_b, keq, kne)
    if tr_a[1].name == tr_b[1].name then
      return keq()()
    else
      return kne()
    end
  end
  local function _Typeable_app(pair)
    local ta, tb = pair._1[1], pair._2[1]
    return {
      {
        name = "(" .. ta.name .. ") :$ (" .. tb.name .. ")"
      },
      __tag = "TypeRep"
    }
  end
  local function _plus0(tmp)
    return function(tmp0)
      return tmp + tmp0
    end
  end
  local string_of_int = tostring
  local function _colon_colon(x)
    return function(xs)
      return {
        { _1 = x, _2 = xs },
        __tag = "Cons"
      }
    end
  end
  local function _dollardExceptionlty(tmp)
    return {
      from_exception = function(x)
        return Some(x)
      end,
      ["Exception$ljh"] = _Typeable_app({
        _1 = (function(tmp0)
          return _TypeRep({
            fingerprint = 272,
            name = "some"
          })
        end)(),
        _2 = (function(tmp0)
          return _TypeRep({
            fingerprint = 277,
            name = "exception"
          })
        end)()
      }),
      describe_exception = function(tmp0)
        return tmp0[1].describe_exception(tmp0[2])
      end,
      into_exception = function(x)
        return x
      end
    }
  end
  local function from_exception(mnp, mqi)
    local x = mqi[2]
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 305,
        name = "user_error"
      })
    end)()
    return __eq_type_rep((function()
      return mqi[1]["Exception$ljh"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception0(mnp)
    return function(mqi)
      return from_exception(mnp, mqi)
    end
  end
  local function _dollardExceptionmms(tmp)
    return {
      into_exception = function(mqy)
        return MkSome(_dollardExceptionmms(nil))(mqy)
      end,
      from_exception = from_exception0(tmp),
      describe_exception = function(tmp0)
        return "User error: " .. tmp0
      end,
      ["Exception$ljh"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 305,
          name = "user_error"
        })
      end)()
    }
  end
  local function from_exception1(nmc, nov)
    local x = nov[2]
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 315,
        name = "invalid_arg"
      })
    end)()
    return __eq_type_rep((function()
      return nov[1]["Exception$ljh"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception2(nmc)
    return function(nov)
      return from_exception1(nmc, nov)
    end
  end
  local function _dollardExceptionnlf(tmp)
    return {
      ["Exception$ljh"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 315,
          name = "invalid_arg"
        })
      end)(),
      into_exception = function(npl)
        return MkSome(_dollardExceptionnlf(nil))(npl)
      end,
      from_exception = from_exception2(tmp),
      describe_exception = function(tmp0)
        return "Invalid argument to function " .. tmp0
      end
    }
  end
  local function tail(xs)
    if xs.__tag == "Cons" then
      return xs[1]._2
    end
    return error(setmetatable(_dollardExceptionnlf(nil).into_exception("tail"), {
      __tostring = _dollardExceptionlty(nil).describe_exception
    }))
  end
  local function scanl(func, q, ls)
    local function go(k, z, x)
      if x.__tag ~= "Cons" then
        return k({
          { _1 = z, _2 = Nil },
          __tag = "Cons"
        })
      end
      local tmp = x[1]
      return go(function(xs)
        return k({
          { _1 = z, _2 = xs },
          __tag = "Cons"
        })
      end, func(z)(tmp._1), tmp._2)
    end
    return go(function(x)
      return x
    end, q, ls)
  end
  local function _dollarfoldr(uuj)
    return function(f)
      return function(z)
        local function loop(k, x)
          if x.__tag ~= "Cons" then
            return k(z)
          end
          local tmp = x[1]
          local x0 = tmp._1
          return loop(function(r)
            return k(f(x0)(r))
          end, tmp._2)
        end
        return function(x)
          return loop(function(x0)
            return x0
          end, x)
        end
      end
    end
  end
  local _dollardFoldableutj, foldl1, foldl10
  _dollardFoldableutj = function(tmp)
    return {
      ["Foldable$ubh"] = function(f)
        return function(xs)
          local function bfl(xss)
            if xss.__tag ~= "Cons" then
              return Nil
            end
            local tmp0 = xss[1]
            return {
              { _1 = f(tmp0._1), _2 = bfl(tmp0._2) },
              __tag = "Cons"
            }
          end
          return bfl(xs)
        end
      end,
      foldl1 = foldl1(tmp),
      foldr = _dollarfoldr(tmp),
      foldl = function(f)
        local function loop(z)
          return function(x)
            if x.__tag ~= "Cons" then return z end
            local tmp0 = x[1]
            return loop(f(z)(tmp0._1))(tmp0._2)
          end
        end
        return loop
      end
    }
  end
  foldl1 = function(uuj)
    return function(vfz)
      return function(vga)
        return foldl10(uuj, vfz, vga)
      end
    end
  end
  foldl10 = function(uuj, vfz, vga)
    local tmp = _dollardFoldableutj(nil).foldl(function(m)
      return function(y)
        if m.__tag == "Some" then
          return Some(vfz(m[1])(y))
        end
        return Some(y)
      end
    end)(None)(vga)
    if tmp.__tag == "Some" then
      return tmp[1]
    end
    return error(setmetatable(_dollardExceptionmms(nil).into_exception("foldl1: empty structure"), {
      __tostring = _dollardExceptionlty(nil).describe_exception
    }))
  end
  local function _dollartraverse(tnw)
    return function(tmp)
      return function(cont)
        local function loop(x)
          if x.__tag ~= "Cons" then
            return tmp.pure(Nil)
          end
          local tmp0 = x[1]
          return tmp["<*>"](tmp["<*>"](tmp.pure(_colon_colon))(cont(tmp0._1)))(loop(tmp0._2))
        end
        return loop
      end
    end
  end
  local _dollardTraversabletmw, sequence, sequence0
  _dollardTraversabletmw = function(tmp)
    return {
      ["Traversable$sjq"] = function(f)
        return function(xs)
          local function bfl(xss)
            if xss.__tag ~= "Cons" then
              return Nil
            end
            local tmp0 = xss[1]
            return {
              { _1 = f(tmp0._1), _2 = bfl(tmp0._2) },
              __tag = "Cons"
            }
          end
          return bfl(xs)
        end
      end,
      sequence = sequence(tmp),
      traverse = _dollartraverse(tmp)
    }
  end
  sequence = function(tnw)
    return function(txn)
      return function(txo)
        return sequence0(tnw, txn, txo)
      end
    end
  end
  sequence0 = function(tnw, txn, txo)
    return _dollardTraversabletmw(nil).traverse(txn)(function(x)
      return x
    end)(txo)
  end
  local prim_parse_int = function(Some, None, x)
    if tonumber(x) and math.modf(tonumber(x)) == tonumber(x) then
      return Some(tonumber(x))
    else
      return None
    end
  end
  local function parse_int(tmp)
    return prim_parse_int(Some, None, tmp)
  end
  local prim_parse_float = function(Some, None, x)
    if tonumber(x) then
      return Some(tonumber(x))
    else
      return None
    end
  end
  local function parse_float(tmp)
    return prim_parse_float(Some, None, tmp)
  end
  local io_open = function(path, mode, cont, fail)
    local h, err = io.open(path, mode)
    if h then
      return cont(h)
    else
      return fail(err)
    end
  end
  local io_read = function(h, s)
    return h:read(s)
  end
  local io_write = function(h, s)
    return h:write(s)
  end
  local wrap_nil = function(none, left, some, k)
    local ok, err = pcall(k)
    if not ok then
      return left(err)
    elseif err == nil then
      return none
    else
      return some(err)
    end
  end
  local io_stdout = io.stdout
  local io_stderr = io.stderr
  local io_stdin = io.stdin
  local function from_exception3(obh, oea)
    local x = oea[2]
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 753,
        name = "io_error"
      })
    end)()
    return __eq_type_rep((function()
      return oea[1]["Exception$ljh"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception4(obh)
    return function(oea)
      return from_exception3(obh, oea)
    end
  end
  local function _dollardExceptionoak(tmp)
    return {
      ["Exception$ljh"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 753,
          name = "io_error"
        })
      end)(),
      into_exception = function(oeq)
        return MkSome(_dollardExceptionoak(nil))(oeq)
      end,
      from_exception = from_exception4(tmp),
      describe_exception = function(tmp0)
        return "Input/output error: " .. tmp0
      end
    }
  end
  local function read_line(file)
    return wrap_nil(None, function(x)
      return error(setmetatable(_dollardExceptionoak(nil).into_exception(x), {
        __tostring = _dollardExceptionlty(nil).describe_exception
      }))
    end, Some, function(tmp)
      return io_read(file, "*l")
    end)
  end
  local standard_out = {
    io_stdout,
    __tag = "Ref"
  }
  local function put_line(str)
    local tmp0 = standard_out[1]
    local tmp = str .. "\n"
    wrap_nil(None, function(x)
      return error(setmetatable(_dollardExceptionoak(nil).into_exception(x), {
        __tostring = _dollardExceptionlty(nil).describe_exception
      }))
    end, Some, function(tmp1)
      return io_write(tmp0, tmp)
    end)
    return nil
  end
  local lpeg = (function()
    local lpeg = require("lpeg")
    local function tuple_collect(xs)
      if #xs == 0 then
        return nil
      elseif #xs == 1 then
        return xs[1]
      else
        local l = xs[#xs]
        for i = #xs - 1 , 1 , -1 do
          l = { _1 = xs[i], _2 = l }
        end
        return l
      end
    end
    local function list_collect(n, c, xs)
      local l = n
      for i = #xs , 1 , -1 do
        l = c({ _1 = xs[i], _2 = l })
      end
      return l
    end
    local function make_array(tab)
      return {
        __tag = "Array",
        { length = #tab, backing = tab }
      }
    end
    return {
      p = lpeg.P,
      c = lpeg.C,
      r = lpeg.R,
      s = lpeg.S,
      cc = lpeg.Cc,
      cx = function(pat)
        return function(f)
          return lpeg.Cmt(lpeg.C(pat) * lpeg.Cp(), function(_, _, cap, pos)
            local val = f(cap)
            if val.__tag == "Some" then
              return pos, val[1]
            else
              return false
            end
          end)
        end
      end,
      actx = function(pat)
        return function(f)
          return lpeg.Cmt(pat * lpeg.Cp(), function(_, _, cap, pos)
            local val = f(cap)
            if val.__tag == "Some" then
              return pos, val[1]
            else
              return false
            end
          end)
        end
      end,
      zero = lpeg.P(false),
      one = lpeg.P(true),
      star = lpeg.P(1),
      rep = function(p)
        return function(r) return p ^ r end
      end,
      collect_tuple = function(p)
        return lpeg.Ct(p) / tuple_collect
      end,
      collect_list = function(n)
        return function(c)
          return function(p)
            return lpeg.Ct(p) / function(xs)
              return list_collect(n, c, xs)
            end
          end
        end
      end,
      collect_array = function(p)
        return lpeg.Ct(p) / make_array
      end,
      parse = function(pat)
        return function(str)
          local res = lpeg.match(pat, str)
          if res then
            return { __tag = "Some", res }
          else
            return { __tag = "None" }
          end
        end
      end
    }
  end)()
  local p = lpeg.p
  local r = lpeg.r
  local s = lpeg.s
  local ws = s(" \t\n\13");
  lpeg.cx(s("+-") ^ -1 * r("09") ^ 1)(parse_int);
  lpeg.cx(s("+-") ^ -1 * r("09") ^ 1 * (p(".") * (r("09") ^ 1 * (s("eE") * s("+-") ^ -1 * r("09") ^ 1) ^ -1) ^ -1) ^ -1)(parse_float)
  local function read_lines(file)
    local tmp = read_line(file)
    if tmp.__tag == "Some" then
      return {
        { _1 = tmp[1], _2 = read_lines(file) },
        __tag = "Cons"
      }
    end
    return Nil
  end
  local function tmp(regions)
    local tmp = _dollardFoldableutj(nil).foldl(function(tmp)
      local count, old = tmp._1, tmp._2
      return function(new)
        if old < new then
          return { _1 = count + 1, _2 = new }
        end
        return { _1 = count, _2 = new }
      end
    end)({ _1 = -1, _2 = -1 })
    if regions.__tag ~= "Some" then
      return put_line("None")
    end
    local tmp0 = tmp(regions[1])
    return put_line("Some (" .. ("(" .. string_of_int(tmp0._1) .. ", " .. string_of_int(tmp0._2) .. ")") .. ")")
  end
  local function bfl(xss)
    if xss.__tag ~= "Cons" then
      return Nil
    end
    local tmp = xss[1]
    return {
      {
        _1 = prim_parse_int(Some, None, tmp._1),
        _2 = bfl(tmp._2)
      },
      __tag = "Cons"
    }
  end
  local parsed = _dollardTraversabletmw(nil).sequence({
    ["<*>"] = function(f)
      return function(x)
        if x.__tag ~= "Some" then
          return None
        end
        local x0 = x[1]
        if f.__tag == "Some" then
          return Some(f[1](x0))
        end
        return None
      end
    end,
    ["Applicative$fpa"] = function(f)
      return function(x)
        if x.__tag == "Some" then
          return Some(f(x[1]))
        end
        return None
      end
    end,
    pure = Some
  })(bfl(read_lines(io_open("input.txt", "r", function(x)
    return x
  end, function(x)
    return error(setmetatable(_dollardExceptionoak(nil).into_exception(x), {
      __tostring = _dollardExceptionlty(nil).describe_exception
    }))
  end))))
  if parsed.__tag == "Some" then
    local function zip_with_sat(xs, ys)
      if ys.__tag ~= "Cons" then
        return Nil
      end
      local tmp0 = ys[1]
      local y = tmp0._1
      local ys0 = tmp0._2
      if xs.__tag ~= "Cons" then
        return Nil
      end
      local tmp1 = xs[1]
      return {
        {
          _1 = tmp1._1 - y,
          _2 = zip_with_sat(tmp1._2, ys0)
        },
        __tag = "Cons"
      }
    end
    local ps = scanl(_plus0, 0, parsed[1])
    if ps.__tag == "Cons" then
      tmp(Some(zip_with_sat(tail(tail(ps[1]._2)), ps)))
    else
      tmp(Some(zip_with_sat(tail(tail(error(setmetatable(_dollardExceptionnlf(nil).into_exception("tail"), {
        __tostring = _dollardExceptionlty(nil).describe_exception
      })))), ps)))
    end
  else
    tmp(None)
  end
end