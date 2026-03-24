Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B623F8819
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358054; cv=none; b=IIHK1AwpLg0n74l3MZqAJSQy2gZiGk6YqNVDawQDzr/wxCpnPEb2MgzRqUKz4E7VRBnhEUjbiPRR0JOAseLxDVt5LfuOthtXtda83FzS57/RklgxZ5QRjfsVwiwrS6ZKF9kMiTUXvtahGaf0ZiJRkQponUnxECHTq0IttCBnLkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358054; c=relaxed/simple;
	bh=J81J+LY4cXmCfiCa4VAaJsCHh1Rz+x6O0P/2zIEpnlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzoHdwKjEpq57uqepf1i6ajTXaQc/YRY3ECTjqiI92FW/WlZRNdwOqw37emsLzVIgLHPxGhhxj9Tiy0wY7KOOiK49RX2SUGC2j5Vd+GJLZTOd4dSENqaMsdKB7gzr9cQ509DuAEJIAVJxCyN3rd2z+dDpzJ7/+6YPfPzXSz4z8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DRASGFuX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cC3RGQLa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DRASGFuX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cC3RGQLa"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OA7iiS1761789
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D6L8r7u3kRPBrzUycGNBvVmzelB/6ESNzHI9KDr8D5E=; b=DRASGFuXd3ppP4MS
	ewLmqstG4/Ue6l6HoHa7ByUDGOGOnbnhmHGbSQ6GqsG2lYyGVkgLGMxnYjGVtBAJ
	mB4bk3dORX/LSlKwPhdVXuVwkfXqvcx3sTbNiJD0zvF45PryJkrkY+vTs4iuv7bg
	ZRp7hueDGSTHBdydbR/V2X3NRqRDm+4ZCZUslEySteh+Wyf+Pbol4AX3/NS2bBtI
	iCn0h+ksJJu1hHF2DqSa2se1sWr+n4l7ocMUmgOPOUXBY8O7wi8cPdK6YDQJP9Wx
	uWQpmZN3QABCeGXbCiWjODg4XAFGsRvpacuLpbB50M8K27mdA2yuipCe7vtPZdUV
	pRBQhw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d36f0cm8a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:14:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82c613194caso520600b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 06:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774358051; x=1774962851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6L8r7u3kRPBrzUycGNBvVmzelB/6ESNzHI9KDr8D5E=;
        b=cC3RGQLaws0w63YHm/S9myKk1gEUToDWB+nZ0voUPCPJYYzPK2TNKm4C8NBaQWz6pE
         CV8atHlIWsMAdix3tRvopmy5r7rSVJatXtb0aHolsIVXlk/3O1pNyvuv+nc0b9livKH9
         m/sXQnWiJDCErmvBF8fZuyh4+An8T+4jtwkg2GL/MklhBInL8g5OzQcttnSR0VuiMV/t
         Mabl6du/tJCuXqf5x3wdrotygkFqfjNvIBnk70Lgg3saD50YG0SADU7XVB9Nbk7cnXAa
         8y34ZBQw0cSsJbQi3kOJWOWY2JXr5XasSlf9RtB0PlBLQQ86fEBxSmEChJZbMD3VSYrd
         PRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774358051; x=1774962851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D6L8r7u3kRPBrzUycGNBvVmzelB/6ESNzHI9KDr8D5E=;
        b=RwQxSjq02vfN1N7XD310nAIEvQFQ7Mo5hfNQMr+voZe0iJDuKXglg+FlemnWKLasSZ
         nuLOUrG+saMWQUfvMWF93VdXAmpgu5qhpy6atLfngA9i3YYn4zXeaTef/6CkRM7hgdFj
         dpiUpcCHkSXYF30TM2WG00I0owd2d/V6/Qy+/fiuzKK4eEjmO3S4VDsx1xYMtC1sga7Q
         3caUO3MwgZpgmu/e+pl0ZCOYYa43AB31W/YpPitAjGVWm7oVBf4XxqwCDRuLSys3zNXm
         D/sWWvbFIuCUO4i6KKr9POfQ16639PgnE/IBFUzlPFWOkWEwvCnr7Er1/xzPXSig6pIT
         eK0A==
X-Forwarded-Encrypted: i=1; AJvYcCWkqN/url98p5Fty4IK8Knu49zMuIlHpxgyNMRxZLvtjG6NU+4ofL7SJbH3zhyIyZRBsR63QsMxgvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYiIQNie1DBSBpiYkqesZzeCzG05kOX3FhcMLW4IzfzX9GVJG/
	H8FgSVvBcZRA7NcaIdmbZuzZ1DE8zJByFyX2IswhfyI1n5XU4PZoblIZO3/ws27RB8MZwrnvVYQ
	hqjx8BayeQ+KbvH6O32AU3XxUSkPdoSaBVQ9varqzUpaXNHcgSVssqzTdyCAanaY=
X-Gm-Gg: ATEYQzw1sRshrB+/gVzA3vuAqZr+vwfMFxSUnnU46feGeJD/PmgcwgEBfjwXnqNWM1p
	L9koF2VhCTungVDrw8Cn+7MpmoH6fNz2y2wN+pp6pqGS08qAFaxdDjLolLZAG08pKPYNzAQK3IK
	/JtMwnHFR47zP95yzxaEwC+iZ4ltYw7kuW3QimfOYMcfx7YGhLmIJ5TOH2sN90LR1V6nYy7xXIV
	ksUvMh1k0bp4QacD5yIWIVy+KxMbPjSMeG1lS98b7yS/LUNkzJJl8RDMZOGNuZhFitOMIdd9LIz
	o8PlVJvWWg7S2dXuRdxGVw9F0gSr4tRumRPB7lrdkV0XLMvrUgSR/IIBeQ5gRRZgVleiNveA9Ti
	rKysY9M9CpoSimUamCPSOMoI8DwaA1tPLJK7fey3DsxVZE0OuutR2T96W7Q==
X-Received: by 2002:a05:6a00:ac8f:b0:82a:7471:eb90 with SMTP id d2e1a72fcca58-82a8c35cfb1mr12912719b3a.30.1774358051037;
        Tue, 24 Mar 2026 06:14:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:ac8f:b0:82a:7471:eb90 with SMTP id d2e1a72fcca58-82a8c35cfb1mr12912697b3a.30.1774358050541;
        Tue, 24 Mar 2026 06:14:10 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03be3396sm13517528b3a.27.2026.03.24.06.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:14:10 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 18:43:23 +0530
Subject: [PATCH v1 6/6] arm64: dts: qcom: sc7180: Add QSPI memory
 interconnect path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-spi-nor-v1-6-3efe59c1c119@oss.qualcomm.com>
References: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
In-Reply-To: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774358021; l=1241;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=J81J+LY4cXmCfiCa4VAaJsCHh1Rz+x6O0P/2zIEpnlo=;
 b=s2as4jZb/if2POrhGPP6bsTXfyAPk2SizEeol2/Y4TkuVyXAj4YDqafcBA2ytSSCtp3JipvP5
 zK0i/PhqDyfCwW7sYlONDOqJt4FvUgAWnHr7EmM4BSlYGzWxQINSqi8
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=b+q/I9Gx c=1 sm=1 tr=0 ts=69c28e24 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=L5xbH5DL_T0GcX1SYtwA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: QbsWJwRr9vmtyycvr1rtsI_dKOzBBYIN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwNCBTYWx0ZWRfXzLepFqg8hxBo
 JApX6MTVQT55SH5sRkWXmQENxHF+UEsmYJHoTBT3f6GggiBtVrEvzNF6obTEduJ7rK9qo8wRKhV
 s+Acpsi+zHoXUh+S82+P5mckwTx8DEMVXFQHplPZdWrhD8u1fZdHqVcPat2F+kKgkf/qoJ9sZ2b
 LYrG9R76PaPa+f0qCbZ9f6I4QuhMR4hy6It/2C2SeOl6crZRQfcv7r5bIrTzceBOme1AdgQ5JZ2
 i2pAhsv8z4ChP7XEv4zUVAWXMW5o7y0dxVI5cnTa+yFA0W2/JH5KOK/XGWkjGlykS4Li+yK6Yux
 FkdB3pe1jxLqwXXzsmivUvaysbZclm0qBa3Lu4pUQZ7TuQjW/QipFm4rtFhdpIvg5ypkvEaCzfp
 JQ7UJAIRM1OIAPrwY1ZwsogaELzB1CQXqWIn0e3tANAIZnga5j4MQQZldLrRqMRiQctGSvP6dJK
 cMC+M3gs/4EpinIsb2A==
X-Proofpoint-GUID: QbsWJwRr9vmtyycvr1rtsI_dKOzBBYIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240104

Add the missing QSPI-to-memory interconnect path alongside the existing
configuration path. Without this path, the interconnect framework cannot
correctly vote for the bandwidth required by QSPI DMA data transfers.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 45b9864e3304..7093b39e1509 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2864,9 +2864,10 @@ qspi: spi@88dc000 {
 			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
 				 <&gcc GCC_QSPI_CORE_CLK>;
 			clock-names = "iface", "core";
-			interconnects = <&gem_noc MASTER_APPSS_PROC 0
-					&config_noc SLAVE_QSPI_0 0>;
-			interconnect-names = "qspi-config";
+			interconnects = <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QSPI_0 0>,
+					<&aggre1_noc MASTER_QSPI 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "qspi-config",
+					     "qspi-memory";
 			power-domains = <&rpmhpd SC7180_CX>;
 			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";

-- 
2.34.1

