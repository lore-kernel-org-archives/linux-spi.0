Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466212;
	b=C/ynGfKIRur0TLEPuaqEtgNQJowGbpG0oTJEiwzueCgYbduPjOTm1Z5i5cX2pGdJe0ct
	 4NhtwvacVd4qZfWQBdUMqP9stfS/EPzVNRE5IdyfC5X7UY9xkVF345ZH4KrsRBB/xTltn
	 1qyQBiMczIYdTk6r8b5PSDfMTli0S29ZTU0d9IeDwGYCnzMxu84SzFdPD3MtLJTzGhGJ2
	 ZVBuTvygJIz69DdDAJZFs2LBKfKVTwbT/c7a/nUSlAaxyE7AdsFS80pE23UW3+4k11Ze/
	 1xhKmUCYiRaXL3CWafI3ogssYFw8+o0K2h0FiQkK4lK22QwaEytuHjOz0gZGVFkRXPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lFZI6D9HiCcFKFr5KBwD7yhjEPPk3NJWS5p9mmDk/e4=;
	b=pFE9BvWHpZAJ96G+fhHQYkCmdd4FaKSKpDZXFhShmKKyHcMYIFDzM00lkhiXq4fRuiTJ
	 xIkNXtZ03RfpXTJ/WvzYinoHz48QOF/bx+EFG/QxccwSF0HOfRzep2DWFZx2n+tlFc72U
	 hWZfCi/p1XnL+y/TeR/5hy7xB14ViaLDH6jbG/yrOPDkmv5bGfpY9yEoxNUSz+SBzxzjB
	 qvkv9Dt84AdvsyF1iOs05k2mBzlZRTDDhViPLgbcv/T9NJ0YY4rx2O1MFumNeejO1jAPO
	 k+t9GIVcdPGRimA+6cm+dA/nZQTSmihsLaBK1bcEjX6i4TdZsmW3auwzzERnl38GylQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cWPz+EWz;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E20606A339
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 06:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18E20606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cWPz+EWz
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso8352398eec.0
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 22:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466211; x=1795071011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lFZI6D9HiCcFKFr5KBwD7yhjEPPk3NJWS5p9mmDk/e4=;
        b=cWPz+EWzUeQmTIy8ZK9xBrRqqGwycpud6QuPSV70aIpIP/CnITrTYo2KEFCLXq5s93
         fK0WR1Pfdb5mCZv/QECuYsobLcp8oXXV0QkHqX18a4jlxqDyrxJmKB05dWf2DGDiFavG
         TwK2xjuGsFddCKUOtr2WNunfpdhXJFBfdLOyVu8kYBqdQ7q24+qiBfCnKBhE8r9aKR3l
         j/c5ZIoqdH01QCfNRJhUs+vp3HqxG/4+ejN9BLCpXotHlidQRpwsyYis5HSaqM0F1rAY
         We4UxdMiFBZrY/Zg3XrlQtwgbTri5DN0Ph8RrFbR0rrE3Q0yiTPESB64uY1AMnY8ot2W
         SXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466211; x=1795071011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lFZI6D9HiCcFKFr5KBwD7yhjEPPk3NJWS5p9mmDk/e4=;
        b=YY5bFWrnD4cNsxoNHJM4MhCm61j+CrFWyepZQyBsX0QK7s3LseBZk8SA5n40sgBSWF
         8mlBKXJsK/A7A3X+dejKSQmuwXSjFjWBebBlsILPIa21n2LCWmMsqXBJhDSyXrIPwfI5
         h3U1g71MysJ1GTDCN1Nh6DjiVMaW/YmosDpD2EQckdA8AoemALMMQWoYaBjXQ9QN2Uzo
         I2xgdzkc2fc+ngJmu8asFJaXdF9zm75ORnqnp08uxHoZ88OwbbrawcdIWd2fVe6pFJC3
         AWPN5n2McCEzZhqoCrd3ilbVMi1mo5kxPBBwqWi68YeSP0t4M+cjBf8spf0+XJsOAUCY
         4G0A==
X-Forwarded-Encrypted: i=1; AL+hErEMxTZXvQA2eqm0ZgjxtOkB9CmWNpytgSIhON60rUO9ETLSNX00wN+qF0eC1i+2zBGQXYLJKd1lT3I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9X/9r8Qg4EUoTKqOiBH5w7d+HNgQK+jVVzOu/EDmXRpKXdICxW
	VSlyIRzKMZdQEfVEqAE7TqQIAmgSKY+gE/Ey96ehvOIAWXBy8dNzI9MM
X-Gm-Gg: AYBFou1T2V1GT2g3pHCBfQCIi2i+fN9ZO1cEJcoHuyACZbGkmoyGBWVt8HcJmVixQAG
	QFa1uCH9/BYCOUJ55Ecd4ckbx/KW088B1EGWuUPp7+MXX9vt/ZMer9ZTceEKe8WJZnUT/jNec+j
	Y0G18KxT72y006+oVxCaJO6947N3GcEaVKMwdWc1bIopB1E5ZjA0JGIJQJpckYGOynya0YCVP3w
	TLK2mnma3mw3pJj59qDJz8LhZpu1V57ZNqakLuGP+kGI3kZMtn9tH8W549k/o0kS6tEExphWC4/
	cRV6I5HWDdfCrVsMv/8ZmQVr596/03gX6u1NLXneVHsLwSwPw2ik2+1FBpxRHTQpS8ep7TgSfu4
	cKyGNG+tu7bAPsO3Cjbm/LiJez8rBttWjKwUezp2kApQqt4xeWiwIDiU4K4qiJL6UWRiyvCJYY8
	ujZJisnzzDqB+a4+fybnbm8r/FVCjY9rKok5idNb/Z18FuSdW8hPNvM4IuK/Y2BCbJfsQPQ7cuh
	z16FeVFIqPQI0M8n8T9oV0sgA8P1SK54S1aDcfU5ja8cTiV0hEj/6tpWGEok21RWFFakSuLbhVi
	5OQqTp6VKLeAlLEIY/F1qK5vGIorYJy2lVitW/NIeN9cXQ/MctTc7e01/hKbwiS/4s+14jRgI7K
	HW22PrxQCKXoDOVl9
X-Received: by 2002:a05:7301:795:b0:36e:e349:f2cb with SMTP id 5a478bee46e88-3768579dfa3mr4930481eec.19.1794466210966;
        Wed, 11 Nov 2026 22:50:10 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm27190961eec.19.2026.11.11.22.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:10 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Kris Bahnsen <kris@embeddedTS.com>,
	Mark Featherston <mark@embeddedTS.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Input: ads7846 - fix minor coding style issues
Date: Wed, 11 Nov 2026 22:49:57 -0800
Message-ID: <20261112064957.1796975-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix minor checkpatch warnings and checks across the ads7846 driver,
cleaning up types, spacing, permissions, and macro formatting.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ads7846.c | 119 +++++++++++++---------------
 1 file changed, 57 insertions(+), 62 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4a5a141bb4a6..ce1ae6a7b58e 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -127,6 +127,7 @@ struct ads7846 {
 
 	struct touchscreen_properties core_prop;
 
+	/* Serializes start/stop operations and state changes */
 	struct mutex		lock;
 	bool			stopped;	/* P: lock */
 	bool			disabled;	/* P: lock */
@@ -145,7 +146,8 @@ enum ads7846_filter {
 
 /*--------------------------------------------------------------------------*/
 
-/* The ADS7846 has touchscreen and other sensors.
+/*
+ * The ADS7846 has touchscreen and other sensors.
  * Earlier ads784x chips are somewhat compatible.
  */
 #define	ADS_START		(1 << 7)
@@ -166,7 +168,7 @@ enum ads7846_filter {
 #define	ADS_PD10_REF_ON		(2 << 0)	/* vREF on + penirq */
 #define	ADS_PD10_ALL_ON		(3 << 0)	/* ADC + vREF on */
 
-#define	MAX_12BIT	((1<<12)-1)
+#define	MAX_12BIT	((1 << 12) - 1)
 
 /* leave ADC powered up (disables penirq) between differential samples */
 #define	READ_12BIT_DFR(x, adc, vref) (ADS_START | ADS_A2A1A0_d_ ## x \
@@ -273,8 +275,7 @@ static void ads7846_disable(struct ads7846 *ts)
 	guard(mutex)(&ts->lock);
 
 	if (!ts->disabled) {
-
-		if  (!ts->suspended)
+		if (!ts->suspended)
 			__ads7846_disable(ts);
 
 		ts->disabled = true;
@@ -286,7 +287,6 @@ static void ads7846_enable(struct ads7846 *ts)
 	guard(mutex)(&ts->lock);
 
 	if (ts->disabled) {
-
 		ts->disabled = false;
 
 		if (!ts->suspended)
@@ -327,7 +327,7 @@ struct ads7845_ser_req {
 	u8 sample[3] ____cacheline_aligned;
 };
 
-static int ads7846_read12_ser(struct device *dev, unsigned command)
+static int ads7846_read12_ser(struct device *dev, unsigned int command)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct ads7846 *ts = dev_get_drvdata(dev);
@@ -362,7 +362,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	command |= ADS_PD10_ADC_ON;
 
 	/* take sample */
-	req->command = (u8) command;
+	req->command = (u8)command;
 	req->xfer[2].tx_buf = &req->command;
 	req->xfer[2].len = 1;
 	spi_message_add_tail(&req->xfer[2], &req->msg);
@@ -408,7 +408,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	return status;
 }
 
-static int ads7845_read12_ser(struct device *dev, unsigned command)
+static int ads7845_read12_ser(struct device *dev, unsigned int command)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct ads7846 *ts = dev_get_drvdata(dev);
@@ -420,7 +420,7 @@ static int ads7845_read12_ser(struct device *dev, unsigned command)
 
 	spi_message_init(&req->msg);
 
-	req->command[0] = (u8) command;
+	req->command[0] = (u8)command;
 	req->xfer[0].tx_buf = req->command;
 	req->xfer[0].rx_buf = req->sample;
 	req->xfer[0].len = 3;
@@ -454,30 +454,30 @@ name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
 		return v; \
 	return sprintf(buf, "%u\n", adjust(ts, v)); \
 } \
-static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
+static DEVICE_ATTR(name, 0444, name ## _show, NULL)
 
-
-/* Sysfs conventions report temperatures in millidegrees Celsius.
+/*
+ * Sysfs conventions report temperatures in millidegrees Celsius.
  * ADS7846 could use the low-accuracy two-sample scheme, but can't do the high
  * accuracy scheme without calibration data.  For now we won't try either;
  * userspace sees raw sensor values, and must scale/calibrate appropriately.
  */
-static inline unsigned null_adjust(struct ads7846 *ts, ssize_t v)
+static inline unsigned int null_adjust(struct ads7846 *ts, ssize_t v)
 {
 	return v;
 }
 
-SHOW(temp0, temp0, null_adjust)		/* temp1_input */
-SHOW(temp1, temp1, null_adjust)		/* temp2_input */
+SHOW(temp0, temp0, null_adjust);		/* temp1_input */
+SHOW(temp1, temp1, null_adjust);		/* temp2_input */
 
-
-/* sysfs conventions report voltages in millivolts.  We can convert voltages
- * if we know vREF.  userspace may need to scale vAUX to match the board's
+/*
+ * Sysfs conventions report voltages in millivolts.  We can convert voltages
+ * if we know vREF.  Userspace may need to scale vAUX to match the board's
  * external resistors; we assume that vBATT only uses the internal ones.
  */
-static inline unsigned vaux_adjust(struct ads7846 *ts, ssize_t v)
+static inline unsigned int vaux_adjust(struct ads7846 *ts, ssize_t v)
 {
-	unsigned retval = v;
+	unsigned int retval = v;
 
 	/* external resistors may scale vAUX into 0..vREF */
 	retval *= ts->vref_mv;
@@ -486,9 +486,9 @@ static inline unsigned vaux_adjust(struct ads7846 *ts, ssize_t v)
 	return retval;
 }
 
-static inline unsigned vbatt_adjust(struct ads7846 *ts, ssize_t v)
+static inline unsigned int vbatt_adjust(struct ads7846 *ts, ssize_t v)
 {
-	unsigned retval = vaux_adjust(ts, v);
+	unsigned int retval = vaux_adjust(ts, v);
 
 	/* ads7846 has a resistor ladder to scale this signal down */
 	if (ts->model == 7846)
@@ -497,8 +497,8 @@ static inline unsigned vbatt_adjust(struct ads7846 *ts, ssize_t v)
 	return retval;
 }
 
-SHOW(in0_input, vaux, vaux_adjust)
-SHOW(in1_input, vbatt, vbatt_adjust)
+SHOW(in0_input, vaux, vaux_adjust);
+SHOW(in1_input, vbatt, vbatt_adjust);
 
 static umode_t ads7846_is_visible(struct kobject *kobj, struct attribute *attr,
 				  int index)
@@ -544,9 +544,8 @@ static int ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
 	case 7845:
 	case 7843:
 		if (!ts->vref_mv) {
-			dev_warn(&spi->dev,
-				"external vREF for ADS%d not specified\n",
-				ts->model);
+			dev_warn(&spi->dev, "external vREF for ADS%d not specified\n",
+				 ts->model);
 			return 0;
 		}
 		break;
@@ -555,7 +554,6 @@ static int ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
 	hwmon = devm_hwmon_device_register_with_groups(&spi->dev,
 						       spi->modalias, ts,
 						       ads7846_attr_groups);
-
 	return PTR_ERR_OR_ZERO(hwmon);
 }
 
@@ -575,10 +573,10 @@ static ssize_t ads7846_pen_down_show(struct device *dev,
 	return sprintf(buf, "%u\n", ts->pendown);
 }
 
-static DEVICE_ATTR(pen_down, S_IRUGO, ads7846_pen_down_show, NULL);
+static DEVICE_ATTR(pen_down, 0444, ads7846_pen_down_show, NULL);
 
 static ssize_t ads7846_disable_show(struct device *dev,
-				     struct device_attribute *attr, char *buf)
+				    struct device_attribute *attr, char *buf)
 {
 	struct ads7846 *ts = dev_get_drvdata(dev);
 
@@ -669,8 +667,7 @@ static int ads7846_get_value(struct ads7846_buf *buf)
 	return (value >> 3) & 0xfff;
 }
 
-static void ads7846_set_cmd_val(struct ads7846 *ts, enum ads7846_cmds cmd_idx,
-				u16 val)
+static void ads7846_set_cmd_val(struct ads7846 *ts, enum ads7846_cmds cmd_idx, u16 val)
 {
 	struct ads7846_packet *packet = ts->packet;
 
@@ -869,7 +866,7 @@ static void ads7846_read_state(struct ads7846 *ts)
 static void ads7846_report_state(struct ads7846 *ts)
 {
 	struct ads7846_packet *packet = ts->packet;
-	unsigned int Rt;
+	unsigned int rt;
 	u16 x, y, z1, z2;
 
 	x = packet->x;
@@ -887,18 +884,18 @@ static void ads7846_report_state(struct ads7846 *ts)
 		x = 0;
 
 	if (ts->model == 7843 || ts->model == 7845) {
-		Rt = ts->pressure_max / 2;
+		rt = ts->pressure_max / 2;
 	} else if (likely(x && z1)) {
 		/* compute touch pressure resistance using equation #2 */
-		Rt = z2;
-		Rt -= z1;
-		Rt *= ts->x_plate_ohms;
-		Rt = DIV_ROUND_CLOSEST(Rt, 16);
-		Rt *= x;
-		Rt /= z1;
-		Rt = DIV_ROUND_CLOSEST(Rt, 256);
+		rt = z2;
+		rt -= z1;
+		rt *= ts->x_plate_ohms;
+		rt = DIV_ROUND_CLOSEST(rt, 16);
+		rt *= x;
+		rt /= z1;
+		rt = DIV_ROUND_CLOSEST(rt, 256);
 	} else {
-		Rt = 0;
+		rt = 0;
 	}
 
 	/*
@@ -906,9 +903,9 @@ static void ads7846_report_state(struct ads7846 *ts)
 	 * the maximum. Don't report it to user space, repeat at least
 	 * once more the measurement
 	 */
-	if (packet->ignore || Rt > ts->pressure_max) {
+	if (packet->ignore || rt > ts->pressure_max) {
 		dev_vdbg(&ts->spi->dev, "ignored %d pressure %d\n",
-			 packet->ignore, Rt);
+			 packet->ignore, rt);
 		return;
 	}
 
@@ -919,7 +916,7 @@ static void ads7846_report_state(struct ads7846 *ts)
 	if (ts->penirq_recheck_delay_usecs) {
 		udelay(ts->penirq_recheck_delay_usecs);
 		if (!get_pendown_state(ts))
-			Rt = 0;
+			rt = 0;
 	}
 
 	/*
@@ -931,7 +928,7 @@ static void ads7846_report_state(struct ads7846 *ts)
 	 * The only safe way to check for the pen up condition is in the
 	 * timer by reading the pen signal state (it's a GPIO _and_ IRQ).
 	 */
-	if (Rt) {
+	if (rt) {
 		struct input_dev *input = ts->input;
 
 		if (!ts->pendown) {
@@ -941,10 +938,10 @@ static void ads7846_report_state(struct ads7846 *ts)
 		}
 
 		touchscreen_report_pos(input, &ts->core_prop, x, y, false);
-		input_report_abs(input, ABS_PRESSURE, ts->pressure_max - Rt);
+		input_report_abs(input, ABS_PRESSURE, ts->pressure_max - rt);
 
 		input_sync(input);
-		dev_vdbg(&ts->spi->dev, "%4d/%4d/%4d\n", x, y, Rt);
+		dev_vdbg(&ts->spi->dev, "%4d/%4d/%4d\n", x, y, rt);
 	}
 }
 
@@ -955,7 +952,6 @@ static irqreturn_t ads7846_hard_irq(int irq, void *handle)
 	return get_pendown_state(ts) ? IRQ_WAKE_THREAD : IRQ_HANDLED;
 }
 
-
 static irqreturn_t ads7846_irq(int irq, void *handle)
 {
 	struct ads7846 *ts = handle;
@@ -964,7 +960,6 @@ static irqreturn_t ads7846_irq(int irq, void *handle)
 	msleep(TS_POLL_DELAY);
 
 	while (!ts->stopped && get_pendown_state(ts)) {
-
 		/* pen is down, continue with the measurement */
 		ts->read_state(ts);
 
@@ -988,7 +983,6 @@ static int ads7846_suspend(struct device *dev)
 	guard(mutex)(&ts->lock);
 
 	if (!ts->suspended) {
-
 		if (!ts->disabled)
 			__ads7846_disable(ts);
 
@@ -1008,7 +1002,6 @@ static int ads7846_resume(struct device *dev)
 	guard(mutex)(&ts->lock);
 
 	if (ts->suspended) {
-
 		ts->suspended = false;
 
 		if (device_may_wakeup(&ts->spi->dev))
@@ -1163,8 +1156,10 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts)
 	packet->count_skip = DIV_ROUND_UP(count, 24);
 
 	if (ts->debounce_max && ts->debounce_rep)
-		/* ads7846_debounce_filter() is making ts->debounce_rep + 2
-		 * reads. So we need to get all samples for normal case. */
+		/*
+		 * ads7846_debounce_filter() is making ts->debounce_rep + 2
+		 * reads. So we need to get all samples for normal case.
+		 */
 		packet->count = ts->debounce_rep + 2;
 	else
 		packet->count = 1;
@@ -1237,11 +1232,11 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts)
 }
 
 static const struct of_device_id ads7846_dt_ids[] = {
-	{ .compatible = "ti,tsc2046",	.data = (void *) 7846 },
-	{ .compatible = "ti,ads7843",	.data = (void *) 7843 },
-	{ .compatible = "ti,ads7845",	.data = (void *) 7845 },
-	{ .compatible = "ti,ads7846",	.data = (void *) 7846 },
-	{ .compatible = "ti,ads7873",	.data = (void *) 7873 },
+	{ .compatible = "ti,tsc2046",	.data = (void *)7846 },
+	{ .compatible = "ti,ads7843",	.data = (void *)7843 },
+	{ .compatible = "ti,ads7845",	.data = (void *)7845 },
+	{ .compatible = "ti,ads7846",	.data = (void *)7846 },
+	{ .compatible = "ti,ads7873",	.data = (void *)7873 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ads7846_dt_ids);
@@ -1282,7 +1277,7 @@ static int ads7846_probe(struct spi_device *spi)
 	/* don't exceed max specified sample rate */
 	if (spi->max_speed_hz > (125000 * SAMPLE_BITS)) {
 		dev_err(dev, "f(sample) %d KHz?\n",
-			(spi->max_speed_hz/SAMPLE_BITS)/1000);
+			(spi->max_speed_hz / SAMPLE_BITS) / 1000);
 		return -EINVAL;
 	}
 
@@ -1440,7 +1435,7 @@ static int ads7846_probe(struct spi_device *spi)
 					irq_flags, dev->driver->name, ts);
 	if (err && err != -EPROBE_DEFER) {
 		dev_info(dev,
-			"trying pin change workaround on irq %d\n", spi->irq);
+			 "trying pin change workaround on irq %d\n", spi->irq);
 		irq_flags |= IRQF_TRIGGER_RISING;
 		err = devm_request_threaded_irq(dev, spi->irq,
 						ads7846_hard_irq, ads7846_irq,
@@ -1466,7 +1461,7 @@ static int ads7846_probe(struct spi_device *spi)
 	if (ts->model == 7845)
 		ads7845_read12_ser(dev, PWRDOWN);
 	else
-		(void) ads7846_read12_ser(dev, READ_12BIT_SER(vaux));
+		(void)ads7846_read12_ser(dev, READ_12BIT_SER(vaux));
 
 	err = input_register_device(input_dev);
 	if (err)
-- 
2.56.0.567.gdb80ae8cd5-goog

