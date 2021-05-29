import json, os
def get_classes(path):
    """
    parses a directory of ndjson files for "word" attribute and appends it all to a list
    
    encodes them with a number scheme
    """
    classes = []
    for filename in sorted(os.listdir('data/ndjson')):
        with open('data/ndjson/' + filename) as f:
            record = f.readline()
            classes.append(json.loads(record)['word'])

    classes_dict = {i:classes[i] for i in range(len(classes))}
    return classes_dict