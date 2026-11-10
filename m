Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322676;
	b=cA21jOm2igFxcEykE7KoZd0MVuyApK/GJXk+YMoDe0BdP59gHF92QhFHa5HlYagPmGfe
	 qnhL8tAYH8Mcojw5ea5mUd2DcehTDbjpyVrTmHmTTZL1EAR251yz0U7CeMQNojYnqQRaB
	 tBFVnNt094XKIUT81JF9WIiMwMkzrQwIrQo7MAoRixFySI8DyeZ5iyCPYHVHpphFIE+l2
	 Y5NasMN5DOnHIdGpNQ6yd4kv49Hr9f+1iEPLeFWjsESBcdaPGfGz2jZp4C/2OwMgL3NWb
	 m+fS5qQfdkTsoSy9POtyYsZqggmggdHtUZGC43uPZVJT189mxrAdeBrbOPvcikMKgaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322676;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=Wnl3KD1B2sQrL3NWX/pTpwnXflH+rWTeS8tnM3XFXNg=;
	b=ogp7mhiSNUMa27xI3jivT3tl5CZqwDUpvmUaR3OOTEGOO0GEKS8H4KHSwXxTns76G9T1
	 NnwSNVRwEfFSw3r9y4Doqv1TDTj9WTFVlOAWFHsG3ebLRkYPDRzYAQHxtku0YjkjnPSQ/
	 ojw3G7I8ipL8x1S9JiUskSEKusIONgwKwlQzWXUohiWXtSTWLuc34vTek32z61ZJGfBEI
	 fwTpk4v2UcMnqOV/ipJNgclvcvtLkLrjlKVNjr/sBgRYyAQR5KxUJXjS9F2H1a0h2cdEn
	 GcvmDhZILZ6DKhldVT2R+94HAxDIpMh5QarvwQFlXk/Nfam017uXru8SXzAMwF5xchw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="f4QB4h7/";
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930660A2603;
	Tue, 10 Nov 2026 14:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E930660A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=f4QB4h7/
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jP8s03SYJz57HS4;
	Tue, 10 Nov 2026 22:57:40 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322660;
	bh=dqn1Jn0ErHB9uH7HxkRYY60ypmSrxKKbjunp47DpHy4=;
	h=Date:From:To:Cc:Subject;
	b=f4QB4h7/bBxOaZXy4RRZ9CqpyvvG297hfMUEd/oG0oL1vR358k34wTwIkY5YAXvl2
	 95sz63C/oli27FLOi57ErEIMrfZyavuJzXAYr+W8cdk42+omq0SP3nk3RHzuTDhwuA
	 PmuGWqzKOZCXTxLgGTbdjueuWh6jWcPkYkXbDRsagnokloGzElRq5igCiNEGOgQ+II
	 VtbCpJut6n3adQ/2IAnIGJbGPyTIb7dAximdvsTIDXCwNx8ZOifwcmM3klZoBIBijj
	 HYdFDkKNqxAO1uldmxDUyupw918hnIx08HAa/Fg+KdpBJWKFq842niDJ+vhEgp3Tra
	 Ywv/7xPxhsqog==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6AAEvcma005940;
	Tue, 10 Nov 2026 22:57:38 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 22:57:41 +0800 (CST)
X-Zmail-TransId: 2af96af330e5ccb-fc314
X-Mailer: Zmail v1.0
Message-ID: <20261110225741763HzyrdGiR7ZOAU1NiFmCCZ@zte.com.cn>
Date: Tue, 10 Nov 2026 22:57:41 +0800 (CST)
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
        <pjw@kernel.org>, <samuel.holland@sifive.com>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBzcGk6IHNpZml2ZTogY2xhbXAgdGhlIGNsb2NrIGRpdmlkZXIgdG8gdGhlIHJlZ2lzdGVyIHJhbmdl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AAEvcma005940
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 22:57:40 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF330E4.000/4jP8s03SYJz57HS4

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
This patch supersedes 1/5 of the v1 series; 2/5, 3/5 and 4/5 are
unchanged, and 5/5 is posted separately.

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
