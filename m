Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324906;
	b=uQEGFPf4OC621BStw01efJcgeOhoggLLJrmZEM+CJarQLb+IYLDdZnNxBXaQSDoshQNc
	 d8yM2t0OvQhvKxvsZjE6YQ6RDjLslyWShY7m5Y1qJe6A7FBtzwdiuGxCcSvN++zZMJgTc
	 1UX6Mf5rkV0SE8GNPNnve9NEkFdbz/33dyxRgA4r+mo6Z1AolRj3Vb9AOENxLpwFmn3Nf
	 1xAw96gBjMIc/Iahn/nsTUBqNX1UZSdCuEw6Ba23ofRHNBmcbu/ErzEvGhAaMbK/EzJxf
	 Ab69XHCUr+GJCON1tOu30c01G6yQh23ONm6Lh6/r7zBDmtjpwqzIZEB85UvM3PSxa6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324906;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=BAgeKz0Vili1SlZs1hB8WmyCeJ9ALq7iJrhVHBw1A0Q=;
	b=p6v37BaclLI0i2KBpWnoXFQbtriCLo3GXC9ojlt1kcv1qaRq+NrqZGSv0SX+ZPDZUtBx
	 NmkE40XWuB0Q/5XbafyV5ThvB9656rigawcWngAMVFgdPNj1tmsZjrtfukFsL49fwMhSL
	 8xd71eNDpNerFSdqHOu+p+Eo9J/FMto2GRH8679i0kUbm+FYH3MxFk3TdkHBlWkV6KbSW
	 1fPF/7vsADlCR/EwYbDFWgdoDuIP7qVJ6BSzv3YDGRXz8sw25w4m74PNnJ3glxnYyKhOt
	 4NHvaYelqaw48Qa0qDpXkWmMgShaqY3l2Qeke8wpEnAtln27wUbd1HdC+vCt/FTaQRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=L1p7jFG9;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B160A380E;
	Tue, 10 Nov 2026 15:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 688B160A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=L1p7jFG9
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP9h74gySz5BNS0;
	Tue, 10 Nov 2026 23:35:03 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794324903;
	bh=EYTwQOsdl0aB3bqysjwOQaySDUmO5ccFK2+VSZRfMtQ=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=L1p7jFG9E6b2ppRx/rf/YBAcxSdrhnmOgfG4c1e1RzG+YlNVvvRe0NjqT8BTJXhyU
	 4daIuN50hSk1q16zZFuzMsDVWpDGMZZyCxzrP4tzcLKX1QNRbTtlzqpaDe8BvMeBN4
	 CHsr7RDQP6v+dBFF7LSl86O8hpen8Ac/Q97d2pN/Uz19r9bnAwxI4ILFc70pSuBsmR
	 ZDjDrvwR8DTMVWZ+k4n+0FxxoYCfWTR/x5faIfOB4GnjwMdgQjGAv7RgsEsj7XhlDj
	 C/x/9cx5T6ebMqTdgURFMgLk/esRazonp+ixEjxc1NEcPFTsSIdELOYaZRjUjrJfif
	 vt+bcRAmxZbOA==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AAFYsNh047661;
	Tue, 10 Nov 2026 23:34:54 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:34:57 +0800 (CST)
X-Zmail-TransId: 2afc6af339a1a57-2207b
X-Mailer: Zmail v1.0
Message-ID: <2026111023345770952YKePAJQKAcd2Kxe5M3N@zte.com.cn>
In-Reply-To: <20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn>
References: 20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn
Date: Tue, 10 Nov 2026 23:34:57 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvNV0gc3BpOiBiY202M3h4LWhzc3BpOiBmaXggZGl2aXNpb24gYnkgemVybyBmb3IgZGV2aWNlcyB3aXRob3V0IGEgbWF4IHNwZWVk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AAFYsNh047661
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 23:35:03 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF339A7.000/4jP9h74gySz5BNS0

From: Shao Mingyin <shao.mingyin@zte.com.cn>

A SPI device whose max_speed_hz is zero (no spi-max-frequency property,
or created through the spidev sysfs new_device interface without a
speed) leaves the transfer speed at zero.  spi_setup() would only clamp
it if host->max_speed_hz was set, which this driver does not do, so
bcm63xx_hsspi_set_clk() divides by zero in DIV_ROUND_UP().

The division does not trap on MIPS or arm64.  The quotient is undefined
or zero, so the clock control register is programmed with a meaningless
value.

Clamp the requested rate to 1 Hz before computing the divider.

Fixes: 142168eba9dc ("spi: bcm63xx-hsspi: add bcm63xx HSSPI driver")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

---

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index abfbf97faf7b..319951fba387 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -469,6 +469,9 @@ static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
 	unsigned int profile = spi_get_chipselect(spi, 0);
 	u32 reg;
 
+	/* A device with max_speed_hz == 0 must not divide by zero */
+	hz = max_t(int, hz, 1);
+
 	reg = DIV_ROUND_UP(2048, DIV_ROUND_UP(bs->speed_hz, hz));
 	__raw_writel(CLK_CTRL_ACCUM_RST_ON_LOOP | reg,
 		     bs->regs + HSSPI_PROFILE_CLK_CTRL_REG(profile));
