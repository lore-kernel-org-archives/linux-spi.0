Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FDF34253B
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186553; cv=none; b=iaJcWF33bPnASStB2n64s0/L/bsx9bTndNcxAYr3um6cwOPCsah08RexRiRdoT4yLXBkaig/1DtS7dhDdG1jSwJk3C3NGaOyHtmTpM2TvDJIDTkUmogh9SJ8ON0xk5bhr68e74Uqn3W4ts85u8ZESdXonTPWV7/y3DdMQKjUZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186553; c=relaxed/simple;
	bh=+gxqB3T3OdbImJ4VCq9TEOT8bV8gp0vR7BsLFzk6w6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z8XkH+f4lkhszuudKtV0cIDS5pzObZ4IOv+25arMK3xpt2rsZxOzfA5q9Y1GdNz/lKfLY/6ERg1dKz8XJ19X+sH4flfw5qkjNigJnpy5LIZo8MGbk6Fi3ZdBHENeZshnLzgS9BxYQ4EHjiTKUhH6spQWIskPplUCGK6/n025cdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RtbhGj+n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QYwdmPi7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RtbhGj+n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QYwdmPi7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EH1ZbC031125
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dd4QHJYVnx6VF6HE+2NsnZgJNpywRvKRQw4uXzySa84=; b=RtbhGj+nqzHJLG+n
	edranAJcyrzLkG2HOj0O7LJE+MXC1UwSTEbW/KC45fmyASOWMARpkPmPRwPHnrwQ
	4Jn4LjzL21bha5Y8i+5R5lVsqooz7OssbVxfGM+gUqdIrRs1s9O/3VEHQ/GXInQQ
	OlrC1L1TFTABvW7JcWQdhV0YB6mISpMve59gUR6lQnCR+qi3d9aVkCZhqrjqLxvs
	I8wLyN9LqK2QaTJziWBkyWysT+Z8WqjGZtXzuqfdd8IsLO7tFm0FcLdtmnen7IMb
	tJ0vuysdFNoAhUA+2f4l4g7nzG+yGmZ+LPIXJ2nY+aDei/GtSQUwWt5usrj9SOmW
	kEf51w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhkgmhhda-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:09:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b45cd0bb96so27630495ad.3
        for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776186550; x=1776791350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dd4QHJYVnx6VF6HE+2NsnZgJNpywRvKRQw4uXzySa84=;
        b=QYwdmPi7VkED19gZ2WBV0qIAY7SGBteEn6BnHlLUqb9jWszexsrCfJIkFKvN3Z5KuF
         35NORQ5D1PvrOkQG1odKU1UIJwDwxbU3hk8g0tTfsT0E+tPuoYq1ap7gsUptERn12gLZ
         vTSX/YhOvStTQTRUUe4A2NdvBXf2mSRPJkpNHXpuKuCazoqspTnlgeZtBHzBizCHl5jm
         XsxURVtrGva7GwL8YkzJGZ4P55kdaK/9ohe80KhpM9la6LiEi0tbBcQBR+xj2UOfa02R
         +/VyoHErG6Qv6yu1e/U2BedQj+Zoiohsc8rcuvH/waAO7lM8B2wiA/Vm1AhTSkxDPkLI
         R3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186550; x=1776791350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dd4QHJYVnx6VF6HE+2NsnZgJNpywRvKRQw4uXzySa84=;
        b=K0fsgUoQDTg70WrExbd5IQ/jOuzvVJGB2RNUhOdy2r0lyvLs4tmpmOr9DvUew1Nkyt
         W1tSVBqFYkNOhFYmhXqFh2jdtGtNcaKQWDV2hFX4bAwa474GC+WsC7LPmCqkP/Td6FBb
         0NKDKHKzMAad3y0KurF7qwB7paSGJ7qIGCsX9Npu1g66xiTOri8qgoBfDauy/0kddBbN
         w+rbsd+ZX/fZi3VvMv0dTv8/LJ9Hjhq2+mY9m3SDlS73yIsl1EXmLu6EEnYpnH78v8y0
         S5Dy+wLHkKVutYxfTRVGbYflO6UiNtJAWFlfMeOiXgpFefDu3j0sOMfFlNOAkpzBJUpH
         tDtg==
X-Forwarded-Encrypted: i=1; AFNElJ+dk7jz7ynayAf4hTRlVMuxZOUSAUWPIkMxR/b0Nubi+dbWY+RFKNSguEwkdI0o7txwJtNWc0RDWtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHVl0+cbnbZhhOgLWxKJfMaVM7WKjWj2OB9gpLsLhKxzYTn+Ln
	8ez3v6AcP89V+hxtl92Hl4qA5C6YWmippbb9BBh1zt9VJ7cJMkSeu9f749PquZtCPo+pG5QUATQ
	hkXQ/q6kVMiJb8ak/VMkPzV/9oJfZ7wnaSJimmqYNrjl6kA1LmZrwMaLEC50CCF0=
X-Gm-Gg: AeBDiesYqTHxRYe8yLeJiM64oHXfuv8rI3x3TwW0u1Cb9OctB+LV5+ykXuIEQ3DAMDm
	v0mpbPKV5of0od3B0NxNv2BVjfRIx6Y/7XZi62CkdvYI0GN/R9Ezd19Z5uOU3ukdOFchuSiP/91
	Ibk+86k5dl7IUhyAX3F3vYjxiBHZuXH9Bf2Mk2xACJ8prXhxF0JNnzkOWDtjP/IGfdpf2Bo5Vt4
	fRAtL6HuAbZZjXYkaoG5qzghhtIuPDJxII2Kq0VOSgLU//jNGbggNb4cPeAtVcREPELLTamGHIZ
	IpBsuChjoBofL4I/WC1v0u5xn3qVZjf73tZ9iXHXE4S7CIwrUUk4K8Fkzr5y3qwq531vFnRsGeK
	waxj5nZlIh0cKxjBYTrv2xB44V2ffsuPT4PkY0S9Ve0uxWnWLSmw+3AM1E3remxAoMh27
X-Received: by 2002:a17:903:f84:b0:2b2:596d:594 with SMTP id d9443c01a7336-2b2d59619a5mr173831595ad.13.1776186550011;
        Tue, 14 Apr 2026 10:09:10 -0700 (PDT)
X-Received: by 2002:a17:903:f84:b0:2b2:596d:594 with SMTP id d9443c01a7336-2b2d59619a5mr173831195ad.13.1776186549375;
        Tue, 14 Apr 2026 10:09:09 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45d1ab540sm97535225ad.40.2026.04.14.10.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:09:09 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 22:38:25 +0530
Subject: [PATCH v2 7/7] arm64: dts: qcom: sc7180: Add QSPI memory
 interconnect path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-spi-nor-v2-7-bcca40de4b5f@oss.qualcomm.com>
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
In-Reply-To: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776186510; l=1351;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=+gxqB3T3OdbImJ4VCq9TEOT8bV8gp0vR7BsLFzk6w6Y=;
 b=et35ye3TT8hP/p/UmotWrLocjyo9UNMdTIMftwurVRDTSfNLhD9wJwbrSupVnpxrJsRXXRGjW
 XXZZu6wANn0C/wxoiYumvT1CrCdZtAei04Ut7o60Mj+NMM9NTBhS9Ox
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2MCBTYWx0ZWRfX1SwYnBIgwUdy
 SOv8csZQ80bkfPSLL2FblWef1RllcE6grp07eOQuHxWIBRA7WpWy5s8VsM3Tn2CCOmg2K5xRZ/j
 1fmGfO3Hl/9lSi9orAMWwJvswVoIh/aeQmp85fNKYU8EFDJAfDzRwUwVb/0gJOx9CgmjgW0Chjj
 EIAEVRSRqE2dQQa56byh8mjsVxdN64bJKnlI1z2/VygnLPoeqkWFS80GS4H2ET+Hgops+aVEayc
 IM0NGD0XIRantfqWF40oVaxxZJVZ64w9XwOdbcVbGCtDcPsO9seX1VlEVHASWfOl4s5eZYz5rEv
 E+rre/HH8EabdtKxSH29mPie4bPrlQtq+gQFBzzWITKTTDmJAEQ6f1V81XWu6+8qOzXl+fgCN4I
 xWvy/jMAlo7JHfUJnEbfllmeBHMyzWTIQ37pW8SVwYoJYs9QytRO/FCzmoEyc38kr30QAmpfjGf
 rvxYAcEzj5pet9fO1dg==
X-Proofpoint-ORIG-GUID: lJ26hyvB2-dRK9M9rmiAHa8dr5c3zyUn
X-Proofpoint-GUID: lJ26hyvB2-dRK9M9rmiAHa8dr5c3zyUn
X-Authority-Analysis: v=2.4 cv=HJLz0Itv c=1 sm=1 tr=0 ts=69de74b6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=va74t0jcI0ebB8ul8YAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140160

Add the missing QSPI-to-memory interconnect path alongside the existing
configuration path. Without this path, the interconnect framework cannot
correctly vote for the bandwidth required by QSPI DMA data transfers.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 45b9864e3304..0efcda80ac94 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2864,9 +2864,12 @@ qspi: spi@88dc000 {
 			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
 				 <&gcc GCC_QSPI_CORE_CLK>;
 			clock-names = "iface", "core";
-			interconnects = <&gem_noc MASTER_APPSS_PROC 0
-					&config_noc SLAVE_QSPI_0 0>;
-			interconnect-names = "qspi-config";
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_QSPI_0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&aggre1_noc MASTER_QSPI QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "qspi-config",
+					     "qspi-memory";
 			power-domains = <&rpmhpd SC7180_CX>;
 			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";

-- 
2.34.1

