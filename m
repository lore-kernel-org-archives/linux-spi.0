Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272ED1531E8;
	Mon, 20 Jul 2026 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784527744; cv=none; b=b9jmybDiZ2Gza/pBuLDMaqUqve1NjIgr3Go59PtXpFjC1KRBtswcRK8baCffhx1tSZ7+HBwZuMpXhhkhhe6yj71Rj1DPf5MSqNSD8jSQBbuKQgLsBT/631fFelujOfLzSVXZqIUPhCBkgaifzkx1IwhS1egvg29lQ34Ng5Q5Hnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784527744; c=relaxed/simple;
	bh=IKYDsxUrbXM+/ZwCAYixlrSVbBfsx0uKsxofe7T1EQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHYRltIC3WuZRs8GO55CzZYS+Ss+gYWbDnZCW6HWrBXKGGN2YTjLvA0BztTGY0ZMVRWjqiLnW40WaSe3Nx3gXpRCBRP/y/3DtcNUCNJkRARVYTvoL/NIPRwXG+smUauetxa9Za7BHdMWfz4DUBn6nTP1fGrN7ELSDG4ZosJ+EMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 797c7738840111f1aa26b74ffac11d73-20260720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e842f246-0682-411d-8e80-3c8cad9ea7d7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:bde4576465f2b3ea8be096613a95cf6d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 797c7738840111f1aa26b74ffac11d73-20260720
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1546217824; Mon, 20 Jul 2026 14:08:49 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: broonie@kernel.org,
	dlan@kernel.org,
	elder@riscstar.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 0/2] fix and cleanup in spi-spacemit-k1
Date: Mon, 20 Jul 2026 14:08:42 +0800
Message-Id: <cover.1784527556.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1.fix TX DMA descriptor on RX prep failure
2. drop redundant dev_err_probe() around irq

Pei Xiao (2):
  spi: spacemit: fix dangling TX DMA descriptor on RX prep failure
  spi: spacemit: drop redundant dev_err_probe() around irq helpers

 drivers/spi/spi-spacemit-k1.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.25.1

