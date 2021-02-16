import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * javac TravelRestrictions.java 
 * java TravelRestrictions < travel_restrictions_sample_input.txt 
 */
public class TravelRestrictions {

	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

		int testCases = Integer.valueOf(br.readLine());
		for (int i = 0; i < testCases; i++) {
			System.out.println("Case #" + (i + 1) + ": ");
			int flightCount = Integer.valueOf(br.readLine());
			String in = br.readLine();
			String out = br.readLine();
			Solver.solve(flightCount, in, out);
		}
	}

	static class Solver {

		public static void solve(int f, String in, String out) {

			char[][] res = new char[f][f];

			for (int i = 0; i < f; ++i) {
				res[i][i] = 'Y';
			}

			for (int i = 0; i < f; ++i) {
				for (int j = i + 1; j < f; ++j) {
					if (res[i][j - 1] == 'Y' && out.charAt(j - 1) == 'Y' && in.charAt(j) == 'Y')
						res[i][j] = 'Y';
					else
						res[i][j] = 'N';
				}
			}

			for (int i = 1; i < f; ++i) {
				for (int j = i - 1; j >= 0; --j) {
					if (res[i][j + 1] == 'Y' && out.charAt(j + 1) == 'Y' && in.charAt(j) == 'Y')
						res[i][j] = 'Y';
					else
						res[i][j] = 'N';
				}
			}

			// print result
			for (int i = 0; i < f; ++i) {
				for (int j = 0; j < f; ++j) {
					System.out.print(res[i][j]);
				}
				System.out.println();
			}
		}
	}

}
