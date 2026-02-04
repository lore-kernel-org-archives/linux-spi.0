Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CDB426EDE
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222554; cv=none; b=qDT/JyukzM1zKbPcian0gArqQoKp8wLGi+X8Q5sTC9MivpEZfqZbRomHirf8+6a6o6581pzlJdKZaa54jTn9qMF/TiKKEhpP3n13lb+GJnzHwAenvZZDpp0Es4rizNPP5rD+Ejfvg/OQc0h508Ta9wLt2TTStQGseApHax3dpZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222554; c=relaxed/simple;
	bh=CnO4y3VsGfQYxXVySrD+F8oIZqRqy1yQ2U89tkmae5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlHJEkeHIC5Tovf9oK7EP0hh3vsXpHBHtI/mqvoi91+mSre8OTHk3qL1tNV3h6wX0A+wNBcvQiwfVaV4KZj+4iwTkDpoeMUPJzbf/uZsFHKWZi15PpM9wLOEff9+Eg4yb51n4oyvNvNa+ydHtUew5KmpfUUThblRub8l0oIyVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d2mzYk3j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Np1Or0fu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d2mzYk3j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Np1Or0fu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CITak1246041
	for <linux-spi@vger.kernel.org>; Wed, 4 Feb 2026 16:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bIlScLi5z6d
	d33J+kHWnG73XMqR8pPoB5nxdAypevEA=; b=d2mzYk3jH20C7DSbJLn6A3IKv2v
	5xE633sctue/zxNePHgYfthWAV1n94XR8T/ygw7+oMRxR/TJ0LuhI44LEzYAnOdA
	nBGEuz5qh25grtcl6s4FAfWUcNt1JsDRgkZEyq9anvaaofqNXJbNXZZ0WZNNEcxv
	+qMbKKTqcalQORsDkiQW7Pjh6PIirxkTMc40bl+9vPNWg+jnC2QEhJgplVs2YA+l
	iZd54bv0MGGvUbgYUPr/VgXqxfrMHfX5SzL7G2NmswCBNMB2ESjKZhEXq2K/kwlu
	rvFTeuVQw/pWX03pemLbrsouZmiNjyIpCkmSTxzWgwxTEFPhaX+TTw9l1ig==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3ru9b8dg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 16:29:13 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c636238ec57so754029a12.1
        for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 08:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770222553; x=1770827353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIlScLi5z6dd33J+kHWnG73XMqR8pPoB5nxdAypevEA=;
        b=Np1Or0fuuZcgofzLwwOzD8/zFBF+0zSoZ1JQwPWtDz+mtIf15i5EEF8lZNtH7j0Hqc
         /zs8gaWylnVtQ8H8r8+YJFIBn6iCqpWolMNq3uRBDpXXom7Y/xKM+3yy3N9vhoULFldN
         PKN7yW9/pOfMMeshZ3NvNlaWCxc64cP1B4WcASOoFC9R5brXw8szM3iBeQbgjDR0ZP9N
         U+nJpPKXpOvu8LA4txY4vXzvHhpSSNWzGDeiSVVIyln9fSudFcxP68A1jLyQIeXoFe0L
         yqsPkCq+elM4cAjRp92WvuNV5jaCRGCXNpVb8cq1mLJG3Yt0I5CrR46+bj6LSngJaaHX
         2W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222553; x=1770827353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIlScLi5z6dd33J+kHWnG73XMqR8pPoB5nxdAypevEA=;
        b=j4T3qKNU65exrTyzfzmA0N/KAn9b3UpSXeBw7KDuQp3f74w/J2AnYRCMvO+J+6y3ua
         QE1ueRJowblZviTg7qFMCWRDY25kZAI3mM3adgfHv1hK4gFLyBUrBIDapnymf+tKosNP
         06YhPLLEOrI+Vn8gSBNMl2rrSy3DsFTRPQL9VTmJO4kEhNxZC1G2vYPepAIrDlmQVaGz
         +koDfapWs5x/Jh/Jw2sxXaTxWOgCz55WgTbNtrWcRe6B8cNiBD65JgoR2BwII+q0SR87
         MgVdsRJVOt8R+EbEnqyu572ayUyjuUXNHo1rtBb50WyDHTAIBIgekLHNveYpUzGWKrNB
         mEXw==
X-Forwarded-Encrypted: i=1; AJvYcCXlxOKsXXaMSLkIg6lvDFaO4NBG54sN25QMeWlZGNn37e+l6BqAThGCdE+ptwyQm4DevdTLJg7do28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6k5m97IGhr3mHy9LfrbpmIP0q2POcAwjd4MG7IJw7Ju6xmGQ2
	jxsLIIHjgwGEkT7Sec5FBBhd7+oR0gvNpe8FRI9Tcd1RldpAiQNpk7Nnzo7r/Y372G9JDKnU95q
	XQQPFDL7JOtRRpd93Dfjd2IFz6pyRxAaIvkbfsuSQ/+E9TXupp+2/79+dB9B7VL4=
X-Gm-Gg: AZuq6aJTylI/FxYix41ap59uF7K/6lUCOwIC7ec271Rnbpg9Cawib/wf9SRJdx6qvZx
	scZsO/0gnKi6vf+oxgmQ4/hc7rdC9Fb6ImmqcrdypFP9WGbS4nyfCD+aYAbe/0x4ZK6ptMOi7Jj
	nWr39wGD4w/LF7ZG6O5/aCBgMTG78Q7w53v4o6sqYjaxCsegdCvMBqSrXzsBTC1ftuyIQj+Mz11
	XRNF3WLs6e9JzUtP07V7yhXMKf64nKF9K9whCGfN5R93mAS6xqHMePa3aKYAb77MYzppv4wQzxe
	VwBUcNOps7BtTQx/hvmgcj60nVcq2cSxjZGuterQxmQMccgN4s/faOYH/oGV/xu56GUc6HSYIGW
	1lXcM2HFzvvvyCIglblLX9EYzucfK6c++BR0g+wvHCJE=
X-Received: by 2002:a05:6a21:3297:b0:364:af5:d599 with SMTP id adf61e73a8af0-39372073860mr3496027637.14.1770222552534;
        Wed, 04 Feb 2026 08:29:12 -0800 (PST)
X-Received: by 2002:a05:6a21:3297:b0:364:af5:d599 with SMTP id adf61e73a8af0-39372073860mr3496008637.14.1770222551970;
        Wed, 04 Feb 2026 08:29:11 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c8515f36esm2546878a12.29.2026.02.04.08.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:29:11 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 1/4] spi: geni-qcom: Improve target mode allocation by using proper allocation functions
Date: Wed,  4 Feb 2026 21:58:51 +0530
Message-Id: <20260204162854.1206323-2-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204162854.1206323-1-praveen.talari@oss.qualcomm.com>
References: <20260204162854.1206323-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNSBTYWx0ZWRfX855IgvPJiSI5
 eYlUz5awmkxGpOd60nnnuaD5gWxp1eqQjgwkyfvlPP4Gmogqc54en1z0czVwhrVjYosNcHyZKkC
 xY5xZj5GtP7uqepChWC2lr5zhVS998Wb/O/IFdCQS3ouo4+V4LmDABAHWTLOdtdy7Us5+jkDl2D
 tL1qXQw3mgp8EIEtjWZ0kWXHl+BIKAtuYMkryam7MtT9ukgElXZdo5WhIbLyHUzuf+EhnQM/I4O
 ++IZ8xnmUZZKHpMcLfG7XQRuAKUMh/afIJcwCkdZHQj2lnxX2rk8g3llMb1z9erATpuvXGs1MAv
 6+1ucKih1OXq/RkWIXx5I50GkPVU92Gqxje9kTGFewzulUaSJ4Xpv1BycrI7dMWPIFoTaQYo/eh
 x1Xb3kL5y7k4a1Pnu1vKOVxkJ/LUz8Yr14RPoDmUM0VO47FeTVJDCVT8k4BcgBwZPSKz0gsHQZA
 jXS/ZwKJjQTuGccUycQ==
X-Authority-Analysis: v=2.4 cv=IJoPywvG c=1 sm=1 tr=0 ts=698373d9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Bup7t0bCmiTjNce0pOAA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: QPocGQPCSO7B36LbfFIAgguTebTMBjVy
X-Proofpoint-ORIG-GUID: QPocGQPCSO7B36LbfFIAgguTebTMBjVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040125

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
v1->v2
konrad
- Placed changes where host is allocated.
---
 drivers/spi/spi-geni-qcom.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 0e5fd9df1a8f..f886a9ba56e6 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1033,7 +1033,11 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	spi = devm_spi_alloc_host(dev, sizeof(*mas));
+	if (device_property_read_bool(dev, "spi-slave"))
+		spi = devm_spi_alloc_target(dev, sizeof(*mas));
+	else
+		spi = devm_spi_alloc_host(dev, sizeof(*mas));
+
 	if (!spi)
 		return -ENOMEM;
 
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

