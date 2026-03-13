Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947119ADA4;
	Fri, 13 Mar 2026 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382146; cv=none; b=nU3m2UrNANEznj2ZxxpwZn6BjEZWf630pEG9AVcxeHXMEJw2BwVmMSK7vXKc1geTn0nGiVepblgsR6Whp2Dl5hj7JAuZU6wa0UskOsN+aU1fz06GfeZe7ocAzToJec8exXWXoycO6yqN9uxE3FQJEuyCv/n9hRewYtKevcAeBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382146; c=relaxed/simple;
	bh=QGlDt/8kIZtI3dPN5sXz7Vr0UcAmuiIxwJr14x14ymE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ls9XRBmKfvAXYidtnUmvT3hT3Q+DbGPulkZxsJmh4wQc/v7BS2au7vddj/lONJmZm6sTApQ1+c1dUy6y2voCH7yooHHMNJ+KbCiO2tBr/10RUaxVIDZPfKB0To4R/evbKuxHnIhiclL/jw0Cp9ALYR3+lqhEtRuSTprkbsWyBLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1f3293ac1ea311f1a21c59e7364eecb8-20260313
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:7bc6b968-39e1-4f72-bcff-73ca10c27e16,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:89c9d04,CLOUDID:c109a704f89f73548902f755b0defa24,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1f3293ac1ea311f1a21c59e7364eecb8-20260313
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 288646284; Fri, 13 Mar 2026 14:08:57 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2 00/17] cleanup in spi by use devm_clk_get_enabled
Date: Fri, 13 Mar 2026 14:08:16 +0800
Message-Id: <cover.1773381582.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I know that many old SPI drivers should not be modified for hardware
stability and to reduce maintenance effort. But I can't help cleaning them
up. To minimize the introduction of issues, I tried not to modify the
timing of those hardware clock enables.
---
changes in v2: fix error message but having a line break
Missing error code argument to dev_err_probe()
---
Pei Xiao (17):
  spi: axiado: Use helper function devm_clk_get_enabled()
  spi: bcm63xx-hsspi: Use helper function devm_clk_get_enabled()
  spi: bcmbca-hsspi: Use helper function devm_clk_get_enabled()
  spi: img-spfi: Use helper function devm_clk_get_enabled()
  spi: imx: Use helper function devm_clk_get_enabled()
  spi: npcm-pspi: Use helper function devm_clk_get_enabled()
  spi: orion: Use helper function devm_clk_get_enabled()
  spi: rockchip-sfc: Use helper function devm_clk_get_enabled()
  spi: sifive: Use helper function devm_clk_get_enabled()
  spi: slave-mt27xx: Use helper function devm_clk_get_enabled()
  spi: st: Use helper function devm_clk_get_enabled()
  spi: stm32-qspi: Use helper function devm_clk_get_enabled()
  spi: stm32: Use helper function devm_clk_get_enabled()
  spi: sunplus-sp7021: Use helper function devm_clk_get_enabled()
  spi: uniphier: Use helper function devm_clk_get_enabled()
  spi: zynq-qspi: Use helper function devm_clk_get_enabled()
  spi: zynqmp-gqspi: Use helper function devm_clk_get_enabled()

 drivers/spi/spi-axiado.c         | 23 +++----------
 drivers/spi/spi-bcm63xx-hsspi.c  | 44 +++++++-----------------
 drivers/spi/spi-bcmbca-hsspi.c   | 47 +++++++++-----------------
 drivers/spi/spi-img-spfi.c       | 14 ++------
 drivers/spi/spi-imx.c            | 15 ++-------
 drivers/spi/spi-npcm-pspi.c      | 19 ++++-------
 drivers/spi/spi-orion.c          | 10 ++----
 drivers/spi/spi-rockchip-sfc.c   | 20 ++---------
 drivers/spi/spi-sifive.c         | 20 ++++-------
 drivers/spi/spi-slave-mt27xx.c   |  8 +----
 drivers/spi/spi-st-ssc4.c        | 14 +++-----
 drivers/spi/spi-stm32-qspi.c     | 17 +++-------
 drivers/spi/spi-stm32.c          | 58 ++++++++++----------------------
 drivers/spi/spi-sunplus-sp7021.c | 15 +--------
 drivers/spi/spi-uniphier.c       | 15 +++------
 drivers/spi/spi-zynq-qspi.c      | 28 ++++-----------
 drivers/spi/spi-zynqmp-gqspi.c   | 17 ++--------
 17 files changed, 94 insertions(+), 290 deletions(-)

-- 
2.25.1

