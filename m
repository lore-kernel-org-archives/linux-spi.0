Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2D9460
	for <linux-spi@vger.kernel.org>; Fri, 28 Aug 2026 01:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787880728; cv=none; b=suhYGJd9r2j/VQw2EoSOsk6tmsCsoVBJA8Frmh5hyH11bIsGBcEVILFreZK/o5jAdzwcj+hKn6G0AVGd7Hw0sUcEKyU1zyln+P0AAP2CRC829d9TRT3eYKYnYA4F9+4WoK7ZOcH2ucDZmtBsJxwoVLmG4sSHJgnUkJ9Q4v7Mcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787880728; c=relaxed/simple;
	bh=1IDjBIW08ekXy2TqGD7SQB9Y7LKTD4fO6bhphM1wb4o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SQFrSc/x7gcaMHAYsqieLnehSr2pX/hfAS73B5H8XySDHt5J6Ckq92Qh5KkSQpwSPebpbHTC3emgyVvCgnAnXB9ZAWsQFSk/QH326HTrjYzJT7lWOWFaeO4YCld9hGstlMS8EPCQM82qhhBj6xtycD17BZnB7RiRcpKIrh9FGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 44184f16a28011f19a56ed5b684f684d-20260828
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:e002ffb8-43a2-493e-b23d-f83967e41f6b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:7db8b62,CLOUDID:a9c9aa277be4ffb2fbc300c6d7f285ab,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:2,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 44184f16a28011f19a56ed5b684f684d-20260828
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 114118000; Fri, 28 Aug 2026 09:32:00 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	zhuyinbo@loongson.cn,
	broonie@kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: loongarch: add compatible for loongson spi
Date: Fri, 28 Aug 2026 09:31:46 +0800
Message-Id: <20260828013146.2381737-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the dsdt use "loongson, ls-spi", there is no tpm
device node appearing in /dev, because the id 'ls-spi' does not
appear in the loongson_spi_id_table. After add the id in the table,
the function of tpm device is normal.
Device (SPI0)
{
    Name (_HID, "PRP0001")  // _HID: Hardware ID
    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
    {
	QWordMemory (ResourceConsumer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
	0x0000000000000000, // Granularity
	0x000000001FE001F0, // Range Minimum
	0x000000001FE001FE, // Range Maximum
	0x0000000000000000, // Translation Offset
	0x000000000000000F, // Length
	,, , AddressRangeMemory, TypeStatic)
    })
    Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
    {
	ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
	Package (0x01)
	{
		Package (0x02)
		{
    			"compatible",
    			"loongson,ls-spi"
		}
	}
   })
Device (TPM)
{
    Name (_CID, Package (0x01)  // _CID: Compatible ID
    {
        "SMO0768"
    })
    Name (_ADR, One)  // _ADR: Address
    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
    {

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/spi/spi-loongson-plat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson-plat.c
index 6f8202264341..372ebfa6292a 100644
--- a/drivers/spi/spi-loongson-plat.c
+++ b/drivers/spi/spi-loongson-plat.c
@@ -26,6 +26,7 @@ static int loongson_spi_platform_probe(struct platform_device *pdev)
 
 static const struct of_device_id loongson_spi_id_table[] = {
 	{ .compatible = "loongson,ls2k1000-spi" },
+	{ .compatible = "loongson,ls-spi" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, loongson_spi_id_table);
-- 
2.25.1

