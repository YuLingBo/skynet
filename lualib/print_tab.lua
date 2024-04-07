local myModule = {}

function myModule.tablefind(tbl, val)
    if tbl == nil or val == nil or type(tbl) ~= "table" then
        return nil
    end

    for i, v in pairs(tbl) do
        if v == val then
            return i
        end
    end

    return nil
end

-- getRealValue 如果val为string类型则给他加上双引号，便于更好识别当key为数字时两种不同类型number和string的区别
function myModule.getRealValue(val)
    if type(val) == "string" and not string.find(val, "\"") then
        val = "\""..val.."\""
    end
    return val
end


---my_print_table_recursive
---@param t table
---@param str string    需要打印出来的提示信息
---@param fileds table={_in={},_out={}}  _in需要打印的字段, _out不需要打印的字段
function myModule.my_print_table_recursive ( t, str, fileds)
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do

                   

                    if (type(val)=="table") then
                        print(indent.."["..myModule.getRealValue(pos).."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        if fileds and fileds._out and myModule.tablefind(fileds._out, pos) then
                            goto continue
                        end
                        if fileds and fileds._in and not myModule.tablefind(fileds._in, pos) then
                            goto continue
                        end
                        print(indent.."["..myModule.getRealValue(pos)..'] => "'..val..'"')
                    else
                        print(indent.."["..myModule.getRealValue(pos).."] => "..tostring(val))
                    end

                    ::continue::
                end
            else
                print(indent..tostring(t))
            end
        end
    end

    print("\n***** print begin *********   ", str)
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print("***** print end   *********   ", str, "\n")
end

---my_print_table_normal
---@param ta table
---@param str string    需要打印出来的提示信息
---@param fileds table={_in={},_out={}}  _in需要打印的字段, _out不需要打印的字段
function myModule.my_print_table_normal(ta, str, fileds)
    print("\n***** print begin *********   ", str)
    if type(ta) == "table" then
        for k,v in pairs(ta) do
            if fileds and fileds._out and myModule.tablefind(fileds._out, k) then
                goto continue
            end
            if fileds and fileds._in and not myModule.tablefind(fileds._in, k) then
                goto continue
            end

            print("key= "..myModule.getRealValue(k),"value= ",myModule.getRealValue(v))

            ::continue::
        end
    end
    print("***** print end   *********   ", str, "\n")
end

return myModule

