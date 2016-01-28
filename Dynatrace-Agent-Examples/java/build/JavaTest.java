public class JavaTest {

	public static void main(String args[]) {
		try {
			while (true) {
				try {
					throw new Exception();
				}
				catch (Exception e) {
					System.out.println("Threw Exception...");
				}
				finally {
					Thread.sleep(1000);
				}
			}
		}
		catch (java.lang.InterruptedException e) {
			System.out.println("Exiting...");
		}
	}

}
