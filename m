Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64F443C0F;
	Wed,  7 Oct 2026 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374263; cv=none; b=NkMW19SRlwp3eMTUVEYLUkHHQEnG++HfA6Fpz1zAc76JlREEmEU2uW42GJtuf/8oPH46edTlmA0Xhb79GMK0zzbeUAkS7YJN5dAhGKCehMiv3TQgOEWfilVowMPvAvGX7WVfI4qCFY60RPCOChVX4+yrwXi7S6pxpKhsaNVUvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374263; c=relaxed/simple;
	bh=lcevZVNkW7YCDk6fWRAiPbb1pB3+4xJv8gp0MnyAd40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmZwUwp6eVJ0ceX+EIxDkuklEEXcP+D0yG4RjS3tR6HheuJXWD7Pyt2txzdOpILqtt4Vd7k9tXPQRYOAq0awDRJUuAqvkh7BnmoQo1yuUbND7omNi47OlnLPb2fMWBmiKQVJhuMqYv+RU1Zo6i7WEMMt1yhAYHDdIuSuSvJeYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=G7rhsCXj; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=q0fLVWy9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="G7rhsCXj";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="q0fLVWy9"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BXv4l1257807;
	Wed, 7 Oct 2026 07:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=za3oNAOB2bsst0aq9lmxdri57WN6aXU3DU5z2dKAEi0=; b=G7rhsCX
	jHkKnC8jjHOl+hsxnM50TwRrSVO6CSDEp0mDYOTZaFVFGa+UGsvNuHFpuwiyU2ay
	ptdL15BGxZBDxNy0EAjhfw/5g7R5sr2QkxH3quKaiV4Eg4eeQJdnudMnjicUd7Ve
	4zRCq8s/KGHvU80bVuVbJJCU397SofbzLCStWoHAL6IMA7kfRwO+Be02AYoRJgk3
	5Rn1sG+w5epQt3Ir+7Bjam0JMAkZTMTJKAVE3ca4N+QWTs7Q6nfSwAIZWXA+3F6R
	mjrFm0GV5mLRgH5GDUL99Dw4XFv/DtqSXzpneWOSLYysBqiitybZRrz58RU2O4fN
	EuCHXt4ozQnSpUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=za3oN
	AOB2bsst0aq9lmxdri57WN6aXU3DU5z2dKAEi0=; b=q0fLVWy9YEZvRMyCMn5u9
	9Inlbxh89bjAAlFUaZujKQzqBZi4VQAZUaYiBMXj9hFEJagrWI9ljrlYmaiyH03+
	459gJhUn7/geerPzaSMxi3veDFF5vhpqqR7Zzi6F0FuC1lBc7vssT73ZMloe4+Vt
	FxGSozSVGEc0FvR5JmygfOBFiH8pMlSXeyPlcZbBwQBnsJyBLGqa1uCwDy0B3J+Y
	Ox9fP0/HYsutyjPIKrHIlDNJcdRsFFCPdBpi2w5p72940KX5u7bqQivx591RvG+1
	+WX50Td1cBc0bLARUm4zviv1KL4fFxZKJthgwC88xz7ADXg61vGrbJwH3NHrPwR7
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h591yc47r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 07:57:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 697BvSCr041649
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Oct 2026 07:57:28 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 7 Oct 2026 07:57:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 7 Oct 2026 07:57:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 7 Oct 2026 07:57:17 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 697Bv27Y012208;
	Wed, 7 Oct 2026 07:57:05 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <broonie@kernel.org>, <nuno.sa@analog.com>,
        <michael.hennerich@analog.com>, <jonath4nns@gmail.com>,
        <andriy.shevchenko@intel.comls>
Subject: [PATCH v3 2/2] spi: axi-spi-engine: fix stale SYNC IRQ pending in trigger_enable
Date: Wed, 7 Oct 2026 05:52:46 -0300
Message-ID: <8d3f421e07b6114aae55f964825dba6ac9151cf5.1791361360.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791361360.git.Jonathan.Santos@analog.com>
References: <cover.1791361360.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: xjOjYnR3XjHmcTndQz7saOwRwdI7s2hB
X-Authority-Analysis: v=2.4 cv=N/S8hG9B c=1 sm=1 tr=0 ts=6ac633a9 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=e8Svylq1ojEWAOOCaiwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NyBTYWx0ZWRfX1tMpd8OjPzne
 qfry39LtEHTmS66gLsJFGAXy+8ns2Vk0f5597TA60xgDzdluohC1mvhR0di/ENmUXmN+lfyoQ7o
 a9vBJxbBCl6ofVRTlI+xwpFEBhTNpJ8oULoTGVxY4soczSQzXjleMYJqe/H0u22uFSeyiaZfJqC
 o6RUbWKfI840k2gUZzZbZ75GyWpZSAlXXP/RAsKEQXpOkTgCnN6dhl5f8i1bdVGxTd8M6MQzRjy
 mpQ+UyrdPzPOzsBiV/yg79Liw1Ldla1fLWiIglmeCdwNn8z7RlFsa0+NfFMUXsH30AEFKBVJBWo
 rpC/69ww3Cv/1hFV1moC6ejA+66Wpt2cBK7f+swrcnaOkW3gnbiFKr679T10j8as6g8kPasZ5TB
 B+jV9HP3VgcBDBFsyWwcuopljSOTKK/ro4UFFXB7NOUtwjOq0AwroWNT9oFfNmDoSVY1g6Qb0uw
 0OJMMk6kItphUsC/jFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NyBTYWx0ZWRfX3+ie+FUi4PcW
 qnVZ2KECblFmfAEbc/AKpqiOlVgEMdv5faz2z+Oxcf8scgxgQZDnvxheyHZeAB3b/kuF2OeSNIo
 IHGlkSmzt/cDtjnVhdOP4IP9ZxWbkAJ5Ts9VUsV/AYfJ1QGvMB4x
X-Proofpoint-GUID: xjOjYnR3XjHmcTndQz7saOwRwdI7s2hB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070047

spi_engine_trigger_enable() sends SYNC(1) and polls SYNC_ID, it never
clears the INT_PENDING[SYNC] bit afterward. This leaves a stale pending
interrupt that can fire spuriously when INT_SYNC is later enabled.

Simillarly to the fix on spi_engine_setup(), clear INT_PENDING[SYNC]
after polling the SYNC_ID.

Fixes: 8fc13b822c74 ("spi: axi-spi-engine: don't repeat mode config for offload")
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 87c05cb064cc..ead5b295e680 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -1036,7 +1036,13 @@ static int spi_engine_trigger_enable(struct spi_offload *offload)
 		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
 	ret = readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
-					 reg, reg == 1, 1, 1000);
+					 reg, reg == 1, 1, 1 * USEC_PER_MSEC);
+
+	/* Clear the stale SYNC pending bit so it doesn't fire when the IRQ is later enabled */
+	writel_relaxed(SPI_ENGINE_INT_SYNC, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
+	/* Read back to flush posted write. */
+	readl_relaxed(spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
+
 	if (ret)
 		return ret;
 
-- 
2.34.1

