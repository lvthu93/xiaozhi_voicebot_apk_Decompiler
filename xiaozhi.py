import sys

def java_hashcode(s: str) -> int:
    h = 0
    for c in s:
        h = (31 * h + ord(c)) & 0xFFFFFFFF  # giả lập overflow 32-bit
    # convert về signed int
    if h & 0x80000000:
        h = -((~h + 1) & 0xFFFFFFFF)
    return h

def generate_device_id(android_id: str, mac: str) -> int:
    s = android_id + mac
    h = java_hashcode(s)
    return abs(h) % 10000000

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python tool.py <android_id> <mac>")
        sys.exit(1)

    android_id = sys.argv[1]
    mac = sys.argv[2]

    device_id = generate_device_id(android_id, mac)

    print("Input string :", android_id + mac)
    print("Java hashCode:", java_hashcode(android_id + mac))
    print("Device ID    :", device_id)
