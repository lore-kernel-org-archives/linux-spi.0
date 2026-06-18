Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9EA3AFD07
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773629; cv=none; b=qd8V8V8nU5W7zZdyWHAZM0XMN7o7+7VyUY5M25KjSdgPln/mM7l3RDV5zUwqlOQQBhJhjrOr9Fx1Zek8A7ahFZqN0nM25xL9i7UbHCcReMNoj/s+VfdhzScIaeEhWtHbJP3meWAOq5/x3MnCl4ran78V2HoCf0dFeEVs7JeBi3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773629; c=relaxed/simple;
	bh=9YWKqHG9h+azs7B5xT1AGSTkv5a4OvLQRAny2OdFtmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KhCpJfVH2O0GTCKap7rXvmWNcvJ7HrBDaKckwN0FmlgQZ5XPPwiUGYcvpvOaGD5LzY83sKAF3U1Mc+EXbo6XvOJuDIm8s8VSPoQL8ZwWkZXL8gIbxcXugcsqgtilXkqf7AFykc+Xezc5S3ex+pF6QkWKdAJhsxcb6DS/c5puUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ab9ZY0S/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TTPytgBp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ab9ZY0S/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TTPytgBp"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8G2Bm1253181
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Czs6WvmW4eC+XZ3qTBqPqvwU0TrJ6OjIZ+EZ/8XjiU=; b=Ab9ZY0S/VgFjCrwy
	aWBhllKfjuhMjFY+8zxesXfn5PDrVrNNrjgAsaR9gLudSHLGHB3X4mMR7SRZVV/V
	U9OlqOrfn0mGdnLDPNJBEz4kt2Gdm6k8co8cph0BoRyXnBPUb5RcW21Ri0vPG0El
	Mqhm95WPmppQjR6MfVcfGaO3ICQCd+AMjdQYuc4jhpBpwyh+4rFlYiFJ5scMvUVz
	TBKbDoPaBM+Qgyzuw1/rdVvgHzv5DqtMYf2on+rt7ArEgQZSSSzw0CxCnJmhD4k1
	DhrJ1DDQK96JU4/fP8sAYtogTZ3qvowjf2hSkJpvArHWHRfK3hiRUGE9+QE/ibWf
	Afo8hA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7jww2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:07:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c2d0a8b5beso10122215ad.1
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781773625; x=1782378425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Czs6WvmW4eC+XZ3qTBqPqvwU0TrJ6OjIZ+EZ/8XjiU=;
        b=TTPytgBp6hnedSG/5nOIg542atSsNLcNZHF11K2fKDQ/iEZ9KppA/z6U8cGairy0Q9
         4Hu1qY6I7g+RzkK433bOT+xM4ue7DJgNiuinjb8LsCHHs2gxH5ybBKaUsKD4h2lraY1i
         gDpUEkvy7KfWJaxCy1ET0FWLOqJP0Bi/7ZEIv7RHf4Chb2T8i29s60Km8ycFOzBVRFyL
         w3dPna6g85/H3IVhO4RzjkVyixyq+ZrDAd89yxAN1Q1hJgwIys6K5AaeYjWfrzAEOIUY
         59LCLt6Q/Ay7d2TEPbl4A4oXYJnFrjP4SGxea844QWLqnzz0JTmAXvI0o//aq3oY4Ju2
         wvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781773625; x=1782378425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Czs6WvmW4eC+XZ3qTBqPqvwU0TrJ6OjIZ+EZ/8XjiU=;
        b=NeeYyHmS1r+QI5zcECe0Okoy2UsWVA09n1jIog4z8tmSov7QyQLhxgsUvEPqv5GZ1D
         z4K7uaDW+eKi+vVxBqfwNqfd9wmloRodI72rfifXoQLpolEYd2hDGX8ZYvlgybzNX0it
         mvnxhnqsQxVTtL+KX+Kn2z/+uRt4xtthnnzhbqr9LPgY/zyN8TExsrsiBHJ60jIHSl06
         iwrEFzRXrHtaFUaiWW5q9ZKsd+OHoI4fSIeRuKUqn1RI+7s79LaPiTBHT3Nt2HzQ3OdZ
         c920eoz1Kft/NZaxdBZqXtplOUC14eIZx64taUCu8qH4kUe4I3NORxO0cSlaWtQ/IgPd
         e3hw==
X-Forwarded-Encrypted: i=1; AFNElJ+WGoPhS+XLD3KSqovEtKHaCKEJIckOvCS3UR/0ELndzg5RMIAku/2SCWW9vw5kG3kajiRIMQtFsO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8hA9KKQjyb5OZpsFJyVyGRRHL0vQH11qzpxXJGeb5i1wey3s5
	HPriRF4bhb2PLJOOrrvizgBwIZBN4rnoK66NsC/0QYqzPELmUP+wqm6v2IqpLAPKd6uXaASrvn+
	+lsCe1MEbmpF+rG0VJzVb7uMwarEUWcm7PIwPdsQvHzlR4A0mdsdf65RxbExnSsA=
X-Gm-Gg: AfdE7ck7V4ahyhFKVwr3BgPq3NiRXEIK7R9uG/JXbxCzahQtKdcjKJMSX1c1MfiDmpE
	ULQKpUgBqv31dw8MFzlL1s0+9olka8TkyPNr0TvzzvAuocCCuDSqmVIqedx3r6QLDADStqTsyq+
	Q2Yepu0UCgSNltr+PjRq0fgM9il8+pNtr0U8W2XY6lvOwnENCpP8OiCQqlnZfzUl3jdiJPWFdrn
	e4Sfh4qrUQ08SIR7hFji3m7zCLxS2ja2yorUn8IYsswHenEnEnzgqgqfYcz8Pr+eU3qzOFfTxsw
	GUcwVNluu28mPFbJLXGZpj/ogS0+RQ8XB4SbBigseqlVOmD9q1MPVo3ZVrbmo1T2veogKPNaxxj
	dzK1KTvw81MVGP/+WE65Q+9cMHFaREf+cCTaQTeOd8OyU
X-Received: by 2002:a17:902:e844:b0:2bf:2015:5b94 with SMTP id d9443c01a7336-2c6f340c894mr18082565ad.3.1781773625456;
        Thu, 18 Jun 2026 02:07:05 -0700 (PDT)
X-Received: by 2002:a17:902:e844:b0:2bf:2015:5b94 with SMTP id d9443c01a7336-2c6f340c894mr18081975ad.3.1781773624753;
        Thu, 18 Jun 2026 02:07:04 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac794sm192112835ad.46.2026.06.18.02.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 02:07:04 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 14:36:40 +0530
Subject: [PATCH v4 2/4] spi: qcom-geni: Use geni_se_resources_init() for
 resource initialization
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-enable-spi-on-sa8255p-v4-2-f5b5067e7e1e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781773609; l=2697;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=9YWKqHG9h+azs7B5xT1AGSTkv5a4OvLQRAny2OdFtmg=;
 b=J4I53N1i41tzyPhhs7ATLMiLulNR4q3N5bXGGJ7vdCNkUxLqQrvApk0P5NSUI0hMVkZBGVQNs
 EeqeBruvSUzCMou64jZwjB1ExfXxtj9Dt5F6GnlliksNvvmFimAiG8/
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4MyBTYWx0ZWRfXyys3ubVhZ+2U
 a3U86oA8kTWvS5PSxdmHaUt4mDiEAUGXhdxftDLDGQjjDzyW8CgS4pBGMxU742NmB/aSn+/XtOo
 rtkrtVLpiE/35svZnGS4msngAoe8ShE2Y1fTYleUw9pibvkpXz0S0h69QemGqDbIJoSMvnOlEOW
 B2EP/RDatYVJJJSDBvuCR6GDDmfasuEKKijr55iFKUvd51Ho93E+e4xVCS42aYNQI0geB29JmWV
 HGk0SBXLzH4gYCPfdfIJXmbc7+vQc2N9UFnqbmUcfycg5o/NXclnF2NDqEOsIQf+dkELAT6sEOt
 fBtkvadWyKmZxh1sGrJw6VfujZVJQkuEuJoOq398LLZV4wO1TO0ziONj7FAgNd4ZNBGbVfKg8/V
 eRBwzxzhVNqyA6Xzg09OOSgX8sVapVmGm7rji7f7h7G85NTXmOtxyEZ/tDbHxDol0iaQ8lvSoj1
 BlVcPNRDBKPOe/qW6Ow==
X-Proofpoint-GUID: wMO_WmuTsnF7ykmfSW8TXO3OYzKO5Cy9
X-Proofpoint-ORIG-GUID: wMO_WmuTsnF7ykmfSW8TXO3OYzKO5Cy9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4MyBTYWx0ZWRfXzDJEFwpP4eCH
 JF5oyMV+vhzBywjFQFBAVheiLbxk5GVCpuXd0xH70GhDBi+4j4tXMuso+b/D9s50ibgZID9bE0z
 UxAUeVgD5C6wNY+J2JcPRPlng8f9238=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a33b53a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=TXo2QnZ9t29hVJcr6pMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180083

Replace resources initialization such as clocks, ICC path and OPP with the
common geni_se_resources_init() function to avoid code duplication across
all drivers.

The geni_se_resources_init() function handles all these resources
internally, reducing code duplication and ensuring consistent resource
management across GENI SE drivers.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 26e723cfea61..09feb6577efc 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1045,7 +1045,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	struct spi_controller *spi;
 	struct spi_geni_master *mas;
 	void __iomem *base;
-	struct clk *clk;
 	struct device *dev = &pdev->dev;
 
 	irq = platform_get_irq(pdev, 0);
@@ -1060,10 +1059,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk = devm_clk_get(dev, "se");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
 	if (device_property_read_bool(dev, "spi-slave"))
 		spi = devm_spi_alloc_target(dev, sizeof(*mas));
 	else
@@ -1079,17 +1074,10 @@ static int spi_geni_probe(struct platform_device *pdev)
 	mas->se.dev = dev;
 	mas->se.wrapper = dev_get_drvdata(dev->parent);
 	mas->se.base = base;
-	mas->se.clk = clk;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
+	ret = geni_se_resources_init(&mas->se);
 	if (ret)
 		return ret;
-	/* OPP table is optional */
-	ret = devm_pm_opp_of_add_table(&pdev->dev);
-	if (ret && ret != -ENODEV) {
-		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
-		return ret;
-	}
 
 	spi->bus_num = -1;
 	spi->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
@@ -1115,24 +1103,12 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (spi->target)
 		spi->target_abort = spi_geni_target_abort;
 
-	ret = geni_icc_get(&mas->se, NULL);
-	if (ret)
-		return ret;
-
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
-	/* Set the bus quota to a reasonable value for register access */
-	mas->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(CORE_2X_50_MHZ);
-	mas->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
-
-	ret = geni_icc_set_bw(&mas->se);
-	if (ret)
-		return ret;
-
 	ret = spi_geni_init(mas);
 	if (ret)
 		return ret;

-- 
2.34.1

