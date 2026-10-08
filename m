Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8B46EC76;
	Thu,  8 Oct 2026 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449625; cv=none; b=tmy01JHUnXiZS1BvtxPHadxA1K1oL1H9La4czys6N/s4zbaHSEkY1ect+XPktvLLXX/sfAXKihfM4vjGmfqP5O4/967cM3GFps2s/9T6/pnqD0WNDw8L1m/Q2rjesWICN5XDMrMOjZztxPFCInT0RJF/Rnd2x7SCcqxrPII24rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449625; c=relaxed/simple;
	bh=dHd2aiHDSy5ciOTqdqus6Sopj4jw+dCUM1H5t2+Arwc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KWbQ73jPv4kzRKYiU9ss3I51mEaLt/eZLfZmC6ZbatF2vm1v80EsKIFlqBsPOZaEsIx6/WZvDeGSAz1xlKyhCkJ5pn4jzNrtPSRHABg3fNJxBsXjbbqWhJun1RkOWrwuIuPwBSQypwEN9tkWcLAxpqsxFMmXADqdQPCTpMY/R68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NGljQqcP; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NGljQqcP"
X-UUID: bed66716c2f511f1b1788b6acf885367-20261008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8NRFf+dUUvJa3wu2zpI7GqfOZRfD8a7WGeUeQy4/QVA=;
	b=NGljQqcPivh7a9HM3sveLUpa45f45rGLK8C2p8UJSMb2nrT52CUkllt/iGzD2o5CaCRrwFzFEJTcc0AduSDoB28qwwwCzIXjGGdi8qkTunHFIAzjKo4T1izLC5tvEfUxsIeWk5MA6AWDTs5q/LMfW2IRRCgqsT2rCfmjQEVriT8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:58aa6548-e4c8-4a4b-a475-d057597ff577,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:291e20b,CLOUDID:4bb31a20-2f17-48f6-b8a0-2bb5971c52b4,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bed66716c2f511f1b1788b6acf885367-20261008
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <tim.kuo@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1748741106; Thu, 08 Oct 2026 16:53:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Oct 2026 16:53:33 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 8 Oct 2026 16:53:33 +0800
From: Tim Kuo <Tim.Kuo@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Steven Liu <Steven.Liu@mediatek.com>,
	Sky Huang <Skylake.Huang@mediatek.com>, Sam Shih <Sam.Shih@mediatek.com>, Tim
 Kuo <Tim.Kuo@mediatek.com>
Subject: [PATCH v3 1/2] spi: dt-bindings: mediatek,spi-mt65xx: add MT7987/MT7989 compatibles
Date: Thu, 8 Oct 2026 16:53:31 +0800
Message-ID: <20261008085332.802898-1-Tim.Kuo@mediatek.com>
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

The MT7987 and MT7989 SPI IPs are IPM designs, so they keep
"mediatek,spi-ipm" as their fallback compatible, but they widen the tick
delay field of SPI_CMD_REG and therefore need compatibles of their own.

Signed-off-by: Tim Kuo <Tim.Kuo@mediatek.com>
---
v2: Add mt7987 and mt7989 real device compatible
v3:
 - Drop "mediatek,spi-ipm-v59" 
 - Move compatible of mt7987 and mt7989 to group of spi-ipm fallback

 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index 3bf3eb1f8728..63b23928c734 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -35,8 +35,10 @@ properties:
           - enum:
               - mediatek,mt7981-spi-ipm
               - mediatek,mt7986-spi-ipm
+              - mediatek,mt7987-spi
               - mediatek,mt7988-spi-quad
               - mediatek,mt7988-spi-single
+              - mediatek,mt7989-spi
               - mediatek,mt8188-spi-ipm
           - const: mediatek,spi-ipm
       - items:

base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1
-- 
2.45.2

