Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324911;
	b=iam5jVExaxUQCpg7CPo7y3uCnSLX2oSmouvBBk/8jpxtRKxvtSarD0nCugl/D8qZSyCl
	 pqbn5yl+Awqtfw5x+0zOB/IijtnIynL6eXkijW8t2Ww4o4BKjyPXzwQaCyA8b4dnDzmaU
	 /erEEZmP6eJ78fdTomghPHZgUKn8BsMmGvbGWKBGle0pbx94nS83FCEmvUibthM1KsBt8
	 hXmJhnglQA37R6kkh9OgNkguz755IeD5sjbJKxwrFKPrV42G3k9pr665Lwx3BM0WeDrTj
	 //GTlf+tBHsfuLiOB8otPCJA2TMRSLur9tGbbhxm9+GmGjgKA4ZlAENw+nrob2dmYww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324911;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=zho6bsM+TfME0Pp2+8lLvIpvzVI3LONdQiWunYWEwck=;
	b=Bx6LMyDDeJDCATnspQN1KUBGtkKSRfov3Gyod0/udyOF8RZj/bwk5hSFKyXzftc/dlYX
	 VKbuOmoQKZjCw+ysjxfifA+aukjFPc6MgDQ8Pj2d2lyURFDvA8CfMmrvyMPtvgeYHPQLp
	 Vv0rjs/0UJGrGSfx4HOqbEWnnSXVHucN9KtgvC/DrBpVNA160/zkAKl/hv38hbhegpX0u
	 DbLEELU1X7FkLky92Albv5r4tiq1gAwLyfRdbn8sKBc4PHceQYQA4NRcm3qMyDmaWyfro
	 h+0yJGIvtdppfbCEQYFyNE764x5o83ZbMsIL2z7o0v0BqENY42x4otA5mFsev1i6DpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="j3p/3kJd";
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621660A3823;
	Tue, 10 Nov 2026 15:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4621660A3823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=j3p/3kJd
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jP9h92grXz57HS9;
	Tue, 10 Nov 2026 23:35:05 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794324905;
	bh=oRLho79KieyE2VMKbYYhENUlkEN5V852+HAhpxS1D2A=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=j3p/3kJdFHUG0iuXprN/iESfWpGJaWNiilkc59lUyWHncFLPYxq1s2hsP24lU0sB0
	 Q6mepvq+83quKfN9MqEkmnfyUAGwMKhmoxrGdrXZv+0tz1VMtUbcmKNT+cIS2KUyum
	 cx4TXXwrPR8TvMXQFW1wpEgASZmcMhL4Bd2Al30U2EVBQxBid1xC13Tc1dBDPbSwne
	 NDbFpaFxKEb4DJdWBy6IqHYB0OIgP6E//WegtgwOCHDBciVVfsHxHqv9axyeX4fx8m
	 S74iiEotk1L9sqopddtFdxqaU1O9gBMycv5eq2jdLan8BQZn2vHgL7o4p0FETTi965
	 ugG8oUZnTfvzg==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6AAFZ0JX026510;
	Tue, 10 Nov 2026 23:35:00 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:35:02 +0800 (CST)
X-Zmail-TransId: 2af96af339a602d-22650
X-Mailer: Zmail v1.0
Message-ID: <20261110233502434XJBDWHTKR8EhK_xG0sf4m@zte.com.cn>
In-Reply-To: <20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn>
References: 20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn
Date: Tue, 10 Nov 2026 23:35:02 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDUvNV0gc3BpOiBhdG1lbDogdXNlIHRoZSBtYXhpbXVtIGRpdmlkZXIgZm9yIGFuIHVuc3BlY2lmaWVkIHNwZWVk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AAFZ0JX026510
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 23:35:05 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF339A9.000/4jP9h92grXz57HS9

From: Shao Mingyin <shao.mingyin@zte.com.cn>

atmel_spi_set_xfer_speed() divides by xfer->speed_hz. That speed can
remain zero when neither the device nor the controller supplies a
maximum, allowing a transfer to reach the divider calculation with a
zero divisor.

Select the maximum SCBR value directly when the speed is zero. This
avoids both the division and an out-of-range divider that would be
rejected by the subsequent validation. Keep the existing range checks
for explicitly requested speeds.

Fixes: d3b72c7e6bf3 ("spi: atmel: add support for changing message transfer speed")
Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
v2:
  - select SCBR=255 directly for a zero speed, avoiding the division
    and the subsequent rejection of an out-of-range divider (Mark Brown)
  - preserve the range checks for nonzero requested speeds
v1: https://lore.kernel.org/all/20261106234803459Z94udUX-Ai29-OfBFRND6@zte.com.cn/

Validation on x86-64 with GCC 13 and UBSAN: the verbatim speed-setting
function ran with clock/register stubs for v1/v2 controllers and native
or GPIO chip selects. Zero speed bypassed division, programmed SCBR=255
and set effective_speed_hz. Nonzero speeds retained the existing
SCBR=0 and SCBR>=256 rejections and the valid-divider register values.

 drivers/spi/spi-atmel.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ffc896e4621acf2f2abfd33981904fae40b08ff5..333423b3111f8b04fbb314da659fc4ac99a390fa 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -923,7 +923,10 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
 	 * Calculate the lowest divider that satisfies the
 	 * constraint, assuming div32/fdiv/mbz == 0.
 	 */
-	scbr = DIV_ROUND_UP(bus_hz, xfer->speed_hz);
+	if (xfer->speed_hz)
+		scbr = DIV_ROUND_UP(bus_hz, xfer->speed_hz);
+	else
+		scbr = (1 << SPI_SCBR_SIZE) - 1;
 
 	/*
 	 * If the resulting divider doesn't fit into the
