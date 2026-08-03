Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A77B23395F;
	Mon,  3 Aug 2026 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726158; cv=none; b=gW+4QMgNQh4RandvVOXhAebv90TMQMoyju+8ntISuHGe/GGUZRkuMnfNIaVMUkIE9R2oOwfFQZFF0CzwvbE6hwlbs/Eh3qF4rI9qPBy6Apz3qAloFKjVMnqPPRYdZGrdiOPBI5OQNwRAjzQeHApoHiSvJGaKbNbw8lpymHmgh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726158; c=relaxed/simple;
	bh=89VaO+GuejkXaL0nK7MMQZwZAfJXlOlOReouxxIDrAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abs9qZju6/YaLdGAKOMr7Zk1b41iAGVhwiU8rassNsD44HwVC260CmTISHS9RIq6tfpXrDIQeVc+/cF8Qjyb4gkFZhsvIgzdCmlSl83iXZioeNrhJHJeRhqsOrbR9NXkVA0E9O8x0je0pW4+8or7koNaPrYD8yFQDhJnLbwGkUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nf4FkVi9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nf4FkVi9"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LV3sK1127294;
	Sun, 2 Aug 2026 23:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JfL8N
	KpiQeVTrnHbTQfWyFuhppVsVgQFcQ8e1yEck/M=; b=nf4FkVi9VHpo2pRr5oIoV
	KbSUoTJsXWcmuD6LJrFTeFQxOhtHCa9kPs8we5nRryCE8+D/dQoUtopznkaspgEA
	6uwjvnlkXGBp1YryiQZ/nq4k1aurWeNfrZWMDucdgsELBltMi/prrGk+qgjvYOvY
	YIEtOV+fhoxM7SYmX5DpKqF69hjXSxsofDcYF1NynRGTvajVG+wANhp/aMdgEe91
	RyPJDLh7rPOZblrk4DurASHgm0yJMb0XGBTgGl9zlCnm789ho47gkhe2Tqw4DmuZ
	ZtaVruKoidN/UxS0h4hLRRx3M6eXUXsvZfSUPLd18UX2IpwSCZyf65m71r5l4bNp
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fsy4bt7n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 23:02:33 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67332Wl2035380
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Aug 2026 23:02:32 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sun, 2 Aug 2026 23:02:32 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sun, 2 Aug 2026 23:02:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sun, 2 Aug 2026 23:02:32 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67332LXu011642;
	Sun, 2 Aug 2026 23:02:23 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 3/5] spi: introduce SPI ancillary device with lanes
Date: Mon, 3 Aug 2026 00:02:15 -0300
Message-ID: <55c674601bfb3ba5495bc364cf2f7b86d0e4e65c.1785725359.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyMyBTYWx0ZWRfXy9mHYDQiqgfM
 fqXEsWyVhR4gEV8koKzelCpFb7VzSAfoz6CCmzRyex6AREAr5+dyynQ2Bq/VAYKvMabxv5zwv9w
 gmHNb7nmxKGo33VotXldHmTizc2DL3tnL52JAg0P5FqOv9qBhHM1gFgPH1ho0VBSJu2hSKmnBVF
 XPtG16iS5L+/b0zG7iRWM6chhbqci4Klvkh/o5YSHH9lHA4pcE47QnHztTWyV6ATnSEArUm7RD1
 dk/MUic5H8EnsPPCQFThs020H/Ki/1xvyLxELkJlZA10XbyzgapvdDgqxAn0cleEgEnse5WVuxu
 cZ8/f+dHHs3TsUCOUIpegz2n/vkGHm5ERwJ+3hQjXWF+dVW9kTM3NEc+AvYUQM0tSOCNGO33jtq
 cvbcqc3QlR7SR5/8VBoGvxe1ilzmkQRyn1s4JVVSdQx4gZkG4MNti5g1jkUKsoKxcieknqW0kTf
 /RM6+UyOX7KQ6vXIuVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyMyBTYWx0ZWRfXxC9Vdw1e76kU
 YYLMKKjP66MsWcQ2dFbvW/4DmJdy/rPw4yWXiJ4lQ4NmyekqNmDy3lFTtNMTGQk+k/IdNGZD+gB
 UOXoaFQQGf2l0INqni6Xv9sZvLrhryo39XaQaqX5ehpe94fqcGyS
X-Proofpoint-ORIG-GUID: lBDuig05vRkyzd0xE1xCdqmmM_uIqlMD
X-Proofpoint-GUID: lBDuig05vRkyzd0xE1xCdqmmM_uIqlMD
X-Authority-Analysis: v=2.4 cv=QKRYgALL c=1 sm=1 tr=0 ts=6a7004c9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=85GZpr9K2BDV8NdfQd4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030023

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
Changes in v2:
* New patch.
---
 drivers/spi/spi.c       | 102 ++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |   8 ++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 61423aee1525..d41c9392c04e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2749,6 +2749,72 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 }
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
+	struct spi_controller *ctlr = spi->controller;
+	struct spi_device *ancillary;
+	int rc;
+
+	ancillary = spi_alloc_device(ctlr);
+	if (!ancillary) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
+	strscpy(ancillary->modalias, "dummy", sizeof(ancillary->modalias));
+
+	spi_set_chipselect(ancillary, 0, chip_select);
+
+	ancillary->max_speed_hz = spi->max_speed_hz;
+	ancillary->mode = spi->mode;
+	ancillary->cs_index_mask = BIT(0);
+
+	if (rx_lane_idx >= spi->num_rx_lanes || tx_lane_idx >= spi->num_tx_lanes) {
+		rc = -EINVAL;
+		goto err_out;
+	}
+
+	ancillary->rx_lane_map[0] = spi->rx_lane_map[rx_lane_idx];
+	ancillary->num_rx_lanes = 1;
+	ancillary->tx_lane_map[0] = spi->tx_lane_map[tx_lane_idx];
+	ancillary->num_tx_lanes = 1;
+
+	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
+
+	/* Register the new device, passing the parent to skip CS conflict check */
+	rc = __spi_add_device(ancillary, spi);
+	if (rc) {
+		dev_err(&spi->dev, "failed to register ancillary device\n");
+		goto err_out;
+	}
+
+	return ancillary;
+
+err_out:
+	spi_dev_put(ancillary);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_GPL(spi_new_ancillary_device_with_lane);
+
 static void devm_spi_unregister_device(void *spi)
 {
 	spi_unregister_device(spi);
@@ -2789,6 +2855,42 @@ struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi,
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

