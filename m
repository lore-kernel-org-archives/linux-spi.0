Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF323C3C19;
	Sat, 17 Oct 2026 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223805; cv=none; b=DIl0T+odGey2i5JqDTthyxpaDBY/aFpdoCXySy9A8B3MfeB74E2FXfMCaR23uoMUIRHu8AUqflgE211xMnwXb8SV/puQp5RP8fN4yOp4baMJs/06FvitELE03shlSrZY+Tz43coHZSrk/JJumEkHjf5EGnzZ7Xd5e8sfLulEOlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223805; c=relaxed/simple;
	bh=k61wgDs7T9sK5hYRjTQ0xOh9CdEGiEhFv1LBY+S4epg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIbCGGwzdguDVC8sV1NZvnXdH7Xqtd48hUO/BXQDFkN9NJ7MEvF2f7suqF0hQMVdtcGNB2a4mcYaDZTUAu1rJkLqbG+qJ4/efAm42xLWJt7DArQIYn6FljNMq8lZqMKx071oSDVU48t5tsiYNn8LtE/9yLKWHuVa/bD9IuQY6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpgz3t1792223749td9b57055
X-QQ-Originating-IP: nS5SmDb7r7zDI7MsP68STATtfd3mkBZmpPrULitq8Rk=
Received: from localhost.localdomain ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 17 Oct 2026 15:55:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17322942487440971034
EX-QQ-RecipientCnt: 5
From: Hongjian Dai <daihongjian@kylinsec.com.cn>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	purna.mandal@microchip.com,
	Hongjian Dai <daihongjian@kylinsec.com.cn>
Subject: [PATCH] spi: pic32-sqi: fail transfer when the BD ring is exhausted
Date: Sat, 17 Oct 2026 15:55:45 +0800
Message-ID: <F5276982A630220B+20261017075545.95854-1-daihongjian@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:kylinsec.com.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OUC5DGN0mB58GH4wSbD7cnOVw0/m49be2gOBmrQX/weH8FIrE+mIYusu
	/owZm1m9jhsMicrUFCUWrGZS5Co9dB4vobJP/gSg/zMqxcdZ3Aq2Nxk9srr4IFDtL6xqt3B
	XlWpF3RAdkSSR6O2K1NK6uCDJKanGXThNUArXegQiIVT7zzHU7b3dyDFttCsspO6Ch+0ZUk
	F1chX/xnhKEjQ0m1zTiLreH6NDRnxglxwDhZplPlOiPQiafebcG69Sj4gFVY4Y/+SMK7m+e
	2auU6PnFOpjy+k6TULQb7FJ2Dy/36Rxw+9bIQZjq6SD7zem8mxmEt5trgPKcUsHw9f08ttD
	NH2+/dCOnpgJuVJenLPMyXudsEZoOoHta9iviq3WXBE7ElBPTYe6sDrHId9ePXNwHSz4X98
	fhDkyE+kR17XRFLlyQCoVzfs4Lzf6a6/TQ+g6eIg6KRIG9BIs9jCtUD8XdsAJ8LomzcbqRX
	2sAudwEyzfSEkeplUkQ/opLAJE4oLHWrrBopHtQD1N3tKenIonAwCBlGVTzJs/iHgy+efoO
	YKxMr9ea8wlAzt7SW0tEt2Cn7n8EWbGDhQpWITKsohegzuPFIx2B09NyA3PLENcJITY/iIT
	27u0sl+On8jeVWEMrCwhG6A/K2MhJHxzofNbFK0Ce64ERgYndHCTbbBlygVsfAX+pG3SXAb
	+zEVQcHmp3PQnWkXetGn2yoj2RBrF3lJ+x+Dwuu6BZEUX1hOr900HG/tRTbPBdbTK/OUYNj
	r5G6x7TzNF4ocRXtyAnRHtRQ7ml7HLh0EKy+OQ6OvUQjYBiEDsC1bSdbHjXhsUf37yJGive
	KKnaS8b7ZJ/DZzIYsbie+l7V0YI+GsjbyItcHaZNbpbj7pAaBHG5BsHYi8iLV/inuzolEGz
	QV8ibPDU1mXQuoJKleUe2bC9wKHcYeVntJLJHzYJRKCjOqRiDofyo0f6eCtkY9+MrriKV10
	O+BcLIdrbKB+hdFntdlm/mCN3g5+8kLVyD14OOk+eKuFEHUmsZeYIj6/fGx7k1SncsZ5WXj
	f2UBqgqgXkbODjb12c
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

pic32_sqi_one_transfer() silently stopped programming buffer descriptors
when ring_desc_get() returned NULL and still returned success. The caller
then marked the last programmed descriptor as the end of the list and
started the DMA engine, so the hardware transferred only a prefix of the
requested data while the message completed with status 0.

The ring holds PESQI_BD_COUNT (256) descriptors of at most
PESQI_BD_BUF_LEN_MAX (256) bytes each, so messages larger than 64 KiB (or
with enough SG entries) can exhaust it. Since the driver sets no
max_message_size/max_transfer_size, the SPI core does not prevent this.

Return -ENOMEM instead, and set msg->status so the failure reaches the
caller rather than being silently truncated.

Fixes: 3270ac230f66 ("spi: pic32-sqi: add SPI driver for PIC32 SQI controller.")
Signed-off-by: Hongjian Dai <daihongjian@kylinsec.com.cn>
---
 drivers/spi/spi-pic32-sqi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 5d3921e29461..35f0c60a31d6 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -297,7 +297,7 @@ static int pic32_sqi_one_transfer(struct pic32_sqi *sqi,
 		/* get ring descriptor */
 		rdesc = ring_desc_get(sqi);
 		if (!rdesc)
-			break;
+			return -ENOMEM;
 
 		bd = rdesc->bd;
 
@@ -387,6 +387,7 @@ static int pic32_sqi_one_message(struct spi_controller *host,
 		ret = pic32_sqi_one_transfer(sqi, msg, xfer);
 		if (ret) {
 			dev_err(&spi->dev, "xfer %p err\n", xfer);
+			msg->status = ret;
 			goto xfer_out;
 		}
 	}
-- 
2.43.0

