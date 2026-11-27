Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795748144;
	b=MEwF8vDlN/ta//tOp4dXLhNt5gcq5ASKgvxGDbZ9NYDAgvdOhqRGkknxXsOx90LK9uU4
	 XhIPMdKJomOdbj550dk7MEcErx3NynJ/L357QPLgwBe2QBFjFr5CZ8TcqjQLRu1xStEFm
	 oZnpADHCOGJp+CNU6Fsea6tR+dpI+50GBBZUzHrcd8g9JsogEsxl34p9fDdcpteXCK0HE
	 lpCc5irLF+bukooP+ltEtjHyrIyuv6hqi+HkjOGG/hXMO/XpUwq/88pTcEjFxoPB3cExw
	 TVdvBt6mxVcmU3IHDOe4JxV1vNOQTAGlv/tow2a9EO+kwFe05ZD5Q9NTnHdMoxh9+mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748144;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dn6Ire02f1+vVi/qeWD2sYadl/ZWdpVhAw3V5v5WUkc=;
	b=vJ1+1uS48Q8SURNnCKQDcMfO9dUaWZW+AghObI2do54wsqGhMmWYAECXVMzbdUFZjmWq
	 jl0n4uwlI5MmvzaiH9kYN18QjJgZkovaO252/Q9MEphoGykpWs7IT4EGarwjfsQ9MIzPK
	 dv1655vvef5B9HgkP44E18FN2H23LKmIsMQRjnf8lS1Mk/wZW4dHnV3tQ4d+rVEmIf+DO
	 YSf11hM3yzSI5jP86pvvwtE54fnHd+h7Pe12P2LBXMcApluH0E8Trjqo8abM3DibnwN3b
	 hFo4FgNmjxhQ2070UnI7amfOw7QJTADut3Sd3wzNUT5onMijmY+36+zW6/uxPhcN04Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0Pvvnu9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84E606A321
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0Pvvnu9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795748144;
	b=nE4X1rop9qv2JxPWWxeIPiZM/r2uiaFUfaU8QoHy3TJtewby3+NeB8BGL2piPCMyYqjo
	 JTXfjAFpGfqsvrrdS9QhKkR0q6NgHkNlEJONNKjKf9W+eYgkALA19vNEr1C09uG3vo9Ow
	 Sw8QHqPTAXgpqr7nbSo1VmkaF4ubEzukTD59v5xtJqWReKwkE3l2LNAWI7OpSPxqp1Sln
	 Ny6NTDRg6Sg/ptS/0PWQEraxZG2beO98+XuvRPnwUTP0gcf7ac9E5sQXrzlerksYx9Klk
	 jZ3TdmwyBXp86MK+q3jt5IDeINVpTVOs2o6L3A8ch0QZT9UN8CRqzyIQeegar5FCxrw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795748144;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=dn6Ire02f1+vVi/qeWD2sYadl/ZWdpVhAw3V5v5WUkc=;
	b=UUxRPah1aXvJ1GvTGtZNCQtTEDfGP3nYCfQz5hv9nsQyU7O6kX7/jUofM0A+8ku67bJK
	 gzqbpe+SnbhGjrXYgIwXtj/4zFb7/lqFjShgdyblSj3o6JgtLGWop1kVt7XenkTlHWkgk
	 WccFcHPeBuy9ZZnglk16KSkct6MePJ5VWI8ZaEN+/wYHaJJmQXJzAqT5V6iDAAGkp0p6o
	 RTX5h9bbU70oyQNvfWvkxrXIo143+3phBaujRrDBKwXINhVpDWPpPYhmR2isW99dhJEBO
	 hFxcbSfb3ydamOdcmsO0rj2zYEoa8LaZL6Za/NCMx3pfcXUXhVSCKU74tHx+5UCP1iA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 58BF41F000C1;
	Fri, 27 Nov 2026 02:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795748144;
	bh=dn6Ire02f1+vVi/qeWD2sYadl/ZWdpVhAw3V5v5WUkc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=j0Pvvnu9rT1KhGGUv/fgvGFV5bVfeOFvV0d2SRzPKncqrFg7RyLfe8+Y1cuQUaT+n
	 yW0uf4kRunldFtmbugZWODGrLvBRQnOMzqXhFoPD/O1L9VUPPFv18bmw1VYi6TyeyY
	 VKC33CypQW4C/+eXaPmWd1bSwZiVI65gwDIqsAnZuH6to10n2DZJtBHVu/jBhzyloO
	 t5I4yc34PSJS9NhP3Rr0c1eltDjNLLIHudNWrWMdCpOIH/xq33Q5R3tm/G4XKgWzTN
	 9uZ2LdjGByHa+UlS++cMFbso0x4gRUmI0zktdp/VoEL5tc8olalvJwKeqYuuuN/X0w
	 g1g8rKOqSH4eQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E06ED4B50B;
	Fri, 27 Nov 2026 02:55:40 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Fri, 27 Nov 2026 04:55:38 +0200
Subject: [PATCH] spi: meson-spifc: round the clock divider up
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-b4-meson-spifc-div-round-up-v1-1-e927ca0d0c8a@iav.lv>
X-B4-Tracking: v=1; b=H4sIACnxCGsC/x3MQQqAIBAAwK/EnltIicS+Eh1Mt9pDKi5FEP096
 TiXeUCoMAmMzQOFLhZOsUK1DfjdxY2QQzXoTg9KaYNLjwdJiiiZV4+BLyzpjAHPjC4s1nhlh84
 R1CEXWvn+92l+3w8UV6PabQAAAA==
To: Mark Brown <broonie@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2042; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=Rt0Bq6tvIo11qsWLzpWdcysvdzpavIURklDKm0ZG7KU=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNkcH7Vn5T2fc+jIndtfvNcseRUx354tb1oeZ5dpHstfM
 cvUvyv+dZSyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJ3K5kZNg+NfdMdEWT65lc
 ZiaJbFbjb/21h177BqY8Fr0zp7CQ8yrD/9Czqnc+pD//5+elwOx9LngOq7jkBfPFr1LKNeK2/E/
 8xQgA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

meson_spifc_setup_speed() computes the divider as parent / speed - 1,
which rounds the divisor down and makes SCLK faster than requested.
On ODROID-N2+ (clk81 222.2 MHz) a 104 MHz spi-max-frequency gives
n = 1 and SCLK = 111.1 MHz.

Round the divisor up so SCLK does not exceed the requested rate, and
round min_speed_hz and max_speed_hz up to match: with an odd parent
rate, rate >> 1 would need n = 2 instead of 1, and rate >> 6 would
need n = 64, which does not fit the 6-bit divider field.

Fixes: c3e4bc5434d2 ("spi: meson: Add support for Amlogic Meson SPIFC")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on ODROID-N2+ with the patch on 7.3.6: for 104 MHz REG_CLOCK
goes from 0x1001 to 0x2002 (SCLK 111 -> 74 MHz). The board's
MX25U6435F read with READ (03h) misread 36 of 50 4 KiB blocks before,
0 of 200 after.
---
 drivers/spi/spi-meson-spifc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 1580797f4a84..865440793a8b 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -168,7 +168,7 @@ static void meson_spifc_setup_speed(struct meson_spifc *spifc, u32 speed)
 	int n;
 
 	parent = clk_get_rate(spifc->clk);
-	n = max_t(int, parent / speed - 1, 1);
+	n = max_t(int, DIV_ROUND_UP(parent, speed) - 1, 1);
 
 	dev_dbg(spifc->dev, "parent %lu, speed %u, n %d\n", parent,
 		speed, n);
@@ -320,8 +320,8 @@ static int meson_spifc_probe(struct platform_device *pdev)
 	host->bits_per_word_mask = SPI_BPW_MASK(8);
 	host->auto_runtime_pm = true;
 	host->transfer_one = meson_spifc_transfer_one;
-	host->min_speed_hz = rate >> 6;
-	host->max_speed_hz = rate >> 1;
+	host->min_speed_hz = DIV_ROUND_UP(rate, 64);
+	host->max_speed_hz = DIV_ROUND_UP(rate, 2);
 
 	meson_spifc_hw_init(spifc);
 

---
base-commit: 63083539d2bf955ccf84042d4b044d1133752bed
change-id: 20261127-b4-meson-spifc-div-round-up-adb97c1960ae

Best regards,
-- 
Igor Velkov <iav@iav.lv>


