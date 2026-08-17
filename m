Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C23F1660;
	Mon, 17 Aug 2026 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009638; cv=none; b=A6hHk4qaPyss9OWVJvjfUKvVD6DBbuhJBn3OnQlxVDEvJa0jnVkuZymuJcWTV0eluxgyb1X/mNPjZROhBUXpPaS58KXkIR7f0WEg2+QieaArio2zh/VTteHG/fHQ3LhiNErZRajwyBscDOeOxZ1ADk+FqrZR/Or6usIce/h6k3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009638; c=relaxed/simple;
	bh=HaIqB9LMNgVlLpnaCK6HjTB/BITFb/+7Mki/WxhjpNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjMsXe7cgwEegWdgELXMoJYo5vBUnwJGc41LqnFnnqIqbdPmR2KDmdqIIdmiptZZ6MF9PfRMlcX2DxQ9cO0636RpcjSt7tlmLcOWGenOCzwelwxHrWBQ8e3Gbj7qhQsF5PMY3PDn8o7nVaNh9Rn4ANqkDpTzujjV8Gcvq1yLZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=s/lU+IpB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="s/lU+IpB"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLqtH51731335;
	Mon, 17 Aug 2026 19:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=N7ae0
	PKVPxcM5CBQvXj43YM5IzZcAR/QZ5nLaoDVPBA=; b=s/lU+IpBFge8fJ9qJacUc
	tu36vcv6/7CbZq/EkGdlTFyycKs8lbVHWv2Ot3rJJrpkLYb7S6SriuhBFjiordDL
	1pYGt1vte/zYdXdp6H1vNiRxznLZhxzZpeI/MutqO6/oPo3rNDZzq1qCtOGdW9Vp
	LCQhkqLYLc9cufQum8DXNJhE1WK7mzC+UAj9G0kpIk1KzYSqGARZSky3EKy85pda
	mjWceKBW9+IYfhsqNp/WaUGnHFzbCMRxjPS1/TVSVTPb0caLBpy6isElA0g0qsf1
	nymwBFzjbyRtAhBF5TZeK1ymNodOSdYZgiT5N7xD4h69plDgdV3X5Q53tKIl7qol
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g2hy02wsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 19:33:52 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67HNXpg1025347
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 19:33:51 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 19:33:51 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 19:33:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 17 Aug 2026 19:33:50 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67HNXbKE020613;
	Mon, 17 Aug 2026 19:33:40 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andriy.shevchenko@intel.com>
Subject: [PATCH v3 5/6] spi: spi-engine-ex: Add support for multi-CS devices
Date: Mon, 17 Aug 2026 20:33:26 -0300
Message-ID: <1e369b85711dc01d3494645d8bf60036cdad1134.1786973376.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: nvTko-orq1pfLC7KUmYjZ2gSzS2kwlWe
X-Proofpoint-GUID: nvTko-orq1pfLC7KUmYjZ2gSzS2kwlWe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE4MSBTYWx0ZWRfX6QkNUKJnSUpJ
 5mi10UpnV3swWbOUAu5PYNCrCkZCHHJt7TflPOCdVCoC4NqJ+pDChFA2hHrSL4iPE1cH1lXNavg
 hJRYiETf2zg3keqmFevlhIQdcaDjLTq4x1LsSAETbJWxyg50GTUKjHbnbrsR6V9tBIorhR3+Ov2
 Cb6BQrsqtLEPtt5wFMOoJT3qMa7QL55kVPf06SYsiS3KBM/VyJn4aMZI1VOfwJ/hJvlLanyWzTm
 44pF9BKSAPiv8CWpj52bv7aePECnweZlB02cCWZNLJQOpQagZdQwf7pRjxHFp55yqV/7pFJ/H75
 nGlTrDJThLjBzBtuiEaooSdKREjN0Ilg3ttyY2j7Ft+J0X4gilEWYjeB5PhRsg0ybQ214e59oUT
 BJAxn5eeITBlgbNZ2NCO7SWpuh7hNc1/1ljxVE+z9G+fwOUY05QyTP6oYn7QFCoYGWZW7GPNWnz
 bosoaBgAfFs3Xdku9QQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE4MSBTYWx0ZWRfX9jxXSAB4fErb
 6KtKVlQf/e4uWtNZeDX9lj1zDG93d17UxircNBa+ntduTFwQxnQHA4LvjARr6DtoeKv9ZMfNtVq
 OHkZZLJwC/hvUX/SBTzwuaEbiHfHaqERtwCx5ITKG9ZP1ovgVBBG
X-Authority-Analysis: v=2.4 cv=KYTidwYD c=1 sm=1 tr=0 ts=6a839a60 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=ENVVfsUtpBKDjCfSmAkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170181

The SPI Engine controller only handled the first chip select when
asserting CS lines and configuring CS polarity inversion, ignoring
additional CS indices present in cs_index_mask.

Update spi_engine_gen_cs() to iterate over all set bits in
cs_index_mask and toggle each corresponding CS line in the assert mask.
Update spi_engine_setup() likewise so that SPI_CS_HIGH polarity is
applied to every active CS index rather than only index 0.

Set SPI_CONTROLLER_MULTI_CS in the controller flags to reflect the
capability to the SPI core.

Acked-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v3:
* None.

Changes in v2:
* Adaptation of the patch
  "spi: spi-engine-ex: Add support for multi-CS devices" from v1,
  discarding the per transfer CS mask and keeping the Multi-CS support
  only.
---
 drivers/spi/spi-axi-spi-engine.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 02bbc5d0cfc5..8a2cae81aea6 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -46,6 +46,7 @@
 #define SPI_ENGINE_REG_SDI_DATA_FIFO_PEEK	0xec
 
 #define SPI_ENGINE_MAX_NUM_OFFLOADS		32
+#define SPI_ENGINE_MAX_CS			8
 
 #define SPI_ENGINE_REG_OFFLOAD_CTRL(x)		(0x100 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
 #define SPI_ENGINE_REG_OFFLOAD_STATUS(x)	(0x104 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
@@ -281,10 +282,14 @@ static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
 static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
 		struct spi_device *spi, bool assert)
 {
+	unsigned long cs_index_mask = spi->cs_index_mask;
 	unsigned int mask = 0xff;
+	unsigned int cs_bit;
 
-	if (assert)
-		mask ^= BIT(spi_get_chipselect(spi, 0));
+	if (assert) {
+		for_each_set_bit(cs_bit, &cs_index_mask, SPI_ENGINE_MAX_CS)
+			mask ^= BIT(spi_get_chipselect(spi, cs_bit));
+	}
 
 	spi_engine_program_add_cmd(p, dry, SPI_ENGINE_CMD_ASSERT(0, mask));
 }
@@ -886,12 +891,16 @@ static int spi_engine_setup(struct spi_device *device)
 {
 	struct spi_controller *host = device->controller;
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	unsigned long cs_index_mask = device->cs_index_mask;
 	unsigned int reg;
+	u32 cs_bit;
 
-	if (device->mode & SPI_CS_HIGH)
-		spi_engine->cs_inv |= BIT(spi_get_chipselect(device, 0));
-	else
-		spi_engine->cs_inv &= ~BIT(spi_get_chipselect(device, 0));
+	for_each_set_bit(cs_bit, &cs_index_mask, SPI_ENGINE_MAX_CS) {
+		if (device->mode & SPI_CS_HIGH)
+			spi_engine->cs_inv |= BIT(spi_get_chipselect(device, cs_bit));
+		else
+			spi_engine->cs_inv &= ~BIT(spi_get_chipselect(device, cs_bit));
+	}
 
 	writel_relaxed(SPI_ENGINE_CMD_SYNC(0),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
@@ -1222,6 +1231,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->unoptimize_message = spi_engine_unoptimize_message;
 	host->get_offload = spi_engine_get_offload;
 	host->put_offload = spi_engine_put_offload;
+	host->flags |= SPI_CONTROLLER_MULTI_CS;
 	host->num_chipselect = 8;
 
 	if (adi_axi_pcore_ver_gteq(version, 1, 2)) {
-- 
2.34.1

