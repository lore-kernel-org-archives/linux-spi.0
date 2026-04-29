Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD5410D1A
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482123; cv=none; b=YZBgn04OIreInjY+hCqJELyqgphvMtI9da0p4yQrArvAf4/s+nTWygC01fLtMdvY4AodDc96UgMA0okunQW1vGLBX5Wm7LmCK/NM6MlV89aObK9aoFJ2ehDjsDjfW9BkDYk3+aiqIY/YJqy1+VjKhaOVBPp27alaUjkmSE/yv6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482123; c=relaxed/simple;
	bh=ovZTqUF5/g2sWp/btJDRSg/I1HuohA0bLfF+dYDDAN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKrSumSVWYbxns7UTk+I6IPN0Ywz4hjpg3sejEluuqhhVMnWqTiAdQg2FAITojCmUgIFz9PE2+qfIWLBxUcGsf7zFqDG3XW5x72C18sbE/DC76jUYojVHypk+OJWEw2/tlX0B/UzDDt4ep9Z1CjZnKCOIGZhDGPG3EWxJPIJDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZCAbOsSh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HFmrMLOa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZCAbOsSh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HFmrMLOa"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFMgZx3067025
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j2Ivexwz+aHyP4Wah8ZSNwaKmGZD+PrFeXoflq99gDE=; b=ZCAbOsSh7jJfTWXJ
	YLq4yNxSyUKwYAnssN7pkdn5VXZlAxirYKuC/baaSghDv+96VC4QYsDXFx5ccyVy
	Z8WxtVSL74b/Ik2c7m165qfS8EHCNpbD91BBuG9X5qRpF0U3MEQ+r8zhukvcCZEM
	XULEqcO8TExlQdzL7vIqcUpU8eU5fYqdXBwkAqp1ti+U3uLz0NKOHIOUIVR9y4NT
	q8mzDTgRVdM4feTpL2CBrFTdgjIt2oJ38spRr3ueuc93gGXHtiZ+LY0mp0XODbsp
	Px5UGPqVuJZKKUICNciraysJTPrAzhnt9AAJf4bE0xiBiZnoAkmdhyqAGrq3Jyxp
	AFsNAQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxbnhr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b241be0126so50565ad.3
        for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777482119; x=1778086919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2Ivexwz+aHyP4Wah8ZSNwaKmGZD+PrFeXoflq99gDE=;
        b=HFmrMLOakOPIvIXrZZ7Yh6XHNKhLLkLjE3xXKe+F5jp4U1qbDls/9f6mxCe/Ysic9F
         /YKocdh6+dXqGEHDP0VqP3iBouH6kAp3VM4F1v7ZOtuOSOqC41i0Z3qGtYIH4XTpsAvM
         6QeGDxzu30Psn2I2CZLB7XRUwddBUNLck6wPkT4RQkQZVleIZ9cPqyIEAqIjeJbT52GZ
         dMFrOC+RC+mqXjupJ7I8U5cKVTnkR4x9WMqQhAssPaj0bke/5ongYVWhOOODsG+4O06c
         fmeyV/lDtnnPlQ774/pxfkYzF75RocdijdBK7q4v8aSkZctWLEjtc2hzq6OHMub7++gT
         o5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482119; x=1778086919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j2Ivexwz+aHyP4Wah8ZSNwaKmGZD+PrFeXoflq99gDE=;
        b=rH7dTM/w0BLOi0s78DDssDm01SNJds89J+Pgl+Pc5t/LlDlhxOgH0BY505Md02Xxl1
         JiP2jyXxIy8Y3yBV4vj+1Wqz4v4LfAlI18PlelLaikKjWL1ktXqAjQwHFJNblEb23exM
         2/HLRYKOXTjKhHQhirq68TV8nqb0GZDSOEN3df/qz+K7TlzaSq+WRqTMucCYl/ZA8LCA
         OXxVF3NkCxd2ywkGFVpijA9cU+f5Xio04E5zqr2DzC1ni0Hj7hNT8SRYVGupySd1Jt+9
         AxWHL7VfxlQwfjw2JDDCrOibuX4AbWFCci4XF9mISO97vvMpg/BcSZV4jpXz2FmFRily
         reFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8sEvqq126GzV9oBjbSXw5HMSU9G2t6RM/2nTcAjdVYy+P55N0qY+UDVqu4NYlhTXbsbeOkwWw8Fv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp1Yc9ZwwcYsR75aBJ3gRi1qWT+9V35df/rkbIIcsXnI91zVAy
	IQXKSr5srnx+5Ejb9lAMfLu1S0W3iVRR9iS564t6BAB3GrTnma1bk5e01IvyKVTstfNj/dX+9Y8
	P+PJCqPO+ekEsxPelmrz/2A4QJ2hmnom9cNuc/H+XQoVvJFWaravbcsSvYkkG94s=
X-Gm-Gg: AeBDietDv3l/D8GNuldYSY80LrcWZhYzbr4JSUdf1w+51wcZJQUPs09XvyFakvY1Wb0
	Szz0PWwR4t306JheGl2W284Q3TX9WId1jRXpPJ9gSXahh2KXPCmL7Q28CSEzodrBUYVkm61aZX/
	bjhRUy5sbNm08akvK7oacBvG0DF1+0pecAlLN4qYU3Ro7IW/aJmnPQ7e0GbFrvRD796+L80cD0c
	C0LZctp+IAWm71E26a/bVdGGM1M4aG5lablPXB9Ybhs2ZAKWp16CJYZpSEJtL56GSE3n+9lUaY2
	bk+hrWtppPhr2uP4h4BdixG3FI8wheL7aAarB98j1Sf+b9IZ+xgVkv+Zf3EWTGhTnOQENs2e/3M
	9dUi5Lf77laiq0D2KC/bUpIORsRDKBoWAk74ihh+PuemAuXALZPaf3y4F2JzNnMDw/wkt
X-Received: by 2002:a17:902:c407:b0:2b4:5dad:2523 with SMTP id d9443c01a7336-2b9874c7e78mr50152415ad.35.1777482119109;
        Wed, 29 Apr 2026 10:01:59 -0700 (PDT)
X-Received: by 2002:a17:902:c407:b0:2b4:5dad:2523 with SMTP id d9443c01a7336-2b9874c7e78mr50151905ad.35.1777482118618;
        Wed, 29 Apr 2026 10:01:58 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9887853a2sm29530195ad.18.2026.04.29.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:01:58 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 22:31:38 +0530
Subject: [PATCH v5 3/7] spi: spi-qcom-qspi: Add interconnect support for
 memory path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-spi-nor-v5-3-993016c9711e@oss.qualcomm.com>
References: <20260429-spi-nor-v5-0-993016c9711e@oss.qualcomm.com>
In-Reply-To: <20260429-spi-nor-v5-0-993016c9711e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777482100; l=4235;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=ovZTqUF5/g2sWp/btJDRSg/I1HuohA0bLfF+dYDDAN4=;
 b=gxL6mgFY9dV5rNFOJLIQhaOWze1XUs8hM9+PuUYaer8dRy2UUpam/lQMrxLEUEJ6cbpTjMR7a
 q5PyTtqplVICwNR4yie4D4+2ZKbrF18vn6OuOlJXU5aBvkJaUThiPAq
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-GUID: qxaefnLbQQkY_5b-6C5651l_pT0WJV6x
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f23988 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=S70kITjG2mzSNXz8RO8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE3MSBTYWx0ZWRfX9uXBpU2R+U7W
 vgvM7uA1j6x10Smtpm2tJJQIXTZJFMFxytmcnyxU4P4DKfS/6BVh6tWZEMJ9rd8lUU9bwfMmJin
 ANnTCE3Jwv4P5kN6/Aqf5Fvy46Exw4/TTBFcZUfL3J+LrijOxX9J3vSQz0QZSVyPI5RK+OZjUEj
 BOqUb6xSk7tAea1bmXiGkKlmy220ToQx/R057tfDN0KGMyH5KyhNbxnVNKNzSNgje4gL6JbNeJW
 5KCZfBJkTx/maV/yNTub/piVtXXjSquZzcaJTm4QJBrsQZNodAI5JQudL2Ife7Pm0gT6dy+qQFS
 zQx63pPutW1KE7C1UPFmrYY6Y5R2pQbEicJazerbnIwT5IHtMUx/gkdhFepk9O+sayWyuRPw3di
 RmwjjQ1lN46jnF+b6s4869o4yE9K/FMRnD8fMeeQ+WiUTbXaYfj+RdGxqCDOBP9ZLhuGwJGMSUA
 dXG8kSGTW3N9T/NOqcA==
X-Proofpoint-ORIG-GUID: qxaefnLbQQkY_5b-6C5651l_pT0WJV6x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290171

The QSPI controller has two interconnect paths:
1. qspi-config: CPU to QSPI controller for register access
2. qspi-memory: QSPI controller to memory for DMA operations

Currently, the driver only manages the qspi-config path. Add support for
the qspi-memory path to ensure proper bandwidth allocation for QSPI data
transfers to/from memory. Enable and disable both paths during runtime PM
transitions.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/spi/spi-qcom-qspi.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index edfbf0b5d1fa..caf55a6f70b3 100644
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
@@ -729,6 +737,14 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_cpu_to_qspi),
 				     "Failed to get cpu path\n");
 
+	ctrl->icc_path_mem = devm_of_icc_get(dev, "qspi-memory");
+	if (IS_ERR(ctrl->icc_path_mem)) {
+		if (PTR_ERR(ctrl->icc_path_mem) != -ENODATA)
+			return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_mem),
+					     "Failed to get memory path\n");
+		ctrl->icc_path_mem = NULL;
+	}
+
 	/* Set BW vote for register access */
 	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, Bps_to_icc(1000),
 				Bps_to_icc(1000));
@@ -827,9 +843,15 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 		goto err_enable_clk;
 	}
 
+	ret = icc_disable(ctrl->icc_path_mem);
+	if (ret) {
+		dev_err_ratelimited(ctrl->dev, "ICC disable failed for memory: %d\n", ret);
+		goto err_enable_icc_cpu;
+	}
+
 	ret = pinctrl_pm_select_sleep_state(dev);
 	if (ret)
-		goto err_enable_icc;
+		goto err_enable_icc_mem;
 
 	/* Drop the performance state vote */
 	ret = dev_pm_opp_set_rate(dev, 0);
@@ -840,7 +862,9 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 
 err_select_default_state:
 	pinctrl_pm_select_default_state(dev);
-err_enable_icc:
+err_enable_icc_mem:
+	icc_enable(ctrl->icc_path_mem);
+err_enable_icc_cpu:
 	icc_enable(ctrl->icc_path_cpu_to_qspi);
 err_enable_clk:
 	if (clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks))
@@ -869,13 +893,21 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 		goto err_select_sleep_state;
 	}
 
+	ret = icc_enable(ctrl->icc_path_mem);
+	if (ret) {
+		dev_err_ratelimited(ctrl->dev, "ICC enable failed for memory: %d\n", ret);
+		goto err_disable_icc_cpu;
+	}
+
 	ret = clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
 	if (ret)
-		goto err_disable_icc;
+		goto err_disable_icc_mem;
 
 	return 0;
 
-err_disable_icc:
+err_disable_icc_mem:
+	icc_disable(ctrl->icc_path_mem);
+err_disable_icc_cpu:
 	icc_disable(ctrl->icc_path_cpu_to_qspi);
 err_select_sleep_state:
 	pinctrl_pm_select_sleep_state(dev);

-- 
2.34.1

