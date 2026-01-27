import re

with open('chatbot.js', 'r', encoding='utf-8') as f:
    content = f.read()

# Replace all msg.reply( with client.sendMessage(msg.from, 
content = re.sub(r'await msg\.reply\(', r'await client.sendMessage(msg.from, ', content)

# Add { sendSeen: false } before the closing parenthesis of sendMessage calls
# This is tricky, so we'll do it manually for the specific patterns

with open('chatbot.js', 'w', encoding='utf-8') as f:
    f.write(content)

print("Fixed all msg.reply to client.sendMessage!")
