# AOC 2024

To set up expected directories for a day's solutions, run:

```sh
ruby setup_day.rb 1
```

This will create:

```
├── 01
│   ├── input
│   ├── solution.rb
```

`input` will be an empty file.  You will need to go to `https://adventofcode.com/2024/day/{day_num}` and copy the response body into `input`.  (They appear to require authentication to get the inputs, and I'm not implementing that.)

The solution file will have a `Solution` class with empty `part_one` and `part_two` methods that take in the `lines` of the input file.

To run and copy your solution to the clipboard you can run:

```sh
ruby solve.rb 1 1
```

This will find and run the solution for Day 1 Part 1 and copy the return value of `Solution#part_one` to the clipboard.

_Note that `input` files are gitignored, so you will need to supply these if you clone/fork the repo._
