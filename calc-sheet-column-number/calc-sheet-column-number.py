def title_to_number(s):
    total = 0
    tmp = 0

    for i in range(len(s)-1, -1, -1):
        total += (ord(s[i])-64) * (26**tmp)
        tmp += 1
    return total


if __name__ == "__main__":
    s = "AB"
    print(title_to_number(s))
