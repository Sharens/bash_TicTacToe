# main.sh
#!/bin/bash

# Dodać opcję wyboru czym chce gracz grać
player_1="X"
player_2="O"

turn=1
game_on=true

field=( 1 2 3 4 5 6 7 8 9 )

print_board(){
    echo " ${field[0]}   |   ${field[1]}   |   ${field[2]} "
    echo "--------------------"
    echo " ${field[3]}   |   ${field[4]}   |   ${field[5]} "
    echo "--------------------"
    echo " ${field[6]}   |   ${field[7]}   |   ${field[8]} "
}

welcome_screen(){
    clear
    echo "### START GRY ###"
    echo "Poniżej znajdziesz plansze: "

}

starting_player() {
    echo "Który gracz ma zaczynać grę: (X/O) "
    read current_player
    echo "Grę rozpoczyna gracz: "$current_player
}

welcome_screen

print_board

starting_player

select_field () {
    echo "Wybierz pole od 1 - 9: " # Dodać sprawdzanie czy gracz wybrał poprawne pole
    read input_field
    select_field=${field[($input_field-1)]}
    (($turn+=1))

    field[$input_field-1]=$current_player
}

select_field
print_board

