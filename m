Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324907;
	b=aymbTxrDZQx6rl+u8z1OEbaAF+kygr9e5IJ3pT0pjC7iieq4RNFu5/eT2dgUWFx3WT/i
	 ULHflBM9nHnS0o3WTc3DOXD4CM0zPQlI9flHOLZK37rm5rg84551eVeMeRMbq1XHJKv3u
	 e3VxXOrJRLIyldydQSLSKfN7+ITVl30H0i7auW+21QokWw8bvpXhNV7QMLUu+HRGQPyOl
	 pPLQLqawJC0uiCIVbKgX5QPJvQGsni49i7VBcpr316N+Do+unZpHzJnxawXFc8on/ZscZ
	 KbaZgTXOebnUjFsXaAjDy4QlOXte9vYv8renE/BWGAAqtIwsH57/6Or1vUwZCaaor8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324907;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=ESvnSPlhI6d1r8qvxOASwdMGMJowBVvpPLgNpoFimY4=;
	b=T1FZtGc5i9PLJlaiAtl2sDXulk5JdK9a4q3ug3b5H2G02ue+p23OlUUznGYuLreLOdhh
	 lJEOVUU133QlD/mtHbRlgQLgqYKMuuOTRDPMLP9yzDLTSnVzDzSPGMVHL9XCWyvvG4adR
	 e4AM6wg4k7Ur555p89ZKSSfHvNgnVoTLrEWRdz22CRYNAsHwwuXTltgb94eQx1u5ig9KX
	 FH7VGan2SVPjcEjT2vif3isxjsg57JAKBnWKYHQmWpfLJyWiL65uQ0SCZ5BN5JlQgoYYb
	 WXYitjofOYou3M39uLQU4yFpIfAw0K41Fe3je5YazC6dK8rQZw5gdhRUuqTeSw0hZhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=QR2V0ZTJ;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8760A380C;
	Tue, 10 Nov 2026 15:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C8760A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=QR2V0ZTJ
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP9h75NFyz7QqdV;
	Tue, 10 Nov 2026 23:35:03 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794324903;
	bh=wAWlJ6Jio6cctgZYE+NOyPskWIzd0WbXKJemczhN/q0=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=QR2V0ZTJratldbLAMuhSAfXIRnUWHWxpd4/7Y+V2oIKZ7GqfOWGGUDHECBxFtm/44
	 3FHJ10p8hmM1kRmmnUe/k0abb0KdjvhlyvT/No1DCVL5hov+4w0kEGj+8G44U/k6wN
	 bMmhW5Wic91+SqNDSvAtDHD+bmvlMs5SlfQpLOUtfKPnzyXKRHU62vabLTVA/uJnWX
	 xaadSm4XUlcDiWMHaXn09rWoJroAN3nxEOxjOiBUbl/eSeEYIjbSoTePu6EgskMZ7R
	 d8YwLuyW9qH2bh3DpIWsh5WGYElUw9augfTvqMjwgcy/taUatSwrqA7LByNTbnnZrh
	 0o1QQtWnHPfYA==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6AAFYq0c026304;
	Tue, 10 Nov 2026 23:34:52 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:34:56 +0800 (CST)
X-Zmail-TransId: 2af96af339a0e5e-22482
X-Mailer: Zmail v1.0
Message-ID: <20261110233456078X64bfhY1W1EUthj960Svy@zte.com.cn>
In-Reply-To: <20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn>
References: 20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn
Date: Tue, 10 Nov 2026 23:34:56 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvNV0gc3BpOiBzaWZpdmU6IGNsYW1wIHRoZSBjbG9jayBkaXZpZGVyIHRvIHRoZSByZWdpc3RlciByYW5nZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AAFYq0c026304
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 23:35:03 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF339A7.001/4jP9h75NFyz7QqdV

From: Shao Mingyin <shao.mingyin@zte.com.cn>

sifive_spi_prep_transfer() divides by t->speed_hz, which can remain
zero when neither the device nor the controller provides a maximum
speed. For a nonzero but very low speed, masking the divider to 12 bits
can also wrap it to a small value and program a much faster clock.

Use the maximum divider when no speed is supplied, and saturate an
out-of-range divider to the same value. Keep the calculation in an
unsigned long until it has been clamped, so it is not truncated to u32
before the range check.

Fixes: 484a9a68d669 ("spi: sifive: Add driver for the SiFive SPI controller")
Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
v2:
  - use the maximum SCKDIV directly for a zero speed, and saturate an
    excessive divider instead of masking away high bits (Mark Brown)
  - keep the divider wide until after the range check
v1: https://lore.kernel.org/all/20261106234756882V9wUQNCEZAYUGTAbexMSL@zte.com.cn/

Validation on x86-64 with GCC 13 and UBSAN: the verbatim preparation
function ran with clock/register stubs over all representable SCKDIV
values and the first overflow. A zero speed bypassed division and
programmed 0xfff. A 1 Hz request needing divider 4096 programmed 0xfff
instead of wrapping to zero; a divider exceeding u32 also saturated.
In-range requests retained their original register values.

 drivers/spi/spi-sifive.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index cee4d92e46f437319fa40f6377e5511e692d12c7..ca7b04520a682c3fffb070169ab0e3c485e323de 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -167,12 +167,15 @@ static int
 sifive_spi_prep_transfer(struct sifive_spi *spi, struct spi_device *device,
 			 struct spi_transfer *t)
 {
+	unsigned long div = SIFIVE_SPI_SCKDIV_DIV_MASK;
 	u32 cr;
 	unsigned int mode;
 
-	/* Calculate and program the clock rate */
-	cr = DIV_ROUND_UP(clk_get_rate(spi->clk) >> 1, t->speed_hz) - 1;
-	cr &= SIFIVE_SPI_SCKDIV_DIV_MASK;
+	/* Use the slowest clock if no speed is specified. */
+	if (t->speed_hz)
+		div = DIV_ROUND_UP(clk_get_rate(spi->clk) >> 1,
+				   t->speed_hz) - 1;
+	cr = min_t(unsigned long, div, SIFIVE_SPI_SCKDIV_DIV_MASK);
 	sifive_spi_write(spi, SIFIVE_SPI_REG_SCKDIV, cr);
 
 	mode = max_t(unsigned int, t->rx_nbits, t->tx_nbits);
