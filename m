Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190716;
	b=rIChRsyiCWkFvgaua9M85JIUXeKk5BUxgUkaiwjgif2s4PNJhpemu84nCL03cCUnD7Qc
	 VlX22wS1eokaALdqgL3hgkGVWFCS/arQwj0iDF9ADicAlv8UB/dKvK93ovgQGnvgEG2Kq
	 pDdyZvLiV5hLJJ7MloJzd+lPxKPfKQSCTymzMGelCI+zDGGvITWmPuKbtFeXHxuEnNlmt
	 uYTmmlQG4EXKZ9YNB8vpt5jF6Au5XGMatcBrYFheV2EMaagfddwZSAdGNd7G1FTlu3Txa
	 AgtxVskfBmULCdIruSKDJ7u9HsxlKKN+gKwG0RpNkTvirhSv1K+bqb6abft3tSqW9Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nmGAkRQuZY1WnXUxjgDk5sO5Kth0S7mM5PEwkEwxFCo=;
	b=Ytsy5xC1Aag3iL+EV/LmV5nMruDl098UmQ9/IGPbRez2aZ8PXSBzuSMwC/KVmoc22ees
	 NJfuCp+qFuRenAdxYEgi/omEmMDfU3ARu8wgHjMH+NWjrmcK9e9YjgCrE47vzR6bMiTvg
	 plwk3YJr6eL8sftVaoUK23QMivBNgK6bXGy8xWJQ9tUhFmKscMIQ8cPaKO9Edxd1SlEqQ
	 BEqpQ1xdgwYXP8lqe6OOYiTI2WDwm2ucPux5juV7N0buVWhojmoenAEBaF+m4ZcHfF7xi
	 xctT+CKE0UraJPL/QAnFfS/UhnTwGDcltSpxFJ0Mlny4msGxhs4/ulsfe0ZkndYq/iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q35aRVP6;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B4606A320
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 16:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 001B4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q35aRVP6
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so1005900a91.3
        for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 08:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190715; x=1795795515; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nmGAkRQuZY1WnXUxjgDk5sO5Kth0S7mM5PEwkEwxFCo=;
        b=q35aRVP6+eZXAUEoKHKYT+B/VyAvxIT9w9lNOTZ1Yd0ZdeoYPDQ7YXRch0Gn13kLf4
         idH1INhXq/gOFn3C+qrNDGX8ZnWdgOQYO2k3oaw3/z1gZ9rrDAmSwTgyL++No/6sbRpJ
         ZwFvwAMRZnIhyqcrKX8j97ZMxul6ibmIYi9ml7xpTGuoj2okKOwlYAIrDPauP8Fh/jW4
         1+Y0Djamwi8eiPP2A/Dfax/NNkuzBDK86d4wPwPa+0gWjCVJ/HCvh8VUb3TQd2LPiwUP
         mBdekerm8qqRJOIWBJ32SS/3th1t7WcKqULsAAoHxHymA+yqaMkFiHxle6kDkKiYeCZ1
         8M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190715; x=1795795515;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nmGAkRQuZY1WnXUxjgDk5sO5Kth0S7mM5PEwkEwxFCo=;
        b=s+P+5BA41sAgBGgOXpcpTYz/elKeOFdWkKwBCvPabdFhNoWhDohb9Zy6xPL4ReOSlN
         AV06sQzh4sWQzyQnYUzdxgzOMEFrUkHygfDz5cT9Jgq8Aba7MJ4aXKOQt83P8PSQIMv6
         oI+Y3u6aoM4SyoTdTQaHgDtFdw+9u6ogZRBzraxF4zOwCh4swYbnzd2M3tHosNQ+AqDF
         l/FrfOlUGXaWRI3TLoWhdjm/vXFDymw9NsOiwJ8IZyTEDCAGr7y/7BVrcBmUhE0dnMb8
         gI2MEMznFUfANxAgYzLXAij0mL1nIraumDLjaV8n5C6+iyy+/adNbHK8NQESA1DS3/V0
         cSLQ==
X-Gm-Message-State: APuU4Z87LgUYabr4Kn6CBScX38+z72pinMpV5/MJDFzAfMwkwR73e40l
	0gvhtQTbWjKV6NTgqkzdvMSgOgayGRC6pHxEm/AE4jntpPKwVfVMDUgz
X-Gm-Gg: AZFdTZefZUZ+NiXgcapfwE/CSnWzH5oanBMa40S4URg60uyXpLtzPyxefWWL2kbqRiR
	uweHKI7exwrmtbzKp/rq1/mrwEmj1B+NrNEwZ32cxHludel0XEQeU/D6+NdEaRLFn+TYTUmlhkD
	elOyxW5g/2P3C+LVf8zmnBZSVKoEnxCcQf/H620LDN/WHAHJWEvHNxTPd5wwozZf26rP7H7zFNy
	bOUeWkJ8FSKbGSyAB47ctfvTgvChBhT+ZHUWRhnspb3QGzXxMr5GkoWQThH9BPFJPOYRCPiWUUV
	9v7SyMh3Fy74oOVGk8X7N1UI09EnrNmX7EEnTdffn85x3jDPUug8Nedj2C3LyhVauBxmJ53jsan
	1nFrS+m8OURfK1ykqy8d1rvJTdn4aNDQWv2Fb5UsizryjehU84YwMuQu2ByCGg83TW/4anji6Hn
	j6WCawJ6tAPHAQW+s4UlWNvc+Hdeu7oaZQIVeN42OC3LOUeyNf773RxJBmB7Lxi+4XtdI/EvhF7
	LuBKpsdYOeFXdVl3BL6gLC6arfeCv4RNRu+qwvyR96xDRo/bNgYenk/LiRthjVKuks6p89GZZTX
	z1BjfaaUf7Cn8VlRtiMtnKuyuRgPjFX5Y6tFe1Lj4VDob5hQ0GNCOEi4Wy7trl+RnPvirSk5HOz
	GV1Ip1CapYuxbJxAMgWJ63RM=
X-Received: by 2002:a17:90b:1dcd:b0:3b0:9e2c:9b57 with SMTP id 98e67ed59e1d1-3b41c7c7a57mr3608641a91.4.1795190715046;
        Fri, 20 Nov 2026 08:05:15 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:b6e2:dea:3892:877:4c42])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-cde6c9c7dcbsm1603907a12.0.2026.11.20.08.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:05:14 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 21 Nov 2026 00:05:02 +0800
Subject: [PATCH] spi: sun6i: Release TX DMA channel when RX is unavailable
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-sun6i-v1-1-ce211aace0e8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDVpS0tcRSyowViUdBCJuLti+
 SX/excwBkKGKrkg4EFMi49QaQJuav2Igvpo0FJbpbQUvHtLwmRYmrbIO4cSYrsGHOj8furmN+/
 djG57x3DfDwoQw2ZpAAAA
X-Change-ID: 20261120-sun6i-53e85a74bce0
To: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795190709; l=989;
 i=ustc.gu@gmail.com; s=20261030; h=from:subject:message-id;
 bh=g4Lb6UCytjHFAliWTA0cYV0Jre5Cf+YcZAPH67r/ocE=;
 b=Dd0N3HYfVymgF6axdUG4tzKPVuPJMdg0NT7r/hxBQv1Vpr01tfeYh4tAlWsi7ze8GekFVwrPw
 Uixubio1FDTBDj0Lc4F9ZG/XqRxTfDJo76IjmmUeBFAlPEllNz/WoOP
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjDJtbnSeysEBjmOfNYqYUUDS6g7Tfov9W5oGngTBfo=

If requesting the RX DMA channel fails, the controller falls back to PIO
because DMA is enabled only when both channels are available.

Release the TX channel acquired earlier so it is not held unused until
driver removal

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-sun6i.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index e9fce8618299..f6d1699f1116 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -709,6 +709,10 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 		}
 		dev_warn(&pdev->dev, "Failed to request RX DMA channel\n");
 		host->dma_rx = NULL;
+		if (host->dma_tx) {
+			dma_release_channel(host->dma_tx);
+			host->dma_tx = NULL;
+		}
 	}
 
 	if (host->dma_tx && host->dma_rx) {

---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261120-sun6i-53e85a74bce0

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

