Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08133368B0
	for <linux-spi@vger.kernel.org>; Sat,  4 Apr 2026 03:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274315; cv=none; b=aD8+PfQvTy9WbXn7z6G2NZVfCAQ6WgCI9A98xe/jZ5NdfwOrjOKycZGnIVJ0VoVeqcfkpYCylm1bUoR6iyvj/kwNjamEawPHBt+mYUHIcxIx6ooXdIe4pKqgaHtZ0w9uEmdfwXDTyxeqHsBUGxes7/nupXwc0k0vKZAebYHRJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274315; c=relaxed/simple;
	bh=Zqp3P9Zx2UcjFWSKVbPAJFYXqi8jPgT8BCWKnn5T+cU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KhJSAnY39qT8Z5aDnmHC1/H+t73ztQVOwv1HdVkURxgNvcPSIP4CfKDTnsxzBZc8SvWjjk5ArLVMurrNcXLTPdr663DsPh+FeJ0aQTG5LHGFk12mE1VH1gzqZOruoxkV3ptIuSs2SDarXmwTiV71EZvbqrNpMtwa8Svd3OyWgu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ab100b202fd811f1aa26b74ffac11d73-20260404
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:11f74241-d528-46c2-9775-852b33c553f0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:1409f8a221cefc52db75bafb357b998a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ab100b202fd811f1aa26b74ffac11d73-20260404
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1249234470; Sat, 04 Apr 2026 11:45:05 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: broonie@kernel.org,
	gch981213@gmail.com,
	linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 0/4] cleanups in spi
Date: Sat,  4 Apr 2026 11:44:57 +0800
Message-Id: <cover.1775273351.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi Mark,
Some cleanups in spi. Thanks!

1.spi: uniphier: Simplify clock handling with devm_clk_get_enabled()
It might be that the previous unused variable caused it not to be merged.

2.spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()
It was not merged. Upon checking, runtime is not used.

3.spi: mtk-snfi: unregister ECC engine on probe failure and remove()
    callback
'copy from' b0dc7e7c56573e7a52080f25f3179a45f3dd7e6f
spi: amlogic: spifc-a4: unregister ECC engine on probe failure and remove() callback

4.ch341
In Chinese, the pronunciation of this manufacturer includes an 'n' sound.
It's a bit strange that the manufacturer's name was wrong, so I still want
to correct it.

Pei Xiao (4):
  spi: mtk-snfi: unregister ECC engine on probe failure and remove()
    callback
  spi: uniphier: Simplify clock handling with devm_clk_get_enabled()
  spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()
  spi: ch341: Correct vendor name

 drivers/spi/spi-ch341.c     |  4 ++--
 drivers/spi/spi-mtk-snfi.c  | 14 ++++++++++++++
 drivers/spi/spi-uniphier.c  | 18 ++++--------------
 drivers/spi/spi-zynq-qspi.c | 31 ++++++-------------------------
 4 files changed, 26 insertions(+), 41 deletions(-)

-- 
2.25.1

