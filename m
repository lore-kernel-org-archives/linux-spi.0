Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D539307481;
	Mon, 15 Jun 2026 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499603; cv=none; b=JrMTJvbtCL+ak3UutrmsuoZlkc5/WheYGTtRJapbce4JQWeWdbP/qomahpvviKTiyTa9+ER7BVfnBFzI5jg+Dl9gEpaW0aFlW71jjJEqNg7PeZDrXuojeeNsjngBlMQpWQffDCpNWoclLRPPGWkg71LpY87UHrLfZqkPVQZGWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499603; c=relaxed/simple;
	bh=AZlgW7qRAITiP/6Y8xUa+CpmeziIZNDVjEE+Krq8UN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbtHGTN0UtbB/iqQ7tJvK0v6GTZaBHLSxk1ExBddGZ9t/GrQ/yKUN49kcdl417XO5Rc5OONtMgEo8SaADGFswf4wdE1IstfJcybDpJw+KBCqacGfDTFdVeEXndYzlaZkoEifT6BPGepa50FN9W57Tlvb9pzflulJP841TPkD9kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjSZ+Ado; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjSZ+Ado"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0511F00A3D;
	Mon, 15 Jun 2026 04:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781499599;
	bh=mQmxe/7ASJ84QSczEmDFxNbnqKh9r1vO3tpg/sTve6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KjSZ+AdoXggjzxYiNUUjyprn68361Gsw5eBoWeoc0+Rs6REUzr9RMpXJODcLRyh5e
	 iy5w5pBLcdOGG5sDO4qW+OHQjUwfPKYrCb4/RLnBycRH2lqe7H/0AQRMuux8Gh96os
	 7kU7LftA6BfiKHxDWG0V4zJgZl/iz3n86Idi0FASZYD2NAu8n/p2aeMSjim4/+yV8L
	 zEhk91suaJnxGdvVYpFni9NQ2KH0E2uT45j+PUm+VdATgrynJTY4nSYTGo/I5ZpVhc
	 frdlCEQGoZJfsox+sm3ZOOw+OiMmYU6xPR19B2qXwWmm/sdyPcu17ljbuAX4K4FQXi
	 4HBVADWU+TVUA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] spi: dw: use DW_SPI_ISR directly
Date: Mon, 15 Jun 2026 12:40:37 +0800
Message-ID: <20260615044039.9750-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615044039.9750-1-jszhang@kernel.org>
References: <20260615044039.9750-1-jszhang@kernel.org>
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
index 02e0b4b66a5b..aa2e51d0f959 100644
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

