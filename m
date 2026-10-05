Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2FE4BD7AF;
	Mon,  5 Oct 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214666; cv=none; b=Ftaasl2jWIxFneGsx1YP5CpiTnFUW2XBnpd4D1MBM6gHdb0tRauvGZGWWY9UilzIPIuOACyJy0N7qoeDqLNbxT1km+2pOoSx/DDpdc0UtDWBDhQDyPNCrLOtnuJ7owTZBzZV+UaoAOuju/OhELzuwcIKaUUwdhQp5T1IyDMSjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214666; c=relaxed/simple;
	bh=nGdYLg2zESTGFIBGHK2aAMM0kZU4gOJ3f7MRReBq8ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuI2DpdY64tdS3bRJ5EVMFMQz6yVqdERdJLvF6dtvqmwK002TtP3IGD+eF/VrQk/R/HXSIdHJuS0Qx6wd+umjNb1boJvKmvrJZD1+egT9F/zjlr1QMj5psyRFtyomWAJ6V+6jubd8xPEdLAzvEZkbZJvHKVR/PQ7UDNKhrZ1+DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hStecTDS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hStecTDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9051E1F000FF;
	Mon,  5 Oct 2026 15:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214664;
	bh=IJiZ2TnXxmM1hKMOJEegUtvDgb/v3wkQbBVQFfOo6gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hStecTDSfnONFVIbkFQ7NvlbV/TxRmHNkLKggP6GWg1Kz/3eIu98rDvmE6TKWwwfX
	 ORpYBK6R/OvoBGCC6LJ18C1tXYTwktpzKmYNcgTZ/yadkswnPKE+vUsuDngA1VbCFL
	 fWAEwOFyYxR2/e/OCyiIIhNl2tLQe/ZQ4WvmZrRBGRz1PzLExukuqKU6/bacGQjv9A
	 euRXTRDXUco1QMkpmeg8kFMf7WV/wE0XNGk68+n7I4ia8wpJtqgjqOnPrOVUVgvT1S
	 nVcqqK6r5R7yIcad52iV/WeYr82Qf9n2GYDImXyMrHl3wlhL6FCJxH7LpmcqvnmVNS
	 VcYeKeLD//WAA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Joseph Steel <recv.jo@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v5 3/4] spi: dw: restore previous irq handling behavior when !ctlr->cur_msg
Date: Mon,  5 Oct 2026 23:17:38 +0800
Message-ID: <20261005151739.25233-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261005151739.25233-1-jszhang@kernel.org>
References: <20261005151739.25233-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent "enhanced" support changes the dw_spi_irq() behavior a bit
when !!ctlr->cur_msg:

    if (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler) {
            dw_spi_mask_intr(dws, 0xff);
            return IRQ_HANDLED;
    }

But it misses the dma case, where the transfer_handler ==
dw_spi_dma_transfer_handler, so this changes the previous long time
working behavior, let's restore the previous handling by only filtering
out the dw_spi_enh_handler.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index f82a632ca71c..06f4b0ea954e 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -280,7 +280,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 	if (!irq_status)
 		return IRQ_NONE;
 
-	if (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler) {
+	if (!ctlr->cur_msg && dws->transfer_handler != dw_spi_enh_handler) {
 		dw_spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
-- 
2.53.0

