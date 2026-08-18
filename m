Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62644236B
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060316; cv=none; b=edEQEByhn4UjHlqUzUT6vS/nTvSUFGsX3q4WoG5mN9jG/ps9ptp1L0fWhC1m565FrgZzhorJ93hKcq5BqM6q+Ktnc8Tk1e6Laol5dBEGohJ5H1HQziEuHqhq5h1b2J7R1ojl66ad9VqIMZvah3NyaJjUftwqENacXij72Y1NZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060316; c=relaxed/simple;
	bh=07fWoDKWlhLp+o+voMIwf61zTNZp2ZtvKXItlluoCmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7mt/4fo1mZznCANTFlTa0oWG4xVCH0GcWX3bd6f7owBqntglo++dds+8pAE2ihGQUS4o1jL/bBKu1XqEGDgYI3zM1R4LkjwZqS3Q/wf+YHzAb52JvKNSggLdSd//h8Wr57hQZ9AGnG0fdUVy0XvD8jxM2pfpNUPjuz69jEbH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c/KP/kKc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XaMX9ZTS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c/KP/kKc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XaMX9ZTS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDcLfi242475
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SY8+egivx5hMX+E10IaKzHuFd6+P6fa7OvrZXy9RXk4=; b=c/KP/kKcpknNp/QK
	IKzuUqrKIaaNAY8cE0TDaRSbumBAD8/y1kf3lWQLU4DMm3NEmNV22ObUHN2ugfT2
	Aye3vCcJHl+3/DqbF7arZ7NmE7aOikF5vIPCLy8IIi2CgkI70Pq0gCm32dF4HIqJ
	8YEJ4vUgIPyG4g6FVKBZ740xa2ruAXuTI19T/aWRJcFctuaOJ1OFiCqDyVKspEZW
	SlIjYE4F7oSZ2Iju4DPuCs3HjxiAGzy2Yi2VkGUHXKv6AlMokgwxVVBzVQwwnEyq
	PiJo4s0kLO+Sij0pAqP2uYbLFNhuufXsY0FKOTOChm1800pwX4AmfyF6zHwXS9mv
	KeFRiQ==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4resg019-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:38:29 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6b0e7370be1so1118632eaf.0
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787060308; x=1787665108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SY8+egivx5hMX+E10IaKzHuFd6+P6fa7OvrZXy9RXk4=;
        b=XaMX9ZTS/xhy1/P72Hj6EaYv1zh3I7Fdjn5Rn9XhjpxlVVOWRlw+XLwj8JsF0HUM1k
         tTELvpRLmjJMsZ09y5rvmPTRfFypoTmjvWftqltMQ+UT+7GANvdCV6qIkouwA+C9euuT
         pFCtzcrz1OY+MhARNTr7VYsNfwBoE1btNyBMiRf/TXdq7M8AJ3iGbL/bpv51mzx2534D
         7aszapXv735WQJ0KoYrNr+eWk2zeDt5S8pq5MDINl/sVNGFBZ928jhZiqTk1/IhKQ5Zr
         nSj1oYMnDLzqpqxmF9F9bctXkl3FtvJacFz8EBUT3cvkvzTzcY9rIyIUhX2EDhkTQ4yH
         v3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787060308; x=1787665108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SY8+egivx5hMX+E10IaKzHuFd6+P6fa7OvrZXy9RXk4=;
        b=Lk5kZFN1uoRiPhw3pNVV5vo05oSHuLx/4NaweHmVbvWOsWcnLye7X2oGl1kse+L5pq
         kQLpdnQwEEUx/XxRg78tj2uKscw2YIjQOvp/kaY7eoUFY2Zj9e8g8/peW4g1lIGQylyq
         hROc4NsqpP9bDu1rnwUWGjo3bAh24NaImbzfh0fj5qMTUnb93yckiIV/UNsVE2Kb+zyz
         WNYoc4xV9gmQ+A6DtZ7uUFAqJdHz7ZF6amz7rnzqD+cZQ3Emw+Nlzkzt1L/Ts2dEObOG
         idcHDVSf3XqdREym6kS5/jJ9W3qkC3wckiqmzsy2gzWM8l1ae2zrTLVoDUXp0AaC6o26
         2+MQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzDw1ve7Rm28Hech0ksRgUszYC3jtsYmT0QKtoybaE86rPPnJXYNrEEFjPqzoznSdUaZfz+3HAsFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNckobjbFwXiLNY5opALeenXZyL5dLn+jv2cRSTEHzDbRgzP/4
	mrNFxoLAufyvUYZYpHyBgNj5Wa0zAgsEkahtvprMAXIW3INbYr1KxmPuMQAfKP78XKzTUygADV0
	QcktgFLaEPaI0KjJ9uFigH58a9uqQvaQemASAMu+TlU/oegdv54K+j8ACALJH5bY=
X-Gm-Gg: AR+sD13fhzabN4qU9JerdD9yqBIWxZ+WwpZVk3VnA3+CyJgJdJKf2IavLe/b36giqku
	yBfueuTzQEh+nTTSNcDDceidXBb0NlhAQi19RygL9GcciDNaHnhUovAj5TjcN2dKoGbx13an5Z7
	g5PsshgPB4Df80q4UyrbL83GiWCOZRNR0e1qZ1zs31h5mXPh5OqqF1G2J8Vj3wWT/I9YwBCXc+h
	y/FfOIKDKU77f1qzb2LsBhjtMiDfqzYbnnczIsQrR/ULS+5tRLVofZVVdu67KD8SqUp/jc1rENv
	QlZPhSlHR05Wc6huPfJ7q6/EHFI5y0xlWYY7cIg3c00AZbZ3+jXjPui2FB3m5XAutlFxP5gerN/
	EcFY9dmu4cVxSbvt+KgyLISNBySeSCWRX/w==
X-Received: by 2002:a05:6820:56c2:b0:6b1:2ac9:a9ef with SMTP id 006d021491bc7-6b12ac9d91dmr2027103eaf.1.1787060308498;
        Tue, 18 Aug 2026 06:38:28 -0700 (PDT)
X-Received: by 2002:a05:6820:56c2:b0:6b1:2ac9:a9ef with SMTP id 006d021491bc7-6b12ac9d91dmr2027060eaf.1.1787060308035;
        Tue, 18 Aug 2026 06:38:28 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45f22aea368sm3232956fac.5.2026.08.18.06.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:38:27 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 19:08:10 +0530
Subject: [PATCH v3 1/2] spi: dt-bindings: Document ready-gpios property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-1-e1c9e0dabbda@oss.qualcomm.com>
References: <20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-0-e1c9e0dabbda@oss.qualcomm.com>
In-Reply-To: <20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-0-e1c9e0dabbda@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787060297; l=2206;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=07fWoDKWlhLp+o+voMIwf61zTNZp2ZtvKXItlluoCmk=;
 b=+RfIboZ6AQXsKOzLAQuW7H+UHiOiN/W0hk/Va8G/kwNY7uBMbbuHOeKUmbGxrj3QzRK1Om1aQ
 h4SFLmlIKcdB3Yj6ChOxYrser1T90jnnfDzj6p2lpquvTZt3VXl686H
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=Ne/WEWD4 c=1 sm=1 tr=0 ts=6a846055 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=esOR2qCunaKGNcCvXUQA:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-GUID: VYLq6sdERRZO9gFwbxC3nvVF_nBYD-wA
X-Proofpoint-ORIG-GUID: VYLq6sdERRZO9gFwbxC3nvVF_nBYD-wA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMCBTYWx0ZWRfX/HksxGVmvbjo
 5NgwgQPmcIZ+oHI33qONWzT1ekaDKo3hceAZi3L/nY0JZ4J53rDX3ojVA+s8OP7D+baeDwm9sfr
 zKzi/xYc34SBDMo+e5O1KieOx5/z+JM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMCBTYWx0ZWRfX27Y3BfpDP42x
 /IbQAg2oT4f4rvRczggBqdzGekYdrjgQ/dRaREk+4+hvXbm7HcU2WiWTREdIhtbe+ghXjWhU+IL
 +/nq3kJDjsFsh1vhP1IVy4VzFS1n7dkMLOK//P1EYpn+Nc34AXP/HwdTRI6lgQgDYhKbVXGh9js
 0Jc/5sn6D3YeH0TzzIPiqOVlEg7kbS21HvVYsoDKKbYiP4CquMp1bd/tP7vEY3ZjCXc93fHuTN7
 XDHRaM2L3lh+/8o8JbBri7fMF8gwayrAXGnlbqCrGScgF/hcy6zKZaFqWJBTNW4gQ9FKvRU6FJ2
 PcOmWWbpfwZ/RFMp/nzZyzNr+8rDVGQIq1f9rPOEbkBEj3yTN0g+DaCt9356tvxHA4KIvR37gXu
 +hbjzA9eQNUz2O4bn7WpwMQ3KyBKrN/i+9dBtYPJyeOh112XbTka91wy+ekiD8Fkds10bBFePwr
 FSVGDTF9saj8+9wTdDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180100

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

