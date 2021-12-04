do
  local function MkSome(a)
    return function(b)
      return { __tag = "MkSome", a, b }
    end
  end
  local Proxy = { __tag = "Proxy" }
  local function T(a)
    return { __tag = "T", a }
  end
  local E = { __tag = "E" }
  local function Array(a)
    return { __tag = "Array", a }
  end
  local function Parser_coll_array(a)
    return {
      __tag = "Parser_coll_array",
      a
    }
  end
  local Nil = { __tag = "Nil" }
  local function Parser_coll_list(a)
    return { __tag = "Parser_coll_list", a }
  end
  local None = { __tag = "None" }
  local function Some(a)
    return { __tag = "Some", a }
  end
  local function Parser_tuple(a)
    return { __tag = "Parser_tuple", a }
  end
  local function _TypeRep(x)
    return {
      {
        name = x.name .. "#" .. x.fingerprint
      },
      __tag = "TypeRep"
    }
  end
  local Gt = { __tag = "Gt" }
  local function __eq_type_rep(tr_a, tr_b, keq, kne)
    if tr_a[1].name == tr_b[1].name then
      return keq()()
    else
      return kne()
    end
  end
  local Eq = { __tag = "Eq" }
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
  local Lt = { __tag = "Lt" }
  local function _plus0(tmp)
    return function(tmp0)
      return tmp + tmp0
    end
  end
  local function int_eq0(tmp)
    return function(tmp0)
      return tmp == tmp0
    end
  end
  local function lt_int0(tmp)
    return function(tmp0)
      return tmp < tmp0
    end
  end
  local function lte_int0(tmp)
    return function(tmp0)
      return tmp <= tmp0
    end
  end
  local function gt_int0(tmp)
    return function(tmp0)
      return tmp > tmp0
    end
  end
  local function gte_int0(tmp)
    return function(tmp0)
      return tmp >= tmp0
    end
  end
  local string_of_int = tostring
  local function _dollar_less_star_greater(hlb)
    return function(_fs)
      return function(xs)
        local function cdq(xss)
          if xss.__tag ~= "Cons" then
            return Nil
          end
          local tmp = xss[1]
          local x, xs0 = tmp._1, tmp._2
          local function cdu(xss0)
            if xss0.__tag ~= "Cons" then
              return cdq(xs0)
            end
            local tmp0 = xss0[1]
            return {
              { _1 = x(tmp0._1), _2 = cdu(tmp0._2) },
              __tag = "Cons"
            }
          end
          return cdu(xs)
        end
        return cdq(_fs)
      end
    end
  end
  local function _dollardApplicativehkb(tmp)
    return {
      pure = function(x)
        return {
          { _1 = x, _2 = Nil },
          __tag = "Cons"
        }
      end,
      ["<*>"] = _dollar_less_star_greater(tmp),
      ["Applicative$gnb"] = function(f)
        return function(xs)
          local function cdm(xss)
            if xss.__tag ~= "Cons" then
              return Nil
            end
            local tmp0 = xss[1]
            return {
              { _1 = f(tmp0._1), _2 = cdm(tmp0._2) },
              __tag = "Cons"
            }
          end
          return cdm(xs)
        end
      end
    }
  end
  local function _dollar_greater_greater_equals(hsw)
    return function(xs)
      return function(f)
        local function cdy(xss)
          if xss.__tag ~= "Cons" then
            return Nil
          end
          local tmp = xss[1]
          local xs0 = tmp._2
          local function cec(xss0)
            if xss0.__tag ~= "Cons" then
              return cdy(xs0)
            end
            local tmp0 = xss0[1]
            return {
              { _2 = cec(tmp0._2), _1 = tmp0._1 },
              __tag = "Cons"
            }
          end
          return cec(f(tmp._1))
        end
        return cdy(xs)
      end
    end
  end
  local function _dollardMonadhrw(tmp)
    return {
      join = function(xss)
        local function ceg(xss0)
          if xss0.__tag ~= "Cons" then
            return Nil
          end
          local tmp0 = xss0[1]
          local xs = tmp0._2
          local function cek(xss1)
            if xss1.__tag ~= "Cons" then
              return ceg(xs)
            end
            local tmp1 = xss1[1]
            return {
              { _1 = tmp1._1, _2 = cek(tmp1._2) },
              __tag = "Cons"
            }
          end
          return cek(tmp0._1)
        end
        return ceg(xss)
      end,
      [">>="] = _dollar_greater_greater_equals(tmp),
      ["Monad$gvy"] = _dollardApplicativehkb(nil)
    }
  end
  local function _colon_colon(x)
    return function(xs)
      return {
        { _1 = x, _2 = xs },
        __tag = "Cons"
      }
    end
  end
  local _dollardMonadkhu, join, join0
  _dollardMonadkhu = function(tmp)
    return {
      ["Monad$gvy"] = {
        ["Applicative$gnb"] = function(f)
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
  join = function(kiu)
    return function(klv)
      return join0(kiu, klv)
    end
  end
  join0 = function(kiu, klv)
    return _dollardMonadkhu(nil)[">>="](klv)(function(x)
      return x
    end)
  end
  local function _dollardExceptionmrz(tmp)
    return {
      ["Exception$mhi"] = _Typeable_app({
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
  local function from_exception(nlq, noj)
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 305,
        name = "user_error"
      })
    end)()
    local x = noj[2]
    return __eq_type_rep((function()
      return noj[1]["Exception$mhi"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception0(nlq)
    return function(noj)
      return from_exception(nlq, noj)
    end
  end
  local function _dollardExceptionnkt(tmp)
    return {
      into_exception = function(noz)
        return MkSome(_dollardExceptionnkt(nil))(noz)
      end,
      from_exception = from_exception0(tmp),
      describe_exception = function(tmp0)
        return "User error: " .. tmp0
      end,
      ["Exception$mhi"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 305,
          name = "user_error"
        })
      end)()
    }
  end
  local function from_exception1(okd, omw)
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 315,
        name = "invalid_arg"
      })
    end)()
    local x = omw[2]
    return __eq_type_rep((function()
      return omw[1]["Exception$mhi"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception2(okd)
    return function(omw)
      return from_exception1(okd, omw)
    end
  end
  local function _dollardExceptionojg(tmp)
    return {
      from_exception = from_exception2(tmp),
      describe_exception = function(tmp0)
        return "Invalid argument to function " .. tmp0
      end,
      ["Exception$mhi"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 315,
          name = "invalid_arg"
        })
      end)(),
      into_exception = function(onm)
        return MkSome(_dollardExceptionojg(nil))(onm)
      end
    }
  end
  local function _dollardCategoryaefd(tmp)
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
  local function _dollarfoldr(vsk)
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
  local _dollardFoldablevrk, foldl1, foldl10
  _dollardFoldablevrk = function(tmp)
    return {
      foldr = _dollarfoldr(tmp),
      ["Foldable$vai"] = function(f)
        return function(xs)
          local function cdm(xss)
            if xss.__tag ~= "Cons" then
              return Nil
            end
            local tmp0 = xss[1]
            return {
              { _1 = f(tmp0._1), _2 = cdm(tmp0._2) },
              __tag = "Cons"
            }
          end
          return cdm(xs)
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
  foldl1 = function(vsk)
    return function(wea)
      return function(web)
        return foldl10(vsk, wea, web)
      end
    end
  end
  foldl10 = function(vsk, wea, web)
    local tmp = _dollardFoldablevrk(nil).foldl(function(m)
      return function(y)
        if m.__tag == "Some" then
          return Some(wea(m[1])(y))
        end
        return Some(y)
      end
    end)(None)(web)
    if tmp.__tag == "Some" then
      return tmp[1]
    end
    return error(setmetatable(_dollardExceptionnkt(nil).into_exception("foldl1: empty structure"), {
      __tostring = _dollardExceptionmrz(nil).describe_exception
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
  local function from_exception3(pai, pcb)
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 753,
        name = "io_error"
      })
    end)()
    local x = pcb[2]
    return __eq_type_rep((function()
      return pcb[1]["Exception$mhi"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception4(pai)
    return function(pcb)
      return from_exception3(pai, pcb)
    end
  end
  local function _dollardExceptionoyl(tmp)
    return {
      from_exception = from_exception4(tmp),
      describe_exception = function(tmp0)
        return "Input/output error: " .. tmp0
      end,
      ["Exception$mhi"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 753,
          name = "io_error"
        })
      end)(),
      into_exception = function(pcr)
        return MkSome(_dollardExceptionoyl(nil))(pcr)
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
      return error(setmetatable(_dollardExceptionoyl(nil).into_exception(x), {
        __tostring = _dollardExceptionmrz(nil).describe_exception
      }))
    end, Some, function(tmp1)
      return io_write(tmp, tmp0)
    end)
    return nil
  end
  local tabulate = function(index, cont)
    local r = {}
    for i = 1 , index , 1 do
      r[i] = cont(i)
    end
    return r
  end
  local geti = rawget
  local seti = rawset
  local function _dollarfoldl(bdat)
    return function(func)
      return function(acc)
        return function(tmp)
          local tmp0 = tmp[1]
          local backing, length = tmp0.backing, tmp0.length
          local function loop(acc0, i)
            if i > length then return acc0 end
            return loop(func(acc0)(geti(backing, i)), i + 1)
          end
          return loop(acc, 1)
        end
      end
    end
  end
  local function _dollarfoldr0(bdat)
    return function(func)
      return function(acc)
        return function(tmp)
          local tmp0 = tmp[1]
          local backing = tmp0.backing
          local function loop(acc0, i)
            if i < 1 then return acc0 end
            return loop(func(geti(backing, i))(acc0), i - 1)
          end
          return loop(acc, tmp0.length)
        end
      end
    end
  end
  local _dollardFoldablebcyq, foldl11, foldl12
  _dollardFoldablebcyq = function(tmp)
    return {
      ["Foldable$vai"] = function(f)
        return function(tmp0)
          local tmp1 = tmp0[1]
          local backing, length = tmp1.backing, tmp1.length
          return Array({
            length = length,
            backing = tabulate(length, function(i)
              return f(geti(backing, i))
            end)
          })
        end
      end,
      foldl1 = foldl11(tmp),
      foldr = _dollarfoldr0(tmp),
      foldl = _dollarfoldl(tmp)
    }
  end
  foldl11 = function(bdat)
    return function(bdnx)
      return function(bdny)
        return foldl12(bdat, bdnx, bdny)
      end
    end
  end
  foldl12 = function(bdat, bdnx, bdny)
    local tmp = _dollardFoldablebcyq(nil).foldl(function(m)
      return function(y)
        if m.__tag == "Some" then
          return Some(bdnx(m[1])(y))
        end
        return Some(y)
      end
    end)(None)(bdny)
    if tmp.__tag == "Some" then
      return tmp[1]
    end
    return error(setmetatable(_dollardExceptionnkt(nil).into_exception("foldl1: empty structure"), {
      __tostring = _dollardExceptionmrz(nil).describe_exception
    }))
  end
  local function _dollar_dot_28_29(beny, arr, i)
    local length = arr[1].length
    local function tmp(tmp)
      if tmp then
        return geti(arr[1].backing, i + 1)
      end
      error(setmetatable(_dollardExceptionojg(nil).into_exception("(.())" .. ": index " .. string_of_int(i) .. " is out of bounds"), {
        __tostring = _dollardExceptionmrz(nil).describe_exception
      }))
      return geti(arr[1].backing, i + 1)
    end
    if i >= 0 then
      return tmp(i < length)
    end
    return tmp(false)
  end
  local function _dollar_dot_28_290(beny)
    return function(arr)
      return function(i)
        return _dollar_dot_28_29(beny, arr, i)
      end
    end
  end
  local function _dollardIndexbemo(tmp)
    return {
      [".()"] = _dollar_dot_28_290(tmp),
      [".?()"] = function(arr)
        return function(i)
          local length = arr[1].length
          if not (i >= 0) then return None end
          if i < length then
            return Some(geti(arr[1].backing, i + 1))
          end
          return None
        end
      end
    }
  end
  local function _dollar_dot_lbrack_rbrack_less_minus(bfah, arr, i, x)
    local length = arr[1].length
    local function tmp(tmp)
      if tmp then
        seti(arr[1].backing, i + 1, x)
        return nil
      else
        error(setmetatable(_dollardExceptionojg(nil).into_exception("update" .. ": index " .. string_of_int(i) .. " is out of bounds"), {
          __tostring = _dollardExceptionmrz(nil).describe_exception
        }))
        seti(arr[1].backing, i + 1, x)
        return nil
      end
    end
    if i >= 0 then
      return tmp(i < length)
    end
    return tmp(false)
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
  local function read_input(tmp)
    local tmp0 = io_open("input.txt", "r", function(x)
      return x
    end, function(x)
      return error(setmetatable(_dollardExceptionoyl(nil).into_exception(x), {
        __tostring = _dollardExceptionmrz(nil).describe_exception
      }))
    end)
    local tmp1 = wrap_nil(None, function(x)
      return error(setmetatable(_dollardExceptionoyl(nil).into_exception(x), {
        __tostring = _dollardExceptionmrz(nil).describe_exception
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
  local function singleton(x)
    return T({
      _1 = x,
      _2 = { _1 = 1, _2 = { _1 = E, _2 = E } }
    })
  end
  local function balance_l(x, l, r0)
    if r0.__tag == "E" then
      if l.__tag == "E" then
        return T({
          _1 = x,
          _2 = { _1 = 1, _2 = { _1 = E, _2 = E } }
        })
      end
      local tmp = l[1]
      local tmp0 = tmp._1
      local tmp1 = tmp._2
      local tmp3 = tmp1._2
      local tmp4, tmp5 = tmp3._1, tmp3._2
      local tmp2 = tmp1._1
      if tmp5.__tag == "E" then
        if tmp4.__tag == "E" then
          return T({
            _1 = x,
            _2 = { _1 = 2, _2 = { _1 = l, _2 = E } }
          })
        end
        return T({
          _1 = tmp0,
          _2 = {
            _1 = 3,
            _2 = {
              _1 = tmp4,
              _2 = T({
                _1 = x,
                _2 = { _1 = 1, _2 = { _1 = E, _2 = E } }
              })
            }
          }
        })
      else
        local tmp6 = tmp5[1]
        local lrx = tmp6._1
        local tmp7 = tmp6._2
        if tmp4.__tag == "E" then
          local tmp7 = {
            _1 = 1,
            _2 = { _1 = E, _2 = E }
          }
          return T({
            _1 = lrx,
            _2 = {
              _1 = 3,
              _2 = {
                _2 = T({ _1 = x, _2 = tmp7 }),
                _1 = T({ _1 = tmp0, _2 = tmp7 })
              }
            }
          })
        else
          local tmp9 = tmp4[1]._2
          local lls = tmp9._1
          local tmp8 = tmp7._2
          local lrl, lrr = tmp8._1, tmp8._2
          local lrs = tmp7._1
          if lrs < 2 * lls then
            return T({
              _1 = tmp0,
              _2 = {
                _2 = {
                  _1 = tmp4,
                  _2 = T({
                    _1 = x,
                    _2 = {
                      _1 = 1 + lrs,
                      _2 = { _1 = tmp5, _2 = E }
                    }
                  })
                },
                _1 = 1 + tmp2
              }
            })
          end
          local tmp11 = 1 + tmp2
          local tmp10 = 1 + lls
          local function tmp12(tmp12)
            local tmp13 = T({
              _1 = tmp0,
              _2 = {
                _2 = { _1 = tmp4, _2 = lrl },
                _1 = tmp10 + tmp12
              }
            })
            local function tmp14(tmp14)
              return T({
                _1 = lrx,
                _2 = {
                  _1 = tmp11,
                  _2 = {
                    _1 = tmp13,
                    _2 = T({
                      _1 = x,
                      _2 = {
                        _1 = 1 + tmp14,
                        _2 = { _1 = lrr, _2 = E }
                      }
                    })
                  }
                }
              })
            end
            if lrr.__tag == "E" then
              return tmp14(0)
            end
            return tmp14(lrr[1]._2._1)
          end
          if lrl.__tag == "E" then
            return tmp12(0)
          end
          return tmp12(lrl[1]._2._1)
        end
      end
    else
      local tmp = r0[1]._2
      local rs = tmp._1
      if l.__tag == "E" then
        return T({
          _1 = x,
          _2 = {
            _2 = { _1 = E, _2 = r0 },
            _1 = 1 + rs
          }
        })
      end
      local tmp0 = l[1]
      local tmp1 = tmp0._2
      local tmp2 = tmp1._2
      local ll, lr = tmp2._1, tmp2._2
      local ls = tmp1._1
      local lx = tmp0._1
      if not (ls > 3 * rs) then
        return T({
          _1 = x,
          _2 = {
            _2 = { _1 = l, _2 = r0 },
            _1 = 1 + ls + rs
          }
        })
      end
      if ll.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      local tmp3 = ll[1]._2
      local lls = tmp3._1
      if lr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      if lr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      local tmp4 = lr[1]
      local lrx = tmp4._1
      if ll.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      if ll.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      if lr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      local tmp5 = lr[1]._2
      local lrs = tmp5._1
      if lr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      local tmp6 = lr[1]._2._2
      local lrl = tmp6._1
      if ll.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      if lr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      local tmp7 = lr[1]._2._2
      local lrr = tmp7._2
      if ll.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      if lrs < 2 * lls then
        return T({
          _1 = lx,
          _2 = {
            _2 = {
              _1 = ll,
              _2 = T({
                _1 = x,
                _2 = {
                  _2 = { _1 = lr, _2 = r0 },
                  _1 = 1 + rs + lrs
                }
              })
            },
            _1 = 1 + ls + rs
          }
        })
      end
      local tmp9 = 1 + ls + rs
      local tmp8 = 1 + lls
      local function tmp10(tmp10)
        local tmp12 = T({
          _1 = lx,
          _2 = {
            _2 = { _1 = ll, _2 = lrl },
            _1 = tmp8 + tmp10
          }
        })
        local tmp11 = 1 + rs
        local function tmp13(tmp13)
          return T({
            _1 = lrx,
            _2 = {
              _1 = tmp9,
              _2 = {
                _1 = tmp12,
                _2 = T({
                  _1 = x,
                  _2 = {
                    _2 = { _1 = lrr, _2 = r0 },
                    _1 = tmp11 + tmp13
                  }
                })
              }
            }
          })
        end
        if lrr.__tag == "E" then
          return tmp13(0)
        end
        return tmp13(lrr[1]._2._1)
      end
      if lrl.__tag == "E" then
        return tmp10(0)
      end
      return tmp10(lrl[1]._2._1)
    end
  end
  local function balance_r(x, l, r0)
    if l.__tag == "E" then
      if r0.__tag == "E" then
        return T({
          _1 = x,
          _2 = { _1 = 1, _2 = { _1 = E, _2 = E } }
        })
      end
      local tmp = r0[1]
      local tmp0 = tmp._1
      local tmp1 = tmp._2
      local tmp3 = tmp1._2
      local tmp4, tmp5 = tmp3._1, tmp3._2
      local tmp2 = tmp1._1
      if tmp5.__tag == "E" then
        if tmp4.__tag == "E" then
          return T({
            _1 = x,
            _2 = {
              _1 = 2,
              _2 = { _1 = E, _2 = r0 }
            }
          })
        end
        local tmp6 = {
          _1 = 1,
          _2 = { _1 = E, _2 = E }
        }
        return T({
          _2 = {
            _1 = 3,
            _2 = {
              _1 = T({ _1 = x, _2 = tmp6 }),
              _2 = T({ _1 = tmp0, _2 = tmp6 })
            }
          },
          _1 = tmp4[1]._1
        })
      else
        local tmp6 = tmp5[1]
        if tmp4.__tag == "E" then
          return T({
            _1 = tmp0,
            _2 = {
              _1 = 3,
              _2 = {
                _1 = T({
                  _1 = x,
                  _2 = { _1 = 1, _2 = { _1 = E, _2 = E } }
                }),
                _2 = tmp5
              }
            }
          })
        end
        local tmp7 = tmp4[1]
        local rlx = tmp7._1
        local tmp8 = tmp7._2
        local tmp9 = tmp8._2
        local rll, rlr = tmp9._1, tmp9._2
        local rls = tmp8._1
        local tmp10 = tmp6._2
        local rrs = tmp10._1
        if rls < 2 * rrs then
          return T({
            _1 = tmp0,
            _2 = {
              _2 = {
                _1 = T({
                  _1 = x,
                  _2 = {
                    _2 = { _1 = E, _2 = tmp4 },
                    _1 = 1 + rls
                  }
                }),
                _2 = tmp5
              },
              _1 = 1 + tmp2
            }
          })
        end
        local tmp11 = 1 + tmp2
        local function tmp12(tmp12)
          local tmp14 = 1 + rrs
          local tmp13 = T({
            _1 = x,
            _2 = {
              _2 = { _1 = E, _2 = rll },
              _1 = 1 + tmp12
            }
          })
          local function tmp15(tmp15)
            return T({
              _1 = rlx,
              _2 = {
                _1 = tmp11,
                _2 = {
                  _1 = tmp13,
                  _2 = T({
                    _1 = tmp0,
                    _2 = {
                      _1 = tmp14 + tmp15,
                      _2 = { _1 = rlr, _2 = tmp5 }
                    }
                  })
                }
              }
            })
          end
          if rlr.__tag == "E" then
            return tmp15(0)
          end
          return tmp15(rlr[1]._2._1)
        end
        if rll.__tag == "E" then
          return tmp12(0)
        end
        return tmp12(rll[1]._2._1)
      end
    else
      local tmp = l[1]._2
      local ls = tmp._1
      if r0.__tag == "E" then
        return T({
          _1 = x,
          _2 = {
            _2 = { _1 = l, _2 = E },
            _1 = 1 + ls
          }
        })
      end
      local tmp0 = r0[1]
      local rx = tmp0._1
      local tmp1 = tmp0._2
      local tmp2 = tmp1._2
      local rl, rr = tmp2._1, tmp2._2
      local rs = tmp1._1
      if not (rs > 3 * ls) then
        return T({
          _1 = x,
          _2 = {
            _2 = { _1 = l, _2 = r0 },
            _1 = 1 + rs + ls
          }
        })
      end
      if rr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[97:13 ..97:62]")
      end
      if rl.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[97:13 ..97:62]")
      end
      local tmp3 = rl[1]
      local rlx = tmp3._1
      if rr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[97:13 ..97:62]")
      end
      if rl.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[97:13 ..97:62]")
      end
      local tmp4 = rl[1]._2
      local rls = tmp4._1
      if rr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[97:13 ..97:62]")
      end
      if rl.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[97:13 ..97:62]")
      end
      local tmp5 = rl[1]._2._2
      local rll = tmp5._1
      if rl.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[97:13 ..97:62]")
      end
      local tmp6 = rl[1]._2._2
      local rlr = tmp6._2
      if rr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[97:13 ..97:62]")
      end
      if rr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[97:13 ..97:62]")
      end
      local tmp7 = rr[1]._2
      local rrs = tmp7._1
      if rl.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[97:13 ..97:62]")
      end
      if rls < 2 * rrs then
        local tmp8 = 1 + ls
        return T({
          _1 = rx,
          _2 = {
            _1 = tmp8 + rs,
            _2 = {
              _1 = T({
                _1 = x,
                _2 = {
                  _2 = { _1 = l, _2 = rl },
                  _1 = tmp8 + rls
                }
              }),
              _2 = rr
            }
          }
        })
      else
        local tmp8 = 1 + ls
        local tmp9 = tmp8 + rs
        local function tmp10(tmp10)
          local tmp12 = 1 + rrs
          local tmp11 = T({
            _1 = x,
            _2 = {
              _2 = { _1 = l, _2 = rll },
              _1 = tmp8 + tmp10
            }
          })
          local function tmp13(tmp13)
            return T({
              _1 = rlx,
              _2 = {
                _1 = tmp9,
                _2 = {
                  _1 = tmp11,
                  _2 = T({
                    _1 = rx,
                    _2 = {
                      _1 = tmp12 + tmp13,
                      _2 = { _1 = rlr, _2 = rr }
                    }
                  })
                }
              }
            })
          end
          if rlr.__tag == "E" then
            return tmp13(0)
          end
          return tmp13(rlr[1]._2._1)
        end
        if rll.__tag == "E" then
          return tmp10(0)
        end
        return tmp10(rll[1]._2._1)
      end
    end
  end
  local function anqa(anoi)
    local function _dollarinsert(x, x0)
      if x0.__tag == "E" then
        return singleton(x)
      end
      local tmp = x0[1]
      local tmp0 = tmp._2._2
      local l, r0 = tmp0._1, tmp0._2
      local y = tmp._1
      local tmp1 = anoi.compare(x)(y)
      if tmp1.__tag == "Lt" then
        return balance_l(y, _dollarinsert(x, l), r0)
      elseif tmp1.__tag == "Gt" then
        return balance_r(y, l, _dollarinsert(x, r0))
      else
        return x0
      end
    end
    return {
      insert = function(x)
        return function(x0)
          return _dollarinsert(x, x0)
        end
      end
    }
  end
  local function _less_greater(asbv)
    return function(asfk)
      return function(asfl)
        return not asbv["=="](asfk._1)(asfl._1)
      end
    end
  end
  local function _dollardOrdasfp(tmp)
    local tmp0 = tmp["Ord$dvj"]
    return {
      ["<="] = function(asoo)
        return function(asop)
          local tmp1 = _dollardOrdasfp(tmp).compare(asoo)(asop)
          if tmp1.__tag == "Gt" then
            return false
          end
          return true
        end
      end,
      [">"] = function(aspp)
        return function(aspq)
          local tmp1 = _dollardOrdasfp(tmp).compare(aspp)(aspq)
          if tmp1.__tag == "Gt" then
            return true
          end
          return false
        end
      end,
      [">="] = function(asqq)
        return function(asqr)
          local tmp1 = _dollardOrdasfp(tmp).compare(asqq)(asqr)
          if tmp1.__tag == "Lt" then
            return false
          end
          return true
        end
      end,
      ["<"] = function(asnn)
        return function(asno)
          local tmp1 = _dollardOrdasfp(tmp).compare(asnn)(asno)
          if tmp1.__tag == "Lt" then
            return true
          end
          return false
        end
      end,
      ["Ord$dvj"] = {
        ["=="] = function(tmp1)
          local a = tmp1._1
          return function(tmp2)
            return tmp0["=="](a)(tmp2._1)
          end
        end,
        ["<>"] = _less_greater(tmp0)
      },
      compare = function(tmp1)
        local a = tmp1._1
        return function(tmp2)
          return tmp.compare(a)(tmp2._1)
        end
      end
    }
  end
  local function _dollar_dot_28_291(auyf)
    return function(map)
      return function(key)
        local function _dollargo(x)
          if x.__tag == "E" then return None end
          local tmp = x[1]
          local tmp1 = tmp._1
          local x0 = tmp1._2
          local tmp0 = tmp._2._2
          local l = tmp0._1
          local r0 = tmp0._2
          local tmp2 = auyf.compare(key)(tmp1._1)
          if tmp2.__tag == "Lt" then
            return _dollargo(l)
          elseif tmp2.__tag == "Eq" then
            return Some(x0)
          elseif tmp2.__tag == "Gt" then
            return _dollargo(r0)
          end
        end
        local tmp = _dollargo(map)
        if tmp.__tag == "Some" then
          return tmp[1]
        end
        return error(setmetatable(_dollardExceptionnkt(nil).into_exception("Map.(.[]): no such key in map"), {
          __tostring = _dollardExceptionmrz(nil).describe_exception
        }))
      end
    end
  end
  local function _dollardIndexauwf(tmp)
    return {
      [".()"] = _dollar_dot_28_291(tmp),
      [".?()"] = function(map)
        return function(k)
          local function _dollargo(x)
            if x.__tag == "E" then return None end
            local tmp0 = x[1]
            local tmp2 = tmp0._1
            local tmp3 = tmp.compare(k)(tmp2._1)
            local x0 = tmp2._2
            local tmp1 = tmp0._2._2
            local l = tmp1._1
            local r0 = tmp1._2
            if tmp3.__tag == "Lt" then
              return _dollargo(l)
            elseif tmp3.__tag == "Eq" then
              return Some(x0)
            elseif tmp3.__tag == "Gt" then
              return _dollargo(r0)
            end
          end
          return _dollargo(map)
        end
      end
    }
  end
  local tmp = int_parser * (p(",") * int_parser) ^ 0
  local tmp10 = lpeg.collect_list(Nil)(Cons)(Parser_coll_list({}))(tmp) * wsp
  local board_row = lpeg.collect_array(Parser_coll_array({}))(int_parser * (p(" ") ^ 1 * int_parser) ^ 0)
  local board = lpeg.collect_array(Parser_coll_array({}))(board_row * (p("\n") * p(" ") ^ 0 * board_row) ^ 0)
  local tmp12 = lpeg.collect_tuple(Parser_tuple({}))
  local tmp0 = wsp * board
  local tmp1 = tmp0 ^ 0
  local tmp2 = board * tmp1
  local tmp7 = tmp2 ^ -1
  local tmp3 = lpeg.collect_list
  local tmp4 = tmp3(Nil)
  local tmp6 = tmp4(Cons)
  local tmp5 = Parser_coll_list({})
  local tmp8 = tmp6(tmp5)
  local tmp9 = tmp8(tmp7)
  local tmp11 = tmp10 * tmp9
  local parser = tmp12(tmp11)
  local function check_place_win(board0, x, y)
    local tmp13 = board0[1]
    local backing, length = tmp13.backing, tmp13.length
    local tmp15 = tabulate(length, function(i)
      local tmp14 = geti(backing, i)
      return _dollardIndexbemo(nil)[".()"](tmp14)(x)
    end)
    local aebs = _dollardCategoryaefd(nil)
    local tmp14 = aebs.id
    local function all_sat(x0)
      if x0.__tag ~= "Cons" then
        return true
      end
      local tmp15 = x0[1]
      local xs = tmp15._2
      return tmp14(tmp15._1) and all_sat(xs)
    end
    if all_sat(_dollardFoldablebcyq(nil).foldr(_colon_colon)(Nil)(_dollardIndexbemo(nil)[".()"](board0)(y))) then
      return true
    end
    local aebs0 = _dollardCategoryaefd(nil)
    local tmp16 = aebs0.id
    local function all_sat0(x0)
      if x0.__tag ~= "Cons" then
        return true
      end
      local tmp17 = x0[1]
      local xs = tmp17._2
      return tmp16(tmp17._1) and all_sat0(xs)
    end
    return all_sat0(_dollardFoldablebcyq(nil).foldr(_colon_colon)(Nil)(Array({
      length = length,
      backing = tmp15
    })))
  end
  local tmp13 = _dollardIndexbemo(nil)
  local cvcj = _dollardIndexbemo(nil)
  local function mark(call)
    return function(tmp14)
      local tmp15 = tmp14._2
      local marks = tmp15._1
      local tmp16 = {
        [".[]<-"] = function(arr)
          return function(i)
            return function(x)
              return _dollar_dot_lbrack_rbrack_less_minus(nil, arr, i, x)
            end
          end
        end,
        ["Mut_index$aroi"] = tmp13
      }
      local slot = tmp14._1
      return _dollardMonadkhu(nil)[">>="](_dollardIndexauwf({
        compare = function(fgu)
          return function(fgv)
            if fgu == fgv then return Eq end
            if fgu <= fgv then return Lt end
            return Gt
          end
        end,
        ["Ord$dvj"] = {
          ["=="] = int_eq0,
          ["<>"] = function(cvx)
            return function(cvy)
              return cvx ~= cvy
            end
          end
        },
        ["<"] = lt_int0,
        ["<="] = lte_int0,
        [">"] = gt_int0,
        [">="] = gte_int0
      })[".?()"](tmp15._2)(call))(function(tmp17)
        local x, y = tmp17._1, tmp17._2;
        tmp16[".[]<-"](cvcj[".()"](marks)(y))(x)(true)
        if not check_place_win(marks, x, y) then
          return None
        end
        local function zip_with_sat(xs, ys)
          if ys.__tag ~= "Cons" then
            return Nil
          end
          local tmp18 = ys[1]
          local y0 = tmp18._1
          local ys0 = tmp18._2
          if xs.__tag ~= "Cons" then
            return Nil
          end
          local function zip_with_sat0(xs0)
            return function(ys1)
              if ys1.__tag ~= "Cons" then
                return Nil
              end
              local tmp20 = ys1[1]
              local y1 = tmp20._1
              local ys2 = tmp20._2
              if xs0.__tag ~= "Cons" then
                return Nil
              end
              local tmp21 = xs0[1]
              local x0 = tmp21._1
              local xs1 = tmp21._2
              if y1 then
                return {
                  {
                    _1 = 0,
                    _2 = zip_with_sat0(xs1)(ys2)
                  },
                  __tag = "Cons"
                }
              end
              return {
                {
                  _1 = x0,
                  _2 = zip_with_sat0(xs1)(ys2)
                },
                __tag = "Cons"
              }
            end
          end
          local tmp19 = xs[1]
          return {
            {
              _1 = zip_with_sat0(_dollardFoldablebcyq(nil).foldr(_colon_colon)(Nil)(tmp19._1))(_dollardFoldablebcyq(nil).foldr(_colon_colon)(Nil)(y0)),
              _2 = zip_with_sat(tmp19._2, ys0)
            },
            __tag = "Cons"
          }
        end
        local tmp18 = zip_with_sat(_dollardFoldablebcyq(nil).foldr(_colon_colon)(Nil)(slot), _dollardFoldablebcyq(nil).foldr(_colon_colon)(Nil)(marks))
        local tmp19 = _dollardMonadhrw(nil).join(tmp18)
        return Some(call * _dollardFoldablevrk(nil).foldl(_plus0)(0)(tmp19))
      end)
    end
  end
  local function find_some(x)
    if x.__tag ~= "Cons" then
      return None
    end
    local tmp14 = x[1]
    local tmp15 = tmp14._1
    local tmp16 = tmp14._2
    if tmp15.__tag == "Some" then
      return Some(tmp15[1])
    end
    return find_some(tmp16)
  end
  local res = _dollardMonadkhu(nil)[">>="](_dollardMonadkhu(nil)[">>="](read_input(nil))(function(s0)
    return lpeg.parse(parser)(s0)
  end))(function(tmp14)
    local function zip_with_sat0(xs, ys)
      if ys.__tag ~= "Cons" then
        return Nil
      end
      local tmp20 = ys[1]
      local y = tmp20._1
      local ys0 = tmp20._2
      if xs.__tag ~= "Cons" then
        return Nil
      end
      local tmp21 = xs[1]
      return {
        {
          _1 = { _1 = tmp21._1, _2 = y },
          _2 = zip_with_sat0(tmp21._2, ys0)
        },
        __tag = "Cons"
      }
    end
    local tmp15 = _dollardFoldablebcyq(nil)
    local function cdm(xss)
      if xss.__tag ~= "Cons" then
        return Nil
      end
      local tmp15 = xss[1]
      local tmp16 = tmp15._1[1]
      local backing, length = tmp16.backing, tmp16.length
      return {
        {
          _1 = Array({
            length = length,
            backing = tabulate(length, function(i)
              local tmp17 = geti(backing, i)[1]
              local backing0, length0 = tmp17.backing, tmp17.length
              return Array({
                length = length0,
                backing = tabulate(length0, function(i0)
                  geti(backing0, i0)
                  return false
                end)
              })
            end)
          }),
          _2 = cdm(tmp15._2)
        },
        __tag = "Cons"
      }
    end
    local boards = tmp14._2
    local markers = cdm(boards)
    local tmp17 = _dollardCategoryaefd(nil)["%>"](function(x)
      local tmp16 = x[1]
      local backing, length = tmp16.backing, tmp16.length
      return Array({
        length = length,
        backing = tabulate(length, function(i)
          local tmp17 = geti(backing, i)
          return tmp15.foldr(_colon_colon)(Nil)(tmp17)
        end)
      })
    end)
    local tmp16 = _dollardFoldablebcyq(nil)
    local tmp18 = tmp17(function(xs)
      return tmp16.foldr(_colon_colon)(Nil)(xs)
    end)
    local function cdm0(xss)
      if xss.__tag ~= "Cons" then
        return Nil
      end
      local tmp19 = xss[1]
      return {
        {
          _1 = tmp18(tmp19._1),
          _2 = cdm0(tmp19._2)
        },
        __tag = "Cons"
      }
    end
    local lboards = cdm0(boards)
    local function loop(i, x)
      if x.__tag ~= "Cons" then return Nil end
      local function loop0(i0)
        return function(x0)
          if x0.__tag ~= "Cons" then
            return Nil
          end
          local tmp20 = x0[1]
          return {
            {
              _2 = loop0(i0 + 1)(tmp20._2),
              _1 = {
                _1 = tmp20._1,
                _2 = { _1 = i0, _2 = i }
              }
            },
            __tag = "Cons"
          }
        end
      end
      local tmp19 = x[1]
      return {
        {
          _1 = loop0(0)(tmp19._1),
          _2 = loop(i + 1, tmp19._2)
        },
        __tag = "Cons"
      }
    end
    local tmp19 = _dollardCategoryaefd(nil)["%>"](function(x)
      return loop(0, x)
    end)(_dollardMonadhrw(nil).join)
    local function cdm1(xss)
      if xss.__tag ~= "Cons" then
        return Nil
      end
      local tmp20 = xss[1]
      return {
        {
          _1 = tmp19(tmp20._1),
          _2 = cdm1(tmp20._2)
        },
        __tag = "Cons"
      }
    end
    local function cdm2(xss)
      if xss.__tag ~= "Cons" then
        return Nil
      end
      local tmp21 = {
        compare = function(fgu)
          return function(fgv)
            if fgu == fgv then return Eq end
            if fgu <= fgv then return Lt end
            return Gt
          end
        end,
        ["Ord$dvj"] = {
          ["=="] = int_eq0,
          ["<>"] = function(cvx)
            return function(cvy)
              return cvx ~= cvy
            end
          end
        },
        ["<"] = lt_int0,
        ["<="] = lte_int0,
        [">"] = gt_int0,
        [">="] = gte_int0
      }
      local tmp20 = xss[1]
      return {
        {
          _1 = _dollardFoldablevrk(nil).foldr(function(tmp22)
            local k, v = tmp22._1, tmp22._2
            return function(xs)
              return anqa(_dollardOrdasfp(tmp21)).insert({
                _1 = k,
                _2 = v
              })(xs)
            end
          end)(E)(tmp20._1),
          _2 = cdm2(tmp20._2)
        },
        __tag = "Cons"
      }
    end
    local function zip_with_sat(xs, ys)
      if ys.__tag ~= "Cons" then
        return Nil
      end
      local tmp20 = ys[1]
      local y = tmp20._1
      local ys0 = tmp20._2
      if xs.__tag ~= "Cons" then
        return Nil
      end
      local tmp21 = xs[1]
      return {
        {
          _1 = { _1 = tmp21._1, _2 = y },
          _2 = zip_with_sat(tmp21._2, ys0)
        },
        __tag = "Cons"
      }
    end
    local zboards = zip_with_sat(boards, zip_with_sat0(markers, cdm2(cdm1(lboards))))
    local function cdm3(xss)
      if xss.__tag ~= "Cons" then
        return Nil
      end
      local tmp20 = xss[1]
      local tmp21 = mark(tmp20._1)
      local function cdm4(xss0)
        if xss0.__tag ~= "Cons" then
          return Nil
        end
        local tmp22 = xss0[1]
        return {
          {
            _1 = tmp21(tmp22._1),
            _2 = cdm4(tmp22._2)
          },
          __tag = "Cons"
        }
      end
      return {
        {
          _1 = find_some(cdm4(zboards)),
          _2 = cdm3(tmp20._2)
        },
        __tag = "Cons"
      }
    end
    return find_some(cdm3(tmp14._1))
  end)
  if res.__tag == "Some" then
    put_line("Some (" .. string_of_int(res[1]) .. ")")
  else
    put_line("None")
  end
end