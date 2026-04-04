Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08A0337BA0
	for <linux-spi@vger.kernel.org>; Sat,  4 Apr 2026 03:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274315; cv=none; b=fyAinrVBPA47X1iplqz8bJQEwfmKVnsnFxQyhpU17OLSsgYmqwkikq3maP/j4WZ+IF9eQjYOfT3KRxrlKzNmMxlfyelkx1svaLGGUAoID91V188QPDPoQtTVgu05GxCbw3DKq66n7kHo7XIh8+Bv8S8aa84YgxxDpuYJxfbFdl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274315; c=relaxed/simple;
	bh=6/wr55um58FhX1qTi6ZEi3obH8PmImjOHl3G+sOWNK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THHClWtbW03GiLkdv7g4IRsNECROfNXYti9hVV2+Xuf1WxGbHzJHC7E6CpA5lTCY8ON7PYlKo5u98RtAJSWpctX0Y+p0IuYZ/1xR8k6sCsUjRI5YFINTqBKPe4VNKyrLFkbbioJlllyyZTWdxMMzkp4W97GQ/HDg9917thxUC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ab9c82ee2fd811f1aa26b74ffac11d73-20260404
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ef55d49b-016d-40d0-a057-beccc8a42ac2,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:47061a859de56c0b9a49db5e62739cfa,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ab9c82ee2fd811f1aa26b74ffac11d73-20260404
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 429297759; Sat, 04 Apr 2026 11:45:06 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: broonie@kernel.org,
	gch981213@gmail.com,
	linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 4/4] spi: ch341: Correct vendor name
Date: Sat,  4 Apr 2026 11:45:01 +0800
Message-Id: <9d86466a5b14bdb42cdbf66ded9fbff700e86b6e.1775273351.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1775273351.git.xiaopei01@kylinos.cn>
References: <cover.1775273351.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usb2spi ch341a is manufactured by QinHeng Electronics, not QiHeng.
Update the driver description and the initial comment to reflect the
correct vendor name.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-ch341.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
index 3eaa8f176f63..396c17274187 100644
--- a/drivers/spi/spi-ch341.c
+++ b/drivers/spi/spi-ch341.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// QiHeng Electronics ch341a USB-to-SPI adapter driver
+// QinHeng Electronics ch341a USB-to-SPI adapter driver
 //
 // Copyright (C) 2024 Johannes Thumshirn <jth@kernel.org>
 //
@@ -250,5 +250,5 @@ static struct usb_driver ch341a_usb_driver = {
 module_usb_driver(ch341a_usb_driver);
 
 MODULE_AUTHOR("Johannes Thumshirn <jth@kernel.org>");
-MODULE_DESCRIPTION("QiHeng Electronics ch341 USB2SPI");
+MODULE_DESCRIPTION("QinHeng Electronics ch341 USB2SPI");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

