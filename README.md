# AOC 2024

To set up expected directories for a day's solutions, run:

```sh
ruby setup_day.rb 1
```

This will create:

```
├── 01
│   ├── input
│   ├── solution_part_1.rb
│   ├── solution_part_2.rb
```

`input` will be an empty file.  You will need to go to `https://adventofcode.com/2024/day/{day_num}` and copy the response body into `input`.  (They appear to require authentication to get the inputs, and I'm not implementing that.)

The two solution files will have a `Solution` class with an empty `solve` method.  Return the solution from this method

You can get the lines of the input file with the `lines` method (it's on `SolutionBase`).

To run and copy your solution to the clipboard you can run:

```sh
ruby solve.rb 1 1
```

This will find and run the solution for Day 1 Part 1 and copy the return value of `solve` to the clipboard.
