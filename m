Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D63B995E
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773636; cv=none; b=DLI0xnXbDoh7mvZ3bzWWXNN1yR3KPDVesNlaPr42P3ZiD6OMaWX3/AZkbZ36ZutQD+XhOtirDDG5psNjElS/a6SgvF5kfzZfAmIX0j7qK0rPfgueFxwQgj1mWlVrx/YLa67JO7vdAj2h/Gd2Q3soYoCCUID7AjaG6qsblKnT0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773636; c=relaxed/simple;
	bh=/txVxAvLF9aMAGkR9CXzGeWqGotHA5mWrN9Q3pLZeUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7xXlI3K4WN6QxRYxUZHTHPMGLR+AH1dyuhFcjHcZEQA8Trc98g7uuQnmISdex740H7Ev1mY1U0eIO5C1rxZS/7W5HMxHbUwTn+sckZNLbLZVIMQXIvwHzMEAipwhGaGN1vuY2tvLcFCAqUZfOylYUsjEpnJWTQz2Tsv7VG20p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZSzMwuFa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZuTSjRjk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZSzMwuFa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZuTSjRjk"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I92meh1350145
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FNTRNEjUl2bB1SNxPHc/nBXY2g2gOYZl5SKxQ13yWaY=; b=ZSzMwuFabmz+Foca
	YJGRHEaoDe9xSh5MWdsbu2cyVGxP5SsFiLiVC+7DPUwyxMpXjp01PkxCQw3FTisL
	LRuTa6qiUKFW6G5ZQt2LKWxAJAtreiZNESjxPQuoNwbferRxZsvbgbtN6Eo1B31o
	o29kCqt4PJ+9PPWcQOBzI5qjfQZb4IgZWVQdfTYv1a01BIv1LNLYXC/Q+ImtVCzt
	9Ob/FFGmRoQnKZYxivtj3yGXhdnuBt+7p3rHG4SJyAQJw++SCUctiaMwcaVuZv2Q
	zmn2NEblxvM8yOd1cv4DUNpPerwLlokwryOtdRoPkzijmbcOm5nPblciOfCrXN1E
	k5mekw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jutye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:07:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c891ed872ddso515154a12.2
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 02:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781773630; x=1782378430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNTRNEjUl2bB1SNxPHc/nBXY2g2gOYZl5SKxQ13yWaY=;
        b=ZuTSjRjk1KOqohHEryWUU2K2N56wsQg/z/e3nX3fYZzXrB9pWqhxtARsN+W4xLqfHJ
         VHSSisIj4M+x+Vt9aHT3+RoL8Pqb/iVGjYspTto65rdceqm5w3q37FeAe/UMokLG6T+2
         N8u3slfvgaeHgBpGtzJNwb6TuEffX4wSRc5CGYKAexFqAkK+0a2aLW8LTIohKjJEnGrP
         7A9ZYAc6wGoM3L6vvb92MXing3mfaStIu+zueNB5PBsaRRMOkAlcz/A+pnyQft9CakJG
         GwQQnRHmj7poVUTrmP8EiyyJU9+zRPMfk7CONeNhDmjUa1ehLvtjLgKLDxg9YIFOzGBH
         q2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781773630; x=1782378430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FNTRNEjUl2bB1SNxPHc/nBXY2g2gOYZl5SKxQ13yWaY=;
        b=iA5lg34PUHJraLCfR7F5pBdAORRs71cjlHBgWiTjLggGG1wQGzNvXj08ZF1gEK/M9q
         T9k9VFg+HYyLH7sNAEOU/MTb/e8lMmP1hjqBZQzn5nI+fW+19VtB244qU2OH4+eyEMmd
         IkGFn5XwqAWNf+AgRiRoSbzi1QVrPHJhXv9FREQvX5mGj73rtfnAZ4K1U7BzN++gIwcm
         /4bTj46Pnap/Q2ik1J7B2SWFBeDREXFJbVG0VE9rWbQ13UcPAkgo2r6LxA6olqoc/0jx
         mKtvqEYVc1v8AKbi58+zssgq+ZLgsQrE/vHrUWLpsR2nVbWMBMx9adm78QFGv//BDbZ1
         ABIg==
X-Forwarded-Encrypted: i=1; AFNElJ+2zkKp5PZtnDcoyB8EYnLeEW/zPhiFHe0y/o+K67yKiTwHvWLG9BzUoJnMDPpvJp+hwf4i++katUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwugfatVDgGH6+KCX0coBZ4CUoA/189CxEO5CNv5RpMAIkeb8mT
	+7NF4qmbbC5+wCuWaa3Vp9HktAefbROfvxgXVXQAduCGXbPUEiLqWfCkvp/Oy8GD9XqogJskD6g
	xgYuZ6urSAT6PJjm0xkNZG3a007XVPbohIIODhZ/gQK+xYc6mcnBxSwr4OfxL7nc=
X-Gm-Gg: AfdE7cn9S1R+i7wMhjYNY874Ukb/tgLJ45xfEO/XYbFsWVXO0kwEmC5J9cOx4LxqJSx
	pDQkYznp5sQ2lw6zU/YqhREOA9ADj2Ge53EnV5yMz5Za+EC9ljdfWqursViZ5dtgeZnpLwnR0ID
	6sQaM5l/cdD+G/MErmzDwhvcm8eiITjehJDDdujjdQ0hhk3CgEp+3PpHnxXHdN5UKF4FRnkqvoX
	PPdg9e97SdPJMzszUv5KqPC/9xkQErC/wT5+vRQSnqbdTu0FQ9Hmyn0GbJ+b6KhNxU59Kcu6aU4
	eX9qb8wB05E9f7fJL9r+0Bqc1F2Gpe+A3BTAlUjQChlc5RfEzBte1joeV94u2BhGTb4J38JVwI5
	owEk6KVfJh9fpz8V8pdYb3hjebVUZ4um77TiePKX+hXEi
X-Received: by 2002:a17:902:f790:b0:2c2:21e9:5a7d with SMTP id d9443c01a7336-2c6f347dbc7mr20749685ad.34.1781773630397;
        Thu, 18 Jun 2026 02:07:10 -0700 (PDT)
X-Received: by 2002:a17:902:f790:b0:2c2:21e9:5a7d with SMTP id d9443c01a7336-2c6f347dbc7mr20749005ad.34.1781773629882;
        Thu, 18 Jun 2026 02:07:09 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac794sm192112835ad.46.2026.06.18.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 02:07:09 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 14:36:41 +0530
Subject: [PATCH v4 3/4] spi: qcom-geni: Use resources helper APIs in
 runtime PM functions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-enable-spi-on-sa8255p-v4-3-f5b5067e7e1e@oss.qualcomm.com>
References: <20260618-enable-spi-on-sa8255p-v4-0-f5b5067e7e1e@oss.qualcomm.com>
In-Reply-To: <20260618-enable-spi-on-sa8255p-v4-0-f5b5067e7e1e@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781773609; l=2053;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=/txVxAvLF9aMAGkR9CXzGeWqGotHA5mWrN9Q3pLZeUQ=;
 b=XlCL9PArLwZ+b4O6accMSjXrsls6A1CgsKC/2t4RXFFnqwlual08eHzfbWc2FWVDll/pB/6By
 7+lhi25hJ1gD9X4x/vC/oXmZXeC3rnqwZXxmsXYcM/sEom/Ct4RyfGb
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4MyBTYWx0ZWRfX24i6dfMaJCla
 28mnUzSjHmajYAvkTRBDgttwYSGAiRArF/eYWn0Oe2LwhE95TJXo+uSPfJz55bQCgwhYeK7y9KL
 mdZix9+PL3LU/SUUXXB7U5utvbN4U3MPJLbFcI+xMB8o++KgyI9DoVRfI6uJrPWznc2wHFQjlyn
 UgFyRMe8aE6tqXz3nBjJrP0zGjAcjFMLtPjDudQCgwAHoJjVZ3SQLVtcJjbAw1MjvQXfP2H7AFf
 JdeQyfo/w3NzHusDakNPKl0zBj9Eat1QTUXsBiiTPYyH6Ly804683vnawGqG4sNyLbHaCzwoVcs
 61UBP4wZXd5z9ZdC+tZ5/dPwZzFnW/nEHl2PVJJwii/AhsfBSIGCbnuQ2YU+3QodTeX3z11M9Xc
 ZGiKb88UVGAyWNMkGvcHyfbElyG99AeZ/CNVPPZqpsB/iFjuwHd81oZwGKXAJW5Gcmq+6wzqswt
 64YHtMlDTgs1o+hGWEQ==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33b53f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=i7xoKaWEWnc8ZE6DH4sA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: iBUbPqMREMePfpnfLpE0is1hFr8-gDl8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4MyBTYWx0ZWRfX64ZBOt49G4eH
 hbVhF/HGyojkIkduvYIf1yHd3wHUUYUK1fH/vPjJ3PYTqEXnllbAXGm8U7AqFYGiCvOnLYO6049
 dWhC98W39tfUTIatylEcTPBcFdtmMsU=
X-Proofpoint-GUID: iBUbPqMREMePfpnfLpE0is1hFr8-gDl8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180083

To manage GENI serial engine resources during runtime power management,
drivers currently need to call functions for ICC, clock, and
SE resource operations in both suspend and resume paths, resulting in
code duplication across drivers.

The new geni_se_resources_activate() and geni_se_resources_deactivate()
helper APIs addresses this issue by providing a streamlined method to
enable or disable all resources based, thereby eliminating redundancy
across drivers.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 09feb6577efc..025165c4b952 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1130,16 +1130,8 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
-	int ret;
-
-	/* Drop the performance state vote */
-	dev_pm_opp_set_rate(dev, 0);
-
-	ret = geni_se_resources_off(&mas->se);
-	if (ret)
-		return ret;
 
-	return geni_icc_disable(&mas->se);
+	return geni_se_resources_deactivate(&mas->se);
 }
 
 static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
@@ -1148,15 +1140,14 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	int ret;
 
-	ret = geni_icc_enable(&mas->se);
+	ret = geni_se_resources_activate(&mas->se);
 	if (ret)
 		return ret;
 
-	ret = geni_se_resources_on(&mas->se);
-	if (ret)
-		return ret;
+	if (mas->se.has_opp)
+		return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
 
-	return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
+	return 0;
 }
 
 static int __maybe_unused spi_geni_suspend(struct device *dev)

-- 
2.34.1

