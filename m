Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043D381B15
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665618; cv=none; b=i0MHCPWMU8vrMSBUNk7ROB8WgkBAbGrq+z7HYjvtGAqrIW/I95gVhV0TsW0xf91bhrEjEwWXjfPNetMV7pW2sqknrgNLnK+cOZyvpqbJy47jO7htZyN50mgShNnvSxv4u6QFU5An67OCQ4wTcFK4UdRAzVuPrEb3ymPe67d+GEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665618; c=relaxed/simple;
	bh=WaNBJJv+6oSOPyDrHj7H5U/mPHlAb+zThv04RVsrfDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fipy58goNs9/KK8vmq2AqDUvEdzbKPkA1j3g1aZdd4i//uZwN6VnMAaKQGYgGPkkFddakmO1WjvwOa23sEFkTEINlm+wDp4XrQdqCJ2Jcj1wbmTbaxlDY8GMAl9UMd1S7vWW8QBs8pSk4VQHQIV0fjHYsGZ2Nn1UAy0LkUHypyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yrap/BSZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4zkMUNz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yrap/BSZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4zkMUNz"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JJhbF63189995
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VVVQaFx6O4r01adoydXe8nktqRl4sT+iMmmpPIdWQYw=; b=Yrap/BSZl0h6O+Zw
	W7B3mr7zSD7bd2XJsQQ58IOCaqSn/iZUDKPU6qvF8vACf2ENPdKABSk1Ay6Ph01+
	Fdx1WotmmXMzJWj92/SSrY7gAOo6i2l2mgoyt2P9DeUazJ5nd0QwdzYiWdCGq2YQ
	nXBBzV8Ra8FcVH1ZmCN5RjqEhkFmSNPwFer5DgZGhOusBx5w5hW+anldlPSCzCg8
	UAvPXeuZG4vbjXH9ZAqRGhPcF413YA/8O3/0DJiF2zjBoQJp1do+41zw4CO/bSKA
	uEFgvZcxMwo9rJIYdWXLNSMLYeZRhZGnJsn3g3ljQlBCrf5BAlfZB58nN22MjRSG
	KJSKJg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm388m920-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:35 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f780a13c9so1898269b3a.0
        for <linux-spi@vger.kernel.org>; Sun, 19 Apr 2026 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776665615; x=1777270415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVVQaFx6O4r01adoydXe8nktqRl4sT+iMmmpPIdWQYw=;
        b=Q4zkMUNz0BZI4LyvQFrITz42JM0pbKuNwxpt3NtYByHnIQupUIASj08Zwu0WglALV7
         8hKGc+pstXrLT4zN6s+I8yQO64N1l0M/zZQhPSkg4iMLCgonLGp3oaHt4fkUqfC9nUGF
         tI7YM+QM0nHJVZ/Yr0p+koCrMaPCE0zLy76Jfsek2voP1bH/K6cfgOKZwUSpKcn38o7k
         qJWFcbJNMoKCcviNE0H7mG3N5DAZnqunZtuA27D2Qch/Fh41hgXtjyx40AREX9iUh6A+
         bsjpq2I/uP8JBV3kNEMsZZ0eVbXj8voFgreT17FktAhxXZfH4oj/VZu6t/iwwY/2oXN6
         p8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776665615; x=1777270415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VVVQaFx6O4r01adoydXe8nktqRl4sT+iMmmpPIdWQYw=;
        b=Ll2fjtWiiM/MWdup2VFWkLmB9ykOsPcaHWdtFtctYVzwu5iT+MmoX5nKTx7yNKNfJC
         cZJPy6jdIx8zuOKa5jgF/g/yB1Ok9ic6VIek+OkIrav1P2ZWAeo9cYkKXJgJqXHKJ02S
         0LyEMhJ2eZBn6emRZkdHPs88qsFwXHsHZyEcWtP7gKoeo3v+Bm9it+kzoXkHrGFfKPQK
         4k1NNmimB+bpXnZVw8VbKvwGUoJ6Dm2lhKOLZHsPGcImSQPMXQb9T+7SIhpWxcHBk3n8
         6Sd3ILuYRjcJk5n4p4+DTdhyuoRqvL2VLcrd/UdGbdacfrRaMrRHDrISf+KtgfwvjIqq
         kErg==
X-Forwarded-Encrypted: i=1; AFNElJ+XXN8N+iQuz5oJPpHjsP3oP1suggem4VqSkS7kuQdXQDxAF3YG9iqajQr1FpzT//SpmHRI7jEVVio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZLZCubCT58pO4JRO0/jFfo1d/d6/tLFIDO5ihAXfHV2MgVPG
	MPMEb+XYv/3tTHmioLDdD0okinGp6lTSC+q8KdNjI2kH8m74N1lcQVRPkgEVsdpNDF9vajGNT5e
	n5NCUoDIaJ7NfOuphu6AmHDJaG0ts+ya71HZy+s/hmibiJcBGFmDZtTDGjXhm9SY=
X-Gm-Gg: AeBDies/7nA8xEuUcqRrAkwrMWa2rKcxpfNg7x1LvnrvI1HT7xRhY6AW4fU5h25bHrq
	4dXf59UBuLM+bC3sJfdleRNOtN4pKn2Esrlf39R8pwOZm6TBm7HtoNy24rMzzdgfq5EyczVfO33
	FjEvtPkVvkMn4AGg7qgtbkMz+FzaKKYo3RPElzzzd9/s46jGw2h2lxO6Q5zQxCoUjdG2WxulngB
	XFonsA4z9BaIM+Zap0Tum+SI0GMi+TK7rvMOtIY9jKCWvwhbe6APmQNDIbRsvqf1DD4x7KOSfyr
	JcevcZupeUfp+7+WGUelfwvZDcZ/ZASWY1xE1Hzd8qPT4JfxnjkKVlnlSHUuepk8LnOfwABUVYn
	OIc0sXA+guj3Cgw2KSkdsuUFPsOc/8BK4sz9dkVPsdJmYTbxhtORIznkSsco2xUz6k0uv
X-Received: by 2002:a05:6a00:2988:b0:82f:66e8:4257 with SMTP id d2e1a72fcca58-82f8b565509mr10317105b3a.32.1776665615136;
        Sun, 19 Apr 2026 23:13:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:2988:b0:82f:66e8:4257 with SMTP id d2e1a72fcca58-82f8b565509mr10317002b3a.32.1776665613218;
        Sun, 19 Apr 2026 23:13:33 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb28sm9018034b3a.13.2026.04.19.23.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 23:13:32 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:42:53 +0530
Subject: [PATCH v3 6/7] arm64: dts: qcom: kodiak: Add QSPI memory
 interconnect path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-spi-nor-v3-6-7de325a29010@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776665582; l=1316;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=WaNBJJv+6oSOPyDrHj7H5U/mPHlAb+zThv04RVsrfDQ=;
 b=YjQE9TtlyTOLdtjF74fv4xRCrvlKlwM0C7iDsTGbqAn4OMBL9tb1wjyaBd1jk2NFfeTg76P6R
 9zfUwHSASnQB9cb5FZR/Hvpph+K90I/ZvPwIuEF2aXwB8VXB+IJIr9V
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=GthyPE1C c=1 sm=1 tr=0 ts=69e5c40f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=DDoZI6XnaA0zmnrO1bYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: syENU2sT4Q64gHKNZXTTkAr1iTYeUWCb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA1OCBTYWx0ZWRfXyfo1M3J6y3Af
 bWKeC5ADJnKggxWGdisdo/0BZsbxFJsQK4rsQJQMot3vAA2qpmJYZN2JsPph8TuEb/fu2OfvHOq
 GfgWTWbxSyPS4mwkHTWfCULcsAJENrPOt3d/DDbosxaDNDADWCY0tn4DtXkQRwa8ZQX52Bl9Zse
 0F4UTBfApqe/4XJKWEgvpsTEV+Hw8fz9EhdpBvN5kWgXFbuWG9YJemyQulNx00XRamsnRhZIicR
 U5ti2J4A9X8Re7TGdupqEFV2Lzk92uXFWz5kScl1ecyGW0262H2/l9rYPltwJqZHHNuCbfbRnAZ
 o/5oCOOZwER6yhFl6jOhc/yYZ0bfVOgs9uJeqRuBAuxqp5JW6wbVLgwIO13p0R98re+9uDKv/j5
 fOrFKZEY7Hrn0o9EEgZrgB7ehA2mRBggBlnK3UAnF3Rq+RhZt4i2/G02rDNsRqZl+dsu9nAizZI
 O2mns21G6fw9uFkEFUQ==
X-Proofpoint-ORIG-GUID: syENU2sT4Q64gHKNZXTTkAr1iTYeUWCb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200058

Add the missing QSPI-to-memory interconnect path alongside the existing
configuration path. Without it, the interconnect framework cannot vote for
the bandwidth required by QSPI DMA data transfers.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 6079e67ea829..01e35e34ef51 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -4312,9 +4312,12 @@ qspi: spi@88dc000 {
 			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
 				 <&gcc GCC_QSPI_CORE_CLK>;
 			clock-names = "iface", "core";
-			interconnects = <&gem_noc MASTER_APPSS_PROC 0
-					&cnoc2 SLAVE_QSPI_0 0>;
-			interconnect-names = "qspi-config";
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc2 SLAVE_QSPI_0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&aggre1_noc MASTER_QSPI_0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "qspi-config",
+					     "qspi-memory";
 			power-domains = <&rpmhpd SC7280_CX>;
 			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";

-- 
2.34.1

