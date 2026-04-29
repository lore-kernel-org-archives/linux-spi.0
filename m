Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A37413235
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482129; cv=none; b=MuVWAa+0j+hQqfbSlpt/CrJPKYsFtlw5vzlv2WZD0NpVixZJ8+G1tA5gsAQmI5Z/GLgBnzzk3RMvWdFDrVrP47JHlK5VvreaLU2Dwpqg3RYB1GMLTsgforvW1if9oDSdv+IN/Q8TO9jujlfKZEfRyqHadyQnoUy/0lXH+DUTfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482129; c=relaxed/simple;
	bh=NbxUVY7Cr8u27hZfVARiPe/uaWSuVRtYLFGamRIaT1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oqz5rIY19hCuuRxlfLZTUtZLNEZL9lD4r88WQLPLx6tq/qVvWOjk8yceazS7EUDXPq3OXR7zD2GOY7ZnofVVny9ZBKvEbOkFvSEf8/ABhlaqDbDMxEU1eIx0/0ruU52hTQJPlo8TyjBZkJLoe0O9TgAJVtD3ZpJ/0z/e6QQc0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=estCKPI2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dvjb+P3l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="estCKPI2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dvjb+P3l"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF1ie72095332
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/jn7w3CeadBy1OTnp4vTqdzsrafgI/os35ZMqljkHg8=; b=estCKPI2ws23d/AA
	AR1ifEluxBtzakSnnSYxXRZRA8nrbB9o9R+2NAmpGfd5iJOOLoV3QlTCB0mEQw5W
	aKvg1rDFvootFysOIAu7qf9Cuk0rXWpTJFbX9bsXwso/27Vdy5MhyAMNRfu8/2wn
	feAivWYMI9pU/bBjnV/qE6qPmphz3WsOD4i4SVgVEyd7v1pN+O20VcUA08LikguL
	BOOJ7XcHHkkz1Gec6tEKiix9/dWYQFh9ytGX74yE+I6VgvwEYXT9sRCRX3eb5zms
	LnbKIZkZwl/Gn0ttpgFnZ5q+qANnCKbUvJLHYuTTn6YzxF3NaZkdf/8nEOqJjcjz
	Kxj+Dg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3tdfg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b4654f9bb6so55625ad.2
        for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777482126; x=1778086926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jn7w3CeadBy1OTnp4vTqdzsrafgI/os35ZMqljkHg8=;
        b=Dvjb+P3lwHPnCHe2dBBsfbQYo3w3a4CeGqGUO+iiJ1waZaHapkeKCgwecTlf4i0wMx
         gKPi1iCAW2jICSVCNuXXulnETVBhtGbLxEnjKP0dNv0N9E+hqN7neaX+owrHE1uQawU/
         RqVeU4OsSCmZDwC8kop0w7OOYL8CPq19lRXU9eEW5OEPY73RONiwolckpMVa0WMai8JA
         YD9j5AZRs0FczxKDdYw5ZAFqO4qqbfkhaAXIjvXcxgQoYtjhglqD6l1zrL74IqaJu55z
         d1oM3SLk3W+UBBqThY8zeVtLgNxqVvq3UkzlvGnHEzskHmpV4m/FaHZHIKT6SSl8eFP6
         LImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482126; x=1778086926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/jn7w3CeadBy1OTnp4vTqdzsrafgI/os35ZMqljkHg8=;
        b=fHxKZuhsm1ygoKW4aEKnnGl7hz7uOu8uN4SdVO8/ONK4o8MFxnNK+U//hI8HRmxe4y
         5BDkZj4X3yXDa9IhrxaE8szSmv2uZYmzk9JW69f/OlNQmGpmge0dLnjZhU2ZNROYBFk2
         8a4cEIqb/rpmFdhWOqkpY+arrneHOIXVSoM+wSX43RGBm70ScT+gUnL9nrHblqPNlYeQ
         pxSyZdXmdHW+sSzdj/C3EwacwyDPvwa8m0Bc3MaZKZn1vLnJCNFvAqdfA7S9cI4YERP2
         0clNrqIUpsG0xvZW/txYKWV0OM65MgvJpcn+ocPPTKY899COLbXgmrw09eFCcIAHu4zy
         +zAA==
X-Forwarded-Encrypted: i=1; AFNElJ8KYyEyABJ3ufY4YdExGGA4vl79JwIgpFgwIWsi5ksbiTl8ljjWTBhKAhTyjO+vmhgMNC2w03Gnwag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EJsve/I1+1qm7AWM5IioI5oEPglo5G6v9ft9FL2WZU2uv3xO
	G6DxPmedWni8vKSnAMufxmQ7CVVSJpdBSz7fDSBixKWV4OqpL1ET+KpiTXaEZi5cIXKXlt9cxAp
	bU+PAxxKXfNVduKgw4ZHX3292l00vchkpgY0RoKue+sTr1lWpxA1URiWVQsVLswlPiKotFFk=
X-Gm-Gg: AeBDievIsm+iqZCwIZA13COxnicHkoMcntCVBORlvP0aXBQWz+FMNE14bYnNAc4CJsW
	VpXae4lgH3sIjHyNOtlfc47ZOPqbXKBML3s1iip2e+JL0xmeF+EkygVj0Xcu9HEjlPD2CDKwUVJ
	g3Ls1NJjIPR501Q4plzc3DlOinVdQsXUecl4jmSq5TvIcN+KY6MCERFLv9AU3ZUPZipkwkywqWs
	+5pSj2Qq8YOYf+qLD3ln2S2/0vmfL2a+tW6pwOXLb+lXyJLGOv4Omi6V6yU/wcOl3DvSRC7MGO+
	dSBTOhf7x9A0wk1ycaxWbVZaVz4ZKS6afvfPCPvUvRSvgyCjpIXUfcoNYPGP7dU1zZuV50oxM3R
	n7tZW10aO+7iuhojV2w8TxOOeYp8nQNfFMToJCY58kszQZuBBtdxfyV3Us3s9sMXf7Cil
X-Received: by 2002:a17:903:32ce:b0:2b9:8ee1:73ac with SMTP id d9443c01a7336-2b98ee176f1mr24235175ad.11.1777482123960;
        Wed, 29 Apr 2026 10:02:03 -0700 (PDT)
X-Received: by 2002:a17:903:32ce:b0:2b9:8ee1:73ac with SMTP id d9443c01a7336-2b98ee176f1mr24234485ad.11.1777482123162;
        Wed, 29 Apr 2026 10:02:03 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9887853a2sm29530195ad.18.2026.04.29.10.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:02:02 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 22:31:39 +0530
Subject: [PATCH v5 4/7] arm64: dts: qcom: talos: Add QSPI support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-spi-nor-v5-4-993016c9711e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777482100; l=3170;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=NbxUVY7Cr8u27hZfVARiPe/uaWSuVRtYLFGamRIaT1Q=;
 b=nH4uu+GeW60QZJNodnvtK4N7vGyIkYvXMgy0WWvBuxYK/rrvOsp4Kwn6KiXc2xvqRdMAw9JwO
 gEa1LT6ckG+AxvemqB4K0sVM6tPSoEQlqDbOzMVuf48S+oOXlGU0HDU
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-GUID: yKlsZthZ6-vEtMQjURVwVt_iaTcQUa4z
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f2398f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=NWNfpJqe0LLSB_FnjTEA:9 a=oMVJaGz166wJ4grX:21
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: yKlsZthZ6-vEtMQjURVwVt_iaTcQUa4z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE3MSBTYWx0ZWRfX66fCepkBkpds
 s4lU59ogqBREDQ18BZKCsNn7NH2BTJEE3w6Uuxl4Vlk7u0PuqruSCQAWEYNCJ8i1FR8SKNcfyeP
 pQjw74dh92C+tIlsPcuru2T4yE/r3lKNkMa7/SMS6BW8wq3mivqBoAQi5JGuWigoyNA4N9GPSOi
 cLSwERJf62oIb2E4/lS4Iq85B4c+vlzTmnrkoF42cD89Fwx0iT98Z8Snir18/aZBV4FAJeUHbK1
 5tl9gAYdxXbAqAEG722d6hDvpCE+lIZg3Kzoft9gYysKY9iFV/Q0SfHwfVr5Af+PQe4I840jN1x
 VyHlHXS/pl7IXz/hya91UvlFB09DYWw6VHjvlqSKFygVcdodoDjnGELpgV8YL8aMblkSIYTqgTh
 ilOb2ZOVwAdxu22WO4e2ncBRPiV1eHZQROScuFsjYEO0LXLWqv0Rihi0pvmBWnfNxlSSSXESnX6
 BQ1LTiqOSA1GZlzE7Jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290171

The Talos (QCS615) platform includes a QSPI controller used for accessing
external flash storage. Add the QSPI OPP table, TLMM pinmux entries, and
the QSPI controller node to enable support for this hardware.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 80 +++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index ff5afbfce2a4..8c7ea369a332 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -531,6 +531,25 @@ cdsp_smp2p_in: slave-kernel {
 
 	};
 
+	qspi_opp_table: opp-table-qspi {
+		compatible = "operating-points-v2";
+
+		opp-60000000 {
+			opp-hz = /bits/ 64 <60000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-133250000 {
+			opp-hz = /bits/ 64 <133250000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+
+		opp-266500000 {
+			opp-hz = /bits/ 64 <266500000>;
+			required-opps = <&rpmhpd_opp_nom>;
+		};
+	};
+
 	qup_opp_table: opp-table-qup {
 		compatible = "operating-points-v2";
 
@@ -1610,6 +1629,34 @@ cci_i2c1_default: cci-i2c1-default-state {
 				bias-pull-up;
 			};
 
+			qspi_cs0: qspi-cs0-state {
+				pins = "gpio44";
+				function = "qspi";
+				bias-disable;
+				drive-strength = <6>;
+			};
+
+			qspi_data0123: qspi-data0123-state {
+				pins = "gpio45", "gpio46", "gpio47", "gpio49";
+				function = "qspi";
+				bias-pull-down;
+				drive-strength = <6>;
+			};
+
+			qspi_clk: qspi-clk-state {
+				pins = "gpio48";
+				function = "qspi";
+				bias-pull-down;
+				drive-strength = <6>;
+			};
+
+			qspi_cs1: qspi-cs1-state {
+				pins = "gpio50";
+				function = "qspi";
+				bias-pull-down;
+				drive-strength = <6>;
+			};
+
 			qup_i2c1_data_clk: qup-i2c1-data-clk-state {
 				pins = "gpio4", "gpio5";
 				function = "qup0";
@@ -3896,6 +3943,39 @@ opp-202000000 {
 			};
 		};
 
+		qspi: spi@88df000 {
+			compatible = "qcom,qcs615-qspi",
+				     "qcom,qspi-v1";
+			reg = <0x0 0x088df000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+				 <&gcc GCC_QSPI_CORE_CLK>;
+			clock-names = "iface",
+				      "core";
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_QSPI QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&aggre1_noc MASTER_QSPI QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "qspi-config",
+					     "qspi-memory";
+
+			power-domains = <&rpmhpd RPMHPD_CX>;
+			operating-points-v2 = <&qspi_opp_table>;
+
+			iommus = <&apps_smmu 0x160 0x0>;
+
+			pinctrl-0 = <&qspi_clk>, <&qspi_cs0>, <&qspi_data0123>;
+			pinctrl-names = "default";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		dc_noc: interconnect@9160000 {
 			reg = <0x0 0x09160000 0x0 0x3200>;
 			compatible = "qcom,qcs615-dc-noc";

-- 
2.34.1

