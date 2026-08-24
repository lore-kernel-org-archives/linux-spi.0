Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0843CEFE
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581579; cv=none; b=Io9PPaLcHz5xLQKtoJnpJ+UKT6Gy9EL2qwb5+x24nw9+rrWA26kMtTIrlMkYEkgc36WBOxBJVyRIUAQ0yH4+wTtnvRyA/RL1Rik1ZB6rnDsKW5FY10eihMHYcO42618jzHK6AR31V/smas5tiDBTKKOKs9lUSFAjITkewvbQdpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581579; c=relaxed/simple;
	bh=07fWoDKWlhLp+o+voMIwf61zTNZp2ZtvKXItlluoCmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VtCgupJh5FUBLMN9wV4PVtzf1UgFzKMuWepY0JPInra5lQzXmFFhJB8vc9svSnCKHifov0nQ10uAAYECxSCr1zKoJUDNYW8ZKTDBIhqy/cIA/wsCEVMXY9PcQyZAECVssTz/OK5RmWwP2z+neDPmG4viQVFTlcUQrL0DBbiV0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IPC3Zrek; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PsW4F1I9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IPC3Zrek";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PsW4F1I9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCv5Yl2006634
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 14:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SY8+egivx5hMX+E10IaKzHuFd6+P6fa7OvrZXy9RXk4=; b=IPC3ZrekBD71qPf+
	T+Vwn0+FgmJ/OCYOiMc/BpIumdrPFNwEr8Q8ij5FoDdaIH1ozRW1/pnHQBdQOHvW
	FKKvnYCBrkZvByRoYUGq+46/MMoUjOxAMLXfEvGdOQiBUpXtNIfeVkRa3Y5cidz3
	LMlnzXvxPcxg3pGcFhcmC5NAtu02T+iaMjlG+1xB9qtq/kuoB5ZN2FLf6jgSUn9s
	zNTsgwkkPZzmPrH53NmLu+0Jy91N3vEpAC+fkoabHW3amh6uxC1bwkxaV4J/CV5D
	02QssjEQpxK+yQS5gbsbJ4mtPx+vfmTPk2KLY8FIiA2mVHUVqnLPhpRbc5bUXrFn
	Yjlbnw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kv791ad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 14:26:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d63bad3d09so43634565ad.3
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787581577; x=1788186377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SY8+egivx5hMX+E10IaKzHuFd6+P6fa7OvrZXy9RXk4=;
        b=PsW4F1I9MZx4HyUMKuV+dqk1vfhg5SZSQZ2uyfoX0VA9Mup1+HBXaEl4wZVch+dr3Z
         s5l1JV9WnsAd6bribAoXk+un7qUYvd+r8HtfrFfzg3lqXJexGW4OFS99WByb9DSUUZZ4
         LumOYTaPOuj7WgBqf3N3vAR8AN6hSPy1hZ5sbFqFu/bCJqqRtlzuzGhp1l2ZaARI/Rbp
         Iufm4srtYM77ScGpWRfRFN5RvlMdaUWgZtMppf+G0uwij81dya0dllFRhaS/0YVzWutn
         D1qRN9tA5wo9lKfMZLjhR6agP4g9OSWDn/0AoXozO28g8Dr2Q6uGmZZFSEGGQwkuxKVH
         p0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581577; x=1788186377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SY8+egivx5hMX+E10IaKzHuFd6+P6fa7OvrZXy9RXk4=;
        b=No240Kwqoin/zwLFQ8wEb8D6nifqMh/geQgWbEfc/1KmjPGm7eAMeatbhvrV1cUIN/
         nXwBPrXFUIQ0UveidKLjbcaAlQJYxdi3ohxCJsxbzAO5tagLM6sdHY9RmKmCfPCeUDoU
         n5PP//vIaAhJWF6jTLRJF4DEG5CJHnksu1zT1SVHWFyi3pwJSjV91hHt9Pf5qgL36HMo
         hiK1DGvgqAY6AN1D0Fr8uhw8GfIoaMCF/bMuFTjSzkpF2vO+TWStlqH+v1TWGrrmePYV
         ZZMerxQvsNQ2jTWt3D6F/ayYpK+hsqoSBeGqPO8FWva4voKtiSx9UbUR/lziG8c5qTHD
         IOug==
X-Forwarded-Encrypted: i=1; AHgh+RqW7wJCrJ0JVcGmUX67Gc+7lpXBUI/owogtCn1RvOr8dNIh0RP0bfOks91+gwf9NNdKcDtEPJm60Kk=@vger.kernel.org
X-Gm-Message-State: AFuF++l9tVOdnDbpDGn+b1EdfBlemAoRuIZ8HkJdFOYCeiwRC7DuISiS
	xz3llG977hPMCf05c7TZtx9Rc8/NWxEW6TKvKG+988Y/FxhLJDh92bsdRQ3Mu0prx7mt69zbnXI
	sTAtFDg3dUUmrz9M3gq9ePcZFQ1SM857/6du0pumNROIkK1BgJ5lUYnEr5CXVab4=
X-Gm-Gg: AR+sD121gM5K9ZV2Cc9e4qVogVx+Dd+lH36wxzFAFJV81fCgC5Ye61NjERpBF1X3dgK
	fEfndoXPn2lIuIfnd/yBGCvepR6luzflNHAOBUHGhm18fSnsvrg4ujrY4g8SwVpTxgGmq9EstIt
	yKBQL1LEAHpxmpFrndBM37sTKyWHKrNPaleGniBlvslhF52VGoHyUtseIgKYjbMhfcQo0xOc83J
	qR43GvyfPx7eDB5jLZE5DQhtD/noCb82qqh4Hkl/5n0d1nNx7IQQDpoqOpHMHyl3+uQUhUSwtsT
	7gvQ07eUzzjCPqAh+ytZdnY+YTQtWdz3X2Xc6XSbjdMpBk436nSNCwiAlQoJ8sbrbSUgAZw4wpY
	7fwDOKh658sRHFmd2yI8wz5fQFZME+F536A==
X-Received: by 2002:a17:903:1670:b0:2d0:8b28:517c with SMTP id d9443c01a7336-2d670b61a51mr341735585ad.3.1787581576882;
        Mon, 24 Aug 2026 07:26:16 -0700 (PDT)
X-Received: by 2002:a17:903:1670:b0:2d0:8b28:517c with SMTP id d9443c01a7336-2d670b61a51mr341734425ad.3.1787581576307;
        Mon, 24 Aug 2026 07:26:16 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676761fbcsm18523275ad.4.2026.08.24.07.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:26:16 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 19:55:59 +0530
Subject: [PATCH v4 1/2] spi: dt-bindings: Document ready-gpios property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-1-fde2ebf043db@oss.qualcomm.com>
References: <20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-0-fde2ebf043db@oss.qualcomm.com>
In-Reply-To: <20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-0-fde2ebf043db@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787581567; l=2206;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=07fWoDKWlhLp+o+voMIwf61zTNZp2ZtvKXItlluoCmk=;
 b=j/qELHbdgK66Sh9pwZDF8rqgN9s6kBB+zMziKi6AIGAwHmMhn+hwXfK/chaNvH2eN+VUcb8KU
 vfUNcn6KoxtBmKO43KNQynaJFvmZGBa7MG2ElOPalofb8/JOlqSIDtv
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=Cfg4Irrl c=1 sm=1 tr=0 ts=6a8c5489 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=esOR2qCunaKGNcCvXUQA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMSBTYWx0ZWRfX/gfpQjFY45jQ
 qM6xoIVWJnXtAiDVK35+hgISpoXOr/nXV1E7Ut/Fb5uSCyg6Z16ijnz86MTLPCWOblOXzWJIlHq
 httNTNvTizaLnnKjhLR+vNnssnyoAg0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMSBTYWx0ZWRfX5F6m7rElrjTc
 RQ1vv1geaAJhXqEj+2HlAMzufIAUHi+DcnqirhDFM8CoHVmHo3UjuxHFgSl4q2zaBFbwmuaiEJb
 Moh9RoiPy2k8HUjix0BvpL3kwFPas7I0ZNnLz2kdG/Eli88zQ8Y6PDKv2FW6VC9qs2B3NkhZS4l
 4bjvmABIopbHaZFEAm9RQOHknaFlkhqnshEFg7PVGQXSakW3c9A8tj+tCUYlDCdxkS1UQxwF30z
 asXCezwmimgts5iy7APr/CyZzkg1D4waNAxQSKBxkhz/ocx2BOYafgbOP/8IM3nAWxO2AtkKzGM
 SuTmgUxuuHqDuorjK002c8hEbrcQgFpWPJtl7JGyUVsF2piPhMC7FToYzouNGnSSa2Zxq5vbd7b
 sP6+25cjXQ0f3Xx1FdZrVTj/IDC0vUgGMpUVjn2PVeP7jfwLemFtQkmhfU6ZzeqlPmLazeEryXS
 lvkM2yf8zoQjqAW35tw==
X-Proofpoint-ORIG-GUID: MA-lPUh8DmmRr5IdiPdDtD44-rL2c_KW
X-Proofpoint-GUID: MA-lPUh8DmmRr5IdiPdDtD44-rL2c_KW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240121

When operating in SPI target (slave) mode, the GENI SPI controller can
use an external GPIO to notify the SPI master about the target's
active state.

Document the optional ready-gpios property for the qcom,spi-geni-qcom
and qcom,sa8255p-geni-spi bindings, restricted to spi-slave nodes.

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

