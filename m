Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A83515D1
	for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124513; cv=none; b=rFAzBq2G6RisbSsyEbor2LXDXjqtGkMy0YzD2PIvH0SF5PM+wy1XwXUDT+9iTAcQ5K+EF5XeTouZQxrruCWCe2dher/vU9eYudSB0SNPpaenm1PUabJNR/pMHNfORhNp8QJRKXJRcs8LJHEfhbT1w4eqm+1pWSOoLz4dNJakB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124513; c=relaxed/simple;
	bh=n2FF6yTybhDp/bZ90SDTSjgM6yCnUR63Nrzc303VrvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LXIVjeTtmI+mq7qpQf/RnGkj91U5d9271BXHgYI1vYRVi3K0WIc2YrxDYn9ZBj0X3UUSq9ETfapOvelEuCFIb7TIf5YAY5m7ZC5wihHy2ogtKdjpfS0WoS7JSsnUTYSWu4ltEFyPC2tKm2IZSCvIV2NU+AZqt90sXN9+BBk2R3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+q7KENd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+q7KENd"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38deea72eebso3192448a91.1
        for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786124510; x=1786729310; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rTKEFy1dHQS9eTV30s1RmJcGez8nqQ/r+IruxxzByOc=;
        b=L+q7KENdQkogWEy4JmbIFNaguzjWWo5U/R0ibcoIlKdix7sFInTSuI54mSDkbSStfW
         N840QdV8eOHO9avicqnOpKkArjSmtH0scSTCPTdiGxJMqfBXPTwekVVyk+jZcb8aC6th
         5QzSKcYb4rRgNQihaFi6CJA6IbOe7epLUnCAulJXw9aycpN2iM6/K/nKtdT7RHVY08Qv
         fcTLFtoI2GGBLm6s2RQij0cpB24GDgj8IGBS7u/saZPnDZltv/X/7qBTzVGAGjA8MuRU
         W04KD7VCJomk9DKI0C4QVoF8Sc8osUO100T2yH1mEx6J7V02dCELARzE434lBJPUb+yq
         MT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786124510; x=1786729310;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rTKEFy1dHQS9eTV30s1RmJcGez8nqQ/r+IruxxzByOc=;
        b=ZVjCoZcgG09tBmB5rGD5RJNHiDXGOitIkjAH3k+HagBAGl1sDhJP8AhV4nMo+5xAaW
         0Wcd91XHS+LimMvOqZrzphPXnOpUf54jIxVgoDZN37xHER9NB+dZ2sfy2usRdpf52WN2
         N60wK3Ob7biiY/J8KprFUMnkSO8HbZfPmbD5HQdRdfmifnrAECCWaM5iCIr9GZFk4lCO
         HJK9cha/EvGxIBnnuFH51fPqzkJm+gCXUnALG/dLZJ40tVu/qP/QLdFj9+Aynnk8Ubnp
         vLmo0Tvg96MyAiHBfJQV8/0bkO3Ug60Ln05ne0+kgnLLBtuESW+WFrXbERJmRCrATMHo
         d3Ig==
X-Gm-Message-State: AOJu0Ywa5Jbely+wVQcYfC1/s0QqqaBHkpe29Dxvql5qUfmtonKr8jgP
	JHZee8TpjmF8ZxX9saEKicgMI/L857qUZg5S2OLTSCfxbUTtwS0C1VFF20jBVw==
X-Gm-Gg: AR+sD11OCBedazZnGqJqMxZay2nBz3ETpG1MSyEU+pLTFULpqutX2kk985GFIznLLNF
	cMk5sIv45HLJrH9oE7nlEnez9ATDfgbLcVkW/++oAytyVSmQ6j+88KZsDq/hk3vZQ6Npkoh0C0i
	qCVtZ83r/HPtHFMlHkPjEjbLf+UBd3NulonARQr/rFxaUn8Mrod6um/wOOgBznQ4bnlsA+TvOAF
	J9VO8x/zZCDHOTppjq3WVpfLcCIMcA5uO+TU12kkbLt53YDkz2973XUEYApZWnudHKrWxeMl04G
	9iy+Q3cA0gaoVal5t3JwJ6zIcufKnqglvGkCwsALprxvV9Gvh69MW5jg8eEfO6yrGUHz065fc1y
	HH0cYa0w0xCa3i0Zhqt+JmW+N5MSOu/ynUl30hT64Dzl95Y/KcWqk+UBIxhwOAvroy6r1OkTf+H
	6SctaU+A/MmT59lZt/lVstMk2tKeNrAk32kOYic//9r3kgxFT5fYGSFvZt8yiSZepmtlsJmxeNV
	ZCO6LxoQRLKGnWxdxBoiFUfcJWpfP+TKjRwOAI5+t3/csDP6vM0Y6Fp
X-Received: by 2002:a17:90b:4f81:b0:38c:e9e9:e7ce with SMTP id 98e67ed59e1d1-392822bf6abmr1208572a91.3.1786124509914;
        Fri, 07 Aug 2026 10:41:49 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff912c7sm3503364a91.17.2026.08.07.10.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:41:48 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 08 Aug 2026 01:41:43 +0800
Subject: [PATCH] spi: img-spfi: don't disable runtime PM on DMA deferred
 probe
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-spfi-v1-1-6bc4345be430@gmail.com>
X-B4-Tracking: v=1; b=H4sIANYYdmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwNz3eKCtEzdlNREM0MTiyRTi7RkJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAFsZMNFoAAAA
X-Change-ID: 20260807-spfi-dea6148b58fc
To: Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786124505; l=1621;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=n2FF6yTybhDp/bZ90SDTSjgM6yCnUR63Nrzc303VrvU=;
 b=oHDWFYyWlsStzsEx9ZWzxDqEPhpnEGqeJkGUOMR0YBevf/nqXJC+RVAoviSJAoekTfOzjuIHz
 YuO//6CAFEnD2qYJsv3MUkW0l94LP1qdCEOKgICuTvAlaz2DvwE2KfE
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When dma_request_chan() returns -EPROBE_DEFER, the error path jumps to
disable_pm and calls pm_runtime_disable() even though pm_runtime_enable()
was never called, leaving disable_depth unbalanced and the device
permanently PM-disabled.

Route the defer path through free_dma to skip pm_runtime_disable().

Fixes: 6bfbf4d0aa0c ("spi: img-spfi: Use dma_request_chan() instead dma_request_slave_channel()")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-img-spfi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index aec724e3f824..a9310a1b0354 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -611,7 +611,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 		ret = PTR_ERR(spfi->tx_ch);
 		spfi->tx_ch = NULL;
 		if (ret == -EPROBE_DEFER)
-			goto disable_pm;
+			goto free_dma;
 	}
 
 	spfi->rx_ch = dma_request_chan(spfi->dev, "rx");
@@ -619,7 +619,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 		ret = PTR_ERR(spfi->rx_ch);
 		spfi->rx_ch = NULL;
 		if (ret == -EPROBE_DEFER)
-			goto disable_pm;
+			goto free_dma;
 	}
 
 	if (!spfi->tx_ch || !spfi->rx_ch) {
@@ -647,6 +647,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 
 disable_pm:
 	pm_runtime_disable(spfi->dev);
+free_dma:
 	if (spfi->rx_ch)
 		dma_release_channel(spfi->rx_ch);
 	if (spfi->tx_ch)

---
base-commit: 1701fda2f58e345c050f4309971bdc07cd6146ba
change-id: 20260807-spfi-dea6148b58fc

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

