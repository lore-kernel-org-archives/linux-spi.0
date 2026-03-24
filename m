Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60253F8815
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358042; cv=none; b=sbwxE1DqIKxWVlMoxI45J42y1aQ1tSO0ub2VCEI3PMBvvoK2+NWVKK0YicjDB/GDZDgmYpLfZI+aqLwSJ3kh67MxwyEO74R86J6r/IQkw69dGkCJzAhDI+XN9Vsgkq4gn8ldR9+9XJdieHaNiSTQSyhowNv9m4bsXFY+z/DdRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358042; c=relaxed/simple;
	bh=WXipHHaMSghZTjkBOpnJEI3bnyrHeBcaQLZJ/3xgUYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjcvZbD4D1dxzDWtGWcUFgfeaOtNw0xqVsoDZPyu/c13Lhw+TAFin524Zj8B9eumGuG9dewwr/hDhNXpv10PgBDlQik55eZq33fAWX3caw+MX4F0eI5pv0sQpJX+thWobZqXhDQXEbTdV9SyyvU8SUA/8gc9KCm3IXoN7eBux4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JfDcLY2n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aaStUaRo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JfDcLY2n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aaStUaRo"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O8xg5t2322865
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+09D4ZEojkjUPpZ3Pa0bm6VEOfzKxGqmEjdyH+dgNWw=; b=JfDcLY2ni8aL6QYu
	8u436Blw82gn4wj75myCYSZ4wBH/Uds87Fh4wZsrV5dN/N13ZoIQESCNEiyP5yWh
	6g7p1I6uQXGyh/PRvpyfx7gHStnfakRhiZbuvcHFJHJwbRXqBXYECp60+jtr9Q46
	D+yh5PnkRvVDGHnR5vTeLTfOT3j8ClCX7XredHOXgnJgZIq31ga7HQ+68ANnb4M1
	qsvSim+/HLTAbkCFJ51iXO2vFmLwCAlCSA1BP9GrTVqsQ7IlkyhMUxf2YJdabYv7
	ZNp0SOAZOcxCfWrv8EURJMyk2FjQO5pCZS1FEE/TR72xDynBFb9vy5H8VkVFD9sc
	70jFTQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3qkes0gt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:13:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c7414179cceso2490922a12.0
        for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 06:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774358038; x=1774962838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+09D4ZEojkjUPpZ3Pa0bm6VEOfzKxGqmEjdyH+dgNWw=;
        b=aaStUaRo3XtMKtWx4WgDDeUHijFl77qzmfc2PvotAN0jEd6hBskihPoTMS7Vf+vJlB
         GN0cuTmeCYcVUjOgk+nXBsgFTDNx2T3DBxUEiFGGU3WsRG76Vwp+BiMR/zogMsb6aSsJ
         wBRz2bGRkKx4mmgp4EShTFmwfeVMTWmna1c2BCaYbIdZ9zIsN108O+mOVF49WncMvdM1
         W/vnjT6+luEdacbjF6iNF5QU0Uq3Mf9Zf9roIk/TGH7ByhETj5zbG1EWkuku3JUzTCd/
         T5nt2PyPcJOGzyVBmaj7p3fV0JQB3zbGIIsCN216XaHZhKo8qRSUzKbb6xfgonde+Ll6
         dVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774358038; x=1774962838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+09D4ZEojkjUPpZ3Pa0bm6VEOfzKxGqmEjdyH+dgNWw=;
        b=C/ykDnJFJD2K9yuNo7a06PE/3WQA4VVnpcAj4E2dVoQMVVu2AcSpU/Rcf5U6rubCZ/
         INJ/AojIxmWBHLhCXkIV1UwGfIAYsnrTYSDa2V1V9AAZ7pTsJ2f+YZ/lqyhCel42lOJJ
         C7p6OSlvzYmi+5/soXkcB/6Z5KLDhxCtEWYLWTStd/GChHC6GXWRBX0lDmWOmJ0ZekF+
         kA0Loq9Xdy1jhm7+scmEle0olEqmPko1RNEKEv9CziBOaMKe8Lfi08KCYktfxSqTbnqw
         XrDr07VC88Ox8Any3m2tMJGn10F9akzoJqk5CeELb28SceQrz8q0N8MJ+UJp/vzjF7cn
         ZXXw==
X-Forwarded-Encrypted: i=1; AJvYcCVmsllhW2uuU9IJyuD6NRJwU3bmPe/dVUHwu7wf/tEPHzji7cfhMzL5QZuvDcmgbYnOSioognQheJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYS9QdgWf2lYgfCXZv8Rq/VSfMRP7ddlkBJJ8HiH1FXEV1DmEA
	hpG4W6xIE48XELoz0jGZcNGZOBN+4quqKz3Wwl6TJyna7RrQAIkYZTspOV3VMsE2/haw6UftJFQ
	GSgyF2WlK4EfJty+4DLqraSuYgZR6hnq1yKiDpPjzO19/NYXFppyloP2oDn5wF3M=
X-Gm-Gg: ATEYQzzH08pRQyRFsnZRiN8GYfYuDyhvGqbpgfcBFsawpTh1oN52V5vNH5k//coR5Qb
	Rsm+8Kb3kDU1hLN0aXtlgy9HHlfT63XNoUnJ71hBswuixYeIqqwNYowgkK7mGq5oF6DnNpws59e
	8XaG+xXBlhINsTiLtXCZqwZRI40Ssgi540rm8cW0jMdd9EUhPFPk0mHTb1xLzi81IvnttbY/fIp
	D6Kl8WXiFxzcMJOpiBBIj7+emiarvWXQvUNhd3AQQhctkHBgxhYFj7vpj7aRW8hZlZbz2R4jB6B
	ukAsbAQRgtyxQn+pmG8KAWVeKZueR2+T/jvpOxqNl6cpefqP9AoZ+Q1UQgCA1CI5QvH0qfT3QPI
	7P4Kc1H4RpUNALaKrapRoxtk88Td4r0RwpxOi4RuWmnonY7ek6orBXsJHdw==
X-Received: by 2002:a05:6a20:a12b:b0:398:837a:7af0 with SMTP id adf61e73a8af0-39bcea60f64mr14340260637.30.1774358038221;
        Tue, 24 Mar 2026 06:13:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:a12b:b0:398:837a:7af0 with SMTP id adf61e73a8af0-39bcea60f64mr14340232637.30.1774358037614;
        Tue, 24 Mar 2026 06:13:57 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03be3396sm13517528b3a.27.2026.03.24.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:13:57 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 18:43:20 +0530
Subject: [PATCH v1 3/6] arm64: dts: qcom: talos: Add QSPI support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-spi-nor-v1-3-3efe59c1c119@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774358020; l=3110;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=WXipHHaMSghZTjkBOpnJEI3bnyrHeBcaQLZJ/3xgUYo=;
 b=2yysSkf3SS58hQVmvmZKweLn9qogFyPrp2HBItlnHKLGeVHRkadtm0lApPBfmum63eqvEsWYJ
 5p5MnmM4z1kABGt9EXo6MkjjfZCVpH3EjqOcUVAXsBggmBApjvIOtHm
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-GUID: -duyzIxsCvL1y-ba9QGGqj9bgQQAiLnc
X-Proofpoint-ORIG-GUID: -duyzIxsCvL1y-ba9QGGqj9bgQQAiLnc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwNCBTYWx0ZWRfXxhksruFOPAce
 KcWUM7hxmSAjvUW6uHO8pRGsBwDhFpUjEQ19aTXoFhjd88uhRO94uASBA+pJKxIjNTU1ccOQdNT
 CIWxqYOJZtyx2Y42XAyi8uFR+tEF+i73brvGzdYq9+X5IhVkDf//gJZBHnVHGwKrMi/n2Cxe4hq
 X8RIDJsmU8LzoRzTQ3XZ/06bTg3RDNsMM8vr5yTUaPqc+mwA5KdDHoAihqgIGtF+EMSYEZAGhe8
 QXaR2DnqPUM528ZjVvyJH+V8LR4pKIxCP95g/6NCjSIA5iVSjJ4Aq2lj9v9D0+Xg8Has49GsHN0
 qHMRusclLL8IqEMTL+H2QF2uo9cmb3I2B6+v3PEG2lP40DhHWzz/csRn+8h5JF/igUndUaCjmGt
 F4wDc1hbxhDTmSb3wteHEHgwFs/3WfeiAjj038hU9N8cpvMeP+//gXAVWBycA+XdFm+tqG6RWdr
 knJ88dMXqovWcSSoJng==
X-Authority-Analysis: v=2.4 cv=Veb6/Vp9 c=1 sm=1 tr=0 ts=69c28e17 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=CbYcEB_S6CoEFAquLCsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240104

The Talos (QCS615) platform includes a QSPI controller used for accessing
external flash storage. Add the QSPI OPP table, TLMM pinmux entries, and
the QSPI controller node to enable support for this hardware.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 80 +++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 75716b4a58d6..fd727924b8ca 100644
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
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_QSPI QCOM_ICC_TAG_ALWAYS>,
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

