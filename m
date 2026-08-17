Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B02C15BE;
	Mon, 17 Aug 2026 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009601; cv=none; b=Lm9ftxbQyfk/Y/uz6QG2cLtKoxixPkjMfHt1AYhLmQHlrNi0hmKwFsgzkANceH0j0wmxyMLbGvpRIGToWO5pSNcOQChUJAVE78KmBoNQD720FajWPoC0mUNBsv3bJ7N9I11otZONZaUq4xwMsS7VLb5hZBYTEkPt+QPkWTgt9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009601; c=relaxed/simple;
	bh=Lk3F8LjVYmEMjIMhrygX3gzWYCTmczPnRoCGMKY0JYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHLH0oswKiTHdLmmX6h8WcFQcWSUc0JU66hloLvT5ew27VThD9DvXxkiwYGAMzKbXFLcNXqE9TEZqJrowQzEU1GmbXX02b2Yq9kxGWLUc58iYh82Fr4oAJhYRt1gwk07nJEOsCAeQ/AVg2TuveU/ZPd6pbpEfcbtk7Qu3qHxSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JSG+ARTW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JSG+ARTW"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLqsWO1731269;
	Mon, 17 Aug 2026 19:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UVS0t
	dlFIUaDBtjC0iI/1HoSrwk00F43xbD51P26C4w=; b=JSG+ARTWBFaXS727EoOTw
	i87xeLU2Q6bv4Z21GHJpY2F8EwscS/BlJ7IsAcpA1BbX1yI9iQF9vCD63X2eVLcf
	2/lJ7l/tQrjzPaPQ08Oa6Ex8rCQmZzYPiwHRsHuARmd2v77zDwr6Cv8vKNxU5A7j
	WQc5B/XbPsntorM8U83ZT8KMVxaRMi5jS77sIONDsktbYfWPI9XvK4HjQ//Bks3a
	7pjmsSd/kH5xFVHf3wLkemHkvcviPwEYtdrqF1e7RpZdxknlp9H5OSu9rjPbu1QC
	MryFD5tLYkNbT34wqwHfORhrC2nEag982qLCJjyJfiCtw5kKqmU521DOuSs7If8F
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g2hy02wnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 19:33:15 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67HNXEUA025247
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 19:33:14 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 19:33:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 19:33:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 17 Aug 2026 19:33:07 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67HNWsI6020595;
	Mon, 17 Aug 2026 19:32:56 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andriy.shevchenko@intel.com>
Subject: [PATCH v3 2/6] spi: support simultaneous assertion of multiple CS
Date: Mon, 17 Aug 2026 20:32:43 -0300
Message-ID: <e8870b405f29cc89439701d1fcc7e88781aaab22.1786973376.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786973376.git.Jonathan.Santos@analog.com>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: As2l_6XgCND0FQltQbNwIhJ8kpS9WYdi
X-Proofpoint-GUID: As2l_6XgCND0FQltQbNwIhJ8kpS9WYdi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE4MCBTYWx0ZWRfX8FxGdGg0hXE2
 Sjt0jhHdtIZy/kdYkGkz1W/DNuxIfsENFLU4Hbb1qm6z7Kw/dncfklFpqyd3iV7t/GTzrEZ9nWv
 /P/n2Rslqnem3FIvzPRmaEjWs0s3GvfbE8ivvNsjcHhpdxkKQWpY82XUyObUZGJ8LaSSu0MZQ4u
 0KdPn3Wm4jUQ+8P0RnGbJhFUKJ0ytzaNyz1u8fmI8NL4UkOASIdha6sxlJ2YoesENPa8loXySES
 lUXhyGhIEcPtfkPzPHY1ybMU9HKpsF75XH4nAOWXs8dyYVYQWAoko5rVNEl2gqABuXTvttR6PD7
 6uo0b+B6qewmnpBStyEoVs2uvdflP9xL9N92NzHj+5ykE4Ay82lmgGfg1eFwhzEAWRHGs5NuK8e
 ts09sa70gw14U6364mEn84coiaBmPXb+fxe0X4axP3HEvtc41YU9aWCL/FoDG4u4ZrSeAnmEmU7
 DdruoS/n6PuXomOjmtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE4MCBTYWx0ZWRfX/ee6tXdaR4c/
 PkF2fnqLaU4z868Gv30NOgSqabEEcEaW9a+jy9JTy9Xg9jXx43NZZnhHpZakVC5L7+F18c8UGU1
 1t7hVDWBhjGODuOfS9Wjzxtw4wBN5VzGefk+9Tvdz9Rv3uhfd8dA
X-Authority-Analysis: v=2.4 cv=KYTidwYD c=1 sm=1 tr=0 ts=6a839a3b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=k-FQ2K6VbMuEqB_s0bsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170180

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
Changes in v3:
* None.

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

