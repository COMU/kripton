import java.util.*;


/**
 * https://leetcode.com/problems/cheapest-flights-within-k-stops/
 *
 * $ javac CheapestFlightsWithinKStops.java
 * $ java Solution
 */
class Solution {

    class Node {
        int city;
        List<Edge> neigbours = new ArrayList<>();

        public Node(int city) {
            this.city = city;
        }
    }

    class Edge {
        Node to;
        int price;

        public Edge(Node to, int price) {
            this.to = to;
            this.price = price;
        }
    }

	class Flight {
        Node currentCity;
        int totalCost;
        int stops;

        public Flight(Node city, int cost, int stops) {
            this.currentCity = city;
            this.totalCost = cost;
            this.stops = stops;
        }
    }



    public int findCheapestPrice(int n, int[][] flights, int src, int dst, int K) {

        // build the graph
        Map<Integer, Node> graph = new HashMap<>();
        for(int i=0; i<n; ++i){
            graph.put(i, new Node(i));
        }
        for (int[] f : flights) {
            Edge edge = new Edge(graph.get(f[1]), f[2]);
            graph.get(f[0]).neigbours.add(edge);
        }


        // shortest path - Dijkstra Algorithm
        PriorityQueue<Flight> heap = new PriorityQueue<Flight>((f1, f2) -> f1.totalCost-f2.totalCost);
        heap.offer(new Flight(graph.get(src), 0, 0));

        while(!heap.isEmpty()) {
            Flight curr = heap.poll();
            if(curr.currentCity.city == dst) {
                return curr.totalCost;
            }

            if(curr.stops > K) continue;

            for(Edge neigbour : curr.currentCity.neigbours) {
                heap.offer(new Flight(neigbour.to, curr.totalCost+neigbour.price, curr.stops+1));
            }
        }

        return -1;
    }


	public static void main(String[] args) {
		int n = 3;
		int[][] edges = {{0,1,100},{1,2,100},{0,2,500}};
		int src = 0;
		int dst = 2;
		int k = 1;

		System.out.println(new Solution().findCheapestPrice(n, edges, src, dst, k));
	}

}

