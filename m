Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72E4137BC;
	Mon,  3 Aug 2026 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767185; cv=none; b=o677TzWp41pu0uxwS7CO6qIMI4N4W2A1M0RvdxqJDvMCpjQJhoeCz1pFfvFbSdThhdxpeGLeS+Xai0UBb2TyQu8UKJOEcVWnk1LveYVHEmZIFcDhBsrhU3LS6v2al1o6NouQ003NGFgVPPvJgi0P+8Gx+RegZQy7WVFoC/aDgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767185; c=relaxed/simple;
	bh=s/F7ZoCxc/w7/vMle1KirNom5WUKx1ES8rIOKvpXy5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzgY1DMvK5Dn6nwbXI3xyX224G8sQ4I7wZk3tIgrpl97dJ4sXyOEKlanTCzesYnwavkOZ0LHIt7XQyGLxkuVYwnRpeOvxgX031R3e7DWV6XhKkKUIxeZlt9KlVWVwvBuOyHQqsw9i/ps6IikFLuY4rmXU3OaZYQriyuz7YJUYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or0Qtt6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or0Qtt6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E151F00A3A;
	Mon,  3 Aug 2026 14:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767183;
	bh=3rNPkhcAMJtdcHCaXJv18wIfs8IPQn8JBx9mfmWihFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=or0Qtt6fFA869XX4WdNf2AgrhKmBHg/R+Olsav2bby+eZti23o9sFU70GAOMjEOCp
	 49Z5KB89oXBVNkbdFR5juJhvcyCDufOOx0jvjir8jJMtOkFTFddGXWOXO4cHyiDFj7
	 VCYt2zVO4cJsCAoCuPmkrGuLUAIbHa5LhvXRbIxU/kkRrMDMECxRV3PFBcOagqUW9V
	 PWAgKjoKVo/Jqu63Qzdpe2++kihM+0fU2Dy9h8qd21Qxe7fO8axcG8nHCTpeL/lMw4
	 hoAxWVSqvpoIy7QMhqOozTdPsVBmD6kmNeAqNI/i4yApEnzBaz9MyunvKLgw+kjsMS
	 Diq+vVDhWZgkQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] spi: dw: use DW_SPI_ISR directly
Date: Mon,  3 Aug 2026 22:06:47 +0800
Message-ID: <20260803140649.12718-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803140649.12718-1-jszhang@kernel.org>
References: <20260803140649.12718-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DW_SPI_ISR register reports the masked interrupts, no need to mask
again.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index ad8aad958c76..f0d5528a0e8a 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -252,7 +252,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 {
 	struct spi_controller *ctlr = dev_id;
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
-	u16 irq_status = dw_readl(dws, DW_SPI_ISR) & DW_SPI_INT_MASK;
+	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
 
 	if (!irq_status)
 		return IRQ_NONE;
-- 
2.53.0

