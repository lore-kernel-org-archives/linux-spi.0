Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E03A1E96;
	Tue, 14 Jul 2026 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997809; cv=none; b=ELZGyrix50A1VAngQCakMiWxhpYErfiIfzk1ypJvSchS1siyh1E8Dtt2Jrstz2ynSLLgsiB2ITL/5U1n8GxMH1GnKHcYG5aFkXjBSyEBhc1E270O0ermJw6pRHg3QHyu1AmbcnnKDK2beWqHyj1OrSsOed+1QGpoSwKLT2hM2pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997809; c=relaxed/simple;
	bh=qV6un4UfrHNxZVm2e/g6K41vF1zaYz+HWXh3aQ8XQGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWT74b0k9j4D6ljf+vKnM6MGL2wRqS3f00IH65RbatngtO8Dl9udek9gDV8tDsyplj57lTJmz64nUb+C25+W1I/UYgTp9wuhqwweh9YBHcxIzltc/OTyy/ZkHnPA/sFhtmDa/HeGTqmRzCKnaOeWlkiZ3oGewpKnEn63Uq/YrbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kxYP4Iy8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kxYP4Iy8"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNloqD777904;
	Mon, 13 Jul 2026 22:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jBuuu
	X3+ttnZ7cpSV+y8xTpXIMHeFHbDYbWa+o/jGtQ=; b=kxYP4Iy8QnBBTqppgYgXM
	U8sQzinQHZEGSv5vW2Zuih5UrPLWL8LImAzO0vDKTmlU6eup92dKzo2srqQ8azZ8
	ouXeZwXUuU6jU/ZvP5eBWpfC3u2tyw8axYL9HxNUjag/SL8gjVqROpSf9FgbHP/I
	Zjw8EOMyCqWSCBbkJmRH36NmZYHQ5jivOUvjeqJOW3PYAvft9JU+Fv8B0tNMY1b1
	IH42a3FVvevydGL2DvBKZIWhPcDWbv87L+5y18trJegxHmPm84o+PoWn/ebLbbSv
	T5bDzyJ5wVCiVI1I3eMqlolhuJ6Ye7u5z8jUS6vqleeej+LscErqzM31LKY8MWP2
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fcx3qk6gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 22:56:43 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66E2ugxS028341
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 22:56:42 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Jul
 2026 22:56:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 22:56:41 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66E2uVaR021216;
	Mon, 13 Jul 2026 22:56:34 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andy@kernel.org>
Subject: [PATCH 3/6] spi: spi-engine-ex: Add support for multi-CS devices
Date: Tue, 14 Jul 2026 02:56:16 -0300
Message-ID: <844bb5dbe3a4f40f12575bc50b4e65875fa33d3c.1783729282.git.Jonathan.Santos@analog.com>
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
X-Authority-Analysis: v=2.4 cv=cqirVV4i c=1 sm=1 tr=0 ts=6a55a56b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=8iOLvlXn-sb-eJmLljsA:9
X-Proofpoint-GUID: HjOCM87hwfpZTE5OEhSKqbPIyWEXAyjg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfX5/eOn9E26ELb
 zfFSSXc317eoUdtVxBfK6G1yT2EZHH3xanbx0QK3lnngsDyILCEGYP5IPzv7R0kUXmF5ssnMsax
 IRx4RC2GeYaYuZyXRVfWlac8lLfAyoChGoYlkeYehYKJ7wB6cK6UzpUhf1kyQFf79c0Ty/q59qV
 2UjK7j08ZqbMfRO7rsgMJtlQsO2liIvERDPIshYU2/ovoCU0tY/H09bQin5Yov3hAoOaQyGlllj
 gs5AjjLNN/N2MKhCzZ1Jl33nKrTHkF0J2DhNnT0yZxO5eZxx9SZ8JBVgrPLlHjrxyU7q2pgZqNZ
 BTmOkzrTv6Hzvct7dO/BLCk5BUi+NKka/mr1PNs0u/wCGIQLyyz8t2kbtIhtvfnm/bnUol7x3k0
 UjOL8i/umCFxN8DS5KtSZPND2N4l8n7vCv90ZGvYcw8Zs0CxhpEr9/Z1xzLPXWfX3bOS0A8T0dt
 SZ9o6pZFxXqcehgJffA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfX1X/xyQSvyImg
 1XzrBLENB4dmVj77fk4fgt+lWNBEQxUxSzPW0oMg4BppBA7lNfV2iObCRzosIWYF7/WNeTwZu9O
 BkX9RIk5oz+n7ljKJ+rckkWCQCKdsG8OFoaCsNWC02zVyNjuc3X8
X-Proofpoint-ORIG-GUID: HjOCM87hwfpZTE5OEhSKqbPIyWEXAyjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140028

The AXI SPI Engine controller hardcoded CS index 0 when generating
assert commands, so only the first chip select was being toggled even
when a device declared multiple CS lines in the device tree.

Modify spi_engine_gen_cs() to accept a cs_select_mask argument and
iterate all bits set in the effective mask (the intersection of
xfer->cs_select_mask with spi->cs_index_mask, falling back to
spi->cs_index_mask when the transfer mask is 0). Update
spi_engine_compile_message() to pass each transfer's cs_select_mask
at every CS transition, including cs_change and cs_select_mask
change boundaries between consecutive transfers.

Likewise, modify spi_engine_setup() replacing the single-index CS
assert with a for_each_set_bit() loop over cs_index_mask.

Set SPI_CONTROLLER_MULTI_CS flag in the probe path so the core
multi-CS path in spi_set_cs() is activated for this controller.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 44 ++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 02bbc5d0cfc5..f2d0a6dd593b 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -46,6 +46,7 @@
 #define SPI_ENGINE_REG_SDI_DATA_FIFO_PEEK	0xec
 
 #define SPI_ENGINE_MAX_NUM_OFFLOADS		32
+#define SPI_ENGINE_MAX_CS			8
 
 #define SPI_ENGINE_REG_OFFLOAD_CTRL(x)		(0x100 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
 #define SPI_ENGINE_REG_OFFLOAD_STATUS(x)	(0x104 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
@@ -279,12 +280,17 @@ static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
 }
 
 static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
-		struct spi_device *spi, bool assert)
+		struct spi_device *spi, bool assert, unsigned long xfer_cs_mask)
 {
+	unsigned long cs_index_mask = !xfer_cs_mask
+		? spi->cs_index_mask
+		: spi->cs_index_mask & xfer_cs_mask;
 	unsigned int mask = 0xff;
+	unsigned int cs_bit;
 
 	if (assert)
-		mask ^= BIT(spi_get_chipselect(spi, 0));
+		for_each_set_bit(cs_bit, &cs_index_mask, SPI_ENGINE_MAX_CS)
+			mask ^= BIT(spi_get_chipselect(spi, cs_bit));
 
 	spi_engine_program_add_cmd(p, dry, SPI_ENGINE_CMD_ASSERT(0, mask));
 }
@@ -406,7 +412,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	}
 
 	xfer = list_first_entry(&msg->transfers, struct spi_transfer, transfer_list);
-	spi_engine_gen_cs(p, dry, spi, !xfer->cs_off);
+	spi_engine_gen_cs(p, dry, spi, !xfer->cs_off, xfer->cs_select_mask);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
@@ -451,28 +457,33 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
 				     inst_ns, xfer->effective_speed_hz);
 
+		struct spi_transfer *next_xfer = list_next_entry(xfer, transfer_list);
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list, &msg->transfers)) {
 				keep_cs = true;
 			} else {
 				if (!xfer->cs_off)
-					spi_engine_gen_cs(p, dry, spi, false);
+					spi_engine_gen_cs(p, dry, spi, false, xfer->cs_select_mask);
 
 				spi_engine_gen_sleep(p, dry, spi_delay_to_ns(
 					&xfer->cs_change_delay, xfer), inst_ns,
 					xfer->effective_speed_hz);
 
-				if (!list_next_entry(xfer, transfer_list)->cs_off)
-					spi_engine_gen_cs(p, dry, spi, true);
+				if (!next_xfer->cs_off)
+					spi_engine_gen_cs(p, dry, spi, true,
+							  next_xfer->cs_select_mask);
 			}
 		} else if (!list_is_last(&xfer->transfer_list, &msg->transfers) &&
-			   xfer->cs_off != list_next_entry(xfer, transfer_list)->cs_off) {
-			spi_engine_gen_cs(p, dry, spi, xfer->cs_off);
+			   xfer->cs_off != next_xfer->cs_off) {
+			spi_engine_gen_cs(p, dry, spi, xfer->cs_off, xfer->cs_select_mask);
+		} else if (!list_is_last(&xfer->transfer_list, &msg->transfers) &&
+			   xfer->cs_select_mask != next_xfer->cs_select_mask) {
+			spi_engine_gen_cs(p, dry, spi, true, next_xfer->cs_select_mask);
 		}
 	}
 
 	if (!keep_cs)
-		spi_engine_gen_cs(p, dry, spi, false);
+		spi_engine_gen_cs(p, dry, spi, false, 0);
 
 	/*
 	 * Restore clockdiv to default so that future gen_sleep commands don't
@@ -886,12 +897,18 @@ static int spi_engine_setup(struct spi_device *device)
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
+			spi_engine->cs_inv |= BIT(spi_get_chipselect(device,
+								     cs_bit));
+		else
+			spi_engine->cs_inv &= ~BIT(spi_get_chipselect(device,
+								      cs_bit));
+	}
 
 	writel_relaxed(SPI_ENGINE_CMD_SYNC(0),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
@@ -1222,6 +1239,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->unoptimize_message = spi_engine_unoptimize_message;
 	host->get_offload = spi_engine_get_offload;
 	host->put_offload = spi_engine_put_offload;
+	host->flags |= SPI_CONTROLLER_MULTI_CS;
 	host->num_chipselect = 8;
 
 	if (adi_axi_pcore_ver_gteq(version, 1, 2)) {
-- 
2.34.1

