Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E4340F751;
	Mon,  3 Aug 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767226; cv=none; b=qaRQoLjGXDeDcCQjf5ICzwKjL2WnBJ8Y82a1NDrez7z5sChD3Bs7xaUCIU4IlDXesLfrNL6NIsA7RFeiMxKTre38b6LGaJldIOD7JIQoiE/TnHNvsvNYor96JX0Xb0gICiIPNc70MNoArgh32+9CwUISb+FNrgbgSGhFuu+6DFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767226; c=relaxed/simple;
	bh=dMSS7IFN/djg1r4lUtSD9LJAu4E4NfU9W1vmzJoQ0zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky5KY9REhooz6gfejX60sPf2X1oWT6Oktm96fHAT+DG5AbRwZS8awNj+1/RRi6owNxhpS2+IH4ZBa7dq6W7z7wAXsEc6eppDbCiJvxRZAEse0H69BJOwq1N+DllN24MtWKEiv4bGGfJOqxEINzZdKkB7tjmTWq7nrUEdzWXBQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imWpEIu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imWpEIu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821CB1F00A3F;
	Mon,  3 Aug 2026 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767225;
	bh=6uD6QEkytfnVGllMV/alSAyNpq5AY0njMQmDldmoj+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=imWpEIu9ICb2G4HuNAmmxDo8Fm4Z1R7p0Y0vKZByZZndT5hvqchLa56bW3iRXLQag
	 GYz35+7a8SKSEED7iiHJLJTsAloCRSQChPeKD1CQqK2XzmFj4EV8lu8AFkMrZYE7q7
	 yATCpnnKqHOIfyYpNBMxg0n0SDEcoDhnnNoQPiA/L+k8QYgFgA7xNBRCWqzX8nreyR
	 B15DvFAvSIcHfpIFjXj/gdzywOufYikVWumadOIBGcZvzAdAgJ538pgQH4+AL2ZVPq
	 Q2LnqQLbTjncl/W7N/zGPJLXqPFaU+a6tDAQKgot6Iftq1mgSAzEGSm5geJFTGOHhA
	 XPePSS63qqG3g==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] spi: cadence-xspi: only use readsq/writesq under 64BIT
Date: Mon,  3 Aug 2026 22:07:27 +0800
Message-ID: <20260803140728.12747-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803140728.12747-1-jszhang@kernel.org>
References: <20260803140728.12747-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, cadence-xspi depends on 64BIT. This dependency isn't from
cadence xspi controller itself, but from marvell support code and 64bit
slave dma interface performance optimization.

readsq and writesq are only available under 64BIT. For 32BIT platforms,
we can fallback to ioread32_rep/iowrite32_rep. So we can remove another
reason of the 64BIT dependency.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 784619f17b40..39c868a5b171 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -454,18 +454,20 @@ static inline void cdns_xspi_sdma_read(struct cdns_xspi_dev *cdns_xspi, size_t l
 	void *buf = cdns_xspi->in_buffer;
 	size_t offset = 0;
 
-	if (cdns_xspi->dma_data_width == 4) {
+	if (!IS_ENABLED(CONFIG_64BIT) || cdns_xspi->dma_data_width == 4) {
 		if (IS_ALIGNED((uintptr_t)src, 4) && IS_ALIGNED((uintptr_t)buf, 4)) {
 			ioread32_rep(src, buf, len >> 2);
 			offset = len & ~0x3;
 			len -= offset;
 		}
+#ifdef CONFIG_64BIT
 	} else {
 		if (IS_ALIGNED((uintptr_t)src, 8) && IS_ALIGNED((uintptr_t)buf, 8)) {
 			readsq(src, buf, len >> 3);
 			offset = len & ~0x7;
 			len -= offset;
 		}
+#endif
 	}
 	ioread8_rep(src, (u8 *)buf + offset, len);
 }
@@ -476,18 +478,20 @@ static inline void cdns_xspi_sdma_write(struct cdns_xspi_dev *cdns_xspi, size_t
 	const void *buf = cdns_xspi->out_buffer;
 	size_t offset = 0;
 
-	if (cdns_xspi->dma_data_width == 4) {
+	if (!IS_ENABLED(CONFIG_64BIT) || cdns_xspi->dma_data_width == 4) {
 		if (IS_ALIGNED((uintptr_t)dst, 4) && IS_ALIGNED((uintptr_t)buf, 4)) {
 			iowrite32_rep(dst, buf, len >> 2);
 			offset = len & ~0x3;
 			len -= offset;
 		}
+#ifdef CONFIG_64BIT
 	} else {
 		if (IS_ALIGNED((uintptr_t)dst, 8) && IS_ALIGNED((uintptr_t)buf, 8)) {
 			writesq(dst, buf, len >> 3);
 			offset = len & ~0x7;
 			len -= offset;
 		}
+#endif
 	}
 	iowrite8_rep(dst, (const u8 *)buf + offset, len);
 }
-- 
2.53.0

