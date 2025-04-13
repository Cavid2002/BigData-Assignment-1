from typing import List
import ast

cut_num = 0

def extract_nodes(src_file: str, dst_file: str):
    src = open(src_file, "r")
    dst = open(dst_file, "w")
    count = 0
    for line in src:
        count += 1
        print(count)
        if count == 1:
            continue
        ids = extract_ids(line)
        res_line = parse_list_str(ids)
        dst.write(res_line)


    src.close()
    dst.close()

def parse_list_str(l: List[str]):
    res_line = ""
    for i in l:
        res_line += i + " "
    res_line += "\n"
    return res_line

def extract_ids(line: str) -> List[str]:
    count = 9
    while True: 
        try:
            parts = line.split(',', count) 
            list_str = parts[count].strip()

            id = int(parts[0].strip('"'))
            user_list: list = ast.literal_eval(list_str)
            user_list.insert(0, str(id))
            return user_list
        except:
            count += 1


extract_nodes('data.csv', 'result.txt')