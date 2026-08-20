Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03C3EA963
	for <linux-spi@vger.kernel.org>; Thu, 20 Aug 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217867; cv=none; b=IxuMsrWDFtnhBJ9eOvxrh9uV3UDZVT03BlssvDVStqCFguU615APz0zdqI1gsPs0A1ngZuTOWdoFjNn2bYaJkUDX1Puf6LYUki7NLtOK5Es3ppbAaE0+cbZtTa2xbC0A+Qs8ZyeTcBFM2LAKuzDkK/d9ViZPbPYFFSDa5hrJ6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217867; c=relaxed/simple;
	bh=7zGG8lI0nQ9UWjO1VHCQnGfutAuQl5M9sEsdHS9Xbnw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=M0ETXaZet723x6LhwknHQwEX/WKKg1cLPhjzdGRpx5hBlI3yhjvNyQoIDaGDGC4cJh3dRFIZaWMPCcBQvu28ornSV7aYFZ7ulOLYMMXQzF8ADAPMKr6VZfKZplvrrkDrk5oYL1Tpi+yWv5HSV743bxwzUvQmDQRB3JKGqBYThMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e3fdcb4a9c7811f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:72f5c269-c41c-423a-8c32-f558b5a95eae,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:1ab1c7c72e884eb216018420c8ecb3d1,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e3fdcb4a9c7811f19a56ed5b684f684d-20260820
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 582755277; Thu, 20 Aug 2026 17:24:06 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	zhuyinbo@loongson.cn,
	broonie@kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v3] spi: loongson: pm: add .freeze .poweroff .thaw .restore
Date: Thu, 20 Aug 2026 17:23:51 +0800
Message-Id: <20260820092351.101605-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

after execute s4, the spi error,
[ 1104.754246][ 4] [    T1] tpm_tis_spi spi-SMO0768:00: SPI transfer failed: -110
[ 1104.761503][ 4] [    T1] spi_master spi1: failed to transfer one message from queue
[ 1104.769201][ 4] [    T1] spi_master spi1: noqueue transfer failed
[ 1104.776344][ 4] [    T1] tpm_tis_spi spi-SMO0768:00: SPI transfer failed: -110
[ 1104.783609][ 4] [    T1] spi_master spi1: failed to transfer one message from queue
[ 1104.791308][ 4] [    T1] spi_master spi1: noqueue transfer failed
[ 1104.797446][ 4] [    T1] gttadd tpm_chip_start1 ret = -110
and in s4 the loongson_spi_resume&suspend are not
called at all. use DEFINE_SIMPLE_DEV_PM_OPS() add .freeze .poweroff
.thaw .restore, after s4 the spi communication is normal.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/spi/spi-loongson-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index 30b6a7176ce9..6ba7c56b1bdd 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -269,10 +269,8 @@ static int loongson_spi_resume(struct device *dev)
 	return 0;
 }
 
-const struct dev_pm_ops loongson_spi_dev_pm_ops = {
-	.suspend = loongson_spi_suspend,
-	.resume = loongson_spi_resume,
-};
+DEFINE_SIMPLE_DEV_PM_OPS(loongson_spi_dev_pm_ops, loongson_spi_suspend, loongson_spi_resume);
+
 EXPORT_SYMBOL_NS_GPL(loongson_spi_dev_pm_ops, "SPI_LOONGSON_CORE");
 
 MODULE_DESCRIPTION("Loongson SPI core driver");
-- 
2.25.1

