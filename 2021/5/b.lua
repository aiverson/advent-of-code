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
  local function _less_greater(dnv)
    local dnw, dnx = dnv._1, dnv._2
    return function(drs)
      return function(drt)
        local b = drs._2
        _less_greater({ _1 = dnw, _2 = dnx })
        local dra = drt._2
        if dnw["=="](drs._1)(drt._1) then
          return not dnx["=="](b)(dra)
        end
        return true
      end
    end
  end
  local function _dollardOrdelh(tmp)
    local ehm = tmp._1
    local tmp0 = ehm["Ord$duo"]
    local ehm0 = tmp._2
    local tmp1 = ehm0["Ord$duo"]
    local enh1, eni1 = tmp._1, tmp._2
    local enh0, eni0 = tmp._1, tmp._2
    local enh, eni = tmp._1, tmp._2
    local enh3, eni3 = tmp._1, tmp._2
    local enh2, eni2 = tmp._1, tmp._2
    return {
      [">="] = function(ewj)
        return function(ewk)
          local tmp2 = _dollardOrdelh({
            _1 = enh3,
            _2 = eni3
          }).compare(ewj)({
            _2 = ewk._2,
            _1 = ewk._1
          })
          if tmp2.__tag == "Lt" then
            return false
          end
          return true
        end
      end,
      compare = function(tmp2)
        local a, b = tmp2._1, tmp2._2
        return function(tmp3)
          local tmp4 = enh.compare(a)(tmp3._1)
          local d = tmp3._2
          if tmp4.__tag == "Lt" then
            return Lt
          elseif tmp4.__tag == "Eq" then
            return eni.compare(b)(d)
          elseif tmp4.__tag == "Gt" then
            return Gt
          end
        end
      end,
      ["<"] = function(eso)
        return function(esp)
          local tmp2 = _dollardOrdelh({
            _1 = enh0,
            _2 = eni0
          }).compare(eso)({
            _2 = esp._2,
            _1 = esp._1
          })
          if tmp2.__tag == "Lt" then
            return true
          end
          return false
        end
      end,
      ["Ord$duo"] = {
        ["<>"] = _less_greater({
          _1 = tmp0,
          _2 = tmp1
        }),
        ["=="] = function(tmp2)
          local a, b = tmp2._1, tmp2._2
          return function(tmp3)
            local d = tmp3._2
            return tmp0["=="](a)(tmp3._1) and tmp1["=="](b)(d)
          end
        end
      },
      [">"] = function(evc)
        return function(evd)
          local tmp2 = _dollardOrdelh({
            _1 = enh2,
            _2 = eni2
          }).compare(evc)({
            _2 = evd._2,
            _1 = evd._1
          })
          if tmp2.__tag == "Gt" then
            return true
          end
          return false
        end
      end,
      ["<="] = function(etv)
        return function(etw)
          local tmp2 = _dollardOrdelh({
            _1 = enh1,
            _2 = eni1
          }).compare(etv)({
            _2 = etw._2,
            _1 = etw._1
          })
          if tmp2.__tag == "Gt" then
            return false
          end
          return true
        end
      end
    }
  end
  local _dollardMonadkgz, join, join0
  _dollardMonadkgz = function(tmp)
    return {
      join = join(tmp),
      [">>="] = function(xs)
        return function(f)
          if xs.__tag == "Some" then
            return f(xs[1])
          end
          return None
        end
      end,
      ["Monad$gvd"] = {
        ["Applicative$gmg"] = function(f)
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
      }
    }
  end
  join = function(khz)
    return function(kla)
      return join0(khz, kla)
    end
  end
  join0 = function(khz, kla)
    return _dollardMonadkgz(nil)[">>="](kla)(function(x)
      return x
    end)
  end
  local function _dollardExceptionmre(tmp)
    return {
      from_exception = function(x)
        return Some(x)
      end,
      ["Exception$mgn"] = _Typeable_app({
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
  local function from_exception(nkv, nno)
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 305,
        name = "user_error"
      })
    end)()
    local x = nno[2]
    return __eq_type_rep((function()
      return nno[1]["Exception$mgn"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception0(nkv)
    return function(nno)
      return from_exception(nkv, nno)
    end
  end
  local function _dollardExceptionnjy(tmp)
    return {
      describe_exception = function(tmp0)
        return "User error: " .. tmp0
      end,
      ["Exception$mgn"] = (function(tmp0)
        return _TypeRep({
          fingerprint = 305,
          name = "user_error"
        })
      end)(),
      into_exception = function(noe)
        return MkSome(_dollardExceptionnjy(nil))(noe)
      end,
      from_exception = from_exception0(tmp)
    }
  end
  local function range_from_to(ycr, yec)
    local tmp = ycr["Ord$duo"]
    return function(start)
      return function(finish)
        if ycr[">"](start)(finish) then
          return Nil
        end
        local function _dollargo(n)
          if tmp["=="](n)(finish) then
            return {
              { _1 = n, _2 = Nil },
              __tag = "Cons"
            }
          end
          return {
            {
              _1 = n,
              _2 = _dollargo(yec.successor(n))
            },
            __tag = "Cons"
          }
        end
        return _dollargo(start)
      end
    end
  end
  local function _dollarfoldr(vrp)
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
  local _dollardFoldablevqp, foldl1, foldl10
  _dollardFoldablevqp = function(tmp)
    return {
      foldl1 = foldl1(tmp),
      foldr = _dollarfoldr(tmp),
      ["Foldable$uyn"] = function(f)
        return function(xs)
          local function ccr(xss)
            if xss.__tag ~= "Cons" then
              return Nil
            end
            local tmp0 = xss[1]
            return {
              { _1 = f(tmp0._1), _2 = ccr(tmp0._2) },
              __tag = "Cons"
            }
          end
          return ccr(xs)
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
  foldl1 = function(vrp)
    return function(wdf)
      return function(wdg)
        return foldl10(vrp, wdf, wdg)
      end
    end
  end
  foldl10 = function(vrp, wdf, wdg)
    local tmp = _dollardFoldablevqp(nil).foldl(function(m)
      return function(y)
        if m.__tag == "Some" then
          return Some(wdf(m[1])(y))
        end
        return Some(y)
      end
    end)(None)(wdg)
    if tmp.__tag == "Some" then
      return tmp[1]
    end
    return error(setmetatable(_dollardExceptionnjy(nil).into_exception("foldl1: empty structure"), {
      __tostring = _dollardExceptionmre(nil).describe_exception
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
  local function from_exception1(oyn, pbg)
    local x = pbg[2]
    local tmp = (function(tmp)
      return _TypeRep({
        fingerprint = 753,
        name = "io_error"
      })
    end)()
    return __eq_type_rep((function()
      return pbg[1]["Exception$mgn"]
    end)(Proxy), (function()
      return tmp
    end)(Proxy), function(tmp0)
      return function(tmp1) return Some(x) end
    end, function(tmp0) return None end)
  end
  local function from_exception2(oyn)
    return function(pbg)
      return from_exception1(oyn, pbg)
    end
  end
  local function _dollardExceptionoxq(tmp)
    return {
      into_exception = function(pbw)
        return MkSome(_dollardExceptionoxq(nil))(pbw)
      end,
      from_exception = from_exception2(tmp),
      describe_exception = function(tmp0)
        return "Input/output error: " .. tmp0
      end,
      ["Exception$mgn"] = (function(tmp0)
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
      return error(setmetatable(_dollardExceptionoxq(nil).into_exception(x), {
        __tostring = _dollardExceptionmre(nil).describe_exception
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
  local function read_input(tmp)
    local tmp0 = io_open("input.txt", "r", function(x)
      return x
    end, function(x)
      return error(setmetatable(_dollardExceptionoxq(nil).into_exception(x), {
        __tostring = _dollardExceptionmre(nil).describe_exception
      }))
    end)
    local tmp1 = wrap_nil(None, function(x)
      return error(setmetatable(_dollardExceptionoxq(nil).into_exception(x), {
        __tostring = _dollardExceptionmre(nil).describe_exception
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
  local function balance_l(x, l, r0)
    if r0.__tag == "E" then
      if l.__tag == "E" then
        return T({
          _1 = x,
          _2 = { _1 = 1, _2 = { _1 = E, _2 = E } }
        })
      end
      local tmp = l[1]
      local tmp1 = tmp._2
      local tmp3 = tmp1._2
      local tmp4, tmp5 = tmp3._1, tmp3._2
      local tmp2 = tmp1._1
      local tmp0 = tmp._1
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
        local tmp7 = tmp6._2
        local lrx = tmp6._1
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
                _1 = T({ _1 = tmp0, _2 = tmp7 }),
                _2 = T({ _1 = x, _2 = tmp7 })
              }
            }
          })
        else
          local lrs = tmp7._1
          local tmp8 = tmp4[1]._2
          local lls = tmp8._1
          local tmp9 = tmp7._2
          local lrl, lrr = tmp9._1, tmp9._2
          if lrs < 2 * lls then
            return T({
              _1 = tmp0,
              _2 = {
                _1 = 1 + tmp2,
                _2 = {
                  _1 = tmp4,
                  _2 = T({
                    _1 = x,
                    _2 = {
                      _2 = { _1 = tmp5, _2 = E },
                      _1 = 1 + lrs
                    }
                  })
                }
              }
            })
          end
          local tmp11 = 1 + lls
          local tmp10 = 1 + tmp2
          local function tmp12(tmp12)
            local tmp13 = T({
              _1 = tmp0,
              _2 = {
                _1 = tmp11 + tmp12,
                _2 = { _1 = tmp4, _2 = lrl }
              }
            })
            local function tmp14(tmp14)
              return T({
                _1 = lrx,
                _2 = {
                  _1 = tmp10,
                  _2 = {
                    _1 = tmp13,
                    _2 = T({
                      _1 = x,
                      _2 = {
                        _2 = { _1 = lrr, _2 = E },
                        _1 = 1 + tmp14
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
            _1 = 1 + rs,
            _2 = { _1 = E, _2 = r0 }
          }
        })
      end
      local tmp0 = l[1]
      local lx = tmp0._1
      local tmp1 = tmp0._2
      local tmp2 = tmp1._2
      local ll, lr = tmp2._1, tmp2._2
      local ls = tmp1._1
      if not (ls > 3 * rs) then
        return T({
          _1 = x,
          _2 = {
            _1 = 1 + ls + rs,
            _2 = { _1 = l, _2 = r0 }
          }
        })
      end
      if lr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      if ll.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      local tmp3 = ll[1]._2
      local lls = tmp3._1
      if ll.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      if lr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      local tmp4 = lr[1]
      local lrx = tmp4._1
      if lr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      local tmp5 = lr[1]._2
      local lrs = tmp5._1
      if ll.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      if ll.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      if lr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[72:13 ..72:62]")
      end
      local tmp6 = lr[1]._2._2
      local lrl = tmp6._1
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
            _1 = 1 + ls + rs,
            _2 = {
              _1 = ll,
              _2 = T({
                _1 = x,
                _2 = {
                  _2 = { _1 = lr, _2 = r0 },
                  _1 = 1 + rs + lrs
                }
              })
            }
          }
        })
      end
      local tmp9 = 1 + ls + rs
      local tmp8 = 1 + lls
      local function tmp10(tmp10)
        local tmp12 = 1 + rs
        local tmp11 = T({
          _1 = lx,
          _2 = {
            _2 = { _1 = ll, _2 = lrl },
            _1 = tmp8 + tmp10
          }
        })
        local function tmp13(tmp13)
          return T({
            _1 = lrx,
            _2 = {
              _1 = tmp9,
              _2 = {
                _1 = tmp11,
                _2 = T({
                  _1 = x,
                  _2 = {
                    _1 = tmp12 + tmp13,
                    _2 = { _1 = lrr, _2 = r0 }
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
      local tmp1 = tmp._2
      local tmp3 = tmp1._2
      local tmp4, tmp5 = tmp3._1, tmp3._2
      local tmp2 = tmp1._1
      local tmp0 = tmp._1
      if tmp4.__tag == "E" then
        if tmp5.__tag == "E" then
          return T({
            _1 = x,
            _2 = {
              _1 = 2,
              _2 = { _1 = E, _2 = r0 }
            }
          })
        end
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
      else
        local tmp6 = tmp4[1]
        local tmp7 = tmp6._2
        local rlx = tmp6._1
        if tmp5.__tag == "E" then
          local tmp7 = {
            _1 = 1,
            _2 = { _1 = E, _2 = E }
          }
          return T({
            _1 = rlx,
            _2 = {
              _1 = 3,
              _2 = {
                _1 = T({ _1 = x, _2 = tmp7 }),
                _2 = T({ _1 = tmp0, _2 = tmp7 })
              }
            }
          })
        else
          local tmp9 = tmp7._2
          local rll, rlr = tmp9._1, tmp9._2
          local rls = tmp7._1
          local tmp8 = tmp5[1]._2
          local rrs = tmp8._1
          if rls < 2 * rrs then
            return T({
              _1 = tmp0,
              _2 = {
                _1 = 1 + tmp2,
                _2 = {
                  _1 = T({
                    _1 = x,
                    _2 = {
                      _2 = { _1 = E, _2 = tmp4 },
                      _1 = 1 + rls
                    }
                  }),
                  _2 = tmp5
                }
              }
            })
          end
          local tmp10 = 1 + tmp2
          local function tmp11(tmp11)
            local tmp13 = 1 + rrs
            local tmp12 = T({
              _1 = x,
              _2 = {
                _2 = { _1 = E, _2 = rll },
                _1 = 1 + tmp11
              }
            })
            local function tmp14(tmp14)
              return T({
                _1 = rlx,
                _2 = {
                  _1 = tmp10,
                  _2 = {
                    _1 = tmp12,
                    _2 = T({
                      _1 = tmp0,
                      _2 = {
                        _2 = { _1 = rlr, _2 = tmp5 },
                        _1 = tmp13 + tmp14
                      }
                    })
                  }
                }
              })
            end
            if rlr.__tag == "E" then
              return tmp14(0)
            end
            return tmp14(rlr[1]._2._1)
          end
          if rll.__tag == "E" then
            return tmp11(0)
          end
          return tmp11(rll[1]._2._1)
        end
      end
    else
      local tmp = l[1]._2
      local ls = tmp._1
      if r0.__tag == "E" then
        return T({
          _1 = x,
          _2 = {
            _1 = 1 + ls,
            _2 = { _1 = l, _2 = E }
          }
        })
      end
      local tmp0 = r0[1]
      local tmp1 = tmp0._2
      local tmp2 = tmp1._2
      local rl, rr = tmp2._1, tmp2._2
      local rs = tmp1._1
      local rx = tmp0._1
      if not (rs > 3 * ls) then
        return T({
          _1 = x,
          _2 = {
            _1 = 1 + rs + ls,
            _2 = { _1 = l, _2 = r0 }
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
      if rl.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[97:13 ..97:62]")
      end
      local tmp4 = rl[1]._2
      local rls = tmp4._1
      if rr.__tag ~= "T" then
        return error("Pattern matching failure in let expression at /nix/store/hr8gqvjdmnrizsm9l1qn66af1nnnisf8-amuletml-1.0.0.0/lib/data/internal/bbtree.ml[97:13 ..97:62]")
      end
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
            _2 = {
              _1 = T({
                _1 = x,
                _2 = {
                  _2 = { _1 = l, _2 = rl },
                  _1 = tmp8 + rls
                }
              }),
              _2 = rr
            },
            _1 = tmp8 + rs
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
  local function balance(x, l, r0)
    if l.__tag == "E" then
      if r0.__tag == "E" then
        return T({
          _1 = x,
          _2 = { _1 = 1, _2 = { _1 = E, _2 = E } }
        })
      end
      local tmp = r0[1]
      local tmp1 = tmp._2
      local tmp3 = tmp1._2
      local tmp4, tmp5 = tmp3._1, tmp3._2
      local tmp2 = tmp1._1
      local tmp0 = tmp._1
      if tmp4.__tag == "E" then
        if tmp5.__tag == "E" then
          return T({
            _1 = x,
            _2 = {
              _1 = 2,
              _2 = { _1 = E, _2 = r0 }
            }
          })
        end
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
      else
        local tmp6 = tmp4[1]
        local tmp7 = tmp6._2
        local rlx = tmp6._1
        if tmp5.__tag == "E" then
          local tmp7 = {
            _1 = 1,
            _2 = { _1 = E, _2 = E }
          }
          return T({
            _1 = rlx,
            _2 = {
              _1 = 3,
              _2 = {
                _1 = T({ _1 = x, _2 = tmp7 }),
                _2 = T({ _1 = tmp0, _2 = tmp7 })
              }
            }
          })
        else
          local rls = tmp7._1
          local tmp8 = tmp5[1]._2
          local rrs = tmp8._1
          local tmp9 = tmp7._2
          local rll, rlr = tmp9._1, tmp9._2
          if rls < 2 * rls then
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
          local tmp10 = 1 + tmp2
          local function tmp11(tmp11)
            local tmp13 = T({
              _1 = x,
              _2 = {
                _2 = { _1 = E, _2 = rll },
                _1 = 1 + tmp11
              }
            })
            local tmp12 = 1 + rrs
            local function tmp14(tmp14)
              return T({
                _1 = rlx,
                _2 = {
                  _1 = tmp10,
                  _2 = {
                    _1 = tmp13,
                    _2 = T({
                      _1 = tmp0,
                      _2 = {
                        _2 = { _1 = rlr, _2 = tmp5 },
                        _1 = tmp12 + tmp14
                      }
                    })
                  }
                }
              })
            end
            if rlr.__tag == "E" then
              return tmp14(0)
            end
            return tmp14(rlr[1]._2._1)
          end
          if rll.__tag == "E" then
            return tmp11(0)
          end
          return tmp11(rll[1]._2._1)
        end
      end
    else
      local tmp = l[1]
      local tmp0 = tmp._2
      local tmp1 = tmp0._2
      local ll, lr = tmp1._1, tmp1._2
      local ls = tmp0._1
      local lx = tmp._1
      if r0.__tag == "E" then
        if lr.__tag == "E" then
          if ll.__tag == "E" then
            return T({
              _1 = x,
              _2 = { _1 = 2, _2 = { _1 = l, _2 = E } }
            })
          end
          return T({
            _1 = lx,
            _2 = {
              _1 = 3,
              _2 = {
                _1 = ll,
                _2 = T({
                  _1 = x,
                  _2 = { _1 = 1, _2 = { _1 = E, _2 = E } }
                })
              }
            }
          })
        else
          local tmp2 = lr[1]
          local lrx = tmp2._1
          local tmp3 = tmp2._2
          if ll.__tag == "E" then
            local tmp3 = {
              _1 = 1,
              _2 = { _1 = E, _2 = E }
            }
            return T({
              _1 = lrx,
              _2 = {
                _1 = 3,
                _2 = {
                  _1 = T({ _1 = lx, _2 = tmp3 }),
                  _2 = T({ _1 = x, _2 = tmp3 })
                }
              }
            })
          else
            local lrs = tmp3._1
            local tmp5 = tmp3._2
            local lrl, lrr = tmp5._1, tmp5._2
            local tmp4 = ll[1]._2
            local lls = tmp4._1
            if lrs < 2 * lls then
              return T({
                _1 = lx,
                _2 = {
                  _1 = 1 + ls,
                  _2 = {
                    _1 = ll,
                    _2 = T({
                      _1 = x,
                      _2 = {
                        _1 = 1 + lrs,
                        _2 = { _1 = lr, _2 = E }
                      }
                    })
                  }
                }
              })
            end
            local tmp7 = 1 + ls
            local tmp6 = 1 + lls
            local function tmp8(tmp8)
              local tmp9 = T({
                _1 = lx,
                _2 = {
                  _2 = { _1 = ll, _2 = lrl },
                  _1 = tmp6 + tmp8
                }
              })
              local function tmp10(tmp10)
                return T({
                  _1 = lrx,
                  _2 = {
                    _1 = tmp7,
                    _2 = {
                      _1 = tmp9,
                      _2 = T({
                        _1 = x,
                        _2 = {
                          _1 = 1 + tmp10,
                          _2 = { _1 = lrr, _2 = E }
                        }
                      })
                    }
                  }
                })
              end
              if lrr.__tag == "E" then
                return tmp10(0)
              end
              return tmp10(lrr[1]._2._1)
            end
            if lrl.__tag == "E" then
              return tmp8(0)
            end
            return tmp8(lrl[1]._2._1)
          end
        end
      else
        local tmp2 = r0[1]
        local tmp3 = tmp2._2
        local tmp4 = tmp3._2
        local rl, rr = tmp4._1, tmp4._2
        local rs = tmp3._1
        local rx = tmp2._1
        if rs > 3 * ls then
          if rr.__tag ~= "T" then
            return error(setmetatable(_dollardExceptionnjy(nil).into_exception("Impossible: balance T vs T, rs > delta * ls"), {
              __tostring = _dollardExceptionmre(nil).describe_exception
            }))
          end
          local tmp5 = rr[1]._2
          local rrs = tmp5._1
          if rl.__tag ~= "T" then
            return error(setmetatable(_dollardExceptionnjy(nil).into_exception("Impossible: balance T vs T, rs > delta * ls"), {
              __tostring = _dollardExceptionmre(nil).describe_exception
            }))
          end
          local tmp6 = rl[1]
          local rlx = tmp6._1
          local tmp7 = tmp6._2
          local tmp8 = tmp7._2
          local rll, rlr = tmp8._1, tmp8._2
          local rls = tmp7._1
          if rls < 2 * rrs then
            local tmp9 = 1 + ls
            return T({
              _1 = rx,
              _2 = {
                _1 = tmp9 + rs,
                _2 = {
                  _1 = T({
                    _1 = x,
                    _2 = {
                      _2 = { _1 = l, _2 = rl },
                      _1 = tmp9 + rls
                    }
                  }),
                  _2 = rr
                }
              }
            })
          else
            local tmp9 = 1 + ls
            local tmp10 = tmp9 + rs
            local function tmp11(tmp11)
              local tmp13 = 1 + rrs
              local tmp12 = T({
                _1 = x,
                _2 = {
                  _2 = { _1 = l, _2 = rll },
                  _1 = tmp9 + tmp11
                }
              })
              local function tmp14(tmp14)
                return T({
                  _1 = rlx,
                  _2 = {
                    _1 = tmp10,
                    _2 = {
                      _1 = tmp12,
                      _2 = T({
                        _1 = rx,
                        _2 = {
                          _1 = tmp13 + tmp14,
                          _2 = { _1 = rlr, _2 = rr }
                        }
                      })
                    }
                  }
                })
              end
              if rlr.__tag == "E" then
                return tmp14(0)
              end
              return tmp14(rlr[1]._2._1)
            end
            if rll.__tag == "E" then
              return tmp11(0)
            end
            return tmp11(rll[1]._2._1)
          end
        else
          if not (ls > 3 * rs) then
            return T({
              _1 = x,
              _2 = {
                _2 = { _1 = l, _2 = r0 },
                _1 = 1 + rs + ls
              }
            })
          end
          if lr.__tag ~= "T" then
            return error(setmetatable(_dollardExceptionnjy(nil).into_exception("Impossible: balance T vs T, ls > delta * rs"), {
              __tostring = _dollardExceptionmre(nil).describe_exception
            }))
          end
          local tmp5 = lr[1]
          local tmp6 = tmp5._2
          local lrs = tmp6._1
          local lrx = tmp5._1
          local tmp7 = tmp6._2
          local lrl, lrr = tmp7._1, tmp7._2
          if ll.__tag ~= "T" then
            return error(setmetatable(_dollardExceptionnjy(nil).into_exception("Impossible: balance T vs T, ls > delta * rs"), {
              __tostring = _dollardExceptionmre(nil).describe_exception
            }))
          end
          local tmp8 = ll[1]._2
          local lls = tmp8._1
          if lrs < 2 * lls then
            return T({
              _1 = lx,
              _2 = {
                _1 = 1 + ls + rs,
                _2 = {
                  _1 = ll,
                  _2 = T({
                    _1 = x,
                    _2 = {
                      _2 = { _1 = lr, _2 = r0 },
                      _1 = 1 + rs + lrs
                    }
                  })
                }
              }
            })
          end
          local tmp10 = 1 + ls + rs
          local tmp9 = 1 + lls
          local function tmp11(tmp11)
            local tmp13 = 1 + rs
            local tmp12 = T({
              _1 = lx,
              _2 = {
                _2 = { _1 = ll, _2 = lrl },
                _1 = tmp9 + tmp11
              }
            })
            local function tmp14(tmp14)
              return T({
                _1 = lrx,
                _2 = {
                  _1 = tmp10,
                  _2 = {
                    _1 = tmp12,
                    _2 = T({
                      _1 = x,
                      _2 = {
                        _1 = tmp13 + tmp14,
                        _2 = { _1 = lrr, _2 = r0 }
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
            return tmp11(0)
          end
          return tmp11(lrl[1]._2._1)
        end
      end
    end
  end
  local function max_view(x, x0)
    local l = x0._1
    local tmp = x0._2
    if tmp.__tag == "E" then
      return { _1 = x, _2 = l }
    end
    local tmp0 = tmp[1]
    local tmp1 = tmp0._2._2
    local tmp2 = max_view(tmp0._1, {
      _1 = tmp1._1,
      _2 = tmp1._2
    })
    return {
      _1 = tmp2._1,
      _2 = balance(x, l, tmp2._2)
    }
  end
  local function glue(x)
    local l, tmp = x._1, x._2
    if tmp.__tag == "E" then return l end
    local tmp0 = tmp[1]
    if l.__tag == "E" then return tmp end
    local tmp4 = tmp0._2
    local tmp5 = tmp4._2
    local rl = tmp5._1
    local rr = tmp5._2
    local tmp1 = l[1]
    local lx = tmp1._1
    local tmp2 = tmp1._2
    local rx = tmp0._1
    local tmp3 = tmp2._2
    local ll = tmp3._1
    local lr = tmp3._2
    if tmp2._1 > tmp4._1 then
      local tmp6 = max_view(lx, {
        _1 = ll,
        _2 = lr
      })
      return balance_r(tmp6._1, tmp6._2, tmp)
    else
      if rl.__tag == "E" then
        return balance_l(rx, l, rr)
      end
      local tmp6 = rl[1]
      local tmp7 = tmp6._2._2
      local tmp8 = max_view(tmp6._1, {
        _1 = tmp7._1,
        _2 = tmp7._2
      })
      return balance_l(tmp8._1, l, balance(rx, tmp8._2, rr))
    end
  end
  local function alter(auat, f, k, tmp)
    local function _dollargo(x)
      if x.__tag == "E" then
        local tmp0 = f(None)
        if tmp0.__tag == "Some" then
          return T({
            _1 = { _1 = k, _2 = tmp0[1] },
            _2 = { _1 = 1, _2 = { _1 = E, _2 = E } }
          })
        end
        return E
      else
        local tmp0 = x[1]
        local tmp3 = tmp0._1
        local kx, x0 = tmp3._1, tmp3._2
        local e = { _1 = kx, _2 = x0 }
        local tmp4 = auat.compare(k)(kx)
        local tmp1 = tmp0._2
        local tmp2 = tmp1._2
        local l, r0 = tmp2._1, tmp2._2
        local sx = tmp1._1
        if tmp4.__tag == "Lt" then
          return balance(e, _dollargo(l), r0)
        elseif tmp4.__tag == "Eq" then
          local tmp5 = f(Some(x0))
          if tmp5.__tag == "Some" then
            return T({
              _2 = {
                _1 = sx,
                _2 = { _1 = l, _2 = r0 }
              },
              _1 = { _1 = kx, _2 = tmp5[1] }
            })
          end
          return glue({ _1 = l, _2 = r0 })
        elseif tmp4.__tag == "Gt" then
          return balance(e, l, _dollargo(r0))
        end
      end
    end
    return _dollargo(tmp)
  end
  local coords = lpeg.collect_tuple(Parser_tuple({}))(int_parser * p(",") * int_parser)
  local line = lpeg.collect_tuple(Parser_tuple({}))(coords * p(" -> ") * coords)
  local tmp = (line * (wsp * line) ^ 0) ^ -1
  local parser = lpeg.collect_list(Nil)(Cons)(Parser_coll_list({}))(tmp)
  local function expand_line(cttn, cttx, ctyp, ctyz)
    local tmp1 = ctyp["Ord$duo"]
    local tmp0 = cttn["Ord$duo"]
    return function(tmp2)
      local x1, y1 = tmp2._1, tmp2._2
      return function(tmp3)
        local x2, y2 = tmp3._1, tmp3._2
        if tmp1["=="](x1)(x2) then
          if cttn["<"](y1)(y2) then
            local function csxh(xss)
              if xss.__tag ~= "Cons" then
                return Nil
              end
              local tmp4 = xss[1]
              return {
                {
                  _1 = { _1 = x1, _2 = tmp4._1 },
                  _2 = csxh(tmp4._2)
                },
                __tag = "Cons"
              }
            end
            return csxh(range_from_to(cttn, cttx)(y1)(y2))
          else
            local function csxh(xss)
              if xss.__tag ~= "Cons" then
                return Nil
              end
              local tmp4 = xss[1]
              return {
                {
                  _2 = csxh(tmp4._2),
                  _1 = { _1 = x1, _2 = tmp4._1 }
                },
                __tag = "Cons"
              }
            end
            return csxh(range_from_to(cttn, cttx)(y2)(y1))
          end
        else
          if tmp0["=="](y1)(y2) then
            if ctyp["<"](x1)(x2) then
              local function csxl(xss)
                if xss.__tag ~= "Cons" then
                  return Nil
                end
                local tmp4 = xss[1]
                return {
                  {
                    _2 = csxl(tmp4._2),
                    _1 = { _1 = tmp4._1, _2 = y1 }
                  },
                  __tag = "Cons"
                }
              end
              return csxl(range_from_to(ctyp, ctyz)(x1)(x2))
            else
              local function csxl(xss)
                if xss.__tag ~= "Cons" then
                  return Nil
                end
                local tmp4 = xss[1]
                return {
                  {
                    _2 = csxl(tmp4._2),
                    _1 = { _1 = tmp4._1, _2 = y1 }
                  },
                  __tag = "Cons"
                }
              end
              return csxl(range_from_to(ctyp, ctyz)(x2)(x1))
            end
          else
            local function tmp4(ys)
              if ctyp["<"](x1)(x2) then
                local function zip_with_sat(xs, ys0)
                  if xs.__tag ~= "Cons" then
                    return Nil
                  end
                  local tmp4 = xs[1]
                  local xs0 = tmp4._2
                  local x = tmp4._1
                  if ys0.__tag ~= "Cons" then
                    return Nil
                  end
                  local tmp5 = ys0[1]
                  return {
                    {
                      _2 = zip_with_sat(xs0, tmp5._2),
                      _1 = { _1 = x, _2 = tmp5._1 }
                    },
                    __tag = "Cons"
                  }
                end
                return zip_with_sat(range_from_to(ctyp, ctyz)(x1)(x2), ys)
              else
                local function zip_with_sat(xs, ys0)
                  if xs.__tag ~= "Cons" then
                    return Nil
                  end
                  local tmp4 = xs[1]
                  local x = tmp4._1
                  local xs0 = tmp4._2
                  if ys0.__tag ~= "Cons" then
                    return Nil
                  end
                  local tmp5 = ys0[1]
                  return {
                    {
                      _1 = { _1 = x, _2 = tmp5._1 },
                      _2 = zip_with_sat(xs0, tmp5._2)
                    },
                    __tag = "Cons"
                  }
                end
                local function loop(acc, x)
                  if x.__tag ~= "Cons" then return acc end
                  local tmp4 = x[1]
                  return loop({
                    { _1 = tmp4._1, _2 = acc },
                    __tag = "Cons"
                  }, tmp4._2)
                end
                return zip_with_sat(loop(Nil, range_from_to(ctyp, ctyz)(x2)(x1)), ys)
              end
            end
            if cttn["<"](y1)(y2) then
              return tmp4(range_from_to(cttn, cttx)(y1)(y2))
            end
            local function loop(acc, x)
              if x.__tag ~= "Cons" then return acc end
              local tmp5 = x[1]
              return loop({
                { _1 = tmp5._1, _2 = acc },
                __tag = "Cons"
              }, tmp5._2)
            end
            return tmp4(loop(Nil, range_from_to(cttn, cttx)(y2)(y1)))
          end
        end
      end
    end
  end
  local function build_map(locs, m)
    local function tmp1(x)
      if x.__tag == "Some" then
        return Some(x[1] + 1)
      end
      return Some(1)
    end
    local tmp0 = _dollardOrdelh({
      _1 = {
        compare = function(ffz)
          return function(fga)
            if ffz == fga then return Eq end
            if ffz <= fga then return Lt end
            return Gt
          end
        end,
        ["Ord$duo"] = {
          ["=="] = int_eq0,
          ["<>"] = function(cvc)
            return function(cvd)
              return cvc ~= cvd
            end
          end
        },
        ["<"] = lt_int0,
        ["<="] = lte_int0,
        [">"] = gt_int0,
        [">="] = gte_int0
      },
      _2 = {
        compare = function(ffz)
          return function(fga)
            if ffz == fga then return Eq end
            if ffz <= fga then return Lt end
            return Gt
          end
        end,
        ["Ord$duo"] = {
          ["=="] = int_eq0,
          ["<>"] = function(cvc)
            return function(cvd)
              return cvc ~= cvd
            end
          end
        },
        ["<"] = lt_int0,
        ["<="] = lte_int0,
        [">"] = gt_int0,
        [">="] = gte_int0
      }
    })
    return _dollardFoldablevqp(nil).foldr(function(k)
      return function(tmp2)
        return alter(tmp0, tmp1, k, tmp2)
      end
    end)(m)(locs)
  end
  local function build_map0(locs)
    return function(m)
      return build_map(locs, m)
    end
  end
  local function tmp1(tmp0)
    local tmp1 = _dollardFoldablevqp(nil).foldr(build_map0)(E)
    if tmp0.__tag ~= "Some" then
      return None
    end
    local function go(z, x)
      if x.__tag == "E" then return z end
      local tmp2 = x[1]
      local tmp3 = tmp2._2._2
      local l = tmp3._1
      local tmp4 = go(z, tmp3._2)
      if tmp2._1._2 > 1 then
        return go(tmp4 + 1, l)
      end
      return go(tmp4, l)
    end
    return Some(go(0, tmp1(tmp0[1])))
  end
  local tmp0 = _dollardMonadkgz(nil)[">>="](read_input(nil))(function(s0)
    return lpeg.parse(parser)(s0)
  end)
  local res
  if tmp0.__tag == "Some" then
    local function ccr(xss)
      if xss.__tag ~= "Cons" then
        return Nil
      end
      local tmp2 = xss[1]
      local x = tmp2._1
      return {
        {
          _1 = expand_line({
            compare = function(ffz)
              return function(fga)
                if ffz == fga then return Eq end
                if ffz <= fga then return Lt end
                return Gt
              end
            end,
            ["Ord$duo"] = {
              ["=="] = int_eq0,
              ["<>"] = function(cvc)
                return function(cvd)
                  return cvc ~= cvd
                end
              end
            },
            ["<"] = lt_int0,
            ["<="] = lte_int0,
            [">"] = gt_int0,
            [">="] = gte_int0
          }, {
            predecessor = function(x0)
              return x0 + 1
            end,
            successor = function(x0)
              return x0 + 1
            end,
            enum_of_int = function(x0)
              return x0
            end,
            int_of_enum = function(x0) return x0 end
          }, {
            ["Ord$duo"] = {
              ["=="] = int_eq0,
              ["<>"] = function(cvc)
                return function(cvd)
                  return cvc ~= cvd
                end
              end
            },
            compare = function(ffz)
              return function(fga)
                if ffz == fga then return Eq end
                if ffz <= fga then return Lt end
                return Gt
              end
            end,
            ["<"] = lt_int0,
            ["<="] = lte_int0,
            [">"] = gt_int0,
            [">="] = gte_int0
          }, {
            predecessor = function(x0)
              return x0 + 1
            end,
            successor = function(x0)
              return x0 + 1
            end,
            enum_of_int = function(x0)
              return x0
            end,
            int_of_enum = function(x0) return x0 end
          })(x._1)(x._2),
          _2 = ccr(tmp2._2)
        },
        __tag = "Cons"
      }
    end
    res = tmp1(Some(ccr(tmp0[1])))
  else
    res = tmp1(None)
  end
  if res.__tag == "Some" then
    put_line("Some (" .. string_of_int(res[1]) .. ")")
  else
    put_line("None")
  end
end