Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01F3624B2;
	Tue, 14 Jul 2026 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997781; cv=none; b=O70e6TEYyPDutdbyPr5s+3N1G28T84udx6zJ7Uz9r5/QXzF4r8E/1uyKPBWP++rdUkzn6m8NUT1kvRu3dDinnsZiqB4a2BGT6FYPE9x6wDDlg+jbtrC2nuZHcsdRywp1W7FbphIiQ1rLv4HsvEBfbFCa1nP005KftcWrMtqSFt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997781; c=relaxed/simple;
	bh=cxWzMtV3sfoaLLd7AYOwHNTZ8bTV4BufRq3OJivEFbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMs+ksHeZHW2noaSoWX53Jj44FU6SrYc+lr9ANNtzYoKh+bzzsUPboVQeCjQkm7ZD8U3tyFbteRtdc2NpupPjrhYCVPgfCD33IT56vzYce4GyOLpz7oOwJK6CiwojzxnYPO/gGd9QJdS6nRc59UldEDD7y4oaB1VeInzXuFyUiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jcgnIsgF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jcgnIsgF"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNlWAD464089;
	Mon, 13 Jul 2026 22:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TvZBO
	lc8cZ5+gnN/RuPFTL3InU+X1slEUYPtySS/5TQ=; b=jcgnIsgFcDcb5fqDgRfmP
	EP5c1kjKcjTH0Nu1EaPuKC8UzNpuPsPKqKE5+LmQwSr8U8lT704/yUBabvCJEVsc
	tRMAvZs2BORZY2PuXHtvLcFcMoz9CLQAPZfc9htRMl5Pk24Q+eoeDV6gmKmLRVot
	e89bEbAXN5wE7VTJ+PhEgKUDYJmKc5VFr1iFujc1E3+2HkBqQDxy61DXpRvfAyll
	BXSFI4L/Bm3hxXXEUQS9kIMJScGpeCMwoagBnzC3YN689kAMnVMrcQ1Px206bMem
	m3uNxmvNWQRGJyEx8VhWfyZ/f7m0cxNcTnUS9+NgCmJvXuCh65oBqsV2sNuMV0VR
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fc45bevp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 22:56:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66E2uFOd028233
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 22:56:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Jul
 2026 22:56:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 22:56:14 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66E2u1mQ021208;
	Mon, 13 Jul 2026 22:56:04 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andy@kernel.org>
Subject: [PATCH 1/6] spi: support simultaneous assertion of multiple CS
Date: Tue, 14 Jul 2026 02:55:48 -0300
Message-ID: <4a18b2d08916aebb3f8ac01d3c57679caf0e8caf.1783729282.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfX0aSfAs0GSSPS
 u1mv7fqIT1PdpYX6k75U8ocqpR21QLRkKvz80r0dwpKEPWS2f8ZUbXuD4Ptk7vM3a7pTl/R6UeD
 QyCuPrOGZ8AQo0YXc/8L3srDShPEkncOm1YyOwWn5gyfU5HGG0Vz7wzJxztxh76tLhKmlepFTUY
 qQX13ljFM4jXpHW4+DFo77d19931SFKbsRnOytKjiTlYXto2Dc1G7fjsXMl3vca39X8WsUVUQGF
 i83Z1ojhvOVEXO6RwoBvandWWHRnw/LCIcr2yk92QqYKrCWUDnPC5sdSy/25TfJE1SEpPuj0EK3
 zc66CFZJF87mCzgTzV4ap3AwYj6slh+RKGdt4VHLF7LRL3OBIOd46QIiO0uYSE1lSZnlV7wcpXM
 G4zJ+5QTj+vVJ6/zQJxS2/5WZ+5rXQdfbfwl+gB23oToyA0JhpceGYlUW/FAVyrtaiQXU4qeXu6
 yUaDbOPNe7DsshhEKTg==
X-Authority-Analysis: v=2.4 cv=CcA4Irrl c=1 sm=1 tr=0 ts=6a55a550 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=13qQ07JXM6sjQPzRH8oA:9
X-Proofpoint-GUID: iAjNVWYp1lgTdmt6XbfqE7CGszU8MUvS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfX4/DF03OB/lck
 P0osXO0T/hM1dFxUqS8rSJrivKmIvJWbKAVd3t6wFVF8W2asaaKNuJs82e8qe3fbPF7D5/JUkfR
 heYgEP0f/aCpIdwe2B+5UevDJERl9ZOIK4K03zzvHUGhJYx0LSa7
X-Proofpoint-ORIG-GUID: iAjNVWYp1lgTdmt6XbfqE7CGszU8MUvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140028

Some SPI controllers allow multiple CS lines to be toggled at the same
time. The existing code always used CS index 0 when tracking the last
active CS in spi_set_cs(), and unconditionally set cs_index_mask to
BIT(0) when parsing DT, both forcing the single CS usage.

Modify spi_set_cs() to iterate last_cs[] using each logical CS index
instead of always reading index 0. Modify of_spi_parse_dt() to build
cs_index_mask from all parsed CS entries rather than hardcoding BIT(0),
so the controller correctly identifies which CS lines belong to a device
when asserting them simultaneously.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/spi/spi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d9e6b4b87c89..55fb96fea243 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1090,7 +1090,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	spi->controller->last_cs_index_mask = spi->cs_index_mask;
 	for (idx = 0; idx < SPI_DEVICE_CS_CNT_MAX; idx++) {
 		if (enable && idx < spi->num_chipselect)
-			spi->controller->last_cs[idx] = spi_get_chipselect(spi, 0);
+			spi->controller->last_cs[idx] = spi_get_chipselect(spi, idx);
 		else
 			spi->controller->last_cs[idx] = SPI_INVALID_CS;
 	}
@@ -2594,10 +2594,11 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi_set_chipselect(spi, idx, cs[idx]);
 
 	/*
-	 * By default spi->chip_select[0] will hold the physical CS number,
-	 * so set bit 0 in spi->cs_index_mask.
+	 * Set cs_index_mask to indicate which logical CS indices are active.
+	 * Each bit corresponds to a logical CS index in the spi->chip_select array.
 	 */
-	spi->cs_index_mask = BIT(0);
+	for (idx = 0; idx < rc; idx++)
+		spi->cs_index_mask |= BIT(idx);
 
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
-- 
2.34.1

