Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6744C500
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983436; cv=none; b=rXkgvp8+WnIWQUTCihkknnXL/Bwy1DxayXYbmAuASjjz3mJJzsMjzKDq1pE5QoNS3m/EDNB+LwRIL3kVQp2VzWLwSYRmCW/eR0n5NwB/OzU/zcX8JbiHRXajbNV4NVeAZcAF8DQUb0KMg3FTBPjmRw+S+kyeXsA7N1XkPq97emg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983436; c=relaxed/simple;
	bh=07fWoDKWlhLp+o+voMIwf61zTNZp2ZtvKXItlluoCmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gciSj4wph7PYteQObCFmaXn0gtfRkoEYP/MQiGDL7wdvlFKBJBx9LBH8HZDWZBVZU1aYDTtCXTdccgwL5UQkLSTgKX6aBmgww11WDq34kMKvMMG/bF1yjWuHCFXar8xy7dQBih1HYu7T3cSRl13tU+ppSmQ91s61j8mfoopR+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FZ+QxQNH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QFQwXzfK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FZ+QxQNH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QFQwXzfK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYt3e1840293
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 16:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SY8+egivx5hMX+E10IaKzHuFd6+P6fa7OvrZXy9RXk4=; b=FZ+QxQNHLu7OCNL3
	47xvSPAl3abugJ2GEZ4KqNWE8Jci1oGbxq/4923CRq/fjOXQyaxll+PjYPLpREhK
	1lKQVZcgh+V0mCTQwmtPCTipqReOZ0Zb9IkTOWFHii7gryFGt7Jpu0V2Xx2Jw8to
	AjfboH0eA3dqViE8TXc0JJPCiFz4e+y/iov0vcFXSZEqZ9dZ7tIDuVqRUI/Bcg5c
	xDu8YDkjNsN+N84Iuzadmi/CLyvgC58hqipz9MRnfnZEYMvAta+ZZwKzXOu4fg6c
	xdXg+MYjGzbN9WfKduYvsVr3891EadQk2uxWsFGbe7+f1EjcKrERGaZv4GDF5rHW
	Am3lkw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3x30j1ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 16:17:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84859a64079so5915014b3a.3
        for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786983429; x=1787588229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SY8+egivx5hMX+E10IaKzHuFd6+P6fa7OvrZXy9RXk4=;
        b=QFQwXzfKDZfEh+1eHJSHvHmPbXv8201HwPTsJRoduyXzyGQO3fLCi+SYXg1acLCefa
         XoibY0Tp1jZwPeMyACL2B1Af3U+4vKVi49lNYbkNLxqmcWMt8ZjpysXYasrVA5E4HedG
         S9JcfYbE0joCSEFYfH0p4zdxexekaSeDL3Zx3miMFepsZYhz1OGF4KUTiwTaCmc5+00S
         E8bmyOv6ARfm2owHDvWEMpETeIpfh7YvZIswCv7eEwzi3jkO1exlsJhUk9d37Jk6+K0x
         0gIAS3X1gIDD7/xK/jfwjm9kCRTprC6tAHyXg4y6BksPtDtgrMSMjTY+rHIXqrTUraEg
         XDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786983429; x=1787588229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SY8+egivx5hMX+E10IaKzHuFd6+P6fa7OvrZXy9RXk4=;
        b=l/EVNJC08VRLHSrtVQutZQHoinf385SPrWBYLk+dhEXsPJ1oRGFmX1xvS56SBHpyL6
         D2qwJotjixVg8N5Ius3cod9ghWkSXz601ZVthVPOzIpfD6z2Vg6722gbFfmSWkikv1/L
         eLN4LkNQXJFqvMYVPJfSEdXnouK+rNvIDiXuTOYZ5zeZ2oK3SxJG00Tv7doJwKPQhnQd
         l4VvY9fzd0p7EnDvEYBkp8tQPTZPMF+n9B0/O+52Yse1S5/c9+cbz8s59vuq5Qf2TnRH
         jKri2/gdgVqAY+OzIxEXj8wdypTWMuJoJP822nV+mSqbDo3BukpmItux+P24Ti4CRob6
         a2fg==
X-Forwarded-Encrypted: i=1; AHgh+RrqHDcRTry0zV5r7qn5Qt0pJpAUolArzPr9E5VASHsydnHQVf4EgJEFjZ7THtBmCLZ7xshdC5wZkMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydm/EGq6P1IaOg4fJPJWbQobZPurrVB6c6nbtDUHhNrLDdplfy
	yvbhI7odv4YNHgCR7yVrwlzffxhIOmCAt0GeCcS5ayOC+At1CNURfR4xojKlAFxr34G8y8uCkIX
	ZrmNhbD1wIDAakdn2zf08Uy42SrqSdku7ejBF6/SA52vDJNYSFkLf11SBHiEhe6Q=
X-Gm-Gg: AR+sD13FlvSVamkItt/0C1PXjYQ69GIrLahrbVycDaDAZU1mnz3/QWyYhzsw62kNCcM
	iwDclilPeTMMY7n0zVuX/PCT55SeorS0ynRytu5MWInJF4KB3Y6E8mcJtFCs2wx8JDdiNL8KGN0
	wGpEnH54bRkIGC2EBn1rxWJvgE7wmmW7QMZsL0XMxey4AYwtsOtqBoNAzOVYEbomqwONqCmF+dS
	OIpHNNxokdOtrWG+Tmuifk6rJqTk3Gd8fCK1yp4kArL4kKe+95vhklGaLgpa+Nf088m2X+PwEbC
	X3KWYUJ0cchQxDijxrFT7TfVHIns7PAnGDbxmuZlpQPo99X6NYPwfmsrW+dfaz+2bWU6LYJSK+Y
	9IbVI4RyuBREJ/Pz5b2mXTzPOyD1KYO2Vng==
X-Received: by 2002:a05:6a00:847:b0:84f:a82e:d32f with SMTP id d2e1a72fcca58-851b8744335mr1604973b3a.3.1786983429242;
        Mon, 17 Aug 2026 09:17:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:847:b0:84f:a82e:d32f with SMTP id d2e1a72fcca58-851b8744335mr1604919b3a.3.1786983428592;
        Mon, 17 Aug 2026 09:17:08 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fc0fd9sm563035b3a.45.2026.08.17.09.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:17:07 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 21:46:52 +0530
Subject: [PATCH v2 1/2] dt-bindings: spi: qcom-geni: Document ready-gpios
 property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-use_gpio_to_notify_master_of_spi_target_activity-v2-1-94d1eff3175f@oss.qualcomm.com>
References: <20260817-use_gpio_to_notify_master_of_spi_target_activity-v2-0-94d1eff3175f@oss.qualcomm.com>
In-Reply-To: <20260817-use_gpio_to_notify_master_of_spi_target_activity-v2-0-94d1eff3175f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786983418; l=2206;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=07fWoDKWlhLp+o+voMIwf61zTNZp2ZtvKXItlluoCmk=;
 b=gqengJBy0r1j0QNKh9Clw7XfOJmXO+r2QXfhf4Dqb7Tpvm+ee3gD+35UfzCiPMMINDosDK7iB
 H/qzlIFSrjSDHB4FFiIJ7UD/po9eYpIiuKsUENM8XVwFGaJoimF6pyY
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyNSBTYWx0ZWRfX1tzA1Dvlbgfu
 Rw+EzjD+tehzX/V9nlN3QhJplQU5Zakb6Ksgtjo88XLVwrICmkyADD4GdCcjc/cQLR6eudi5W8C
 saSRJjePUwu0JWYAr79Jk5fCI4RNfrksCtSCcyI8W06DZg199W0lLmzHmwiSAclSuqdElOnZP1k
 u2Qknxe0VynIAKB5VEzn43t+rXX9UP86p84EayhygG9mE8C0aQR2cmNHkyir6nZCq+gOXaXZIrk
 KehgYKqraXHh8uP2O96wNzJ+G0IEv+NpO2fo65qcPUkoxLxzt1Roz5ip+Q7vtNe8r9osK3xvkw+
 dxDXtNYt/1EwI8TENR5syE0aojQNVrIdp6oINwP0ATLhTttQe2tVuLcHvcZMYVpreeLQGpgY1hZ
 cfFYzVj52xxyqgEtYde/6cLIfzxe+dlhsI2fzxhZZnZMWDwf72V+kzIosgXf9usaiv+kOjTlMjP
 vhfoszxCoot/s3fXSDA==
X-Proofpoint-GUID: 8ZqjtHngB8Fls93gbU1zQLRz-1KO8USh
X-Proofpoint-ORIG-GUID: 8ZqjtHngB8Fls93gbU1zQLRz-1KO8USh
X-Authority-Analysis: v=2.4 cv=Y9/IdBeN c=1 sm=1 tr=0 ts=6a833406 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=esOR2qCunaKGNcCvXUQA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyNSBTYWx0ZWRfX43UjeMQfxkqo
 7vVEAFJMN8ETgFID1RaWKN9C35d6p0OdZkLDGdRTgOvBx8HcJ6xW5lFKeMSQ9BqHc3XqcoIFyU8
 QNl+jNcLJykzFfzDndAGC2WHzzo8anc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170125

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

