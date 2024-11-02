#!/bin/bash

player_1="X"
player_2="O"

turn=1
game_on=true

field=( 1 2 3 4 5 6 7 8 9 )

print_board(){
    echo -e "\n"
    echo " ${field[0]}   |   ${field[1]}   |   ${field[2]} "
    echo "--------------------"
    echo " ${field[3]}   |   ${field[4]}   |   ${field[5]} "
    echo "--------------------"
    echo " ${field[6]}   |   ${field[7]}   |   ${field[8]} "
}

welcome_screen(){
    clear
    echo "### START GRY ###"
}

starting_player() {
    echo -e "\n"
    echo "Który gracz ma zaczynać grę: (X/O) "

    while true; do
        read current_player
        if [ "$current_player" == "X" ] || [ "$current_player" == "O" ]; then
            break
        else
            echo "Niepoprawnie wybrano gracza. Wybierz 'X' lub 'O'."
        fi
    done

    echo "Grę rozpoczyna gracz: "$current_player
}

select_field () {
    echo -e "\n"
    echo "Wybierz pole od 1 - 9 lub naciśnij "S" celu zapisania gry: "

    while true; do
        read input_field

        if [[ "$input_field" == "S" || "$input_field" == "s" ]]; then
            save_game
            echo "Gra została zapisana, Wybierz pole od 1 - 9: "
            continue
        elif [[ ! $input_field =~ [1-9]$ ]]; then
            print_board
            echo -e "\n"
            echo "Wybrano niepoprawny znak, wybierz cyfrę 1-9"

        elif [ "${field[$input_field-1]}" == "X" ] || [ "${field[$input_field-1]}" == "O" ]; then
            print_board
            echo -e "\n"
            echo "Wybrano zajęte pole, wybierz inne"

        else
            break
        fi
    done

    ((turn+=1))

    field[$input_field-1]=$current_player
}

change_player () {
    if [ "$current_player" == "X" ]; then
        current_player="O"
    else
        current_player="X"
    fi
        echo -e "\n"
    echo "### Teraz tura gracza " $current_player
}

check_win () {
    if [[ ${field[$1]} == ${field[$2]} && ${field[$2]} == ${field[$3]} ]]; then
        game_on=false
    fi
    if [ $game_on == false ]; then
        if [ "${field[$1]}" == 'X' ]; then
            echo -e "\n"
            echo "################"
            echo "Wygrał gracz: X"
            echo "################"
            return
        else
            echo -e "\n"
            echo "################"
            echo "Wygrał gracz: O"
            echo "################"
            return
        fi
    fi
}

choose_winner () {
    if [ $game_on == false ]; then return; fi
    check_win 0 1 2

    if [ $game_on == false ]; then return; fi
    check_win 3 4 5

    if [ $game_on == false ]; then return; fi
    check_win 6 7 8

    if [ $game_on == false ]; then return; fi
    check_win 0 3 6

    if [ $game_on == false ]; then return; fi
    check_win 1 4 7

    if [ $game_on == false ]; then return; fi
    check_win 2 5 8

    if [ $game_on == false ]; then return; fi
    check_win 0 4 8

    if [ $game_on == false ]; then return; fi
    check_win 2 4 6
}

save_game () {
    echo "### Zapisywanie gry ###"

    echo "${field[@]}" > game_save.txt
    echo "$current_player" >> game_save.txt
    echo "$turn" >> game_save.txt

    echo "### Gra została zapisana w game_save.txt ###"
}

load_game() {
    if [ ! -f game_save.txt]; then
        echo -e "\n"
        echo "Brak zapisanego stanu gry."
        return
    fi

    echo -e "\n"
    echo "Wczytuje grę..."

    read -a field < game_save.txt
    read current_player < <(sed -n '2p' game_save.txt)
    read turn < <(sed -n '3p' game_save.txt)

    echo -e "\n"
    echo "### Gra została wczytana ###"
    print_board
}

ask_load_game() {
    echo "Czy chcesz wczytać grę? (Wpisz 'Y' jeżeli tak)"
    read answer

    if [[ "$answer" == 'Y'|| "$answer" == 'y' ]]; then
        load_game
    else
        starting_player
    fi
}

welcome_screen
ask_load_game
print_board
select_field
print_board

while $game_on
do
    change_player
    select_field
    print_board
    choose_winner
done