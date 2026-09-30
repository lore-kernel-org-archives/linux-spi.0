Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B3361DAD;
	Wed, 30 Sep 2026 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734714; cv=none; b=kPju6EwX8KyKeDjFJEDSYAJraBz26Pe6nCDLt4gmkFLE0dIMaPjrTt8t1iGf44b5hXnjSa1WE8tpvCLg/ethHoAvR7hmGpoGazOPc90ssZf4v99N49G5QM/6XLWVC4YQP4snD6BsDchIX4QfOiNgL54CUXEVyBJe+HevHdt7Wmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734714; c=relaxed/simple;
	bh=nQ/pssnRnmPWVvCCGrnJKmINF1GBQQdpmPlwCCb6EYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1S9Mv37t0YuLgyOHJxT1LgcjBr4BRvPPUR3nVU4jslSS5Rf14B8DpboHlMGCAKZYptcBHBY6rXmoZxNilzinSH0Rmijfs8zLZvQDgctrXLXN6z3pUnJbpRHuulJZD5DGONYEFSqI3AAZW0ITEHwLhzcDDvparkxiqUH2HfT/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MyhSo5Of; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MyhSo5Of"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U2DjRI159516;
	Tue, 29 Sep 2026 22:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6/9/M
	S17AR5+L/FWYvJEkQuYKwk+vcPwM6J9nsoE6fU=; b=MyhSo5OflJZzUOQU7dtOI
	6v+5IOzqrwo1NimOkcWDTi8pMzycxcTEad8jYpFG4sGenR1GEj6bBEkeuAroNoDe
	08weBeePips+vN1gvf9NS9TIabtwjqG/taeu2aZKdZC+AZBqnqTZ+MJgRZIAOia9
	Xd4aXQMW68p3oUNtZw++NsP/OQWHuI8w3LYBh+Fx30AM+hBSXhFFKhBpGlxHCqu6
	DBJzsPjCqS3PBwu+QcCXwlLwoWkqksaDJ4Oc9PJA0xO70NAhzDf1kNi9y6bxjtS1
	dowxLjZObiX3S83FpGmp154f+LJOCIL5UiFY6/c6FuuPSHmvcfy0xvZp7zboIBW+
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h0jhsa839-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 22:18:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68U2ISiO047950
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 22:18:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 29 Sep
 2026 22:18:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 22:18:27 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68U2IEue015864;
	Tue, 29 Sep 2026 22:18:17 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <broonie@kernel.org>, <nuno.sa@analog.com>,
        <michael.hennerich@analog.com>, <jonath4nns@gmail.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v2 2/2] spi: axi-spi-engine: fix stale SYNC IRQ pending in trigger_enable
Date: Tue, 29 Sep 2026 23:17:45 -0300
Message-ID: <b1573f16b8e30f22877677026bc2296420a0c527.1790731588.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1790731588.git.Jonathan.Santos@analog.com>
References: <cover.1790731588.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ZbeIpcVA c=1 sm=1 tr=0 ts=6abc7175 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=0xhvZQ9x_G-bgwfll7QA:9
X-Proofpoint-GUID: TGh3EuU6LpLgAlw_W3ZPmFDomKfRMKyz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwOCBTYWx0ZWRfX6Iz5l1vaPxdA
 WxW08frGOxfobd4OH5ryffHc6cZsG6FzAnNc8att0ouXMh1/GrhygxaysSwD+hWv0Gw/PkNxBcB
 4G/xGXqnBpTMKc/gy3leHn1wcp7UopG00Ltb1ZH+ZvplAIgrkgIG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwOCBTYWx0ZWRfX9LuIJpPEXv96
 F4EUBzNyqGlYuew/waR+VThQm1VO7xFnFt6WGI9a3IeiC/1dPXDgGU6PFPxZmpwTxeMHLz+aEKT
 vSH3X7qIEUf7RwCM1OTb2NDENtDlsZRVxWqtKD2I42zgCXQWvjsu4pmqII9FWIBBBSETAsJkqil
 gIdapB4lCBAAs6onmDnrAbZNJpez4ue/NdsHsDpYDJ2YITJ1vxAdEaUBbkk1HAdfn/rDSeWAZtg
 cuYFsegcHX0KjmnWC3DoLj2HfnUsmFAN1Umfbj+MFo77LfHjP0Qi045SI1GkJcZSh4vDtsGKzkj
 g1VyUZbm/Wmi6yXRCo5amREV3ciTqkV8wp9yJmsuKviEQk/JsBKe6gO1yu4iQG/fuZq/Bxbqcxg
 Fm70G/W7xPYlwhL1u3vwP5qnqmrJL23MZRnjaIyRNtc5IV0uGIZFupfAXZUBJS49QRZNVV4p2D+
 yHMi64VQLaFpvNY4HJw==
X-Proofpoint-ORIG-GUID: TGh3EuU6LpLgAlw_W3ZPmFDomKfRMKyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300008

spi_engine_trigger_enable() sends SYNC(1) and polls SYNC_ID, it never
clears the INT_PENDING[SYNC] bit afterward. This leaves a stale pending
interrupt that can fire spuriously when INT_SYNC is later enabled.

Simillarly to the fix on spi_engine_setup(), clear INT_PENDING[SYNC]
after polling the SYNC_ID.

Fixes: 8fc13b822c74 ("spi: axi-spi-engine: don't repeat mode config for offload")
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 0de3af5c429c..d0e5b7bccf55 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -1034,7 +1034,11 @@ static int spi_engine_trigger_enable(struct spi_offload *offload)
 		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
 	ret = readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
-					 reg, reg == 1, 1, 1000);
+					 reg, reg == 1, 1, 1 * USEC_PER_MSEC);
+
+	/* Clear the stale SYNC pending bit so it doesn't fire when the IRQ is later enabled */
+	writel_relaxed(SPI_ENGINE_INT_SYNC, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
+
 	if (ret)
 		return ret;
 
-- 
2.34.1

