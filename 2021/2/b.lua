do
  local function MkSome(a)
    return function(b)
      return { __tag = "MkSome", a, b }
    end
  end
  local Proxy = { __tag = "Proxy" }
  local function Parser_coll_list(a)
    return { __tag = "Parser_coll_list", a }
  end
  local Nil = { __tag = "Nil" }
  local function Parser_tuple(a)
    return { __tag = "Parser_tuple", a }
  end
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
  local function Cons(x)
    return { x, __tag = "Cons" }
  end
  local string_of_int = tostring
  local _dollardMonadjjv, join, join0
  _dollardMonadjjv = function(tmp)
    return {
      [">>="] = function(xs)
        return function(f)
          if xs.__tag == "Some" then
            return f(xs[1])
          end
          return None
        end
      end,
      ["Monad$fxz"] = {
        ["Applicative$fpc"] = function(f)
          return function(x)
            if x.__tag == "Some" then
              return Some(f(x[1]))
            end
            return None
          end
        end,
        ["<*>"] = function(f)
          return function(x)
            if f.__tag ~= "Some" then
              return None
            end
            local f0 = f[1]
            if x.__tag == "Some" then
              return Some(f0(x[1]))
            end
            return None
          end
        end,
        pure = Some
      },
      join = join(tmp)
    }
  end
  join = function(jkv)
    return function(jnw)
      return join0(jkv, jnw)
    end
  end
  join0 = function(jkv, jnw)
    return _dollardMonadjjv(nil)[">>="](jnw)(function(x)
      return x
    end)
  end
  local function _dollardExceptionlua(tmp)
    return {
      ["Exception$ljj"] = _Typeable_app({
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
      from_exception = function(x)
        return Some(x)
      end,
      describe_exception = function(tmp0)
        return tmp0[1].describe_exception(tmp0[2])
      end,
      into_exception = function(x)
        return x
      end
    }
  end
  local function from_exception(mnr, mqk)
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 305,
        name = "user_error"
      })
    end)()
    local x = mqk[2]
    return __eq_type_rep((function()
      return mqk[1]["Exception$ljj"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception0(mnr)
    return function(mqk)
      return from_exception(mnr, mqk)
    end
  end
  local function _dollardExceptionmmu(tmp)
    return {
      into_exception = function(mra)
        return MkSome(_dollardExceptionmmu(nil))(mra)
      end,
      from_exception = from_exception0(tmp),
      describe_exception = function(tmp0)
        return "User error: " .. tmp0
      end,
      ["Exception$ljj"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 305,
          name = "user_error"
        })
      end)()
    }
  end
  local function _dollarfoldr(uul)
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
  local _dollardFoldableutl, foldl1, foldl10
  _dollardFoldableutl = function(tmp)
    return {
      foldl1 = foldl1(tmp),
      foldr = _dollarfoldr(tmp),
      ["Foldable$ubj"] = function(f)
        return function(xs)
          local function bfn(xss)
            if xss.__tag ~= "Cons" then
              return Nil
            end
            local tmp0 = xss[1]
            return {
              { _1 = f(tmp0._1), _2 = bfn(tmp0._2) },
              __tag = "Cons"
            }
          end
          return bfn(xs)
        end
      end,
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
  foldl1 = function(uul)
    return function(vgb)
      return function(vgc)
        return foldl10(uul, vgb, vgc)
      end
    end
  end
  foldl10 = function(uul, vgb, vgc)
    local tmp = _dollardFoldableutl(nil).foldl(function(m)
      return function(y)
        if m.__tag == "Some" then
          return Some(vgb(m[1])(y))
        end
        return Some(y)
      end
    end)(None)(vgc)
    if tmp.__tag == "Some" then
      return tmp[1]
    end
    return error(setmetatable(_dollardExceptionmmu(nil).into_exception("foldl1: empty structure"), {
      __tostring = _dollardExceptionlua(nil).describe_exception
    }))
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
  local function from_exception1(obj, oec)
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 753,
        name = "io_error"
      })
    end)()
    local x = oec[2]
    return __eq_type_rep((function()
      return oec[1]["Exception$ljj"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception2(obj)
    return function(oec)
      return from_exception1(obj, oec)
    end
  end
  local function _dollardExceptionoam(tmp)
    return {
      into_exception = function(oes)
        return MkSome(_dollardExceptionoam(nil))(oes)
      end,
      from_exception = from_exception2(tmp),
      describe_exception = function(tmp0)
        return "Input/output error: " .. tmp0
      end,
      ["Exception$ljj"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 753,
          name = "io_error"
        })
      end)()
    }
  end
  local standard_out = {
    io_stdout,
    __tag = "Ref"
  }
  local function put_line(str)
    local tmp0 = standard_out[1]
    local tmp = str .. "\n"
    wrap_nil(None, function(x)
      return error(setmetatable(_dollardExceptionoam(nil).into_exception(x), {
        __tostring = _dollardExceptionlua(nil).describe_exception
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
      collect_tuple = function(typefam)
        return function(p)
          return lpeg.Ct(p) / tuple_collect
        end
      end,
      collect_list = function(n)
        return function(c)
          return function(typefam)
            return function(p)
              return lpeg.Ct(p) / function(xs)
                return list_collect(n, c, xs)
              end
            end
          end
        end
      end,
      collect_array = function(typefam)
        return function(p)
          return lpeg.Ct(p) / make_array
        end
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
  local ws = s(" \t\n\13")
  local wsp = ws ^ 1
  local int_parser = lpeg.cx(s("+-") ^ -1 * r("09") ^ 1)(parse_int);
  lpeg.cx(s("+-") ^ -1 * r("09") ^ 1 * (p(".") * (r("09") ^ 1 * (s("eE") * s("+-") ^ -1 * r("09") ^ 1) ^ -1) ^ -1) ^ -1)(parse_float)
  local entry = lpeg.collect_tuple(Parser_tuple({}))(lpeg.c(p("up") + p("down") + p("forward")) * wsp * int_parser)
  local tmp = (entry * (wsp * entry) ^ 0) ^ -1
  local parser = lpeg.collect_list(Nil)(Cons)(Parser_coll_list({}))(tmp)
  local tmp2 = _dollardMonadjjv(nil)[">>="]
  local tmp0 = io_open("input.txt", "r", function(x)
    return x
  end, function(x)
    return error(setmetatable(_dollardExceptionoam(nil).into_exception(x), {
      __tostring = _dollardExceptionlua(nil).describe_exception
    }))
  end)
  local tmp1 = wrap_nil(None, function(x)
    return error(setmetatable(_dollardExceptionoam(nil).into_exception(x), {
      __tostring = _dollardExceptionlua(nil).describe_exception
    }))
  end, Some, function(tmp1)
    return io_read(tmp0, "*a")
  end)
  local input
  if tmp1.__tag == "Some" then
    local tmp3 = tmp1[1]
    if tmp3 == "" then
      input = tmp2(None)(function(s0)
        return lpeg.parse(parser)(s0)
      end)
    else
      input = tmp2(tmp1)(function(s0)
        return lpeg.parse(parser)(s0)
      end)
    end
  else
    input = tmp2(tmp1)(function(s0)
      return lpeg.parse(parser)(s0)
    end)
  end
  local tmp3 = _dollardFoldableutl(nil).foldl(function(tmp3)
    local tmp4 = tmp3._2
    local y, aim = tmp4._1, tmp4._2
    local x = tmp3._1
    return function(line)
      local tmp5 = line._1
      local dy = line._2
      if tmp5 == "down" then
        return {
          _1 = x,
          _2 = { _1 = y, _2 = aim + dy }
        }
      elseif tmp5 == "forward" then
        return {
          _1 = x + dy,
          _2 = { _1 = y + aim * dy, _2 = aim }
        }
      elseif tmp5 == "up" then
        return {
          _1 = x,
          _2 = { _1 = y, _2 = aim - dy }
        }
      else
        return {
          _1 = x,
          _2 = { _1 = y, _2 = aim }
        }
      end
    end
  end)({
    _1 = 0,
    _2 = { _1 = 0, _2 = 0 }
  })
  local res
  if input.__tag == "Some" then
    res = Some(tmp3(input[1]))
  else
    res = None
  end
  if res.__tag == "Some" then
    local x = res[1]
    put_line("Some (" .. string_of_int(x._1 * x._2._1) .. ")")
  else
    put_line("None")
  end
end