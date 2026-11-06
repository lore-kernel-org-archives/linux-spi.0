Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980088;
	b=VUIAEWsd9NtCsEnWLmX2ADST+8H5hMQgz57/yFl/ZjzrxmSJ+Veh33tLQvniADwfDvYz
	 I+w3D8MMzsuG8pC/2QecAo5705kQllrYrK2ArFASKNmdShPbgYw2MlXJfDzzZoh33UskM
	 sJpbU21+S2iakvWHkiBM781WkSYyjoux8xJHYFiR1BoiTlRM2+cYLQUdgO0TuU+Qk3Er9
	 6mEUVtqktSjt28vO3ZARQaVc+IeOeGJ6QH/UbLdU0P3urlzExUtkyUb6BRjgVXqS0ps+5
	 XZhW9UeDxKFExLeT0s/Se1MyyBOtoUTjbzeT+XJiZQBc6CvBy4T6jdis69HPstXJs6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980088;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=ya7OB1mVqTIxqpI9rlmDOEIgR2N3ToDyqlFZeda2RZ0=;
	b=cyJr+OslE/jqZSQldCmJgq/pR20AglUT2EiUB9u07D+i0xgiN9tjU/H1g/UiTjX6zcu0
	 7qTEQwIq6f2W4OcWT/UpZ2QJWXF65U39PlXmrcl8G9lrWXN6u3loP4ZxCud5Sojt2bVYj
	 31amSvbVPY11amIe9iwR6BzKN0eH73bKVaN8VSji3ua7ghhIzf31g0eZ0D7pYkHx+iWsY
	 CpPjHlHirx2JfBGUI4trWnRasYydWkcK27v0QCoxp+ytAdX/NYwQz2nJtzHCpAn7Glsju
	 I48CrzsiNo2DpPxrbnlwpxmUw9z2DEI3kP8CS51dDU9aollck6fj2pfER+DYBWdBOzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF75606A32C;
	Fri,  6 Nov 2026 15:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DF75606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLk915xmBz5B12k;
	Fri, 06 Nov 2026 23:48:05 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6A6Flx8X080941;
	Fri, 6 Nov 2026 23:47:59 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 23:48:01 +0800 (CST)
X-Zmail-TransId: 2afa6aedf6b18d4-a685b
X-Mailer: Zmail v1.0
Message-ID: <20261106234801838-FDh9tSFfnurdJmKLz1ay@zte.com.cn>
In-Reply-To: <20261106234751020Egf42VCVVlsSC_Msov4HO@zte.com.cn>
References: 20261106234751020Egf42VCVVlsSC_Msov4HO@zte.com.cn
Date: Fri, 6 Nov 2026 23:48:01 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDQvNV0gc3BpOiBhcHBsZTogZml4IGRpdmlzaW9uIGJ5IHplcm8gaW4gY2xvY2sgZGl2aXNvciBjYWxjdWxhdGlvbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6Flx8X080941
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 06 Nov 2026 23:48:05 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDF6B5.002/4jLk915xmBz5B12k

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
