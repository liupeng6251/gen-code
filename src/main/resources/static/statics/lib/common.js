function parseDate(data) {
    var arr = data.replace("-", ":").replace(" ", ":").split(":");
    if (arr.length == 3) {
        return new Date(arr[0], arr[1], arr[2])
    }
    if (arr.length > 3) {
        return new Date(arr[0], arr[1], arr[2], arr[3], arr[4], arr[5])
    }

}