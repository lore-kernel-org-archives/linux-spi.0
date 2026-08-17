Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66037C0F0;
	Mon, 17 Aug 2026 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009608; cv=none; b=ho2SvbeI1dBeYlDIZiFYlbhYl6BFs6/iJCD1Boumn7pL8knzHZafa64GCm9RVh2OfLz4hCbv0KAf2p/7r1MkOXHBJAIQXsS2qZntzFzKlTyT4JXWOeSKVKW5ZXny5e1ZXxH8RImFyVXAbGM2t4xL+dgTiC7P7D7ytT9tSVMdHws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009608; c=relaxed/simple;
	bh=zQvezol5TUt14zgSwjX8/JYwDtYEHk/IK22UDA0gNlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+iBr/QZQmz2rT28WwkmgXYIqfC2hm+3oNbg4agB/rrrIr+bsIGvtj3oIiOKfYLX626wA+rQzU3Ox9tHid1PsyQj7/opxentyqdZZfbUGAZzuMZ3WIav7fO4Jdx0WlAoW09ax0nrot3KjevbC2bi8WeLqsC62MZj2AgsuLrfXU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zAurNIXB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zAurNIXB"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLr1gS1731704;
	Mon, 17 Aug 2026 19:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=b7IXl
	DlTDRn0nyDwzsHIHsdP7O4M5rFW26rrhs7jfc8=; b=zAurNIXBb8h8GN1BHAdic
	CDMN73u5uYLrUBv5zeeaAfGyDn5cV/b6m6PqVRFJ7MtcVXbDfsVdB7H86wa07Jcj
	iCByTj8YieFKxrlSgYShy2LNacTjyWkUhYiAAlm9grLC0XyFW0UdnRKOF+Kz97ke
	zneLPXIEmExW/c2Oxb0qAy8pNndP9t0nsoPHwlMQP2S25lIkBJoagitafRxlvIdb
	491aJq8M5s/uaDyCUImq6vmNR7fKU4fpoYUDMfIlXVwzur+1pqqWexc648vZzZ/d
	UHTNrRWGF0HgsvsQFjcW/aK5PMJnC3qgAQeOcwMYWz/ZterXMrA9khPAb4kC4J/D
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g2hy02wp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 19:33:22 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67HNXLRt025273
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 19:33:21 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 19:33:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 19:33:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 17 Aug 2026 19:33:21 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67HNX8ol020600;
	Mon, 17 Aug 2026 19:33:11 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andriy.shevchenko@intel.com>
Subject: [PATCH v3 3/6] spi: expand device name to include all CS lines for multi-CS devices
Date: Mon, 17 Aug 2026 20:32:57 -0300
Message-ID: <5719698587a0a7658a3980168eef0731a5e7506a.1786973376.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786973376.git.Jonathan.Santos@analog.com>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: LzEtIW6TjCO5iBKXefAwDIL3EZwbs4oA
X-Proofpoint-GUID: LzEtIW6TjCO5iBKXefAwDIL3EZwbs4oA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE4MCBTYWx0ZWRfX823Ng8umkxFP
 e8mmSSqlRoKKDVEKYkG04P45e++wYPawu+ZKnWZVy0g2UeoAkPWHE6tRXH5zlOOhtAOE+rCDacX
 tyiplyEW7uW0OFk+5KPw/ZSu/NIFxCNlxbqrGoADDj+Q37cHv+WHZJ5vDCv8jLCP1UiccX+7QaT
 BJteRXGuj9liI9tcpBEUXa8q7sKnUfn8AnHMHEd9ZogIP+Klnu/asdcXx1XDLL4tkOQRMYDEuga
 hmdBgYl5OOGc0Y5pi05/BxNKey71pUsEBXvXoCs0L5cVUTANrE6hQ83BZeGR+U4kboPLCKF2Gji
 UdtbXw5hivJS4fevvrVPgkcoAcOD85TUd06DTTi6mQPZKvLayFQv9hlXUxTJ9VUo9zleGU2FSwF
 PWvRCv2uzrE3m5bp9YllIi3QYfeGCXKe3iriDqm7HUfaqiFUtqxJ3rAeTvg3Z8aeD+vXwY1fH7t
 MlM4WKgj0B3kVt6cogg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE4MCBTYWx0ZWRfX11UzLlkuU/sA
 2c8DAv56wh1iq/zTIWfjSYYwKyoFouyMK8HWw5mPrqdDfDsknTnfcZ1oDungG5dyHnLuTtr/Qpn
 0kk67bdDaSOwwQiEdoeYUAUslV9KITz5Vae1EFbxx+weVgzdMLtG
X-Authority-Analysis: v=2.4 cv=KYTidwYD c=1 sm=1 tr=0 ts=6a839a43 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=fYqlP5uAqiFSQV6okFIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1011 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170180

The device name for SPI devices was formatted as <controller>.<cs0>,
always using only the first chip-select index, ignoring the remaining CS
lines.

Change the naming format to <controller>.<cs0>+<cs1>+... so that all
active chip-selects are reflected in the device name. Single-CS devices
are not affected since the loop only appends extra indices when
num_chipselect is greater than one.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v3:
* replaced `int idx = 1` by `unsigned int idx = 1` in the for loop.

Changes in v2:
* New patch.
---
 drivers/spi/spi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 55fb96fea243..9ccfa5be557b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -594,6 +594,8 @@ static void spi_dev_set_name(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	char cs_str[32];
+	int cs_len;
 
 	if (is_acpi_device_node(fwnode)) {
 		dev_set_name(dev, "spi-%s", acpi_dev_name(to_acpi_device_node(fwnode)));
@@ -605,8 +607,12 @@ static void spi_dev_set_name(struct spi_device *spi)
 		return;
 	}
 
-	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
-		     spi_get_chipselect(spi, 0));
+	cs_len = scnprintf(cs_str, sizeof(cs_str), "%u", spi_get_chipselect(spi, 0));
+	for (unsigned int idx = 1; idx < spi->num_chipselect; idx++)
+		cs_len += scnprintf(cs_str + cs_len, sizeof(cs_str) - cs_len,
+				    "+%u", spi_get_chipselect(spi, idx));
+
+	dev_set_name(&spi->dev, "%s.%s", dev_name(&spi->controller->dev), cs_str);
 }
 
 /*
-- 
2.34.1

