Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964E38B7D4
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436605; cv=none; b=jaAi2tZDelzZm5VIQHf7HCRwtMnfLfyy34SDfGOq43vol1k7W3H3Y8fXwKOsMUf1c0Hmagxk/mxBvsRQwR9ThScI17MrBu5x2phDfQrsip6NH0lK4jFpYfEWSGwOyZ75gyq9M4RBxw9hXrhssHikOWXkYlHHMOGcBPQQmC19hTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436605; c=relaxed/simple;
	bh=/3t3rqT8fqV1+HN4uB6fWJFPqT2keSdILxMvfOZM+Pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=deXtrrxxf+WUcWJ++j8qYZE+0h9usTk4HLJ0gQibGVIbZM2kpsKqbTJWCYW2CLQ2T9ZZ9GUHC3ESmCknQ55KK4iwG12k0kGlMkd/EBEOMPOIcgykCcEMA6tF1faLnHvG/OJ9EfuLaW4e9tVq8T0ZZhf38wOo10loyTM7KnBPbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XK8RH6gC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UwWVFUDy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XK8RH6gC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UwWVFUDy"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T1aLV12890700
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mQdLrKTj+Qbw7jgoPEFhPIKDij8coJlWzW1Mxsre+eI=; b=XK8RH6gCHKt20o08
	+yay0hZPJoZ7bSirHLjGms20brp0Q1dOLwN0rGd1o6pfuaq7Lymi+rVT+pw8xnbN
	i50RG49SmjOfV/EPh2ZMz9iUEOm6mHPrsdXA08pGwm+SeqjDlmqAHJ/lhYQ2EE3n
	xEE8/i3Q1y+pyrYSMzzgQY2WqU5KSakbcnN0L7SgObsyhn4qJZSsevLqY0X2jxMy
	Ij5Ke61V3IA+YyqaTMEs7YQ7KYXWUPTpDylYpkjyt/N9TPeOKuddguUD6FecFtkT
	6cUI4irK1L50pAmkDt7Z2CWGXpysA9sQJECrFAfa72U2KINRo8yQSNLnTjT6tCSd
	pW215A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttgyusjb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso14011368b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 21:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777436601; x=1778041401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQdLrKTj+Qbw7jgoPEFhPIKDij8coJlWzW1Mxsre+eI=;
        b=UwWVFUDyxGQJ2YVC6tTgubt7T0Oco9rkzuA8NOkPnkwI8YHpwFf6J1RM/uQTQBiD/F
         yq+0YdSx8/9XOiItHxp4MEpe/K2bUY1ffAPYPoxciATIchD/ShlAUbwOfJCGcDF8gF1E
         dUjUFneaWa8dxHcZn6yxxzOBezulvB7k5Anit0nrndcssb3xxh2rRXRLLlGeKwArk7e0
         DLaKEZhl14L7wVOAgspkyODYFNJVqA5G0Ii/4sYn6KEtlBBoiBSH8XklIqsGqou5Gk9B
         4jtChp5t3rCSNvMxbeBOWy9epIIb7p7yq06PUo65bE033feW3C4Z08pLg4o0Xo6JdyH7
         QuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777436601; x=1778041401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mQdLrKTj+Qbw7jgoPEFhPIKDij8coJlWzW1Mxsre+eI=;
        b=KXgSqS0syZyraH4N+44PBlm7Us76f/KKXmUyPwxzFz/kI8iXSCSU95XbRwGh4cMNnh
         mN746FaryxyUXUYw37B7Mkc1hKMLiBeO/CNHwKVWFpQB0NLTt9DkM7bjXP1TUJQNiqYo
         ohhpEzj6dBFh9y9GicQlxHd51r4md+mH/G/ASNz+TxyjJ/fsSFidRQSm5HRORQRC+jm0
         1T5eLo51TCMW3NXFYUJG85YKD5iSkKNsUdyeJIaEMn8NpU+XY7x17fkcOFiMkGZUPIyO
         LGuuiQVHFG4w4Bj8+KJpTfgY03060lAvuaGvActLToa47E/hOvtPY2AHNYiXka3aEvln
         71zg==
X-Forwarded-Encrypted: i=1; AFNElJ/mdUYUw7gTAonnZjrN774Z+jOMXX6NEcsofq5nA4tQ06nJnK6u8lwZ1sKH1kVGodv9A5Tz+633Qo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlRE5wnDpZMictP04G4hLI9AaHmEDQGiD9VXdLZmSW4RU9azuF
	b7Y4McKYVrb1XMVpJPRqX0AaupD8By2SZ+H8Ows9sTNljmUm0UxTf6edURMApjaQ4/hXeGwE4Ke
	g65lN7BNWkuPaBIpodbx0f+a6SWWM+QWr/9O0yzHtREuVXIeheI8J3ySBqxHE3j0=
X-Gm-Gg: AeBDievo+Xg7nE108WDTNHmF2NaBgLntztbkYga2PyKYTXa9sZchTOtQynJb7BmbnUI
	WG81B3qZgKMAbmTWjLEwPOtv+qT5peYYKXiNyDMP8CSTxjTx0Exc3D7imEmIGpZULgwYkYbna4+
	9DH80r1iyZBppf0M4odiu8ictgLKoyNuYTL6s5jcI/vqVegNi4CSzEEaOj/KIFkS/Wy/2cQ7/FT
	T3w8HkG/0V8NPS9OUj0FXBTCdLujhGzngUxpDACD4PUB1XI2y6N311g22+XdZc84bNAjRJkQfBd
	x/JKjz4Lu2wPN1LcEiiesKralPXlI6h1t65tFhQwOdEr3lOIquh0m4G65uLlVQUwp3z47LnXDvY
	JbskG7EnboSv+LcQ0UrXO6VJUtdHRxzdHYfU//WEUn0CtSM9SyeG2LP4wWiV5aklOLZAL
X-Received: by 2002:a05:6a00:7611:b0:82c:24d5:21cb with SMTP id d2e1a72fcca58-834ddaca2a6mr4879484b3a.8.1777436600843;
        Tue, 28 Apr 2026 21:23:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:7611:b0:82c:24d5:21cb with SMTP id d2e1a72fcca58-834ddaca2a6mr4879469b3a.8.1777436600417;
        Tue, 28 Apr 2026 21:23:20 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5a074dsm602200b3a.10.2026.04.28.21.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 21:23:19 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 09:52:45 +0530
Subject: [PATCH v4 6/7] arm64: dts: qcom: kodiak: Add QSPI memory
 interconnect path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-spi-nor-v4-6-73fb1bab03ba@oss.qualcomm.com>
References: <20260429-spi-nor-v4-0-73fb1bab03ba@oss.qualcomm.com>
In-Reply-To: <20260429-spi-nor-v4-0-73fb1bab03ba@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777436569; l=1377;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=/3t3rqT8fqV1+HN4uB6fWJFPqT2keSdILxMvfOZM+Pg=;
 b=oLEY1TE6amPJ+BGtiW68uwqYVzXTghJp1RhvGxaqaDWXn6wn4vH3GJYpnAM5OthnzgEnInx0q
 9wG1SDYzWcfD4dCSzcEhiM7SOxQDmtO4BMrN/a+TY7oPeFK7zNF/Neq
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: 83IqOBJufWTVpjyxRZ0x-kLVgHDgvg6B
X-Proofpoint-GUID: 83IqOBJufWTVpjyxRZ0x-kLVgHDgvg6B
X-Authority-Analysis: v=2.4 cv=cb7iaHDM c=1 sm=1 tr=0 ts=69f187b9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=DDoZI6XnaA0zmnrO1bYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAzOCBTYWx0ZWRfX95zIfeW1Pmlb
 Kkh5TPPdsQA/GDbONP5PPVN8qFbiEgdUDGo8S0IOzR5lfqSMW+w22HLgC7DU6S0QMSbdaCxK/cp
 iNPshjOO4VgSPSZ9MN6Y/ZGVVPeu5cAZQJsAZBLflIrCCXP9uvg1EUbwNSstBFG/T061CXxVkS4
 pMNl7ex4mogr7Wk1DhzgoUIvRu1mTrszFn3dz/jMuUMKywgFtjCfKeoFEVLkz5HN7IllicUVyNE
 E0jzOghCiSWvN/cxYbtsMVJhgodQ+DZN+Zjx3UxkQgCPXk7Qukphjs0tgMkCrFoOFmdo4QK6inu
 /TRvuBEA/K3sJ8mOvqrq/GwDsaxwycuTBD5/rZ8tAjsaAu8MpUC78iAqBpisrvPKLp4qovcgs99
 SKu0tkKKo3vdIAapCkWUR6VD34NxapPxsPwtOviY/N0sdJohHqgy7QDq5RWoxPX5nvvu6XIO2RZ
 js5XWy+y2ClWV0oV7kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290038

Add the missing QSPI-to-memory interconnect path alongside the existing
configuration path. Without it, the interconnect framework cannot vote for
the bandwidth required by QSPI DMA data transfers.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

