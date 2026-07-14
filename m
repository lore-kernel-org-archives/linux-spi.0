Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5C3A1A21;
	Tue, 14 Jul 2026 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997855; cv=none; b=qv/KkK3hkwKyYJJ3s9zaiFmtHMMLL7IRVbEGBNJo0UFDRBjGT0sKtPnG9JBXqFGNQXmZhcfes4mcUQ5f9NNji4cziiwHdUm95+rV98v4mpP+nddeMddQd/kxe8SvGiIy9GS6Zt9MVtZ3oQzAOyd6bXhSFE3NFWYVYDRP7VGXMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997855; c=relaxed/simple;
	bh=GU74mPplPXE0itQC1rJ9CFZOZBCTYO8tTFd3vF1hKP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkHLuMdGIUVHhZYrLsJFw8+Ry01qgY0DvArI1jVnrsfDn4RktiQqXccAVWTAYeI4yWdOGAuMnvvoB5PqGKGsBsDKj2JMlKP99rUlunXrmRao8ENeEEIXgz4Xfi8NKYYZZS4Crl0/+nyG/lAqNoFly0jN2Bc927Mfol5rjRposSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zrxWZwlS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zrxWZwlS"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNljr8464638;
	Mon, 13 Jul 2026 22:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CBJq3
	OzQhrzoqwc8Eh/eX9nWFqAutAY9ZXRvKbCBSXU=; b=zrxWZwlSN2PdFgxOpzBUR
	I79o3X2zYWCHcBGpUlc6jjiyzyWOkQdGs3N3Bk9D5lDs8nf+B1Kvkf4hZvLSCDz6
	zxMBxRBzjQ/tw/pia5DSPKRCyhGOSGDQN6T6pRz/0eTLsOZyU+sqbSXNIjXjMnNh
	g7zeF+ObXEzdf4Xvr6lBbt0p9u/Zp6AR+ydArW1XRuryFRZhtX7t9VA7AvUKr04N
	bdvr5Vk4JxhafVsI2xD9yDavbFHi+rrl+Yu03mPvIhy2UmBaBEuL4BPrPTWKy9bM
	pYNjmMoQPPV0BvD7uOnHL4Jl58q/nTcfKF9xxn/zKDNxgEB1wf6u5cdFPBQXYLMl
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fc45bevsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 22:57:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66E2vSeW028533
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 22:57:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Jul
 2026 22:57:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 22:57:28 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66E2vGPW021239;
	Mon, 13 Jul 2026 22:57:18 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andy@kernel.org>
Subject: [PATCH 6/6] spi: axi-spi-engine: add support for dynamic multi-lane selection
Date: Tue, 14 Jul 2026 02:57:00 -0300
Message-ID: <c37b7c63f8d5e4e0df6f0130d202e1d2291e12af.1783729282.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfX9nPxqNFeDG4Y
 qXAM8WCdidC4gGGt43YdWti0zBfQpqkdr5T6mh3wj6e29CpjwRvDL8bNuQ75oYFGD9eB5OnLPWV
 k4/loWyiyx3K7DCJ1LXueFtrNOMC8ALnflt9iFltdwsNEXXMmvUHZNKB1oAYIosgzILeBTaJCa0
 VjC4tsKMQmFlg/DcDGCdnwpZdGn/FtBZgjtCL3WAo3ob+wPLaVVWuKd1yakYhObPDIGa4BGOSa3
 hKhB7+yv++ycTbecZ4rltX4XQRmT4yKPStxF3jLHen+uovp1sVvOUrEaOhQqyLTZtmkE60iR93t
 F3aOfSWEtP9RB66SPF4wAfg/bOgqs1hzH2CN9t4qKpUGq7JGvYotxgcEjgy4CAOhitEFRxJpFZc
 Ryhg+Sfho0ZKxgqqPqYenA3iFsGsm8PWLlmD2KB1VS3h0COUdNR29uAy9nUlnN41butYCqi+Oq8
 t69ZQzVdpMGjTh91ybg==
X-Authority-Analysis: v=2.4 cv=CcA4Irrl c=1 sm=1 tr=0 ts=6a55a599 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=RTuk8bJzp5siEuWeIw0A:9
X-Proofpoint-GUID: 6Wd12TLpncmVUQQIleHuFuZCFeyuGXPV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfX1LlZOI9TdnuQ
 5/8yTrYWheQzMwN54QC3WQQdClpfgBE3i1gwrxpjB0/IQMvbPhXEK0iaQtsHn2DcNUL9sPc73Yj
 Hpwbmp5w+PAgL1LAjPMH6tIKrWh0Wu081MoX0UJqyPhK1bXAPCam
X-Proofpoint-ORIG-GUID: 6Wd12TLpncmVUQQIleHuFuZCFeyuGXPV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140028

In SPI_MULTI_LANE_MODE_STRIPE mode, a transfer currently activates all
available lanes. Some use cases require operating over a subset of lanes
per transfer.

Make use of the rx_lane_mask and tx_lane_mask to allow setting the
multi-lane configuration transfer-wise. Rename rx_all_lanes_mask and
tx_all_lanes_mask in spi_engine_offload to rx_lanes_mask and
tx_lanes_mask, as these fields now hold the active lane mask for the
message rather than all available lanes.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 62 ++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index f2d0a6dd593b..d6c5264fee9a 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -115,6 +115,10 @@
 #define SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN	-1
 #define SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING	-2
 
+/* Extending lane_mask values for optimizing messages. */
+#define SPI_ENGINE_LANE_MASK_UNKNOWN		-1
+#define SPI_ENGINE_LANE_MASK_CONFLICTING	-2
+
 struct spi_engine_program {
 	unsigned int length;
 	uint16_t instructions[] __counted_by(length);
@@ -155,8 +159,8 @@ struct spi_engine_offload {
 	unsigned int multi_lane_mode;
 	u8 rx_primary_lane_mask;
 	u8 tx_primary_lane_mask;
-	u8 rx_all_lanes_mask;
-	u8 tx_all_lanes_mask;
+	u8 rx_lanes_mask;
+	u8 tx_lanes_mask;
 	u8 bits_per_word;
 };
 
@@ -312,6 +316,8 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 	unsigned int clk_div, max_hz = msg->spi->controller->max_speed_hz;
 	struct spi_transfer *xfer;
 	int multi_lane_mode = SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN;
+	int rx_lane_mask = SPI_ENGINE_LANE_MASK_UNKNOWN;
+	int tx_lane_mask = SPI_ENGINE_LANE_MASK_UNKNOWN;
 	u8 min_bits_per_word = U8_MAX;
 	u8 max_bits_per_word = 0;
 
@@ -339,11 +345,21 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 				return -EINVAL;
 			}
 
-			/* If all xfers have the same multi-lane mode, we can optimize. */
+			/* If all xfers have the same multi-lane mode and mask, we can optimize. */
 			if (multi_lane_mode == SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN)
 				multi_lane_mode = xfer->multi_lane_mode;
 			else if (multi_lane_mode != xfer->multi_lane_mode)
 				multi_lane_mode = SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING;
+
+			if (rx_lane_mask == SPI_ENGINE_LANE_MASK_UNKNOWN)
+				rx_lane_mask = xfer->rx_lane_mask;
+			else if (xfer->rx_lane_mask != rx_lane_mask)
+				rx_lane_mask = SPI_ENGINE_LANE_MASK_CONFLICTING;
+
+			if (tx_lane_mask == SPI_ENGINE_LANE_MASK_UNKNOWN)
+				tx_lane_mask = xfer->tx_lane_mask;
+			else if (xfer->tx_lane_mask != tx_lane_mask)
+				tx_lane_mask = SPI_ENGINE_LANE_MASK_CONFLICTING;
 		}
 	}
 
@@ -364,8 +380,13 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 					     &priv->rx_primary_lane_mask,
 					     &priv->tx_primary_lane_mask);
 		spi_engine_all_lanes_flags(msg->spi,
-					   &priv->rx_all_lanes_mask,
-					   &priv->tx_all_lanes_mask);
+					   &priv->rx_lanes_mask,
+					   &priv->tx_lanes_mask);
+		if (rx_lane_mask > 0)
+			priv->rx_lanes_mask &= rx_lane_mask;
+
+		if (tx_lane_mask > 0)
+			priv->tx_lanes_mask &= tx_lane_mask;
 	}
 
 	return 0;
@@ -380,6 +401,9 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	struct spi_transfer *xfer;
 	int clk_div, new_clk_div, inst_ns;
 	int prev_multi_lane_mode = SPI_MULTI_LANE_MODE_SINGLE;
+	int prev_rx_lane_mask = 0;
+	int prev_tx_lane_mask = 0;
+	u8 num_rx_active_lanes;
 	bool keep_cs = false;
 	u8 bits_per_word = 0;
 
@@ -405,6 +429,8 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 		 */
 		bits_per_word = priv->bits_per_word;
 		prev_multi_lane_mode = priv->multi_lane_mode;
+		prev_rx_lane_mask = priv->rx_lanes_mask;
+		prev_tx_lane_mask = priv->tx_lanes_mask;
 	} else {
 		spi_engine_program_add_cmd(p, dry,
 			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
@@ -417,15 +443,27 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
 		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
-			if (xfer->multi_lane_mode != prev_multi_lane_mode) {
+			num_rx_active_lanes = spi->num_rx_lanes;
+
+			if (xfer->multi_lane_mode != prev_multi_lane_mode ||
+			    xfer->rx_lane_mask != prev_rx_lane_mask ||
+			    xfer->tx_lane_mask != prev_tx_lane_mask) {
 				u8 tx_lane_flags, rx_lane_flags;
 
-				if (xfer->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE)
+				if (xfer->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE) {
 					spi_engine_all_lanes_flags(spi, &rx_lane_flags,
 								   &tx_lane_flags);
-				else
+					if (xfer->rx_lane_mask) {
+						rx_lane_flags &= xfer->rx_lane_mask;
+						num_rx_active_lanes = hweight8(rx_lane_flags);
+					}
+
+					if (xfer->tx_lane_mask)
+						tx_lane_flags &= xfer->tx_lane_mask;
+				} else {
 					spi_engine_primary_lane_flag(spi, &rx_lane_flags,
 								     &tx_lane_flags);
+				}
 
 				spi_engine_program_add_cmd(p, dry,
 					SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
@@ -435,6 +473,8 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 							     tx_lane_flags));
 			}
 			prev_multi_lane_mode = xfer->multi_lane_mode;
+			prev_rx_lane_mask = xfer->rx_lane_mask;
+			prev_tx_lane_mask = xfer->tx_lane_mask;
 		}
 
 		new_clk_div = host->max_speed_hz / xfer->effective_speed_hz;
@@ -453,7 +493,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 					bits_per_word));
 		}
 
-		spi_engine_gen_xfer(p, dry, xfer, spi->num_rx_lanes);
+		spi_engine_gen_xfer(p, dry, xfer, num_rx_active_lanes);
 		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
 				     inst_ns, xfer->effective_speed_hz);
 
@@ -1034,10 +1074,10 @@ static int spi_engine_trigger_enable(struct spi_offload *offload)
 
 	if (priv->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE) {
 		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
-						    priv->rx_all_lanes_mask),
+						    priv->rx_lanes_mask),
 			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
-						    priv->tx_all_lanes_mask),
+						    priv->tx_lanes_mask),
 			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 	}
 
-- 
2.34.1

