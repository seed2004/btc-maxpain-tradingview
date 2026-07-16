# คำอธิบายสำหรับหน้า Publish Script บน TradingView

> Copy ข้อความด้านล่างไปวางในช่อง description ตอนกด Publish Script
> (TradingView กำหนดให้ต้องอธิบายว่า script ทำอะไรและใช้อย่างไร)

---

**BTC Max Pain (Deribit) — เส้น Max Pain ของทุก expiry สำคัญบนกราฟเดียว**

## Indicator นี้ทำอะไร

แสดงระดับราคา **Max Pain** ของ Bitcoin options บน Deribit แยกตามวันหมดอายุ (expiry) เป็นเส้นประแนวนอนบนกราฟ โดยแต่ละเส้น:

- ใช้ **คนละสี** ต่อ expiry พร้อม label บอกวันหมดอายุ / ราคา Max Pain / Open Interest รวม
- ลากจากแท่งปัจจุบันไปสิ้นสุดที่ **เวลา settle จริง** ของ expiry นั้น (08:00 UTC) — เห็นชัดว่าแต่ละระดับ "หมดอายุ" เมื่อไหร่
- **ความหนาเส้นแปรตาม Open Interest** — expiry ที่เงินกองอยู่เยอะ (monthly/quarterly) เส้นหนากว่า weekly ที่ OI บาง

## Max Pain คืออะไร

Max Pain คือ strike ที่ทำให้มูลค่ารวมของ options ทั้ง call และ put (ถ่วงน้ำหนักด้วย Open Interest) **หมดค่ามากที่สุด** ณ วัน settle — เป็นราคาที่ผู้ซื้อ options เจ็บสุดและผู้ขาย (ซึ่งมักเป็น market maker) ได้ประโยชน์สุด ทฤษฎีนี้เชื่อว่าเมื่อใกล้หมดอายุ แรง delta-hedge มีแนวโน้มดึงราคาเข้าหาระดับนี้ นักเทรดจึงใช้เป็นโซนแม่เหล็ก/แนวรับ-แนวต้านเชิง options flow ประกอบการวิเคราะห์

## ข้อมูลมาจากไหน

คำนวณจาก Open Interest รายสัญญาของ BTC options ทั้งหมดบน **Deribit public API** (ฟรี ไม่ต้องมี key) ด้วยสูตรมาตรฐาน: ไล่ทุก strike หา strike ที่ total payout ของผู้ถือ options ต่ำสุด

เนื่องจาก Pine Script ไม่สามารถเชื่อมต่ออินเทอร์เน็ตเองได้ indicator นี้จึงรับข้อมูลผ่านช่อง **"Data"** ใน Settings รูปแบบ `YYMMDD:maxpain:oi` คั่นด้วย comma — สร้าง string นี้อัตโนมัติได้ด้วย Python script (โอเพนซอร์ส) ใน repository ที่แนบไว้ รันคำสั่งเดียวข้อมูลใหม่จะถูก copy เข้า clipboard พร้อม paste

## วิธีใช้

1. เพิ่ม indicator ลงกราฟ BTCUSD (แนะนำ timeframe **D ขึ้นไป** — บน intraday TradingView จำกัดการวาดล่วงหน้า ~500 แท่ง ทำให้ expiry ไกลแสดงตำแหน่งคลาดเคลื่อน)
2. อัปเดตข้อมูล: รัน script จาก repo (หรือคำนวณเอง) → paste string ใหม่ในช่อง Data → OK
3. ตั้งค่าได้: ซ่อน/แสดง OI ใน label, ซ่อน expiry ที่หมดอายุแล้ว

## Settings

- **Data** — data string (`YYMMDD:maxpain:oi,...`)
- **Show total OI in label** — แสดง Open Interest รวมใน label
- **Hide expired** — ซ่อน expiry ที่ settle ไปแล้ว

⚠️ Max Pain เป็นกรอบวิเคราะห์เชิงทฤษฎี ราคาไม่จำเป็นต้องวิ่งเข้าหาเสมอไป โดยเฉพาะช่วงตลาดมีแรงขับทิศทางแรง — ไม่ใช่คำแนะนำการลงทุน

Source code + ตัวสร้างข้อมูลอัตโนมัติ: github.com/seed2004/btc-maxpain-tradingview
