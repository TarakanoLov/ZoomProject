import os

import numpy as np

import audio_of_conference
import my_speech_recognizer


def _word_error_rate(r, h):
    d = np.zeros((len(r) + 1) * (len(h) + 1), dtype = np.uint8).reshape((len(r) + 1, len(h) + 1))
    for i in range(len(r) + 1):
        for j in range(len(h) + 1):
            if i == 0:
                d[0][j] = j
            elif j == 0:
                d[i][0] = i
    
    for i in range(1, len(r) + 1):
        for j in range(1, len(h) + 1):
            if r[i - 1] == h[j - 1]:
                d[i][j] = d[i - 1][j - 1]
            else:
                subsistution = d[i - 1][j - 1] + 1
                insertion = d[i][j - 1] + 1
                deletion = d[i - 1][j] + 1
                d[i][j] = min(subsistution, insertion, deletion)
    
    return d[len(r)][len(h)]

def get_list_of_message_from_recognize_audio():
    user_home_directory = os.path.expanduser("~")
    
    if 'Documents' not in os.listdir(path=user_home_directory):
        return {}
        
    if 'Zoom' not in os.listdir(path='{}\\Documents'.format(user_home_directory)):
        return {}
        
    list_of_conferens = os.listdir(path='{}\\Documents\\Zoom'.format(user_home_directory))
    list_of_conferens_abs_path = [user_home_directory + '\\Documents\\Zoom\\' + one_conference_name for one_conference_name in list_of_conferens]
        
    for one_conference_abs_path in list_of_conferens_abs_path:
        all_audio, list_row, additional_info = audio_of_conference.get_data_for_conference(one_conference_abs_path)

        if not list_row or not all_audio or not additional_info:
            continue

        res = []
    
        while len(all_audio) != 0 and len(list_row) != 0:
            l = len(all_audio)
            min_wer = 10**9
            index = -1
            for i in range(len(list_row)):
                el = list_row[i]
                wer = _word_error_rate(el['text'][0], all_audio[0])
                if wer < min_wer:
                    min_wer = wer
                    index = i
                elif wer == min_wer and len(res) != 0 and res[-1]['user'] == el['user']:
                    min_wer = wer
                    index = i
        
            el = list_row[index]
            if len(res) == 0 or res[-1]['user'] != el['user']:
                res.append({'user' : el['user'], 'text' : all_audio[0]})
            else:
                res[-1]['text'] += ' ' + el['text'][0]
        
            all_audio.pop(0)
            el['text'].pop(0)
            if len(el['text']) == 0:
                list_row.pop(index)

        yield { 'users_messages' : res,
                'description' : 'to do: description',
                'conference_id' : additional_info['conference_id'],
                'conference_name' : additional_info['conference_name'],
                'conference_date' : additional_info['conference_date'],
                'conference_summary' : audio_of_conference.get_summary_of_text(res) }
                
