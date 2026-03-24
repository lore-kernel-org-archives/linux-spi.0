Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9053B388C;
	Tue, 24 Mar 2026 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333730; cv=none; b=Fp1/TH8H81XVOz+kgrMKVqQGutPGIDsVOXD6H7n3jjVKZXLjqrcXDS3n3ZmuPIBwd+VFXrq09xQ2DVt1XmZkRYLayzP+SN69k/a9zoVhth7vWo6CehA2MiIG3qaniXKTopsQVjwM+iOL5PQdQpyByNJfBTk+bkBtSqpPTvLp038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333730; c=relaxed/simple;
	bh=1fbBx/MVVzzlRqk3iFpmxdUPyKrrAdMfveqckFM3W/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3MRCW+Z0vmoyTyss+fj0VFVlYWI8f/MC3YhON7fg+DTLXCAeQqy28oWEKj3UBbljPgcAKpBJeqICgSRJtZ4i+nPt8P25CcXEXJZ7JZMiIe2hScJ049y7lQCYjwAOY0asuWL4ITIH8JpHYxpVjkKr4ZdyZVztwExaDjkKK9YpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sJjlMdG1; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sJjlMdG1"
X-UUID: b39bda08274a11f1a02d4725871ece0b-20260324
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sULUjpLWZ7wVszRxwC8FpqlNzXJ4qE9Ukq/gh4VHajw=;
	b=sJjlMdG1v8FtuqCzs2eG9m6HDYmGcRbmwKJdgYRKbPO0kuFLKitRY/5PlHkjgKucjHlp/ptlTQk1/rOmPNeD8KlhCcNpXNBH56LpzQTzrxlLpsu++CoZTKbbqVwQbZskrr4Sxw0yBmQvK++NmJeLc3Xw2wpJ+CpEeVJ26sv2gR4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:061ebd37-6a52-43d9-8f75-6d58934839e0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:a3a210d5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b39bda08274a11f1a02d4725871ece0b-20260324
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ot_meiker.gao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1422607889; Tue, 24 Mar 2026 14:28:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 24 Mar 2026 14:28:40 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 24 Mar 2026 14:28:40 +0800
From: Meiker Gao <ot_meiker.gao@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Bayi Cheng <bayi.cheng@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Meiker Gao <ot_meiker.gao@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: spi: Fix clock-names definition
Date: Tue, 24 Mar 2026 14:28:24 +0800
Message-ID: <20260324062835.1747943-2-ot_meiker.gao@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260324062835.1747943-1-ot_meiker.gao@mediatek.com>
References: <20260324062835.1747943-1-ot_meiker.gao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the device tree binding for the Mediatek
MT8196 NOR controller to require that the 'clock-names'
property contains exactly six entries, in the strict order:
"spi", "sf", "axi", "axi_s", "bclk", "27m".

Signed-off-by: Meiker Gao <ot_meiker.gao@mediatek.com>
Change-Id: I0542d6d726f1af34ef76c1a58ba4e4b02ec45fe6
---
 .../devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
index a453996c13f2..f605a36e753c 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -56,6 +56,10 @@ properties:
                      design, so this is optional.
       - description: clock used for controller axi slave bus.
                      this depends on hardware design, so it is optional.
+      - description: clock used for bclk.
+                     this depends on hardware design, so it is optional.
+      - description: clock used for 27m.
+                     this depends on hardware design, so it is optional.
 
   clock-names:
     minItems: 2
@@ -64,6 +68,8 @@ properties:
       - const: sf
       - const: axi
       - const: axi_s
+      - const: bclk
+      - const: 27m
 
 required:
   - compatible
-- 
2.45.2

