Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675B33A1E9F;
	Tue, 24 Mar 2026 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333727; cv=none; b=RvRGUPPeltZSdgNxLqpAi8pDWuY4XsT1Jk2JmKv4uqQvcNHSgUapQmKn6r1aX/psKiqdsP0rJZU/21fOwLEzdrrLkbjyFNCbfK4djsoZtR7XJrZQUYI3lOB6kvkSfhCckxmrXJuShA1EDksy454fqPv8KOlbAdfN8pjoCIHeLMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333727; c=relaxed/simple;
	bh=WhUCCSXnkSvW//C7xzh8crYa+N0nnlsCrw3v/Fk+w0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZIRRmB6irXBPtD1eMIQkk/27Pw9znXJt/krxrPjpI9ROi9ijrPpCij4KF5ybAh7T6VvITK3yG8xD0Y/ICTLl5iTkkh8jEQyq77ySIj+3W41BHl2hmB9RdKqX64rvmUkgd6GSrwndxzKTSU3NW1UUiRhk6TKO2DbE8q6i0ngafIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AfTtnAwE; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AfTtnAwE"
X-UUID: b27d61a0274a11f1a02d4725871ece0b-20260324
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fTb3ytmu88frSKY6/byD6L0sRJa4aARZkpJoC5b6WIc=;
	b=AfTtnAwEI2zGmScY2TDsf2XLDo+vUGmodU1psJm32DCifRDxvknzL8YQm2ffTyNR3XpMeIaWAurmTDTI07JBOykAU3+mhyEwQc+HlQwq9XNJAagK28mvfUFmML3RpqD04Zc8yDf6cTchWhz2IOjS3NmAGCIMO9Dnz418SDdOlmo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cf338719-b436-44fb-a73d-cdcda495fd7d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:79a210d5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b27d61a0274a11f1a02d4725871ece0b-20260324
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ot_meiker.gao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1655481050; Tue, 24 Mar 2026 14:28:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 24 Mar 2026 14:28:38 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 24 Mar 2026 14:28:38 +0800
From: Meiker Gao <ot_meiker.gao@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Matthias Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Bayi Cheng <bayi.cheng@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Meiker Gao <ot_meiker.gao@mediatek.com>
Subject: [PATCH 0/2] Add clock to dt-bindings and Modify nor driver.
Date: Tue, 24 Mar 2026 14:28:23 +0800
Message-ID: <20260324062835.1747943-1-ot_meiker.gao@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series refactors the clock management for the Mediatek SPI NOR driver,
making it more flexible and compatible with different platforms.

Patch 1 updates the device tree binding to support variable clock-names.
Patch 2 migrates the driver to use clk_bulk API and optimizes error handling.

Changes in v1:
  - dt-bindings add clock for mt8196.
  - Dynamically allocate clk_bulk_data array.
  - Simplify error handling.
  - Code cleanup and style improvements.

Meiker Gao (2):
  dt-bindings: spi: Fix clock-names definition
  [v3] spi: spi-mtk-nor: Modify and optimization the SNFC.

 .../bindings/spi/mediatek,spi-mtk-nor.yaml    |  6 ++++++
 drivers/spi/spi-mtk-nor.c                     | 19 ++++++++-----------
 2 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.45.2

