public class JavaTest {

	public static void main(String args[]) {
		try {
			while (true) {
				Thread.sleep(1000);
			}
		}
		catch (java.lang.InterruptedException e) {
			System.out.println("Exiting...");
		}
	}

}
