import os
import os.path
import hashlib

from pydub import AudioSegment
import speech_recognition as sr
import audiosegment
from pydub.effects import normalize
from pysummarization.nlpbase.auto_abstractor import AutoAbstractor
from pysummarization.tokenizabledoc.simple_tokenizer import SimpleTokenizer
from pysummarization.abstractabledoc.top_n_rank_abstractor import TopNRankAbstractor

import my_speech_recognizer

def _my_split(ls):
    return ls.lower().split()
    
def get_summary_of_text(messages):
    auto_abstractor = AutoAbstractor()
    auto_abstractor.tokenizable_doc = SimpleTokenizer()
    auto_abstractor.delimiter_list = ['@']
    abstractable_doc = TopNRankAbstractor()
    
    string = ''
    for msg in messages:
        string += msg['text'] + '@'
    result_dict = auto_abstractor.summarize(string, abstractable_doc)

    return [one_msg[:-1] for one_msg in result_dict['summarize_result']]

def _get_audio_of_all_users(path_to_one_conference):  
    open(path_to_one_conference + '\\so_user_audio_conference_we_already_parse.txt', 'a').close()
        
    result_list = []
    if 'Audio Record' in os.listdir(path=path_to_one_conference):
        path_to_seperate_audio = path_to_one_conference + '\\Audio Record'
        list_of_separate_audio_only = os.listdir(path=path_to_seperate_audio)
        for one_audio_file in list_of_separate_audio_only:
            true_path = path_to_seperate_audio + '\\' + one_audio_file

            if (os.path.splitext(one_audio_file)[0] + '.wav') not in os.listdir(path='.') and os.path.splitext(one_audio_file)[0] + '.wav' != one_audio_file:
                audio_m4a = AudioSegment.from_file(true_path, format='m4a')
                audio_m4a.export(true_path[:-4] + '.wav', 'wav')
            if os.path.splitext(one_audio_file)[0] + '.wav' != one_audio_file:
                    
                def get_name_user_from_file_name(file_name):
                    return ' '.join(file_name.split('_')[-2:])

                try:
                    result_list.append({'text' : _my_split(my_speech_recognizer.one_file_speech2text(true_path[:-4] + '.wav')), 
                                    'user' : get_name_user_from_file_name(one_audio_file[:-4])})
                except:
                    pass
                    
                os.remove(true_path[:-4] + '.wav')
                
    return result_list
    
    
def _get_main_audio(path_to_one_conference):
    open(path_to_one_conference + '\\so_this_conference_we_already_parse.txt', 'a').close()
    
    file = path_to_one_conference + '\\audio_only'
    if 'audio_only.wav' not in os.listdir(path = path_to_one_conference):
        audio_m4a = AudioSegment.from_file(file + '.m4a', format='m4a')
        audio_m4a.export(file + '.wav', 'wav')
    
    text = my_speech_recognizer.one_file_speech2text(file + '.wav')
    result = _my_split(text)
    os.remove(file + '.wav')
    return result

def _get_additional_info_of_conference(abs_path_to_conference):
    return { 'conference_id' : int(hashlib.md5(bytes(abs_path_to_conference, encoding='utf-8')).hexdigest(), base=16),
             'conference_date' : abs_path_to_conference.split('\\')[-1][:19],
             'conference_name' : abs_path_to_conference.split('\\')[-1][20:]}


def get_data_for_conference(abs_path_to_conference):
    if 'so_this_conference_we_already_parse.txt' in os.listdir(path=abs_path_to_conference):
        return None, None, None
    if 'so_user_audio_conference_we_already_parse.txt' in os.listdir(path=abs_path_to_conference):
        return None, None, None
        
    return _get_main_audio(abs_path_to_conference), _get_audio_of_all_users(abs_path_to_conference), _get_additional_info_of_conference(abs_path_to_conference)

