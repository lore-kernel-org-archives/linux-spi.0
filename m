Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8B2E541F
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186529; cv=none; b=SlYdf/xhK5k+P5wL7qYz+trXAUy0Fa0+Caw/9knaBf3RbmEdUw/wvB9w0Zc3YpYCy3GUANaGu9W0mfmHxSyO9dganZV6OqKrT14Ppi61jablJcV2Kt/EGhWYjYGbzFBQ9BjaYtedOLFlHtQrEFMTUbR6INSQGCmwDk4x5Z6YMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186529; c=relaxed/simple;
	bh=nG3HGLtKAAk6JI8ZPXSU1m2OMN1KOTGzF+vXFrB2bfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qjfPkUPAbDYv2GROMU/PIr469autwz1hghWOJ3Nqtcpbm1eSKafANUDI2iTkl5OT4lsocZxUgS+i6TapXNXIXgUfasdWs7Qnd9BMlUa3zQkVo2DC98U1rvw9PqpCKfNVoA8ICLx7k07YqApEcho/O2wW1mLDHJ665oWrCbKcJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mLOOyRpB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LWROhph1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mLOOyRpB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LWROhph1"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ECUQff967261
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wmgIZX9kqMP1Kel1luzD38WggWBRb6Y5G8TMEPPawwY=; b=mLOOyRpB1HgTUtUV
	mHRy7RL4O2GFBN0mw4O9LcmtPlXUrVSK94ggV5lx6CUF9IDJD9Gy63zZdVKKJIf3
	Afluu/mIt6OnnUTI5X0ht57k5CrXAq90wCmpDtG6nlsZKJkdAHbQQiiZ0n94C4gn
	29HywD+dXSPTw2rxhjUOTI64WdGTD8Sd4uRSNUwlnAen9NcmLje0N7t2hkDkNGdD
	nlO1XGjOR2ntpnXvFWPG/6Ms0S++vgOqy0Z2EjHah6BuAGkPVkLkA+yq0KOzFNO+
	XugDqxTwJ3vTKCL87Zh6HBbPvVrhF1OXvie7Pdxf0S7hhMvf6irCVVJwBC9ukv1n
	9LSEUQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86v3nrf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:08:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b465bf993cso19285955ad.1
        for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776186525; x=1776791325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmgIZX9kqMP1Kel1luzD38WggWBRb6Y5G8TMEPPawwY=;
        b=LWROhph1QRIkwKIdmESPSZ29cFuiBGPkYI7hlSaG6tSp/8Jbo+kavzU+H6KPHtOFFz
         jsY/QuCqytJuF35mfatpjSpQ1eSfNQkXSod988J9A2v/4vOFmXtITTFaPbRjGPQHkktZ
         rfszeKyPlhq1iNRrimXnVeCYnpp+jzVbFhJtWM4+rGcL0xEIZKb0H5I9mdHXvKTWq6OQ
         z+nKxAhBfZIVlmUIi8YUYIfDPq3v5An+Kmw4H0eM8nRe/EIun6fpjTibryHvteB9Qesf
         6tagl9OEX1ZdgU4NfDwJjqhAa5xLaV2PdW1ynrxeD3GUDVFQOAVIRsEsp1GqUyTg47RD
         ZRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186525; x=1776791325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wmgIZX9kqMP1Kel1luzD38WggWBRb6Y5G8TMEPPawwY=;
        b=P7q+YAMvseSql90TGhu92Smu4qn/lvoke7XrTRNGo4DmGcjggbq0njZTbBiZE+CtcQ
         E7FZneDAeGK+eYhT9YrX1KLSk3xxVSqkbHu3uL+ak2Ec71ef7L14OMq7eE9d/s6Eup18
         H5846AyR2YT6PPLO3O10z0IS7idKhhM0YD9DGdl8+VjJH3pBvALbaQ62eLgrjxEYiH1q
         uqPcIZ6+H5VZxgIL15bHm/JxzYLiYLlCyAAq2gjbX+xrnBB5/aMVWn9Y8Pyv8HpTEAFI
         YchlBwudEGiNU1LxtrEuxYR2UgYpZQNH1A1kFMFXpUvIJFHtS5413jjV9Ameqdm9Nb4F
         AyGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vYcX0hdmR/JA0Z7Zz2HU02uohCCdPnQSySi6vqnF+DkO+knTnvS4AndBlWkQ08kR45ghoKYxgx0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl7LxAU4WZPyVzDbHcOXcYJ7MysQrLEVhEdO5D5bIzYk1bnsQm
	OTum6NW6vkjqCouIGfdMAFx+thivk/K6GaTWU8c/gINPTmuuQtLsQhijfHhaYNEPyExXIXr5JbK
	0/BNi2lE8xss2LyvdalgJezO22yJ0wUHDe/gV5hePQ+624bmP8Vu24nFqQusbDkIAI7sK9Jw=
X-Gm-Gg: AeBDietJjlywmW1Xrwjt+L0JjUOiNvtdImaP/2lkqLNDrWhF3M14pYKF5r2+g/Jd7ZC
	V3AdmMNgDeXkvBsEIITTPTs9ogD1vIXiMoHJI1k43AoC6ocWL/9UgYiZyDMEGBi7vXxBjj29bJ1
	vKC38g/yA6bsgd8Va/mUP4zNrcEfNajfXyTlKvSS+aGlFpQsi2PjR26u4HleuEuJaKTEJM6Ij4k
	4gzs7b2WbNqakgoxYZXN7I0fWqweHwI46nqnavmSt7yMKjwXXhZVm4z44OvcxiaZooFDEgtQwrS
	i7rQHF0IZlc3s0Cstw1Jc6x2A+qhycS20jebtkdgtut0cHehImQaW84ksF/V0pScYIrZ1hRwg6m
	iyWIpCJ6kreW1bFSnBW2/ZRfuknNAdjGH4rsiKp9L7gffVAASv+dZ3j0mrCElDtHUrP9P
X-Received: by 2002:a17:903:2ac3:b0:2b4:5df2:ebd8 with SMTP id d9443c01a7336-2b45df2fa77mr80727165ad.45.1776186525518;
        Tue, 14 Apr 2026 10:08:45 -0700 (PDT)
X-Received: by 2002:a17:903:2ac3:b0:2b4:5df2:ebd8 with SMTP id d9443c01a7336-2b45df2fa77mr80726625ad.45.1776186524861;
        Tue, 14 Apr 2026 10:08:44 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45d1ab540sm97535225ad.40.2026.04.14.10.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:08:43 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 22:38:20 +0530
Subject: [PATCH v2 2/7] spi: qcom-qspi: Fix incomplete error handling in
 runtime PM
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-spi-nor-v2-2-bcca40de4b5f@oss.qualcomm.com>
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
In-Reply-To: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776186510; l=2901;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=nG3HGLtKAAk6JI8ZPXSU1m2OMN1KOTGzF+vXFrB2bfQ=;
 b=31644fZHVoQSXMrcYnJW71B4KkmEd7vugysgBf0qD9Mv0ylYtPuBiwaqFomH252uATFdCyovW
 I+nIxsM0ftwDU2ceey1RfNMC4UeeWupbwR5PlwqCLgPxAIxIFkjjose
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2MCBTYWx0ZWRfX6rFhAqVF7uuy
 Ou5krbY7todTEJb6SlvfGdIo98rZteh7Jpx2LdLqsKmQ2REzd/Wog0MZF6As0Cr2VAVBlaxnHi0
 L8+qMW0ANzmO8eiLgwKPyxLACuWWHDieex6kKDRpkaj3h3bxqNb1C4tTtWOxGnv6i+ZcRZnegvj
 wnBpZT34yYuCcS/ShecZL4/z56I1iNZ8fgiRoGd5GnOAPO6CEgUzoeAZOCvSSXL5zYccK4JmSNj
 WCPQSxCm+xTPFblnQGKU0g7RkzFRYRYDnEaVvMUfV2Rt93FGnhAm5tpXRjWe8fsScpZgC0GWzSJ
 +/ZPZielVx9jCYXKBUuiuCCca6sEuqqksZob7RelIZ79uYwUaDUrMgu+ihtT1zDOFw0gpqtDde4
 jL6uF7qSg9WNviy7yNroZqVHnH0doAjA7hg2i0JFMm9Di8ApnGaa2zWAcFssnyTaV3Ydujl/fvb
 LpSSXNUTVYUzTF9FQmw==
X-Proofpoint-ORIG-GUID: A1HsMOetcWWF2ppxlU5DyJ4A6IFY4Sxw
X-Authority-Analysis: v=2.4 cv=Iowutr/g c=1 sm=1 tr=0 ts=69de749e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=8HTBTZp0RI7lF_4f_zEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: A1HsMOetcWWF2ppxlU5DyJ4A6IFY4Sxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140160

The runtime PM functions had incomplete error handling that could leave the
system in an inconsistent state. If any operation failed midway through
suspend or resume, some resources would be left in the wrong state while
others were already changed, leading to potential clock/power imbalances.

Fix by adding proper error checking for all operations and using goto-based
cleanup to ensure all successfully acquired resources are properly released
on any error.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/spi/spi-qcom-qspi.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 7e39038160e0..38af859713a7 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -819,19 +819,31 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 	int ret;
 
 	/* Drop the performance state vote */
-	dev_pm_opp_set_rate(dev, 0);
+	ret = dev_pm_opp_set_rate(dev, 0);
+	if (ret)
+		return ret;
+
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
 
 	return 0;
+
+err_enable_icc:
+	icc_enable(ctrl->icc_path_cpu_to_qspi);
+err_enable_clk:
+	clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
+	dev_pm_opp_set_rate(dev, ctrl->last_speed * 4);
+	return ret;
 }
 
 static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
@@ -840,20 +852,34 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 	struct qcom_qspi *ctrl = spi_controller_get_devdata(host);
 	int ret;
 
-	pinctrl_pm_select_default_state(dev);
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
 
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
+	ret = dev_pm_opp_set_rate(dev, ctrl->last_speed * 4);
+	if (ret)
+		goto err_disable_clk;
+
+	return 0;
+
+err_disable_clk:
+	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
+err_disable_icc:
+	icc_disable(ctrl->icc_path_cpu_to_qspi);
+err_select_sleep_state:
+	pinctrl_pm_select_sleep_state(dev);
+	return ret;
 }
 
 static int __maybe_unused qcom_qspi_suspend(struct device *dev)

-- 
2.34.1

