#!/bin/bash

player_1="X"
player_2="O"
computer="O"
game_mode=""
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

select_game_mode() {
    echo -e "\n"
    echo "Wybierz tryb gry:"
    echo "1 - Gra z drugim graczem"
    echo "2 - Gra z komputerem"
    
    while true; do
        read mode
        if [ "$mode" == "1" ] || [ "$mode" == "2" ]; then
            game_mode=$mode
            break
        else
            echo "Nieprawidłowy wybór. Wybierz 1 lub 2."
        fi
    done
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

# Funkcja sprawdzająca, czy pole jest wolne
is_field_free() {
    local pos=$1
    if [[ "${field[$pos]}" != "X" && "${field[$pos]}" != "O" ]]; then
        return 0
    else
        return 1
    fi
}

# Funkcja symulująca wygraną
simulate_win() {
    local pos1=$1
    local pos2=$2
    local pos3=$3
    local symbol=$4
    
    if [[ ${field[$pos1]} == $symbol && ${field[$pos2]} == $symbol && ${field[$pos3]} == $symbol ]]; then
        return 0
    fi
    return 1
}

# Funkcja sprawdzająca możliwą wygraną
check_possible_win() {
    local symbol=$1
    local test_field=()
    
    # Kopiuj aktualny stan planszy
    for ((i=0; i<9; i++)); do
        test_field[$i]=${field[$i]}
    done
    
    for ((i=0; i<9; i++)); do
        if [[ "${field[$i]}" != "X" && "${field[$i]}" != "O" ]]; then
            test_field[$i]=$symbol
            
            # Sprawdź wszystkie możliwe linie
            if simulate_win 0 1 2 $symbol || \
               simulate_win 3 4 5 $symbol || \
               simulate_win 6 7 8 $symbol || \
               simulate_win 0 3 6 $symbol || \
               simulate_win 1 4 7 $symbol || \
               simulate_win 2 5 8 $symbol || \
               simulate_win 0 4 8 $symbol || \
               simulate_win 2 4 6 $symbol; then
                return $i
            fi
            
            test_field[$i]=${field[$i]}
        fi
    done
    
    return 255
}

# Funkcja dla ruchu komputera
computer_move() {
    local move
    
    # Sprawdź możliwość wygranej komputera
    check_possible_win $computer
    move=$?
    if [ $move -ne 255 ]; then
        field[$move]=$computer
        ((turn+=1))
        return
    fi
    
    # Sprawdź i zablokuj możliwą wygraną gracza
    check_possible_win "X"
    move=$?
    if [ $move -ne 255 ]; then
        field[$move]=$computer
        ((turn+=1))
        return
    fi
    
    # Wybierz środek planszy jeśli jest wolny
    if is_field_free 4; then
        field[4]=$computer
        ((turn+=1))
        return
    fi
    
    # Wybierz losowe wolne pole
    local free_fields=()
    for ((i=0; i<9; i++)); do
        if is_field_free $i; then
            free_fields+=($i)
        fi
    done
    
    if [ ${#free_fields[@]} -gt 0 ]; then
        local random_index=$((RANDOM % ${#free_fields[@]}))
        field[${free_fields[$random_index]}]=$computer
        ((turn+=1))
    fi
}

select_field () {
    if [ "$game_mode" == "2" ] && [ "$current_player" == "$computer" ]; then
        echo -e "\n"
        echo "Ruch komputera..."
        sleep 1
        computer_move
        return
    fi

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
    if [ "$game_mode" == "2" ] && [ "$current_player" == "$computer" ]; then
        echo "### Teraz tura komputera"
    else
        echo "### Teraz tura gracza " $current_player
    fi
}

check_win () {
    local winner=""
    if [[ ${field[$1]} == ${field[$2]} && ${field[$2]} == ${field[$3]} ]]; then
        winner=${field[$1]}
        game_on=false
    fi
    
    if [ $game_on == false ] && [ ! -z "$winner" ]; then
        if [ "$winner" == "X" ]; then
            echo -e "\n"
            echo "################"
            echo "Wygrał gracz: X"
            echo "################"
            return
        elif [ "$winner" == "O" ]; then
            if [ "$game_mode" == "2" ]; then
                echo -e "\n"
                echo "################"
                echo "Wygrał komputer!"
                echo "################"
            else
                echo -e "\n"
                echo "################"
                echo "Wygrał gracz: O"
                echo "################"
            fi
            return
        fi
    fi

    # Sprawdź remis
    local is_draw=true
    for ((i=0; i<9; i++)); do
        if is_field_free $i; then
            is_draw=false
            break
        fi
    done

    if [ "$is_draw" == true ]; then
        game_on=false
        echo -e "\n"
        echo "################"
        echo "     REMIS!"
        echo "################"
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
    echo "$game_mode" >> game_save.txt

    echo "### Gra została zapisana w game_save.txt ###"
}

load_game() {
    if [ ! -f game_save.txt ]; then
        echo -e "\n"
        echo "Brak zapisanego stanu gry."
        return 1
    fi

    echo -e "\n"
    echo "Wczytuje grę..."

    read -a field < game_save.txt
    read current_player < <(sed -n '2p' game_save.txt)
    read turn < <(sed -n '3p' game_save.txt)
    read game_mode < <(sed -n '4p' game_save.txt)

    echo -e "\n"
    echo "### Gra została wczytana ###"
    print_board
    return 0
}

ask_load_game() {
    echo "Czy chcesz wczytać grę? (Wpisz 'Y' jeżeli tak)"
    read answer

    if [[ "$answer" == 'Y' || "$answer" == 'y' ]]; then
        if load_game; then
            return
        fi
    fi
    select_game_mode
    starting_player
}

# Start gry
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