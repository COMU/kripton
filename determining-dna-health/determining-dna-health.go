/*
Problem Link

https://www.hackerrank.com/challenges/determining-dna-health/problem

Sample Input

6
a b c aa d b
1 2 3 4 5 6
3
1 5 caaab
0 4 xyz
2 4 bcdybc

External links

https://wiomoc.de/aho-corasick-viz/
https://en.wikipedia.org/wiki/Aho%E2%80%93Corasick_algorithm#Example
https://www.toptal.com/algorithms/aho-corasick-algorithm
https://www.youtube.com/watch?v=OFKxWFew_L0
*/

package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"strconv"
	"strings"

	"github.com/bradleyjkemp/memviz"
)

type Trie struct {
	Genes    []Gene
	Children map[rune]*Trie
}

func (trie *Trie) HasChild(char rune) bool {
	return trie.Children[char] != nil
}
func (trie *Trie) GetChild(char rune) *Trie {
	return trie.Children[char]
}
func (trie *Trie) Add(gene Gene, runes []rune) {
	if len(runes) > 0 {
		child := trie.GetChild(runes[0])
		if child == nil {
			child = &Trie{[]Gene{}, make(map[rune]*Trie)}
			trie.Children[runes[0]] = child
		}
		child.Add(gene, runes[1:])
	} else {
		trie.Genes = append(trie.Genes, gene)
	}
}
func (trie *Trie) GetScore(start int, end int) int {
	score := 0
	for _, g := range trie.Genes {
		if g.Index >= start && g.Index <= end {
			score += g.Health
		}
	}
	return score
}
func (trie *Trie) GetOccurrenceCount(runes []rune, start int, end int) int {
	score := trie.GetScore(start, end)
	if len(runes) > 0 && trie.HasChild(runes[0]) {
		score += trie.GetChild(runes[0]).GetOccurrenceCount(runes[1:], start, end)
	}
	return score
}

type Gene struct {
	String string
	Health int
	Index  int
}
type DNA struct {
	Start  int
	End    int
	String string
}

func main() {
	input, err := getInput()

	if err != nil {
		fmt.Println(err)
		return
	}

	count, err := strconv.Atoi(input[0])
	if err != nil {
		fmt.Println(err)
		return
	}

	//  Make root Trie
	root := Trie{[]Gene{}, make(map[rune]*Trie)}
	health := strings.Split(input[2], " ")
	for i, g := range strings.Split(input[1], " ") {
		num, _ := strconv.Atoi(health[i])
		gene := Gene{g, num, i}
		root.Add(gene, []rune(gene.String))
	}

	//  DNA array
	count, _ = strconv.Atoi(input[3])
	dna := make([]DNA, count)
	for i, d := range input[4:] {
		s := strings.Split(d, " ")
		start, _ := strconv.Atoi(s[0])
		end, _ := strconv.Atoi(s[1])
		dna[i] = DNA{start, end, s[2]}
	}
  
  
	healthy_dna := " "
	unhealthy_dna := " "
	healthiest := 0
	unhealthiest := -1

	for _, d := range dna {
		score := 0
		runes := []rune(d.String)
		for i, _ := range runes {
			score += root.GetOccurrenceCount(runes[i:], d.Start, d.End)
		}

		if score > healthiest {
			healthiest = score
			healthy_dna = d.String

		}
		if score < unhealthiest || unhealthiest < 0 {
			unhealthiest = score
			unhealthy_dna = d.String
		}
	}
	fmt.Println(" ")
	fmt.Println(unhealthy_dna, ":", unhealthiest)
	fmt.Println(healthy_dna, ":", healthiest)

	//  Make visualization of root Trie

	buf := &bytes.Buffer{}
	memviz.Map(buf, &root)
	err = ioutil.WriteFile("example-tree-data", buf.Bytes(), 0644)
	if err != nil {
		panic(err)
	}
}

func getInput() ([]string, error) {
	reader := bufio.NewReader(os.Stdin)
	input := []string{}
	for {
		str, err := reader.ReadString('\n')
		if err != nil && err != io.EOF {
			return nil, err
		}

		if err == io.EOF {
			input = append(input, str)
			break
		} else {
			runes := []rune(str)
			input = append(input, string(runes[0:len(runes)-1]))
		}
	}

	return input, nil
}
