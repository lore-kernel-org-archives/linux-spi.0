Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52341C2F4
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222570; cv=none; b=nT4J4DuSlQRItFgSHGCpjE9s1a9ziKCRll3wN6EpgyFa1F4HYe3GZw1XIQKbOUJo44QLjPznK1KJCr3jj8zYfnHq9iAm0eSOlEgjvVIjjrGuzyEmbrHe0dLKBROeDv3hJfcPL3CGE6xg2lS3qyp11BSBsEo9RLXPts2XIbEZCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222570; c=relaxed/simple;
	bh=L9DqGelcCFtxzG1Txqh7DNBFozIWof89KKJwfCaxV5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LcS/qxyiTVKnjiYxfWOeJoPCn1cp+NHDTFemGuYeCK2Q6e/J7hamjzw5SawYT5n4b/rDaV0TEEIGyzBZI3AgbJ+N1e4CVWA9mel+SAJLXpd+axTUkWWtDlRp9xumw3m9ngLgdejAlqVFO0upziAwnSVgeByuwrvThY0tPqcxqw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TaI13mje; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B+Lm+usY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TaI13mje";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B+Lm+usY"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614EGYVL926571
	for <linux-spi@vger.kernel.org>; Wed, 4 Feb 2026 16:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FSKr5h6hAkT
	Nur0wrixEKU3taeueA9+e0fBqw6QqP7A=; b=TaI13mjerNyVFRTlupU1xSfWCaJ
	MGj5uJFLTFE7cRfGygZ47zlPdg4s61e9Zkx14yIjMCGdohQWhoPiMDwRNcZ5wBjT
	auTGor9UkVUCog9uzYvHya5rEdwCy5ZokJ1oCSsuBBdW64C3NQmyL6nOLy35D+pN
	GZeVy4leZWA8TM+WEvXqrr6loCLhvV9U3+wr2ae2mOPKAyb0KzY0IelvLcr4C3nk
	9Y2QtysJ/zrtGhtFQ1U/ecbqkv3nsZCwQjcOTPMRaEe6dj9H5IpBSgpSgc7wvCIw
	w5u9j4RLPnZJl9VygC2G9/JB27nBispj2a1Z+kFFcOgzd/58WmlZlqCNlDQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c47qv8f6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 16:29:29 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bce224720d8so4180720a12.1
        for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 08:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770222569; x=1770827369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSKr5h6hAkTNur0wrixEKU3taeueA9+e0fBqw6QqP7A=;
        b=B+Lm+usYzYP5k6g2QxYS3dKbK4iGGQgwScy+90bnFkJIeQkEei51FPF8Uq9h6jMPHi
         R29dkYr8EV/ufEqatCRagGQ11S7Vw5JbhEhjQ2nr+Kl9VH0Wnh0cjarMFitUTyq7EEj0
         Ntqb59pZFBhJKoJ0LfivUvFl/5xG8RgElkZGL2CSTku1fQzDq5FezJqmqlWu1C0TknYk
         C92txuZt0uCL9FBBZLpGb/LsjxbqeRHG0ojpkyB/A184UK581OEmFUG5yUryTaG49P3U
         rhF9/83OTdF1K4m6u+CM5SfcKDRgU/W8Umz3+60uvHMF7hZHBo+CdLJe9YO9OJT2F26j
         zJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222569; x=1770827369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FSKr5h6hAkTNur0wrixEKU3taeueA9+e0fBqw6QqP7A=;
        b=rkkf/qeEmPdCr1+2NGWAsb+5+FJxmFa5TcPMgyVt5ssrwGyaaZnnmi9S0DVjANoQ+O
         hNpKEe3f/vzanmet71I36eJeCC0EgtZOpLtVJk2bviSE9P8VJ0L5l84t7k7tVc5StaFe
         w+i/LAy499guESa4jLFp4kil9ikal8g7ByWcr97f967Whu0qiB5k64GfW09jj0pP6aQt
         geMwoPi63O6aCwH1VfckecQJFjuTDbsB3gHcvxXDjLL7Vn6UgDuSODa5Ok6nMgdQLlPz
         EZUYi3ApTILWhLW+eduk6xpVAg7rIsBLzfRnLxsTb/RqzygYg6TRXjcfMkFr97x/oCqT
         ni5w==
X-Forwarded-Encrypted: i=1; AJvYcCUXMWgNxZLiGFWdBFFMdGtOf99thNfPTJyADktx3EqHlPRy5yvKzhAW7LEzbdkgVcblT0ETF9/8NAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmsCpdLLSF31rXlHvE6uNxlS3p/Hd08dhkrB/AlHCEFczRcMFr
	zvZ7Zs03ADT+feotd+Fx7+mQwrLv/0pgK2J9J1E0WiWbE7EAKLF7J8nGAA3ma/PuVhdJrdvaye4
	8nVLK+W4UExKnRhDZpcQHuCEDNH+5Yc34FpjBrh9/TjjH7wu8a0NrWlQ8PoH2Zmk=
X-Gm-Gg: AZuq6aKVq69/2/DUGuRwpDNGOOHl73GTwwlhCPAlg8Xba0AmDMsEoTF2ZZsd4eEQsUC
	/QkykLNeya7JkSyW1FCeEICEMrPZcuu12Wj9pocqDM3By/knQl0U6lQUsc7r4iWNGPHLHKMbcNp
	zGQJhK+UJo/MYfOVIIc3rPNORPVpEoG8Mz8T58BW7WclQfgx8Dy+y4AbrGDy08og8tUcmUm7z+i
	jZgqdZxSUiwHkdVjmyit1T8yuGN2QXL99nMX93Nm+Fllb09iF8aiCqwz95PM76nUwK7DEShLTKW
	SPCGlTviwyE+4/GZE7VGDXZ9xEwS317/eGqrwMto7rBGDEl+MTECMYpqEseYYBMbgC8XFyvmnLw
	9agskTob270nBSdB6hOl8j2c4iFcTTJGrwwz5a8kxQy0=
X-Received: by 2002:a05:6a21:8982:b0:393:7f50:f3b1 with SMTP id adf61e73a8af0-3937f50f78cmr1511103637.39.1770222568824;
        Wed, 04 Feb 2026 08:29:28 -0800 (PST)
X-Received: by 2002:a05:6a21:8982:b0:393:7f50:f3b1 with SMTP id adf61e73a8af0-3937f50f78cmr1511080637.39.1770222568262;
        Wed, 04 Feb 2026 08:29:28 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c8515f36esm2546878a12.29.2026.02.04.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:29:27 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 4/4] spi: geni-qcom: Add target abort support
Date: Wed,  4 Feb 2026 21:58:54 +0530
Message-Id: <20260204162854.1206323-5-praveen.talari@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GaEaXAXL c=1 sm=1 tr=0 ts=698373e9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ZHV-9eCtjRHb1jRugp0A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: kTYAeTKvav-zaxEbDxeRToZpIA79Rk7F
X-Proofpoint-ORIG-GUID: kTYAeTKvav-zaxEbDxeRToZpIA79Rk7F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNSBTYWx0ZWRfX/pAXiNye8Xjx
 T6iMweJeqj5qnMqS3JZ94sPESEiOTkL4Wtdeu/t+cOnkSAG7LJm0yLsHCBaDfjADq6r4I9UjYQH
 tcEf4Vco0JNK2Ua3g+bD9MzDXMotSe2j9DN8EDsxXtXRE60Trsd0yb27592IB8QweoJ/qjSCxMe
 tQ+8M9ZIxJLosYaH5msJNOLTZgDQTZOlOFB+icuejC2oGs3sl0unQjuSEiMuXv7pSGo1KQ+yc13
 2TNculC5YNzaoHfeDs107u3qBNYRNJ+bbszhZCpT6zQD1XXeRc3/F5igTbBEBNlIJV6raBhqV+M
 TkWbjljAptltnOsnTJzKUW1owxc5PDen6S9668j/70ehuQApG0WvRxUrLDj1WNbr3pVYDX7BxqF
 ciHQgGpGkIaj0faTLB2fmYFwEc5s2gx1Bo7NJIccYZyO7/cGs7Thy6wpFa3ZQg2mHMP9wOAY1pL
 s/B5f7f1FNoU4+rVRCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040125

SPI target mode currently lacks a mechanism to gracefully abort ongoing
transfers when the client or core needs to cancel active transactions.

Implement spi_geni_target_abort() to handle aborting SPI target
operations when the client and core want to cancel ongoing transfers.
This provides a mechanism for graceful termination of active SPI
transactions in target mode.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v1->v2
- Removed unused param from time out handlers.
---
 drivers/spi/spi-geni-qcom.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 5077dc041e3a..43ce47f2454c 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1003,6 +1003,17 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int spi_geni_target_abort(struct spi_controller *spi)
+{
+	if (!spi->cur_msg)
+		return 0;
+
+	handle_se_timeout(spi);
+	spi_finalize_current_transfer(spi);
+
+	return 0;
+}
+
 static int spi_geni_probe(struct platform_device *pdev)
 {
 	int ret, irq;
@@ -1076,6 +1087,9 @@ static int spi_geni_probe(struct platform_device *pdev)
 	init_completion(&mas->rx_reset_done);
 	spin_lock_init(&mas->lock);
 
+	if (spi->target)
+		spi->target_abort = spi_geni_target_abort;
+
 	ret = geni_icc_get(&mas->se, NULL);
 	if (ret)
 		return ret;
-- 
2.34.1

