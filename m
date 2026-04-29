Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E62389472
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436594; cv=none; b=m3nSPdkChQ+XZELYcfs37pJ9ktV+QdKc74/dzj/d2Cl9ia3tenLoRCx8u60TxP5/V5z+mQ3jbvDZvODdURIbIRtHOUON8c/YhiEJl/Mw79ragAnEqhoO+fWOziZHw/mDTNaVZjHuW4reqwfU0FVYy4Jmxy/O6FofXCKbRr544+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436594; c=relaxed/simple;
	bh=Od3ZwTtQdbzBvs50T5pyXtz3cBqHTKlOz35dqlKRPvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ivi+MNS4zKcPwUSCxmf0ml6NoSt9DhwrBGrdhlZi7BzfXSzX/qaytTWAG9zdhP6uV7n4as61UIYbwlslbhYvLElsVctG1Tc9Qjxq+09BbUu4STR1d1oNoMkoLc7c4wDizWgRyZS8EC4olTdxcG/YciWcIkJAD0JNtOG4DZrNwhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E2/Xp5mO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L1OGuCx+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E2/Xp5mO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L1OGuCx+"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T2gbX13184101
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NXzfs6q25ToiACbxZcaxpEL0TnFQ1btzx5ESJx3d+/E=; b=E2/Xp5mOHfZqkt5i
	gQiCVcwXliBk4HGv0wvRY0mfHuUCk6ehrC9GHqeOVWNTVb0eXCuZx9ybXCVVsR9u
	VEehBoLTG3Xi/Vng5yi/hNkI366A8jyhSvbyuPh8d3dnHI1JcZkiNMfXut7gnFQE
	dtMILgIs6M7KbltgYn8hC+CcQeOjNaWmd7J9MQx9MSttTVua4q/yZUtf3qAdRX8O
	QceC/qwEekEhpsf1eZXFO/AGROcUUePplptBFr1TXPoOH/Pk00eefp2lAWRggjFO
	893GDw9BDubOeOlj2t01lMP+Md4al+bmpFhViVgosLC4y3L6niTeD6E7ZbFuCPwA
	zbD0FQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du9em08ra-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:12 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f460260cfso12442493b3a.2
        for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 21:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777436592; x=1778041392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXzfs6q25ToiACbxZcaxpEL0TnFQ1btzx5ESJx3d+/E=;
        b=L1OGuCx+y3mJmHGXit73kfHgswHxm3eLGiDUXJqpw4QJrDpSepwhxQGFpmBuMgBut/
         DJynEn5b8BWFaJ8Qr4WiAMjmBcqHUqjU+4tVceaEBdH5XiNHYac+8yjU+i9OfQZ0tnhP
         io+D4TjWeKuBglmnOPnlcEFgJMqRU2Z4jRqEtavnKL40nT9jEEhZ1VzXfmQCpLo1BVpa
         F/QzFQ/qnMJ8IgfU8Noe4760zS8UVXzU+VgFLlZwlF4m+Rngm89RrI9/mwNIMX5lBxk+
         Suss1wPujd2qmUi7eoILxff42n+57z4n3BvyS6aCGLohL7G3VYPDaa4jnnT4wI6+f2u+
         tfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777436592; x=1778041392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NXzfs6q25ToiACbxZcaxpEL0TnFQ1btzx5ESJx3d+/E=;
        b=fbVay18f2FP2JqWj3GkIWkwFWlYxyFUF+qfkQcyyQFVh3NKgridOQAOC8ZB+B9euE4
         r0BpFW+NURLFcsaBDfcC+c4eEO4B1i7M1xQzAJG+5m87QWo6b21DUHGNQia7KPpSRiff
         uTlhpdhiOA3raQSvLgnBwWNfbzgIYhI8fHBQdEfCKHE4ZlO6f3Ds9opxnMbEG3Xn5O2/
         ndgeKAEZK4Pxe3gigUjnN0T7eVTYaKZejEIEUN/FHUWXHm3BDr/1uqnOoKBhxqjwC8VE
         HZzlAnfzlcFToZFVVMkHaqNW9RHiV05jC2O4lO+CrSBKKjDGX1UhnHV1mPGAiFhhiFEi
         kdWA==
X-Forwarded-Encrypted: i=1; AFNElJ/2smnAu7JJekh6FwNDrB2oB5v4Xwf2zkepZHvviF1UAI3j7Ko7X/LxkVe4M0SMbjvsWPfmA3pNC+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHMOANaj612as0aNqM8YPUZGPoG97CshfBf4LLXDRjxNxFgnyb
	KtRkhkKSpBb4gGBN+ZLbVWyvT5n6VTgfcWNp5niEUiscbkDU92q8dm8V+Ulogelmmeyia0/Vcie
	VakG800pHAhWuM+KZK3TDEHBFSdUKJ8NxJ8RFYmIw7JepA9szm+IUuq43TX+yIYU=
X-Gm-Gg: AeBDievbaqQPJ+4ddPmtzdlrvJT5u+904wA1Q3l4AkiOms2n2QBJ4wWYwKLvXkNCPhQ
	lx2WhAEiaXxnSuxLiyhuWQVhCdOOoDkV/eP21ouvc4TwbJL6TNa7kTDqiUViCj++NfPGQmNToDk
	cJH+FAO2/s3UVRH6MGKmyHIHlX9mo5VcsjV1tQIc5p0sdL0jqn2gB/6ztDkqDC/BUP5RSlGVPP+
	6GRbmQtTLbK+vEOAtkvum4CyIytkMC6yJf6RW9UsO8L5bm/T4iekbynTioiGLSsynBUYWu/QM44
	Id+D1qB1yCV9l0ga8gvJMZUkb0JCQtfl/uzO03uJe+v7KdT3XOQAttfjjCy6ODcYy10FLxu72nJ
	cg36JGvfOjETNb3kCxhhMS/AYFKYzJiUsLxaa2SSp14XnCHn8AWLACrLBs2TDg8oyzw9W
X-Received: by 2002:a05:6a00:3e1f:b0:82c:9126:31e3 with SMTP id d2e1a72fcca58-834ea66f475mr2073113b3a.26.1777436591658;
        Tue, 28 Apr 2026 21:23:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e1f:b0:82c:9126:31e3 with SMTP id d2e1a72fcca58-834ea66f475mr2073086b3a.26.1777436591218;
        Tue, 28 Apr 2026 21:23:11 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5a074dsm602200b3a.10.2026.04.28.21.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 21:23:10 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 09:52:43 +0530
Subject: [PATCH v4 4/7] arm64: dts: qcom: talos: Add QSPI support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-spi-nor-v4-4-73fb1bab03ba@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777436569; l=3181;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=Od3ZwTtQdbzBvs50T5pyXtz3cBqHTKlOz35dqlKRPvA=;
 b=BTqEppcFYP/2x6aC3E8WoATyYEoG5IxVWs7rmObqC4zlWLKsX/1bhGiR22QA9o2kfgEFbmpa+
 DjR5e9dSZFbBfEvmS4JLrOAmctAtVpwvQY6jQqHtMBSg0RDw4nIeQtD
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=bvd8wkai c=1 sm=1 tr=0 ts=69f187b0 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=NWNfpJqe0LLSB_FnjTEA:9 a=oMVJaGz166wJ4grX:21
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: BGL0Ka2lgTX3atSoe5jGgTRou72O3uAN
X-Proofpoint-GUID: BGL0Ka2lgTX3atSoe5jGgTRou72O3uAN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAzOCBTYWx0ZWRfX0IAuphBxiCIL
 bDI97Yiv7yt/wJiLmaFNxQy7OtvMyvYeVr7dRE4VH/dWRUit135252oL64QKc0NW1q3DA6IWxPB
 CGiIUceB0gvVIRR2Vg9ntNvrtHXVpF03rPpWB6hDJmyZf2ufeAYcSwPYIzLk1p9S1DKEq16zSwJ
 UI9++370hy39GJbFwKVwzVxkyq8W8MiQPyeGH3Olb2T/F12NY0vUI4KYLEHuD7DKzS1IzbD0PUk
 7oaYdppt6WS4mY/lCYXlvbQ1irYmBWGE2gwsQnQXYAC+t5whL7VBwRIQmoMjFxC3jeUs+O4btp7
 vLXsy/LPQOKAh08UCSZFaisevgyhALuWpPQhO7wNDBxIfXT8rpR87AK1szEj9B0djW00tYyMY0W
 V+/uRX0JF9LglQpJ+2JX/7c1TWEXFpaJaMCKh+7wW7v40ZLp+X9HaCFDa/xNzAAhwxfw8GtXYGR
 xxmiIgdgRaIwrwfOWEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290038

The Talos (QCS615) platform includes a QSPI controller used for accessing
external flash storage. Add the QSPI OPP table, TLMM pinmux entries, and
the QSPI controller node to enable support for this hardware.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

