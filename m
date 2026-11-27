Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795747804;
	b=rCHlR5zRnNy0P7mRQuKOP7WzuveMDP0tGxbDqddqUGAv3UaPgIriigkvoUOCwRDi8ilD
	 YDmRS5jF0gEdXz7wP8V/DjW2Quic0gNI+ikX+iDD8hvovHY4qPm89RJg53pIvhOoc0jdP
	 4yjdKFG8bclL1TmAXGvrcSv5D6C+AbxXTxUMFRTWq3LKts0T8jpMBkzGqQc0HaMjWAJ8J
	 QlrSNW9HLEv4ZbYGm0MqIsH7Mo1ZHU3vEzUofwzBfFjy+CxCUqsrKaYIP8aT3bS4ozofO
	 YYIuP1UKSHiAQDOQPJmZrhMlw+OwNcd7PEpoUMCtWQPh4dDWcTUy6T/6rNT0u13Kn9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795747804;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=2X8lINQUPwlfkcaoAYlh4FWfsAegOZJi9VEYSrxjRA8=;
	b=OvfGbzSbqnZnEq4tOyhV/KcV40KGc0RSO3kUx7XFsqSrjQWdmlYhDrQ6CQ9Q31aeUh91
	 QNYY2swKEcYU0I7KAVxo7/yoZKD5rqZC18oNM5vh0K2uVhW3OOh8BDElfQgoDwYNEeiwt
	 e7KSkoBYzjVNG7EJasJea5E6RohzY0rk+00YKNXgVZyMv1PnDQpOWLtfmK+qu7DsgJ5jg
	 N4ssKHUBHY5ECWAhirCl2aawEHWXIs66eByZKPUSY/UAo5zRDr3mIi7Mp3OuYakDuf9H8
	 mSv+RyVA8GwD9VxwdVmWAl5imsTIBNWZI73q5huegiWTtg+l8ikA7NfxKiEr+6p30YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwEoHput;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB5606A32E;
	Fri, 27 Nov 2026 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwEoHput
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795747803;
	b=l4GUq02r983sILgWP3Qk6zWpUqMuBdT5m/lE00J+MUfgP5uJGOWSV4DNQKU5PgugecbO
	 EsL14eht8yojZdTgu/7PlZlAMfR+wJKlRedbbUI1hSm+hm1T510vdgaC/13P8sMy2p7zv
	 1oeOG39SbVExgRlsSrX7yIl3C5h2devwdes8B36ldMbD9aB/GBdJpPZNxWxSG5EIx3Ji2
	 Yl8Vhc4WwPExEacpCekJwsp2OC8qObkRqJh8mlPmWF2Dezys78YJnV7hE4O6Fk/Cau/6V
	 1OaA1TDtautWBS8XgqjLNTvDfO0BrGxhdoRx0MnIjxLFXC1FrRiGpHfMV+FAW7jHV+Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795747803;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=2X8lINQUPwlfkcaoAYlh4FWfsAegOZJi9VEYSrxjRA8=;
	b=ASN2iZ8pk1DtSdaEA4E3ODG9zTn+APBmCDxF7F8Vp8Lmb2ZWfKxNcSC6oq1pevIIUGvK
	 nXPyORIs4CdXJhwNGeIsGWFqo92hoeXw4BFVYl7IbQyHp/75qNUSRBkkFRso2J+MpisMO
	 vgUKDeLWucE31f6ipEbuN8M2HHrLe/sd0P8G5XkNx6DbU16BPvc5uijys0G2q0CAo9/u1
	 kpXtSFEXGLv09lkTJDNKcZaY414ApYhT34GYd5DRblmTOTWVUVz/1tIVvax92ln3rai1l
	 +Hn0AJCBwkP0zfs7YvztKenKai4dByJZAZLVBchcjriNAMGmCDnmqUJ3XIgx0wj1v/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3197B1F000C1;
	Fri, 27 Nov 2026 02:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795747803;
	bh=2X8lINQUPwlfkcaoAYlh4FWfsAegOZJi9VEYSrxjRA8=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=PwEoHputZUrSoC/suScLk4e3ZgactoXgmM5L4ZN/dpEaUQpia4t/2pl42xJr009Cc
	 MyoGcFnu3r/r0d7+yKQUxFqt1pMMXKdhRkYZZU+7xi/OrTEKJh7zDFNgfHuw6LgFIh
	 zxb/30rZLa/3BvEDR1e6/k+ALKdiutaQKkk2Oa6cGT6++9IRVeySCfvZ25VBM+NXSi
	 q5UvKn4xD3gqnpWzRL2zDSyPaCzfygx2XnCoiMhPbSu0J7gV5r6X5CU93ge2vrB97G
	 DBFlAHFNS4FQUBWheNcrXgeJNkg3DTdRydl/Os2PnTvXAo/WnYuC+jlzIp+AYx+zae
	 TuAFNHmnc5V9w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A40424B4DA;
	Fri, 27 Nov 2026 02:49:59 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: broonie@kernel.org
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 Roman Vivchar <rva333@protonmail.com>, linux-spi@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: mt65xx: set host->max_speed_hz in probe
Date: Fri, 27 Nov 2026 02:49:58 +0000
Message-Id: <20261127024958.8686-1-iasnezhkov@gmail.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795747798; l=2087;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=BHEc+LMfLY+B72htL0cr2zKEFVE9SAYFoEO0zNM8fBc=;
 b=DBC5DI8rLzSjNB7e94V8D1QT17kFycbLd5NUg1CceltKs4S3ZJvIEDGJUjybmYKQNV8H70PKs
 Ypvz0G2lGCzDQsCq6+T5dew+szLokLaPehr+AAD1u1rH0Ynt2fNyw5X
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com
Content-Transfer-Encoding: 7bit

From: Ilia Snezhkov <iasnezhkov@gmail.com>

spi-mt65xx leaves host->max_speed_hz unset (0). When a client device
omits spi-max-frequency in DT, spi_setup() keeps spi->max_speed_hz == 0,
and transfers or spi-mem ops without an explicit speed reach
mtk_spi_prepare_transfer() with speed_hz == 0 and mtk_spi_transfer_wait()
with mem->spi->max_speed_hz == 0, causing division by zero in both
DIV_ROUND_UP(mdata->spi_clk_hz, speed_hz) and
div_u64(ms, mem->spi->max_speed_hz).

Validate that spi_clk_hz is at least 2 Hz and set host->max_speed_hz to
mdata->spi_clk_hz / 2 (the controller's maximum SCK rate at div = 1,
sck_time = 1) so the SPI core populates spi->max_speed_hz,
xfer->speed_hz, and op->max_freq for all transfer paths.

Fixes: a568231f4632 ("spi: mediatek: Add spi bus for Mediatek MT8173")
Suggested-by: Roman Vivchar <rva333@protonmail.com>
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
Changes in v2:
- Set host->max_speed_hz = mdata->spi_clk_hz / 2 in mtk_spi_probe()
  (and reject spi_clk_hz < 2) instead of only guarding speed_hz in
  mtk_spi_prepare_transfer(), covering mtk_spi_transfer_wait() as well
  (suggested by Roman Vivchar).
- Move AI coding assistant disclosure below ---.
- Link to v1: https://lore.kernel.org/r/20261126003314.49090-1-iasnezhkov@gmail.com

Found and drafted with an AI coding assistant.

 drivers/spi/spi-mt65xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 8b4deef..7e94b4d 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1285,6 +1285,14 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	}
 
 	mdata->spi_clk_hz = clk_get_rate(mdata->spi_clk);
+	if (mdata->spi_clk_hz < 2) {
+		clk_disable_unprepare(mdata->spi_clk);
+		clk_disable_unprepare(mdata->spi_hclk);
+		return dev_err_probe(dev, -EINVAL, "invalid spi-clk rate %u\n",
+				     mdata->spi_clk_hz);
+	}
+
+	host->max_speed_hz = mdata->spi_clk_hz / 2;
 
 	if (mdata->dev_comp->no_need_unprepare) {
 		clk_disable(mdata->spi_clk);
-- 
2.54.0 (Apple Git-157)



