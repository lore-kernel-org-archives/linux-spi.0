Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C06D23C8AE;
	Tue, 24 Mar 2026 03:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774322797; cv=none; b=eog9GFDjvefVJISEEKorpYhK0rn6I56ADjLPkc6zobMyOLSc/UdzCvrzLSzJ+BSFU3pb1VjogLh3EGWsAkYEsE6WnQlTReikrxzo0OCop2+kuzfKZBWoezKhpD18COWTKNjLsuhEg6yyfGHlzhA1XSpnwytT/PpXlP7VG/pMpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774322797; c=relaxed/simple;
	bh=DSY5G3NnHOs6KKfQu752OUtJoy5d3o1BhARI6TRlFbc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZuHU67YYueLunlrhCKBTkva1GOLpD+F64tW2lqkFaxuxzmZBTnarZN/hPLS8d+zr0EpCWKMLl9SNDdHAtgMzZ100ur+ohp/+fumghb0WIlJ2X6UpVGqNRjJxD7RoIyZQb0epXEPsR6yj/w44eg8NYkZgIvioT1CXujiNOHwbkIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AbBUI423; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AbBUI423"
X-UUID: 3f2e881e273111f1a39cd589f645bc18-20260324
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Zj2qyC8xhG10+YQXv/gFMiWEJ3lx8xupMwUnARNEhRY=;
	b=AbBUI423eJ4HlnyMnOmdzD3zJ6OlgbXL4Txhd5JYwiwNXyIKMe8tK/vo8SkkL8pytsTnCtqZY+5QGS7PAhHclGGIkwf0OOYqOZRPkyzy/FcWwXjQAKSGGIZfkj6urdCoBoH/cPRYeQhDcgVM6Guurqg/5yUkAxfDF/vjTXLThuU=;
X-CID-CACHE: Type:Local,Time:202603241047+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e5affb3d-3a6c-4a21-ab30-099017b4fc29,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:78da2194-f8ef-4ca8-bea0-143568f9ca1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3f2e881e273111f1a39cd589f645bc18-20260324
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ot_meiker.gao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 999752341; Tue, 24 Mar 2026 11:26:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 24 Mar 2026 11:26:27 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 24 Mar 2026 11:26:27 +0800
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
Subject: [PATCH 0/2] *** SUBJECT HERE ***
Date: Tue, 24 Mar 2026 11:26:16 +0800
Message-ID: <20260324032624.1708029-1-ot_meiker.gao@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

*** BLURB HERE ***
This patch series refactors the clock management for the Mediatek SPI NOR driver,
making it more flexible and compatible with different platforms.

Patch 1 updates the device tree binding to support variable clock-names.
Patch 2 migrates the driver to use clk_bulk API and optimizes error handling.

Changes in v1:
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

