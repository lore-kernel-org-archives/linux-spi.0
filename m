Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880F2D0605
	for <linux-spi@vger.kernel.org>; Mon,  5 Oct 2026 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238000; cv=none; b=aHxbd/Fd33g1HXpyuQmQFOb06kX9VqMtYE16+DD9O4TJSLyvCW7BkcHCFW3mB6MecG/O2zlbDTEAzUakH1ICKVQAUocsfZSMSceLm3ryeGwO256flbykkYahvhJ5rgsyZgTqqGyOBqsNEGKUfl62wkaO71vav8MG4qf/1/tvhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238000; c=relaxed/simple;
	bh=V251f68AK2V7fciivPQ3/BNfSprJGGjRz02NZzkvc9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ln3z5YxdRVamLCcqYlXyT8vkyoXqpMRTB4hrB2s8UCdrKz7Ke2PmOKeab2uFn8nprI82cKnLNUuy29wW/eHpWzgTPB+SeJnudX/355oOkf3ZMxQezUvp27Tnsx7aedxdGepRFHgcOxG8JnDFyHNy86TGLzuEfiiJq6zaOCJd0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sO7zk+53; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sO7zk+53"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78d59bb02so740209a12.1
        for <linux-spi@vger.kernel.org>; Mon, 05 Oct 2026 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791237999; x=1791842799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JTKWejYowm2p4DJaJvyyuvQbEpNVbY+JknPKvn9wkJo=;
        b=sO7zk+53ykV2XWNu41c6R1tEIaGqsYLAraUqTSqbYEFfDNYoDDVt9/o73U7eNCLmw7
         PzgAlGVjCoXzEbDmlulF78XmMblyYXu1m7knHqfyyhLGGGKtwur0pUafAfnfkJ4py4yl
         EAIm15MkddaZj/iQnGk6MOAPIT+eR+PK8f/y/DFF5lUFw1prJKM+bK+prAGTbyCFyLcH
         XSMsqFMAqQSxQ/Pm0hS3GAcz9wwcc6hTg0c6naXp6QA64XLshWnHMo0QdzSm4dNNSLQD
         KzxYO9/wJ/2F04LM1ssgo78ZvHAfFfFtOMOhjOXOM59icycGAu5cVPpOPpoRLPJQzxh/
         RVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791237999; x=1791842799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JTKWejYowm2p4DJaJvyyuvQbEpNVbY+JknPKvn9wkJo=;
        b=a/yKdXKoBdaHrQYUA0EjA/KEhAgXcOBOTG9qK1JngbeVHtkTT4mM5S1vZzAUI0CPXK
         ScVFSnbolV2X8HsZ12Fwn4tyII2bHvIg2LCd8qjC51Sv6L4aZIEOoVYk5M9etZ9Xnzgh
         TxN1THyLATvNkYhlux/OuXFZQT3c+9bnmGcML5ZI7SPmMew5c8VS7UvmuvJn/PP9MxD7
         nOPZVMh19McVsm31SK8W0scBP5K1SsCRdX6MT/3ibqCRvBMuqHmZ/vCuxaJX/sS3aot3
         nittyIHaK/xMBm6rmFiD7xH0eFTJtYm8ed6KvgQaE5yWZZkAvJUg31JitAN+2cE1MXKb
         VOMw==
X-Forwarded-Encrypted: i=1; AKwUvBxenvQ9mwx5rGrGco/mzE71yc+zFJVdDPOUNqD9IMsR0xmmKfzy06B68j6xWRiwBMsuSOp44XUo/IY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVgCCXEKxI2malB0zCmysgi/pwkQGx13vLHfeGIxwUw9dU0eLP
	WVb/5tm4GBsIKKLOmj3NuphqnOBj17dTJt8SbdJaP6A3lT5AZJWisX7W
X-Gm-Gg: AYBFou38kPA4TDs++SSuTSGu4rtAO5G+3Hq9VF2vIf7H2lMPbjrveVanHkZOlY1FW+8
	lRJTS0XhuetIsAOZbSfoix2eD0IUjhe3QbCBHlN0N+Rm5wraevezBoGNbzEZeML+dzdTaKj7hK6
	C+/90an79BadzKwsec/telCFnq6Ehi1UYiK8NGqzPDaG0fnHmiH7927SHRWBzfFSPFui+jEpglk
	ADG6NlmZHj95VTcbrOQ+B0AgWBURDASt3RTxAlSsy3NsTwMh3V+F6N8dourSqxJgljKrpcEbAnr
	Tpj7ZDes0h7/gQKoNs/MD5W6A0EMpRk8y5ODgpyR+AJBjlsxronGOs3yaUS5/8nx5ClAwTRlZrx
	3SHwwhKmqaoy52bmqfDdBx9Qtox/fyEz3lZZnIxVf5fgENYQxVJrLw6Vyw6RS3dsM2cM3L3oMMl
	/62fxWj6H4w6JG6nFqhQmdVbYnoaoQvwckQciid/A/Yb87QJBlnyOgkf6Af9g0o8h1QM/NtmwJ4
	2k9EAMv18PW6XtwprnrNGUp67pNNu2MXBe1IH4nh/XpE/mPLW7TGGsDksnXUU5U
X-Received: by 2002:a17:903:191:b0:2dd:c053:d741 with SMTP id d9443c01a7336-2e49b684cffmr118013695ad.40.1791237998457;
        Mon, 05 Oct 2026 15:06:38 -0700 (PDT)
Received: from LAPTOP-BEQ9FFIS.localdomain (60-250-51-133.hinet-ip.hinet.net. [60.250.51.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5ecbdd3sm13723035ad.48.2026.10.05.15.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 15:06:31 -0700 (PDT)
From: Pin-Hao Chen <billy920225@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Mark Brown <broonie@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clement.legoffic@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pin-Hao Chen <billy920225@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: stm32: fix double free of SRAM buffer on MDMA fallback
Date: Tue,  6 Oct 2026 06:05:28 +0800
Message-ID: <20261005220528.7199-1-billy920225@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the "rxm2m" MDMA channel cannot be obtained, the driver frees the
SRAM buffer and falls back to DMA-only mode. However, sram_rx_buf is
left pointing to the freed buffer.

As a result, stm32_spi_unprepare_msg() may clear the released SRAM
area, while stm32_spi_remove() or a later probe error path may free the
buffer again, triggering BUG_ON() in gen_pool_free_owner().

The probe error path also checks sram_pool instead of sram_rx_buf. If
the SRAM allocation failed and a later probe step fails,
gen_pool_free() may therefore be called with an unallocated buffer.

Clear sram_rx_buf after freeing it on the MDMA fallback path and use
the buffer pointer to determine whether cleanup is needed.

Fixes: d17dd2f1d8a1 ("spi: stm32: use STM32 DMA with STM32 MDMA to enhance DDR use")
Cc: stable@vger.kernel.org
Signed-off-by: Pin-Hao Chen <billy920225@gmail.com>
---
Found by code inspection. Compile-tested only (ARM multi_v7_defconfig,
W=1 and sparse); no hardware was available for runtime testing.

 drivers/spi/spi-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index be88e62075af..605b847d8773 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2511,6 +2511,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 					gen_pool_free(spi->sram_pool,
 						      (unsigned long)spi->sram_rx_buf,
 						      spi->sram_rx_buf_size);
+					spi->sram_rx_buf = NULL;
 					dev_warn(&pdev->dev,
 						 "failed to request rx mdma channel, DMA only\n");
 				}
@@ -2548,7 +2549,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	if (spi->mdma_rx)
 		dma_release_channel(spi->mdma_rx);
 err_pool_free:
-	if (spi->sram_pool)
+	if (spi->sram_rx_buf)
 		gen_pool_free(spi->sram_pool, (unsigned long)spi->sram_rx_buf,
 			      spi->sram_rx_buf_size);
 	if (spi->dma_rx)

base-commit: fd99864b0ac936e870c7ae28354c5cd3dad5efd0
-- 
2.53.0

