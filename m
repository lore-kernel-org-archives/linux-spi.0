Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E4A41A92C;
	Tue, 29 Sep 2026 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663135; cv=none; b=g86bmXb0H3n/QzOOnI6BRq3s8bM2gg2YU7HV7sx76w0JpQpV6mdZbiBNauQd+15axyNzutuJ/PgiEp71ojnE6EyxefLSPmDijzZuJIFPSmNGpSbPQ5x209F6LXSVCrynhQ9FPUYl5Um/FUbzvUrSB0FCeTud2pDENftuzhg6dN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663135; c=relaxed/simple;
	bh=quxAoFc0jh8sRiiUgmMr/Pgb3tJBWNr4iLfGz2B0/EU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dy5J0uXIj4gMgEPJ7uLRe1fNDDP3RFNaw+RcwarCao5nKXSysIGMEDK4FdDi1j6DKTih/LMfDYGLIFe1C0FaMoo/3NynU3qx1cbG66sEUOE4dRA0i83EFOhkmNRQE8IKCLBIs+eDJ2ecV3MGX4P+L3/rv9h/6uRMZC+1pxMUakY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=u+sDz2lI; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u+sDz2lI"
X-UUID: 8b7f720abbce11f18dc8c9802ae25ab1-20260929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4BBaoZ4uoulOab2Cr6EQ3iDBn+vLxKq+FxX0x0G4yZE=;
	b=u+sDz2lItx93DHdhddJWmflhLVux1w7e0VWYl38mvTjrLTqlQWdiFFFkU9yI09EjIpPtAD1H+dGl12lyr4WxFoD5dsnla3E7uxBws8/do5eDjm7Q6BbYsD3mYmOWpkWGvj+8YroZD0rJWU83mfWOiLE+VRccqVaypUCxn6I3tuQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:6c1e87c9-61c6-4adc-8993-cfdefa23457c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:291e20b,CLOUDID:c7359f34-37f0-435c-b265-a3ddc15fd61c,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8b7f720abbce11f18dc8c9802ae25ab1-20260929
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <tim.kuo@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 164707656; Tue, 29 Sep 2026 14:25:20 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 29 Sep 2026 14:25:19 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 29 Sep 2026 14:25:19 +0800
From: Tim Kuo <Tim.Kuo@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Steven Liu <Steven.Liu@mediatek.com>,
	Sky Huang <Skylake.Huang@mediatek.com>, Tim Kuo <Tim.Kuo@mediatek.com>
Subject: [PATCH v2 1/2] spi: dt-bindings: add SPI IPM v59 compatible for mt7987 and mt7989
Date: Tue, 29 Sep 2026 14:25:15 +0800
Message-ID: <20260929062516.416368-1-Tim.Kuo@mediatek.com>
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

MTK mt7987 and mt7989 SPI hardware has been updated to IPM v59 SPI IP and
it differs from earlier IPM designs, most visibly in the tick delay field
of SPI_CMD_REG, so it needs its own fallback compatible rather than reusing
"mediatek,spi-ipm".

Signed-off-by: Tim Kuo <Tim.Kuo@mediatek.com>
---
v2: Add mt7987 and mt7989 real device compatible

 .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index 3bf3eb1f8728..d2c740572d85 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -39,6 +39,11 @@ properties:
               - mediatek,mt7988-spi-single
               - mediatek,mt8188-spi-ipm
           - const: mediatek,spi-ipm
+      - items:
+          - enum:
+              - mediatek,mt7987-spi
+              - mediatek,mt7989-spi
+          - const: mediatek,spi-ipm-v59
       - items:
           - enum:
               - mediatek,mt8196-spi

base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1
-- 
2.45.2

