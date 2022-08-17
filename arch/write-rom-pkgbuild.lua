local version, mainsum = ...
local out = assert(io.open("PKGBUILD.new", "w"))
for line in io.lines("PKGBUILD", "*L") do
    if line:match "^%s*pkgver%s*=" then out:write("pkgver=" .. version .. "\n")
    elseif line:match "^%s*pkgrel%s*=" then out:write("pkgrel=1\n")
    elseif line:match "^%s*sha256sums%s*=" then out:write("sha256sums=('" .. mainsum .. "')\n")
    else out:write(line) end
end
out:close()
out = assert(io.open(".SRCINFO.new", "w"))
for line in io.lines(".SRCINFO", "*L") do
    if line:match "^%s*pkgver%s*=" then out:write("\tpkgver = " .. version .. "\n")
    elseif line:match "^%s*pkgrel%s*=" then out:write("\tpkgrel = 1\n")
    elseif line:match "^%s*sha256sums%s*=" then out:write("\tsha256sums = " .. mainsum .. "\n")
    elseif line:match "^%s*source%s*=" then out:write("\tsource = https://github.com/MCJack123/craftos2-rom/archive/v" .. version .. ".tar.gz\n")
    else out:write(line) end
end
out:close()
os.remove("PKGBUILD")
os.remove(".SRCINFO")
os.rename("PKGBUILD.new", "PKGBUILD")
os.rename(".SRCINFO.new", ".SRCINFO")