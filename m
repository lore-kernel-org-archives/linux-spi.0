Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D13955D6;
	Tue, 14 Jul 2026 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997796; cv=none; b=EVL4d4KNgdo1O3rIyueMTYM/GBGtXvq9iyWFbZGLyXaph4SRxX6RfSFQuM9FOv33rZCFptz/IYv8YWGOAbrry0uBwDTONUaNB40V7EBFDyQgEaGtZUBwq6pViELSXdUD5wk0EaSC/a/813Xx4xz69TWwD67LCUx1+nFORQfcMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997796; c=relaxed/simple;
	bh=XvT/Ormq9AL6I69TlaDdcBMA7j8Hc9q8KW5ef98kAFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBSu99ovTOTkXFvUdaRIs8EkFeoLLQqhT0a+FCqJ8OY1xYdNG2Y/jZy2RYcoPYLfVESYJqUohibp1BWbaI0tQRpKVc/mmgQheG8QOJ56W8foBGDo5vl85k5zTVW6u9wYTiOh38LPYxS4kIJJ+9IiMCQpQxh+SWSvP035twT6+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZDBH0krt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZDBH0krt"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNlPlt777063;
	Mon, 13 Jul 2026 22:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Hr6UU
	d2cB125lR5yP9182i9IDtjKYHd3QaiwU3cZKRE=; b=ZDBH0krtR3If7b7uNAhp8
	DqGSWZgTfzb3fTXa9b7C7l4HgHaZ3ETBEeKny7Mf0QakvhvBcCs3qphwAfI31sVd
	lX4/AABqf7/kFrOzXj5n5KIoZo61YdYh1gdIKcDjKNeJksiQrLw01vDoZoGXTxpp
	JetvFJvdGgIozAzxBrwhlaifbkLVrz2kjYdm83rxnKwWunyjyxtptyQHQx4NegVb
	FGjRD1x7kp87ikZgtrouKzF0gB6EP6eO8Hbd0nndwVDfYnUwknfaH429y+CinI9m
	Qt9BJXO6nVNzpLY3EiPK5TxIrGOoy+5vcJDvI8rNj7ctppr17f5zuCcAMVyKmHHH
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fcx3qk6fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 22:56:30 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66E2uTcn028280
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 22:56:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Jul
 2026 22:56:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 22:56:28 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66E2uFaE021212;
	Mon, 13 Jul 2026 22:56:18 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andy@kernel.org>
Subject: [PATCH 2/6] spi: add per-transfer CS mask
Date: Tue, 14 Jul 2026 02:56:02 -0300
Message-ID: <3b38df61feee9a0c7e08bd03e624be12b5812cda.1783729282.git.Jonathan.Santos@analog.com>
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
X-Authority-Analysis: v=2.4 cv=cqirVV4i c=1 sm=1 tr=0 ts=6a55a55e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=ehdimxznmKi42SKfmAQA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: DhKF2ITkbG16gJV0q0VakjN296-YmyMf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfXzxHqMg09k1/x
 QIj+MGHcOxYU6sDAmhe1It+radOUuJSTkBh5YsgixKANhecogwyuZ3tgBkeLPxMv8x/LHBlNdA8
 TaI9fgj9mlj/cJTrbUm6TCaZ5ifSID7DwbAGskNpTOXX0yhAZPnuD1+DhcGbwS6hTcjjOQ3+0hy
 mS55Nx4c4vk1G6ZkF4JT+ouaMXatvak7NQ+rcIHA8Hi78noUqPqaEkQw7CWL90Wp2xKe0gQb8z/
 NVC0ah3Vv8jQxQknlfEaCewtAwScJyFz+5KZZLsl44G/zC9vfpH8mClcQow0p6tJuvqQVj0qLGw
 OeVtHfBuiRGMiyvElA1yd7SCDxZRfT+0hVSWJYvwbZPOY/+I+PycQu3/PWQuHsyyNLtRKTtZfWN
 OqGs3uRhXazPWz5wcrQOLjZo9WehDZBJ7BQMK98p5zxaTCRxTgMwoG2Pd4NCfzpuhOxxwshM0qf
 UWl2olzZ6mgIgyAoDOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfX5BBq2zi7hkWc
 8lTuPjytdyUtruPoGhZWa2hqY4sjPJEzaASSxaRVRpKwLUmrJJTEihnHxaO6CYNXGJKVQDyLtTm
 n+mcf57OWMSbTMbQsW4t+Q09tWsKz1674rYQZtg8tWoaEEz5D59X
X-Proofpoint-ORIG-GUID: DhKF2ITkbG16gJV0q0VakjN296-YmyMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140028

Multi-CS devices assert all their chip selects simultaneously by default
via cs_index_mask. Some use cases require selecting a subset of those CS
lines per transfer (e.g. routing data to one of several subdevices sharing
the bus).

Add a cs_select_mask field to spi_transfer. When the mask is set and the
controller has SPI_CONTROLLER_MULTI_CS, spi_set_cs() builds a temporary
spi_device whose chip_select[] and cs_gpiod[] arrays contain only the lines
indicated by the mask, then delegates to the renamed _spi_set_cs().
When cs_select_mask is 0 or the controller does not support multi-CS,
the device default (cs_index_mask) is used unchanged.

Update spi_transfer_one_message() to pass the relevant spi_transfer to
every spi_set_cs() call so CS transitions between transfers with
different masks are handled correctly.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/spi/spi.c       | 88 +++++++++++++++++++++++++++++++++++------
 include/linux/spi/spi.h |  4 ++
 2 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 55fb96fea243..6d644adf8445 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1071,7 +1071,7 @@ static void spi_toggle_csgpiod(struct spi_device *spi, u8 idx, bool enable, bool
 		spi_delay_exec(&spi->cs_inactive, NULL);
 }
 
-static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
+static void _spi_set_cs(struct spi_device *spi, bool enable, bool force)
 {
 	bool activate = enable;
 	u8 idx;
@@ -1129,6 +1129,61 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	}
 }
 
+static void spi_set_cs(struct spi_device *spi,
+		       struct spi_transfer *xfer,
+		       bool enable, bool force)
+{
+	struct spi_controller *ctlr = spi->controller;
+	struct spi_device temp_spi;
+	u8 cs_mask, cs_count, idx;
+
+	/*
+	 * If no transfer-specific CS mask, or device does not support multi-CS,
+	 * fall back to device default
+	 */
+	if (!xfer || !(ctlr->flags & SPI_CONTROLLER_MULTI_CS))
+		goto out_default_cs;
+
+	if (!xfer->cs_select_mask)
+		goto out_default_cs;
+
+	/*
+	 * Handle multi-CS controller path.
+	 * For multi-CS controllers, we need to create a temporary spi_device
+	 * structure that reflects the transfer's CS selection
+	 */
+	cs_mask = xfer->cs_select_mask & spi->cs_index_mask;
+	temp_spi = *spi;
+	cs_count = 0;
+
+	temp_spi.cs_index_mask = 0;
+	for (idx = 0; idx < spi->num_chipselect; idx++) {
+		if (cs_mask & BIT(idx)) {
+			temp_spi.chip_select[cs_count] = spi->chip_select[idx];
+			if (spi->cs_gpiod[idx])
+				temp_spi.cs_gpiod[cs_count] = spi->cs_gpiod[idx];
+			temp_spi.cs_index_mask |= BIT(cs_count);
+			cs_count++;
+		}
+	}
+	temp_spi.num_chipselect = cs_count;
+
+	_spi_set_cs(&temp_spi, enable, force);
+
+	/*
+	 * Copy the last CS state from temp device back to original controller
+	 * to keep the tracking.
+	 */
+	ctlr->last_cs_index_mask = temp_spi.controller->last_cs_index_mask;
+	ctlr->last_cs_mode_high = temp_spi.controller->last_cs_mode_high;
+	memcpy(ctlr->last_cs, temp_spi.controller->last_cs, sizeof(ctlr->last_cs));
+
+	return;
+
+out_default_cs:
+	_spi_set_cs(spi, enable, force);
+}
+
 #ifdef CONFIG_HAS_DMA
 static int spi_map_buf_attrs(struct spi_controller *ctlr, struct device *dev,
 			     struct sg_table *sgt, void *buf, size_t len,
@@ -1612,7 +1667,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_statistics __percpu *stats = msg->spi->pcpu_statistics;
 
 	xfer = list_first_entry(&msg->transfers, struct spi_transfer, transfer_list);
-	spi_set_cs(msg->spi, !xfer->cs_off, false);
+	spi_set_cs(msg->spi, xfer, !xfer->cs_off, false);
 
 	SPI_STATISTICS_INCREMENT_FIELD(statm, messages);
 	SPI_STATISTICS_INCREMENT_FIELD(stats, messages);
@@ -1680,28 +1735,39 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 
 		spi_transfer_delay_exec(xfer);
 
+		struct spi_transfer *next_xfer = list_next_entry(xfer, transfer_list);
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list,
 					 &msg->transfers)) {
 				keep_cs = true;
 			} else {
 				if (!xfer->cs_off)
-					spi_set_cs(msg->spi, false, false);
+					spi_set_cs(msg->spi, xfer, false, false);
 				_spi_transfer_cs_change_delay(msg, xfer);
-				if (!list_next_entry(xfer, transfer_list)->cs_off)
-					spi_set_cs(msg->spi, true, false);
+				if (!next_xfer->cs_off)
+					spi_set_cs(msg->spi, next_xfer, true, false);
 			}
 		} else if (!list_is_last(&xfer->transfer_list, &msg->transfers) &&
-			   xfer->cs_off != list_next_entry(xfer, transfer_list)->cs_off) {
-			spi_set_cs(msg->spi, xfer->cs_off, false);
+			   xfer->cs_off != next_xfer->cs_off) {
+			spi_set_cs(msg->spi, next_xfer, xfer->cs_off, false);
+		} else if (!list_is_last(&xfer->transfer_list, &msg->transfers) &&
+			   xfer->cs_select_mask != next_xfer->cs_select_mask) {
+			/* disable the current xfer CS before enabling the next xfer CS */
+			spi_set_cs(msg->spi, xfer, false, false);
+			spi_set_cs(msg->spi, next_xfer, true, false);
 		}
 
 		msg->actual_length += xfer->len;
 	}
 
 out:
-	if (ret != 0 || !keep_cs)
-		spi_set_cs(msg->spi, false, false);
+	if (ret != 0 || !keep_cs) {
+		/* Use the last transfer's CS configuration for proper cleanup */
+		struct spi_transfer *last_xfer = list_last_entry(&msg->transfers,
+								 struct spi_transfer,
+								 transfer_list);
+		spi_set_cs(msg->spi, last_xfer, false, false);
+	}
 
 	if (msg->status == -EINPROGRESS)
 		msg->status = ret;
@@ -4138,10 +4204,10 @@ static int __spi_setup(struct spi_device *spi, bool initial_setup)
 		 */
 		status = 0;
 
-		spi_set_cs(spi, false, true);
+		spi_set_cs(spi, NULL, false, true);
 		pm_runtime_put_autosuspend(spi->controller->dev.parent);
 	} else {
-		spi_set_cs(spi, false, true);
+		spi_set_cs(spi, NULL, false, true);
 	}
 
 	mutex_unlock(&spi->controller->io_mutex);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4c285d3ede1d..a9988db3fe2f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -993,6 +993,9 @@ struct spi_res {
  *      for this transfer. If 0 the default (from @spi_device) is used.
  * @dummy_data: indicates transfer is dummy bytes transfer.
  * @cs_off: performs the transfer with chipselect off.
+ * @cs_select_mask: bitmask of chipselects from the @spi_device chipselect
+ *      array to assert for this transfer, overriding @spi_device.cs_index_mask.
+ *      If 0 the device default (@spi_device.cs_index_mask) is used.
  * @cs_change: affects chipselect after this transfer completes
  * @cs_change_delay: delay between cs deassert and assert when
  *      @cs_change is set and @spi_transfer is not the last in @spi_message
@@ -1120,6 +1123,7 @@ struct spi_transfer {
 	unsigned	dummy_data:1;
 	unsigned	cs_off:1;
 	unsigned	cs_change:1;
+	unsigned	cs_select_mask:8;
 	unsigned	tx_nbits:4;
 	unsigned	rx_nbits:4;
 
-- 
2.34.1

