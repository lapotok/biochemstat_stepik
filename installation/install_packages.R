# как работать с данным файлом
# 1. считать его командой source("https:// ... .R")
# 2. построить список установленных пакетов и пакетов, нужных для установки командой build_list()
# 3. установить пакеты, которых не хватает командой install_pkgs()
# 4. проверить, все ли ОК командой installation_report()
# (еще есть системные команды print_pkg_list() и print_conda_list())

# задаем адрес для репозитория
options(repos = c(CRAN = "http://cran.rstudio.com"))

# считываем список пакетов для установки
source("https://raw.githubusercontent.com/lapotok/biochemstat_stepik/main/installation/package_list.R")

build_list = function(from_scratch = F){
  dependencies_ <<- unlist(tools::package_dependencies(base.packages))
  base.packages.minimal <<- base.packages[!(base.packages %in% dependencies_)]
  
  # составляем списки того, что надо поставить
  if (from_scratch) 
    installed <<- ""
  else
    installed <<- as.character(installed.packages()[,"Package"])
  
  uninstalled_cran <<- setdiff(base.packages, installed)
  uninstalled_git <<- setdiff(names(github.packages), installed)
  uninstalled <<- c(uninstalled_cran, uninstalled_git)
}
print_pkg_list = function(){
  if (length(uninstalled_cran))  cat( paste0("install.packages( c(\"", paste0(uninstalled_cran, collapse='\", \"'), "\"), dependencies = TRUE, type = \"binary\" )\n\n"))
  if (length(github.packages[uninstalled_git])) cat( paste0("devtools::install_github( c(\"", paste0(github.packages[uninstalled_git], collapse='\", \"'), "\"), upgrade = \"never\", dependencies = TRUE )\n\n"))
}

print_conda_list = function(){
  cat(paste0("conda install r-", paste0(tolower(base.packages.minimal), collapse=' r-'), "\n"))
}

# ставим
install_pkgs = function(){
  for (pkg in uninstalled_cran) {
    install.packages(pkg, dependencies = TRUE, type ="binary")
  }
  for (pkg in github.packages[uninstalled_git]) {
    remotes::install_github(pkg, upgrade = "never", dependencies = TRUE)
  }
}

installation_report = function(){
  # составляем списки того, что осталось непоставленным
  installed_upd <<- as.character(installed.packages()[,"Package"])
  uninstalled_upd <<- setdiff(c(base.packages, names(github.packages)), installed_upd)
  # пишем отчет
  cat(crayon::bold$underline('\nPackage installation report\n'))
  if (length(uninstalled) == 0) {
    cat(paste0(' ', crayon::green(clisymbols::symbol$tick), " No packages need to be installed.\n")) 
  } else {
    cat(paste0('Following packages (', length(uninstalled), ') needed to be installed:\n'))
    for (p in uninstalled) cat(' ', paste0(crayon::yellow(clisymbols::symbol$star), ' ' , crayon::style(p, 'gray'), '\n'))
  }
  if(length(setdiff(uninstalled, uninstalled_upd))>0){
    cat(paste0('Following packages (', length(setdiff(uninstalled, uninstalled_upd)), ') were succesfully installed:\n'))
    for (p in setdiff(uninstalled, uninstalled_upd)) cat(paste(' ', crayon::green(clisymbols::symbol$tick), crayon::style(p, 'gray'), '\n'))
  }
  if(length(uninstalled_upd)>0) {
    cat(paste0(crayon::red('Following packages (', length(uninstalled_upd), ') are still missing:\n')))
    for (p in uninstalled_upd) cat(' ', paste(crayon::red(clisymbols::symbol$cross), crayon::style(p, 'gray'), '\n'))
  }
}
