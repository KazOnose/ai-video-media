import os
from PIL import Image

files = [
    r'c:\Users\admin\Desktop\ai-video-media\public\blog\ld\multilingual-sop-microlearning.png',
    r'c:\Users\admin\Desktop\ai-video-media\public\blog\hr\recruitment-video-ai-auto-generation.png',
    r'c:\Users\admin\Desktop\ai-video-media\public\blog\cs\customer-success-onboarding-video.png',
    r'c:\Users\admin\Desktop\ai-video-media\public\blog\saas\saas-hikaku-video-gaichuu.png'
]

for f in files:
    if os.path.exists(f):
        img = Image.open(f)
        width, height = img.size
        print(f"--- {os.path.basename(f)} ---")
        print(f"Size: {width}x{height}")
        # 中央部分の色分布やテキスト領域の大まかな推測（簡易的）
        # ここではメタデータやサイズのみを出力
        img.close()
