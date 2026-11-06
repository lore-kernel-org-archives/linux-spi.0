Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980092;
	b=0lcdPFqU6c9tW35Zkte8y6eQgY7N3LAn+AfLz4F75MJKlSw9Pcrm9AnQgRChQKkKVNmh
	 Gjfq5OS5uHH0jHr0YlF/T703Frs0nhxoTLVGNTstC7r/rZxktV0QaM7bpP/f6cXvNMSxU
	 3F67cDeRSMC9sSzUGwf8dKdm5HI7G/vQlZl419my4jfVZAeEMsyKKW31MhQSg3N/eP015
	 B1mWRbkoSw89SJdhbac++4si/JykJO0UrSmAseQ1SXnZttGSb9NZi4GR/2NrRgyjSq95x
	 NHSIuVi2CDd9ubKoX9V3ztrqlk3RgrzhD/LPTpS9iPb0ukkTUGwG5rK354/ZxCvemtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980092;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=/u8h+hcsj8MZ3F8YEpQZ/r2DyybrF8zCRIH94PeMAS8=;
	b=DFal6T2spll89bpunOpAiXz3WqK2mnlaHY0vDuFnquHwhtN8ZlKnTTQCkF+LSCJ9z65W
	 v9IzuoI4YwOhL9q9Hn74G3Mlouj+FYnPwIofVKSP3+mHBd2IzcPm4IsPjMpH2sf53P/WK
	 X/Mws19tJqn38+NNeFOIregjTUSvmsSO9JOXDikAO7JxYI7UYuFT1XMr7KLTRh33eyvuJ
	 SCGNILC+NfexEDv8UFhjxqjfM269+RLrENGj7heA8uVaK3iH6Awm7seRBcIFjg7SYj/JZ
	 5AThRggRQWQRfjQWKkGtbd2t1WKTLZpMGi91HVmKNEL8IpuA615yOCcDvbPsII8KDtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6D606A332;
	Fri,  6 Nov 2026 15:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69E6D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLk96605nz8Xrr9;
	Fri, 06 Nov 2026 23:48:10 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6A6Fm1cp081003;
	Fri, 6 Nov 2026 23:48:01 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 23:48:03 +0800 (CST)
X-Zmail-TransId: 2afa6aedf6b3953-a68da
X-Mailer: Zmail v1.0
Message-ID: <20261106234803459Z94udUX-Ai29-OfBFRND6@zte.com.cn>
In-Reply-To: <20261106234751020Egf42VCVVlsSC_Msov4HO@zte.com.cn>
References: 20261106234751020Egf42VCVVlsSC_Msov4HO@zte.com.cn
Date: Fri, 6 Nov 2026 23:48:03 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDUvNV0gc3BpOiBhdG1lbDogZml4IGRpdmlzaW9uIGJ5IHplcm8gd2hlbiB0cmFuc2ZlciBzcGVlZCBpcyB6ZXJv?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6Fm1cp081003
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 06 Nov 2026 23:48:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDF6BA.000/4jLk96605nz8Xrr9

From: Shao Mingyin <shao.mingyin@zte.com.cn>

atmel_spi_one_transfer() calls atmel_spi_set_xfer_speed() for every
transfer.  A device whose max_speed_hz is zero (no spi-max-frequency
property, or created through the spidev sysfs new_device interface
without a speed) leaves the transfer speed at zero, and the divider
calculation divides by it.  spi_setup() would only clamp the speed if
host->max_speed_hz was set, which this driver does not do.

On cores without a hardware divider this reports "Division by zero in
kernel" and dumps a stack trace, and on cores with one the quotient is
silently zero; in both cases the existing "too high" check then rejects
the transfer.

Clamp the divisor to 1 Hz so the zero never reaches the division.

Fixes: d3b72c7e6bf3 ("spi: atmel: add support for changing message transfer speed")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

---

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ffc896e4621a..deebf7afabbc 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -922,8 +922,9 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
 	/*
 	 * Calculate the lowest divider that satisfies the
 	 * constraint, assuming div32/fdiv/mbz == 0.
+	 * A device with max_speed_hz == 0 must not divide by zero.
 	 */
-	scbr = DIV_ROUND_UP(bus_hz, xfer->speed_hz);
+	scbr = DIV_ROUND_UP(bus_hz, max_t(u32, xfer->speed_hz, 1));
 
 	/*
 	 * If the resulting divider doesn't fit into the
