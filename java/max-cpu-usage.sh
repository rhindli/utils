#!/bin/bash
##
## Descriere  : Utilizatorul poate capta, afisa si salva 
##              datele thread-urilor Java care ocupa cel mai mult CPU 
##              pentru un anumit domeniu  
## Autor      : nic.silvestru@bitsoftware.ro
## Data       : 28 Aug 2019
## Vers.      : 1.2
## Format     : ./max-cpu-usage.sh <domeniu>
##              <domeniu> = continut tabel 'domains_table'
## Ruleaza din: /app/scloud
## Obs.       : Cere password sudo
##              Salveaza datele stack trace-ului in $rezult_file din $log_dir
##              iar fisierul de log anterior este redenumit cu propriul time stamp
##              Necesita aplicatiile: top, jstack
##----------------------------------------------------------------
## 

user='user'
group='group'
log_dir='/log/max_cpu_usage'

declare -a domains_table
domains_table=( \
'domain1'  \
'domain2'  \
)
len_dom=${#domains_table[@]}
##------------------------------
jstack_file='jstack.tmp'
top_file='top.tmp'

jstack_path="$log_dir/$jstack_file"
top_path="$log_dir/$top_file"

check_lines=8
((erased_lines=$check_lines + 2))

declare -a cpu_table
declare -a nid_table
declare -a stat_table
declare -a run_time_table

noc='\e[0m'
red='\e[1;31m'
yellow='\e[1;33m'
pink='\e[1;35m'
cyan='\e[1;36m'
tile_cyan='\e[1;46m \e[0m'
up_line='\e[1A\e[K\e[1A'
##----------------------------------------------------------------
## Functie
## citeste primele $check_lines din $top_file, 
## filtreaza datele si le pune in nid_table, cpu_table, stat_table si run_time_table
function get_top_data {
  top -n 1 -H -p $pid_domeniu > $top_path
  ## sterge primele 8 linii din $top_file
  sed -i '1,7d'  $top_path
  i=0
  while IFS= read -r line; do
    nid=$(echo "$line" | awk '{print $2}')
    ## tine seama de linia thread-ului "http-thread-pool.."
    if [ "$nid" == "root" ]; then
      nid=$(echo "$line" | awk '{print $1}' |  sed 's/.*m//')
      stat=$(echo "$line" | awk '{print $8}')
      cpu=$(echo "$line" | awk '{print $9}')
      run_time=$(echo "$line" | awk '{print $11}')
    else
      stat=$(echo "$line" | awk '{print $9}')
      cpu=$(echo "$line" | awk '{print $10}')
      run_time=$(echo "$line" | awk '{print $12}')
    fi
    cpu_table[i]=$cpu
    nid_table[i]=$nid
    stat_table[i]=$stat
    run_time_table[i]=$run_time
    ((i++))
    if (( i >= $check_lines )); then
      break
    fi
    done < $top_path
}

## Functie
## afiseaza formatul comenzii
function cmd_usage {
  echo
  echo -e "  Format comanda:"
  echo -e "  max-cpu-usage.sh <domeniu>"
  echo -en "    <domeniu> ="
  for (( i=0; i<$len_dom; i++ )); do
    echo -n " ${domains_table[i]}"
  done
  echo
  echo
}
##----------------------------------------------------------------
## Main
##----------------------------------------------------------------
## testeaza posibile erori de comanda
if [ $# -lt 1 ]; then
  echo
  echo -e " $red EROARE $noc: lipsa parametru <domeniu> !"
  cmd_usage
  exit 1
fi
domain="$1"
verif=0
for (( i=0; i<$len_dom; i++ )); do
  if [ "$domain" == "${domains_table[i]}" ]; then
    verif=1
  fi
done

if [ "$verif" -eq "0" ]; then
  echo
  echo -e " $red EROARE $noc: Nume domeniu $red$domain$noc invalid !"
  cmd_usage
  exit 1
fi
## seteaza nume fisier de rezultate
rezult_file="max_cpu_usage_$domain.log"
rezult_path="$log_dir/$rezult_file"
rezult_name=$( echo $rezult_file | cut -d. -f1)

sudo -E echo
## daca nu exista, creaza $log_dir
if [ ! -d "$log_dir" ]; then
  sudo mkdir -p "$log_dir"
  sudo chown "$user":"$group" "$log_dir"
fi

## parseaza PID-ul procesului JAVA asociat domeniului
## daca domeniul e oprit, afiseaza ce domeni(u/i) sunt pornite 
pid_domeniu=$(ps ax | grep $domain | grep -v "grep" | grep -v "bash" | sed 's/ *\([^ ]*\).*/\1/')
if [ -z "$pid_domeniu" ]; then
  echo
  echo -e "$red  ABANDON:$noc Domeniul $red$domain$noc NU e pornit !"
  echo
  ver=0
  for (( i=0; i<$len_dom; i++ )); do
    pid=$(ps ax | grep ${domains_table[i]} | grep -v "grep" | grep -v "bash" | sed 's/ *\([^ ]*\).*/\1/')
    if [ ! -z "$pid" ]; then
      if [ "$ver" -eq "0" ]; then
         echo -e "  Domeni(ul/ele) pornite sunt:"
         ver=1
      fi
      echo -e "   $pink ${domains_table[i]}$noc"
    fi
  done
  echo
  exit 1
fi

## filtreaza si afiseaza primele $check_lines thread-uri
echo -e "$tile_cyan$cyan Capteaza datele thread-urilor procesului Java PID:$noc $pid_domeniu$cyan al domeniului $noc$domain"
echo -e "$cyan primele $noc$check_lines$cyan cele mai mari consumatoare de CPU$noc"
echo
printf " Stare\t ThID\t CPU%%\n"
echo " --------------------"

while true; do
    get_top_data
    for (( k=0; k<$check_lines; k++ )); do
        printf "   %s\t %s\t %s\n" ${stat_table[k]} ${nid_table[k]} ${cpu_table[k]}
    done
    echo
    echo -e "$yellow--- Va rog ASTEPTATI !$noc"
    sudo jstack $pid_domeniu > $jstack_path
    echo -e $up_line
    read -r -p "$(echo -e "$yellow---  Doriti o noua captura [Enter] sau Afisati datele captate [n,N] ? : $noc") " response
    if [ "$response" = "n" ] || [ "$response" = "N" ]; then
        echo -e $up_line
        break
    fi
	## sterge datele afisate
    for (( j=0; j<$erased_lines; j++ )); do
         echo -e $up_line
    done
done

## salveaza/redenumeste vechiul $rezult_file cu time stamp
if [ -f "$rezult_path" ]; then
    time_stamp=$( stat -c %y $rezult_path | cut -d. -f1 | sed 's/[-]*//g' | sed 's/ /-/g' | sed 's/://g' )
    new_rez_path="$log_dir/$rezult_name-$time_stamp.log"
    mv $rezult_path $new_rez_path
fi

## salveaza datele stack trace-urile filtrate in $rezult_file
## numai daca CPU% din cpu_table sunt diferite de zero
echo "" > $rezult_path
first=0
for (( i=0; i<$check_lines; i++ )); do
  if [ "${cpu_table[i]}" != "0.0" ]; then
    if [ "$first" -eq "0" ]; then
      echo "DOMENIU: $domain Java PID: $pid_domeniu" >> $rezult_path
      first=1
    fi
    ## calculeaza nid in hexa
    nid_hex=$( printf "0x%x" ${nid_table[i]} )
    ## parseaza starea thread-ului
    case "${stat_table[i]}" in
      R)
        stat_name="Running"
        ;;
      S)
        stat_name="Sleep"
        ;;
      Z)
        stat_name="Zombie"
        ;;
      *)
      stat_name='???'
        ;;
    esac
        ## filtreaza si salveaza datele stack trace-ului in $rezult_file
        echo >> $rezult_path
        printf "CPU Usage: %s %%\tThread ID: %s\t nid: %s\tStare: %s\t Run Time: %s\n" ${cpu_table[i]} ${nid_table[i]} $nid_hex $stat_name ${run_time_table[i]} >> $rezult_path
        echo "-------------------------------------------------------------------------------------------------" >> $rezult_path
        awk '/'$nid_hex'/,/^$/' $jstack_path >> $rezult_path
        echo "-------------------------------------------------------------------------------------------------" >> $rezult_path
  fi
done
echo
if [ "$first" -eq "0" ]; then
  echo -e "$tile_cyan$cyan Nu exista thread-uri consumatoare de CPU ! $noc"
  rm $rezult_path
else
  ## afiseaza in termial datele stack trace-ului salvate in $rezult_file
  echo -e "$tile_cyan$cyan Se afiseaza datele stack trace-ului thread-urilor Java care ocupa cel mai mult CPU: $noc"
  cat $rezult_path
  echo
  echo -e "$tile_cyan$cyan Datele stack trace-ului pentru aceasta captura au fost salvate in:$noc"
  echo -e "  $rezult_path "
fi
echo

## se sterg fisiere temporare
rm $top_path
rm $jstack_path
