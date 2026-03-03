Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4354B8DDC;
	Tue,  3 Mar 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555409; cv=none; b=K49Xc+SeNb8kWLz47WTIrUTDNcHhVUgXfR8BI93gmrgmEaf7Q7WIWKYmoei0xMg3V2T4Xutd6ywuTqP6V9GIPncBNS0izCxp6SwQtqe133FkKJzSC4FU5A4XBLtyNlPB24z/X0srRgsZcV2iH7YCC2HUwVUGl4Boy86QDtQ6zM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555409; c=relaxed/simple;
	bh=yL/xSbcaZwuUOu6gkmddpGfg1RNwAiNrd9YKVZaYdN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iA21YfKT7j6yb2ptsSOvEN7trQo+qPavhqlHVB5qA3otboVWGsVPSNZo3DoCd5ic6SGipXBYoPUv/8hc7BzaprcWaC6Zd24zZwYdQ9UcmCM30C8VqygEBnNUPwjNTRPQrsfT5TxsMsuAjJxZ5q85VBRUryaPPv572tzQA0nDgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=uh8WI7mG; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="uh8WI7mG"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1772555398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jEzN+ZbuPiy2X43ltzsOH8xhPtq3QTkuVtmlsPHM9I=;
	b=uh8WI7mG1o6aI/mjEFxWTylQAQHFKTSjYQ96O6N7o74Oo8x/T7qAALbKOm4Fn3qWQ3z3EA
	dfVXtmnGsKr6kRsxyhIL07ctqko0sq8dVVW3l6sIZctd0O0VuTEU6WYjKPngwiGvhQfJyc
	ijO04WpWy1+rMVySo93grJ5edJATcvU8CzFTfZyhog53+knXMm4/buPCNyPZ6Nh2T1DvyM
	28h89o48kWGG7Mffxn07dXfFk/4jmawRLZ5NLEkNRxDdZzXkoz3mD8bvv9XDJUEuZSdFPa
	qXa73xU0NW8g8Ot8i/88+gvV2IJSco/Sujdvnq7X0T4QzjyAsjkCzv3NwbemfQ==
Date: Tue, 03 Mar 2026 17:29:27 +0100
Subject: [PATCH RFC 6/7] spi: spi-mem: Call spi_set_rx_sampling_point() for
 each op
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-fsl-qspi-rx-sampling-delay-v1-6-9326bbc492d6@kontron.de>
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
In-Reply-To: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
To: Mark Brown <broonie@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Han Xu <han.xu@nxp.com>
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, imx@lists.linux.dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=789;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=LwNCpqII5STHerKJFGgtW51z+gveZ5FdSLV1sPEkDaQ=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIXM5T1P05w+c/q8f1HEL/z9e/rvzbY+NyWeGXpP/6wQ/3
 bgsUW7ZUcrCIMbFICumyCLFb/Ha1izWR/5YdRTMHFYmkCEMXJwCMJHcOIb/HoluqStOqzE3b4qy
 +nDB45R3uEPozJs2q9cbHDpUoaH4lOGvoJtN7NmJf64wx6T4qTF9z9qRK2F/MEEjoXFpik9k1EU
 WAA==
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216

From: Frieder Schrempf <frieder.schrempf@kontron.de>

With clock rates changing on a per-op basis, we need to make sure
that we meet the RX sampling point delay constraint of the underlying
SPI chip.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spi-mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a09371a075d2e..6b8bee7d6f5e3 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -589,6 +589,8 @@ void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
 		op->max_freq = mem->spi->max_speed_hz;
+
+	op->max_freq = spi_set_rx_sampling_point(mem->spi, op->max_freq);
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_freq);
 

-- 
2.53.0

