Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6834DB6F
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094625; cv=none; b=rODRZVK4eKW1QWYCzpSQUP0avFr5xCJIypTYhGsckict/a+dkP77gmBzdAjPIM+O67/ISybyS8DFX2kDD1Gvy0KnvP0f4m8nuJf9wWJY+VdHcjIsnPs52Dck/oMjbAwERkhTVWu5vGAdsIGFVsn0LZzXtQmXbhhWtE9ruknKen0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094625; c=relaxed/simple;
	bh=wRMlMUOjNaNt0fRe8bIGnbbQF2FAo1GXnXeodrX1dvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qg2aNgwSKe1EUT6v2zFAyoIEQEVN+OoYiEAnvyifwPTBbXLe7vjT1nHsmMGEItPviFWC1e3P+Be5Azh43LzA7oxMD5+K8ppT5HlqtgQiEoOO44jcbc8stFdud0zDC7oQwORugD5opRz3M0hILs7+lBixpUl03XFIkUY3S9LQGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QzDPhdyg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iDfSyZUq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QzDPhdyg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iDfSyZUq"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M8lbCQ645893
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xyqIphb3PH9
	WrLK8b/LVLC85X+KOkuonBJmPjmbkCOo=; b=QzDPhdygolWmuxVj6WLzmBK0XTD
	zE6RFeebgWQHlZ3BTAoIh3HIikDh9yFOrlxjoUgaxoW59BDSeW9oeqKxAhAENmlY
	WmWvjsuPd7H2o8xhz33VKZcJ1eUsBENfzmnWum4h9ewb49KojXCRIr99vR0L5/MZ
	EvI0S3rGu/4X+SOVD3V9fXD/PFsYIyFg7Rk9UYqZtkU5pQigj4iUxkRjFOsaA2E0
	zAGSmkfK+CVbeT4q1CUaZiL/8XDiv72tynnaB4uPJ76dgHPM2tknWh3yW/JkIPHj
	ij0tiykYYxaGOaIRxQlDXgt9rOYx7dcKmo9M6hno0ISaU4bozPu9cf/lmog==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu8j9tjj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:10:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81ed3e6b917so1150518b3a.1
        for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 07:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769094623; x=1769699423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyqIphb3PH9WrLK8b/LVLC85X+KOkuonBJmPjmbkCOo=;
        b=iDfSyZUqb3Jc62ORRurQZDhusV2rNIIPSkS/yD6njb7oWWX+f+wuLlaAUc6CYuUn0C
         jCID6TYGM+bFX77rChJv0Q8mqIKmF1UZCipSI2XzSz4L4IJEruO7Kx6hvq2vkeTFJ1xJ
         r+c9tolqGJ0MGUot4am42NS2S4ZjCaeoTlmzMgVf18rl9RwKDPDZ1mbWKbzmS6msTa3d
         ciM5R0E9f1Zxy3jbD14DUtpWyPcG60X7+UYgO8dRFCEduZEbJifmLpnr5sLGe2OfSKxi
         EgO8ytzG+D0rJNmmYAvd8lL5TjzzOJq2hGlVRzXY1s3N9eK/c0Fz0gETac/9nfxujx8U
         ADqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094623; x=1769699423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xyqIphb3PH9WrLK8b/LVLC85X+KOkuonBJmPjmbkCOo=;
        b=cUYnCHzvDzuUoVLRSMQJGDzjS8WdF2MjDyallgJmd58FnioEueOS/QM6ejsCjK8GlB
         znuA14+V0FhCuZLCsZ3QAEHLEn1TBuOg5ILBKNMfO4N9vIfVYM1qcCqYT5AbEoMSc2Ru
         AY62roY73GT0gapFAnmOQiBL0dQ3Yyo7xBM4Cij64AL4rNBgi720cAcbBrJqeOjt5IV+
         Sly/Y3EQedxalzwQUxAQD4UAwaJFdHCFywEBB7mO9LrXjugQzJRI7B/1mG372f8MeZ4b
         ZtZurfXBNGg36Y+PduFjRA6z6dFRRBo+cHtpV+VEl5oj45/b65x/Cwwv9NJNwt5tEaPo
         YOWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCbokA/lQ+MK4gUPS84SWly4UN2ObGckbq9ZiA9ibrWla2SNcVoI0U0XFbe13AnK33fe4uBc6UkcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPb6g0Ti6uP3lB2nuUmA8d646uQJIOzU8yocIRZFvM9u2J3V4s
	3uNzFHJGSJMpKcsFrJDekyMKL4p8gVjQVSRqTo+H+HaG3F29p9S43JfSrotIGb2/SQPY9xBjvKL
	jfsbk3jDg8O5Y2W6m9VOUrGHGQrz55DBZV5EoNhYF6R23gR9uT6dBBSZRXcafo2I=
X-Gm-Gg: AZuq6aIpMqyzUnL1VAks2z7sCxuxioVJ90cy+XjXjpMOVeIhgkdCHg9DvK1ken1lRtJ
	YbRWs+iSBKGVYPc0Y3rVY9bc/Y1bfEqVuT9n/ArU3KXfvcyIPFwJ/vTwy0hVneG7Xdc6/YzS9LF
	UxqQGLfBSD9iZvFvH6L5RDOTpiNCsvq0EfeIbHy1CZ9F0hfHPOJGyxN0M0I4soQctEwg4Ry1tSn
	8jrqCXW7nc9CZ3tcncm8yZsghhf6WJXp5z1dt2Qduz7/4HT42YiH10u9HkFBKZ2o2Vy/lh6K6WB
	CHrEIIluWJ+e0mWTgeKUCzCoJyKZ9CZkjckntA0sqvotu/Y3z63tlW87glIcUBarVvPAD3hT8Sq
	fKHX2zze+e+0mXGmdGpLxJO5bKPZo85aj5OOL5nnqyiU=
X-Received: by 2002:a05:6a00:10c4:b0:81f:42b7:e589 with SMTP id d2e1a72fcca58-81fa0354717mr18941132b3a.45.1769094622685;
        Thu, 22 Jan 2026 07:10:22 -0800 (PST)
X-Received: by 2002:a05:6a00:10c4:b0:81f:42b7:e589 with SMTP id d2e1a72fcca58-81fa0354717mr18941090b3a.45.1769094622030;
        Thu, 22 Jan 2026 07:10:22 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8217c258fa7sm4328182b3a.17.2026.01.22.07.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:10:21 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v1 1/3] spi: geni-qcom: Improve target mode allocation by using proper allocation functions
Date: Thu, 22 Jan 2026 20:40:06 +0530
Message-Id: <20260122151008.2149252-2-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
References: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: s9JBDVt6uBXiCE0Sw4_GQ-9S60El6tXr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDExNSBTYWx0ZWRfX0nlNFUx9Hv00
 AwpEIdbI/mopnMc6xnsalL/R0vYihP1wlNIF97wdcsvnSmr5d2/l5xRPaKSaGO62IhyEaCdWAt7
 QIDAsUPccHfSrUdUAo2R+4tt3lptuQEsLccXtPsmdyQPd74Ot62PMxYHAKFotTdh909f2z60g0F
 9L5+MNKpri6kTxE07xudEtInYNd6wK9h6lYL7+bkkEKw8lJpfWWA1XDAMkAyKksvpvBovn+EVkm
 RrjqH48qnOUWtutL9B0AfLQrHXWdRvKfueNCU1d6u1wEEGQsuwNmq5f0C9ze/h/nBu0Xf1t1IdV
 Rj2sjeN5GEuud4Cwff886nSh6eVUIKIYgYsreFt7lnjR4rYvXPTR2STxQY287D8VbNIrzv/1c7Y
 8Z4o+PsaXsyVPlBDvq2dfsLU3qeln6kpjG/hkyMyiAc8T5tLQD/buSoZdfaspvb6b9rGXjKHbKS
 aElstfybEz1HgWZ/Ekg==
X-Authority-Analysis: v=2.4 cv=U4CfzOru c=1 sm=1 tr=0 ts=69723ddf cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Bup7t0bCmiTjNce0pOAA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: s9JBDVt6uBXiCE0Sw4_GQ-9S60El6tXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220115

The current implementation always allocates a host controller and sets the
target flag later when the "spi-slave" device tree property is present.
This approach is suboptimal as it doesn't utilize the dedicated allocation
functions designed for target mode.

Use devm_spi_alloc_target() when "spi-slave" device tree property is
present, otherwise use devm_spi_alloc_host(). This replaces the previous
approach of always allocating a host controller and setting target flag
later.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 0e5fd9df1a8f..f5d05025b196 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1017,6 +1017,14 @@ static int spi_geni_probe(struct platform_device *pdev)
 	struct clk *clk;
 	struct device *dev = &pdev->dev;
 
+	if (device_property_read_bool(dev, "spi-slave"))
+		spi = devm_spi_alloc_target(dev, sizeof(*mas));
+	else
+		spi = devm_spi_alloc_host(dev, sizeof(*mas));
+
+	if (!spi)
+		return -ENOMEM;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -1033,10 +1041,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	spi = devm_spi_alloc_host(dev, sizeof(*mas));
-	if (!spi)
-		return -ENOMEM;
-
 	platform_set_drvdata(pdev, spi);
 	mas = spi_controller_get_devdata(spi);
 	mas->irq = irq;
@@ -1087,9 +1091,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (device_property_read_bool(&pdev->dev, "spi-slave"))
-		spi->target = true;
-
 	/* Set the bus quota to a reasonable value for register access */
 	mas->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(CORE_2X_50_MHZ);
 	mas->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
-- 
2.34.1

