do
  local function MkSome(a)
    return function(b)
      return { __tag = "MkSome", a, b }
    end
  end
  local Proxy = { __tag = "Proxy" }
  local Nil = { __tag = "Nil" }
  local None = { __tag = "None" }
  local function Parser_coll_list(a)
    return { __tag = "Parser_coll_list", a }
  end
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
  local _dollardMonadjkg, join, join0
  _dollardMonadjkg = function(tmp)
    return {
      [">>="] = function(xs)
        return function(f)
          if xs.__tag == "Some" then
            return f(xs[1])
          end
          return None
        end
      end,
      ["Monad$fyk"] = {
        ["Applicative$fpn"] = function(f)
          return function(x)
            if x.__tag == "Some" then
              return Some(f(x[1]))
            end
            return None
          end
        end,
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
        pure = Some
      },
      join = join(tmp)
    }
  end
  join = function(jlg)
    return function(joh)
      return join0(jlg, joh)
    end
  end
  join0 = function(jlg, joh)
    return _dollardMonadjkg(nil)[">>="](joh)(function(x)
      return x
    end)
  end
  local function _dollardExceptionlul(tmp)
    return {
      from_exception = function(x)
        return Some(x)
      end,
      ["Exception$lju"] = _Typeable_app({
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
  local function from_exception(moc, mqv)
    local x = mqv[2]
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 305,
        name = "user_error"
      })
    end)()
    return __eq_type_rep((function()
      return mqv[1]["Exception$lju"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception0(moc)
    return function(mqv)
      return from_exception(moc, mqv)
    end
  end
  local function _dollardExceptionmnf(tmp)
    return {
      into_exception = function(mrl)
        return MkSome(_dollardExceptionmnf(nil))(mrl)
      end,
      from_exception = from_exception0(tmp),
      describe_exception = function(tmp0)
        return "User error: " .. tmp0
      end,
      ["Exception$lju"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 305,
          name = "user_error"
        })
      end)()
    }
  end
  local function _dollarfoldr(uuw)
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
  local _dollardFoldableutw, foldl1, foldl10
  _dollardFoldableutw = function(tmp)
    return {
      ["Foldable$ubu"] = function(f)
        return function(xs)
          local function bfy(xss)
            if xss.__tag ~= "Cons" then
              return Nil
            end
            local tmp0 = xss[1]
            return {
              { _1 = f(tmp0._1), _2 = bfy(tmp0._2) },
              __tag = "Cons"
            }
          end
          return bfy(xs)
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
  foldl1 = function(uuw)
    return function(vgm)
      return function(vgn)
        return foldl10(uuw, vgm, vgn)
      end
    end
  end
  foldl10 = function(uuw, vgm, vgn)
    local tmp = _dollardFoldableutw(nil).foldl(function(m)
      return function(y)
        if m.__tag == "Some" then
          return Some(vgm(m[1])(y))
        end
        return Some(y)
      end
    end)(None)(vgn)
    if tmp.__tag == "Some" then
      return tmp[1]
    end
    return error(setmetatable(_dollardExceptionmnf(nil).into_exception("foldl1: empty structure"), {
      __tostring = _dollardExceptionlul(nil).describe_exception
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
  local floor = math.floor
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
  local function from_exception1(obu, oen)
    local x = oen[2]
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 753,
        name = "io_error"
      })
    end)()
    return __eq_type_rep((function()
      return oen[1]["Exception$lju"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception2(obu)
    return function(oen)
      return from_exception1(obu, oen)
    end
  end
  local function _dollardExceptionoax(tmp)
    return {
      ["Exception$lju"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 753,
          name = "io_error"
        })
      end)(),
      into_exception = function(ofd)
        return MkSome(_dollardExceptionoax(nil))(ofd)
      end,
      from_exception = from_exception2(tmp),
      describe_exception = function(tmp0)
        return "Input/output error: " .. tmp0
      end
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
      return error(setmetatable(_dollardExceptionoax(nil).into_exception(x), {
        __tostring = _dollardExceptionlul(nil).describe_exception
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
  local wsp = ws ^ 1;
  lpeg.cx(s("+-") ^ -1 * r("09") ^ 1)(parse_int);
  lpeg.cx(s("+-") ^ -1 * r("09") ^ 1 * (p(".") * (r("09") ^ 1 * (s("eE") * s("+-") ^ -1 * r("09") ^ 1) ^ -1) ^ -1) ^ -1)(parse_float)
  local function read_input(tmp)
    local tmp0 = io_open("input.txt", "r", function(x)
      return x
    end, function(x)
      return error(setmetatable(_dollardExceptionoax(nil).into_exception(x), {
        __tostring = _dollardExceptionlul(nil).describe_exception
      }))
    end)
    local tmp1 = wrap_nil(None, function(x)
      return error(setmetatable(_dollardExceptionoax(nil).into_exception(x), {
        __tostring = _dollardExceptionlul(nil).describe_exception
      }))
    end, Some, function(tmp1)
      return io_read(tmp0, "*a")
    end)
    if tmp1.__tag ~= "Some" then
      return tmp1
    end
    local tmp2 = tmp1[1]
    if tmp2 == "" then return None end
    return tmp1
  end
  local _bit = p("1") * lpeg.cc(true) + p("0") * lpeg.cc(false)
  local tmp = _bit ^ 1
  local bits = lpeg.collect_list(Nil)(Cons)(Parser_coll_list({}))(tmp)
  local tmp0 = (bits * (wsp * bits) ^ 0) ^ -1
  local parser = lpeg.collect_list(Nil)(Cons)(Parser_coll_list({}))(tmp0)
  local function int_from_bit(x)
    if x then return 1 end
    return 0
  end
  local function count_trues(bitss)
    local function zip_with_sat(xs, ys)
      if ys.__tag ~= "Cons" then
        return Nil
      end
      local tmp1 = ys[1]
      local y = tmp1._1
      local ys0 = tmp1._2
      if xs.__tag ~= "Cons" then
        return Nil
      end
      local tmp2 = xs[1]
      return {
        {
          _2 = zip_with_sat(tmp2._2, ys0),
          _1 = tmp2._1 + y
        },
        __tag = "Cons"
      }
    end
    local function bfy(xss)
      if xss.__tag ~= "Cons" then
        return Nil
      end
      local tmp1 = xss[1]
      local function bfy0(xss0)
        if xss0.__tag ~= "Cons" then
          return Nil
        end
        local tmp2 = xss0[1]
        local xs = tmp2._2
        if tmp2._1 then
          return Cons({ _1 = 1, _2 = bfy0(xs) })
        end
        return Cons({ _1 = 0, _2 = bfy0(xs) })
      end
      return {
        {
          _1 = bfy0(tmp1._1),
          _2 = bfy(tmp1._2)
        },
        __tag = "Cons"
      }
    end
    return _dollardFoldableutw(nil).foldl(function(xs)
      return function(ys)
        return zip_with_sat(xs, ys)
      end
    end)({
      {
        _1 = 0,
        _2 = {
          {
            _1 = 0,
            _2 = {
              {
                _1 = 0,
                _2 = {
                  {
                    _1 = 0,
                    _2 = {
                      {
                        _1 = 0,
                        _2 = {
                          {
                            _1 = 0,
                            _2 = {
                              {
                                _1 = 0,
                                _2 = {
                                  {
                                    _1 = 0,
                                    _2 = {
                                      {
                                        _1 = 0,
                                        _2 = {
                                          {
                                            _1 = 0,
                                            _2 = {
                                              {
                                                _1 = 0,
                                                _2 = {
                                                  { _1 = 0, _2 = Nil },
                                                  __tag = "Cons"
                                                }
                                              },
                                              __tag = "Cons"
                                            }
                                          },
                                          __tag = "Cons"
                                        }
                                      },
                                      __tag = "Cons"
                                    }
                                  },
                                  __tag = "Cons"
                                }
                              },
                              __tag = "Cons"
                            }
                          },
                          __tag = "Cons"
                        }
                      },
                      __tag = "Cons"
                    }
                  },
                  __tag = "Cons"
                }
              },
              __tag = "Cons"
            }
          },
          __tag = "Cons"
        }
      },
      __tag = "Cons"
    })(bfy(bitss))
  end
  local res = _dollardMonadjkg(nil)[">>="](_dollardMonadjkg(nil)[">>="](read_input(nil))(function(s0)
    return lpeg.parse(parser)(s0)
  end))(function(bitss)
    local counts = count_trues(bitss)
    local len = _dollardFoldableutw(nil).foldl(function(l)
      return function(tmp1) return l + 1 end
    end)(0)(bitss)
    local function bfy(xss)
      if xss.__tag ~= "Cons" then
        return Nil
      end
      local tmp1 = xss[1]
      return {
        {
          _1 = tmp1._1 > floor(len / 2),
          _2 = bfy(tmp1._2)
        },
        __tag = "Cons"
      }
    end
    local common = bfy(counts)
    local function bfy0(xss)
      if xss.__tag ~= "Cons" then
        return Nil
      end
      local tmp1 = xss[1]
      local xs = tmp1._2
      if tmp1._1 then
        return Cons({
          _1 = false,
          _2 = bfy0(xs)
        })
      end
      return Cons({
        _1 = true,
        _2 = bfy0(xs)
      })
    end
    local least_common = bfy0(common)
    local tmp1 = _dollardFoldableutw(nil)
    local tmp2 = tmp1["Foldable$ubu"](int_from_bit)(common)
    local tmp5 = tmp1.foldl(function(acc)
      return function(_bit0)
        return acc * 2 + _bit0
      end
    end)(0)(tmp2)
    local tmp3 = _dollardFoldableutw(nil)
    local tmp4 = tmp3["Foldable$ubu"](int_from_bit)(least_common)
    return Some(tmp5 * tmp3.foldl(function(acc)
      return function(_bit0)
        return acc * 2 + _bit0
      end
    end)(0)(tmp4))
  end)
  if res.__tag == "Some" then
    put_line("Some (" .. string_of_int(res[1]) .. ")")
  else
    put_line("None")
  end
end