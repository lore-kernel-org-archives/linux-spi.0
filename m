Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAED38735D
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773624; cv=none; b=BXYGqPc25vxclPu8OEZH5MA1VlFmj0LoumePMigHmE5xPLyRljTZAI5cfg3BMIvz8ee7UGdUQGTod5tZAgBvONCKeKjq71fCWgyLTS6Tg3727hhZ5cZwKkhOuTntuqW3bwO9jcMN60PePkcuPzFZGr+K8NAMdtZTlDN86y5cUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773624; c=relaxed/simple;
	bh=af6bOdZ1W9cbfvbeGvSgzZBjx4KNkrqAVkux3s7tjEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbTRgW/a5BEsD1KbfBVR8AHDzCUwZGKnc/pQgq9Tu/l6MdkJ3epXMjgsi21/+Q+UYIMwZefc/7vPkuJ/C2Nw+TOn8ieEov9an2suBEwvebSxTzB1N6onAo0Ko1Rrst5G6w6JTvliGA8B9Wyg2FGb05v5+XiuPklykID9iDh7Hdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jbwaEj7Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/lfk9Qp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jbwaEj7Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/lfk9Qp"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8wh7X1339274
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gF1qv97LlWYeWZA611ceR5Xzh2tQu7iyVQHKj5+MepA=; b=jbwaEj7QRJTGojwl
	P07FaoaxiW2Lb1wiIX1XARYyxpxcsoVLg3NVdNNew/DbH9ZQoAJ4e3tIKNZQ3wsn
	+hLPhgHVnvGCSH1ncgM9k/IWkxGP2OW8DdhrZ05Gy1n+9xH+IfbY4pDmTGT2lVL+
	iiN379eofAoKoyaOE98cjIwosDv7dVfmGfyPs82SGxxrYS19HHD0kbB3lO+mVM55
	0hUdYhds19vtf7s92aKcQMcRbbxLYkO+v07eKVMD8K6HgxHMNg/X7D49JFdmy90P
	MAsTINWpRDy1kTHd7iNb7fu8D2E6VZUhK6eI+SwWiRSmfjs5cd7h+2Rac98ynMhI
	DgjblA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jutxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:07:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c6cf1126cbso7653125ad.2
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781773620; x=1782378420; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gF1qv97LlWYeWZA611ceR5Xzh2tQu7iyVQHKj5+MepA=;
        b=a/lfk9Qpyz5pn1gyK8oc+TWGj0WYIWqTC4oBerErfUcfLI9XRFh7CQiWh4DMeSH4ap
         tazy6oNuysrti862XipK29mt3Ew8PWd5n2ZhdvzLD4YbXaItFrHMBZHJaf9EZIUntaP5
         jRlrHxPC9r+lYTW/iDeELk0xV8Sh6zS/P4xo6gK6dyyzDsaVtkOwp+yMpmPEpJlbo/Zi
         G6gGcqLzKIuWHcd7GE1p7jbu8CTp6J53BQz1UDAHrfhInmTrhR/Pjo98ixKXjHL9lYGH
         /UahgA7phZrkrGYfoWVjwFV/gJ3k1OiDLFh+5XhLlqCgx1MqKz5OOEzzUl/4nCG8I8ic
         ZGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781773620; x=1782378420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gF1qv97LlWYeWZA611ceR5Xzh2tQu7iyVQHKj5+MepA=;
        b=h0s5xIADHI3CHb0dQ9nDAXNNVaWdCPhJ3UYVpREeR8bMKX8zcMVt8z6O1kTwN/ctr6
         4YstqOjr86cdFymmbQnn0yg+KKeMHpRRh8BdUCyeZel5s2K6xm5vdjy9OsS0UwixFCo0
         lYsqN2ryORwdk/MD7jQsFSjRML3DzaHMmeT3+qJ8z0wxnFXqDdBGGYil3xKCGBxeA+ci
         zauyYitioZ8jVh2CTlayxJ7Zb8fCnqr318LGP1m+fi9kYOIQXSbk8IcP928ycnL8GXlh
         g22d8t/We1VkKpgbFGzGs1IsXJKDgQtY8ORAJeDzWu6Z3vbNU381y04BVsyFJfzdQ8BA
         nMlQ==
X-Forwarded-Encrypted: i=1; AFNElJ80NUCIxzTT6nrzDv6VKu22fy1RzI5O7ai4Os471gKpx+86iwBQUhM17IfCvdmU+3uXGoUb1S7tA8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPW+6K7C5bZXEAdFnVeqLxd8f0I2xHaYkeOVLuia84VjEXzAZ
	GaD0ec2Ucn5MLm+XpFeM9PSo0r5hzfbE4S7PT1x91ACG1nZoLYiu3gHTsekYMniEG5p9iwtwUDh
	CFAU2ZoeWjJ4uvOXE6LmGQBtof9qpoI50LLdBq6Z8C7w5fZlToGJW+/HLoxxAUHQ=
X-Gm-Gg: AfdE7clUmQKHpTBsHqvz6LIFUVk9cs18z7U8HwBoZxXoBw1k/UCYDAFxQX86znlI+/y
	86vZoyLmeikQ9sO76oXs1E3MgmBmTKJy+15355nUyWw4W7Kw0bLbLuu+YfR9XCZ+HzT2IjDDF4S
	E5omS3HuU456dLr+3m5degUQNOkRlYpGayQLwjuTPXX2vQZS51t2gwt++QphQqGvMt4j934Ci9K
	ipIQLo5WOiq+UzuQi9B21w+U4DG7nTPw5FbpScSG6zomQy2c4jn6D05vkzlR4Q3PC8nOy2MtIbc
	sYSuEmNJ9DiWNwO9E5mjDygGi4EwKDN58rGBW1r7BGmdmJvN1fFEX8O/ocVrw9i/2K885DDm/ZR
	baFyeO8l2wNxjrLyGYOagnIvIQxkkJa1b9ZTWCsecJIWS
X-Received: by 2002:a17:902:cf0b:b0:2b2:ebed:7af5 with SMTP id d9443c01a7336-2c6e4851985mr29816715ad.13.1781773620359;
        Thu, 18 Jun 2026 02:07:00 -0700 (PDT)
X-Received: by 2002:a17:902:cf0b:b0:2b2:ebed:7af5 with SMTP id d9443c01a7336-2c6e4851985mr29816105ad.13.1781773619772;
        Thu, 18 Jun 2026 02:06:59 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac794sm192112835ad.46.2026.06.18.02.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 02:06:59 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 14:36:39 +0530
Subject: [PATCH v4 1/4] spi: dt-bindings: describe SA8255p
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-enable-spi-on-sa8255p-v4-1-f5b5067e7e1e@oss.qualcomm.com>
References: <20260618-enable-spi-on-sa8255p-v4-0-f5b5067e7e1e@oss.qualcomm.com>
In-Reply-To: <20260618-enable-spi-on-sa8255p-v4-0-f5b5067e7e1e@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com, Nikunj Kela <quic_nkela@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781773609; l=2573;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=af6bOdZ1W9cbfvbeGvSgzZBjx4KNkrqAVkux3s7tjEU=;
 b=tqsq+yHGyUGmldkPvCnKVSHVSCcXg/Cpgp2Ltkv6m6BPwnsifmcazYaS0PU+XrTA3Mz8sUsCJ
 sS0bkV+dysKC/mbUcaPxFQAD9MoGbtqDvWaJAlqMahxAk99r9uDJM1+
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4MyBTYWx0ZWRfX5EofYohvpSDe
 rp7ystTO4iWrJKYJgVaLD/+2JGjr9FFQ3lGAxkuds/wNbfIBLXoLXS/OxrWQU6ax/AdyMko3Gh6
 7kryg6sGiUYxisJacyqH8p1WrEg2wwgZMSuGXwk59CdjOBygeHuECXbDLxG+cg0KwDltw0NdemU
 SGcSe4Lvyv/zVRnIZHXWxzoanCTGuvzsGmDbnpvVNIc9SFoOMnexYHGMb8e94V4WRf1Rqo+zfhM
 oL0+ij3V+CI0OTEFYFKPXA+MYbc7bFfl2gTtXBtMCRd6S1aVZM1SMPkF2aBhNwN9/bl7mSklbGp
 ppqjWH6E/lPNK/z8fBmvENKFMDK5c/lgkZZqLo5xwW49trDWXeDkTCMwiazFGGUk285NsyNNMGd
 KY7QMhzYxZxCL6lPQA3Vv059zoy9n0exeTItNNBw3vyoqmJ/35O9pU0n2SKbmIBoXj+cwTWtChJ
 LF4bxwe2rcaxHEsjHxQ==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33b535 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=b8-5IbU7OP05I74H5fIA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 965G_nISOTmdEzTxNQViMF3hvGNNWgO8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4MyBTYWx0ZWRfX4S31syk7Fp3a
 IXz/9mrI4D+YaqTaalZ9cNciOdJwnpZDAWBNblPPFc6kH/N/Sj7BJ9ARPTh+10HmU8Ro5KRdVKF
 L3/rAlPEuQERJMrOu6UDspgqmcurEjk=
X-Proofpoint-GUID: 965G_nISOTmdEzTxNQViMF3hvGNNWgO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180083

Add DT bindings for the QUP GENI SPI controller on sa8255p platform.

SA8255p platform abstracts resources such as clocks, interconnect and
GPIO pins configuration in Firmware. SCMI power and perf protocols are
utilized to request resource configurations.

SA8255p platform does not require the Serial Engine (SE) common properties
as the SE firmware is loaded and managed by the TrustZone (TZ) secure
environment.

Co-developed-by: Nikunj Kela <quic_nkela@quicinc.com>
Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 .../bindings/spi/qcom,sa8255p-geni-spi.yaml        | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml b/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
new file mode 100644
index 000000000000..d9347d780ca4
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/qcom,sa8255p-geni-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GENI based Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
+
+maintainers:
+  - Praveen Talari <praveen.talari@oss.qualcomm.com>
+
+properties:
+  compatible:
+    const: qcom,sa8255p-geni-spi
+
+  reg:
+    maxItems: 1
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 2
+
+  power-domain-names:
+    items:
+      - const: power
+      - const: perf
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - power-domains
+  - power-domain-names
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/dma/qcom-gpi.h>
+
+    spi@888000 {
+        compatible = "qcom,sa8255p-geni-spi";
+        reg = <0x888000 0x4000>;
+        interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
+               <&gpi_dma0 1 0 QCOM_GPI_SPI>;
+        dma-names = "tx", "rx";
+        power-domains = <&scmi0_pd 0>, <&scmi0_dvfs 0>;
+        power-domain-names = "power", "perf";
+    };

-- 
2.34.1

