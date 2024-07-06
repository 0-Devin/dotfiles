#!/bin/bash

bmenu(){
bemenu --fn 'intelonemono' --nb '#282828' --ab '#282828' --hb '#303030' --hf '#ffffff' --tb '#282828' --tf '#ffffff' --fb '#282828' --scf '#303030' --hp 15 -p "$@" -P ">" -c -l 4 -W .30
}

newQuestion(){
generateRand=(
    $(awk -v loop=4 -v range=19 'BEGIN{
        srand()
        do {
            numb = int(rand() * range)
            if (!(numb in prev)) {
                print numb
                prev[numb] = 1
                count++
            }
        }   while (count<loop)
    }')
    )
    choices=( 
    $(for j in ${generateRand[@]}; do echo ${polyatomicpair[$j]}; done)
    )

    if [[ $(( $RANDOM%2 )) == 0 ]]
    then
        rand=$(( $RANDOM%4 ))
        molecule=$(echo ${choices[$rand]} | cut -d : -f 2)
        moleculeAnswer=$(echo ${choices[$rand]} | cut -d : -f 1 | sed 's/_/ /') 
        printChoices() {
        for k in $(seq 0 3); do
            echo ${choices[$k]} | cut -d : -f 1 | sed 's/_/ /'
        done
        }
    else
        rand=$(( $RANDOM%4 ))
        molecule=$(echo ${choices[$rand]} | cut -d : -f 1)
        moleculeAnswer=$(echo ${choices[$rand]} | cut -d : -f 2) 
        printChoices() {
        for k in $(seq 0 3); do
            echo ${choices[$k]} | cut -d : -f 2 | sed 's/_/ /'
        done
        }
    fi
}

polyatomicpair=(
"Ammonium:NH4(+)"
"Acetate:C2H3O2(-)"
"Cyanide:CN(-)"
"Hydroxide:OH(-)"
"Nitrate:NO3(-)"
"Nitrite:NO2(-)"
"Perchlorate:ClO4(-)"
"Chlorate:ClO3(-)"
"Chlorite:ClO2(-)"
"Hypochlorite:ClO(-)"
"Permanganate:MnO4(-)"
"Bicarbonate:HCO3(-)"
"Carbonate:CO3(2-)"
"Peroxide:O2(2-)"
"Bisulfate:HSO4(-)"
"Sulfate:SO4(2-)"
"Sulfite:SO3(2-)"
"Dihydrogen_Phosphate:H2PO4(-)"
"Hydrogen_Phosphate:HPO4(2-)"
"Phosphate:PO4(3-)"
)

correct=0
while [[ 1 == 1 ]]; do
    newQuestion 
    
    answer=$(printChoices | bmenu $molecule)
    if [[ "$answer" == "$moleculeAnswer" ]]
    then
        correct=$(( $correct + 1))
        answered=$(( $answered + 1))
        echo "you got $correct / $answered" | bmenu "score"

    else
        answered=$(( $answered + 1))
    fi
    
    if [[ "$answer" == "Exit" ]]
    then
        exit
    fi
done
