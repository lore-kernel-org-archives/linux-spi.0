Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478F381B04
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665608; cv=none; b=pqTGm3xq92gupUcPNGPt/gN6tEH6/yr3nHdE6lkUVBjS1pyqerol9vvziD7Nf2ELxNSnZvcHpHGtJSxwCpb3hAYb/AGI6iyd+HNc2OtZp0EYOyID7a1iYpd85S7JQggz1nd5NUKKz3pxPcUXoXeXxgaQG8jJ486qy7h2uNqYANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665608; c=relaxed/simple;
	bh=zGGHbFoLuQtJKA32X9nqq3tKPosuz+r9hAZ99dLWEwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7cA5MIhpg9McOC23WC8qjh8kQuz1Fbup2ww0R0iQ7bb5tUkfgzbBt4n+P8VCXdxz4T06gZviC0sf3LW/KV4UR0Q5KkHhDQflUn3SWmWVoAec5F/zt1FxkE5L2G1mvxuMMR1CiMSTcHbpgnkQB7UiaI2KodwrOxQjlPE1FrANpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GccHsOiZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jAGrj7O9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GccHsOiZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jAGrj7O9"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JKAI283243493
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q7mY8lTSQrgYkXdkCqcNJA4iP5y3VqBUOnbRE3q1D4A=; b=GccHsOiZLsjB6O0i
	P3c+ffb4Iei40nQmDbO1ReZmb0ZOeln2WrOr5sN7PP0SrNCiukP0OvYDwRtymnF1
	H0rcXir+1wHdqgwkcmh3Z7JUeZo9SsDOT42f+eyv3IbfaaamLSBwX+gf64Wiyqtj
	BTAJ7zXWt4d1SwQrp+lggUM9WBJNYNVdLRXM61Kk2AWMhK53QNLCf+2CRRuDt89k
	+n0fBPA78CWTinj2HunTN1Hp7QzhWGN9vRvGYlyEdaQ/eZ475coc4w4mzC0rg+Q4
	PZ5iE40moqA3/J/uwSVe5i8r/S+NuNTLee0jVJrfQhc74EiarFOJxrFSTvtpB6L5
	h+HdCw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm388m91e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c798fc1a426so60336a12.2
        for <linux-spi@vger.kernel.org>; Sun, 19 Apr 2026 23:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776665605; x=1777270405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7mY8lTSQrgYkXdkCqcNJA4iP5y3VqBUOnbRE3q1D4A=;
        b=jAGrj7O9uVA8l8y5IVJhq9lnP6XQDZV8RMiXH4X86H2UHQMC/e75rMxVl22XMQkz7I
         OyNZhFpRKYYnNrHn5HWxcM00HrlZC/ZP2oWgiiTcqujUu/dsJ5AKpmFU/Cmcy080Myed
         r3xBKmNpeYc4bzTYOX+IQuuo6M7RFyVQNKSFlA05BDTOLdGy7EXMkV2uzcA7Gsoewr8q
         s9pud+peUWHABG/RZUpJO0o35PQWdn2MOn13V0+16TCCejqckq9bt57Bmye3ABYOy0dG
         FRTDNo1zGSZj92moxVN0KOyHHIYiDNRFgHDxvCT8p+XuNEACBbDRcdu7d1x7MuQ69J89
         GGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776665605; x=1777270405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q7mY8lTSQrgYkXdkCqcNJA4iP5y3VqBUOnbRE3q1D4A=;
        b=ZbSTz6LbVdd8tketlPcRAhqiUeCbqgfzDXP2Ytw5eXQnVZUZIfKLbZkd22jSnaHJlf
         vqtCnmMxnpQBzK32vHBNkbx+mBc2p7+G3cYPy15ziBtRH5mIj0w1cZTFj0iTAR7rQ04f
         fLDVGvtBMFAum7KpM3Hps9wcW0ixdAhWQADgaueofg63kb0QLznz/Jn5hX9XRE0RIHdo
         FLetBshWWWURNxTvyVrZ+afFXmRaczoVaN8vweR+iaC6NtTBDvutWIVSkiN/hpHeQ8Rl
         9jFHdr0B4koj0e0x8o3xxa2TLG+PZDW5+ExonMc2hzHEajS4Yt/3Bam5BFj3zzGqqZc6
         DLDw==
X-Forwarded-Encrypted: i=1; AFNElJ8PwOMB9U3Qupfjvz54/Ak3a0KxdVix2b6ZkSkqEVMGxEehFc5Y9+kojLzS7Vqz/VqFSY2j/9R+pqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLx2urHRctkew1QyLIQ1yH2HjQBLcyMphqh27fZ5CCrDU4a5W
	3xqO7gj01WD3lZziWBF8kyphZhq6oBbEgNHix9x8MX5Cl0zvPGowvWrwOsrYN/X1dR3pXm/FWU+
	QKb9kmDZ90HtgHrL+UG9nitJSRdfbsDJYhP8ADDgNmhcYze2GkWxPJIK65WeVmsA=
X-Gm-Gg: AeBDieu7VxPyfjj6sIbPYLQK/o5csXunWTG7SZIoVZxthiTNlUD+JuAQ/mtGKyTvu0u
	/Zd2nvqpkQ0iJVnGADuWpgHcxxQi19OuKveUfcghQKKbKpXiSyAhRX4Knuqvjw7M9f6G53mdKyk
	uSACZgQaKTy/9orK8PQiIisWZ+82tPqwScr9sgvzX58SoxgXjBNPAVqWIxiOdqqDHNxRfmNY1Lu
	cNbmIWZvDp+d50fSmyhjV0hy22YgiTVkRuBA8JArzjjvcatE3yWRrlz49bsPsrds9POq/ERCRMu
	4opyL9Dh1CLDx9VEKxwf7Mugqki6zf4LjgHVqVubzX2g366Pktd12B96vU4yYojoWmPX9Gt98f3
	VxSgqzZt4RC5jRJ+t22vg6EfGYr8BfBM/QygRku1SSOWQoA6mujW8Cbfk3yFwxWMgU6UH
X-Received: by 2002:a05:6a00:ab8c:b0:829:800b:9fe with SMTP id d2e1a72fcca58-82f8c99a9a3mr12866430b3a.39.1776665604878;
        Sun, 19 Apr 2026 23:13:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:ab8c:b0:829:800b:9fe with SMTP id d2e1a72fcca58-82f8c99a9a3mr12866406b3a.39.1776665604415;
        Sun, 19 Apr 2026 23:13:24 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb28sm9018034b3a.13.2026.04.19.23.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 23:13:24 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:42:51 +0530
Subject: [PATCH v3 4/7] arm64: dts: qcom: talos: Add QSPI support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-spi-nor-v3-4-7de325a29010@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776665582; l=3120;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=zGGHbFoLuQtJKA32X9nqq3tKPosuz+r9hAZ99dLWEwI=;
 b=90XKx1R6+e2A9l0NCBIAtA8btFlf60e6u5ouuioK/dcl31az3v40i/HkgGB1Ul2NHZqbUFFIm
 2VNCx3t5EI5BlSoiMoaL6OAkheNa2QNp2Z1D0JIJ2CpJZVnXFxySUFu
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=GthyPE1C c=1 sm=1 tr=0 ts=69e5c406 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=NWNfpJqe0LLSB_FnjTEA:9 a=87zslcl0W4pG1hMJ:21
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: cELJ-iKdaKHvPPwgW64gsXouqajVrdn1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA1OCBTYWx0ZWRfXwc7+AKBOQdfE
 /I8HUXA9Uhj6/dvMuqjtpkKm0f40lukxyS05A/RKvBtHQthxlkjPp9Ewc7JDQ8UsyXLLCkbwjyC
 wawOznw4G/eEeaDA3ibT2hInevXnvwXLeMwnZqUQbJvKbvZRUPgD7lCS0lKwVp8N7YljjPLLNXR
 9h1g74WynEPK2UoijnPSMnqg9nXvl+LEMPJFrj/RgPTEq3oe0bSHlNj6pHUcLlLMxTAsrpYo+t2
 Y1HE6xaioiqB3vLzt6x4G+Z3owkR4Cr52VNswI74xWWVKGhjYs7VyRByhFg0ffzUtIy4Lc53QRv
 QlaTSaUUjMriujsROU2JTo4hgMM2wqrqCnmiM2fs+s4txBVV3oaMCGORZ3pX+xIoeGeSt7mIez4
 vlAibIrG7TTAARRG/VVWwWEyQ62nTDAkhgdBb30s+Mz1X08Cr44hJYFW1E6Gy3tl4tGyAP8sB0M
 wtnRA3RfPXUWXLFKM8A==
X-Proofpoint-ORIG-GUID: cELJ-iKdaKHvPPwgW64gsXouqajVrdn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200058

The Talos (QCS615) platform includes a QSPI controller used for accessing
external flash storage. Add the QSPI OPP table, TLMM pinmux entries, and
the QSPI controller node to enable support for this hardware.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 80 +++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 75716b4a58d6..4b67b3401615 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -530,6 +530,25 @@ cdsp_smp2p_in: slave-kernel {
 
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
 
@@ -1553,6 +1572,34 @@ tlmm: pinctrl@3100000 {
 			#interrupt-cells = <2>;
 			wakeup-parent = <&pdc>;
 
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
@@ -3682,6 +3729,39 @@ opp-202000000 {
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

