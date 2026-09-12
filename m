Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379BE490C1C
	for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2026 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789239672; cv=none; b=Q7nOsP6m3B2opOjHmsol7pgYjOkKu6dkpELTqdPXnu3rc1vN3+/n6mesB2/SmOsFBzfa7p80XFVbRcd09yCpGp1vF7F8sHP416t+coti0WwMHrgouQ75sQ+4hl2YPaezpHq1G77mHZHQvmCzChodySqeq81/eQmZ1VLA+Q021Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789239672; c=relaxed/simple;
	bh=QEiGJeMuvavZArZLMqWA5QCTEdLv23+ne1fNLdnSNTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5HlCdBAG3GGJ5toR3AM83Og0hyVcWv6wmOn9/dQkpR4/Vm8v3m6zNAPhuASEWwpKl4sZBZtCW1DJhRHPIpAQDf44d86h4LdVL6S5crdFk1NfzedL2thTAWnilTuzwu1Dy5S8vRJ+vTeM9M66ndRFTM9H5HI9negt/WPVONN/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmG1xvic; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmG1xvic"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91219376dd6so10107066d6.2
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2026 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789239666; x=1789844466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4AaS2W86AtkX5bjhTKY8jGngBhIYNaOT+HF7QmT5cMk=;
        b=VmG1xvic+ter6OxihUf2c3lDrx3zR6SKG108MXIqEtMmgnehkcplKI9/oDAMoEE9Ak
         LwUN3zQIeNefAtEKqqRAInu6r1nD6r9JVcMT7LMd5eSKJyZedVAtJD6taV4WPaalSF4N
         sB+ZFXINYDJZRr9Jj7wcpJguSUxGacN8BHH6a1Nhtq0zWBzNT0BY2PXgrZhW5T/p/M30
         HX8T9eOTuIJtEFWtCHncj9KNXHrnaDgXXQwSl4/E9bImaz8CNYIw80sjjOl+exLVcnGC
         oaDz3I3XKVeinPoF+6ovP+gXxuU8Olg45KBP8YPpX7X5MRLnJRO5Z7sQ05ncyCy7pxl8
         xKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789239666; x=1789844466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4AaS2W86AtkX5bjhTKY8jGngBhIYNaOT+HF7QmT5cMk=;
        b=B+7X+OMRdwbvVuJJ9YUwDlS6gcpRNCZMoB9F3j4tD6YJ4hQhE9XJfYzhp9ci5murKd
         C60Y/Wsdw95WHqz+abh59Z05vD9UUG5aoakmV4ZCGblNYasFOWo7bbIVp+jFmbAP4vPx
         z1fHFpZsrj/mk1ZrTJgMFHCNTICjCDDNfOPqq0ZSKEVY/NSHSs+0Ti6TeVryDvGiSgKo
         hAYBepf5NTVrh6ZucqWpIpsurAt10N5gZwk/fb5rKoRW8v8wMM32hX8YuVUVWS46pYKM
         y3Wlqdkqx3VAIDDCVLLL4k6rA3Sed6IJJTU+L13LM/AAF2h+UJ1cetE0T3yzESxjziDw
         7WOA==
X-Gm-Message-State: AFuF++mHb2slS8sysTIx0sd7AgHEQZqkAClVxdGrPWaFXGoz9urfokxg
	Q3o+iAyEaPuHMPQrAqDheIg85XL0Jcd3aCZtuAz04P0lBh9T+LsqnqM=
X-Gm-Gg: AYBFou2NqW3Vstb5RHJB4ZnW+FeR4KIK1LFnFhXUfej1kMfukbDWrA4ngxFksJmRObC
	smoL3SMVvSQegMSmoaKA8sU5HIqCj/kU2aTCwlGJO/6gAq1i/Sm7+6kMAigSy+GzH3jLfmnO73M
	zZb5s2pYXx7HEgOLug9Xkys9yYCb+qFEgAMVYvlk92C6B9wnasQOZws56neo1D/eDrRogvhDa2Y
	5fCMxftVeExzBUo+pqh1qDRe3hLENrANtjCL23XqWLM9ALUmqo88OU+jHRjoepPp0Ee77yNfBwy
	vrt7vAQYjcGK4E+CkFvR1Gc0B6IohL7N8vaM2eM7z4sSlo3IicDoevCtY8BkSWVipPYMOyZXrcZ
	ukZe4sj8oFZLjl/ENWT0ZiNI97j6ZiincXILbifMFq4ff410fB+bEbm9th2xIiqhdGBZ4NC+hFx
	qfgU4nDa3IJ3fAVuDUJLlPUf1+bt3mgUgs/oWSyHqixTWxk482LdoJkAh5P/jQOtDM0uduCCstb
	lHaq7IsgH5YlvSRfropjz6B8iiE+3t9FEZEuVcpgmFsN8ZH5ZAl5QQH/aKaRAXw/1BV8IBhrNp4
	GbJWbCyXFof45h7XVmXphgaFMfUdEaMHfg==
X-Received: by 2002:a05:6214:3983:b0:90e:96a9:4c5d with SMTP id 6a1803df08f44-9121d91c1famr77743116d6.15.1789239665588;
        Sat, 12 Sep 2026 12:01:05 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45f1fdsm52597396d6.16.2026.09.12.12.01.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 12:01:04 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] spi: rockchip-sfc: skip DMA cleanup in PIO mode
Date: Sat, 12 Sep 2026 15:00:56 -0400
Message-ID: <20260912190056.42192-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aqRM17TZ0-5pd6Y0@sirena.org.uk>
References: <aqRM17TZ0-5pd6Y0@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With rockchip,sfc-no-dma, probe skips allocating and mapping the transfer
buffer. However, controller registration failure and driver removal still
call dma_unmap_single() for that nonexistent mapping.

Guard the DMA mapping and buffer cleanup with use_dma. Keep the existing
cleanup for allocation and mapping failures on the DMA path.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: ee795e82e101 ("spi: rockchip-sfc: Fix DMA-API usage")
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Guard the cleanup calls directly instead of jumping between error labels,
  as suggested by Mark Brown.

 drivers/spi/spi-rockchip-sfc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 662a994da60beca33358dc6af09017e88771d017..bc5537aee449e0c33c2d6ecf9d57205d432ec7b6 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -719,10 +719,12 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 	return 0;
 err_register:
-	dma_unmap_single(dev, sfc->dma_buffer, sfc->max_iosize,
-			 DMA_BIDIRECTIONAL);
+	if (sfc->use_dma)
+		dma_unmap_single(dev, sfc->dma_buffer, sfc->max_iosize,
+				 DMA_BIDIRECTIONAL);
 err_dma_map:
-	free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));
+	if (sfc->use_dma)
+		free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));
 err_dma:
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
@@ -743,9 +745,11 @@ static void rockchip_sfc_remove(struct platform_device *pdev)
 	struct spi_controller *host = sfc->host;
 
 	spi_unregister_controller(host);
-	dma_unmap_single(&pdev->dev, sfc->dma_buffer, sfc->max_iosize,
-			 DMA_BIDIRECTIONAL);
-	free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));
+	if (sfc->use_dma) {
+		dma_unmap_single(&pdev->dev, sfc->dma_buffer, sfc->max_iosize,
+				 DMA_BIDIRECTIONAL);
+		free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));
+	}
 
 	clk_disable_unprepare(sfc->clk);
 	clk_disable_unprepare(sfc->hclk);
-- 
2.53.0
