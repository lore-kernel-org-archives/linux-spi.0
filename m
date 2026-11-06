Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980087;
	b=4WX2kijLkUMpdNW8Fweafq5yPPAeGt9/HP5zWDdsJb0sRXF5eWffh9wxV/tTVQL+HK2h
	 pdzlUUk/rAoPwQfRK16L0jZ4SfNM/36NhufBweK1j8zdrWVNJUvtYVwJrPnISejE6VxKV
	 1VN17wkSoUq1Q9Y6p1Efn828HmdeUoSqGOaM4cnsDMLddVZTNy4uLAENTHlOrGt++SIe1
	 uL5vb+NMj41/iUA9B2xJaBRbcxvF3BWH7hHAjBZjv5QT6mWhliGeKq9Phxx2SuY0f2/J/
	 cZDcUMibDCnkk79DwJEND7nkSH+XubDmHAGm+5tid0FA2nVp6J6aYlx3XDEmaWuXEiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980087;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=ayUZrHPtgAcHc+0mRQFYPo9FqMxMF0x0I2geL/esqpQ=;
	b=lcLpu+uebL3zKuNfUkxJCD3p2kQOuaZL7oRowxklucfXBonHNAH3tCJfi5sMZ/IJzJ7c
	 raRADwicd528pazhM2bCy/MrVhAbRiCua73f8oORul0KmhnZw8AeaEzPfKRQGUd7Gr0wP
	 h1gbfhpe9Z/RIK1t4F2K4APkFJHW0BxMweQKU5OeCf6JLse4IUfUmpejrCBOv7jNak0m9
	 hzmBnUd4cITfCU3fessiBjKMppFHmDSusDL1DQOvf3iaRJ+SpDJWMZarYk1D0OB+mzJIM
	 NaeAR4x1+tWQmjMm4Q/8+UOEdaILo+Auq/EMBObxq7t++Vaxoi781f11sWUXe6CX49Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9DE606A33B;
	Fri,  6 Nov 2026 15:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B9DE606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLk9163Hpz5B12l;
	Fri, 06 Nov 2026 23:48:05 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6A6FluYY058574;
	Fri, 6 Nov 2026 23:47:56 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 23:48:00 +0800 (CST)
X-Zmail-TransId: 2af96aedf6b032d-952c5
X-Mailer: Zmail v1.0
Message-ID: <20261106234800201ufIhoX2CutYpfR9qcl-9D@zte.com.cn>
In-Reply-To: <20261106234751020Egf42VCVVlsSC_Msov4HO@zte.com.cn>
References: 20261106234751020Egf42VCVVlsSC_Msov4HO@zte.com.cn
Date: Fri, 6 Nov 2026 23:48:00 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDMvNV0gc3BpOiBiY21iY2EtaHNzcGk6IGZpeCBkaXZpc2lvbiBieSB6ZXJvIGZvciBkZXZpY2VzIHdpdGhvdXQgYSBtYXggc3BlZWQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A6FluYY058574
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 06 Nov 2026 23:48:05 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDF6B5.003/4jLk9163Hpz5B12l

From: Shao Mingyin <shao.mingyin@zte.com.cn>

A SPI device whose max_speed_hz is zero (no spi-max-frequency property,
or created through the spidev sysfs new_device interface without a
speed) leaves the transfer speed at zero.  spi_setup() would only clamp
it if host->max_speed_hz was set, which this driver does not do, so
bcmbca_hsspi_set_clk() divides by zero in DIV_ROUND_UP().

On arm64 the division returns zero instead of trapping: the inner
DIV_ROUND_UP() yields zero, which is then used as the divisor of the
outer one, so the clock control register is programmed with a
meaningless value.

Clamp the requested rate to 1 Hz before computing the divider.

Fixes: a38a2233f23b ("spi: bcmbca-hsspi: Add driver for newer HSSPI controller")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

---

diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index 8c01475886e8..84015110557a 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -196,6 +196,9 @@ static void bcmbca_hsspi_set_clk(struct bcmbca_hsspi *bs,
 	unsigned int profile = spi_get_chipselect(spi, 0);
 	u32 reg;
 
+	/* A device with max_speed_hz == 0 must not divide by zero */
+	hz = max_t(int, hz, 1);
+
 	reg = DIV_ROUND_UP(2048, DIV_ROUND_UP(bs->speed_hz, hz));
 	__raw_writel(CLK_CTRL_ACCUM_RST_ON_LOOP | reg,
 		     bs->regs + HSSPI_PROFILE_CLK_CTRL_REG(profile));
