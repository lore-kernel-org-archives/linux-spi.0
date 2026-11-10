Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324909;
	b=ihtUclMJRuFpVb5VvTl+IpiTjE4FxdzRPfdSEz72giYh1yc2G0h9JSH/BLUxRRirQkqm
	 RvKmwAJELIfg5aZpf1EgEWwc7L1nQoitirdpznlh3zVMlWqgOoUZqYb7ehrcD4igf1MmX
	 CR2RFUGN+oQ0D40XAEEKiAN8gaoO1aRjNF03ZHzyOSmaxBRqCBhbTSwszcImUlJYA57PD
	 UgimqCiSfqULvhuxg+nlGHgoNzYGPaQHUo+8TFmpoDk0f+rQmxekgHnU7XEqtvL+3DQC7
	 CF5VIHBcapNvERwG3oxrHtiFkyCBjZUzoWSi2b7bvlz8xrR0w+/F3joYaQvJJRG2ofw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324909;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=ya7OB1mVqTIxqpI9rlmDOEIgR2N3ToDyqlFZeda2RZ0=;
	b=OyXiF+ipfb9RGWzOFf7hapiobLPpSkoPRKszdjZQhaVzzNuFKOnOayYan7m0IzqJcoSa
	 8UzZg7U0VBM5doFVVuBsyU7yIKuIWMAiNbtuJzXVt/q8EEtUegZQH86y9Yzk/Twuc1XtD
	 iJVAKdBZLMk1eDxsxe6q4hmhefpjFKTHnz/Dh1RxPsKLJ7BRyelp0hRDJkU4L1cc4p8jD
	 rWXikacs2JX+/P6Y+4dB12RS5uoJdLgnbvgePX2tWg1XVNSxXL82ihBvmwXR0GE0Ntj5l
	 72CnrhBD5x0kWbep8mNQcT9tzdYtvXXwSWINlmZyZj14kHtdk8R4ayvBpKA6867ulqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=naD5Qbx2;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0F60A3819;
	Tue, 10 Nov 2026 15:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07D0F60A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=naD5Qbx2
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP9hC3Rdqz7QqdW;
	Tue, 10 Nov 2026 23:35:07 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794324907;
	bh=vCndIxAkdLuYPop3RsR+aa3QHLPya9IjXmeL/gb1SfU=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=naD5Qbx2n3hW3oFMwmfvViKkYVRJtqNZIzCgzWIl0LLCDz9VqxSLBbWZTf2gRhr2C
	 trUP0LRqrvZTfugnGB6PXfdVpLPNSg2rpeRqeiCb6YnMwGWrwba+64Wu+uqb3ff8Pa
	 0aE2Vr5ZN3gDy6YHH+ilMsCzwhZ+aXXw8b7H9J7yrMEu/G5U2gfIw7SGILbV8673Oe
	 aVdeuIRn0Rkuv1e8cRrWJHIcI1T0SmOBIivVfi48pbs/9368MkuV5C7LXgNOhufq/Z
	 p97w2dEwQm/s9dUit4HELeGoC2yikjU8h1XxAfCSO7iTKobRe2CdCeqXmpjEe9ZyAV
	 8vpxrKJLQIYFA==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AAFYvO6047675;
	Tue, 10 Nov 2026 23:34:57 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:35:00 +0800 (CST)
X-Zmail-TransId: 2afa6af339a4629-3dc31
X-Mailer: Zmail v1.0
Message-ID: <20261110233500846p3a8Gxa6sHGAVryCJ5vHc@zte.com.cn>
In-Reply-To: <20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn>
References: 20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn
Date: Tue, 10 Nov 2026 23:35:00 +0800 (CST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <pjw@kernel.org>, <samuel.holland@sifive.com>,
        <william.zhang@broadcom.com>, <kursad.oney@broadcom.com>,
        <jonas.gorski@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <anand.gore@broadcom.com>, <florian.fainelli@broadcom.com>,
        <rafal@milecki.pl>, <linux-arm-kernel@lists.infradead.org>,
        <sven@kernel.org>, <j@jannau.net>, <neal@gompa.dev>,
        <asahi@lists.linux.dev>, <ryan.wanner@microchip.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>
Subject: =?UTF-8?B?W1BBVENIIHYyIDQvNV0gc3BpOiBhcHBsZTogZml4IGRpdmlzaW9uIGJ5IHplcm8gaW4gY2xvY2sgZGl2aXNvciBjYWxjdWxhdGlvbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AAFYvO6047675
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 23:35:07 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF339AB.000/4jP9hC3Rdqz7QqdW

From: Shao Mingyin <shao.mingyin@zte.com.cn>

A SPI device without a valid speed (no spi-max-frequency property, or
created through the spidev sysfs new_device interface without a speed)
gets max_speed_hz == 0.  spi_setup() only clamps that to the controller
limit when host->max_speed_hz is set, and this driver does not set it, so
the zero reaches apple_spi_prep_transfer() and DIV_ROUND_UP() divides by
it.

On arm64 the divide instruction returns zero instead of trapping, so
CLKDIV is programmed as zero.  That selects the fastest clock and can
exceed the rate the attached device supports.

Clamp the divisor to 1 Hz so the divider calculation is well defined.

Fixes: c36212b2610d ("spi: apple: Add driver for Apple SPI controller")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

---

diff --git a/drivers/spi/spi-apple.c b/drivers/spi/spi-apple.c
index 61eefb08d2a7..8dbf05936db1 100644
--- a/drivers/spi/spi-apple.c
+++ b/drivers/spi/spi-apple.c
@@ -196,9 +196,13 @@ static void apple_spi_set_cs(struct spi_device *device, bool is_high)
 static bool apple_spi_prep_transfer(struct apple_spi *spi, struct spi_transfer *t)
 {
 	u32 cr, fifo_threshold;
+	u32 speed_hz;
+
+	/* A device with max_speed_hz == 0 must not divide by zero */
+	speed_hz = max_t(u32, t->speed_hz, 1);
 
 	/* Calculate and program the clock rate */
-	cr = DIV_ROUND_UP(clk_get_rate(spi->clk), t->speed_hz);
+	cr = DIV_ROUND_UP(clk_get_rate(spi->clk), speed_hz);
 	reg_write(spi, APPLE_SPI_CLKDIV, min_t(u32, cr, APPLE_SPI_CLKDIV_MAX));
 
 	/* Update bits per word */
