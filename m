Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306EE37C922;
	Thu, 19 Mar 2026 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889615; cv=none; b=CYKHZZ8J4LU4WF205yGiHRoGQOlaSrQpRNoIa7JwzIXTvF+7xmzvvtrbNGYKMbiBHEeMkT8BaqGYBB7j+fY3/l6Nk7fyls59vFn2hwKKrklPT/nh3Zj1iQ0xT6ucCZ3kQpbHU9QUmtONjO/+wPKSP8cdje7I5irw7vAhTV5GpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889615; c=relaxed/simple;
	bh=nI5oFqBnawhvCbv3xOV5lIGxp1FqktC6I4o4VRCiTbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ilzTr63NHXel4EA1EN76di02I/A6512gGItfevNYtQXURoajsfap1Lhb2326iKTQxusZOY60EX83LC9nx0pOtnqiX9Rk1XKTKcAXO1GPb9HXDt/159uluH+MA3yAaL3kTpJcCrjMj8054cPuA4lkAnEPGQjmscfR28z4wdGkZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: abd512fc234011f1a21c59e7364eecb8-20260319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:55496950-00c4-44c2-8be8-3e06f9697035,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:89c9d04,CLOUDID:659065706c894980bdc62be9c201cd68,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|16
	|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: abd512fc234011f1a21c59e7364eecb8-20260319
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 879534120; Thu, 19 Mar 2026 11:06:49 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: shenyang39@huawei.com,
	broonie@kernel.org,
	f.fangjian@huawei.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 2/2] spi: hisi-kunpeng: Add timeout warning in FIFO flush function
Date: Thu, 19 Mar 2026 11:06:42 +0800
Message-Id: <dad95ce42fb5677edfed32bc1f9b3e54df2cf8de.1773889292.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1773889292.git.xiaopei01@kylinos.cn>
References: <cover.1773889292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When flushing the FIFO, the driver waits for the busy flag to clear
with a timeout. Change the loop condition to use pre-decrement (--limit)
instead of post-decrement (limit--) so that warning message can show. Add a
ratelimited warning message to log SPI busy timeout events, aiding in
debugging.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-hisi-kunpeng.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index c42d2a2cdf1e..046bd894040b 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -208,7 +208,10 @@ static void hisi_spi_flush_fifo(struct hisi_spi *hs)
 			break;
 		}
 
-	} while (hisi_spi_busy(hs) && limit--);
+	} while (hisi_spi_busy(hs) && --limit);
+
+	if (!limit)
+		dev_warn_ratelimited(hs->dev, "SPI busy timeout\n");
 }
 
 /* Disable the controller and all interrupts */
-- 
2.25.1

