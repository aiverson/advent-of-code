do
  local function MkSome(a)
    return function(b)
      return { __tag = "MkSome", a, b }
    end
  end
  local Proxy = { __tag = "Proxy" }
  local Nil = { __tag = "Nil" }
  local function Parser_coll_list(a)
    return { __tag = "Parser_coll_list", a }
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
  local function _plus0(tmp)
    return function(tmp0)
      return tmp + tmp0
    end
  end
  local function bool_eq0(tmp)
    return function(tmp0)
      return tmp == tmp0
    end
  end
  local string_of_int = tostring
  local _dollardMonadjky, join, join0
  _dollardMonadjky = function(tmp)
    return {
      ["Monad$gac"] = {
        ["Applicative$fqf"] = function(f)
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
      join = join(tmp),
      [">>="] = function(xs)
        return function(f)
          if xs.__tag == "Some" then
            return f(xs[1])
          end
          return None
        end
      end
    }
  end
  join = function(jly)
    return function(joz)
      return join0(jly, joz)
    end
  end
  join0 = function(jly, joz)
    return _dollardMonadjky(nil)[">>="](joz)(function(x)
      return x
    end)
  end
  local function _dollardExceptionlvd(tmp)
    return {
      ["Exception$lkm"] = _Typeable_app({
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
  local function from_exception(mou, mrn)
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 305,
        name = "user_error"
      })
    end)()
    local x = mrn[2]
    return __eq_type_rep((function()
      return mrn[1]["Exception$lkm"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception0(mou)
    return function(mrn)
      return from_exception(mou, mrn)
    end
  end
  local function _dollardExceptionmnx(tmp)
    return {
      into_exception = function(msd)
        return MkSome(_dollardExceptionmnx(nil))(msd)
      end,
      from_exception = from_exception0(tmp),
      describe_exception = function(tmp0)
        return "User error: " .. tmp0
      end,
      ["Exception$lkm"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 305,
          name = "user_error"
        })
      end)()
    }
  end
  local function from_exception1(nnh, nqa)
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 315,
        name = "invalid_arg"
      })
    end)()
    local x = nqa[2]
    return __eq_type_rep((function()
      return nqa[1]["Exception$lkm"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception2(nnh)
    return function(nqa)
      return from_exception1(nnh, nqa)
    end
  end
  local function _dollardExceptionnmk(tmp)
    return {
      from_exception = from_exception2(tmp),
      describe_exception = function(tmp0)
        return "Invalid argument to function " .. tmp0
      end,
      ["Exception$lkm"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 315,
          name = "invalid_arg"
        })
      end)(),
      into_exception = function(nqq)
        return MkSome(_dollardExceptionnmk(nil))(nqq)
      end
    }
  end
  local function _dollardCategoryadih(tmp)
    return {
      ["%"] = function(f)
        return function(g)
          return function(x) return f(g(x)) end
        end
      end,
      ["%>"] = function(g)
        return function(f)
          return function(x) return f(g(x)) end
        end
      end,
      id = function(x) return x end
    }
  end
  local function filter(p, xs)
    local function loop(acc, x)
      if x.__tag ~= "Cons" then return acc end
      local tmp = x[1]
      return loop({
        { _1 = tmp._1, _2 = acc },
        __tag = "Cons"
      }, tmp._2)
    end
    local function filter_acc(acc, x)
      if x.__tag ~= "Cons" then return acc end
      local tmp = x[1]
      local x0, xs0 = tmp._1, tmp._2
      if p(x0) then
        return filter_acc({
          { _1 = x0, _2 = acc },
          __tag = "Cons"
        }, xs0)
      end
      return filter_acc(acc, xs0)
    end
    return loop(Nil, filter_acc(Nil, xs))
  end
  local function _dollarfoldr(uvo)
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
  local _dollardFoldableuuo, foldl1, foldl10
  _dollardFoldableuuo = function(tmp)
    return {
      foldr = _dollarfoldr(tmp),
      ["Foldable$ucm"] = function(f)
        return function(xs)
          local function bgq(xss)
            if xss.__tag ~= "Cons" then
              return Nil
            end
            local tmp0 = xss[1]
            return {
              { _1 = f(tmp0._1), _2 = bgq(tmp0._2) },
              __tag = "Cons"
            }
          end
          return bgq(xs)
        end
      end,
      foldl1 = foldl1(tmp),
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
  foldl1 = function(uvo)
    return function(vhe)
      return function(vhf)
        return foldl10(uvo, vhe, vhf)
      end
    end
  end
  foldl10 = function(uvo, vhe, vhf)
    local tmp = _dollardFoldableuuo(nil).foldl(function(m)
      return function(y)
        if m.__tag == "Some" then
          return Some(vhe(m[1])(y))
        end
        return Some(y)
      end
    end)(None)(vhf)
    if tmp.__tag == "Some" then
      return tmp[1]
    end
    return error(setmetatable(_dollardExceptionmnx(nil).into_exception("foldl1: empty structure"), {
      __tostring = _dollardExceptionlvd(nil).describe_exception
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
  local function from_exception3(ocm, off)
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 753,
        name = "io_error"
      })
    end)()
    local x = off[2]
    return __eq_type_rep((function()
      return off[1]["Exception$lkm"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception4(ocm)
    return function(off)
      return from_exception3(ocm, off)
    end
  end
  local function _dollardExceptionobp(tmp)
    return {
      from_exception = from_exception4(tmp),
      describe_exception = function(tmp0)
        return "Input/output error: " .. tmp0
      end,
      ["Exception$lkm"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 753,
          name = "io_error"
        })
      end)(),
      into_exception = function(ofv)
        return MkSome(_dollardExceptionobp(nil))(ofv)
      end
    }
  end
  local standard_out = {
    io_stdout,
    __tag = "Ref"
  }
  local function put_line(str)
    local tmp0 = str .. "\n"
    local tmp = standard_out[1]
    wrap_nil(None, function(x)
      return error(setmetatable(_dollardExceptionobp(nil).into_exception(x), {
        __tostring = _dollardExceptionlvd(nil).describe_exception
      }))
    end, Some, function(tmp1)
      return io_write(tmp, tmp0)
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
      return error(setmetatable(_dollardExceptionobp(nil).into_exception(x), {
        __tostring = _dollardExceptionlvd(nil).describe_exception
      }))
    end)
    local tmp1 = wrap_nil(None, function(x)
      return error(setmetatable(_dollardExceptionobp(nil).into_exception(x), {
        __tostring = _dollardExceptionlvd(nil).describe_exception
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
  local function pull_first_bit(tmp1)
    local bits0, value = tmp1._1, tmp1._2
    local function tmp2(tmp2)
      if bits0.__tag == "Cons" then
        return {
          _1 = tmp2,
          _2 = { _1 = bits0[1]._2, _2 = value }
        }
      end
      return {
        _1 = tmp2,
        _2 = {
          _1 = error(setmetatable(_dollardExceptionnmk(nil).into_exception("tail"), {
            __tostring = _dollardExceptionlvd(nil).describe_exception
          })),
          _2 = value
        }
      }
    end
    if bits0.__tag == "Cons" then
      return tmp2(bits0[1]._1)
    end
    return tmp2(error(setmetatable(_dollardExceptionnmk(nil).into_exception("head"), {
      __tostring = _dollardExceptionlvd(nil).describe_exception
    })))
  end
  local function discard_first_bit(tmp1)
    local tmp2 = tmp1._2
    return { _1 = tmp2._1, _2 = tmp2._2 }
  end
  local function find_ratings(bitss)
    local function bgq(xss)
      if xss.__tag ~= "Cons" then
        return Nil
      end
      local tmp1 = xss[1]
      local x = tmp1._1
      return {
        {
          _2 = bgq(tmp1._2),
          _1 = { _1 = x, _2 = x }
        },
        __tag = "Cons"
      }
    end
    local function bgq0(xss)
      if xss.__tag ~= "Cons" then
        return Nil
      end
      local tmp1 = xss[1]
      return {
        {
          _1 = pull_first_bit(tmp1._1),
          _2 = bgq0(tmp1._2)
        },
        __tag = "Cons"
      }
    end
    local pulled = bgq0(bgq(bitss))
    local function separate(values, flag)
      local tmp2 = _dollardFoldableuuo(nil).foldl(_plus0)(0)
      local tmp1 = _dollardCategoryadih(nil)["%>"](function(tmp1)
        return tmp1._1
      end)(int_from_bit)
      local function bgq1(xss)
        if xss.__tag ~= "Cons" then
          return Nil
        end
        local tmp2 = xss[1]
        return {
          {
            _1 = tmp1(tmp2._1),
            _2 = bgq1(tmp2._2)
          },
          __tag = "Cons"
        }
      end
      local count = tmp2(bgq1(values))
      local total = _dollardFoldableuuo(nil).foldl(function(l)
        return function(tmp3) return l + 1 end
      end)(0)(values)
      local subset = filter(function(tmp3)
        local hd = tmp3._1
        if count * 2 >= total then
          return hd == flag
        end
        local tmp4 = bool_eq0(hd)
        if flag then return tmp4(false) end
        return tmp4(true)
      end, values)
      if subset.__tag ~= "Cons" then
        return error(setmetatable(_dollardExceptionnmk(nil).into_exception("should never have an empty list here"), {
          __tostring = _dollardExceptionlvd(nil).describe_exception
        }))
      end
      local tmp3 = subset[1]
      local tmp4 = tmp3._2
      local value = tmp3._1._2._2
      if tmp4.__tag == "Nil" then
        return value
      end
      local tmp5 = _dollardCategoryadih(nil)["%>"](discard_first_bit)(pull_first_bit)
      local function bgq2(xss)
        if xss.__tag ~= "Cons" then
          return Nil
        end
        local tmp6 = xss[1]
        return {
          {
            _1 = tmp5(tmp6._1),
            _2 = bgq2(tmp6._2)
          },
          __tag = "Cons"
        }
      end
      return separate(bgq2(subset), flag)
    end
    return {
      _1 = separate(pulled, true),
      _2 = separate(pulled, false)
    }
  end
  local res = _dollardMonadjky(nil)[">>="](_dollardMonadjky(nil)[">>="](read_input(nil))(function(s0)
    return lpeg.parse(parser)(s0)
  end))(function(bitss)
    local tmp1 = find_ratings(bitss)
    local tmp2 = _dollardFoldableuuo(nil)
    local tmp3 = tmp2["Foldable$ucm"](int_from_bit)(tmp1._1)
    local tmp6 = tmp2.foldl(function(acc)
      return function(_bit0)
        return acc * 2 + _bit0
      end
    end)(0)(tmp3)
    local tmp4 = _dollardFoldableuuo(nil)
    local tmp5 = tmp4["Foldable$ucm"](int_from_bit)(tmp1._2)
    return Some(tmp6 * tmp4.foldl(function(acc)
      return function(_bit0)
        return acc * 2 + _bit0
      end
    end)(0)(tmp5))
  end)
  if res.__tag == "Some" then
    put_line("Some (" .. string_of_int(res[1]) .. ")")
  else
    put_line("None")
  end
end