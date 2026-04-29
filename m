Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A10410D3C
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482141; cv=none; b=t0cNp1VheXHGJlVIZM4R3jjNDpSHbbf80XAIi42x/bNnkV4wcwAZSt0eGZIz8LQw/7hAH0UsXbyNuUssGvUG0XBHNmVyJiNlbmzcS/BdDPKU1HN1yIk+HxM3ttlEm0weKkLnhMXbaVLsPA+SFiRXYRH42qW+4WLYnjuv+tl5ZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482141; c=relaxed/simple;
	bh=GR/YalO0fiQsOhoEWoJSrnxXoPSU+BG2jEl0tP4uuOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Smnn5fUG0VY+pQNa5EuXyybu1bEJA+wjg42gWLuxUDvu3Cp0H90okdkWGM/99rXPIH7heYkPFq4y7AwNL7Efbbz9fvADjoR/HFRS2w+MDnFKsG7Zfa+NPo2tEMfUqNVo5GAzn9Wgc5ww1baXM7NRY6NTFnTOx32LJ4IMxVESGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L3rhJFFv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dj2cFFQ5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L3rhJFFv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dj2cFFQ5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF8YuZ1728608
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eJMUbFM9OeJCR/xO5RmbmZl7e2974jJLhUj6r2MozRw=; b=L3rhJFFvcA42JGRu
	OqL7N/ZWsG9a3fJaUrl4ziUIH0gg+UoLkziqNuLnU1FxL/VQOoUPjHsh8vmifC04
	0e5WZitGqPXUJQ+MJ5TgiGTdSHUIvbf77+fMlN8PEdiTd5N/ivtCZ5YwmRPzHvv1
	+fwbAY0y8kSH34JP1oH5S3Vf6rc8vYDdNLWVY+oVaT3Z8ogN657cysLLMWUg7tan
	njHUCMHFL1T3kPXdMNy7hPLYpaBnh9yhzQm0tda1j9GrSG1fwi/ekLP+odJ3+HJG
	cfodAdgjkZlWE1ukVJlvMylWQq42QnrLdSYBful6xJDN+t8jzpEvZqkyVepmnwNO
	50qETA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4due5kt4p1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b242b9359aso189355ad.0
        for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777482138; x=1778086938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJMUbFM9OeJCR/xO5RmbmZl7e2974jJLhUj6r2MozRw=;
        b=dj2cFFQ5WEDC+8qNUAnV8hJ72EFWTBGYBAcerRLsUnciJEYkcU5WiJJLTG+S2lxNo6
         BsUz+AO+bSPl6rHdyjHJgJXXUh9c/h5ZXyZHtVw04pR1SdoUq9qFcpoVJwQ1hhaOTV9F
         bEDS55bT+3noQOz/wHsLTVlyZlnZEijEQhQVXtvkcAiGvt/JcbpUt+6mAyN1+tZeW9r0
         XUzsIMC6Fb1P2cIGwOB8N8gU1YQIYYHgn/arEqQHmTKfOsI91oW0wjJJyFqE3GUP9Jwn
         s+upsM41t0vepMUV72j/34uKcrZbZX4KrftXDFYDHf/E968mdG04c/xd1NA2QG1dmcCw
         DZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482138; x=1778086938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJMUbFM9OeJCR/xO5RmbmZl7e2974jJLhUj6r2MozRw=;
        b=SM2BYV+R7/NJntqMEf4c378XvKnI1uHXpU4+FREb+s0GQnot4QqTwzl/YekIEuSjQB
         tO0uprfWIGcOVEqTGUXc0HrckUKTvEPNATSvw8TnbM6vzBsW9G2F/MyaQyCdkI1ezoHM
         QnwCG2QmSkUgHSshgTnDvxBPN6DH91gJczPcn5iXXNR498cLErrEWuWc+oguvqo7Bpj7
         EGzg44P2hllA8I/VyBqsWox1xNTqaMEV0hBqw1MRsg5pTizpUYH9DdYx/9mVSZP+CU5T
         F53ypydgVKZeTJuDQoBIk5nkiQp6AmGu3LMKHIh96yPLnr8RFinehYXuLbA/FeIvGR9l
         3XtA==
X-Forwarded-Encrypted: i=1; AFNElJ/tH5ll9Guu8CIb0v2VLSvYrGRyLWGnCFR965zRD4y0LdyVcd9M/LezSOnLtLJIOuM5edqjeQzqVHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYATZb7Ky3ir88reDAuhxHsbhWY8LHn+VaJSsCADw+8UhvA1SO
	1NHtFuQeJ2l4/ywrrCWqtGuMphdXjJM/jotl5ttO2GvvD3o8kFlPCqxBjLbcofkRmeu8s86eNnR
	eI0Xp5mDZAR6vUffdY+TsVJ9flOko/ae2u7lJ6l99Ty1tPiNgT5A449MN8snQwo8=
X-Gm-Gg: AeBDieu+jMta3KRypF1hwJ6md0rKibszSFf60I88qMiUNt2Yd96RVdYHA8aAyk1usUX
	u4UDVcYr89lX9MnVyqRsPh807BpY2BHKOw6iWnxNbi4Tu006R007FzrinI9ptte9o240ty6/Fok
	JDt79nzfl6uWSbOTkV49on2SRUwioMDNushZZArss2ALMgLDEqFqVaSA6SBVn1Lpkv3RAUhSgxp
	+o/uPJ9ToQewGoLNBNEp8ZEIvXlTrOtKqnunUMOUTfsuJ6FmYQCn4k1BiwxaZX56V8risBokQg1
	D+wN/bmq+EVK6Wzhw0eZYao399I7E5d4VZg4CQxbIVyK/HGn54peiyvwcC3QqFN2dAXn4uifLpd
	6csNBhtbNq4Kjy7tbFlul1Zx5NIC37yFJRfIm6Wb+dsIOnRIsK+Uhio9VUysyeQNFLMcR
X-Received: by 2002:a17:902:d2cc:b0:2b4:65f6:e24a with SMTP id d9443c01a7336-2b97c412667mr85546895ad.4.1777482137848;
        Wed, 29 Apr 2026 10:02:17 -0700 (PDT)
X-Received: by 2002:a17:902:d2cc:b0:2b4:65f6:e24a with SMTP id d9443c01a7336-2b97c412667mr85545615ad.4.1777482137140;
        Wed, 29 Apr 2026 10:02:17 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9887853a2sm29530195ad.18.2026.04.29.10.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:02:16 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 22:31:42 +0530
Subject: [PATCH v5 7/7] arm64: dts: qcom: sc7180: Add QSPI memory
 interconnect path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-spi-nor-v5-7-993016c9711e@oss.qualcomm.com>
References: <20260429-spi-nor-v5-0-993016c9711e@oss.qualcomm.com>
In-Reply-To: <20260429-spi-nor-v5-0-993016c9711e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777482100; l=1402;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=GR/YalO0fiQsOhoEWoJSrnxXoPSU+BG2jEl0tP4uuOA=;
 b=xFKh/7cZnMGeFn9XbPu8R8GG05s3Fm+Cx8/GXHZrWm/SthSw2mjw1pb7Ty9ZbqG06EhZG00ec
 aA0cVifpvCJBsjrjqODM7rqBur4XN2m6jrxp3PkoQ1kolmQN99y5SxU
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE3MSBTYWx0ZWRfX+BNAlvbnKk/P
 pdJ8/+MIaf4oWqF6+0Fh/j+P0/PFDYAHQwjpekcWhwPm03FBvUJcbq5ruUEct/QZuOvlinjYORt
 Ur3YFxhyqq54tKjCFfKl6SHZUhy3rUNI7orEM3rT3GnbkhGzFA8VufCeX6cPK4aF7YJ7kKRgcNe
 jo/ifrNmkWCaaJI85cmK/thjcBWR2gyj4t3XP5xr0xrNJPrp0jsleUNsLYckKTtKMpd/U/F5NdC
 nRUGfjj7L6K+QiiFrMs6JQxN1DBEE6xaAp+b1sKtKqhzpODeEHRzWyZFzjiz/ROgZKO6CLragnH
 51zHwjg3KwB2SRQOyj2AGb8fJkaHSaeNF0OPVY5ecN2nZuQejBWEh7pDrV4ciSG8HRFLDjpETCO
 usZReRma0Wiz1UVvVCyxhy1rU2iHfhCsEIIQO2B30G1f9I7hfsJXNKti7VCT0KowETCBXN+CaY/
 UQGsH6qETSwRpURgNPw==
X-Proofpoint-GUID: jW1ZUNLcatR9l_aHNI1bIuOl5sHV03Dt
X-Proofpoint-ORIG-GUID: jW1ZUNLcatR9l_aHNI1bIuOl5sHV03Dt
X-Authority-Analysis: v=2.4 cv=CL4amxrD c=1 sm=1 tr=0 ts=69f2399b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=va74t0jcI0ebB8ul8YAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290171

Add the missing QSPI-to-memory interconnect path alongside the existing
configuration path. Without this path, the interconnect framework cannot
correctly vote for the bandwidth required by QSPI DMA data transfers.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index a4b17564469e..8341a7c4a4c6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2866,9 +2866,12 @@ qspi: spi@88dc000 {
 			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
 				 <&gcc GCC_QSPI_CORE_CLK>;
 			clock-names = "iface", "core";
-			interconnects = <&gem_noc MASTER_APPSS_PROC 0
-					&config_noc SLAVE_QSPI_0 0>;
-			interconnect-names = "qspi-config";
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_QSPI_0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&aggre1_noc MASTER_QSPI QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "qspi-config",
+					     "qspi-memory";
 			power-domains = <&rpmhpd SC7180_CX>;
 			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";

-- 
2.34.1

