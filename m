Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91412E2DF3
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186549; cv=none; b=bk1foLrpF7qKEhT4zo+kLn5bNKg2HYS4wFcVRG+1Qkbca4AAd4pCFEGZqwTmxyEP0oT8WX1Yk5a+bcAcA7KhzrYuBI9ijgoujQizV/jhJ8MsxO8Ov4ohRsyPbPbX/q2jWvtRymU0UCIN3LZWvtDD1DLN2GMyfNzzgIqmrR2Snuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186549; c=relaxed/simple;
	bh=IpvPgvKMIkkzzFuFPdE8c6VPCt08BcGP8tSrCPowhjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4EXhpylD5PqwnVrlnDklmXEGhp/KgtY6inW7mB3HtKBIHGf1G472sPN9FS88Tb1BBql2/UGh7mgNGZiSXYZBdY3aISewzk/AQSsiEnp4iz9gt0s0K88fM6O0XPA6byUlRufJlgnXG97wFi63k46qSP2mDq3HHepeyPvw7NJZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KfMsmIsy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P3ytqozZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KfMsmIsy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P3ytqozZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EAwntX395640
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PD6XdSaO/3pyxUrUmVsiAAOynJN3mgln1X4YOSNbMwg=; b=KfMsmIsyVs3OTNx/
	/F3lgE92+o9mgKmKKzRmrpvknECcE8mQ0Wqd0t0PG6brCsEr7NQIbNg4rymHPQ88
	E7IY9S7lVPuh94tLSa1Jw6BgtQlKsAuwjUNHum1M+LrIElM8fUHsggBroFP6GbHq
	YpidaHK/qY0dIINsPD+rq8B1EzSgVqC+H4cBxPWje/ZEgRXOOwsax4c32bYeL++B
	iIy2XJ16vbY8xkKwjLZC6Li/bRtyps3BiAkjVDShWjkKvHE15jSrk8apOYXQT2V6
	EyPdawnZgrLQ9+dpJpqMrmL7DTi7SKdbOwBSqGW7p8krWQnoShXFt6s3Tjf63UNm
	xMb0aQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870uqsf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:09:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2e06219cbso37846065ad.3
        for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776186546; x=1776791346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PD6XdSaO/3pyxUrUmVsiAAOynJN3mgln1X4YOSNbMwg=;
        b=P3ytqozZPbF+xdxj99E1vkdXJ95wOBgg83LFB0ClLRXiLc4Pa8SD/68AsuFLZdOk3V
         /DaHSFhsY54ndqqAyNORdmWW9FJRQ1DfvgNgX/ZaQHtuVgZF6EwFHQEaVsqImEi6SL9y
         qqglPR1viC99Z5pZct3T42SRr7+H0WG1trMkqApyEsyHL4Wjodu3oMULSFac48QGcGu3
         sOuaJ9AGS4Th9qIjKkVq5LrKmQBxeebfpFDHLbk/V56M71uRfdY9NodOQb0L5u6F/1KH
         HmX8YQjH82cLhrurG5vFPLc2ZitKl3xr3p5eFDlsq+bewzYOjyMAToydCxYyL38zMxpw
         zC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186546; x=1776791346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PD6XdSaO/3pyxUrUmVsiAAOynJN3mgln1X4YOSNbMwg=;
        b=Wx/F6XBx5siUSTEzZkMFYj3JkT3a7ip/a0CxJtTxElBXwyUZZpjQpKq5Mgll7UyoHj
         6uAKYdJ9BibTEvcfT8JMQBQBKytOpAdyHL2aDZkai+SooVMz4WsKmCBWiICmoi5Pdrmw
         u6C76nX+nT6q59fUd/2rejcyGna+o8wwdWE7nPvCz33D93NLDxurkOVF4wyJ2XDREfC2
         i1eEs3vyKbRIFnFp86HvunAHvWnFdvp6rclrNSxnQ+Shv3tF5Qfpg5iKy0+GTUDrRMR1
         GEKd48WJjVeu6xWFJ8PS+mEnm1Z7lqiuJjimPallUVY2Rc7Bte8ENlUj1GoraTp6bgd9
         pY1g==
X-Forwarded-Encrypted: i=1; AFNElJ9iO7cF766HtUYq8R3xl4wodMwueN+9b4SpIvobduWo73Ha8479zwfT8SoLz2r1IvcCrxmagY+Ssgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyinnZYmgHrz5jp1YRD8d/XQ3AZS/nfZqF3MpgjgtnMtL2dZxPy
	UWp2fnpzTrvw9Nj5AYKlfr0YitO5+HGN/S3XiK4OkKhg0nITdfDnxhsM4KSlc9JrxjzuBbTl/Kd
	mDawhjmne0LG58SwzhJCVjxdXBh02qMzt0jGNU7QT04TbLMfm7iV/dBLajfbYTvM=
X-Gm-Gg: AeBDietKw0MyLierp7coWP9Vi74a/yT4KlR+/TMeNZxK0LNz1Mdg2rd/M7vkxVMum5V
	iZ9+7Al4cJnw2zkoijqq/EgxFmcfTvunbcpkTmo3jTag3p4NcPjS/BS563nz7lgcGFMpGcqZqnh
	yBoC4+Iwjc70XzOGhNRO5ltr3K1r2Qx1WnZ8dwes+N0nYIodR2gy6T8PIkyXraNIizidWM6E/mb
	qsAYjtN7dXCc01kNk9G8nsPcsVYaOFpurAPXffP8IiEheUh19R8h6s4hk08fU8/lSnl/7CWFd7g
	LDv+7pLiBuR5W8llzx/w3chYBM64nlFhlbrpIk+JNKEryGTpc25MIB9yhr0ENZz/4A28+MUp0/4
	4ZO7v8g934VK2ulVgOneOzid4cAOVCZ+331QuWw2Mn/9hmulRTS9B2cUk0P/DHfs+tKvV
X-Received: by 2002:a17:903:32c4:b0:2b4:62b8:70a7 with SMTP id d9443c01a7336-2b462b87453mr76584115ad.10.1776186545781;
        Tue, 14 Apr 2026 10:09:05 -0700 (PDT)
X-Received: by 2002:a17:903:32c4:b0:2b4:62b8:70a7 with SMTP id d9443c01a7336-2b462b87453mr76583605ad.10.1776186545247;
        Tue, 14 Apr 2026 10:09:05 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45d1ab540sm97535225ad.40.2026.04.14.10.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:09:02 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 22:38:24 +0530
Subject: [PATCH v2 6/7] arm64: dts: qcom: kodiak: Add QSPI memory
 interconnect path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-spi-nor-v2-6-bcca40de4b5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776186510; l=1326;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=IpvPgvKMIkkzzFuFPdE8c6VPCt08BcGP8tSrCPowhjc=;
 b=Tf/WwFzZ9RHByip5fK+/QOX//b7aOa3kLk9RgsrNcnKM2n/VJ44h7b2fdiG/8/UwH8FX4mFiW
 rBGwEzL9+FeC+K0NyVsXC+SVImbvnGl6tEx8GETDbEZbEQ/eQjpNlKH
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: lrNcpYyKXUDBAJ7sXw4j2ZX0QpDdZWtw
X-Proofpoint-GUID: lrNcpYyKXUDBAJ7sXw4j2ZX0QpDdZWtw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2MCBTYWx0ZWRfXxlv23vapwAMz
 b8lKBuqIyOWmP9U2D5unyaf+Gg5V1OQ4/bE9C3C6f8uln2P9Rra2BDCjvZC8IRWzV90n5ek7mpU
 NvV6Ngi7A1uOicsDorxMEfP6i4u3Md3M1S2MnORSlfE5ZDbLv1xTXDz/UGBa+NbJKeeFL7HK/xn
 Txh2tQcLWUwmnA18bVogDZJigFPkhu+SAF3+S6K3k5Lu2Jp1b2vmMMDUBo2UFAlKCKnsRTAixJH
 luiPUpElgN0JUW4txDb/WPN8ROfnJ6A+CAqUtZYPGWmm76ptonI1jNrRMEanzTH1K7remqhM0nw
 gEdExjzQ2km8joLouWbhDklzf81LfQITMgQ9IVsjEgTjCvMEQSTsyhxP4xLh2a+paQEp/UjDtZz
 Z+s0EReV0DdQc6uBcwA/9WfNBR8yINh8YnMpVX9MSIkPdISNEDk4xyjb2V1xDJyiG+tLbUvWI/v
 +STryC/7lNrLdTyKOYw==
X-Authority-Analysis: v=2.4 cv=MK9QXsZl c=1 sm=1 tr=0 ts=69de74b2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=DDoZI6XnaA0zmnrO1bYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140160

Add the missing QSPI-to-memory interconnect path alongside the existing
configuration path. Without it, the interconnect framework cannot vote for
the bandwidth required by QSPI DMA data transfers.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 6079e67ea829..105efb4b3aa4 100644
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
+					<&aggre1_noc MASTER_QSPI_0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "qspi-config",
+					     "qspi-memory";
 			power-domains = <&rpmhpd SC7280_CX>;
 			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";

-- 
2.34.1

