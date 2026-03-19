Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837DA31ED68;
	Thu, 19 Mar 2026 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889615; cv=none; b=kN5nLH/w27ySBkW38s4dZ26uWHSHu+H7SoLzbYN69uNLFOdN/ddG8tHMDGmh2BqP23mRC0Mp3e6VkPJmTYhAKq/4+QIfavRik7hlJweP3TGEDIkC3LGEoHF2CVGtgBro0gs1ut5XuMWe8EoJrEPQnyPobi0GollmICpwYWvZXuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889615; c=relaxed/simple;
	bh=AT4c6AM2g882gIEo5gRP67e8Yjs7hX9LcTYh+6awq54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SV/7TgXtbffzlr8K3WMtB/nw4G/Ab6fJDIRSmEPeceUuIezGVqm712Eu7pOfO5fqswNDZIk9by9RQyx0ITAIX/9kowBvDF6oStRtJ9yBINzKgSmBbjclKYhCMRdFkyZjnW8SSluiaYEK4DozGWt4IX2dLBHWQrdhlVIPe8RY9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aa4e1d48234011f1a21c59e7364eecb8-20260319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:89570d18-be12-4db0-94ca-fc45a97b0cb0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:89c9d04,CLOUDID:fc429e4feb26b0b5c368a34e44809c15,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aa4e1d48234011f1a21c59e7364eecb8-20260319
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1199404946; Thu, 19 Mar 2026 11:06:46 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: shenyang39@huawei.com,
	broonie@kernel.org,
	f.fangjian@huawei.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 0/2] spi hisi-kunpeng cleanup and fix
Date: Thu, 19 Mar 2026 11:06:40 +0800
Message-Id: <cover.1773889292.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Maintainer,
  I might have wasted your valuable time again. Please help check the two
modifications. Thank you!

Pei Xiao (2):
  spi: hisi-kunpeng: prevent infinite while() loop in
    hisi_spi_flush_fifo
  spi: hisi-kunpeng: Add timeout warning in FIFO flush function

 drivers/spi/spi-hisi-kunpeng.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.25.1

