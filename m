Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2B19CC0F;
	Mon,  5 Oct 2026 03:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791169515; cv=none; b=kMrwSzak/WjVe7i/8AjbQ7zaatLw3BVYnxDb9iWtGsOT4pZ7VWrLXV++gDETzAmM9mNlhkhXO7oQmPxqq0xf9Iz0DfrngU1+G7NjOGTUmVROrqirHhCgOZ2ehE4khbZ04PMC1AkEMlRveZUPQCQo5d855NtzTs3eqDmZty+0SsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791169515; c=relaxed/simple;
	bh=4ThieVKx/TFwBkWagojv0M8KJEVMT/tJo2XCGYuKqHw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RO8u8IfH2r6ot9MjCXWjGPEUz+NNRUDrOc6pPQpEOlpnbUMN1SFyZIXDDc1536XOYchQHITj2azHaAHimKSUrdLrn/vYfZlH7lSniTcN+ff9FJOtQM+nLz1DEMwDawnxAhCIB68HjX6/XmDkp62YKiy0OTdTB6f3u9j/aH6cVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aIxY/XJ5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aIxY/XJ5"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 695354mV41602177, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791169505; bh=Mjthg5LLKKT3K6s+h/Zd3lavq/g2mhz4Kqt0gkqG3CI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=aIxY/XJ5/UdseLdusW6v624k+VlRWvQs+ANxdjV1sDmbLGOvvk26wqay8o63ppP7q
	 Ws8ZoxXnLxGWsLvHMnQvSGwEO/6aGa9M1cjgcWRoH+4l1W4G7XZePBm52Bpat0P726
	 r0btsQSOJgqlqvuf1A6sPpw4UmKTgF+ChVLIvkYBBJ7d+60nud0dsNOCx0WAw/Y8kx
	 PEk7bDyQCdDywciN50rq2PfRf6bEE8QXRL+3knXYMZ/lrCkvQ4ebQ6zntrMqFuWnqZ
	 5UkabtasXfuP/e7+nZInBsNfhSvr7muuVbciPeH7v+biqfxwO0M9JGP7S71NSvFcJ3
	 A2GGnBM+l/aJg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 695354mV41602177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Oct 2026 11:05:05 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 11:05:04 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 11:05:04 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 11:05:04 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <broonie@kernel.org>, <error27@gmail.com>, <robh@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jyanchou@realtek.com>, <cy.huang@realtek.com>, <stanley_chang@realtek.com>,
	<eleanor.lin@realtek.com>, <james.tai@realtek.com>
Subject: [PATCH] spi: rtk-nor: Fix incorrect boolean return value
Date: Mon, 5 Oct 2026 11:05:04 +0800
Message-ID: <20261005030504.2651773-1-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The rtk_spi_supports_op() function is expected to return a boolean value.
Fix this by returning false instead.

Fixes: aca8cbecdd2e ("spi: spi-mem: Add Realtek SPI NOR flash controller driver")
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/lkml/20261002111238.zmU8TY9cdPo1jRPt_Xg1el9kj_ozynuVbJQ2-farWEs@z/
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
 drivers/spi/spi-rtk-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rtk-nor.c b/drivers/spi/spi-rtk-nor.c
index 7f56346506b3..75856c31d2e6 100644
--- a/drivers/spi/spi-rtk-nor.c
+++ b/drivers/spi/spi-rtk-nor.c
@@ -344,7 +344,7 @@ static bool rtk_spi_supports_op(struct spi_mem *mem,
 	 * multi-byte stateless commands are not supported by this controller.
 	 */
 	if (!op->addr.nbytes && op->data.nbytes > 1)
-		return -EOPNOTSUPP;
+		return false;
 
 	if (op->dummy.nbytes != 0) {
 		if (op->dummy.buswidth > 1 || op->dummy.nbytes > 7)
-- 
2.43.0

