# Sudoku puzzle solver

This project is able to solve sudoku puzzles. The project currently does not take user input but you can fill out the starting board from withing the program in order to solve your own board.

## Instructions for Build and Use

Steps to build and/or run the software:

1. Open up the terminal and start the Eshell by running:

```bash
erl
```

2. Compile the erlang script by running this in Eshell
```Eshell
c(sudoku).
```
3. Run the program by calling main from Eshell
```Eshell
sudoku:main().
```

Instructions for using the software:

1. Enter your known board values in list of lists returned by the initial_board() function.
2. Recompile the sukoku file using the Eshell
3. Then run the program from the Eshell

## Development Environment

To recreate the development environment, you need the following software and/or libraries with the specified versions:

* Download and install erlang
* Download the "Erlang LS" extension for VSCode

## Useful Websites to Learn More

I found these websites useful in developing this software:

* [erlang docs](https://www.erlang.org/doc/apps/stdlib/api-reference.html)

## Future Work

The following items I plan to fix, improve, and/or add to this project in the future:

* [ ] Command line board input
* [ ] Multiple solutions or errors for invalid boards
