Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324908;
	b=4L0mGSUnta4AFEYDlo+Qyg5VRvINyulLwuFcB/cfepmBy053BlnjnyDFFGblSy2ZNPVh
	 r/R8VST5DbKmOIh5Mq804SOh5f4Y9AMIvVspZ0mtAsLIfSetMDZSQ9uHf1IkcL/DaVZ0e
	 Dhmhbim0ya3oCdwNnXAjFYxTwSkYiJRjTsgtjbRMqb2Sjc44Z4k6dNLDy1FPIZbsEuVjp
	 MLoXjX6CQiVVoaDdzu6Taa2SIESMTMs4mM7YVr5d41i6rJ7iDkxGdlvYyZ7I4nZCsIQwT
	 INtgF0lu+4Dr1YvceWWhOD1llcBwa29Yh+7xSdDU6PFgNCJ/HXrF478ZRAFlX+ANL5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324908;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=ayUZrHPtgAcHc+0mRQFYPo9FqMxMF0x0I2geL/esqpQ=;
	b=ZIObLirM13AjbWoG9ZF5ZxZ2YinckUt36AtWP8IOw2X0gT2q4BTFsQEccRnPzwG4iR/w
	 QOPYxj/J4jrsNPB29aPTfvM1YZrKlXo6Px6RQtTC5ZN6d+Ne4EcE1eEcswY50/A64MgC4
	 BJnfW9aTX/fqMvIfi0fmWaOO8VcyVuSz6bno2cTP6c9rpIXLeamuJT/pZFn52XflNbtTF
	 IRHOwItpi0HGBKLgSHfL5iv5NExLHA7tn9QuV/l2orzRgFFFzKNX1Tg+/MbeLes8NEcgj
	 BLedvhtHGBxCUz1wBCYm4mYifrFpmhZ9bjgdIldGn2187wu28sfQ2wk+cHnExMZP1pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=nv19DY8M;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5BD60A2606;
	Tue, 10 Nov 2026 15:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C5BD60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=nv19DY8M
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP9hB47K2z6FK1k;
	Tue, 10 Nov 2026 23:35:06 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794324906;
	bh=2zeJZwiD9yu0+B+pRLIcxWVCQ/GI8BQOlaQgqT/leTo=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=nv19DY8MljQocFN4vyiWRTqOETh8IUJT1aMtsFi0v1dIXKTjhZLoUN0MKNSTuEgAF
	 FF1ORcb75CqsTi+bZRYK3VajKPwW+R9AVV3J2Em/pwtUB51xm9bOID9LHSIp9MUMOb
	 JZPC6wzMUwrr3EXrl1UBxrPrRrVBU0OUjldk0Bu1ue0bDtLMwv1HVMuNc7TyP7PtS6
	 yGveQ9s+LvZb3zn6OkQ6HFIRZ/4LBX+6KbBQLVHGwNG5UE7DIrKCtii4Sy51+pbV1Y
	 NgXlYht9f2mxcNjdKPgIbyuTISwotPLK34MHHwuaHz02DUfrYIA+5KByHJ1jMQ3fS5
	 o7kV2zvr9s4fQ==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6AAFYt2v047673;
	Tue, 10 Nov 2026 23:34:55 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:34:59 +0800 (CST)
X-Zmail-TransId: 2af96af339a3f4c-22570
X-Mailer: Zmail v1.0
Message-ID: <20261110233459277eFsXn1VXUPZl1EA9CCa5Q@zte.com.cn>
In-Reply-To: <20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn>
References: 20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn
Date: Tue, 10 Nov 2026 23:34:59 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDMvNV0gc3BpOiBiY21iY2EtaHNzcGk6IGZpeCBkaXZpc2lvbiBieSB6ZXJvIGZvciBkZXZpY2VzIHdpdGhvdXQgYSBtYXggc3BlZWQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AAFYt2v047673
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 23:35:06 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF339AA.000/4jP9hB47K2z6FK1k

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
