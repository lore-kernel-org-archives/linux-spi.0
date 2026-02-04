Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24EB425CF4
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222565; cv=none; b=pyKmRm0/XFeus94PeGSP5veLHjD4lRUdwWtZbCN+xZpqq1bAT6WrdriTjCl4wY/1bdrIyqlKvfrFii+Q0CoFtW4/9Fp5K87i5+GmALOUB4HN0QX55cP5ty2lHrca/izXJ+JGiiAYDK85xzV8t6dnvBjctRoPDUzmrGCeu58sczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222565; c=relaxed/simple;
	bh=68oM4+XC5nRFzWgW83ZVy2hK9lV2X8Fgc/G9FC3yFl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etV4vdnjl/kpIjmHczfs4gttLPvyXsp/NzwMZP5bXzd3NK/dJTFF/N92su2PDlKroHLWy91KQOj1HDkhwWQbbYKYPh+jySePGKJ8hHMKCCrot2818LeqYp1/BIf2/XyTM0oCwKZJZ2MxXSTtKcwFInc7isjnBqtbZjgcJ/o9wSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PuwuN3SB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WRrtNAax; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PuwuN3SB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WRrtNAax"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIb8S795222
	for <linux-spi@vger.kernel.org>; Wed, 4 Feb 2026 16:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wAfwiLiuSak
	yJDmAWGtn9e+lRT9itU+foDd5KST34eo=; b=PuwuN3SBeNAcBYnunF7I8QSyPyg
	tZMaE9VzMa86TdUpPr8BFdGO43Jhbia9y2vFfBx6xIL0uE1rzkWwwdAixYDxIhwK
	UyUvfaL28iYA2sSmenTEEH6Jn9x31F3mD+3WlyvufJEZpB/3pGs6xMlEXm7kz8Rw
	cUc0jU6/qStyLMWCVqIsAtLD7TwCVEyLttSSCM1Gy6s0aI5uTD8FO4egRcuOgfht
	G5Q1wurysZbDjUergFKkDFYXfJ/79MamiMTD5fgQKb5/l08kpc8qM1oJpd1hI5xa
	wNJFWmQtfaSxQBjNS9bvVR0j0V7PpR2lXaY9LXAw3A4t+I314F9KKkXM+fA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43uxh82r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 16:29:24 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c613929d317so4304817a12.2
        for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 08:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770222563; x=1770827363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAfwiLiuSakyJDmAWGtn9e+lRT9itU+foDd5KST34eo=;
        b=WRrtNAaxgZaRoae7WhBfQ4b0/5tLyDUGeityjUOrag78q7WBFdtTitT31bEZkophJF
         iGuxQG7sO9Q+sIIhn4ROGvQ7bPrR2WAiYc6NlneLf2vpFih/i5ykPPVx730B63HcomSt
         PJLYkohpQeKnQTJzJoSOKJZU9ohUwN+8vD6K52r7EKlGiK0DnqrGOcnZW+RvR7gioOtV
         4/qufHHacM+cK3iQnMPNDRHF2tbJ75mLhMbjlNpBR2mCuJlbAwyfFHRMRtBHbJ2D+hNW
         v8LovyjR6iNbJcJWt1TQ+gPCcwDidj07FM0zGefi1sqsB0oOOmt+Gx7zL3S2g9+w9PdG
         eALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222563; x=1770827363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wAfwiLiuSakyJDmAWGtn9e+lRT9itU+foDd5KST34eo=;
        b=IpEfd4GU2QMwOjhRGy9QRYIx5XYyzhIJ2Kk2foXgGbp5UTe+s0nK9mMD7/XXW92TKV
         3TDzdpz7NgYJdDDT/rVsvoI89wqvmU/YdS121eU3dTpNLTBX3bw4iEdE8+87tFrKv5B8
         n2Qa1q4ljhjXSDLKLKme14u/pidENCu6RR5YW0t/OVMYuspqTROGJLPl9dmMKBct1gW3
         q+3nyRLRspuVz6J8Mj1hdCVaoREN6InAqcMuS9Nbfsd2Vf7LF+BeIBwRHQbf7/n8ulbz
         9NvnSNj6f5ib2XjpV0pmSIFY1RxXZhfxa33O0TzSCaT6az/eXiSxQoJSMXrDTEHW2T+D
         dt1w==
X-Forwarded-Encrypted: i=1; AJvYcCV4japgBydJNw7RDnsri9Ymk/hpq9855zyseFnjqkX554NrfE/xpeSXgSfldYyLJKs3HTsFXuzhYGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0cZTmY9LnMbdA29AzobtV6S6U8q/LVsbDzQBgVeRf9tUELB7
	siz05yqCWWd9Pcuq7VOOaOrt9/QTCM1IRjj4SL1cmEW8i4a4FVJh/y3t2GvSBbwAk5iEtFjXBk9
	3zxEhyy/Q2ph3+e6WiIJk0c+TOogmvuMTuguBD4Yc4/x/715NtIFCnoFwtEBZqUw=
X-Gm-Gg: AZuq6aLfe1itiTZPYpf56+hJrVDLEzqBQlzlz/kSM9vm0beXVQQ848IMWKXOM+lrSg7
	pDmREcDagMGrq77TSo8Ayn+HzVC1ucp3+dDb6N5dEVVi1wqtaBgcRdLj6kX9PUfXfgw94XlrQfX
	IEB3tBZAXlFioT72EK76pVRdPe2SWB2yiV2yIH7sUOzaR4MkIrqsjiJekvVrbpnSQWgwP4TTAEe
	0fr4zVCvTk7xJ8QCAbvQZs8GC14wjuhW7/b9BlkgV18tHyBkqJNPCEpRe67TZcebRtyE+CbyWYd
	AmnIn0Y8794Wv2Ub4uz/e7N+WTAoPkH12g0czO6hHNX3PAFI8PttGEMop9fb2eBUNE+NBwmcmu9
	uVT8vce/muKsN4g4Eabh1+7VYPQCpnBe1P7Ojr17WVXw=
X-Received: by 2002:a05:6300:614e:b0:35d:d477:a7e9 with SMTP id adf61e73a8af0-3937210bdb2mr3917173637.35.1770222563385;
        Wed, 04 Feb 2026 08:29:23 -0800 (PST)
X-Received: by 2002:a05:6300:614e:b0:35d:d477:a7e9 with SMTP id adf61e73a8af0-3937210bdb2mr3917152637.35.1770222562794;
        Wed, 04 Feb 2026 08:29:22 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c8515f36esm2546878a12.29.2026.02.04.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:29:22 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 3/4] spi: qcom-geni: Drop unused msg parameter from timeout handlers
Date: Wed,  4 Feb 2026 21:58:53 +0530
Message-Id: <20260204162854.1206323-4-praveen.talari@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=StqdKfO0 c=1 sm=1 tr=0 ts=698373e4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=gJUBjM1s-3uNyhB8e-kA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: yHkrzNy2OV4p9CLIeWDR3-rhmh0HQLOr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNSBTYWx0ZWRfXztIeIdRBidKJ
 lSMg4MyZi+SOiq2B2U7glZgqhl0b4J7oyTchilD1K71L/VMXg0N/wbn3HnHFozq1ogfzbNJLIGg
 yXFEEXyCYCO5UVtDqJihG7Oy2R5k2XApRIzxJ1kZeXVBi4fQyIF+cx78UJ6X1lls403a/veTtTw
 vLHn8exHLhsdgILZA8o0YU412c6Wu01gLqkx1Hz4mX+f9BstJSD/W6CjtkvcDjsjWmg6IVrUmAE
 duU7COPnu+uM1LSFWNUb6nQcHCB8yxCkpILtsyM08IQHCPBJnNI8S+INByHnKTC2TIBnHsM/96F
 5rujd+XOucqeD8lfj9F/EwmhmoeohPSeKtoEybKS3Cl58GPYqD1wULGB1iEAfiZmR7Fgs3v1dbL
 vo2o3OUHfQnDKedude7eq6caagOpSbcfneMRYD5iMYz5XgKnS/cXkRXKqTHfVybuP5RjqsH/ZjK
 W6i9AEIGUFjrtzaU0RQ==
X-Proofpoint-ORIG-GUID: yHkrzNy2OV4p9CLIeWDR3-rhmh0HQLOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040125

The timeout helpers (handle_se_timeout() and handle_gpi_timeout())
took a 'struct spi_message *msg' that was never used. Remove this
parameter and adjust the callers to simplify the interfaces.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index e48aea7ce681..5077dc041e3a 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -146,8 +146,7 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 	return ret;
 }
 
-static void handle_se_timeout(struct spi_controller *spi,
-			      struct spi_message *msg)
+static void handle_se_timeout(struct spi_controller *spi)
 {
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	unsigned long time_left;
@@ -222,7 +221,7 @@ static void handle_se_timeout(struct spi_controller *spi,
 	}
 }
 
-static void handle_gpi_timeout(struct spi_controller *spi, struct spi_message *msg)
+static void handle_gpi_timeout(struct spi_controller *spi)
 {
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
@@ -237,10 +236,10 @@ static void spi_geni_handle_err(struct spi_controller *spi, struct spi_message *
 	switch (mas->cur_xfer_mode) {
 	case GENI_SE_FIFO:
 	case GENI_SE_DMA:
-		handle_se_timeout(spi, msg);
+		handle_se_timeout(spi);
 		break;
 	case GENI_GPI_DMA:
-		handle_gpi_timeout(spi, msg);
+		handle_gpi_timeout(spi);
 		break;
 	default:
 		dev_err(mas->dev, "Abort on Mode:%d not supported", mas->cur_xfer_mode);
-- 
2.34.1

