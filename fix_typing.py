import re

with open('chatbot.js', 'r', encoding='utf-8') as f:
    content = f.read()

# Remove all occurrences of the typing pattern
pattern = r'      await delay\(\d+\);\r?\n      await chat\.sendStateTyping\(\);\r?\n      await delay\(\d+\);\r?\n\r?\n'
replacement = '      await delay(500);\r\n\r\n'

content = re.sub(pattern, replacement, content)

# Also handle 8-space indentation
pattern2 = r'        await delay\(\d+\);\r?\n        await chat\.sendStateTyping\(\);\r?\n        await delay\(\d+\);\r?\n\r?\n'
replacement2 = '        await delay(500);\r\n\r\n'

content = re.sub(pattern2, replacement2, content)

with open('chatbot.js', 'w', encoding='utf-8') as f:
    f.write(content)

print("Fixed!")
