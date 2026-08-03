Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708211CBA;
	Mon,  3 Aug 2026 03:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726131; cv=none; b=rUdEuc8/GAw2VMsePNivmna6guUwnhnF7nPrwN8u4YTh7tQrOHYmoULIrLq7V9OVVnUyySmrkpxmK5ZOOfZ0JHEg5UzKk7tN7qT4PSnux/+2fXbOiUe1yPmioVW18eINi+76V2Inma1ggmoXO05JrOJB7shCzWLRV9nRNdvMk8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726131; c=relaxed/simple;
	bh=ceOeFdD/eZvWQkRW66A2z3ifL6TCLTQVxILJCwAefIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tV9ipdwQ8SsqSyqTMEjLsCFjXa4S+aGtqwQk9DrKeyuHdZLNiAodzWAgVxR7M/w0x/YY1qSnGoYjCmMMU4ukaUmAWjzomK9dgOHEoprk8ZE2fxk1iFFWEbFGeTwCHyZPbQH7S5P3i6/UlG4wxFG+Eo72uPWD3eChEulbgTPdWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=peeBMAxy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="peeBMAxy"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LW66q1129364;
	Sun, 2 Aug 2026 23:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6EI2Z
	f3SLBERM9GccU8m9DFG9qen3UGYutrXkxS86c8=; b=peeBMAxy3mrkMgZaY9ony
	vm6NI3wtGZ7kYBus19+b+2xclwBFNisRh/akGuhyNzbapg/4WWIr0v72FsSaQbu7
	9aPDY+0yzOQMbxrIeWXQjdPXqbNlcoPLZ6+JR3LqyElejlpKqRSTvGSybvp0il0W
	C+9zNnFSQz/q1QUfLW5RwBcBGvXZGbP5bfuYFOc5bPAfGarFvzzbidzG5fVEP+47
	vh9avLWP/I1s5GFdsCHwigDsUMHirp3AEF27dtgFprSaY2HLN78v8jmhajrdgSPN
	sq046T+10jFNbWt9aNHYIrya0rr1A+TXxmrNVW1HZGZQ5t+tjHYXpNbWjJFTBJT9
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fsy4bt7jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 23:02:05 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 673324Y1035270
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Aug 2026 23:02:04 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sun, 2 Aug 2026 23:02:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sun, 2 Aug 2026 23:02:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sun, 2 Aug 2026 23:02:04 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67331rq4011631;
	Sun, 2 Aug 2026 23:01:55 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/5] spi: support simultaneous assertion of multiple CS
Date: Mon, 3 Aug 2026 00:01:48 -0300
Message-ID: <545ce92de534e90123af6fa1c75768b9482eb686.1785725359.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1785725359.git.Jonathan.Santos@analog.com>
References: <cover.1785725359.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyMyBTYWx0ZWRfX+vGTkrvXwYdO
 adNL0vda4SvQwy1GUpm4+Zgan6zov+R+0tjA6YWyDRhAbuP5SqnFSXvYw5TgNiIPFo54mzILkPx
 Re3KzDn4aJ3Xfqk2LB6GqYwd/fm+YLNUMY+PkplqZCUOf26utF/yCLG0Wpmd8DQEZMxAKBgcUuH
 W2jwYGuw6woHfmty6EByU/xEOC/1wVhkQtXuH1ibqDB2EEM90W+/IOiSOpGXvm08hXPAuOYZBsV
 QaK55YErjPE/bkBwl5Y54c+NpkYfr0F2gPDk3IA0wSJRcUVbIZjBr38gkLvmNWDyAqAIHhpnA6+
 ogbnmXM6Bh6xILTotaySpYrj9oAoS1phzxhqGRFj456TqRmz7hvzkqtuAC76hNQBspEs6vah9C4
 7ZVupsLl1FhaNzq0aMXMvx+9ZFza20oz2y9yCkI9Mus4s4YpKquucgVzcEgne7agnKZyOC8ncIs
 d44iT6hdrwdTD61BgxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyMyBTYWx0ZWRfX/MDiLv8foA2n
 rF6wLR4E2hcRCukgDzl+pF1hPV2egnWRznZiE4c5mbhwFJOYjWN92EHRCpeDcMB77l52FC5+UKS
 yUPvsxhZdm1sinB3O75XDpZAx6dmXdjv86VSt8qforfLgkKY+H+W
X-Proofpoint-ORIG-GUID: UubqVlN89pBwkxQl7lbK_kZApya2cDtw
X-Proofpoint-GUID: UubqVlN89pBwkxQl7lbK_kZApya2cDtw
X-Authority-Analysis: v=2.4 cv=QKRYgALL c=1 sm=1 tr=0 ts=6a7004ad cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=k-FQ2K6VbMuEqB_s0bsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030023

Some SPI controllers allow multiple CS lines to be toggled at the same
time. The existing code always used CS index 0 when tracking the last
active CS in spi_set_cs(), and unconditionally set cs_index_mask to
BIT(0) when parsing DT, both forcing the single CS usage.

Modify spi_set_cs() to iterate last_cs[] using each logical CS index
instead of always reading index 0. Modify of_spi_parse_dt() to build
cs_index_mask from all parsed CS entries rather than hardcoding BIT(0),
so the controller correctly identifies which CS lines belong to a device
when asserting them simultaneously.

Board info, ACPI, and ancillary device paths are not updated here.
Board info would require an API change to accept an array of CS values
and is left for a follow-up when we have a use case for this. Ancillary
devices are by design single-CS, so multi-CS is not a current use case for
them. ACPI represents the CS as a 64-bit integer with no established
convention for encoding multiple CS indices yet, so any extension there
would require a separate specification effort.

Acked-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v2:
* Include Summary describind why the other SPI paths were not addressed
  here.
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

