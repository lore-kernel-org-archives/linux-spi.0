Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE53D9549;
	Fri, 14 Aug 2026 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677330; cv=none; b=AwhUc4fbtUJAfPZrGe14QjL4utyTXcvVyRJ1l4W2YSEEL8LA9/swYH8nCBr1kyJh4nvq3OwwtX/1dXxpKvGtijYnME8KmT4Iny7F8z3jKjOUfaWpgye3bs4Kb8YTS2QBGGjlPpN6dUYT81uSAnn1AwuZHN29SPe2uWy0UY7rQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677330; c=relaxed/simple;
	bh=J9XbMsxRndxGJyUJZumUqWe51cotzgOck8sh4nWLj88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDRLOC0Kz28uvO3Zi55t0t6v66kRglFhRgAw1jsUcox0DiG3ARFWs041F5WYUuRoNdA+wDOLO+0ReM+LIftVV3oJsYK/a3cHEUj/ukW+0u8PeJP9Eztp265TLvAxzOiq1GYcCtj1NqXP2k0VyKSqal9SZUVRvB6pACLs+qnLIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hs/PRPTa; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hs/PRPTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Bi
	W95dK0QU3NeJPlxhPQThilW1+H2m99HL/aqjlINd4=; b=Hs/PRPTaufseRlEMvH
	t2RnB4P168S74G0RZnc6ccNucG/FGSSTBTTea25+1008oDk7a7UV3JMw3ZInUlxv
	HFj+xxKV4dVuRdvTVfNQfOjRK5bylx2M8OMhnENejDy9z264KeJgff3QX71Y8P12
	yVgTQ+OmMW0+LLIDwzXo+y67c=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3n_USiH5qk89SOw--.19210S2;
	Fri, 14 Aug 2026 11:14:26 +0800 (CST)
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
Subject: [PATCH v2 3/4] spi: Clear current DMA devices when unmapping a message
Date: Fri, 14 Aug 2026 11:14:17 +0800
Message-ID: <20260814031419.43378-4-jiang_hh2019@163.com>
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
X-CM-TRANSID:_____wD3n_USiH5qk89SOw--.19210S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr47CrWfZw1fXFWxAr4fZrb_yoW8Xr15pF
	4rKFWUCFs5KFWFk3Wa9a1j9F1av397XrW7G3y0yw4Syw1kXF1IqFyrtr15XF9xZF48A34j
	krZ0ka18u342yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEmL9UUUUUU=
X-CM-SenderInfo: xmld0whbkkjiirz6il2tof0z/xtbC0xJgoGp+iBLPpgAA3m

The current DMA device pointers remain set after a message has been
unmapped. Existing users either check the corresponding mapped flag or
access the pointers before finalizing the message, but retaining stale
device pointers is fragile.

Clear both pointers in spi_unmap_msg() after the internal unmap
completes. Keep them intact in __spi_unmap_msg(), since that helper is
also used during partial-map unwind and the in-message DMA-to-PIO
fallback, before processing of the current message is complete.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Honghui Jiang <jiang_hh2019@163.com>
---
 drivers/spi/spi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 96f5058c7..e5b1531b9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1373,6 +1373,7 @@ static inline int spi_unmap_msg(struct spi_controller *ctlr,
 				struct spi_message *msg)
 {
 	struct spi_transfer *xfer;
+	int ret;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		/*
@@ -1385,7 +1386,12 @@ static inline int spi_unmap_msg(struct spi_controller *ctlr,
 			xfer->rx_buf = NULL;
 	}
 
-	return __spi_unmap_msg(ctlr, msg);
+	ret = __spi_unmap_msg(ctlr, msg);
+
+	ctlr->cur_rx_dma_dev = NULL;
+	ctlr->cur_tx_dma_dev = NULL;
+
+	return ret;
 }
 
 static int spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
-- 
2.43.0

