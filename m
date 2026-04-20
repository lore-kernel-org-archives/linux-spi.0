Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB963815D2
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665599; cv=none; b=NhIby38DfpWgclJnX/4BnG6sr7iPJQ1Oe1SuWtpQEq2gz6aT1TIls+B8b/OCfJWQstZgGmGHndrV1QBjCxIOjEUA2dLt+d1XJXr9cntLIbYd44meefxPaYC8eWNVl++W4RuImyGWxID82vFgIFwPL3t/L7v/w6MrXMCmRDeXiH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665599; c=relaxed/simple;
	bh=alSx5LhHMXZVaVz4KF3miez0euhqC7ht0IrPBqldfw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5F3LxbNia651DbGqxcDiRpWls62Wo1+fULQTu1kqLiYi9x3V130/D9pPVhkOFi17PDOLirK1cPwUbZJVKt2N96gK/HxxaB2u2s/kzCKJf4oPdjzld+zBgMBh001GjPyMKXck+/vYjsuNfPreDwxvvc+vKuXmIc2/AakwgDd25c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dLw1zCYL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kNqWmsre; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dLw1zCYL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kNqWmsre"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JMISDi1398645
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KbicD+JjAcPTtJD0uPtbhcOnxF6jPxSUPQ/NZZv1Q/4=; b=dLw1zCYL9JL+A5v0
	JuZ4MnPPcLT3Dv4ZYlUeWIHz2RkJFoRQYK3o8OCob8OV2IV8ms8tGIY481PEJKQ9
	moWh7YHof7pfI2pr0MapFUFCjHxaWmbp4hUNuJX7XUGb2ZEzNP75SSK4rFg50jog
	01YhH6ZsITxjxP7CX8q7RCcGPcIxPBclV7EEADgDxOiM5umhOp3BMdMVed9CxeuC
	8/PaebPJv317Ti5VJKlGmZ0y81zPveNXEernkxxTs0RqF09Vr+ACvGxm3W8MX2nO
	Zh6pPA8nKRmErvu0Y416d4LdTQcFEuwRJmCBgJjlGRaAtYfa5DVUg/o2awFKyWaT
	tYDDVw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0wr4hcg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:16 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f803658d5so3209479b3a.1
        for <linux-spi@vger.kernel.org>; Sun, 19 Apr 2026 23:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776665596; x=1777270396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbicD+JjAcPTtJD0uPtbhcOnxF6jPxSUPQ/NZZv1Q/4=;
        b=kNqWmsrekidtv54JQXd/hyWLvING5+ivHPJ9TUPWPSa44xTVKB05Jp2apSqwbMbN4j
         HrWb6nqZpkkm9Y9u336xkVligDup/bonULB+EpZD4MFfI9IPsM+R2ghmQsYdHUWcQEDA
         mBU0TmVLwxznRrVINbic4IMAUEwvrH9JbRfI7MOXeCRlK++lbQcieGcUulnNlIRAPRy9
         JIGLWCz9qJoLoXqRFuwNeuMpKSscTC2SkMS1pg1WvdmurQ6VdoEPxGYzW/w5TeUreKtj
         /89CUe+eMYJ7kQBvUy3Q8xg8fAhdX62XHTscsLUQFE3I1X4Nf9gVv4IhGGIRANd8tEyV
         rSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776665596; x=1777270396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KbicD+JjAcPTtJD0uPtbhcOnxF6jPxSUPQ/NZZv1Q/4=;
        b=GZXq0aPxL5nKjfiizkolfNZD3CZmI9uJc39pXBC5O726/2R+kqOQj2nFer3kPq9mGZ
         MjXWge4g3SGfLIg9jjxnC+JVO+xDybAQXBlCEwAbf9bs/YI9YlF8E6otKTqbEn3bF5xZ
         oUEwh6gbhM4GxFhqL6Fd8C5H1lsnxbj4e5maI5gebsllMEEnXDWW4wIX5LQiUn6WPTmJ
         smrJHHJaATWHiRz/FnseiFUjya0IZqQcyXE2HGSKYJpk9smgMVVOS5Ry7X6ilmpSbZEc
         u1XOM1PwW76cdUJyA4dMQE0rmC1Gzis1S5XGhv0wFcUyT3SzU8o026ew8B9B6UYHu73V
         lVPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8K8PrTkhMihAKBPbZVBqofe+EJsxES2s8fmYovgzy2dpqChr4zGSjZT9FB+nhjePvVMEoN1ZIuQuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVO21lqU/xNqZ7vR82D4Dr5/B0Od+BTyqM4UGCtzntrKVL/nO
	NlkRClNhSjWkROhf93nevhcVR2AvDsoATk4kp/6eWuMaCPFoK2Sxfnh4l2/UPWZv6oOq0u0Wtcy
	y6JAtAz2wLwKb82QdYxUSBFXXrIRMGgtigvJXWqTRqHHkNDpYtTtWCwTxMOa44Lw=
X-Gm-Gg: AeBDieumkcrYU8yNEwKjDExQQGtutuiEcP+bA4DDDLNKLR35QInd72tL9d+zQkzUvpw
	G/vxJVoDVtDOsPDWMicmjKxWGcOF9f7g66ydBFal/Sx1ppuzQTe3yFpYDWoFcUkfxQ0Giyb4T3j
	dYai+x/nYaaFGxUAnNYr3cx6tYomW25a0yRgBoxEpm/95kMoSiuaxbn39L2o3+H+Z1ik7tOuKwp
	juFsWNzZA4qeCJMQVq7rDHopxQU1f1yJvVIhixEf46C4AY3HbvPGiimkkl+lftZMq+wALRygPLE
	FGYvhlyZCvTc/AOghckJZ8JZUXXnQL0oWJHO0uS93h8p45wWuU8FkE9e9FmbZp2Lze3mcUsAKzC
	xM4QpQPC19pgcBhpPS92jc9k3e9uVFwGxt7Fl6W8CDXKWCn0d1a+zQsH/BVvPo2cwF7ww
X-Received: by 2002:a05:6a00:116:b0:82f:9d21:d352 with SMTP id d2e1a72fcca58-82f9d21d516mr6082061b3a.9.1776665595647;
        Sun, 19 Apr 2026 23:13:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:116:b0:82f:9d21:d352 with SMTP id d2e1a72fcca58-82f9d21d516mr6082033b3a.9.1776665595145;
        Sun, 19 Apr 2026 23:13:15 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb28sm9018034b3a.13.2026.04.19.23.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 23:13:14 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:42:49 +0530
Subject: [PATCH v3 2/7] spi: qcom-qspi: Fix incomplete error handling in
 runtime PM
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-spi-nor-v3-2-7de325a29010@oss.qualcomm.com>
References: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
In-Reply-To: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776665581; l=3239;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=alSx5LhHMXZVaVz4KF3miez0euhqC7ht0IrPBqldfw0=;
 b=hz1LOnX4tYZ3Dighub1FkxkQlKvXQyRbg78ENqcECd/oJM7s6BSAHwxpYesGf7tlfUonqMqbd
 wSvdHmju7eSDqW38oPz6v1shXf87TFugRgHFYVRF/Vv5hZy/StrZ40u
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA1OCBTYWx0ZWRfX4txvFqLFRjK9
 uGBD9BlF7P2N0W9IpAZ0U9YJXU1hyJKl3zVTAGk/dWeS+cAyo+DFWzMkwLlEeOaymZNSKT+FLuU
 FFn0Be+vZkuR4EDrg/6+FQknZJng6OLcPNbVRc02xVO3QyYAZQaqHDVroDvEw0pjYx8nOw9sezn
 56646O50YHYTgLMjfbGdE0Tv6lfJK5LLJzDOIhptEmARXOgj2AxLzDbbAJK6YGtIoFccirWkFnr
 TFexCRzM3ubTbYWbhEvVS5FpMZhl/wZD0T/PjYn3EkmIPTHXbcDRXPfsz/SqgCWKU9WV0bFCvOA
 a0eDSBtBXwyvNqFmMymN6rWzntxehiWvVEmi6mBzJRod30XDJaudTBAostQ3lHAJ37oSrb+2X44
 ErFBrDlj1Q4uQ05V+DXKli7OZdgyV/Fy/ZBEWGMbrnPU550dsrJzhxlPdVIldo+6irhkc64MAVP
 c/H/t1pTpBcglmQftdw==
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=69e5c3fc cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=GfYcMVghsOmS6C78lsIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: xAMRFbYTH2GrdgSPK50UFuOCD_NedYsR
X-Proofpoint-GUID: xAMRFbYTH2GrdgSPK50UFuOCD_NedYsR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200058

The runtime PM functions had incomplete error handling that could leave the
system in an inconsistent state. If any operation failed midway through
suspend or resume, some resources would be left in the wrong state while
others were already changed, leading to potential clock/power imbalances.

Reorder the suspend/resume sequences to avoid brownout risk by ensuring the
performance state is set appropriately before clocks are enabled and clocks
are disabled before dropping the performance state.

Fix by adding proper error checking for all operations and using goto-based
cleanup to ensure all successfully acquired resources are properly released
on any error.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/spi/spi-qcom-qspi.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 7e39038160e0..8496c4a9f642 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -818,20 +818,33 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 	struct qcom_qspi *ctrl = spi_controller_get_devdata(host);
 	int ret;
 
-	/* Drop the performance state vote */
-	dev_pm_opp_set_rate(dev, 0);
 	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
 
 	ret = icc_disable(ctrl->icc_path_cpu_to_qspi);
 	if (ret) {
 		dev_err_ratelimited(ctrl->dev, "%s: ICC disable failed for cpu: %d\n",
 			__func__, ret);
-		return ret;
+		goto err_enable_clk;
 	}
 
-	pinctrl_pm_select_sleep_state(dev);
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret)
+		goto err_enable_icc;
+
+	/* Drop the performance state vote */
+	ret = dev_pm_opp_set_rate(dev, 0);
+	if (ret)
+		goto err_select_default_state;
 
 	return 0;
+
+err_select_default_state:
+	pinctrl_pm_select_default_state(dev);
+err_enable_icc:
+	icc_enable(ctrl->icc_path_cpu_to_qspi);
+err_enable_clk:
+	clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
+	return ret;
 }
 
 static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
@@ -840,20 +853,34 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 	struct qcom_qspi *ctrl = spi_controller_get_devdata(host);
 	int ret;
 
-	pinctrl_pm_select_default_state(dev);
+	ret = dev_pm_opp_set_rate(dev, ctrl->last_speed * 4);
+	if (ret)
+		return ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		goto err_opp_set_rate_zero;
 
 	ret = icc_enable(ctrl->icc_path_cpu_to_qspi);
 	if (ret) {
 		dev_err_ratelimited(ctrl->dev, "%s: ICC enable failed for cpu: %d\n",
 			__func__, ret);
-		return ret;
+		goto err_select_sleep_state;
 	}
 
 	ret = clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
 	if (ret)
-		return ret;
+		goto err_disable_icc;
 
-	return dev_pm_opp_set_rate(dev, ctrl->last_speed * 4);
+	return 0;
+
+err_disable_icc:
+	icc_disable(ctrl->icc_path_cpu_to_qspi);
+err_select_sleep_state:
+	pinctrl_pm_select_sleep_state(dev);
+err_opp_set_rate_zero:
+	dev_pm_opp_set_rate(dev, 0);
+	return ret;
 }
 
 static int __maybe_unused qcom_qspi_suspend(struct device *dev)

-- 
2.34.1

