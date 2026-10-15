Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4AA4AA589
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069162; cv=none; b=ADXf9RdT48CdSKD8DfbxskdC01xC9UVIUp2zLxCar/LLfZm7FXdXVqU0Mm7mAAjBM9c5YT737Uqi5+fK9mu1TdPD0uMOT6qqqabi3jSGO4eMnpXzmbwXKd+fnJK0JDK/L1Lx/0QUUO/Nq3DHbNTM8TLDC4hx29WM+3+C1NT/qIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069162; c=relaxed/simple;
	bh=qkaSYVs1A1FfiNbQRwSWq7z7OVJjlWk8kLkviqlm88w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIqb9kJhwUOpscgtecVLHNF7jvwpuGfLLt/2uKIfPBSYf9hSmsUvfZhoMMkN5iD3UvBPLLQjBZ1rJbOXZm1TXL+S6AmA4N8tOed9pPAMSiqFTYXDXXgF/PWaMAV6gvhJ3Uw+FdsfduK5pCbl2ot6veHE/ogkV0LvV3OnTJ92Fko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0s0nXuh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JyIS/6c0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0s0nXuh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JyIS/6c0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jO462114134
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 12:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QormqeaF2HvP9chRO0iezT1tVsjAj1s4h4tBLJETsh8=; b=L0s0nXuhOFOa8Y/Y
	QPhwbeBBr3Xn6MxK973ZKUL3TkmEMeonGoBQNNi7H1h7AJSCmmWtMwt7PhlcVN9I
	a129SPd99NmTOXWyMoyPFcE2oMwi6NL6dTfWfKtRyU9oAWwAav5zx4wuRc4nk1Fo
	EnZjPT44PcZcs0S5twjrX6JE+LSTzU+ytC1I4BjmnP8nsIE8zEIklyZEvyzedRxy
	WyC1UkodDa3N7jMtkoND3UI2XLuB45OZLT4kwBWE44HwPd+f07ppmCxXwkXO1Jjv
	HI1mkSrfBB2vNy8c77w/+IYWsTMCVoLrYIsI56o7trsAiVpVJghvyRpVaxfXCHBl
	TmJAcw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmyb4nu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 12:59:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e941532594so17903425ad.3
        for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069160; x=1792673960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QormqeaF2HvP9chRO0iezT1tVsjAj1s4h4tBLJETsh8=;
        b=JyIS/6c0Lsb7GWJvpolu9VJQnOjdmbg2CjVH++e3EoOrOdonW2lo5HXT7wJLoCEz2z
         Pi6G4xYw4oCoP+oFzwCkctfj1jF27id9/160ISRO3LCj2Y4jWpxcURiHFiDS80SmHFgM
         TRf7O6OQD/SFBqAR3W/63lxG8awd/t/5GxekMc0CUZ3qL04XTklfM+lc0X3BSTlfrl3M
         VjMbVsDiWTFeCJndw4DbO6qlZ7cfYoqz0ISmx+S4FVe3KVVfGtOEtu27Qm+O5f+QPfXg
         TlfTdS+8MhnOBgSqt5UsQfL+UuDE3So9nPrxiKfu2LBIm+HNNbd0X7TPLvmaWIyIoU+R
         ja8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069160; x=1792673960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QormqeaF2HvP9chRO0iezT1tVsjAj1s4h4tBLJETsh8=;
        b=Y2+G+6Y6FMDgPa8Wz97VTlSvNnGMCtCbSfHVHTnHbqu8Q5C0m6GtfRSv1VVuBpkZlF
         clPokrYM7Gfmu+rvSjcC5SzHdpOQG/VNB8U1fmmo+R2NR0BTAG/tl3PkZajBHchGR40j
         UQ7T9T4k0UdMIobJzyhQWPE++5fRzeHkhRaKsgQu73ls4SY+6hHM3TPWuJSHiSK/ny/g
         MNK5580BQuHmGjn6KdcaXrzX2kWZ6aGdd2+2y5ykeE1ZPvMBdhEzEu1Tw1hkrgQxINj2
         Q18dP9mcaAPTZoHMSaPchivzP2CtbxxNIT+wb39mV+VRPLykUlZm55l+Tsiw+RXVaaZL
         R2Ww==
X-Forwarded-Encrypted: i=1; AKwUvBzTmpMkcDxRpnUmVNoaMr+lw87Nk6Dzq1s8L9Kys+jLcBMnNVwRsbDW2DLTbCRMvh2OINpt0h7Pvw4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJGF2M2CEHKC9sADeoTfgard7Ogaw9U/jhl8JJAS54zFVdjj5C
	bzu+PGQnEOVoOaHwz10+DxG++UY/0IzmlozqsjgQnNpLM8XqwJ+sEoaR5pea+ZR0aDvwehZflJq
	Y+Ti1wh0M4Z4dH4JqYJavuZ8x5gyMObf0TtU2aK8rbeJ2PgRJspA6O5/ZcNkYJPfofq9s8y4=
X-Gm-Gg: AYBFou1aHgPgucV2evesbAtDE7xIRBF76+RWYnVd08ADwvRjtRCV6lgzQb459L0Tdi1
	7803qinYOBw2PyIk6PGUEGi68U/8uQ5yXxKAygTZZ4gxVHpFe19lwNtU8H7ma1MBtknN0VKmLWa
	lTwPJzxsERr+i4aZV92zLBAWMTbw16qkIHfb3zsJzcow9QyXkOUe5+XSJwXi2BXFrqBW/yIVAuz
	Zrx1TsK6+UOcvYoWg4wqtTyrVfq1dxwKxdwtMQUr2YE4O39um/fHHnfavzQykhXT7YwTXgImQOx
	Bacd5YM2awedFsL4MYBN2oyyZxa7CjBDNf/ouLdJUTWoafMkThnDdJNuTHBw9aXkt1gpQVEEPAU
	ZVpQK5QxklbbyoU5yc04xZ8v416yCEh2+KA==
X-Received: by 2002:a17:903:32c2:b0:2e2:d77b:e586 with SMTP id d9443c01a7336-2e843141ea7mr177350765ad.60.1792069159648;
        Thu, 15 Oct 2026 05:59:19 -0700 (PDT)
X-Received: by 2002:a17:903:32c2:b0:2e2:d77b:e586 with SMTP id d9443c01a7336-2e843141ea7mr177350495ad.60.1792069159130;
        Thu, 15 Oct 2026 05:59:19 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8d8dsm79691705ad.52.2026.10.15.05.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:59:18 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 18:28:26 +0530
Subject: [PATCH v3 6/8] i2c: qcom-geni: Vote for SE clock rate using OPP
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-6-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792069108; l=2981;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=qkaSYVs1A1FfiNbQRwSWq7z7OVJjlWk8kLkviqlm88w=;
 b=GfjgqsLnjivYglSkQthZAmSd6PQDk9KHCAFEauzeRzX/MMiVc7VnZLc7GKQI8jgnR8TphMhYv
 0FjUmepZUxjDbOHySEvh7hXEWFaXVlfWLpAyXD3kYlrAwrO+Ltc5aqI
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: oqBxxKXao7I8JJPccf3w_pA70AsEa5uw
X-Proofpoint-ORIG-GUID: oqBxxKXao7I8JJPccf3w_pA70AsEa5uw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfXy/Y60Ji9PSlS
 oFQCf2kwkl77gS5bf5EVlmdPkOW2MSjyPs6SVqfZNEN41jClk2wHI7pOCbJeQWt6l0Ay90lBVDK
 G/VDjEWXRDqzWNGgrdiAZHer3+npQE8=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad0ce28 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=naqKnnrhZPCzqLgBruQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX6pcUmK/UIGLV
 G1PbxLPtDHnmL2uEJjLARxOx68JIa7w9A6pDZJG3+VsijceDalYNbpWqGgmOX7uR6QfJJdMC/4N
 +Ru32gTFCTzxmIsbfHzF2bwaRIFpVPAHMLTFgE0BXgkJ3e57Zp0bmvTGslxjEj5r1JQupWoXLM6
 LL4c+fyuvcqwRbVQxZ4OBDTQZefTytAc1EtXNonySE06r9tl+L0jVyYQI/lqcE11+KLHP/Qf7Uc
 llcodnzxy7LG1ozC2w1ap5PcZsDs0LR3sZcdEBykGWthsy0/xynl+EF7Dter9i5FSfALAlS6tuZ
 Fywt8TD23BUJHXnfEbMwq/vOxKO6TorP6hdj4x/k4RgyWquRCshPPzO4VOyU5CIY9axco+EIfqh
 f6K5on1MVWGlzx/3tCC2/P9hMlX7yH/K3rFoseFWtkom3kPkANwr5vj4dQRWJ00BOplptUHZR5R
 YCfj4gMnX0ShKZif7CQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150051

The GENI I2C driver selects a source clock based on the requested bus
frequency and programs the corresponding clock selector. However, it
does not request the selected source clock rate when OPP-based clock
scaling is used.

Store the matched source clock frequency and vote for it through
dev_pm_opp_set_rate() before programming the clock selector. Also remove
and restore the vote during runtime suspend and resume.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 5f3d260a3913..a6fe89d0934f 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/qcom/geni-se.h>
 #include <linux/spinlock.h>
@@ -136,6 +137,7 @@ struct geni_i2c_dev {
 	u32 clk_freq_out;
 	const struct geni_i2c_clk_fld *clk_fld;
 	u32 clk_idx;
+	unsigned long src_freq;
 	void *dma_buf;
 	size_t xfer_len;
 	dma_addr_t dma_addr;
@@ -206,7 +208,7 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
 static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 {
 	const struct geni_i2c_clk_fld *itr;
-	unsigned long req_freq, res_freq;
+	unsigned long req_freq;
 	int ret;
 
 	/*
@@ -223,14 +225,14 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 	}
 
 	ret = geni_se_clk_freq_match(&gi2c->se, req_freq, &gi2c->clk_idx,
-				     &res_freq, true);
+				     &gi2c->src_freq, true);
 	if (ret)
 		return dev_err_probe(gi2c->se.dev, ret,
 				     "Failed to find SE source clock %lu Hz\n",
 				     req_freq);
-	if (res_freq != req_freq) {
+	if (gi2c->src_freq != req_freq) {
 		dev_err(gi2c->se.dev, "Unsupported SE source clock %lu Hz\n",
-			res_freq);
+			gi2c->src_freq);
 		return -EINVAL;
 	}
 
@@ -255,6 +257,11 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 	u32 val;
+	int ret;
+
+	ret = dev_pm_opp_set_rate(se->dev, gi2c->src_freq);
+	if (ret)
+		return ret;
 
 	writel_relaxed(gi2c->clk_idx, gi2c->se.base + SE_GENI_CLK_SEL);
 
@@ -1286,7 +1293,7 @@ static int geni_i2c_runtime_suspend(struct device *dev)
 		}
 	}
 
-	return 0;
+	return dev_pm_opp_set_rate(dev, 0);
 }
 
 static int geni_i2c_runtime_resume(struct device *dev)
@@ -1300,6 +1307,12 @@ static int geni_i2c_runtime_resume(struct device *dev)
 			return ret;
 	}
 
+	if (gi2c->src_freq) {
+		ret = dev_pm_opp_set_rate(dev, gi2c->src_freq);
+		if (ret)
+			return ret;
+	}
+
 	enable_irq(gi2c->irq);
 
 	return 0;

-- 
2.34.1

