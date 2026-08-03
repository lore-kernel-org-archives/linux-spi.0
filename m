Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA63254B8;
	Mon,  3 Aug 2026 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726146; cv=none; b=aVggKVElPkLwudEX9bFJwARJXhe2iG2HOBenFZ0cZm1DC5aIGxIU69fVqFhIQcQWeYdPVVLb7EcpoIHehX7BPytfAbHZhQ1ijzcxOmZdX91ryYh72q7bWLM5U/ijoVAZiyDiU4COdFq63oab04/lNatro9XZpWHLt+ap4CYFF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726146; c=relaxed/simple;
	bh=n1WDR3V+bGRxQ8T+RApatuEkpwNrzxX908ftxoNS76M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbNdLnhT4PfAfFBqRz82tvLvFsD6NKozV0VUfrrsZu72T9r2Xb+42e5M3+QnMuK4DCV05RD+FXHkV7l2K5iaHRQPo9GDWgPDxKHB1YWpGzzv5zLlyVadpdQwum22X8J6eZxzRI/7sR0tulHN8hUWAjROLRO+xWzKrQPn2FD7SsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wUeqNQyU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wUeqNQyU"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LXGRi1374091;
	Sun, 2 Aug 2026 23:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1Bz8m
	yjVZkwXcfWtMR4buMf1Q6oqm/zGiK0MXt1sfTI=; b=wUeqNQyUSiYCrziRQCJhq
	JPlANT/C1A3jHWIQ90O76oE9jPuewLJ9yGDJNSyxpg2tdCG7VFx3AQUTj1Ikiu8n
	8OygewdZlG2g/uozqXW9XR4Ur0eLhZBTvsVfp/FO1LrWcEXG769S6BnDJ5ZNdCfH
	5E2J1XhI7RxE5FAB5uxrJvedoRZ1nhOBmWn+BERn4r9xT4P7aIzP19ulDZobUu1c
	vhAmChdQ+lAlH1N51//XZbPTRtPJUj3ZWHzMBUoYfVDuGSAqDFAlN+chnsYoon/Y
	DjMXfS1eW8ErcNqT2KsiA16IHuQi7apzKJqZ66PV448oaHzUAtFV2m577jQAguBu
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fsdpxve91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 23:02:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67332I5A035329
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Aug 2026 23:02:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sun, 2 Aug
 2026 23:02:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sun, 2 Aug 2026 23:02:18 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6733270b011637;
	Sun, 2 Aug 2026 23:02:09 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 2/5] spi: expand device name to include all CS lines for multi-CS devices
Date: Mon, 3 Aug 2026 00:02:02 -0300
Message-ID: <897e40907207bf151f0f33937d48ac11a30a024c.1785725359.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1785725359.git.Jonathan.Santos@analog.com>
References: <cover.1785725359.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyMyBTYWx0ZWRfXw+PK4jPrMWLA
 y/GRPMfyFIKqRsg98ngkn9Ujvq5diIqJLFeH34JKN7UcfjbIPArEmQj1l6PIy7Dk0u2zLWWb1kX
 RA1Ps8/uOUYhavUYvKAgXxYj6YrgWqZcyktuPri3KlxOK7QEzd4a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyMyBTYWx0ZWRfXx+7cndVKBJNT
 1FPKWQ97/rIF4xq3Lu3jC8zdmHlp3ItZ9TaRRMQ+u26kJ0KoX30sBpfXGSCnNCjA7IaIWhrd/U4
 YrcV/JMWAeafevOhu+GX2FS+RXMNQDA8JR1kSm4QXgcrv8ntTJENnWOExsesFkdXdWJqL3w43ot
 EBSk1m6fIQtq4mdTv+Hgyad128EZNvoZuizEb/MFwYBro51t55jKftIb+lOyLsc0ao+JnN0gHCE
 rdfFOzQWITbeN/u/Hs0UXRBTG8acC17EAfTP6m2ucud5vueYWSKvCAUTWa84u4Q+2gTVSljIL3U
 jqXdRR7D7OXmHyLeXjxjUCzMMznYpESZyBLukXi44wS8ZnVeR3OJ1K3vZJh4kfFG3G4hKuhmLl+
 I00Hn+40FpEtzkGe6U37fQAYtF/ZTG7PylNKwcwrAHc7EFTawqjFOa0eyDjBuI78ds52oL+sxsY
 veHh/IShiVrpU2ToBGg==
X-Proofpoint-ORIG-GUID: HZ17TvJDZQtGflkZBXTZ6hD3OckiWZrX
X-Proofpoint-GUID: HZ17TvJDZQtGflkZBXTZ6hD3OckiWZrX
X-Authority-Analysis: v=2.4 cv=PJE/P/qC c=1 sm=1 tr=0 ts=6a7004bb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=fYqlP5uAqiFSQV6okFIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030023

The device name for SPI devices was formatted as <controller>.<cs0>,
always using only the first chip-select index, ignoring the remaining CS
lines.

Change the naming format to <controller>.<cs0>+<cs1>+... so that all
active chip-selects are reflected in the device name. Single-CS devices
are not affected since the loop only appends extra indices when
num_chipselect is greater than one.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v2:
* New patch.
---
 drivers/spi/spi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 55fb96fea243..61423aee1525 100644
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
+	for (int idx = 1; idx < spi->num_chipselect; idx++)
+		cs_len += scnprintf(cs_str + cs_len, sizeof(cs_str) - cs_len,
+				    "+%u", spi_get_chipselect(spi, idx));
+
+	dev_set_name(&spi->dev, "%s.%s", dev_name(&spi->controller->dev), cs_str);
 }
 
 /*
-- 
2.34.1

