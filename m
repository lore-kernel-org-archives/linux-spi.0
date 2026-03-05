Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387721FBCA7
	for <linux-spi@vger.kernel.org>; Thu,  5 Mar 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731478; cv=none; b=tffWfZRNCVRm432qLURI6Voky8yNfLbs+1V3e/e8VAbH8vMI6oXA6GoRRIJnSYT9VJbevXH9QOb5EIcOkOdt707qTqHporaNhjck34TaWQY7dDWNQMBJ5i+uxp0oSNLA9xzTR+azsxB3IW0WxcvYDyHuRrLppzqd77XBJyDVNk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731478; c=relaxed/simple;
	bh=lomfZlVN07CiFEPEXh4wGx1EjgxUHi4bQLkDua2YS44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E54ue/LVwYQQwHiaDp59BpKTJH1AJOoNJxiHWe9U7uHu+/k/QQNf0xfNk6QyVxoIVJm22ZBOEALOs3L4/nmcj+uGGgO+gAAIzrqpXImGPpRub7icczIVtjwG5+D5ZcmFUn9znHADj3SfU8wx6o1CEeOYssRaeW4PEqFu6M6I3Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSDE6Ltp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSDE6Ltp"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70f91776fcso3301097a12.0
        for <linux-spi@vger.kernel.org>; Thu, 05 Mar 2026 09:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772731477; x=1773336277; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JT0/L3hjO8bWyA1TdT+7Z0rwF+foYA9hR/6cSM0pLp8=;
        b=JSDE6LtpCZNhe3fiPz9D5sbSci2B34/zpp4WkJvaqUoZ4IFBbxf+LVibUmqXK8j4kc
         q8q5mJKJ8eVshtE9F2NsRl1DBw3TUDMMJh+jFQFio3DKtmhWPWi4n0p1R33waatmJ/XL
         BTaohMMgFPRJZrI2m7t8CNCQZ/rXktx3CkWd5U0IFeSY1jsr8JSVyul4nmM1Fx9X8nIc
         QAownT5Rf0UVyzyPsVvjTo6gyDfP46R5QzIEg1oQpEA5qNT8wg1hYUb48Zbu73EMFb9h
         MiSmR/UPYktpINylenxLb+VVhyXtmADRAYh5HGeh0omx4QpcfhGtoC4fV263c9Cpa1SB
         KLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772731477; x=1773336277;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT0/L3hjO8bWyA1TdT+7Z0rwF+foYA9hR/6cSM0pLp8=;
        b=H404QyFc6JNz5NpKUvn5Xx2+u/iPmMixsfRP5RXzoPscep55uxCCUkk12K/awQ4fIr
         9cfmsZCZFOGADyc/3OO1W9GI66rqxbfIF9bw7sAhtD8smmX5SHit9M9NqC8H49Ebgb5N
         Be3//eE9sW/dZKpnYNEAGKMGG+SwzNBcdnMQAM/WTlj+R01QA3GAmt8N1x22LM/9iOOW
         SH/PB51vIhbrYkCHtOvcBd7O4IwH6a+QAyRpJuqa+0RrT1QXAw+10cwZys9CtIbXjYWm
         CAoNjSfnT+LKiJpfyYoWwbN0K3hfl7z3+EAtLA/4zeV55Jk9l+CKjfUy6KRLezNosGiN
         qMiA==
X-Forwarded-Encrypted: i=1; AJvYcCVlmEoc9y9o6SEQuesar3f2G+Kcmbwg8lM6P5LQxvt01+oOYLo4pIbn0Z9rR6U9yjT0P3U/jMwNoeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ81o4ZH/HMIhItt+3/D/2HShYfqXnKRc9NyMML6AVJU0z1Kpf
	xqqT91443Ka0iRtZYMs/hhkmS2L0AwZp1WWVCAETfaSdrRzPP52AivBi
X-Gm-Gg: ATEYQzxGxgjREdF4rVJ0nbDZWL3uXgMejxr+IxeWXywjs1DmR7i/Qw8daDcfi+CFRlp
	ZwKBvFydAlHKeOIB3f8J6PBY1Q44vNSzkaihRqiNZuONWRj4MZx91ie7yOz7lz4619cfwfv4hm2
	XuKR5K2lPU6hD3L8xqxPABR2wFpN53aFwrnuRRIneXL03ZWH87r5dGplHjz6FxrfZfW9SscOBHo
	k0OJgQ5YHeV+75A0TRYjqHt8r15npRY/bjOww3r6EXi0RTD6Xj9sW3IXiD8WVlFiKdi8K+ArrBr
	rAzxyh4FdsVHvNEhXSpK+pZXv+e+CzVHmymCuqKdh9YAFN/MebEwhyQvfXBfjulPlC+GbwkOxtK
	Dc9oGB8tG7kc1KLssvMew+RJFgbTdu+s9/tl2WpqyKJ4nCRw7Pek7Ba2/pPfiU+kdHmDelV1aJg
	nFGZVUWbigIjJjlXRT5PAEEg7afdC2
X-Received: by 2002:a17:902:ea04:b0:2ae:805d:e0b5 with SMTP id d9443c01a7336-2ae805de2famr2542615ad.56.1772731476543;
        Thu, 05 Mar 2026 09:24:36 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2::3a87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c183bsm237542815ad.24.2026.03.05.09.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 09:24:36 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 06 Mar 2026 01:24:32 +0800
Subject: [PATCH] spi: amlogic: spifc-a4: Fix DMA mapping error handling
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-spifc-a4-v1-1-f22c9965f64a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAE+8qWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMz3eKCzLRk3UQT3RQTgzQLE1MDsxSzRCWg8oKi1LTMCrBR0bG1tQB
 9ctMmWgAAAA==
X-Change-ID: 20260306-spifc-a4-d40f84506d6a
To: Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772731474; l=2039;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=lomfZlVN07CiFEPEXh4wGx1EjgxUHi4bQLkDua2YS44=;
 b=S9kHCyJh41+jIjlilWGWaLPlUEG9e/sEjLAOxgkA0n5AD0EuxwfMPMZi1EaMxSNXIMWAHsQBz
 XiOqxcgGzLOBpmiqgyRAtLQI5uw0ExZAEVIEBMtoTyfHl6wV8GLDmfQ
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Fix three bugs in aml_sfc_dma_buffer_setup() error paths:
1. Unnecessary goto: When the first DMA mapping (sfc->daddr) fails,
   nothing needs cleanup. Use direct return instead of goto.
2. Double-unmap bug: When info DMA mapping failed, the code would
   unmap sfc->daddr inline, then fall through to out_map_data which
   would unmap it again, causing a double-unmap.
3. Wrong unmap size: The out_map_info label used datalen instead of
   infolen when unmapping sfc->iaddr, which could lead to incorrect
   DMA sync behavior.

Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-amlogic-spifc-a4.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index 2aef528cfc1b..3956869cfec1 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -411,7 +411,7 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
 	ret = dma_mapping_error(sfc->dev, sfc->daddr);
 	if (ret) {
 		dev_err(sfc->dev, "DMA mapping error\n");
-		goto out_map_data;
+		return ret;
 	}
 
 	cmd = CMD_DATA_ADDRL(sfc->daddr);
@@ -429,7 +429,6 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
 		ret = dma_mapping_error(sfc->dev, sfc->iaddr);
 		if (ret) {
 			dev_err(sfc->dev, "DMA mapping error\n");
-			dma_unmap_single(sfc->dev, sfc->daddr, datalen, dir);
 			goto out_map_data;
 		}
 
@@ -448,7 +447,7 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
 	return 0;
 
 out_map_info:
-	dma_unmap_single(sfc->dev, sfc->iaddr, datalen, dir);
+	dma_unmap_single(sfc->dev, sfc->iaddr, infolen, dir);
 out_map_data:
 	dma_unmap_single(sfc->dev, sfc->daddr, datalen, dir);
 

---
base-commit: 3f9cd19e764b782706dbaacc69e502099cb014ba
change-id: 20260306-spifc-a4-d40f84506d6a

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

