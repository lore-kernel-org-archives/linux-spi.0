Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0F63E169B
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049784; cv=none; b=F7m3jF1JdxOAkdasqtr5/WJdX6T0icICrc8/CXuQD0LFPt7oLQGu+e4cDLTA4a4jUDW31Spm+OpSAWMoY92pVZqf51HDWqghy6XT7IRiSJ0ZJbjjr27CWZRPm7WtkvwwoKW6j6hQ8GFGSGEkpFk3RjGXutMVap8oXp1zj0QV6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049784; c=relaxed/simple;
	bh=X3o1xhz1qkvZwTF2I2Z6dcmhIloGKxOBxZWnyWPsEm0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XDRNZpj53i2h4yAEK1E3EUtHZtmq0XC0ULo2kSiYHZsHm3FP1P9YJZ2jzQEpy/Xj5KPyJVq4nWDEsnvx4sJSD9lWouZTj8U/0OjHeN+2bV31gt/dO/MYlwpQjS8J9fw5eUMfNn3wNfh9jFJeYzHLvhYqIFtEIzY4DfqTJZn61DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 90e3142a9af111f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:35fc8bcd-9cca-4363-a316-7c72cca05ed6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:9151dc11a054057859879685cda07dd5,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 90e3142a9af111f19a56ed5b684f684d-20260818
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 278568995; Tue, 18 Aug 2026 18:42:53 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	zhuyinbo@loongson.cn,
	broonie@kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: loongson: pm: add .freeze .poweroff .thaw .restore
Date: Tue, 18 Aug 2026 18:42:41 +0800
Message-Id: <20260818104241.850042-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

after execute s4, the spi error,
[ 1104.754246][ 4] [    T1] tpm_tis_spi spi-SMO0768:00: SPI transfer failed: -110
[ 1104.761503][ 4] [    T1] spi_master spi1: failed to transfer one message from queue
[ 1104.769201][ 4] [    T1] spi_master spi1: noqueue transfer failed
[ 1104.776344][ 4] [    T1] tpm_tis_spi spi-SMO0768:00: SPI transfer failed: -110
[ 1104.783609][ 4] [    T1] spi_master spi1: failed to transfer one message from queue
[ 1104.791308][ 4] [    T1] spi_master spi1: noqueue transfer failed
[ 1104.797446][ 4] [    T1] gttadd tpm_chip_start1 ret = -110
and in s4 the loongson_spi_resume&suspend are
not called at all.
add .freeze .poweroff .thaw .restore， after s4 the spi
communication is normal.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/spi/spi-loongson-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index 30b6a7176ce9..28962c01c7e4 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -271,7 +271,11 @@ static int loongson_spi_resume(struct device *dev)
 
 const struct dev_pm_ops loongson_spi_dev_pm_ops = {
 	.suspend = loongson_spi_suspend,
+	.freeze = loongson_spi_suspend,
+	.poweroff = loongson_spi_suspend,
 	.resume = loongson_spi_resume,
+	.thaw = loongson_spi_resume,
+	.restore = loongson_spi_resume,
 };
 EXPORT_SYMBOL_NS_GPL(loongson_spi_dev_pm_ops, "SPI_LOONGSON_CORE");
 
-- 
2.25.1

