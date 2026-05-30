Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228C3CE099
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165729; cv=none; b=nnkcGvJuc6Dv1//Ef5vOzvF6rV8fuFR1LLgYUGBhARmGQSyWnY3ofgz8DJqjLgpXJoafI84XeuyD2+B0WrUaUGl6zoB38XJhMF90vRwCsxtG4HT3bK2uy+itqosUE9WDMOxvGObnFqxa63lpaiJJtUGuWCfluwqSyNUAKa7Oe5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165729; c=relaxed/simple;
	bh=W/YrZ50I3AwtE19t9pzTiT0xdnQWey3D03tHPf2lno4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=so0TY7ltudphlF/TMhQZTdTX/d+/TIkSAQ7M3IjbEpI21QLSzNSLMUGud8zGwjAQjwzAlaUobZLTcQI3BFdI/44fwzwVCBCZHSuRycjOE5yYevUfO5xM4yz8brJPwWQrapFZ2rl7mI+jLWu5N3vv4yWEJSgqS+8uOzIynHEuL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LCMAEMqD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RIAXzYPj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LCMAEMqD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RIAXzYPj"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEQ1rS3471456
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 18:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XB9Q6X09k8YWO7HfZ3onZiDHCRdqw6sxvgxO5l7nA8k=; b=LCMAEMqDn65Lw2Uu
	5C12nK9JjynGhavVcjoCcDQx8hZzJtKTKsuGr5QBuM8/cqXsMDAcBpi/JGI/WCF4
	zsZNbyn0ByY+6jrvFBz31wKX/DEc37nZ8QUgk5yXU9bX2+lMYVFgzFLzA/zkvlaR
	Cw25uXztEBg7WJ+GbXYZ/HPFhanXEt7NbkdlYL3h7NVOpwj4JgpU/9CTE2AcBk7Z
	9bncQZDcvfxP5kGyhW45H4AV8VJ/+DNQNX3dOV3pnDnxPdt789hH0hCHocyo52Nk
	uXLbWDWOToB6/Vx23aGSF+Tzq8r303VLRndVKJIBrwJETH+0n1uNsq3aAqO4lq+o
	gFUOpQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efr989n3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 18:28:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c36f4b76so687565ad.3
        for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165726; x=1780770526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XB9Q6X09k8YWO7HfZ3onZiDHCRdqw6sxvgxO5l7nA8k=;
        b=RIAXzYPjm5t8X0K4Bhsxb6hwjmZAlAevnYzYItvUktdGVVsIyUFXYn9YHkL+6IyjGb
         kYjTHeFEI7m+BQUagzfPyhxjbvPw7hIq9BD+Q6kM6mHpP0qbvWLugHgCqPA0F4dnSJZz
         oIP7yM/s/6TU+sIR2BX/W7oRL900ooznj+GD+tj4t1+0GXzXMCwCSEeziHfJst2Vf1yG
         qBFU8SyTqJBCw8llYECDfmzIAeoEalEHaDN/G271ylX8cpvDbPGORX6GAfl/elc5gBGB
         1VkexN8f9C2w5VhqjkFepZeXYZFF8f56HfV8foYVmRRnsZ00jhs8dYYis5mOfb14k6RE
         x7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165726; x=1780770526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XB9Q6X09k8YWO7HfZ3onZiDHCRdqw6sxvgxO5l7nA8k=;
        b=CczmXNzz1nIOYphNt1G6bAKq8oeqlxk8xhvNRhUKL7wuOkHddomoNog5Crui81o04R
         uhtRBY5kNX1KApqMrBMwKf15o5WweKt01wlF5yddfZ4cXh1eYzyoft4PaMRfhQBB8ONZ
         6ymSGB1cQUhquEVa/3Lf3cPV5AY8GruxYTXRaFYDtHtRMCDl8YcHbWex4u0DcXSSusPx
         wo2WniEd9rpuIkB/qc0SJOdjzOTpPhk7gcHyb6hGnEzhs5udC527J+DVCuVbK7nxnnMu
         CKxmz6AZBhAWWvAH+YPH3xNPrHaWZGoue7LM1IYe7qqg5ASnQoNMr/aF7a3KM4ZyPrn3
         b4Rw==
X-Forwarded-Encrypted: i=1; AFNElJ/jGB0bD1nuglQ3shIHQD5y4QIdSsJQTzmP6y4uV08jVIuJ3h5aLUoCGjXcjFkagqa8tGdII1xxcCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7OszaxaD0d8OGVLeRer58QBi3jghleogSZ3og2PUZQ8q0LRD
	rSUG0KJcrYu5ou8ocCbpnHLe6FyllpaJAunQjjI6A2RASG5rXHc9txRc9Qe+yPiTzLTd2TVn7yY
	x4T1bf9oIo0ReZNJxZswXBn1pPYru6elqeq3x/h6Q7WpD+dozGBg12vUjlhRQi3s=
X-Gm-Gg: Acq92OFVXCQEU2FB28cJjSHZJVqTFKcGVR6f2qwiXEzxV9NZCehuj7USwSK6BeEF3sV
	kecM00FIU23+u3sGfGiY2vJHZhExMso5Pj5AGNSnXWxOQSFXtJ2TTCeWpYFFcyJldALpmxn1olI
	riwImfffOgf9mqf4n8DKHL7JU4ptb9ERbyuxJGeLCn6/WiOgVMs9Uc99mDtveRtO9WiERXTyr9k
	AI2Uf1/Ja1leGlvB6memJGAnQbnGoYZw11hH+NPCP2CRKitVXG1c1CUOGhpo/2wndWyTZi3BgIq
	/R3M6Zcek5HDSQi3086N4S60ybyhFs/+YOO+9VjrQa3mMCc68MPyVpSq4W7H7Q+n7GS0aoB647y
	aiP5UBCcha+So4jHSWbDjUfzRmqV2u8IFs+7CEBftYdY0mssTh0cznzN6cv1vIyeF9g==
X-Received: by 2002:a17:903:46cf:b0:2c0:c625:400d with SMTP id d9443c01a7336-2c0c6254383mr409715ad.37.1780165726245;
        Sat, 30 May 2026 11:28:46 -0700 (PDT)
X-Received: by 2002:a17:903:46cf:b0:2c0:c625:400d with SMTP id d9443c01a7336-2c0c6254383mr409435ad.37.1780165725616;
        Sat, 30 May 2026 11:28:45 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a27ee3sm56879635ad.36.2026.05.30.11.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:45 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:58:24 +0530
Subject: [PATCH v2 2/4] spi: qcom-geni: Use geni_se_resources_init() for
 resource initialization
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-enable-spi-on-sa8255p-v2-2-17574601bd63@oss.qualcomm.com>
References: <20260530-enable-spi-on-sa8255p-v2-0-17574601bd63@oss.qualcomm.com>
In-Reply-To: <20260530-enable-spi-on-sa8255p-v2-0-17574601bd63@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165714; l=2636;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=W/YrZ50I3AwtE19t9pzTiT0xdnQWey3D03tHPf2lno4=;
 b=voDxlLutIN6+40mic0eO9qaR/zPZGz1TZBw7zkWz5anDER4KGLCy5Q4rtAloZPAXl3KnaFiwU
 UAS85ssC7BgCYNdBqAf/7fBTeMRPoqiLnssi30yj3MkJ5ERBSLd4M7r
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=BaDoFLt2 c=1 sm=1 tr=0 ts=6a1b2c5f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=TXo2QnZ9t29hVJcr6pMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: wgOAmAZgUcl4K2dkjq9yr7c64MyQ-ouD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX33+p/0tMAxt/
 Go1ULc+ik/HD/oDtEn9Nn9Shhb4EhvpfVHEyEt94n1CksLZ5G4nKgpXrUvR+KTq1BYTLhQQcAvJ
 jGcnFntKl+UgyJAsPHsxKalJ+l91vxx9geQmIF8OuLbLArxacHRbTL8R8W1BzKeCiqDKKzvMaec
 WCmZNNl7mZ3jL6JiqaRIvebFPkUrUdl4DpI8N9AG1k4m09GfrQ5kpEfPRWLFe7/zuKueO1lbHao
 AG2/neza9GxuoAz8YelEGQKq5h2xTlbAMRNHkaw2OrzDYwkuiaaRjSF4xR2iMl+cCG3tJtNop9F
 WxAQK3pC+m3fX3CSY7n+h0KTrwWVPl5pRbBv66LcSiwEBIFYxnu1Zg1gst5vt1HgbgEN83cV534
 oQ8/oOSbaTemeBdWbGt5HVwxozNSV1OWdvwMf7HCXToX7omreFCm5F+bey2o7Q6f+7z+o8B8w4h
 Qx37EHTrjgPL+L50l3g==
X-Proofpoint-ORIG-GUID: wgOAmAZgUcl4K2dkjq9yr7c64MyQ-ouD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300199

Replace resources initialization such as clocks, ICC path and OPP with the
common geni_se_resources_init() function to avoid code duplication across
all drivers.

The geni_se_resources_init() function handles all these resources
internally, reducing code duplication and ensuring consistent resource
management across GENI SE drivers.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index a04cdc1e5ad4..333216df922e 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1034,7 +1034,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	struct spi_controller *spi;
 	struct spi_geni_master *mas;
 	void __iomem *base;
-	struct clk *clk;
 	struct device *dev = &pdev->dev;
 
 	irq = platform_get_irq(pdev, 0);
@@ -1049,10 +1048,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk = devm_clk_get(dev, "se");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
 	if (device_property_read_bool(dev, "spi-slave"))
 		spi = devm_spi_alloc_target(dev, sizeof(*mas));
 	else
@@ -1068,17 +1063,10 @@ static int spi_geni_probe(struct platform_device *pdev)
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
@@ -1104,24 +1092,12 @@ static int spi_geni_probe(struct platform_device *pdev)
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

