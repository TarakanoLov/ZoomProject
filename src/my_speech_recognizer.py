import speech_recognition as sr
from os import path

def one_file_speech2text(audio):
    r = sr.Recognizer()
    return r.recognize_google(audio, language='ru-RU')
    


#пример использования/тест
if __name__ == '__main__':
    AUDIO_FILE = path.join(path.dirname(path.realpath(__file__)), "test_tarakan.wav")

    r = sr.Recognizer()
    with sr.AudioFile(AUDIO_FILE) as source:
        audio = r.record(source)
    
    print(one_file_speech2text(audio))