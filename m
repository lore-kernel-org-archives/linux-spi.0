Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FA33BBAF;
	Fri, 14 Aug 2026 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677325; cv=none; b=kXkYkjMvnPERgeYeYBEYX8hWm2JfzyLeVZ0ASW/Qq9Gkh1TTjqIKfOtrNMjQ8zc5FbSgbnra/737mcNAYBfHFwIW2nYHNPYg+c8/dIM53i++/0TxEb6j6WWxolK9j23feRXNA9NyJ8FdnbIN4MZvSASEDxl0/Z3DjF92bM97SzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677325; c=relaxed/simple;
	bh=ZImj8O1RwBbSgTOtIj6qO7FCs5lHJzELBM5p9mj6YVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uog4KgX7Mk/5TOYat5rUWqoV6D8z1I7Qe+u/5P+wtjpHgCMNzQymyrtFnpu9keKevRmZx5WuVNFw2OE4MhN7OTAF138e+aRcUY/V2zyBIiqzGvaKbU9PFor/xh9UXvmMgdyO3jefWqv4zsTOJ9OWjXUYp9YNDFyxFxhomMOpgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WF9scX22; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WF9scX22"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Xu
	NlL9yBR16QuhSPEU4qesOF4KWiDHceSxgJFywaTUs=; b=WF9scX22pOKAGumuSb
	vmXa1zbRIyo9S9cstJVOVfU/0MdSHvUSIqksO379CBHpn8TZYMs4AFldAoXsFByd
	PqMYX215DhSjnzt2FytE4icj8O2g55Tc/L88qm2OTW07HzJA66pacrPNXWhMD/K4
	gOPGW3Z9Wmwiv5APk6cFYJe3I=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wC3SQEOiH5qyzohNg--.157S2;
	Fri, 14 Aug 2026 11:14:24 +0800 (CST)
From: Honghui Jiang <jiang_hh2019@163.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Honghui Jiang <jiang_hh2019@163.com>
Subject: [PATCH v2 1/4] spi: Fix DMA mapping ownership on partial map failure
Date: Fri, 14 Aug 2026 11:14:15 +0800
Message-ID: <20260814031419.43378-2-jiang_hh2019@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814031419.43378-1-jiang_hh2019@163.com>
References: <20260814031419.43378-1-jiang_hh2019@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3SQEOiH5qyzohNg--.157S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw47WFy3Xr4xtF4fCryxuFg_yoW5uF1UpF
	43GFW5tr48JF4FgF4Y9w4q93ZIvFZ5C347C34jk3sYkws8XFy3tFyUCF1SqF98JFWxX3W5
	urWYyFWxG34jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE73kJUUUUU=
X-CM-SenderInfo: xmld0whbkkjiirz6il2tof0z/xtbC0xBgoGp+iBDPbwAA3v

If RX mapping fails after TX mapping succeeds, __spi_map_msg() unmaps
TX but leaves tx_sg_mapped set. If TX mapping fails on a later
transfer, mappings created for earlier transfers remain active.

In both cases, cur_{tx,rx}_dma_dev have not yet been updated because they
are assigned only after every transfer has been mapped. The subsequent
spi_unmap_msg() may therefore unmap the TX mapping again or release
earlier mappings using a NULL or stale device. Using a NULL device can
trigger an oops. An empty SG table does not prevent the NULL dereference
because dma_unmap_sg_attrs() accesses the device before checking the
entry count.

Publish both mapping devices before mapping starts and unwind all
failures through __spi_unmap_msg(). This clears the mapping flags and
releases each mapping once with the device that created it.

Publishing the devices before the loop also refreshes them when no
transfer needs mapping. No mapping flag is set in that case, so current
users do not use the pointers as mapping owners.

Fixes: e289df82344f ("spi: Rework per message DMA mapped flag to be per transfer")
Cc: stable@vger.kernel.org
Signed-off-by: Honghui Jiang <jiang_hh2019@163.com>
---
 drivers/spi/spi.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d9e6b4b87..12b3a3b29 100644
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
@@ -1254,7 +1256,13 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
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
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		/* The sync is done before each transfer. */
 		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
@@ -1267,8 +1275,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 						(void *)xfer->tx_buf,
 						xfer->len, DMA_TO_DEVICE,
 						attrs);
-			if (ret != 0)
-				return ret;
+			if (ret)
+				goto unwind;
 
 			xfer->tx_sg_mapped = true;
 		}
@@ -1277,25 +1285,19 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
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
+			if (ret)
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


