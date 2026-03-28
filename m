Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880039B486
	for <linux-spi@vger.kernel.org>; Sat, 28 Mar 2026 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774714040; cv=none; b=lHxj5FDA4MsQ+1cApj3jUCs8XPffGgGNm+L8lcmYuJt6Or9EcKI33GUe+mBeratMK10Rw/UooTeMVa8AYisKFzII+FjCbgNR8Cj7J9MQi/hTBYImkImE8Ft7KSvTe/Gc8KDPWJk+YQPAULXJ/VH6ZecNha1tyfQ5FGx2fqYFPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774714040; c=relaxed/simple;
	bh=g/NC5thUm9GobODU/U36/p17WTlVCj1qLtVx9sZkHSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l9NlevyyK86bWZcYGwRPfMnLq3P/ZN1lEZkryF5tEy8TbDx0CUg0H4RGs9V7rReFRdEePy4UMErE/LO9P1rXqz0cFUASyUhnbsPCIu3JXGD1FUb5Uy/nhoI3xLN20A7SUgT0tjSmAvK16MHduSu9rpirRBvrp/+ZD00iUdmMdF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m620CFb8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m620CFb8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so335567a91.3
        for <linux-spi@vger.kernel.org>; Sat, 28 Mar 2026 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774714036; x=1775318836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqrrS9uvTvJ0weuIXquOC2uG3YCXwOkehaDJ4cbhf3E=;
        b=m620CFb86Qw+HQGwYsbXD0J6lJMiP/5bZLwlVUJcNSVFSNKp3d33P38db9EMetR5nU
         ZRzewV4zF3NzNz5Jc2eMNpGUsxPoB3VEqJZLwIREaAlw3bMS0eM2RTCqEnnV6BgrDTt3
         wyhy/oFFTogMEEZmXcyLshJ0x1TIo+MKQZSLhWOVtf/a2J9YGPnKKNPcuXIiVi/5lvE+
         UiI6J7RIZBZOj7rN9T/A9QUhlJtwNiNiqN4lHi3UwR/5vgN91vvfE2t1XoPO533FXhsp
         tnfGt5X4RFrtcxhYrPDZIsUlgES8cgHjff4kqRw9jz1SZl/vsbdEF530naRKWnnwh7H5
         ctOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774714036; x=1775318836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UqrrS9uvTvJ0weuIXquOC2uG3YCXwOkehaDJ4cbhf3E=;
        b=G1sbAHPGyMxPy+EnghVkuEkBAA0rYiklbLEOPjsrrMsBBbcOFJvZm2qIjLhtaiQPhd
         6YaL7Nrc/qwP8vvjV+lshbKlTQfU/yEQqMoq4qbE6Z49pT2xm5maw4RnAGjoiAaBsVot
         9ZcSFvyHsA2HnB1r/6278kW8YB6/MevD0D6T3vRsvLZoXgbkp9RB2vFXZXYUH8Gi9Xjf
         jImSDhKhbx73/YyY2gQtXPSsuS5PyKqrqwqHyLEoQ5rl4f32r/36wBupRJrPPw6fcdOD
         woPV1OHg5SEC4/wO2sp5wYAIunGQkX6Ne1agQqwNWk1R4Z0iIq9fOBPPl057iONmHMh+
         liYA==
X-Gm-Message-State: AOJu0YyB7qoyCJZnSl5tEc7Y75w0bfodQmfoM/fd2pAiv5wgrgnQsOu/
	mF1Qbc8k+m6fb/qYhCmTbSQOkSErXymaXi74B+4qQBSUsbKs2KVxNumn
X-Gm-Gg: ATEYQzwxDhMoEIxP2r+wGrsWNVuoeBd7q3Xci2ycYRjPZ74tw9UK6yLIoMftZ0qRG+B
	yQzbXOW+CLAYGYNGwJwf6GgyPXDKWs6pON4mJ/iM42RqN9H/uC6hWdcOtN8TMB0SbHKPQryTW2s
	LYrfBRfNEbtN0xF9+JkQENzhBoA5t5X7WG/BMyDXX/oOMAj/QOQQuzAKff3JLkUighizn8WciPp
	e2b8eL8wYelca631Ar7l4iTtD9EoZxl94wSw2rjYsDfUFkusgpUfTOTB29Or6XvMn50o/uzjVZV
	La9lz022JZjD+1rFzdO5BTpZ7MhXEWGqb+jjQRUJNB1aCsw/MuyrvKFrhdW05GqYtiV1KGAvJrn
	QdU+362HnzTUNM3XDpmrjqNK8zReJjYtSF/MbzZ7rs6qM9H/bAB6InxrNISC1wL5uyy8MHAYczE
	XeeqzvbALYtMLbyz6Dh6a+XeC0qRtQSZpo2/nz
X-Received: by 2002:a17:90b:390b:b0:35c:812:6126 with SMTP id 98e67ed59e1d1-35c300f9db0mr5029057a91.24.1774714036132;
        Sat, 28 Mar 2026 09:07:16 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2ec27da0sm1988140a91.8.2026.03.28.09.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 09:07:15 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 29 Mar 2026 00:07:07 +0800
Subject: [PATCH 2/2] spi: stm32-ospi: Fix DMA channel leak on
 stm32_ospi_dma_setup() failure
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-stm32-ospi-v1-2-142122466412@gmail.com>
References: <20260329-stm32-ospi-v1-0-142122466412@gmail.com>
In-Reply-To: <20260329-stm32-ospi-v1-0-142122466412@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774714028; l=1104;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=g/NC5thUm9GobODU/U36/p17WTlVCj1qLtVx9sZkHSc=;
 b=aSWLNSCRp0D8866dSgcbY+JT4XedGUT6QeFZ4e3z25/G+O1t9HoLZs4yvCDebAVPEe6SBW0MI
 wJBP5VFN2niD5tp1lOmoFBkjn9PFB5InUP/CCkXoqJ2mkl3cCcQcxGB
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When stm32_ospi_dma_setup() fails, the DMA channels allocated by
stm32_ospi_get_resources() were never released. Add proper cleanup
in the error path.

Fixes: e35a7607e05d ("spi: stm32-ospi: Set DMA maxburst dynamically")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-stm32-ospi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 52997c3f7174..34498939bcdf 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -923,7 +923,7 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 	dma_cfg.dst_addr = ospi->regs_phys_base + OSPI_DR;
 	ret = stm32_ospi_dma_setup(ospi, &dma_cfg);
 	if (ret)
-		return ret;
+		goto err_dma_free;
 
 	mutex_init(&ospi->lock);
 
@@ -975,6 +975,7 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 err_pm_enable:
 	pm_runtime_force_suspend(ospi->dev);
 	mutex_destroy(&ospi->lock);
+err_dma_free:
 	if (ospi->dma_chtx)
 		dma_release_channel(ospi->dma_chtx);
 	if (ospi->dma_chrx)

-- 
2.43.0

