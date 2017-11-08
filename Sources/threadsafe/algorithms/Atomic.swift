// This is merely a test file and does not actually include functional code.

func atomic(f: () -> (), l: Lock) {
	l.lock()
	f()
}