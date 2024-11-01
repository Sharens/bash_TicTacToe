# Kółko i krzyżyk w bashu

## Backlog:
- [x] - działa w trybie gry turowej,
- [x] - dodać kontrolę nad inputem użytkownika.
- [ ] - pozwala na zapis i odtwarzanie przerwanej gry (save game),
- [ ] - pozwala na grę z komputerem.

Ten projekt to implementacja gry w kółko i krzyżyk (Tic-Tac-Toe) w skrypcie bash. Gra pozwala dwóm graczom na rywalizację na planszy o wymiarach 3x3, gdzie gracze na zmianę wybierają pola i dążą do uzyskania trzech swoich symboli w linii.

## Zawartość projektu

- **main.sh**: główny skrypt zawierający logikę gry.

## Uruchomienie

1. Skrypt można uruchomić bezpośrednio w terminalu. Upewnij się, że masz uprawnienia do uruchamiania pliku, w razie potrzeby nadaj je:

    ```bash
    chmod +x main.sh
    ```

2. Uruchom grę poleceniem:

    ```bash
    bash main.sh
    ```

## Zasady gry

1. Po uruchomieniu skryptu wyświetla się ekran powitalny.
2. Gracz wybiera, czy chce grać symbolem "X" lub "O".
3. Gra wyświetla planszę, a gracze na zmianę wybierają pole, na którym chcą umieścić swój symbol (wpisując liczbę od 1 do 9).
4. Wygrywa pierwszy gracz, który uzyska trzy swoje symbole w linii – poziomo, pionowo lub na ukos.

## Struktura kodu

### Zmienne
- `player_1` i `player_2`: symbol pierwszego i drugiego gracza.
- `turn`: licznik tur.
- `game_on`: wskaźnik, czy gra trwa.
- `field`: tablica przechowująca stan planszy.

### Funkcje

- `print_board`: wyświetla aktualny stan planszy.
- `welcome_screen`: wyświetla ekran powitalny.
- `starting_player`: pozwala na wybór gracza rozpoczynającego.
- `select_field`: pozwala graczowi wybrać pole i aktualizuje stan planszy.
- `change_player`: przełącza tury pomiędzy graczami.
- `check_win`: sprawdza, czy na planszy uzyskano trzy symbole w linii i wyświetla zwycięzcę.
- `choose_winner`: sprawdza zwycięskie kombinacje na planszy.

## Wymagania

- Interpreter `bash`
