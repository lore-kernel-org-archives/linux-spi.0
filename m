Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89C3D9DD1;
	Thu, 24 Sep 2026 03:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219549; cv=none; b=IGy36DyFi+R2QRSkUnnoSlVJ9uZGMiHutAROWJdk7mg67wYkmCvCzKpiOpG5wY2GYXgh1XjkO8bWqzQ/WuQsHyVWhUqFOZ8nOfZRczD2YeGuSwx11ZQuF++KmajOS60E8z70HD1727oedKuz3RPy7hpCGu4z20o4AQXBFXHraGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219549; c=relaxed/simple;
	bh=Ai9tYnbYgd7UmISWRW8eOqVXDzCbFbZNKtV7umeXrIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WjnCYd2HYclI2s9bjIO6rpJvvXoLmf181AXEcIm4aK6oNEjy+NYeUvrfNJg+MNeal8K04w2otNisp6zulvB2FwBq79Sj7FQx5x/ceaoxd1ID3nBIwpXLjjAnEyHKV/Fwjy6dw7AT0o5sCVJGYDMNp8h44K6cErJHEUn+CRPfI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=m8HipW0v; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m8HipW0v"
X-UUID: bdc11316b7c511f18dc8c9802ae25ab1-20260924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WdlxKuZ1eRGNTq9IjWkXwugc0cdMzr3fNzL2g2N6O5c=;
	b=m8HipW0v8aCf9OcDHnF3lOTas7ITq1fvIRFN1w5sLtbyLlFut09hHz/nJJF3+U9b2NmOqvQFO6io8OdKCi3SQ5FgrxOfdAVjccCE4UYVDBavwONYNO8c1huRMCUX0q6IJN3TDabQ8uJzaGhB4uqZY4KJi+DCj3sOzadvFcf53OA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d5dfba1a-913d-4e9a-a411-8140e7855267,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:c356e6fa-1cb6-4618-8a29-fa072b24d2a9,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bdc11316b7c511f18dc8c9802ae25ab1-20260924
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <tim.kuo@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 486424146; Thu, 24 Sep 2026 11:12:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 24 Sep 2026 11:12:13 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 24 Sep 2026 11:12:13 +0800
From: Tim Kuo <Tim.Kuo@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Steven Liu <Steven.Liu@mediatek.com>,
	Sky Huang <Skylake.Huang@mediatek.com>, Tim Kuo <Tim.Kuo@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: spi: mediatek: add mediatek,spi-ipm-v59 compatible
Date: Thu, 24 Sep 2026 11:12:10 +0800
Message-ID: <20260924031211.2199921-1-Tim.Kuo@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The IPM v59 SPI IP differs from earlier IPM designs, most visibly in the
tick delay field of SPI_CMD_REG, so it needs its own fallback compatible
rather than reusing "mediatek,spi-ipm".

Signed-off-by: Tim Kuo <Tim.Kuo@mediatek.com>
---
 .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml         | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index 3bf3eb1f8728..08a3497b03dc 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -39,6 +39,10 @@ properties:
               - mediatek,mt7988-spi-single
               - mediatek,mt8188-spi-ipm
           - const: mediatek,spi-ipm
+      - items:
+          - enum:
+              - mediatek,mtxxxx-spi
+          - const: mediatek,spi-ipm-v59
       - items:
           - enum:
               - mediatek,mt8196-spi
@@ -55,7 +59,6 @@ properties:
               - mediatek,mt8135-spi
               - mediatek,mt8173-spi
               - mediatek,mt8183-spi
-
   reg:
     maxItems: 1
 
-- 
2.45.2

