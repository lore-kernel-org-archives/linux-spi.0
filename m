Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30D427A0B
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222560; cv=none; b=ZPXSDtBL5NjAcaUPE3Ir6viLXKZKhfm28LuqsQrhlKki01uD7r8co4/T2zEt5bddKSAZWXTQCyTMdean+3xv3WNWqkGXOkR3NIB7aGoCay/qawFhUHUGlAYZ7NyZ/ihpVLVSM6aGxsN5O0Ih1M2aF37KNIPd6GXPEAgMFhPohl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222560; c=relaxed/simple;
	bh=3me1SodZTkHVWGIC0kYi6tRJygZte7A7CmjLrhhOe9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bdm/YZiCHeMm+g9gKizW5UF+ALxy+ikA/BE9DRP9+DQpZ84e3O0qsR2dMD8SbZQtMi6AwU4gwVJiylG8rPzAycpPsVTP6Bwl+Eyr6brE4gd6fqCBAoGkp+SqiaLWxRZLUJUWf+/M9oknEVW5UjukCaH6FGkXfrkO5FUejEecmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YvwwIGUS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jhqjpr6a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YvwwIGUS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jhqjpr6a"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIaTN200240
	for <linux-spi@vger.kernel.org>; Wed, 4 Feb 2026 16:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HYH50Zm6WCw
	xpaucxpsuIwIJ6T3oQhCQ2WmmzPUspP4=; b=YvwwIGUSXTGXSY/Mlh2fpz4u/Mb
	eO05hW0d/HuBOorz3SecgKJqaUaX2U4zhBy3/5U0nrMsBlwsiVpyRY3qDRKJQ10z
	v6Dc0vQobj0Wlq1WRDl7zRhkEheaVNpsVw8CVHQyglWEDTeU9bkQPgXTGkUzgaSg
	Vb/TSsVlmiGdDTFnlS+8a/POGGqLFS38IM1eB5t0ogaRix2XrDn4mKLV+7VXEQYY
	Uktd+6lZI1bJezkA1vbL3c3GRsGaEjW/kI0vdE9UPHMjt0elF+haCuFRcPDZ2EbG
	yZmDex7GwMvuwexFidloC3ZlvTwJvLXrmmuHuZzR5xG4sFwYiDwnT3J47pA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3yp5a11b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 16:29:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so4914770a12.3
        for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 08:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770222558; x=1770827358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYH50Zm6WCwxpaucxpsuIwIJ6T3oQhCQ2WmmzPUspP4=;
        b=Jhqjpr6aj4qvseGKY2rtv891GN86LwBESwyffo/quB8PaYmMVsMyxq/nC6QkyPwWcb
         Uioqtkan4S8fmR0cJX+UtXVmXG9vSV5uVAFet3kydl0DIA0dzY6OzfNV61/rB+oHLoDD
         Lj4/VaA3q8BZsFTBLUviGCB2fSFdSQ0//xD+bArcBD9SrqJm9EEgYNXzCCKQaD1sdfxe
         A+3loZ5PxP2x0cyErOfScyXsELGdt0j3xXZj5kXMelaKgxpgx7wyUTrQk/Ngmq+jp+KL
         S2MNxDHWTukcFVgQ9nIAZqsmj104CDvdz3KMaqC/QJNzZq8+cckQ0LmX2oHQLfl+9SSZ
         XOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222558; x=1770827358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYH50Zm6WCwxpaucxpsuIwIJ6T3oQhCQ2WmmzPUspP4=;
        b=QnyhXe2wEPHsHvbL5g/K4bmzctXnQvNBe0kM7t17e+xynmmWftbyOBlsfj/B1w2Luf
         S9LLQKShKXUonLai/LEMDJ3rxAsdgp6dWZB+8/RhUXYTnm1cN3PevQM6QTtYdyb/KiNy
         pwTbKhkv5ZqMuPNfcVptj+JnXf3J1A/uz50VNF6cgKPP0L5JmpOafZr8FKopuahNiIk3
         dkzrI81OA5TOUurDtSjpZOgU3Ze6+3JILCTD2LuKUO1QfZxzCZE8sxGvpLoOPLI+KOYi
         Zm5EyZqKqfbaGuTLeA8d2frfNRcGL24U/RTncykqnJuU3HgukuriwHtXZURYjV4NgZii
         hp4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX850kZ7Sy97h5F1mj6E0Tx+h/tFzedp4ItxFhMrXPdNNqptRy5K4GS+9NyBlpdHFEQ/2CIrioO9CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOHXxIxWw/095Mkb4ITC6xROz6IY8YnsxqIpYosaKZBtInM13C
	Mu04hMkbKwq9V1LDqXdWW+eb00CvuEmU7tjcQYoT3wtadDTZObS01XtPGw3ICVXYcBqBqM+6T22
	oEEsguNtTRTvjcqJ9kb9hceLRwTiPryn6fc1yJ6zfFFd+wq6nDyHj151TqRmcXU0=
X-Gm-Gg: AZuq6aJhpX2J8ceADNUNNmfCnf8eiMmPb1VuDtpMwvaPifYq9bs407eYYpQhLEcxONB
	D2hGrHhLWcokGZoxIbo2ruF6ESple5YjoCwcEB25EIluuF6747/6aoSsPkhGZyUxyDvQrWQWmMI
	843kLtbqb5Byul/IKVR9/S9OaBDkNjgGYibJ1BnBrxg+EyVal6SrwpP3aH3gIA3PZ5mQos+T4Op
	J/xYoGDmaMo2gqL2+kOmU9MhVqfy8+cTNrZruT4wbScR9VMh8I8d+zJ727U1q0HgQ8+J/87C3Y9
	F6TJX7+2lxVSyJVeOzJNFhLefU9151B7rDvydaBBpXvjiZMdh7kTao08xdlPODc+sNaWfwGs69t
	FwlDxzqFRouuSk/5NrhyCVDYw9vd3zkepf0V7SyEMB0Y=
X-Received: by 2002:a05:6a20:43a7:b0:38e:9e77:9168 with SMTP id adf61e73a8af0-393725d73e7mr3446760637.79.1770222557972;
        Wed, 04 Feb 2026 08:29:17 -0800 (PST)
X-Received: by 2002:a05:6a20:43a7:b0:38e:9e77:9168 with SMTP id adf61e73a8af0-393725d73e7mr3446728637.79.1770222557396;
        Wed, 04 Feb 2026 08:29:17 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c8515f36esm2546878a12.29.2026.02.04.08.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:29:17 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 2/4] spi: geni-qcom: Fix abort sequence execution for serial engine errors
Date: Wed,  4 Feb 2026 21:58:52 +0530
Message-Id: <20260204162854.1206323-3-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ASN-nIuH0rpK0jmbTDB5HF8jkq8yFXS8
X-Authority-Analysis: v=2.4 cv=cquWUl4i c=1 sm=1 tr=0 ts=698373df cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=PwoySFKYIoUPqChjOH0A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNSBTYWx0ZWRfX9Rv5DDp2MGdJ
 nSVHMJfb35bA8dmdAAdsngUvb44ZbbskyjTYMtsBKP5LNC5TXHD87KY2l/Xr6dDQE8bCgg3JJ92
 CeIGVmII6pvVKKypZRVdfo8+FVFfhBWakuCppTv3IYg7SOMm/zubq4fisVsKYjIKcqFRCGckcap
 IaY/HWHnszH4KVwF7qcEbYBV8FoMOzVPPvPO5XIZ8nGNxKV1hSKIo0zFN0KOzBqWlogGGq4onPn
 U0cIDCwZ+oVNPqDrtfC4WZaVSzPyr3e93U4SiaH671gNRlwffMxKmxl7FPLOvxFXW07ZF+1V/Yk
 EVQ2unkPA0KlsAvXHS3w/JfeKn6tjgIu3Jz0xncSm2tpmkIHtBk6rM3xAtNWZi0QaNSGvlgqQOK
 0byXnYGdzjpP/83YheKzXcZnaz7runXCkb64dMYSqRJ5L7Q1CSCs5od2EsNW+/kg435QW4E0s1f
 1YeS+eGLp1nCDyoqxUg==
X-Proofpoint-GUID: ASN-nIuH0rpK0jmbTDB5HF8jkq8yFXS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040125

The driver currently skips the abort sequence for target mode when serial
engine errors occur. This leads to improper error recovery as the serial
engine may remain in an undefined state without proper cleanup, potentially
causing subsequent operations to fail or behave unpredictably.

Fix this by ensuring the abort sequence and DMA reset always execute during
error recovery, as both are required for proper serial engine error
handling.

Co-developed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v1->v2
Konrad
- Updated code changes as suggested by Konrad
---
 drivers/spi/spi-geni-qcom.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index f886a9ba56e6..e48aea7ce681 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -161,24 +161,20 @@ static void handle_se_timeout(struct spi_controller *spi,
 	xfer = mas->cur_xfer;
 	mas->cur_xfer = NULL;
 
-	if (spi->target) {
-		/*
-		 * skip CMD Cancel sequnece since spi target
-		 * doesn`t support CMD Cancel sequnece
-		 */
+	/* The controller doesn't support the Cancel commnand in target mode */
+	if (!spi->target) {
+		reinit_completion(&mas->cancel_done);
+		geni_se_cancel_m_cmd(se);
+
 		spin_unlock_irq(&mas->lock);
-		goto reset_if_dma;
-	}
 
-	reinit_completion(&mas->cancel_done);
-	geni_se_cancel_m_cmd(se);
-	spin_unlock_irq(&mas->lock);
+		time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
+		if (time_left)
+			goto reset_if_dma;
 
-	time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
-	if (time_left)
-		goto reset_if_dma;
+		spin_lock_irq(&mas->lock);
+	}
 
-	spin_lock_irq(&mas->lock);
 	reinit_completion(&mas->abort_done);
 	geni_se_abort_m_cmd(se);
 	spin_unlock_irq(&mas->lock);
-- 
2.34.1

