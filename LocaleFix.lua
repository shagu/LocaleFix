-- make sure that ptBR client returns "ptBR" instead of "xxYY"
if GetLocale() == "xxYY" then
  GetLocale = function() return "ptBR" end
end
