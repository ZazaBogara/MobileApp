from flask import Flask, request, jsonify

app = Flask(__name__)

file_path = "D:\\Programing\\flutterLabs\\api\\Api_for_flutterLabs\\storage.txt"


def save_to_file(key, value):
    with open(file_path, "a") as file:
        file.write(f"{key}={value}\n")


def read_from_file():
    data = {}
    try:
        with open(file_path, "r") as file:
            for line in file:
                key, value = line.strip().split("=")
                data[key] = value
    except FileNotFoundError:
        pass
    return data


def update_file(key, value):
    data = read_from_file()
    data[key] = value
    with open(file_path, "w") as file:
        for k, v in data.items():
            file.write(f"{k}={v}\n")


def delete_from_file(key):
    data = read_from_file()
    if key in data:
        del data[key]
        with open(file_path, "w") as file:
            for k, v in data.items():
                file.write(f"{k}={v}\n")


@app.route('/save', methods=['POST'])
def save_data():
    key = request.json['key']
    value = request.json['value']
    save_to_file(key, value)
    return jsonify({'message': 'Data saved successfully'})


@app.route('/get', methods=['GET'])
def get_data():
    data = read_from_file()
    key = request.args.get('key')
    value = data.get(key)
    return jsonify({'value': value})


@app.route('/update', methods=['PUT'])
def update_data():
    key = request.json['key']
    value = request.json['value']
    update_file(key, value)
    return jsonify({'message': 'Data updated successfully'})


@app.route('/delete', methods=['DELETE'])
def delete_data():
    key = request.args.get('key')
    delete_from_file(key)
    return jsonify({'message': 'Data deleted successfully'})


if __name__ == '__main__':
    app.run(debug=True)
