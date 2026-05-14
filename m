Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073A3AA500
	for <linux-spi@vger.kernel.org>; Thu, 14 May 2026 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741160; cv=none; b=sWFQTpEtZKoPlAKZjD2FL0asTN1+4lKKmXT7+YtGzW4UsPqHN1OoogPn+5DSSOy/gQBCP11xnd8ExaCU5tMY6fkAq3oOfMIqxehhEGKa+GgtwcbMTuL4GJhk4QXIXhaErKjPq0acZDXcdMFPo7wIOiVXifOAu1MdhYP0r3rN6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741160; c=relaxed/simple;
	bh=nMhvxZslWNDs8AVaAYTiaGZPDIUm74tSzi5558Uwa54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lv2ZR1P1HVwKwy1gO8GljnZUZenVm+3F76MSiTKYgozto2I2C7iSPTXiebd1ksMv7Jr6ravLKpgziiAcfzXjqMFjWDsLBaFZnlrM01XtSXHv2nf75DStKAg2RTyQUIR4AYCLpxdOIRhaqk9FjVHNORGhSz6Pma4ur5WaJcSf5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DxJpSvc0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ECIMWRnX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxJpSvc0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ECIMWRnX"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E5SVfn2004466
	for <linux-spi@vger.kernel.org>; Thu, 14 May 2026 06:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MNQLraJu9ipq64mXFo2hKvkBzYSACj+4yXC/i3vs0lo=; b=DxJpSvc0ejLXuMBk
	oESOzaeEPEcuxKDZ/dwZx6E/AuPFuP6/PsQieudlbB0HztRo1VVh/ZZsk39WoOPI
	vyXX8Wh0piCkmUOWnjZK07m6N4jkyHyQtit5tviZHnVBorFlm3DVNA7MliUTwr4U
	k6L+uKxdK7C2X4+iMHdEYizOYV7fm4io5EmwA4BKpgSE9jTKRBfFr7sQtU+KXRwl
	MGWcY78TwjScc6DWDPL66mXY2xrebtEp71ZCREsRB+DX/RlVYKCV5sEm2qNT8b3R
	lF5JqAz5c82IPtb2VYcyq+lM2nyROHjc7yPJ7cCz7dL781S0COOzeHNc74DzwEpp
	WtYqww==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5899r7tg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 14 May 2026 06:45:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c827bda2e60so3039558a12.3
        for <linux-spi@vger.kernel.org>; Wed, 13 May 2026 23:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778741157; x=1779345957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNQLraJu9ipq64mXFo2hKvkBzYSACj+4yXC/i3vs0lo=;
        b=ECIMWRnX3pdHICvZ37ClGWHbrkDrevQiaVN6oGNGC2qICN2G8Imguf1xbuBE3TThg9
         cIk1YpwBMn8fkfsnd9zPEiVeb0BGugRya98fAwmI10RtLWAEERYQpr/YbIRSCbfcvtcr
         SMihUTkMN0dOm+djI1vQrtvoob4EQ86fsjol1bQEXlpYj9iLUr2LN7JgmK8G7FkuhgYJ
         L6SzKzYTVQjoNwaG/ay2YCGoZlap6tifi9pd7v2QqRblBvAXj93y9AXwLIkKOVkK9PiX
         IMM+4TFW5Ni57ZiAy55ybUl7MSYcXozJcRKIx/6I/o+94fxOoRQOno+/oVTjRaWE6mwx
         ukWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778741157; x=1779345957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MNQLraJu9ipq64mXFo2hKvkBzYSACj+4yXC/i3vs0lo=;
        b=XW76DbipatAUebLp7akEWp2/YxtOVmAyUOjt/gkJcWTZjVagnQuz1aqd8VB3x3/tlH
         wdgfM653rSM8WB8QpYXWAcWnXL6arKnkUwvb4YKJNkaUPD0NxN71Icoe9ltVCdi3g2oj
         44ELKxY3Fp0NO7akEpng7h9uH1gHgRIR+EmTPkr1sr7vEIZWCnZdSuE2CuRP6QYriAL0
         EXvA+HoWVcvwAMhFRww2n+hi26TYA3r8EtNRStTD1iXJjl10fSxZNjEWOzpPoP2piC6U
         yehxiZIqDvjol6+FOmrZ+sp3PVENrNpLSUPGfhxbaklUh7KJAcj/QwQD9K7KNhrxJjfH
         0L4g==
X-Forwarded-Encrypted: i=1; AFNElJ/gYjW2IC4STU/gvahFXRu0P10YZhqx5nWhG16Op5kAEoov2TCwKZ6V5mCTsLQoD8g5n1OCS30EOAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhr49tHV793qWn6Vf0HlC1Q9ejM7gABDEV5PWtzdbUdZR9ySw
	+jBxU98bEX9w7Zm/CmyqyLf9oDRK5Kh9NQOpVBtH0mocqNC8G7lqzXvQ6OJWUWis4h8mkKwXGTN
	0qRZb4CL72bP+hO5610dVHHSGYoHo+JY5XiPdPCFp3qYjnnqHRvVggq1OHDviuhOpdJ7XTBA=
X-Gm-Gg: Acq92OEP1fPawnK8QXjQdiJfUF5x6Lr3D2pj7U2es8NV4xva/iHMQSOBsl9JlPPkG4p
	jGzJf6MjTjsrUlxSKvxX9J+n+ENb76AKoy1x12hfiPG3cpdNeH/JjqOvDEO2mr0ydWdqmkZe1GL
	hHALxynGqFXDfTtV2oGQGCOutUu+hTchGMNAX+tbv44BkqKTQFJ8VhGWKKTW5P9rLhBUZpkAXnd
	uj3dllj99Aw+v6wEQi9Ubc2pxvN3oP2m6+Z7JZqWDyT8JYJsNwRwHkCrbXCT6OcehTRlWt0pk/J
	srt/lS0ikgQwHwV/f3ncAShw+pYAOWedoP0wdtdjXAauq8cIrvWBUGbtQKBlgwvxDoFi5lbnjzx
	e0vsjAnXD0IeRzyHNZFXVOEoTjsSdx+MYqT2a06Y2xKXIjvEE6+MN9AhbNw5Nxj0EdXIaTKPOUL
	o8RAk9akybDKn7aANdtJTZ3ttsE2X4jBjYn5fxabdahyk5WpOs/sU=
X-Received: by 2002:a17:903:4b03:b0:2b2:a267:784a with SMTP id d9443c01a7336-2bd275c818dmr67835655ad.24.1778741156684;
        Wed, 13 May 2026 23:45:56 -0700 (PDT)
X-Received: by 2002:a17:903:4b03:b0:2b2:a267:784a with SMTP id d9443c01a7336-2bd275c818dmr67835515ad.24.1778741156203;
        Wed, 13 May 2026 23:45:56 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49c9sm13387685ad.49.2026.05.13.23.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 23:45:55 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 14 May 2026 12:15:32 +0530
Subject: [PATCH 2/2] arm64: dts: qcom: ipq5210: Add QPIC SPI NAND
 controller support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-ipq5210-nand-v1-2-cbdd7492e826@oss.qualcomm.com>
References: <20260514-ipq5210-nand-v1-0-cbdd7492e826@oss.qualcomm.com>
In-Reply-To: <20260514-ipq5210-nand-v1-0-cbdd7492e826@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        sadre Alam <quic_mdalam@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2NSBTYWx0ZWRfXwE8NbzctQC7u
 zaNzW07oRGAEbyNaWXH6iJUcs/U/NrRKzWNJx6Nk6kch786eIieXdK8ns7UUF6QjbFZQevMd1Br
 JCUSAMmQ1+Lm44S3ETkBotzMVJPELGiAw9Nn2qjDZZ1o3dOCasLCFslE87KBq1GSmgLxP80vudg
 buuTkTPUA/SGOO4+ctFLCaUrjgrSXIDC/FLvNTi1PWvWlleAtalZJlImY2Nt0t49odnE8yqbIz+
 RDdBZdfNuIyH+MTe/BhLD6dg/wYiC0rwChhla6/xx3URXtM5sCIAEy0Q0R4AHIAPB0ABjWr1nzH
 Z32SPiimUNB0LWWC0ZHLGMskWytB4hULZsk1PVq9974vZupZbKqytCE0/S1EJQmXcrVnIM3/XnA
 spQf+1UxWdT4C9HoIyy3GgeOFweGQbjHnk6ocu4bOxB80huCx+ZnzVwIqhv4Ykckwx+jgJ1guho
 9oCPwKUdBZIRDcnoYHw==
X-Proofpoint-ORIG-GUID: WAMTlA0-cfbeLOdTejw_lE3SE0qOa423
X-Authority-Analysis: v=2.4 cv=N6AZ0W9B c=1 sm=1 tr=0 ts=6a056fa6 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=XeRMpaAEaMlpgmDeE2wA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: WAMTlA0-cfbeLOdTejw_lE3SE0qOa423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140065

Add device tree nodes for QPIC SPI NAND flash controller support on
ipq5210 SoC.

The ipq5210 SoC includes a QPIC controller that supports SPI NAND flash
devices with hardware ECC capabilities and DMA support through BAM (Bus
Access Manager).

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts | 42 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5210.dtsi       | 29 ++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts b/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
index 941f866ecfe9..4813662c2d6c 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
@@ -20,6 +20,25 @@ chosen {
 	};
 };
 
+&qpic_bam {
+	status = "okay";
+};
+
+&qpic_nand {
+	pinctrl-0 = <&qpic_snand_default_state>;
+	pinctrl-names = "default";
+
+	flash@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		nand-ecc-engine = <&qpic_nand>;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+	};
+};
+
 &sdhc {
 	max-frequency = <192000000>;
 	bus-width = <4>;
@@ -36,6 +55,29 @@ &sleep_clk {
 };
 
 &tlmm {
+	qpic_snand_default_state: qpic-snand-default-state {
+		clock-pins {
+			pins = "gpio5";
+			function = "qspi_clk";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		cs-pins {
+			pins = "gpio4";
+			function = "qspi_cs_n";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		data-pins {
+			pins = "gpio0", "gpio1", "gpio2", "gpio3";
+			function = "qspi_data";
+			drive-strength = <8>;
+			bias-disable;
+		};
+	};
+
 	qup_uart1_default_state: qup-uart1-default-state {
 		pins = "gpio38", "gpio39";
 		function = "qup_se1";
diff --git a/arch/arm64/boot/dts/qcom/ipq5210.dtsi b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
index 3761eb03ab24..7fd4291caff2 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
@@ -204,6 +204,35 @@ sdhc: mmc@7804000 {
 			status = "disabled";
 		};
 
+		qpic_bam: dma-controller@7984000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x0 0x07984000 0x0 0x1c000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		qpic_nand: spi@79b0000 {
+			compatible = "qcom,ipq5210-snand", "qcom,ipq9574-snand";
+			reg = <0x0 0x079b0000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&gcc GCC_QPIC_CLK>,
+				 <&gcc GCC_QPIC_AHB_CLK>,
+				 <&gcc GCC_QPIC_IO_MACRO_CLK>;
+			clock-names = "core", "aon", "iom";
+
+			dmas = <&qpic_bam 0>,
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
+			dma-names = "tx", "rx", "cmd";
+
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;

-- 
2.34.1

