Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840AF296BAF;
	Wed, 11 Mar 2026 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194164; cv=none; b=Vi5yFfYBE0GzNbq712mO2AjKFY8auEYbqOAEm2+L81e/n90kje+wOjNUORyulo6jrlxAgQh2edLQ9cLd+5qS73ukplT9MWD33Co2mxlBuoywPacFTIV7Yr5hW2UMZh7LUZZyi0NqzmMqWPBxz5eNmevArcyKLBBMi2U7GAZPy3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194164; c=relaxed/simple;
	bh=vpQIPre32H9LBlfeD8ehOCS6WsRhJKLy4RzsZrJSIqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XhzYlnBO3wMMEwuPxvji1it6eqEFzFExo1UcbgJniJ+EkxOYzpcT3QOnwkePMFjN5qFcwA178WE9Hy5tkydE5vk7P0RLrdJO1TIKWMOTuP0RBjZ7oZZmR3tPgPjT9uYckR9VZpHKnUWeoqpyV9Q07uv2+yjbG5GEw+Fod3zMf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6cbf7c461ced11f1a21c59e7364eecb8-20260311
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:5bd3716b-86a1-4fb3-acea-2b6050028e6d,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-25
X-CID-INFO: VERSION:1.3.11,REQID:5bd3716b-86a1-4fb3-acea-2b6050028e6d,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:89c9d04,CLOUDID:422b830c1254eb8ac3dc169e809ca798,BulkI
	D:260311095550AOYODZ3M,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6cbf7c461ced11f1a21c59e7364eecb8-20260311
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 553752640; Wed, 11 Mar 2026 09:55:48 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: cl634@andestech.com,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2 0/2] two cleanups in atcspi200
Date: Wed, 11 Mar 2026 09:55:12 +0800
Message-Id: <cover.1773193726.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1.Use helper function devm_clk_get_enabled() to simple code.
2.fix mutex initialization order
---
changlog in v2: fix return code error and leak the controller
---
Pei Xiao (2):
  spi: atcspi200: Use helper function devm_clk_get_enabled()
  spi: atcspi200: fix mutex initialization order

 drivers/spi/spi-atcspi200.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

-- 
2.25.1

