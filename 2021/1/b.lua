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
  local function _dollardExceptionluf(tmp)
    return {
      from_exception = function(x)
        return Some(x)
      end,
      ["Exception$ljo"] = _Typeable_app({
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
  local function from_exception(mnw, mqp)
    local x = mqp[2]
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 305,
        name = "user_error"
      })
    end)()
    return __eq_type_rep((function()
      return mqp[1]["Exception$ljo"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception0(mnw)
    return function(mqp)
      return from_exception(mnw, mqp)
    end
  end
  local function _dollardExceptionmmz(tmp)
    return {
      describe_exception = function(tmp0)
        return "User error: " .. tmp0
      end,
      ["Exception$ljo"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 305,
          name = "user_error"
        })
      end)(),
      into_exception = function(mrf)
        return MkSome(_dollardExceptionmmz(nil))(mrf)
      end,
      from_exception = from_exception0(tmp)
    }
  end
  local function _dollardCategoryadhj(tmp)
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
  local function _dollarfoldr(uuq)
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
  local _dollardFoldableutq, foldl1, foldl10
  _dollardFoldableutq = function(tmp)
    return {
      foldl1 = foldl1(tmp),
      foldr = _dollarfoldr(tmp),
      ["Foldable$ubo"] = function(f)
        return function(xs)
          local function bfs(xss)
            if xss.__tag ~= "Cons" then
              return Nil
            end
            local tmp0 = xss[1]
            return {
              { _1 = f(tmp0._1), _2 = bfs(tmp0._2) },
              __tag = "Cons"
            }
          end
          return bfs(xs)
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
  foldl1 = function(uuq)
    return function(vgg)
      return function(vgh)
        return foldl10(uuq, vgg, vgh)
      end
    end
  end
  foldl10 = function(uuq, vgg, vgh)
    local tmp = _dollardFoldableutq(nil).foldl(function(m)
      return function(y)
        if m.__tag == "Some" then
          return Some(vgg(m[1])(y))
        end
        return Some(y)
      end
    end)(None)(vgh)
    if tmp.__tag == "Some" then
      return tmp[1]
    end
    return error(setmetatable(_dollardExceptionmmz(nil).into_exception("foldl1: empty structure"), {
      __tostring = _dollardExceptionluf(nil).describe_exception
    }))
  end
  local function _dollartraverse(tod)
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
  local _dollardTraversabletnd, sequence, sequence0
  _dollardTraversabletnd = function(tmp)
    return {
      ["Traversable$sjx"] = function(f)
        return function(xs)
          local function bfs(xss)
            if xss.__tag ~= "Cons" then
              return Nil
            end
            local tmp0 = xss[1]
            return {
              { _1 = f(tmp0._1), _2 = bfs(tmp0._2) },
              __tag = "Cons"
            }
          end
          return bfs(xs)
        end
      end,
      sequence = sequence(tmp),
      traverse = _dollartraverse(tmp)
    }
  end
  sequence = function(tod)
    return function(txu)
      return function(txv)
        return sequence0(tod, txu, txv)
      end
    end
  end
  sequence0 = function(tod, txu, txv)
    return _dollardTraversabletnd(nil).traverse(txu)(function(x)
      return x
    end)(txv)
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
  local function from_exception1(obo, oeh)
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 753,
        name = "io_error"
      })
    end)()
    local x = oeh[2]
    return __eq_type_rep((function()
      return oeh[1]["Exception$ljo"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception2(obo)
    return function(oeh)
      return from_exception1(obo, oeh)
    end
  end
  local function _dollardExceptionoar(tmp)
    return {
      into_exception = function(oex)
        return MkSome(_dollardExceptionoar(nil))(oex)
      end,
      from_exception = from_exception2(tmp),
      describe_exception = function(tmp0)
        return "Input/output error: " .. tmp0
      end,
      ["Exception$ljo"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 753,
          name = "io_error"
        })
      end)()
    }
  end
  local function read_line(file)
    return wrap_nil(None, function(x)
      return error(setmetatable(_dollardExceptionoar(nil).into_exception(x), {
        __tostring = _dollardExceptionluf(nil).describe_exception
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
      return error(setmetatable(_dollardExceptionoar(nil).into_exception(x), {
        __tostring = _dollardExceptionluf(nil).describe_exception
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
  local function window3(lst)
    if lst.__tag ~= "Cons" then
      return Nil
    end
    local tmp = lst[1]
    local tmp0, tmp1 = tmp._1, tmp._2
    if tmp1.__tag ~= "Cons" then
      return Nil
    end
    local tmp2 = tmp1[1]
    local tmp3 = tmp2._1
    local tmp4 = tmp2._2
    if tmp4.__tag ~= "Cons" then
      return Nil
    end
    local tmp5 = tmp4[1]
    local c = tmp5._1
    local tmp6 = tmp5._2
    if tmp6.__tag == "Nil" then
      return {
        {
          _2 = Nil,
          _1 = {
            {
              _1 = tmp0,
              _2 = {
                {
                  _1 = tmp3,
                  _2 = {
                    { _1 = c, _2 = Nil },
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
    end
    return {
      {
        _1 = {
          {
            _1 = tmp0,
            _2 = {
              {
                _1 = tmp3,
                _2 = {
                  { _1 = c, _2 = Nil },
                  __tag = "Cons"
                }
              },
              __tag = "Cons"
            }
          },
          __tag = "Cons"
        },
        _2 = window3(tmp1)
      },
      __tag = "Cons"
    }
  end
  local function bfs(xss)
    if xss.__tag ~= "Cons" then
      return Nil
    end
    local tmp = xss[1]
    return {
      {
        _1 = prim_parse_int(Some, None, tmp._1),
        _2 = bfs(tmp._2)
      },
      __tag = "Cons"
    }
  end
  local parsed = _dollardTraversabletnd(nil).sequence({
    ["Applicative$fph"] = function(f)
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
  })(bfs(read_lines(io_open("input.txt", "r", function(x)
    return x
  end, function(x)
    return error(setmetatable(_dollardExceptionoar(nil).into_exception(x), {
      __tostring = _dollardExceptionluf(nil).describe_exception
    }))
  end))))
  local tmp = _dollardCategoryadhj(nil)["%"](_dollardFoldableutq(nil).foldl(function(tmp)
    local count, old = tmp._1, tmp._2
    return function(new)
      local newsum = _dollardFoldableutq(nil).foldl(_plus0)(0)(new)
      if old < newsum then
        return { _1 = count + 1, _2 = newsum }
      end
      return { _1 = count, _2 = newsum }
    end
  end)({ _1 = -1, _2 = -1 }))(window3)
  if parsed.__tag == "Some" then
    local tmp0 = tmp(parsed[1])
    put_line("Some (" .. ("(" .. string_of_int(tmp0._1) .. ", " .. string_of_int(tmp0._2) .. ")") .. ")")
  else
    put_line("None")
  end
end