Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571A3A0E8D;
	Tue, 14 Jul 2026 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997839; cv=none; b=ZeKyCkVTz8tYlbuWE5g3qSZFMsgnM6lLoHgxnOAXIuwKkXIDHuqinQ+w7wWzU0W/oXvk4g/MR231dRmTGWCPkKnj9/4ozGDf2Oo7Ce7Rz8aJnZcpq7YU0ZXBD5jDIAFtl4tFEUpt/wom/siyR1Jr3cRM4FvsptbLZLWAPhGimyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997839; c=relaxed/simple;
	bh=7V+Tu+rHjBswkQdQEFJBwu7YYFtsiEfbgwrWvX01p/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OH/oZXpW7tQ8m2z/RmgoL8jXKuDatBRLW1HgOuPS5bEedpf2VaWvxg+FWIbyw8WuuFC+1zWjdJjaube/LH9VPVFigfucSze3GXWwk8i0UMKTIQNop1kQN8CBCBnSZ0I59ezbgNr/qd4PWwxJu4jYKxScW23G474ZglveENwh/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Vh2a1ytS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Vh2a1ytS"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNmofu697372;
	Mon, 13 Jul 2026 22:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QOlkg
	pGezldJx6T+vwK4t3UcEtztt1/QXtFBdd/ODqA=; b=Vh2a1ytSfNS3Kzr7ekwIN
	nGgNQH1pSngc5wI/7fbyli18LKXdzfbRPaIQqvx5kin6FthO5y1XtLiCa4kKaC02
	j3MVyMXPrrdQPyscG8Y3azQtjaJH+uZaY99MnEuQgXAhwiUgfrKpUowkmKocaXfA
	F8ly5gNpzunL7fFfBhngIPhVBCXWRLujcEdfiRkwD8Bmh/QUc7Csie2dKLXx75iT
	n2z0RshbKbuDiRwo4UZaDhECNZrJn60Tqfl65FTvC/oSk72WWgkqahE/2w7b0sgb
	b47oygHLLrgILDaVzGu6wwapxt7eJEqpVUxDeLNKiz2uX7ID/o9va9VE8yqbMWxD
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fcx3ab4fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 22:57:14 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66E2vDBP028459
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 22:57:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Jul
 2026 22:57:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 22:57:12 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66E2uxsM021224;
	Mon, 13 Jul 2026 22:57:02 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andy@kernel.org>
Subject: [PATCH 5/6] spi: add rx and tx lane mask to spi_transfer struct
Date: Tue, 14 Jul 2026 02:56:46 -0300
Message-ID: <a0b2db6f6e436dc0413e61335b2d1e2ec2f6f018.1783729282.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1783729282.git.Jonathan.Santos@analog.com>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfX88Nn+a2Qtfup
 zL2YZlIer/sVLVsXSwb92BBF/u/NOHHHbNBgyM252Mj7OtG7JQcDoBrcAacrHlrt8G6qUhY3C7Z
 0lHz+Stb9Bc0m2ZmRqoOkUg4TyzPqlknqkGJ4XJKHY+0MVgmZAjJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfX/INTSbnwoYre
 GFO5fntkI9z7/Vzcl+BbcwI0mvmAgNQF/gs8K1axKIspNg3ifXQ8mVpemsZHEO8ys1a7MZ+tcaR
 t9nuFMxsKgadO3wQsg1Hp8OxkGA7/DVHCnT7FFvsZJ2pYp1Oxob1rRRN3a1sToQgun5vZMoeYTK
 BT1iv1drmWivayrzvm4y8u5Rt7iTCB6qYjFyGupPWy1JMFF+1edUgFBdWwIB+Hd7hICqf017Ate
 hu7m3V9tIIbnLyWmXhULZ0EUc+r95E1WpnIGhNcd2Vbqf4v8NbZJJY7OFcaAMt77hatsDSzFjg/
 UkScvBnxHj9QilACQS/i0zshtrYqxLxPkopdTfnEuT6kJwdACfooPGcX/DaZiF2QhTizPvcGMje
 UeKsuDDzZBsDcUPh/p9i9gxHib9oFUQkYpWIBnQfX+KT7NA+WbPlJ1PmRpDY+iiXBFm+RNG620f
 qGdbbnDEodW5lN8TXCw==
X-Authority-Analysis: v=2.4 cv=J8CaKgnS c=1 sm=1 tr=0 ts=6a55a58a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=L7ZkF6QJkGf9FD4nB-4A:9
X-Proofpoint-GUID: 9ALwoXVTXt6rrNV_iujeCpHtB-7K3AdT
X-Proofpoint-ORIG-GUID: 9ALwoXVTXt6rrNV_iujeCpHtB-7K3AdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140028

In SPI_MULTI_LANE_MODE_STRIPE mode, a transfer currently activates all
available lanes, but some use cases require operating over a subset of
lanes per transfer.

Enable dynamic lane selection for tx and rx by adding new fields to the
spi_transfer struct. Controllers that support multi-lane selection must
parse the transfer struct to update the rx and tx mask lane-wise.

Peripherals need to set values to the new fields only if multi_lane_mode
is set to SPI_MULTI_LANE_MODE_STRIPE and they need to enable at least one
lane, not necessary for enabling all lanes.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 include/linux/spi/spi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a9988db3fe2f..f4473d53b6b5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -986,6 +986,12 @@ struct spi_res {
  *      (SPI_NBITS_SINGLE) is used.
  * @multi_lane_mode: How to serialize data on multiple lanes. One of the
  *      SPI_MULTI_LANE_MODE_* values.
+ * @rx_lane_mask: Bitmask of lanes to use for receive in
+ *      SPI_MULTI_LANE_MODE_STRIPE mode. Each set bit enables the corresponding
+ *      lane. If 0 all available lanes are used.
+ * @tx_lane_mask: Bitmask of lanes to use for transmit in
+ *      SPI_MULTI_LANE_MODE_STRIPE mode. Each set bit enables the corresponding
+ *      lane. If 0 all available lanes are used.
  * @len: size of rx and tx buffers (in bytes)
  * @speed_hz: Select a speed other than the device default for this
  *      transfer. If 0 the default (from @spi_device) is used.
@@ -1131,6 +1137,8 @@ struct spi_transfer {
 #define SPI_MULTI_LANE_MODE_STRIPE	1 /* one data word per lane */
 #define SPI_MULTI_LANE_MODE_MIRROR	2 /* same word sent on all lanes */
 	unsigned	multi_lane_mode: 2;
+	unsigned	rx_lane_mask: 8;
+	unsigned	tx_lane_mask: 8;
 
 	unsigned	timestamped:1;
 	bool		dtr_mode;
-- 
2.34.1

