Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F81D130E;
	Wed, 25 Mar 2026 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774408762; cv=none; b=glKrajKmjtvS9itJOrHiUWIOhZ32A7XivGVQtU2DG4HCArqPaYxmdeCXT9dKM4lFnhSaaWAR4c3rxHGoPLC7caVBypjRwim8Yy/mJd9O1FQXNX+kaDvNstqbmNTPb/crG8IL4/wU0AD/HNryiRwc8b0nWY5qfGiQKbR8DVEZqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774408762; c=relaxed/simple;
	bh=+F+UWBMNG1/wEjvjlcZoTTurKSlMFLLGwfwKvknDRQo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R6lmnJ2P6pzfj2zGLI/MydCUgzf4/HhnpyVoyFA2m4zKiInFGYEFHRb8S0NUxzUZc2tiMaycvI91TeJThgvkIT40oOvfTSrklr1HQtpCoyZyzGTr5d03tt9plDFr1rz57Fl0UvDaCT6s+Vqqa2d+hw3axkMeYRdL9Qa8zbKJP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ICiN7CSN; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ICiN7CSN"
X-UUID: 61fae69e27f911f1a02d4725871ece0b-20260325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lgdfkt1aEAJFnLfBpu4pkO5ZuUB0UdVAmLAs6to9Vp4=;
	b=ICiN7CSNqyGAAUi2KfR8ARIOEX6WHU6C6RLkhNL80dAZQIeecWCXn3uZ6ZRqDeUgVJ50io01pffzfuF9ssG+Xwi0A1PosCq5cuFnMzOCwzIHBrB/vLHYgYRJFSAW5DDoivhQxxnZtvOfKg0ZNeovwTv24xXOIAv8CxjKaNaqlVg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d72edb0f-35ef-4d8b-89d9-1350ee319a69,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:32c019d5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 61fae69e27f911f1a02d4725871ece0b-20260325
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ot_meiker.gao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 687476276; Wed, 25 Mar 2026 11:19:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 25 Mar 2026 11:19:05 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 25 Mar 2026 11:19:05 +0800
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
Subject: [PATCH 0/2] Add nor dt-bindings new clock and modify driver.
Date: Wed, 25 Mar 2026 11:18:53 +0800
Message-ID: <20260325031900.2099969-1-ot_meiker.gao@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Changs in v2:
 -Modify bindings/spi/mediatek,spi-mtk-nor.yaml,add new clock.
 -Modify nor driver new clock gate need to be added.

Meiker Gao (2):
  dt-bindings: spi: Fix clock-names definition
  spi: spi-mtk-nor: add new clock support

 .../bindings/spi/mediatek,spi-mtk-nor.yaml    |  7 ++-
 drivers/spi/spi-mtk-nor.c                     | 48 ++++++++++++-------
 2 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.45.2

