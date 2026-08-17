Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048944BCB5
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983440; cv=none; b=i4hiabrpG4NTFOMNtcKGoZeAtKXvuGcdD1xoYJA8AFDFQJGHFuZA9FaQVhvOt7WpFLDejPEXKdqNt+aT/t1Ze2rVChOAwqMpE60fMqEHC0JC8IoZerql/nPtR24dEsN+J5y1EUDVPkW0YhdRi54qp8EKBw3IUpUACsK7AxiK8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983440; c=relaxed/simple;
	bh=q6ZulUkewvTtweiAHcMjYBKr7bdgqkM5bp4/CsEC1bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxbabDSqCVBIamHrIaXFO7oXTgSzLayivcqJs4CXKfdrp+Yu1gWr88kt9adfPEnx68QTORjNv+pjTSdmCjkc/LGCrXvEMyFmh2BVUj/Zb9TavHdfnzdqgbmFNY56ZuHvc7EpmCyMDTxu+GSQPupbjf51nwJjHWLjxlblJ73dgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gdPynoD5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BsdRUdlM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gdPynoD5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BsdRUdlM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYfg42263413
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 16:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KIalLVWFAC34M1QLdTBho6qDE8wma2UgEvTyc9q/JKY=; b=gdPynoD5V9dpNaz8
	ILwPFd5f1Ram6AmoteHzh8gFUCsK1QOnykji8KZXE098vd12IqHQENA+1BtZ04QB
	6p+CB+38rGCBoF4vWOakAPSuqPmk9iAjyJwjSuKE5n28D/rlft0MHDV/wAX0SbjK
	JmnUiKG4T8n3zGTgg65CAyMYjo8SI/i8Ub7IHFilri0fCuoBnLrL/LIlqMcdEUhF
	c+eO+kQB2VpWh5A6OltUbfImBVOYvBsFWXOAxu6JMVWsnZujKzlI63lY9hzueuUe
	9wWD/FddODVY0mt8DNPXMqJdlpLP3JuNYUE9TgrfXxwrFdCF4iGWKbvJgQrXQAXc
	bnbEMQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xx7huau-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 16:17:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb835525b10so4445205a12.2
        for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786983434; x=1787588234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIalLVWFAC34M1QLdTBho6qDE8wma2UgEvTyc9q/JKY=;
        b=BsdRUdlMOM858xUfDs00smLOCGKOmtcL8XyVyfiABVmDWunp2ubK7GeeHbpMy5knMo
         OOlULs1NItsFNbL7x2GZP8vF+pmwlC+8MvTTinHwYrJ5xIQQS0x3MZ0E8R0KxUOhs0rh
         p3EZmve+OoScJFCah5MbQw2BQMA+214gIyzHvMCGdkb5A2IGVZUkBYvxEX0wc8VMLJKn
         9upMlZBsy79J7Uw6oYpCE7Xo8KlbrFsAhYHTG8CskfIpi0EFjMElVF9VdEm6ibPsj4PM
         4rq0JRjdCgPN+I9XHGVW8Gu2LXvy1rCD7d2J6Ij9nCVylbKW5s2AW1LsSdjaCxcvxV+G
         SmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786983434; x=1787588234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KIalLVWFAC34M1QLdTBho6qDE8wma2UgEvTyc9q/JKY=;
        b=iBZscYMUYNZQRSKkjkEW6oEHfYM99kkTaLfgJJOlNqPt9JyeZz53tj6uV77iX5WiG3
         7AGf/L9BWLzrJWO1JhhNPMrGtoPLGCBVGdjXgqmMbFyMVAhr6MtsDtNi2pqGn5gyKRVR
         lhxR4OkzFy7fMLBxlcTgsDRGnGrh8I+0GvnM638NyWkssFs4wU4+CLpMmLEc/Jx2yr93
         ynMYRuMorImSHUJiLlFx429hkuiFj7iOq7NiJxF59kN6+mH2TNb6kNvTr8rOgXdWnc+W
         JIK1rbhoQvisQSjmQ6x/iX2HTy5mir5uEt1jSBSgux8xN+WMbIYjmAXelnuF8qMPILEf
         xwIg==
X-Forwarded-Encrypted: i=1; AHgh+RoCSGP5jYwq/fHqgNTn9fyBt8RICd+1HXyXCqgqJ9umg8GucO5feHJfO2AmJH5meKC38LpfSLocoVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDVqubgOSLljGLLGzqXPG+A4TeXeBnwsAi5pPQLXr4VUU/MHbF
	nuF4Frpn0npAXDipIlPC3DbvPBnydlecGlENXKFsA6zyogF+l92KhEG/Z1V+tLY0zmWGTK4Czex
	JkGayoLWmhoH+29iJRN5vlgK/q5gKxAk48G2zW4s0v2/bgRhm3jjZuuG3IC7/F1Y=
X-Gm-Gg: AR+sD13W/Sp9n1VgfRSk6FInX+1k72AjnKlRF5v6Ulmzi3VqK4Zju/qdwVbLA8lOITg
	lc1vUV7tZVDpPFpHEbtkOoJwQXeidqQKiEX9Eub0AEGUJpKiqA9lrR0pYpacBrlX2twvRURba2n
	Gc8rhgc+miBl15IkyStZ3As7HGeKQu2cgzkVvD3imrbIdJm1H7L+chojsJgrJJPMKsd10XXe05c
	GSiYZF6C4gViMoSFf3GMz3U+E6pMLSE0WvjugIvaoivDkelowds76cW3wfmbNB+41cMgXAslOFz
	ITd1aAfvYXSmImCvup/x9gQ1eP0lTuquPWevp9qtpw1g690DBzTanhsP+LceRJx5ng/2Gen9YpE
	vAr5FWy6qrnoFVD0r8kCc/nR0189ICRjUDA==
X-Received: by 2002:a05:6a00:2308:b0:84a:60a4:2651 with SMTP id d2e1a72fcca58-84fddfa84f0mr24531218b3a.6.1786983434282;
        Mon, 17 Aug 2026 09:17:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:2308:b0:84a:60a4:2651 with SMTP id d2e1a72fcca58-84fddfa84f0mr24531167b3a.6.1786983433738;
        Mon, 17 Aug 2026 09:17:13 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fc0fd9sm563035b3a.45.2026.08.17.09.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:17:13 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 21:46:53 +0530
Subject: [PATCH v2 2/2] spi: qcom-geni: Use GPIO to notify master of SPI
 target activity
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-use_gpio_to_notify_master_of_spi_target_activity-v2-2-94d1eff3175f@oss.qualcomm.com>
References: <20260817-use_gpio_to_notify_master_of_spi_target_activity-v2-0-94d1eff3175f@oss.qualcomm.com>
In-Reply-To: <20260817-use_gpio_to_notify_master_of_spi_target_activity-v2-0-94d1eff3175f@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786983418; l=3922;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=q6ZulUkewvTtweiAHcMjYBKr7bdgqkM5bp4/CsEC1bs=;
 b=eF12KjYjAf7knaJPobteGNtq2TN+VdAiVkpmrhYSEJ4rhxzhmLy6OVkTuQB/J7QwIhRfxftQI
 boctXHS872jAGMyppYkYthvIsAydoPxlsx8zv41N2fcS16DVcPAMozP
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyNSBTYWx0ZWRfX3ci1nKESnJS9
 dsxa8p7EQvvo/b7ixZecgvFkF/QKxl2SImPz/fPI/w+NSc7QVEqzmL/A/Kibzv4ZzkcAocHrIEl
 2zataXJftwVFkeWo01mT17oNkEu3uSE=
X-Authority-Analysis: v=2.4 cv=TK91jVla c=1 sm=1 tr=0 ts=6a83340b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Fo9EMwYq_bmgDG0ZVhAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: J0D5eDwRn0OWTD3GwfDhLVo8fKmKtWLY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyNSBTYWx0ZWRfX5+IJqZmIgAuC
 g698alWSrz+F1GGsyw/VVRZj/jSkjePYZ78M6yM9rTNXl2qCsDobU1sX39DPvjniSqMdAvW1kdf
 bRmrXjQxsK7oBcZ1pK+Uq7vGXBaLk8wLGORN9SokG7Hgw/L2fpZbFN1OaLQmvFEYkP14m1vPsal
 /XBxbZgPXm8rmDNvvre1fU68VzAeNaFJWNCL9+c41tmv77stWKsDGHPaQ69C6MsL8OZqfgdHDBy
 ZFFV5zNOke/jEkQjvTOv78FjaCc14dnZh8dKtj9Tw0D31YvJOCx+V6rAHBJLC38Anmmo0E/38r9
 U/cAia7oHBcqlZlJXuYIiaarHgezk7+hjkQtuWmD45XQ/KAMGUl/FkEd96muDwiMMm9zXywYtKk
 i4iuGhY3zRczynkeoyGFqGZMmWBjQVbdZ3cjYk1DxciQHvwv8jQ2xDIyoohrt4ZkFCCOTdLiPpz
 TJXXwtaoxZWVyxAGS0Q==
X-Proofpoint-ORIG-GUID: J0D5eDwRn0OWTD3GwfDhLVo8fKmKtWLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170125

When operating in SPI target mode, the GENI controller relies on an
external GPIO to notify the SPI master about the target's active state.

Add support for an optional ready GPIO that is asserted when a target
transfer begins and deasserted when the transfer completes, is aborted,
or hits a timeout. This allows the target to explicitly signal its
availability to the master and ensures the GPIO is released in all error
and completion paths, preventing the master from observing a stale or
incorrect target-ready indication.

The ready GPIO is intentionally made optional and is requested only
when target mode is enabled. This preserves existing behaviour for
systems that do not require the signal and avoids regressions on
deployed platforms where the GPIO is already controlled from userspace.
Targets without a ready GPIO continue to operate unchanged by using
devm_gpiod_get_index_optional().

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index d262206ed663..5ebbeac70382 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -8,6 +8,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma/qcom-gpi-dma.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/log2.h>
@@ -113,6 +114,7 @@ struct spi_geni_master {
 	struct dma_chan *rx;
 	int cur_xfer_mode;
 	const struct geni_spi_desc *dev_data;
+	struct gpio_desc *target_gpio;
 };
 
 static void spi_slv_setup(struct spi_geni_master *mas)
@@ -171,6 +173,9 @@ static void handle_se_timeout(struct spi_controller *spi)
 	xfer = mas->cur_xfer;
 	mas->cur_xfer = NULL;
 
+	if (spi->target && mas->target_gpio)
+		gpiod_set_value(mas->target_gpio, 0);
+
 	/* The controller doesn't support the Cancel commnand in target mode */
 	if (!spi->target) {
 		reinit_completion(&mas->cancel_done);
@@ -928,8 +933,12 @@ static int spi_geni_transfer_one(struct spi_controller *spi,
 	if (mas->cur_xfer_mode == GENI_SE_FIFO || mas->cur_xfer_mode == GENI_SE_DMA) {
 		ret = setup_se_xfer(xfer, mas, slv->mode, spi);
 		/* SPI framework expects +ve ret code to wait for transfer complete */
-		if (!ret)
+		if (!ret) {
+			if (spi->target && mas->target_gpio)
+				gpiod_set_value(mas->target_gpio, 1);
 			ret = 1;
+		}
+
 		return ret;
 	}
 	return setup_gsi_xfer(xfer, mas, slv, spi);
@@ -969,6 +978,8 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 			if (mas->cur_xfer) {
 				spi_finalize_current_transfer(spi);
 				mas->cur_xfer = NULL;
+				if (spi->target && mas->target_gpio)
+					gpiod_set_value(mas->target_gpio, 0);
 				/*
 				 * If this happens, then a CMD_DONE came before all the
 				 * Tx buffer bytes were sent out. This is unusual, log
@@ -1012,6 +1023,8 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		if (!mas->tx_rem_bytes && !mas->rx_rem_bytes && xfer) {
 			spi_finalize_current_transfer(spi);
 			mas->cur_xfer = NULL;
+			if (spi->target && mas->target_gpio)
+				gpiod_set_value(mas->target_gpio, 0);
 		}
 	}
 
@@ -1116,8 +1129,16 @@ static int spi_geni_probe(struct platform_device *pdev)
 	init_completion(&mas->rx_reset_done);
 	spin_lock_init(&mas->lock);
 
-	if (spi->target)
+	if (spi->target) {
 		spi->target_abort = spi_geni_target_abort;
+		mas->target_gpio = devm_gpiod_get_index_optional(dev, "ready", 0,
+								 GPIOD_OUT_LOW);
+		if (IS_ERR(mas->target_gpio)) {
+			dev_err(dev, "Failed to request GPIO: %ld\n",
+				PTR_ERR(mas->target_gpio));
+			mas->target_gpio = NULL;
+		}
+	}
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);

-- 
2.34.1

