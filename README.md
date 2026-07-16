# Crypto Max Pain → TradingView (BTC / ETH / SOL / HYPE)

แสดงจุด **Max Pain** ของ crypto options บน Deribit ทุก expiry สำคัญ เป็นเส้นแนวนอนบนกราฟ TradingView

*Plot Deribit crypto options (BTC/ETH/SOL/HYPE) Max Pain levels per expiry as horizontal lines on your TradingView chart.*

![Pine v6](https://img.shields.io/badge/Pine%20Script-v6-blue) ![Python](https://img.shields.io/badge/Python-3.8%2B-green) ![License MIT](https://img.shields.io/badge/License-MIT-lightgrey)

## Max Pain คืออะไร

Max Pain คือราคา strike ที่ทำให้ผู้ถือ options (ทั้ง call และ put) **ขาดทุนรวมมากที่สุด** ณ วันหมดอายุ — หรือมุมกลับคือราคาที่คนขาย options ได้กำไรสูงสุด ทฤษฎีเชื่อว่าเมื่อใกล้วันหมดอายุ ราคามีแนวโน้มถูกดึงเข้าหาระดับนี้จากแรง hedge ของ market maker จึงนิยมใช้เป็นแนวรับ/แนวต้านเชิงจิตวิทยา

**วิธีคำนวณ:** สำหรับแต่ละ strike สมมติว่าราคา settle ตรงนั้น แล้วรวมมูลค่า in-the-money ของ options ทุกสัญญา (ถ่วงด้วย Open Interest) — strike ที่ให้ payout รวม**ต่ำสุด**คือ Max Pain

## จุดเด่น

- ✅ ดึงข้อมูลจาก **Deribit public API โดยตรง** — ฟรี ไม่ต้องสมัคร ไม่ต้องมี API key
- ✅ คำนวณ Max Pain เองทุก expiry (ผลตรงกับเว็บ analytics ชั้นนำ)
- ✅ เส้นแต่ละ expiry **คนละสี** ลากไปสิ้นสุดที่**วัน settle จริง** (08:00 UTC)
- ✅ **ความหนาเส้นตาม Open Interest** — expiry ไหน OI หนาแน่น เห็นชัดทันที
- ✅ อัปเดตข้อมูลโดย**ไม่ต้องแก้โค้ด** — paste data string ในช่อง Settings ช่องเดียว

## ไฟล์ในโปรเจกต์

| ไฟล์ | หน้าที่ |
|---|---|
| `maxpain.py` | ดึง Deribit API → คำนวณ Max Pain → สร้าง Pine Script / data string (ใช้ Python stdlib ล้วน ไม่ต้องติดตั้งอะไรเพิ่ม) |
| `BTC_MaxPain.pine` / `ETH_MaxPain.pine` / `SOL_MaxPain.pine` / `HYPE_MaxPain.pine` | Indicator แยกรายเหรียญสำหรับ TradingView (Pine Script v6) |
| `update_maxpain.bat` / `_eth.bat` / `_sol.bat` / `_hype.bat` | (Windows) ดับเบิลคลิกเพื่ออัปเดตข้อมูลเหรียญนั้นๆ — copy เข้า clipboard อัตโนมัติ |
| `tradingview_description.md` | คำอธิบายสำหรับหน้า publish script บน TradingView (ไทย + อังกฤษ) |

> BTC/ETH เป็น inverse options ส่วน SOL/HYPE เป็น USDC-settled (linear) — script จัดการความต่างให้เองทั้งหมด
> รวมถึง normalize OI ด้วย contract size (1 สัญญา SOL/HYPE = 10 เหรียญ) ให้ตัวเลขเป็นหน่วยเหรียญจริง

## วิธีติดตั้ง (ครั้งเดียว)

1. ติดตั้ง [Python 3.8+](https://www.python.org/downloads/) (ถ้ายังไม่มี)
2. Clone หรือดาวน์โหลด repo นี้
3. รัน:
   ```
   python maxpain.py --top 8 --pine BTC_MaxPain.pine
   ```
4. เปิด TradingView → กราฟ **BTCUSD** → **Pine Editor** (แถบล่าง) → paste เนื้อหาไฟล์ `BTC_MaxPain.pine` → **Add to chart** → **Save script**

## วิธีอัปเดตข้อมูล (รายวัน — ไม่ต้องแตะโค้ด)

**Windows:** ดับเบิลคลิก `update_maxpain.bat` → data string ใหม่ถูก copy เข้า clipboard ให้เอง

**macOS / Linux:**
```
python maxpain.py --top 8 --string
# copy บรรทัด data string ที่พิมพ์ออกมา (macOS: | pbcopy)
```

จากนั้นบน TradingView: เปิด **Settings** ของ indicator → ลบข้อความเดิมในช่อง **Data** → **Ctrl+V** → OK

## คำสั่งทั้งหมด

```
python maxpain.py                  # ตาราง Max Pain ทุก expiry (BTC)
python maxpain.py --currency SOL   # เปลี่ยนเหรียญ: BTC / ETH / SOL / HYPE (default: BTC)
python maxpain.py --top 8          # เฉพาะ 8 expiry ที่ OI สูงสุด
python maxpain.py --pine FILE      # สร้างไฟล์ Pine Script
python maxpain.py --string         # พิมพ์ data string สำหรับช่อง Data
python maxpain.py --clip           # copy data string เข้า clipboard (Windows)
```

ตัวอย่าง ETH เต็มๆ: `python maxpain.py --currency ETH --top 8 --clip --pine ETH_MaxPain.pine`

## รูปแบบ data string

```
YYMMDD:maxpain:oi,YYMMDD:maxpain:oi,...
เช่น  260731:64000:117241,260925:72000:90100
```

- `YYMMDD` — วันหมดอายุ (settle 08:00 UTC = 15:00 น. เวลาไทย)
- `maxpain` — ราคา Max Pain (USD)
- `oi` — Open Interest รวมของ expiry นั้น (หน่วย BTC)

## ข้อจำกัดที่ควรรู้

- Pine Script ดึงข้อมูลจากอินเทอร์เน็ตเองไม่ได้ จึงต้องอัปเดต data string ด้วยมือ (Max Pain เปลี่ยนช้า อัปเดตวันละครั้งก็เกินพอ)
- บน timeframe intraday TradingView จะ clamp วัตถุที่วาดล่วงหน้าไว้ ~500 แท่ง — expiry ไกลๆ ตำแหน่งอาจเพี้ยน แนะนำดูบน **D หรือ W**
- ทฤษฎี Max Pain เป็นเพียงกรอบวิเคราะห์หนึ่ง ไม่ใช่คำแนะนำการลงทุน

## License

MIT
