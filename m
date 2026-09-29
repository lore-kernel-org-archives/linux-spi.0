Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1A524AE8;
	Tue, 29 Sep 2026 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685494; cv=none; b=mkckStkbkLc8rDNhitrZPZS+S6G0DmVtZnrbU04gKJR0byEGx4NmqUGCL8LVIN82k8/l3xGo7ccBVerHdGL+STP6F0D7+Qzikuq5DdAYXNV4wUYYonXcXBrCEG+7HZ1gXbDRjnvrkp5ynotHyjzy/NdK1IfMyYSyk1Hs8pLUwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685494; c=relaxed/simple;
	bh=PnJBgVnbIgcWLNLYch9cQewKsDFIC4Led3KTymkokH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CU/fxtEElOTKJ/QP5TqHcZaQeWCR7pv0C9LOz6JKG0ZRroq0GFsCZji4nN90LsJ0M+khW/N4dE3AvJV1AxfLWC3Ad7RLZiSzjIGwX+W5JEymnBOOZGfX4WRWWT1xzdjmVSzF4HGsGKQZ81qAd/HvAvzNKvCwUk2f3NjB2RCYIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W62Ep8tg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W62Ep8tg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70B91F00893;
	Tue, 29 Sep 2026 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685493;
	bh=xQvqh5V0jEHbs9qUBqtF9FaB1INU8MfQPD5WaPzmvXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W62Ep8tgE+ySxjojeOR3jnKlHVdgP8VdVCPFperhYxYzy9sg3KDEAgZ9VEMvbROou
	 564WHbkJgnXg5x1Ui5KOc0qCXRLOqEhWxCDwZo+fPgIOq6tBxzfVS8LXK/Q6F8N6DA
	 HyZr6IQqSHaXM8nCNCvx31w4nB43XOvZAmhSqKYiTgAIGMFgEuw+ACJU/0/OJAhXmy
	 nEfxVSBnFzWuM2CLX1uQWGu1zSJbr2lsEluML0KL6U/np56tNTsxV0UBEPhgtBoH0d
	 RKVZxZ/pg+s/EUy/6JTa/Uwr0VFJ1P/lb/LRbhmbmH6RQBaILTGLZMP8KXS/JgPuAu
	 IbICRk56PkHOw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Joseph Steel <recv.jo@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] spi: dw: use DW_SPI_ISR directly
Date: Tue, 29 Sep 2026 20:18:13 +0800
Message-ID: <20260929121817.20896-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260929121817.20896-1-jszhang@kernel.org>
References: <20260929121817.20896-1-jszhang@kernel.org>
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
index 206d3f9dd83d..1c060f0ec50c 100644
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

