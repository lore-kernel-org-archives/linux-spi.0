Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B524457A3;
	Mon, 17 Aug 2026 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980829; cv=none; b=XbV6LHAZRVrmzfIIiZewwAc0CKA7L4DS2vDuQ0IjR+XpZv2djZtyK9t9Q4TS7zO53iQpZkyJvjakQEGpZ1n3Wb1+OYNfom2bCv4WiO48bkisvQB+h44ZQKp9GsYHEviKj/SGA5kCFPsE+RZuJzlxgki+gQb3m04iiXekLZqummk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980829; c=relaxed/simple;
	bh=AJEVyUufuEw/cA7FDQs6Ot+e7oyx8PwO8gg1XD380mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOE7Blj+xOqkE6YaEy6wdihS2npSgddzkTaE5lVQUjgovhZVyoUmNSJvZDMDJKYU2tsmwxnlNF1Ks8DNvxh7SAo+t0xlQ8oxJ6sVhe7ivG+GxDBI1MR49S+biW9FlNqcGXRmeUBA1DZ8cOe55AYlvvfsegBOSbM4/riFH7DXe9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M91IJ3Vq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M91IJ3Vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3F01F00A3A;
	Mon, 17 Aug 2026 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786980828;
	bh=MdWXow5IpF+qkWj5WkeTBDxTAucTX7Bn9hGMobsDAgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M91IJ3VqtMhC1zI2PX58NQSPL+i68ptu5bsjNRDVWrTYMA5tjO6gKVTJU0D5IZn78
	 DFBBWfygEyjrRsfBEoAkIpuTjimUkAFknOlj6/cyXXO//m9aWZTtTVvBP/eJhrs+q/
	 U7qKxtaH91Y4vGfUnZBMqRJYh3UhLn4vahPTzd/WwBuAq2rg4HarJbLC0MWMgUSbm1
	 gq0xESbNZb1xjEGSqR2YQWfdRNIt5UVo6fy0PVKRzmJNXxc5oirLGwHQ0flyIKjNDr
	 cVesaKYX5UTSBgEHpB3piVeEUdpFQiexUgKbmEgdFMkcJ9VuXxkuFthwy/Ohe0uuHg
	 d+k9OgAxmopeQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: dw: use DW_SPI_ISR directly
Date: Mon, 17 Aug 2026 23:14:03 +0800
Message-ID: <20260817151404.28324-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260817151404.28324-1-jszhang@kernel.org>
References: <20260817151404.28324-1-jszhang@kernel.org>
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
index dfce2fa20adf..299474507663 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -275,7 +275,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 {
 	struct spi_controller *ctlr = dev_id;
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
-	u16 irq_status = dw_readl(dws, DW_SPI_ISR) & DW_SPI_INT_MASK;
+	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
 
 	if (!irq_status)
 		return IRQ_NONE;
-- 
2.53.0

