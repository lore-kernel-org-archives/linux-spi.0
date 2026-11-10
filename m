Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322669;
	b=3Uo87eFMHRD3d5rzHT9nT3hr/HBKWK6cd2LMA0jRxngI8XhTMqK3nne5l5YRPaZKZGSH
	 JuRPyR+MlWdjgsZW91YBNPVWoxXNiG0UbegMRikJGBopTyuANEjqkoP3dbbJuWyBjf6P8
	 6MDP+g5HNGYetygfzTc2yHF1wy9D7uYSgYWGp2w+Tg1peuKiu+LxJbDglNE9fxzASPeyW
	 YD2fxTwldf0/doUZZ9rau2W/6BMFN6zjn8IPiR3xoKb2kuqxPg6q5KdY3hFYPG7n56aiL
	 HI1yrVPATiKqc1plsoXNOcX1K4QaFUMCuslU0CgVt4sUM5Sb9WkqDwoQhwtQtDacilQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322669;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=5r4t6QrAUP1J3ygaG1uqm3B+iaB0VTP6veZu1UrZo0o=;
	b=3K2lGXmRLJQQNIve0wCa9wtDDVVbZD5i0h/QnNHKz7DDQ7g5Alv/CvYh9l+158/THyGr
	 6gSaYMIElYFZJbABjFE66NqMrFKBYIJ9LVCV6T5V8pLuMPiyUkrZj41P2OrO1e55L6Uvc
	 V8KxIXV7dGkePHZ3HAqAuWwfPDIWWkhmCCXe+SvWmzEFbKJaha0UyGiCdbcFfwlRHCeCT
	 AK1XzERYG/8/857fwJp1YxP5uLJ4rVL/BGANAX/DW4h6zOWlGJ/sSny2BJyRo8C0QOxju
	 MPG3hE0hssGi5YaB35GbHN/2bO9LZjLEKs9jY7bpVHGudoUMy2zMlMk65vx6kU+thvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=eNsQ+uEj;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DC9606A33B;
	Tue, 10 Nov 2026 14:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26DC9606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=eNsQ+uEj
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP8s50MvYz8XrrJ;
	Tue, 10 Nov 2026 22:57:45 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322665;
	bh=fxZvD40wCka3RIRc9neoBbabkTYuYltGezERWwCEB44=;
	h=Date:From:To:Cc:Subject;
	b=eNsQ+uEjYdr5pfdM0kmpDBpJelZip/ooDIL/RDYvvATk5abHoKJQE+ihOrne0KZGb
	 uNgwn3KDoki2IJXDxcqPRrlEyN+Ws75JBph8C+yN5B/Z6Z1ZL/U3wSh3JPEV0QAz2d
	 wNmW3aDzwpbW9zlxqDAfCGDrCBG5zYRx/9m1Gz2x+BWoJjAh8hOvJ2jqYZ6bvp/hB3
	 r1pxc+A+KZyMBe/BS/uy5pGVn/3za5ItWTkw5QzSbFxuoJVRyRvglig41tnWIXYNWJ
	 PtUFK26sUJDAM7f+9B+Bo5wXFV9DZPZY6CtA/jmcfxA9jOugwW1ZzAh/1UhSc8Rsm9
	 woeLRh5jwWoNA==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AAEvc0L005941;
	Tue, 10 Nov 2026 22:57:38 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 22:57:42 +0800 (CST)
X-Zmail-TransId: 2afa6af330e63b0-179de
X-Mailer: Zmail v1.0
Message-ID: <20261110225742093XH08EkNNnrDUM6Azn-oCM@zte.com.cn>
Date: Tue, 10 Nov 2026 22:57:42 +0800 (CST)
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
Cc: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <ryan.wanner@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBzcGk6IGF0bWVsOiB1c2UgdGhlIG1heGltdW0gZGl2aWRlciBmb3IgYW4gdW5zcGVjaWZpZWQgc3BlZWQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AAEvc0L005941
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 22:57:45 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF330E9.000/4jP8s50MvYz8XrrJ

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
This patch supersedes 5/5 of the v1 series; 2/5, 3/5 and 4/5 are
unchanged, and 1/5 is posted separately.

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
