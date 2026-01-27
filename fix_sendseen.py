import re

with open('chatbot.js', 'r', encoding='utf-8') as f:
    content = f.read()

# Pattern to match client.sendMessage calls and add { sendSeen: false }
# Match: client.sendMessage(msg.from, "text")
# Replace with: client.sendMessage(msg.from, "text", { sendSeen: false })

# For single line strings
pattern1 = r'await client\.sendMessage\(msg\.from,\s*"([^"]*?)"\s*\);'
replacement1 = r'await client.sendMessage(msg.from, "\1", { sendSeen: false });'
content = re.sub(pattern1, replacement1, content)

# For multi-line strings (with +)
pattern2 = r'await client\.sendMessage\(msg\.from,\s*\n\s*(".*?"(?:\s*\+\s*\n\s*".*?")*)\s*\);'
replacement2 = r'await client.sendMessage(msg.from, \n          \1, { sendSeen: false });'
content = re.sub(pattern2, replacement2, content, flags=re.MULTILINE | re.DOTALL)

with open('chatbot.js', 'w', encoding='utf-8') as f:
    f.write(content)

print("Added { sendSeen: false } to all sendMessage calls!")
