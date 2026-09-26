Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67039A7EF
	for <linux-spi@vger.kernel.org>; Sat, 26 Sep 2026 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452615; cv=none; b=bJrsM5SZQtmtX/MXD4VhXsd2PdLpaWvC/pp75PDZsJm10AVaL4tM3sskwpAllg4F42M+kPcloRiYINFa+Rmru46wsFqs93MB9Z6LbG+gk97spiubJM64gwMtUCMM89ipjY9Ciklms35si2O5Iuu8D3HPdncuozudRH1aRWP1mzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452615; c=relaxed/simple;
	bh=Eg8MoXJd0e3IEzLRN0n8BuDSvgDLuAlOF70Eq1YPEh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/DU0t4pqgR11XpTDcgrCRlGVJ9BOFbXE/sv8+UqMd9tAGnNqHhVSKHR0hQTNnRYkRLAx9xi6wUJXpH2ePKcqMONrKjm9rFO8DeHDUOB+C2sgP+GwDFbUdtBFoO32srU+qeJ4Zi6SMTtNF6H4XCTh+MlAHdbSPlkHT98YP9THQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HuT+9sgi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cYcQeKHn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HuT+9sgi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cYcQeKHn"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QH0D43880424
	for <linux-spi@vger.kernel.org>; Sat, 26 Sep 2026 19:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qc6T0YreUjHG1GLmmkXyghNX8QTO7tgRFzh32Xdx1iA=; b=HuT+9sgiak1Ea1Zs
	TMBNbm1+KgT4p1STdBF5nLdqVURJ2X5PGQasa/lEv2GeDWOP5vk7drbE8tl7gEQg
	9tAqQx0gE86kbCeHcTXCGc7POlhBpOAtCBpwEHpaRbFOvL/E3GKA5CYaV0yn5iqo
	jaY36eRI4TCZhZSFDDat+A92NHwOjfL0UagGQ2//z/KW00wpdYG4GkJr4OGapWjS
	0w5iwpQcPh1LJb3PKrX3fWOAU2YLLfgyT/7ilH36yZ5/b4M7mpZAFxy+/4lCysG6
	NIdunXAkdKckxCby8KtWAMttiQ5GJufLM7WBQvagyRM/0rqJ6jk5h9GsS7tnr1CU
	/fnt3w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mw9pbc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 26 Sep 2026 19:56:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34318e88ba2so864699eec.1
        for <linux-spi@vger.kernel.org>; Sat, 26 Sep 2026 12:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790452612; x=1791057412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qc6T0YreUjHG1GLmmkXyghNX8QTO7tgRFzh32Xdx1iA=;
        b=cYcQeKHnSJln8C1ZHEYt3sDI2a9rrdfDSzUJiHCURuRiq1xBUcmprqdxvVnUkdtiTf
         2yHj+8OOuDtrSatpIEMbCJYeISbp0o9Lucsr44G35TBt+dQyhyRrmCmsVUoxR8/uWHc0
         fIj4rkChUzk0J2WhSr08mf/y0lAKhe9K7Chsgw5hbp8F/0EYUQ6MGM+9B6WkfHcXX2UE
         hGKQbjwEjWcU5aeIf6vzSmsClEYMhi0ROJLB2bPIAeuZ73TxYwQZAaBHpNfx8tkP8G1+
         /cLQA8LQCdfYaqL6VBhhxGKWaqch82lMivwtEzUcfl20zU6BMhpXyyV+mVhCiWi61DJN
         EL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790452612; x=1791057412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qc6T0YreUjHG1GLmmkXyghNX8QTO7tgRFzh32Xdx1iA=;
        b=hgy5bjNHRESLmpZfW2Cmcm+T+E88dFsKXfBeOpehhVHIkEAS6uRP7AfNVrNQo6OvQ/
         AVQ6sv/SDAZTaFtAXReN51QQ3NhUVB8AAevQIis+5N4DrQxmQGfpdTHVgZWuAjM2HaTX
         bjtKmiTmpaZbhvJ1U7ez4BQmRt3toe5hhE4fKz+6ej5A4Y93UdkW23XfQaUrka7/CnvE
         xPwvaMlcW9U7Pb9i4OaJCDSWH5IM5gDVhC3PbP0yvRu5LAEGnIN+/pAMVKfTQSYD0sNy
         o/LWMNgy4fzuxxXLTRIUEnhP6Q64lCmcDLUeszEVU0/B16pe0pbneln4VR2j4V6KIuXX
         kzSw==
X-Forwarded-Encrypted: i=1; AKwUvBxa6MgqIESCsM7rus9rB6jU8CgBEyMrqqv1PbUCMNjF9a/zFNxTD9xYURtHMLpH+SCbUDtE7fQjZ7U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAMDd2hOjlZ3yY4dm7f+8wX+yBqrEkEkEsnw9Pl1Skabhyp9at
	SrttueY155vd93hiYAVF+yEkiKQ4x71rMmiBca4CDUki8FSOE6zoIHmhEzW5ZxAXc1n6Vx+p3SW
	l8wjqxOjyp9fSXx26x+J5Z/+RLGWR7GUDgOtNjXZyOb82c8lkTL9HSW5dXYNlJMMBDhN/l00=
X-Gm-Gg: AYBFou1ZLqsAHbzlqKz8TxQEydv8uNWAoRKouegNeANIGWlBdBDOT1ErSsqZYNviang
	nksxkxsL1c3Hm75Nartugnuyi/N5BFmNyXGM6/tHuEA3tlGq0LRtP7OlC428dWbk7kgsQYJQD0o
	SuXGHrUCOc8hejVkOBWhDDIU8Sc9aDWjWlJVoMR9BKYMMjJ24RZprFVv002uxe15XXBHqFGQQw/
	Y3RH85b0tneHgC07+Bj3uzqwMByo4cXe3lgfRmKBSQI26/Q2KhTvlcn0v/FhjK6g7f0LIelM/WG
	eJB5n3UYKWO1klGMUVjDexrX5vonYVBJMlg6M3IvEeZNt2L1xO49lC2YuKbza5IOJ81QZjvIoOM
	uXP2RgpGq/g4vP7jlgh+osBy5OaPN9XIP
X-Received: by 2002:a05:7301:6906:b0:33c:20d5:b7e1 with SMTP id 5a478bee46e88-3427265d58bmr3926207eec.33.1790452611631;
        Sat, 26 Sep 2026 12:56:51 -0700 (PDT)
X-Received: by 2002:a05:7301:6906:b0:33c:20d5:b7e1 with SMTP id 5a478bee46e88-3427265d58bmr3926165eec.33.1790452610902;
        Sat, 26 Sep 2026 12:56:50 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414407ea69sm17179025eec.7.2026.09.26.12.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:56:50 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 01:26:33 +0530
Subject: [PATCH v5 1/2] spi: dt-bindings: Document ready-gpios property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-use_gpio_to_notify_master_of_spi_target_activity-v5-1-9b973623080f@oss.qualcomm.com>
References: <20260927-use_gpio_to_notify_master_of_spi_target_activity-v5-0-9b973623080f@oss.qualcomm.com>
In-Reply-To: <20260927-use_gpio_to_notify_master_of_spi_target_activity-v5-0-9b973623080f@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790452601; l=2279;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=Eg8MoXJd0e3IEzLRN0n8BuDSvgDLuAlOF70Eq1YPEh4=;
 b=HCSG6CmIMbvYVVbqJP38dOYvmN0RHimuw2c356pTX6pCIf150E5ONevWTCF7hRELGXQrDGsfm
 XfaaYQlJ5QuAuYTV0Ax4BaPgNRDeM9MtvOVLPy2ObYmps8j7jkO0Ksh
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: eGJYc18J8PzznNFJOMFA2zAZ2OSdbXXc
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab82384 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=esOR2qCunaKGNcCvXUQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: eGJYc18J8PzznNFJOMFA2zAZ2OSdbXXc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3OSBTYWx0ZWRfX4GInQ4+5iDYA
 TfRi9p6sCt8FmKQkBZwZTsnNzvABUMIy02VXTcogJHrZWXZ81wdvx9pRo6yVdMxyTKZsDP913VH
 8F+tJzdccXXQ+X5X/TVq5Li//K9hdTmjPtGLDmnAHHeIDswc2p13cjFT/IFL5xKajovCboYXmmf
 izt3s5mqf6w/CqyCkQGmgA9PYFEqyjYuleNh46Iur2iN2TCzouocFsYYmX96QHw+xMt6uviQjtM
 gj+H52A8xZrYB/UOAlMJcMGtGERZL57P+ifexPuGFUHrJysFJZMN8v8VC/66X0KyV9KwbeIXCml
 9Os615KUSA0FOSTp/h7Ma2oQBgIALPs2qW/8ZzuncBqzBNVjwgpapB6oJisDdveY4TnHZY/RDNo
 bUwBUg1NHm8WhiRKsOcNbZkgVIaptLfDk7mt/j7m+2+5IFCX1YpmBeaN7r58507MY/Yo8Y7Ojsw
 rpgL68SqMfoTzL4y+sA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3OSBTYWx0ZWRfXzldqnLp8rdxb
 RnOFQgGaKT+nvVXac60PJfCxl267WO+i1qd/hopdEM9fa391QETh3OnuOjNx/fJrBetBxpqoFNA
 zchdQHEEFmdOfhkGxEc8O9PVZnbrHJU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260079

When operating in SPI target (slave) mode, the GENI SPI controller can
use an external GPIO to notify the SPI master about the target's
active state.

Document the optional ready-gpios property for the qcom,spi-geni-qcom
and qcom,sa8255p-geni-spi bindings, restricted to spi-slave nodes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml | 9 +++++++++
 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml    | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml b/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
index 6552303a4f52..33eddb395a0a 100644
--- a/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
@@ -39,6 +39,12 @@ properties:
       - const: power
       - const: perf
 
+  ready-gpios:
+    description:
+      GPIO used by the SPI target to notify the SPI master when it is
+      ready to service a transfer. Only applicable in target (slave) mode.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -46,6 +52,9 @@ required:
   - power-domains
   - power-domain-names
 
+dependencies:
+  ready-gpios: [ spi-slave ]
+
 allOf:
   - $ref: /schemas/spi/spi-controller.yaml#
 
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index edf399681d7a..8d1c78701657 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -67,6 +67,12 @@ properties:
   reg:
     maxItems: 1
 
+  ready-gpios:
+    description:
+      GPIO used by the SPI target to notify the SPI master when it is
+      ready to service a transfer. Only applicable in target (slave) mode.
+    maxItems: 1
+
 required:
   - compatible
   - clocks
@@ -74,6 +80,9 @@ required:
   - interrupts
   - reg
 
+dependencies:
+  ready-gpios: [ spi-slave ]
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1

