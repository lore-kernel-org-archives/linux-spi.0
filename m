Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC083371056
	for <linux-spi@vger.kernel.org>; Sat, 26 Sep 2026 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452620; cv=none; b=OiHogv9pNckMUC5SxxUcDK7fEDjygvXWB2KD4hWP3+SkPuWvW8nx1pKrn2GbaAMdQs3a4pUdwrFAJ+b0smt+zTmZUXvpNP47tH/E9QJpFah2u8zT6mTMDUtj+HnnlZXTumVFgkwOfUX3rMM4Xg/QcNONp5jzr1gjaDj3Z8+yMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452620; c=relaxed/simple;
	bh=LYsTZYTFw77y4vhzBNm5ZfPLRJ3QTOdjYnl4iGPDAfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fg2jrlEWSLXS3lqucTv4m6jRzOAWey1MBsd+EkBCrMi4SUlVxiKzn4zhe9QAudbVzLCi+nkGDlt16L6j4DSeX0CXng2A7guVKg7rs3dJTV398D0KFsBJ1NW+ET29xYZokYsyMWoYfpmeBC5gaYHlfsMVLxiXRuO9nvx6QGGzpgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IVTubUNd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TPcbZm3F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IVTubUNd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TPcbZm3F"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QGxtj3500337
	for <linux-spi@vger.kernel.org>; Sat, 26 Sep 2026 19:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hI5C4U1EW+2wjdrpG7VIcsYRtJ0qa1gaLwmcQGCX2QI=; b=IVTubUNdmJqrKIJH
	Ac86WJRsz6Uu5Aozp5R4VwQB3XldecJZYVqX0nDaqJIdPqVWOmRR9zIGnKdcO7K9
	h2+IMEV4uJLvtgSQHs09X1B80lneXccRL3iShrSn9zxTiW13rcS7p17ETbNhEGxg
	feODvC8moIP2JjYSoh0b1VbKybFuQZ250RbQ3QYCqeH07xeT33DBWngikyEXB71b
	dunMAYdK/LQcmEnilfUVa86Q9479j3U0OW51Zq4QDuPVgtwa2/LCNwe9wPb0DHI7
	gokRM4v7S9F/r7FxiILVG3wmOF9c02kQOzAfdyBubtBgofxSpywh+Em4dNEEtdD6
	SijxDA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx64ussf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 26 Sep 2026 19:56:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-313d1015161so6884659eec.1
        for <linux-spi@vger.kernel.org>; Sat, 26 Sep 2026 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790452616; x=1791057416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hI5C4U1EW+2wjdrpG7VIcsYRtJ0qa1gaLwmcQGCX2QI=;
        b=TPcbZm3FK37VuCl7kIk1O3esAnIsKDj9dSlOonKcEajRw+J4/llgkr2sCYh/yBauNV
         EyHJK/UM4d84Mz4zYm9G+uGzozhd4oi2bNuAo6QZNOg+LHMuMwqB6b0nWwBJ9pIoKr5M
         3hHBJIzqok3//QM+p4sYHKhghgKcvxcDL8LEfmRCo/eQq9+EbArGfaIprPb4iEvV3/8C
         pQXo9d3qN8ju9moisgn42b2hQZabpisHrpnwj3JH+ZHWSnnRnM4EGc+1baPThPM3t+FB
         GZW3194v6bSxiBNcP7e80b2fXaAoLA7wkua5euoGHLnIPS3fjf0eOVsh8hTTQaE6yULG
         36Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790452616; x=1791057416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hI5C4U1EW+2wjdrpG7VIcsYRtJ0qa1gaLwmcQGCX2QI=;
        b=piN3tNHIcX20tcWV9c2PQLTaHa8SyxEfYu6xY3SMr/6so9OWGeO9+zCK/kfKza4onU
         01XEpZcQ1/noJWCXpTTdkfMkTbUKIeXryQRIduhAdmNmx3EaCT2cEgR16kGjgo9Gy/0T
         RjCk49mzzCToYC8JNNBqM7+kfyHFnJNl8G/twJI+CLpfLG8o2nEAImgU17NXJ19Hk9ay
         pa3ErWx/PpP2Gq3yVVTfeWiNf+S27oniiqv7m5t6hRRsw8j/Mh86DtBPzJ/Vdh0/13yr
         TQxGnljfAZi8fgzhx0/4ENh2KJKLSFeoqd9xeGqeBXO8a+SPTJdX+n7HCE91IInYjtWI
         n1ZA==
X-Forwarded-Encrypted: i=1; AKwUvBxnpmp1JNbLqpdFgQJ8NTxCHAfhlQIkrd1dgAGtFPwt90uPU8tpBIANAFE1u+4+BiEQsoC/YcqD9/M=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1ZX+KPRv0tsfUmvWhDgHWWxNplKgdWsNop/upTSByFNXWblht
	IAygzgN1HQUwRhvL1r9YAbGsrHqxS85CMWYbZ/ciH8B4d+HfuYskxpnAvO2kNxldRzK0HHHQ4sI
	XECa8xGpQ25Cwk0yYHOEwDk/anMHzgqhMrqnwO3RM3qhYHQnmJ1rtsHmHiWoliOY=
X-Gm-Gg: AYBFou2V6KGDvAbIIArqL4wApJyIpPa3rbzw/a2S1U12h/8En9P0CKITDnkeiwoqWsi
	1z31cDFLpfvz1tfwMoOApCn2J7ZmehhTqsKE0ID0CGHwkJd44I54+jAmBRcRIArC/4BwYX26+TP
	YtPb/SwSW/HrDBtLwQ4h0QNrOLzm4PhvELNOI4WDPXjl5GxkoP4KmjrBXE/6Azou4sRVXv01Sgm
	Zc4hvwcykTHGAFd2W/PHUnTUBhzsYB7BOIMppOIwioQyVECiH3ldJknrJL3xFASRlVgTvXVdUpw
	fPSY0z3kiwZJ/W2uLbgZEbWPBVEdFMH1sMbzOECvlrOdb7jVTwf8P1vLuWhJF0z7HVVcaaH1IK3
	x5LmtWXNwMHqJyt0EEi5XEGS4+OQKpdFL
X-Received: by 2002:a05:7300:de0b:b0:342:cbae:b1f7 with SMTP id 5a478bee46e88-342cbbdff28mr3273234eec.27.1790452616055;
        Sat, 26 Sep 2026 12:56:56 -0700 (PDT)
X-Received: by 2002:a05:7300:de0b:b0:342:cbae:b1f7 with SMTP id 5a478bee46e88-342cbbdff28mr3273214eec.27.1790452615533;
        Sat, 26 Sep 2026 12:56:55 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414407ea69sm17179025eec.7.2026.09.26.12.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:56:55 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 01:26:34 +0530
Subject: [PATCH v5 2/2] spi: qcom-geni: Use GPIO to notify master of SPI
 target activity
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-use_gpio_to_notify_master_of_spi_target_activity-v5-2-9b973623080f@oss.qualcomm.com>
References: <20260927-use_gpio_to_notify_master_of_spi_target_activity-v5-0-9b973623080f@oss.qualcomm.com>
In-Reply-To: <20260927-use_gpio_to_notify_master_of_spi_target_activity-v5-0-9b973623080f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790452601; l=3505;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=LYsTZYTFw77y4vhzBNm5ZfPLRJ3QTOdjYnl4iGPDAfU=;
 b=/Zd1tifboPqeD+SVtk/DxTxt97fWniJHlp5apQ72MRM0D7UCU1gc3YItV5drMn8dXo+BDmkpe
 nFEJyhMZN0QC1Wsf5bzwzUPlBVPEWgOQcOp1cL/piPkC0IuM9uYI/I9
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3OSBTYWx0ZWRfX5rMiF03UW+bf
 n/MIA2HyyyakG9ESmzg3EE7zRrwYs3njYEl1Je3caI1gfQT7EZlyyON5pVr96PxDi2PJ/AfUyQH
 Hfy1hpz8dt46DB8CF8IthDCZtlA/ezo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3OSBTYWx0ZWRfXz2CRv52PLNh5
 XsGU4lw9Up1ajjZE5mbekufo0uAZt62BjXTLv+4yByq8EihvWGKhEmdOHBzn0oKfPWQ9daAajq1
 AyPLwFYAEQ0yWEwen9dY18aVBIanix9xrSmz88rLKROepGGWQn/OdPW9qiKlNt1lOd9ER3A1MVc
 3Huijy6OY0eChdUt/LqT/j204oC6tjQm4sPEdhPJiNrIlDqop5CGJ0LXIz6RErLxew6XsEcEn57
 Gd5bsqUpf3ppd2K3mI8wARD2PH/U0h0CYf0WlYhlMaK9YDYyL9IcpjF5XTb4xOIozfwtl2fpGef
 vxiqwSDd2KEs5oIsucv/yStvtYGAcjg6ztwUTQ1htKERh0N+CIaJpXoplRciZICRtetlpdFWGyV
 gsr0sC8a5cTmCWyd4o8gyHRArZljelWXnGP0oZKXSjlizj7AbqMfNwDK802+qpSwf7LZflVK1s6
 Nlwob4vIDu8SSJwXPww==
X-Proofpoint-ORIG-GUID: DVitKvVNMybLAwqnq-siyXtRvGf-56-W
X-Authority-Analysis: v=2.4 cv=E6xYNqdl c=1 sm=1 tr=0 ts=6ab82389 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=HWq8w0C2B1yOpf0TK-AA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: DVitKvVNMybLAwqnq-siyXtRvGf-56-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260079

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
devm_gpiod_get_optional().

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index bced6279a062..91e75e213f92 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -10,6 +10,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma/qcom-gpi-dma.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -118,6 +119,7 @@ struct spi_geni_master {
 	int cur_xfer_mode;
 	const struct geni_spi_desc *dev_data;
 	struct notifier_block panic_nb;
+	struct gpio_desc *ready_gpio;
 };
 
 static void spi_slv_setup(struct spi_geni_master *mas)
@@ -176,6 +178,9 @@ static void handle_se_timeout(struct spi_controller *spi)
 	xfer = mas->cur_xfer;
 	mas->cur_xfer = NULL;
 
+	if (spi->target)
+		gpiod_set_value(mas->ready_gpio, 0);
+
 	/* The controller doesn't support the Cancel commnand in target mode */
 	if (!spi->target) {
 		reinit_completion(&mas->cancel_done);
@@ -936,8 +941,12 @@ static int spi_geni_transfer_one(struct spi_controller *spi,
 	if (mas->cur_xfer_mode == GENI_SE_FIFO || mas->cur_xfer_mode == GENI_SE_DMA) {
 		ret = setup_se_xfer(xfer, mas, slv->mode, spi);
 		/* SPI framework expects +ve ret code to wait for transfer complete */
-		if (!ret)
+		if (!ret) {
+			if (spi->target)
+				gpiod_set_value(mas->ready_gpio, 1);
 			ret = 1;
+		}
+
 		return ret;
 	}
 	return setup_gsi_xfer(xfer, mas, slv, spi);
@@ -1023,6 +1032,8 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		if (dma_rx_status & RX_RESET_DONE)
 			complete(&mas->rx_reset_done);
 		if (!mas->tx_rem_bytes && !mas->rx_rem_bytes && xfer) {
+			if (spi->target)
+				gpiod_set_value(mas->ready_gpio, 0);
 			spi_finalize_current_transfer(spi);
 			mas->cur_xfer = NULL;
 		}
@@ -1192,8 +1203,14 @@ static int spi_geni_probe(struct platform_device *pdev)
 	init_completion(&mas->rx_reset_done);
 	spin_lock_init(&mas->lock);
 
-	if (spi->target)
+	if (spi->target) {
 		spi->target_abort = spi_geni_target_abort;
+		mas->ready_gpio = devm_gpiod_get_optional(dev, "ready",
+							  GPIOD_OUT_LOW);
+		if (IS_ERR(mas->ready_gpio))
+			return dev_err_probe(dev, PTR_ERR(mas->ready_gpio),
+					      "Failed to request GPIO\n");
+	}
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);

-- 
2.34.1

