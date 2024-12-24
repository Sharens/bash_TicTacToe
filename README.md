# Kółko i krzyżyk w bashu
## Backlog:
- [x] - działa w trybie gry turowej,
- [x] - dodać kontrolę nad inputem użytkownika.
- [x] - pozwala na zapis i odtwarzanie przerwanej gry (save game),
- [x] - pozwala na grę z komputerem.

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
2. Gra pyta, czy chcesz wczytać zapisany stan gry; wciśnięcie `Y`/`y` przywróci poprzednią sesję, a inny znak pozwoli wybrać symbol początkowy `X` lub `O`.
3. Gra wyświetla planszę, a gracze na zmianę wybierają pole, na którym chcą umieścić swój symbol (wpisując liczbę od 1 do 9).
4. W trakcie gry gracz może zapisać postęp, wciskając `S`/`s`, co utworzy plik `game_save.txt`.
5. Wygrywa pierwszy gracz, który uzyska trzy swoje symbole w linii – poziomo, pionowo lub na ukos.

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
- `select_field`: pozwala graczowi wybrać pole, zapisuje wybór w tablicy `field` i aktualizuje planszę; umożliwia zapis gry po wciśnięciu `S`/`s`.
- `change_player`: przełącza tury pomiędzy graczami.
- `check_win`: sprawdza, czy na planszy uzyskano trzy symbole w linii i wyświetla zwycięzcę.
- `choose_winner`: sprawdza zwycięskie kombinacje na planszy.
- `save_game`: zapisuje stan gry do pliku `game_save.txt` (zawiera aktualne pole, gracza i licznik tur).
- `load_game`: przywraca stan gry zapisany w `game_save.txt`, jeśli plik istnieje.
- `ask_load_game`: pyta gracza, czy chce przywrócić zapisany stan gry.

## Wymagania
- Interpreter `bash`