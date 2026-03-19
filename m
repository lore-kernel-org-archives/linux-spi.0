Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA10A36BCC5;
	Thu, 19 Mar 2026 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773885871; cv=none; b=K3VlWaWGmqekEHnuY78vRAeWoZlIl8A5raPcpH1Nn/WBEkw3mUxuvmpPiAhxzxlMSZr1lhjDnn9Mttob4Selix5HIVjZ977pTNEJBhobYbqWWpHCaQkWS17ekEA80VoWMr9VPsrjo8siXpwecpwSKqv+8b59tEznTJmBuBNPkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773885871; c=relaxed/simple;
	bh=+9s/YqbFkZx3Dabtm5kt4kmf5Mggb9Jj8IZCMYZydws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Adnu+MZcUU68/bMUbp98WH+zPYGK1NORa+A/gUs/Xtiz+H7mxToJYh2AhllBH6UyTCyKWV/QT+vpIvnT2z3Ehq5g6AZKMz4HYVZ+CKYuj9GnKinl9KyrSEEFCm+qmWfZdv3zCD15Vgcu/UEenBWt8B6JmbNjxqjb66rLk6NLLCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f0539c86233711f1a21c59e7364eecb8-20260319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:4cb70cb4-2445-4a3d-9b3e-6cca71046fc6,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:1
X-CID-META: VersionHash:89c9d04,CLOUDID:44aefcd754ffdd6255a9ac6080a9613a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f0539c86233711f1a21c59e7364eecb8-20260319
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1870073804; Thu, 19 Mar 2026 10:04:18 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	broonie@kernel.org,
	Frank.Li@nxp.com,
	amelie.delaunay@foss.st.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v5 00/17] cleanup in spi by use devm_clk_get_enabled
Date: Thu, 19 Mar 2026 10:03:56 +0800
Message-Id: <cover.1773885292.git.xiaopei01@kylinos.cn>
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

Maybe I need to double-check; sending too many versions has caused
a waste of public resources and wasted everyone's time.
---
changes in v5: 
remove warning: unused variable by kernel test robot check
fix error message but having a line in stm32 patch
changes in v4: modify all commit info
changes in v3: remove disable clk in remove function
changes in v2: fix error message but having a line break
Missing error code argument to dev_err_probe()
---


Pei Xiao (17):
  spi: axiado: Simplify clock management with devm_clk_get_enabled()
  spi: bcm63xx-hsspi: Simplify clock handling with
    devm_clk_get_enabled()
  spi: bcmbca-hsspi: Simplify clock handling with devm_clk_get_enabled()
  spi: img-spfi: Simplify clock handling with devm_clk_get_enabled()
  spi: imx: Simplify clock handling with devm_clk_get_enabled()
  spi: npcm-pspi: Simplify clock handling with devm_clk_get_enabled()
  spi: orion: Simplify clock handling with devm_clk_get_enabled()
  spi: rockchip-sfc: Simplify clock handling with devm_clk_get_enabled()
  spi: sifive: Simplify clock handling with devm_clk_get_enabled()
  spi: slave-mt27xx: Simplify clock handling with devm_clk_get_enabled()
  spi: st: Simplify clock handling with devm_clk_get_enabled()
  spi: stm32-qspi: Simplify clock handling with devm_clk_get_enabled()
  spi: stm32: Simplify clock handling with devm_clk_get_enabled()
  spi: sunplus-sp7021: Simplify clock handling with
    devm_clk_get_enabled()
  spi: uniphier: Simplify clock handling with devm_clk_get_enabled()
  spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()
  spi: zynqmp-gqspi: Simplify clock handling with devm_clk_get_enabled()

 drivers/spi/spi-axiado.c         | 32 +++++------------
 drivers/spi/spi-bcm63xx-hsspi.c  | 46 +++++++-----------------
 drivers/spi/spi-bcmbca-hsspi.c   | 49 +++++++++----------------
 drivers/spi/spi-img-spfi.c       | 18 ++--------
 drivers/spi/spi-imx.c            | 15 ++------
 drivers/spi/spi-npcm-pspi.c      | 20 ++++-------
 drivers/spi/spi-orion.c          | 12 ++-----
 drivers/spi/spi-rockchip-sfc.c   | 22 ++----------
 drivers/spi/spi-sifive.c         | 21 ++++-------
 drivers/spi/spi-slave-mt27xx.c   |  8 +----
 drivers/spi/spi-st-ssc4.c        | 17 +++------
 drivers/spi/spi-stm32-qspi.c     | 18 +++-------
 drivers/spi/spi-stm32.c          | 62 +++++++++-----------------------
 drivers/spi/spi-sunplus-sp7021.c | 15 +-------
 drivers/spi/spi-uniphier.c       | 17 +++------
 drivers/spi/spi-zynq-qspi.c      | 31 ++++------------
 drivers/spi/spi-zynqmp-gqspi.c   | 19 ++--------
 17 files changed, 97 insertions(+), 325 deletions(-)

-- 
2.25.1

