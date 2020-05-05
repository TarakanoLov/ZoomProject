import speech_recognition as sr
from os import path

def one_file_speech2text(path_audio_file):
    r = sr.Recognizer()
    with sr.AudioFile(path_audio_file) as source:
        audio = r.record(source)
        
    r = sr.Recognizer()
    return r.recognize_google(audio, language='ru-RU')
    


if __name__ == '__main__':

    
    
    print(one_file_speech2text('test_tarakan.wav'))