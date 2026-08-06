Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBE43F0BF
	for <linux-spi@vger.kernel.org>; Thu,  6 Aug 2026 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011246; cv=none; b=KeD2kNx3TAXS8DhmayiYzgmBcNa/Q4sBzJdVYWLAfoP7hJHOsHpY+rMP1Nm4FoH6BcMaIOCiDG93FOj3TqcuFP/pzpx1XywM+bJNpAlMn4WvdXc2EBcMO3lUCKBJjsYjlLkslmKP1vVUAC0Z90Fr/RnewAQU3GKVB3iAN6L0+x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011246; c=relaxed/simple;
	bh=JUVS2amGiaPLu8SuTSLsk+M0TeDAtxBBS1V1o1S+vsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TmeI1OWzUX8eXIOBv6UNGMKoDd3NmHN+mfONnc6KMEmOY+J02HxZdaq5Gj4S+tamuGKF31u53JpsuYm90dkFLyAssiBmaWrm5mmiDcqpjYiU4K7OzDdoyGiJ6vzFlS0SgDHgdSpd/zNhKmfGsZxLdABUnstuMI1OWFxi1MvSkCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NYSW0JEh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O1uO9YKK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NYSW0JEh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O1uO9YKK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nd6w1308851
	for <linux-spi@vger.kernel.org>; Thu, 6 Aug 2026 10:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UYs1i5dax/v+Ga+Tp9QxPnFD0dw1JUZ33BO7o3W+tUI=; b=NYSW0JEh3v2EdsfX
	LtIAWGyov+1ccl/AcPa1R0nfsI0noeWu0u9jLqd6Hqf0OIVEFp8IVScXxrWPQfME
	7KHSwYAGYRkN2ZIw/r1vS3HwQX6NxAgy+hBupUfI4cP+byXpWX5ue7Fcl84MeckG
	C4AgRcQJkIlJLF7tGUtyedxkZWQqIEXdPJdSHR0l89t6V0LzF2KWPLN5pqGL4RXe
	FjKw/tsfQRNZ7S0JGRwpF4R8PxN7GmPkbzx8JyVFwWS4dwMz7YANk4N/BM+RKVfz
	vGH2TdN7qxKlyYdgdFv0gYg/7EvHRSpSn//W0LvIkfbWurEds0Xaq5uxYFMbR8L6
	UxukrQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvp728ky3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 10:14:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84865f326efso2501712b3a.0
        for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786011243; x=1786616043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UYs1i5dax/v+Ga+Tp9QxPnFD0dw1JUZ33BO7o3W+tUI=;
        b=O1uO9YKKUiithdjQiCAZ3uqjD65G1605pOAgGeHiGlIDV3yG1m0wDh8DXS+/Kp5uCk
         KovmXtenSBi2srqNHb1bmUj35/dKs+gJPlCe888CBCuu/qtkai4BRnEAZyDA/e5BBhwK
         a3+ujoeDlaO5wgqL7OUdYgBp1zv4fECsV29kD4CFwWVQHyQhxevL+q+yUYKZJtVx6fFF
         Zr4yCUq3zXYlWbaXazauzKQYozi6hAV6khdPMv8l1nErldCYZCssIC/hHtsFX8qBrEnu
         rCtAmqtmBhYJVOD4mHodwUy1zqHdF7Dn+xn9s21xMj1Ze98bqp/blVrEp3AwlcZ8qpsm
         /A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011243; x=1786616043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYs1i5dax/v+Ga+Tp9QxPnFD0dw1JUZ33BO7o3W+tUI=;
        b=qTKp9VDIccSbBXUK1Lm5d5ONNkoHEuSosLDTkGB9bjNUlgHNfVgp9Kr3KI5Rrmyi1Z
         JDANPFGtDLKSzRaGN8VuP759GFLtARhZr3JzzmaVC2+cWWZXOjJITVJcPC6khJhbfNI+
         1/TnjlCBVVuUpgZxPzJPKKfuQEQROfS+Pv7VLA9q/zwUFJ4gQwVZwVPS1lYOLs3fwQhR
         F9vJauGcItMjj4X1qsxlm89hLTIAfuMtgoEeLdXAZonMSl0uFHvKSvTDrvfkl0BIVCiV
         CLDyGtfM/de2hOTm0btzfsmbGpqgmV+1ellM7ElXmXjbCu9Zar9n04oZ48NdqWf8AI6S
         W5qQ==
X-Forwarded-Encrypted: i=1; AHgh+RrVyFY1NLS9iJktA8rlamuQpDKn7WqVSISHQJbHirWnLUPznBxzF7QQZH0DejFlZcKU9sf9x5e8F7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwulctrXpFyJ1oN0fkNOefNgHO6qTqr75/twon1HYT0qEsvOB/X
	Bj4zYQg1rtgllMKXf5RCDjSgBKLqVrw3BYHYfzjCHAccDGhCwzZabsyOAOcCRBXFuxIJolrVs0F
	Z/4qGPqS0/4G8p+qImN0t8MlAHvK2n4f0U7I/1KsDlqVM46znmDhO8LLoSAapZM0=
X-Gm-Gg: AR+sD10e5de+VGAmGR9JFk4SLIaRI/pBzq6EEA0+S6bu/A9kqWBN7oJK2mn5AiuVMOQ
	bOwsZ70/4ZMwBdss4zqwqbG+Z8JPeYus86Wc0DlD4V1BMBJewG+Ku8rfbFELUk9m9DnsVGAU2Sf
	/kcf7K1fiF9Pf6P4eksYO3KAbwD1OBj3GBV/YSM3MSBi/37OkvI0SmraxO+hnHHehMV17RQ8vOg
	dkBfGp7xbfCflhwcY7QqGasm3X7tFUzawxVRHyAiJUVJIwY06me9Hfhc6lKe1FfV6nOGcd5nzXL
	unzSIsx9C9XLyNL9bK0K59JeNUWaOtdRN4f3UIF6S1FtDrePF9dq1iZk9kSoTslffXFC6SGEMSX
	24DW6ESMNIDZOOTwBTiK4ydgervTprY7o2w==
X-Received: by 2002:aa7:9303:0:b0:848:6b76:592f with SMTP id d2e1a72fcca58-84f2e021ecfmr16611472b3a.5.1786011243130;
        Thu, 06 Aug 2026 03:14:03 -0700 (PDT)
X-Received: by 2002:aa7:9303:0:b0:848:6b76:592f with SMTP id d2e1a72fcca58-84f2e021ecfmr16611403b3a.5.1786011242576;
        Thu, 06 Aug 2026 03:14:02 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe707c9970sm2668814a12.6.2026.08.06.03.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:14:02 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 15:43:44 +0530
Subject: [PATCH 1/2] dt-bindings: spi: qcom-geni: Document device-gpios
 property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-1-c363a9b5df69@oss.qualcomm.com>
References: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com>
In-Reply-To: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786011233; l=2211;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=JUVS2amGiaPLu8SuTSLsk+M0TeDAtxBBS1V1o1S+vsI=;
 b=fh1XDLwI043mgR0GIPSWqWhjVIRNFfG93oZjbCd7tBZTWKq3ltD7oJ349KNu11kPbkxpzcdzZ
 ghy3qZa3O/yDQkX6fPGpGqUgbnZg3pbE02ByzNVO+lnZ5xKM+uwWn1J
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: 9SGtXuZCPCafjOsHAM8kjzejNfS6FMND
X-Authority-Analysis: v=2.4 cv=JYCMa0KV c=1 sm=1 tr=0 ts=6a745e6c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Vu4POOTox8Ki18_upKsA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4MCBTYWx0ZWRfX4dawSoicb7Rh
 p1PYd1vUj8kPR0WMo5eiwG3hlpwxUto4JjWl2dif0oqeJ4FJenHhM7acsRCr6gvLq4EYmNr29WJ
 ZEqnsufQ8eO4es4BHiI0sL0bQ/2ArUvjhUjuaqUSgH45QAoEPDK+lZEXa2ohRSuGLp1BY0BNC94
 0ewnq20MGQXlaeBOJO5F5cm37abnwAiEmXJ3mOBm23yJXZOO1d6te+IoHV43YgWdvVyZ2FWSbzp
 BM8leOXXqHzFSg872eVf8vCWFSWiFA4DSNe+EszZ8ghpaMscmnvFcvIq8eTK+5eH7DqzVbmegy1
 AVu/Y5tzSfQLK7zEYhI7fIhGuCxJiTHXxIYale75M2rSIlysgDQg4/Q5kOeV+4NwMWmyYwol4iw
 DENi5/H9LOVyxfNVBPoVIpRz/mYvpXIapgwsDWvSJZ2jzxqJsgRB/EJ5Fu1oLwezVa3IxsyyTXd
 RzIWnfBUhqN4YkhE0nw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4MCBTYWx0ZWRfX1iRUWQQTvzEb
 sisozn2hXTHunmFp8yJbFK6Yl6cboEh9Oex2/wudmjfpVMbY6iUgDXyiYjbEcdTMg7v8tzDVS/B
 WikOtRYD88plkm3LUEW3m5oTRZ64Z24=
X-Proofpoint-GUID: 9SGtXuZCPCafjOsHAM8kjzejNfS6FMND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060080

When operating in SPI target (slave) mode, the GENI SPI controller can
use an external GPIO to notify the SPI master about the target's
active state.

Document the optional device-gpios property for the qcom,spi-geni-qcom
and qcom,sa8255p-geni-spi bindings, restricted to spi-slave nodes.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml | 9 +++++++++
 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml    | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml b/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
index 6552303a4f52..aa75cd6dab13 100644
--- a/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
@@ -39,6 +39,12 @@ properties:
       - const: power
       - const: perf
 
+  device-gpios:
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
+  device-gpios: [ spi-slave ]
+
 allOf:
   - $ref: /schemas/spi/spi-controller.yaml#
 
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index edf399681d7a..d97f928e206c 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -67,6 +67,12 @@ properties:
   reg:
     maxItems: 1
 
+  device-gpios:
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
+  device-gpios: [ spi-slave ]
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1

