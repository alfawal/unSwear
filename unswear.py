from pynput.keyboard import Listener, Key, Controller, KeyCode
import csv


class Recorder:
    buffer = ""

    def __init__(self, word_pairs: dict[str, str]):
        self.keyboard = Controller()
        self.word_pairs = word_pairs

    def on_press(self, key):
        if key == Key.space:
            self.evaluate_word()
            self.buffer = ""

        if key == Key.backspace:
            self.handle_backspace()

        if type(key) is KeyCode and key.char is not None:
            self.buffer += key.char

    def handle_backspace(self):
        self.buffer = self.buffer[:-1]

    def on_release(self, key):
        pass

    def evaluate_word(self):
        if self.buffer in self.word_pairs:
            self.delete_word(len(self.buffer))
            self.keyboard.type(f"{self.word_pairs[self.buffer]} ")

    def delete_word(self, length):
        for _ in range(length + 1):
            self.keyboard.press(Key.backspace)
            self.keyboard.release(Key.backspace)


if __name__ == "__main__":
    with open("replacements.csv", newline="") as f:
        reader = csv.DictReader(f)
        pairs: dict[str, str] = {
            row["swear"]: row["replacement"] for row in reader
        }

    recorder = Recorder(pairs)

    try:
        with Listener(
            on_press=recorder.on_press, on_release=recorder.on_release
        ) as listener:
            listener.join()
    except KeyboardInterrupt:
        raise SystemExit(0)
