Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F24399F1
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060343; cv=none; b=JOUllSt7oCA2Gmjd0ehhiNjAYmXzrbP9TwqzEncm9pV/sc6NxpYgjQ8TmGu8s8y0XUKvd7r0FBkGxnVqdXYD+aN7lbN0uZvVw8xMLWs/vbl+NCbKJvnzoa87dDvHY6TY3XSwuQmoHRTuqXKTfDLWnX7BRvkEDMnx1oosgE4zffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060343; c=relaxed/simple;
	bh=BG2HAs+2vxpsLD28GCWp9ALRBE+J16kkoe8+bOtWqJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=avaq9Qo1Lmj+3gD/RwGMT9sTa+SJjRN8v0Dir14r5wxBInvfFOMlXvST551nBc/8i6008RZZQg69h6xC/EWhaHzBzATsOXJdGcZYzEdvz/VZHaWEZ/esoDWr5nm2SS7Fs6LYapWdMb62iX/hD0pGyMJH0Zp5nh5yY0HmFgQqyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DLFEbHl/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L4j77krp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DLFEbHl/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L4j77krp"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDQmWu1767797
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oqQF95WlbW/wBv08Y8MEkU2oObqRblIP8p9ow3LJ+JU=; b=DLFEbHl/Dhrnjuf3
	LLCt40JxjAznO62eVT61mvnV8SueW5dlCSmIDKcBmxZfTViPT+xWiInSbQ6ab76e
	ULti1SXY3Y/l5dzY8YCn0ZaahWdJb/lhJ1SbwOxyj0Ter6Eet6hoyf+bar4uLmJ8
	sbvnAzASuYVXCw05fZUnBEw23T33WBQ7j/lMYIfzVjiHVjE3Awm2kZhXkbIk745D
	NKEAh7E8VNP+rtbNJqcPCDBMWafQ+QbMEXHZUpg5eih0p+lQjYu1pXCFHC9mYThs
	HhGd7D5mI/9cHXwk9+OK/bbEF0i5M+Yyw6UWC+d0oaBgZrocmHKLs/VFptZ1dC94
	cyVnCQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fvp29m4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:38:55 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b28d9952a5so2010994b6e.1
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787060314; x=1787665114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oqQF95WlbW/wBv08Y8MEkU2oObqRblIP8p9ow3LJ+JU=;
        b=L4j77krpYcWQEgXcWTh+b9XweVeBsSzB7PRK6rgCDwzd8cIO1X2J77wM/2t3w/TvD3
         2DSbYrsanB8ec+14+ozxNL1DtscyGt49kb0rJ4kLBqh4scMsKs0mWmCWpWe2xEDoclUS
         bH6T5bnIhuyud4GOputgU868s6sbItTivCiOYuaF3UJhtZUSih4nX9yParw6Q4s8pD9q
         VOk4n136s8j72Y77PeD85a3en6yM5HECXT6SplgFMtPkFGsk7f0wkTUtSrv5UEf5nbk/
         hrOk/DJEYa2MsY7loapodTb/hlb3B5ky0fnkK0hVDOJoRssdlK9M+5FFG9rV7YTM2FAF
         RqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787060314; x=1787665114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqQF95WlbW/wBv08Y8MEkU2oObqRblIP8p9ow3LJ+JU=;
        b=OVhyEvzprzZbc1XqSgQBNSsiwmTnxns/tAWPO1dl5DOBTv8IZiREO+1hT/ssf/cj/a
         ToIEe0LkzqdBixkucxQ6Oc2pB9ZxfurCyAV3oZDPZcZ7qtLNVT38nMPpFWAreMLxdLSf
         r+ZG1VBZsH0acWWq6eyrWP9u/JdNZ8VCagtTZ835hnF/MtGasc7huceUBvka4OlAhnHa
         Y/cn/sUxFRW5sLNf/a7fd/1sk46LzOr9IaK6WdE/t9OMIyZ73kfehmLn26zcSE93D2UN
         TeTmArsF3P19h0glE2FGTfY0PqgeMEBFSb0snWIpikKRGNau/fvZqu90fvKL275lHo1d
         2Ctg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6YfMB70iLsy6ImzcWJ6v6/QoxkkkYWDLhxxH6MwVTJoiZmZWzbh42kaGNA1L/Hto1t5XkyDqWC+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDlWr8qUgEXR8R/jVsmEvlrMFdRX0Ra3yZ/bTdn9ZqC3SbwFIy
	MW1iZKYKbt9lsM9T7PSEvWEzGwsCf5sJaYXWhtAAbFI9V9aSf5MVcWG8GY9y58CqKFDDAh/H5Nd
	t0ijRbjcgE/NLGiwqam6eTOS4B8rXPzGOUxfDqe0JPx4/DnH+X8/2M1oDEwf1NR8=
X-Gm-Gg: AR+sD13zhJOVq8kHE8DJQjLtW1wbPmV3xuz6bwsItlgQ5s7R+EV/nPdQl6ISPikqHqA
	7E+VaaW7b//f6ZxWTj+qf5gmO5tTqhV+O6Ce5Q7Whrkbs7LZDMyIb91iffgucQZ2GYxIIK4h/lQ
	eLCqHLGhIZNsTXeBmZ0xI2iZ93ByA3LLtZPySG0pZCAuI6wGRJuUokBoOasjsC/9f2XNKFtAQg4
	2op7Z3kWCS3y6cAehPmEiAC+wgY1LhFAGJ+4cIZ+h5fm7qtBGgl0UwJMlxEP7nwWpl53oE79H/0
	7tiz/2TicVTg6rorYEJjS78VMFe0tmy05T/SB0laOmC4Xmee2XxKGtDuclUZZxDpP9x9bSSLPdK
	P7CTe32Lr00aEIazfCqDpWoxC6twlXhPyCw==
X-Received: by 2002:a05:6808:4fe0:b0:489:93ff:9ea0 with SMTP id 5614622812f47-4b240fa99d4mr34038126b6e.2.1787060314014;
        Tue, 18 Aug 2026 06:38:34 -0700 (PDT)
X-Received: by 2002:a05:6808:4fe0:b0:489:93ff:9ea0 with SMTP id 5614622812f47-4b240fa99d4mr34038009b6e.2.1787060313452;
        Tue, 18 Aug 2026 06:38:33 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45f22aea368sm3232956fac.5.2026.08.18.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:38:33 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 19:08:11 +0530
Subject: [PATCH v3 2/2] spi: qcom-geni: Use GPIO to notify master of SPI
 target activity
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-2-e1c9e0dabbda@oss.qualcomm.com>
References: <20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-0-e1c9e0dabbda@oss.qualcomm.com>
In-Reply-To: <20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-0-e1c9e0dabbda@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787060297; l=3924;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=BG2HAs+2vxpsLD28GCWp9ALRBE+J16kkoe8+bOtWqJg=;
 b=um2Py9tYx5SurUsctZdhicd/AgopT7VEvseEsZ9J2HkAE+t8ehMwCdpb8ayQ/grCWPLnH5bKK
 AmwJ+ZFIonmDNH+9E/ILjU4ZWh9QnNcaFPjcIRkxUIv9JkLdOc1brs+
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: AO6AT0-MakIhlsE5y0k5l1ETncPmaR0g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMCBTYWx0ZWRfX/9+Gk/HOX+c8
 eA9yVymQ5M9XCZOf6BDXsNZrUqn22vVPs28NCHK6kRivouMDDn7vKSKvB3/I2MnKqyektH97eF+
 IdQUBCCBgv0vCfS3+sLZsxgzvX6rv1r07pPKOHC1kYsXJCQgkQGi93/ETz/WFG9XLANq3oTMZDo
 5CPoqnm/Dx2TBlumZOaSYAIVZXpxRZoMZR0b1TvxnMB3+z/p6i7sQeU5ZflJ3Eph+u9Z6Ex5AWf
 A0jFYxUYfoprKN34NjHEhLxePmbw4QLLY5qW8vp02Xs3dmvH2g3qX6NVZLGVwdlOBp7QjhZ/N2f
 t1judENLl/WY9TvP2RHY+0icdLH7kzjwx6gPRTNdIgsIqEn7QviFusxDwK4SYAZDmHy5kw4jv2D
 nOwJ0jOrBf+fT7Q/BPsYkuwJsesOM673iH0bcHnkIYLw54w5wg0BCSEThUjpsujugZMpgC7heI0
 FXA01g0/JXm3NgRwn3w==
X-Authority-Analysis: v=2.4 cv=K/IS2SWI c=1 sm=1 tr=0 ts=6a84606f cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Fo9EMwYq_bmgDG0ZVhAA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMCBTYWx0ZWRfX6MKGoFK5nCao
 9addtvnCTsR00y3G63IG/pmSx7/kp5XCNH9ehtznODDG950DQCVUwVSMwfdJgWa4/9lhAcb80Ex
 mNAKsUkj2eXU7PMdkwr23+uoije8isY=
X-Proofpoint-GUID: AO6AT0-MakIhlsE5y0k5l1ETncPmaR0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180100

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
index 6c57f8309a3b..bbe040383d53 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -10,6 +10,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma/qcom-gpi-dma.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/log2.h>
@@ -115,6 +116,7 @@ struct spi_geni_master {
 	struct dma_chan *rx;
 	int cur_xfer_mode;
 	const struct geni_spi_desc *dev_data;
+	struct gpio_desc *target_gpio;
 };
 
 static void spi_slv_setup(struct spi_geni_master *mas)
@@ -173,6 +175,9 @@ static void handle_se_timeout(struct spi_controller *spi)
 	xfer = mas->cur_xfer;
 	mas->cur_xfer = NULL;
 
+	if (spi->target && mas->target_gpio)
+		gpiod_set_value(mas->target_gpio, 0);
+
 	/* The controller doesn't support the Cancel commnand in target mode */
 	if (!spi->target) {
 		reinit_completion(&mas->cancel_done);
@@ -938,8 +943,12 @@ static int spi_geni_transfer_one(struct spi_controller *spi,
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
@@ -981,6 +990,8 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 			if (mas->cur_xfer) {
 				spi_finalize_current_transfer(spi);
 				mas->cur_xfer = NULL;
+				if (spi->target && mas->target_gpio)
+					gpiod_set_value(mas->target_gpio, 0);
 				/*
 				 * If this happens, then a CMD_DONE came before all the
 				 * Tx buffer bytes were sent out. This is unusual, log
@@ -1027,6 +1038,8 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		if (!mas->tx_rem_bytes && !mas->rx_rem_bytes && xfer) {
 			spi_finalize_current_transfer(spi);
 			mas->cur_xfer = NULL;
+			if (spi->target && mas->target_gpio)
+				gpiod_set_value(mas->target_gpio, 0);
 		}
 	}
 
@@ -1131,8 +1144,16 @@ static int spi_geni_probe(struct platform_device *pdev)
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

