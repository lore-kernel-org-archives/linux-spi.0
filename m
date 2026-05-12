Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CD410D08;
	Tue, 12 May 2026 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572141; cv=none; b=Ef1l/+oVDxOHDVJPF0Eot3HnmpjjMRXXKARFMYbBpR4qIjkqpeL8SaO70evo+pKNYwzylBgLKKWuInkOvWM9VFcBXR2/dmS30iNbVjitW7DN/0JueyIBqArgVTWtEgo5m4+ryjlgwtSWqD7E2S89d0NGG9/TA6u61Lmkysw8MSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572141; c=relaxed/simple;
	bh=C7+2tlfJt+/60Cg5T2oLZMZSQjrjNWEbEFuBQH9/ZBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qo1boKC7CM77zqg5SkIU/YMp2qhMTfZ76QzWy/DnKduzC10pktEkkwuw8SAsfMR9EaRhVcSXjADhkJUh95qkA6/Hbt5L7EciM/T3liww4JOsz9lQvdX3xG7pvbGpsh/avgnQw9+J8gBfEKxp9a66qFMHj8wxVQDqExRegmoFm1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceQ1t0th; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceQ1t0th"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEFDC2BCB8;
	Tue, 12 May 2026 07:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778572141;
	bh=C7+2tlfJt+/60Cg5T2oLZMZSQjrjNWEbEFuBQH9/ZBI=;
	h=From:To:Cc:Subject:Date:From;
	b=ceQ1t0tha2wzT/2FtJ+na72a9e0WSaA5g0kh81LEe3Kr+OJ1AMfSexegLUyUPpvlk
	 xxyULB7rUfTPrBvnELy2q5TfIloV0r4uHB7H0pUn6XyDweyO7QFruUgTQTpvpTnz/F
	 S3vSQUbpgzsuJHAjC01JGWBJBKVGEtzy1pG1LYjP5ZFdQSeroLHwIvGIfLBYwBLzaM
	 XpNJrSz84oeZQo54M13Gnhq7s0iutyLlGQwhI/rrY/70UPOHk+5eJCkKOvKgsp3oLX
	 dbstAmTQsA+WoiHCs2cS9IR7YqbOAFH47DEt7DjbBafo4ibpGo90nRNqM+yau8eStP
	 poQzGy5s758Ng==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMhrO-00000003q4e-33xq;
	Tue, 12 May 2026 09:48:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH] spi: ep93xx: fix error pointer deref after DMA setup failure
Date: Tue, 12 May 2026 09:48:49 +0200
Message-ID: <20260512074849.915143-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to the clear the DMA channel pointers on setup failure to
avoid dereferencing an error pointer on later probe errors or driver
unbind.

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: e79e7c2df627 ("spi: ep93xx: add DT support for Cirrus EP93xx")
Link: https://sashiko.dev/#/patchset/20260429091333.165363-1-johan%40kernel.org?part=10
Cc: stable@vger.kernel.org	# 6.12
Cc: Nikita Shubin <nikita.shubin@maquefel.me>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-ep93xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index db50018050e5..f716c9607be4 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -582,12 +582,14 @@ static int ep93xx_spi_setup_dma(struct device *dev, struct ep93xx_spi *espi)
 	espi->dma_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(espi->dma_rx)) {
 		ret = dev_err_probe(dev, PTR_ERR(espi->dma_rx), "rx DMA setup failed");
+		espi->dma_rx = NULL;
 		goto fail_free_page;
 	}
 
 	espi->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(espi->dma_tx)) {
 		ret = dev_err_probe(dev, PTR_ERR(espi->dma_tx), "tx DMA setup failed");
+		espi->dma_tx = NULL;
 		goto fail_release_rx;
 	}
 
-- 
2.53.0

