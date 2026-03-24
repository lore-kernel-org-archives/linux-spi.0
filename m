Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6B3F8DE0
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358037; cv=none; b=nTw2RP+bdnAh24kbnGKp8YJLNtq5DEngA4RRFkBJJe74MQPpUi5hqIphh+bETDBS1uTeU8QitbU3VP4nVxD2c0h+UmuY3ai+3CBW3UffEjqvXWs3i3/Zw/D+nhVL2cPuLX4P3Ziogx4Nb/tDv3FadfcYLhuSpU+EWw0Z9+T2yGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358037; c=relaxed/simple;
	bh=eLk+moHGQ/KDUbGhPcR3O1NOipyZ9xBd3d/bM6COqeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UDsJ+KvECElDru3YmOwKKr7xADqz17z71gJ1RYIQ4TjeJ0P3m4jPm7GlwV4jlhY7jZgdq+rcw2oxAZKFDWLi6J+wG4liBd289XY0t9LAbKWkVHxDedfphmOCa2FswB2GnVKpOkOYidYhskOdcqblbGJMEAr7BzP3HovgjtQzim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nhBuDQvC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fz1BIMUH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nhBuDQvC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fz1BIMUH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O8xxB12323595
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WF5ijdDywM27lraVCHuUZkzXeHBLB5LhHo7w/l3hGLA=; b=nhBuDQvCvYFYrERQ
	jVWX4HYQ8b9iFJeiCDxV3a9cbOgbGuIhy6vVrQp35HJ2d3jj5lcGrtICf/RiJLF2
	QNZiWJpCp3685tvYbYQpMDgIlBZQLsH0loTTK58O3gXg4DzCF8SWsM5eUDrRnXEE
	j0nRBHfvlo5T1iUwjQW93NBRJr8PQb4D0fn0SSWGZ5+lmtBB1ONJi3fT2/dNk/qS
	sEQhpqSjoAmHilf3nlnwSVBHTI5G6AS7yo0Vwkogpg8XB3h6K6POTVLQPDAfqPZ6
	/nPOUQuqXIOtoZP/EqlgRf88XXEh/NBaApKMVF3PnyfaOAdcAqbzqcm6kg0QAv4m
	fjAgqQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3qkes0gc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:13:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c44bf176so4980644a91.0
        for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774358034; x=1774962834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WF5ijdDywM27lraVCHuUZkzXeHBLB5LhHo7w/l3hGLA=;
        b=Fz1BIMUHTnGidPg/MyTwL8kyOylOEajK2p9L4zM/GHWpRKiOw/5k/4HeP+S4rN8kBQ
         4Rmrcm3ZaFs25SrWeEyXDUm36wvrQFybyc5kvt4JpdTvSIkUfBLPp2bU3Ke9AvVQrMeb
         mJa/WDSwLhvPIOfFkgYcKJpeWzj+iUipN6ex+hp6snVK2ZKSy5IAyXPSxfDeHBR9JnFo
         NwAGxDgD18VbQLqoWJTZpzOGQsAa/dmgLJULlFyuJwNwciKOgS0edA9KLQ7Lmz+A2JQb
         v+ILj0gsSk7dq/cZGkLfVTw7wHHrtYF/SH4pik2aoINmNAAa2CryzdDqdW6ldEIdQK+o
         6wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774358034; x=1774962834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WF5ijdDywM27lraVCHuUZkzXeHBLB5LhHo7w/l3hGLA=;
        b=Aln+rHYhDy6p5H6hmhPaj4jtFeBaZZgohPOfQtgXeqWNgWAe2SbIiJGFM4PycqL3s3
         a0VjPuTQXPTiCjNVzEktZdd67Zf3E19wKnw5LhY9CWEb6AiFRdq+05b+IiByGNMAGiJ2
         /RnsSPlfmS6K0W5P7GgI+8qIoylpg59kBrQbhE7KPnNqOtfgHZW0JkIKHCjGNeA2+gjM
         y3zup5TNPq+YumIphN7Y5Rl6u/dFfPsIY1/1NXmy7cBG97sQ+0Lh0U6pOM1yWvH9ttKt
         dGnV21R3sEOarsoERwhEYh+oq+Co4a4KKX17jTtfuv0sS4QTdNu9OCfUAd21JZ2S8xwY
         J8qg==
X-Forwarded-Encrypted: i=1; AJvYcCV/AeXWg7B3FWxL0ZO7XOUQCNMYO59wAF7eXJsLenaNyOwm4ohkYSLzvmcfvpfglaQpvGDrL6NrZ4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9rBaobHP26fEBDoUuWB7KcIaDdlnVdEqoGgsWDzyhdOzDlUg+
	Qvdj8Rm5H9nB7b6qnBflThchLXXNKCeqrJOMTsGFxQcTwu4xjsdAT3977jN3UZSjjj7jCLu86FQ
	alCGAK8zgStCFMunyzpYnDIG7AJ65CdOVFyzqki20VaJI7h0W3M0VoOJjJerMvIU=
X-Gm-Gg: ATEYQzz/mOs+V/7fC3YxGHL9rta9REUde6Nq4YzUBcI4COJi6HB8TjU57SJQSlb+f+O
	vtw/lvevq2wBVAgzt+gDzaLkvlfptMRNyri9rmEgvEpe8pfxPw+1GZQx33mDRsozfYwxO+e9mEq
	hk0SWN1/TQdh0+eoZHm1dbI4na/hlB9ZQ4Md2DlJPNHtk+ZIWYknOvY08pXonVY7ab+nc+RdTFT
	pDaMgUh4Zkf5baWXtdYvH90W4GeqINyI0x+6nBPDXj9pVxXUsf2JJ2aO0/Tbn5Jjos00aqNYH00
	mFC7pVBTvu/52FJ5KdrnGmiBM+FHhihEnUpSnzjo90VscspmLR2fQxI2v07+y6cF8ieNCiG1C6u
	LYfTRJvChr0TiHffiuqsypQZqFY99bMvjMOkg+nIfFIuZfEg2qDgZYmtX6g==
X-Received: by 2002:a05:6a20:729e:b0:39c:1871:7c6e with SMTP id adf61e73a8af0-39c18717e0cmr6769758637.16.1774358033999;
        Tue, 24 Mar 2026 06:13:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:729e:b0:39c:1871:7c6e with SMTP id adf61e73a8af0-39c18717e0cmr6769725637.16.1774358033410;
        Tue, 24 Mar 2026 06:13:53 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03be3396sm13517528b3a.27.2026.03.24.06.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:13:52 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 18:43:19 +0530
Subject: [PATCH v1 2/6] spi: spi-qcom-qspi: Add interconnect support for
 memory path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-spi-nor-v1-2-3efe59c1c119@oss.qualcomm.com>
References: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
In-Reply-To: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774358020; l=3550;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=eLk+moHGQ/KDUbGhPcR3O1NOipyZ9xBd3d/bM6COqeQ=;
 b=M8/COYw+KT3lylYETQfA5lK9LxQl7ncDB9ZNzWdprWFWdBQUeowaLlt5F2EKKdEB2s0R18f2s
 YyQcGGswb2cCFokh21vRDns4ZV000MLxNQuTAdQpw+vZurcjoC5RKoS
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-GUID: zaIkfPah68ERh16kI-HSucRBQ6wioO2G
X-Proofpoint-ORIG-GUID: zaIkfPah68ERh16kI-HSucRBQ6wioO2G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwNCBTYWx0ZWRfXwWDUeaTmXA98
 AJakjJnPDjtrGenukApnLkdUh5bY714pygF2CYyX474IiVhlujLt6OvxWWenFnrjMwgXe+Nd/QA
 ZgYtNGLw0ND/AHV754qxfq51+F95ytnRL2ONXDvxtGsfWUg6WDkk35EEji1qtBPFc2CcJ3BNeic
 FwK2vUxoZmCyNPAyzHgj6lioa4iOjwi7RbClOp5pfmXo7d09c/AcL3+xgA5s0wv9fVGgeIiQi1C
 UraA0huIak1qXryW+VK1BBBTlrBXAHRNv54hL0jXiqxcqmdJ4rUn8BSGNLC2p2tfbE6Cn8kLmy9
 tUxGnEpkP6N0LT3zpJESfQWjpPrNDLReOXM8t4arsOimMHBMbg++xyrBauNa0epmKKw62N9bYiE
 I92jwiELp4ydvIllt/lsDVH9bU708Vkrn8HD5Quz127EnGzEh+azsurFAOn7u4vnuZD66jgMu28
 QzlJYTxE+CiLXLy0BJw==
X-Authority-Analysis: v=2.4 cv=Veb6/Vp9 c=1 sm=1 tr=0 ts=69c28e12 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=UubsFNhUUF1sPbzy-JQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240104

The QSPI controller has two interconnect paths:
1. qspi-config: CPU to QSPI controller for register access
2. qspi-memory: QSPI controller to memory for DMA operations

Currently, the driver only manages the qspi-config path. Add support for
the qspi-memory path to ensure proper bandwidth allocation for QSPI data
transfers to/from memory. Enable and disable both paths during runtime PM
transitions.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/spi/spi-qcom-qspi.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 7e39038160e0..624b3a7b6291 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -174,6 +174,7 @@ struct qcom_qspi {
 	void *virt_cmd_desc[QSPI_MAX_SG];
 	unsigned int n_cmd_desc;
 	struct icc_path *icc_path_cpu_to_qspi;
+	struct icc_path *icc_path_mem;
 	unsigned long last_speed;
 	/* Lock to protect data accessed by IRQs */
 	spinlock_t lock;
@@ -272,7 +273,7 @@ static void qcom_qspi_handle_err(struct spi_controller *host,
 static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 {
 	int ret;
-	unsigned int avg_bw_cpu;
+	unsigned int avg_bw_cpu, avg_bw_mem;
 
 	if (speed_hz == ctrl->last_speed)
 		return 0;
@@ -285,7 +286,7 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 	}
 
 	/*
-	 * Set BW quota for CPU.
+	 * Set BW quota for CPU and memory paths.
 	 * We don't have explicit peak requirement so keep it equal to avg_bw.
 	 */
 	avg_bw_cpu = Bps_to_icc(speed_hz);
@@ -296,6 +297,13 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 		return ret;
 	}
 
+	avg_bw_mem = Bps_to_icc(speed_hz);
+	ret = icc_set_bw(ctrl->icc_path_mem, avg_bw_mem, avg_bw_mem);
+	if (ret) {
+		dev_err(ctrl->dev, "ICC BW voting failed for memory: %d\n", ret);
+		return ret;
+	}
+
 	ctrl->last_speed = speed_hz;
 
 	return 0;
@@ -729,6 +737,11 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_cpu_to_qspi),
 				     "Failed to get cpu path\n");
 
+	ctrl->icc_path_mem = devm_of_icc_get(dev, "qspi-memory");
+	if (IS_ERR(ctrl->icc_path_mem))
+		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_mem),
+				     "Failed to get memory path\n");
+
 	/* Set BW vote for register access */
 	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, Bps_to_icc(1000),
 				Bps_to_icc(1000));
@@ -829,6 +842,13 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 		return ret;
 	}
 
+	ret = icc_disable(ctrl->icc_path_mem);
+	if (ret) {
+		dev_err_ratelimited(ctrl->dev, "ICC disable failed for memory: %d\n", ret);
+		icc_enable(ctrl->icc_path_cpu_to_qspi);
+		return ret;
+	}
+
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
@@ -849,9 +869,19 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = icc_enable(ctrl->icc_path_mem);
+	if (ret) {
+		dev_err_ratelimited(ctrl->dev, "ICC enable failed for memory: %d\n", ret);
+		icc_disable(ctrl->icc_path_cpu_to_qspi);
+		return ret;
+	}
+
 	ret = clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
-	if (ret)
+	if (ret) {
+		icc_disable(ctrl->icc_path_cpu_to_qspi);
+		icc_disable(ctrl->icc_path_mem);
 		return ret;
+	}
 
 	return dev_pm_opp_set_rate(dev, ctrl->last_speed * 4);
 }

-- 
2.34.1

