#!/bin/python

import sys
import png

def are_rows_white(rows, white_color):
    for row in rows:
        for color in row:
            if color != white_color:
                return False

    return True

def main(args):
    for filename in args:
        with open(filename, "rb") as f:
            r = png.Reader(file = f)

            _, _, rows, info = r.read()
            rows = [row for row in rows] # we want to be able to read rows from closed files

        row8_count = (len(rows)+7) // 8
        white_color = (1 << info["bitdepth"]) - 1

        while are_rows_white(rows[(row8_count-1)*8:], white_color):
            rows = rows[:(row8_count-1)*8]
            row8_count = row8_count - 1

        if len(rows) > 6*8:
            rows = rows[:6*8] + [bytearray([white_color for _ in range(info["size"][0])]) for _ in range(2*8)] + rows[6*8:]

        with open(filename, "wb") as f:
            info["size"] = (info["size"][0], len(rows))
            w = png.Writer(**info)
            w.write(f, rows)

            print(f"{filename} {info['size'][0]}x{info['size'][1]}")

if __name__ == "__main__":
    main(sys.argv[1:])
