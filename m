Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0963806C4;
	Wed,  5 Aug 2026 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942932; cv=none; b=LZkb6uEV0jZtC1TMc/DBrTdmjs8U9cZtXHiwG4LDI/9llepukewRMnpgX0qMeQyff2n0q7PXIN5eol7VY486gU+9TeiU8XWIHfRaJ3RNX0mjctOQE+8uM37tnqwlvrxtxKp/k7E3MMGydv/ydaft+wYLUReirYBINIXvKIdhpbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942932; c=relaxed/simple;
	bh=vpR+RWdNJcp86gwIj9XC2G/BJ+zicPixVXzW41Rfht8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zjf340ehYk7jG7x/GJ7YKI5RBJ8gUMegLD0kMFi9oMhNNgy/3Bm0qJtSoF6Xo4Ku7LEwhMe86tKVvkYytHiRO2SepuuPgMiEh+MrnIL7dqY2Y81wPcdtk3/hkQYyRyJ0XgF87cOuxWN/L2viaX5aYUWypy6s7Y4qBlfwJbJPoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JHGIDfjP; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JHGIDfjP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=IM
	jsJNpggY+DC36BugxXjwMyUnwgPSg8cA3Uxlka01M=; b=JHGIDfjPVTp/9Oy9RK
	vV3UYpQJGjZYty6St7ZKjgge2lGySOdFVtfIUaUjbvWkwiazKAESaxuBoddkbEUq
	/icIbjgOoObgDJ480xbx9okv13x3xJw8IycOrAUX17UTvfLWmc662QZmvC3T+4GM
	skjFTvXP6OFLVTxXZ9CQppS8U=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H31xU3Nq02g5AA--.30422S3;
	Wed, 05 Aug 2026 23:15:00 +0800 (CST)
From: Honghui Jiang <jiang_hh2019@163.com>
To: broonie@kernel.org
Cc: andy@kernel.org,
	andriy.shevchenko@linux.intel.com,
	fancer.lancer@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Honghui Jiang <jiang_hh2019@163.com>
Subject: [PATCH 1/2] spi: Fix DMA mapping ownership on partial map failure
Date: Wed,  5 Aug 2026 23:14:55 +0800
Message-ID: <20260805151456.756579-2-jiang_hh2019@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805151456.756579-1-jiang_hh2019@163.com>
References: <20260805151456.756579-1-jiang_hh2019@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H31xU3Nq02g5AA--.30422S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw47WFy3Xr4xur43uw47twb_yoW5Zry8pF
	43GFW5tF48tF4FgF4a9w4q9FnIvFZ5G347C3yjkasYkwn8XF13tFy8CF1SqFy5JFWxX3W5
	urWYyFW8GryqyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKYLyiUUUUU=
X-CM-SenderInfo: xmld0whbkkjiirz6il2tof0z/xtbC9hVpqWpzU3U-8wAA3Q

If RX mapping fails after TX mapping succeeds, __spi_map_msg() unmaps
TX but leaves tx_sg_mapped set.  If TX mapping fails on a later
transfer, mappings created for earlier transfers remain active.

In both cases, cur_{tx,rx}_dma_dev have not yet been updated because they
are assigned only after every transfer has been mapped.  The subsequent
spi_unmap_msg() may therefore unmap the TX mapping again or release
earlier mappings using a NULL or stale device.  An empty SG table does
not prevent the NULL dereference because dma_unmap_sg_attrs() accesses
the device before checking the entry count.

Publish both mapping devices before mapping starts and unwind all
failures through __spi_unmap_msg().  This clears the mapping flags and
releases each mapping once with the device that created it.

Link: https://lore.kernel.org/r/20240531194723.1761567-9-andriy.shevchenko@linux.intel.com
Fixes: e289df82344f ("spi: Rework per message DMA mapped flag to be per transfer")
Cc: stable@vger.kernel.org
Signed-off-by: Honghui Jiang <jiang_hh2019@163.com>
---
 drivers/spi/spi.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d9e6b4b87..05a852494 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1231,6 +1231,8 @@ void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
 	spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);
 }
 
+static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg);
+
 static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 {
 	struct device *tx_dev, *rx_dev;
@@ -1254,7 +1256,14 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	else
 		rx_dev = ctlr->dev.parent;
 
-	ret = -ENOMSG;
+	/*
+	 * Store the devices before mapping so partial failures can be unwound
+	 * with the device that created each mapping.
+	 */
+	ctlr->cur_tx_dma_dev = tx_dev;
+	ctlr->cur_rx_dma_dev = rx_dev;
+
+	ret = 0;
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		/* The sync is done before each transfer. */
 		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
@@ -1268,7 +1277,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 						xfer->len, DMA_TO_DEVICE,
 						attrs);
 			if (ret != 0)
-				return ret;
+				goto unwind;
 
 			xfer->tx_sg_mapped = true;
 		}
@@ -1277,25 +1286,19 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 			ret = spi_map_buf_attrs(ctlr, rx_dev, &xfer->rx_sg,
 						xfer->rx_buf, xfer->len,
 						DMA_FROM_DEVICE, attrs);
-			if (ret != 0) {
-				spi_unmap_buf_attrs(ctlr, tx_dev,
-						&xfer->tx_sg, DMA_TO_DEVICE,
-						attrs);
-
-				return ret;
-			}
+			if (ret != 0)
+				goto unwind;
 
 			xfer->rx_sg_mapped = true;
 		}
 	}
-	/* No transfer has been mapped, bail out with success */
-	if (ret)
-		return 0;
-
-	ctlr->cur_rx_dma_dev = rx_dev;
-	ctlr->cur_tx_dma_dev = tx_dev;
 
 	return 0;
+
+unwind:
+	__spi_unmap_msg(ctlr, msg);
+
+	return ret;
 }
 
 static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
-- 
2.43.0

