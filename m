Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C083F12CC;
	Mon, 17 Aug 2026 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009622; cv=none; b=DYiRpa3fmBdyyTBudz3fVEGj3mw8GvNzWQX5jTU686rFHF8VVDQPUSf5QWnekoZvb7qAD99tr9x5DzZSS/KO8g6O3dXl9XkixrIaxZYum8BTUJ5xCMCrUzjcPp6vHWqZnXZDxejaKrx93iSH5UlcmOBZlp+zRdwKScR3gKm7F2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009622; c=relaxed/simple;
	bh=GoGSFjbjDl11T7v+3dIpfc5nlPgP98P89ahDEklsono=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+kQLVXQT3xTwOcWzyku4xVYhV+/fjlpZu0EXeGUGKM0bEED/48qN3mV40OZfTiNTck3V8eb3iiyBh1YQb5NucUn1bJEtnumGnTw8OgGAOUdw398SnvaYdo693AQowx5iRlUF5eOUjSAV1PdwG6AYk757q086sO+MdVDc2iqzGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1mbrO014; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1mbrO014"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLqtH11731335;
	Mon, 17 Aug 2026 19:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LmN41
	TNBOpREwyJRrDFEhtNxXS8jrzW7HYcylr8KjH8=; b=1mbrO014kx/pTiiT3aW3Q
	grA4v4VGXdCJt3BWdrdDCPQWuo1q+ACrIG0S3rTJbx3cteUmAABc6DnY+fX7LGz3
	B5To/8mVMdnPhtBfbyKVYetXffWRswjhHFePZqpEpSCBYdYmGmwbhknq9ZGHYrMc
	peDqZlZCQLODhU21C/jLgfPveAaiA4xX5jH5jKyw0b7r4XctIgzQvqlN4R4UH+AH
	uYJv+apsUKRaenqp96fT5s8xN9LGjNWlot3APEBPAFxaO5BIT49Ve5hqtUchNabM
	7uTA/DmHZNddnPuL7nq5GerHXApFCUATr8AAjBh2de2ISa/OS+5gaFvFtI10bzDJ
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g2hy02wr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 19:33:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67HNXaLC025301
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 19:33:36 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 19:33:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 19:33:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 17 Aug 2026 19:33:36 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67HNXNMM020606;
	Mon, 17 Aug 2026 19:33:25 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andriy.shevchenko@intel.com>
Subject: [PATCH v3 4/6] spi: introduce SPI ancillary device with lanes
Date: Mon, 17 Aug 2026 20:33:12 -0300
Message-ID: <d593c34ec559a674bdee30e2f11489259af295b7.1786973376.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: xeaDnTlNOgRIXGotzK78iQI6hSjCedem
X-Proofpoint-GUID: xeaDnTlNOgRIXGotzK78iQI6hSjCedem
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE4MCBTYWx0ZWRfXy83Yv1n4bM9X
 dP7UeHYUEBt+Fe4oLepvAK8z8mdUI0dj7nLfz4NrEGMUDyA5M2rKTEl60cDtoH6Ha1O1M+GQnfo
 BzgwtWoFEOCI9AZAtAHJ7HM2eIO1ytFCVaB6t+hrXS1V3RGDDN9taHXosZOE4HIXDYBU/rYjcqp
 Qe3282PQv76rrCx60qX7RsOGSTG1QVFfY3+Yhct43NXTObNkcjNauXlLOi6L3sjMIxVrTuqrU6n
 rp3/+JB+SsIRa13KjWZWR+bl0Jo6JhsvAtD848uGg1aEE3K6z/rrWrBxrhEBY4uwCoDTr9ba32p
 7hIgWaN/LS3MoXbewfXx7KVkWRWAC7GsKCNd651hkj9IAPYJaaNcZxch3UuErsfCbaR07KoMEaX
 COl/BnXhopHvCS9bxA8lAlLepDknwxZ8AWaJV2LGuuNLjmWGWiRrpXii4dwjKNSFunh2zr6zU0m
 a00fbV0ECbMze6LXY5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE4MCBTYWx0ZWRfX0w07tDnSC05A
 NF3ya9Q9em47X5iD69y/purQDSfiAljXA2Zl3Z8qe75sYk1fgf2sxTDG1GjOh79+6yQOKw4yubz
 DpZ53sEXzvz+EoI/RlCFtK67jP9MkF1SqVtmHFEcpJvWILeD/NG4
X-Authority-Analysis: v=2.4 cv=KYTidwYD c=1 sm=1 tr=0 ts=6a839a51 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=MtwxMzEE2bzGYhNubMUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170180

The existing spi_new_ancillary_device() creates an ancillary SPI device
but does not consider the parent's lane map. In multi-device setups where
each sub-device's chip-select is bound to a dedicated data lane, there is
no way to bind an ancillary device to an arbitrary lane index.

Introduce spi_new_ancillary_device_with_lane() and
devm_spi_new_ancillary_device_with_lane(), which accept rx_lane_idx and
tx_lane_idx parameters to select a specific lane from the parent's
rx_lane_map and tx_lane_map respectively. The resulting ancillary device
is registered with a single RX and TX lane, keeping it independent from
the other sub-devices sharing the same controller.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v3:
* Refactored code using helper function to reduce duplicated code.

Changes in v2:
* New patch.
---
 drivers/spi/spi.c       | 116 +++++++++++++++++++++++++++++++++++-----
 include/linux/spi/spi.h |   8 +++
 2 files changed, 110 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9ccfa5be557b..174507696f1f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2692,20 +2692,12 @@ static void of_register_spi_devices(struct spi_controller *ctlr)
 static void of_register_spi_devices(struct spi_controller *ctlr) { }
 #endif
 
-/**
- * spi_new_ancillary_device() - Register ancillary SPI device
- * @spi:         Pointer to the main SPI device registering the ancillary device
- * @chip_select: Chip Select of the ancillary device
- *
- * Register an ancillary SPI device; for example some chips have a chip-select
- * for normal device usage and another one for setup/firmware upload.
- *
- * This may only be called from main SPI device's probe routine.
- *
- * Return: 0 on success; negative errno on failure
- */
-struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
-					     u8 chip_select)
+#define SPI_UNDEFINED_LANE	-1
+
+static struct spi_device *__spi_new_ancillary_device(struct spi_device *spi,
+						     u8 chip_select,
+						     int rx_lane_idx,
+						     int tx_lane_idx)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct spi_device *ancillary;
@@ -2732,6 +2724,21 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 	 */
 	ancillary->cs_index_mask = BIT(0);
 
+	if (rx_lane_idx >= spi->num_rx_lanes || tx_lane_idx >= spi->num_tx_lanes) {
+		rc = -EINVAL;
+		goto err_out;
+	}
+
+	if (rx_lane_idx != SPI_UNDEFINED_LANE) {
+		ancillary->rx_lane_map[0] = spi->rx_lane_map[rx_lane_idx];
+		ancillary->num_rx_lanes = 1;
+	}
+
+	if (tx_lane_idx != SPI_UNDEFINED_LANE) {
+		ancillary->tx_lane_map[0] = spi->tx_lane_map[tx_lane_idx];
+		ancillary->num_tx_lanes = 1;
+	}
+
 	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
 
 	/* Register the new device, passing the parent to skip CS conflict check */
@@ -2747,8 +2754,53 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 	spi_dev_put(ancillary);
 	return ERR_PTR(rc);
 }
+
+/**
+ * spi_new_ancillary_device() - Register ancillary SPI device
+ * @spi:         Pointer to the main SPI device registering the ancillary device
+ * @chip_select: Chip Select of the ancillary device
+ *
+ * Register an ancillary SPI device; for example some chips have a chip-select
+ * for normal device usage and another one for setup/firmware upload.
+ *
+ * This may only be called from main SPI device's probe routine.
+ *
+ * Return: 0 on success; negative errno on failure
+ */
+struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
+					    u8 chip_select)
+{
+	return __spi_new_ancillary_device(spi, chip_select,
+					  SPI_UNDEFINED_LANE,
+					  SPI_UNDEFINED_LANE);
+}
 EXPORT_SYMBOL_GPL(spi_new_ancillary_device);
 
+/**
+ * spi_new_ancillary_device_with_lane() - Register ancillary SPI device bound to specific lane
+ * @spi:          Pointer to the main SPI device registering the ancillary device
+ * @chip_select:  Chip Select of the ancillary device
+ * @rx_lane_idx:  Lane index within the parent's rx_lane_map
+ * @tx_lane_idx:  Lane index within the parent's tx_lane_map
+ *
+ * Like spi_new_ancillary_device(), but additionally binds the ancillary device
+ * to a single lane from the parent's lane map. Use this in multi-device setups
+ * where each sub-device is physically wired to a dedicated CS and a dedicated
+ * data lane.
+ *
+ * This may only be called from main SPI device's probe routine.
+ *
+ * Return: Pointer to new ancillary device on success; ERR_PTR on failure
+ */
+struct spi_device *spi_new_ancillary_device_with_lane(struct spi_device *spi,
+						      u8 chip_select,
+						      unsigned int rx_lane_idx,
+						      unsigned int tx_lane_idx)
+{
+	return __spi_new_ancillary_device(spi, chip_select, rx_lane_idx, tx_lane_idx);
+}
+EXPORT_SYMBOL_GPL(spi_new_ancillary_device_with_lane);
+
 static void devm_spi_unregister_device(void *spi)
 {
 	spi_unregister_device(spi);
@@ -2789,6 +2841,42 @@ struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(devm_spi_new_ancillary_device);
 
+/**
+ * devm_spi_new_ancillary_device_with_lane() - Register managed ancillary SPI device bound to a lane
+ * @spi:         Pointer to the main SPI device registering the ancillary device
+ * @chip_select: Chip Select of the ancillary device
+ * @rx_lane_idx: Per-device lane index within the parent's rx_lane_map
+ * @tx_lane_idx: Per-device lane index within the parent's tx_lane_map
+ *
+ * Managed version of spi_new_ancillary_device_with_lane(). The ancillary device
+ * will be unregistered automatically when the parent SPI device is unregistered.
+ *
+ * This may only be called from main SPI device's probe routine.
+ *
+ * Return: Pointer to new ancillary device on success; ERR_PTR on failure
+ */
+struct spi_device *devm_spi_new_ancillary_device_with_lane(struct spi_device *spi,
+							   u8 chip_select,
+							   unsigned int rx_lane_idx,
+							   unsigned int tx_lane_idx)
+{
+	struct spi_device *ancillary;
+	int ret;
+
+	ancillary = spi_new_ancillary_device_with_lane(spi, chip_select,
+						       rx_lane_idx, tx_lane_idx);
+	if (IS_ERR(ancillary))
+		return ancillary;
+
+	ret = devm_add_action_or_reset(&spi->dev, devm_spi_unregister_device,
+				       ancillary);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return ancillary;
+}
+EXPORT_SYMBOL_GPL(devm_spi_new_ancillary_device_with_lane);
+
 #ifdef CONFIG_ACPI
 struct acpi_spi_lookup {
 	struct spi_controller 	*ctlr;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4c285d3ede1d..91c9e2d2e7e3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -385,6 +385,14 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 
 extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 chip_select);
 extern struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi, u8 chip_select);
+extern struct spi_device *spi_new_ancillary_device_with_lane(struct spi_device *spi,
+							     u8 chip_select,
+							     unsigned int rx_lane_idx,
+							     unsigned int tx_lane_idx);
+extern struct spi_device *devm_spi_new_ancillary_device_with_lane(struct spi_device *spi,
+								  u8 chip_select,
+								  unsigned int rx_lane_idx,
+								  unsigned int tx_lane_idx);
 
 /* Use a define to avoid include chaining to get THIS_MODULE */
 #define spi_register_driver(driver) \
-- 
2.34.1

