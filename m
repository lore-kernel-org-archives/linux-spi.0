Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36037EFF6
	for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070798; cv=none; b=KMT2x5rfy+XAuRFoLLzoawOdN9d0mALMAOhE+nSwN0et1vCFJsZiidGCary4rQVpHw1JgUVHWneCqQ09VeCQrSdtBrsLN51xNX+aUMssixdoVQTz+iQ6wboSC3jBSsdGfB5cqRYYndo0xNAi6NrwtERD/oSMvWr9Rv3snV8Nu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070798; c=relaxed/simple;
	bh=L442J0TwwkkuIUC8FYLtsVKcRZ/d3ytHa4etGdl3Eb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AsKOHZPZamAEdpfDRwgQTyp9AdTucWt6tvudMXQPjcmRfrDpdmex0Cv0MfCcr1lSf2uxAvTlihAz7LH/+5CpuULxl6UnLlnHLHR7bA84hHWVIt4yFEbjT9FzPE3xq2vKDwf5WY0uzdIZjctH9lKZvStFqDl2ZfZACl+5NRrECsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GBSENAhu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dEmBjIhL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GBSENAhu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dEmBjIhL"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D7CVEU1515789
	for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 08:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PkRzWo8rUsGFuiJvzYXey03vyXqqSNfhJwR
	0OAPDinw=; b=GBSENAhurBow5OKvWIniVryoqZfOKcW2NRv3zcX0ljvPGWpHlPb
	ifAPMFHfBUZ+qfK1P5XzRYDE9FO5hlqe5wjgQ4OXBjgBMiRpEy+ORghG2dOKWL4Y
	NDEOf+ln4bmsKnUlPSnnSk/GXWi686M/GCYwp5S3hVTFlHMQ4NDPiTDLzzPHNj/1
	YPuL2f9RfYnaNFkcqrdkArypype57F9Scb1enazrkAMFqJckmiuFcepSrV7N+Zx5
	SOSDUKIR/dVkIClTEZoYhCgTknairwqT4NgmH8kfSpeMhkbHhwzrO1EHa4phtsJm
	oXvicdAprjuMxwf81X4vRlntC0xC0Es9mVw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtmk92-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 08:59:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b4b81c632so34790511cf.1
        for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776070795; x=1776675595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PkRzWo8rUsGFuiJvzYXey03vyXqqSNfhJwR0OAPDinw=;
        b=dEmBjIhLVzKKtlfujTmDPnYOwYHwW7CMpP7KRL8v0v74VCb26uFAXLxo9bJoRzRT0I
         AmaQbkrxG6VM4NYYrNGBBD4uItFpGQIYEVWnQBV9zLUXgRrokvIVHaJ/lAzUGY2p6eQX
         J7lFhWQ0XDZMPlZEbkQnDYJkF8Y9gZvaIDdCEx2fHyF1k584kut7rWSLb8lraBjFQmd8
         bLNprARE6NEMilF8pNd49ay7CA/3vz5gtE3bS/e6/5lVuMqoRoxqLn/VYUXjhiliGC1s
         a+dHY3pooB/h7Sop5TDeRhUbrkfQuxs00HFR5fu6J0P2De2IKIM4t69mv829x+jyDkfy
         lNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070795; x=1776675595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkRzWo8rUsGFuiJvzYXey03vyXqqSNfhJwR0OAPDinw=;
        b=SWpFzMNRykKBvaQZE8sHwuHA/HoRFg71jMKatxa5cf9CpinIVOiinmqTDo4sA+4k9a
         zwLHQYYprWccLJMECdl5A9sDAA9QPkJcEoF8je5gxom0R1rYNhHqZyD6tcjlz3UsYGmT
         84IygFeXwPUbMSYwnpsGD7o7cY1x5/XPD7QLmUc82dr2E+rqTMJLiJVUTUw5LrWB1+JI
         uIpd/YYHEXqIe6BY9L/1s+j2e4MGq2nlTLlYFA7TyxFOhczHQr/dVbiYNXMUiBf+VdG5
         1IDMeyc37nXTfeIPH+4ejc0imkdBt6wY1eSsKtkS4EnyDsDqZyR3CFkOvrB9cmcwTakQ
         COIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8nVW4fje0eBLzLv9Nkciw5Ly+JvcgIC2b9q6/QS1H2226RHAXueZO+eFB59/mN03cKHbt8Xcs8wOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0YBzAfc7f+SKlq5WA/P6QwrNg5izGHhgLQXmGJS0TKuaE4Bgr
	y82/l5CGhQ1BvxNA3Gmz47F/4e4vrwJQx1HabBGORCNi3rAzTAy2A2F4pP6PgflIG5VmQ2EdeBJ
	q37Gi51z2QRC41AUlmYXas7m6nNVfKKqnTl6NZgOm7DFhayil0JCpJdSUacAUYyA=
X-Gm-Gg: AeBDiesvFi6fhZBzKo+wV4KJMfIcOSUqQenlPX/9YXMMU3v8VA+LxhuYpC6DVA2CR82
	k1sXCfGBU5UZr3g3RY3n1W4j2fgXuaiTGCGXJP4Ov4NGhu4sX03/JqvjEYu8z5ovLfJBy/5uFFa
	k9LVZym0Y38f+vdxMNNiUL8fUqVqLoGyF3A8/TLGtaRL0YR8mIhw79AjSwuoXGWStb8gAmhhWVz
	zArOowDHO+CDRFyVcYhCiXPnV9RrtJDDhSq4yqI9L8p7Ke3x7nM9tmLuPuaDi3h0+JnjF8ZLPg1
	SDhdGIHjV3Bltao7+dtGcaDdVl8etiqArC5U9lm6RlzIZC6XEFRgcJb32e4B8QwUrIujX71WvnD
	on9PKjTpvWusTl4E6bu4fMlMH0ZOaIJn5UfcW
X-Received: by 2002:a05:622a:a988:10b0:50d:a987:89b2 with SMTP id d75a77b69052e-50dd5baac89mr141941201cf.31.1776070795254;
        Mon, 13 Apr 2026 01:59:55 -0700 (PDT)
X-Received: by 2002:a05:622a:a988:10b0:50d:a987:89b2 with SMTP id d75a77b69052e-50dd5baac89mr141941081cf.31.1776070794793;
        Mon, 13 Apr 2026 01:59:54 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d76eeb2d1sm11422184f8f.22.2026.04.13.01.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:59:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] spi: dt-bindings: fsl: Correct GPIO flags in the example
Date: Mon, 13 Apr 2026 10:59:48 +0200
Message-ID: <20260413085947.51047-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=L442J0TwwkkuIUC8FYLtsVKcRZ/d3ytHa4etGdl3Eb4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp3LCDCBTRylj4M0qHf00HBSs+2Cjmd/aCt+/Eh
 mZkVchvrUKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadywgwAKCRDBN2bmhouD
 1zx7EACIuCXQH/hzaxeBNlbEEVVMthpbn76FXO2qqvkHHfx4wg+IbzpOyt/2BJCX0k0Ttz7pg7K
 BHeEbMi8ZVDl+iYTGU+VHLFZeJqCIdhPEUCFyfpEVuPQctB/9dxTg4oJ/lSA7Mn7OwKneGDBMSV
 J7jLPAwaP3BUXoHtWIw6kkaHcZvV1SjJwuW2P4k00vgjHkSh4KlX0eHreqnfxgPASU3KBKyl88L
 FcDDgYK1wuxjsNtiEXEsl40H6h7lOV1jdHRHCWrVuPv990b7HTlyUV8w6vvm3YzLpIXHnCWMui2
 cJBQKyYj0jsgXXbX6LknlY35Cle91GPmxFp5ci7u9xw/rFXzVGen/4sW3m/h2Wt7Nz5dtSymQpk
 r3BEau2OVdEX1hh56aHiFIJd5M/5lYQ26b1ncu5ysIHA7W+SUWNhM8wpjRpnFz0yvz4RZ53M6bu
 DAYismfE9cjhLFEI1MO5U9PWp8UQ9YjyTiKvAOH++L61pHscInvwOGS/fu6EfJFGZxgx6ON+/gY
 U/cBsnaLvzFOx7cP4PaC1+jNr1RGz/QszROpeUPfOoynn4pig08ofyoWRpnoM84b4d3tRSQsJoC
 /l+3JGh8OnNWFJwurX1aYb/3x00iH+eZd3T8950yVkY9meqGkxEptjePbpWoHJWgelvawBFj6pp WGzA77obQ3UhGOw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69dcb08b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=vGezUznNFi9R9SW6FEQA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 9KADZvoXbFB9XycAG_LAEkKd6crADO-X
X-Proofpoint-ORIG-GUID: 9KADZvoXbFB9XycAG_LAEkKd6crADO-X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4NyBTYWx0ZWRfX88JYAcNlykbR
 MvNMzjYHezuZiXZEvtUkIsSvTZlXry0rz6EHavCRGLVaMmhB5ZTxtC9puQhjdDbYP/zoHgcsLKK
 dFzxtRH+ikNDlBfHNqTJ5mlFLEB63J6dXGQ+dC0yzyEYQmxfDJlvZFLRsbcwX9z3Fg8+PJJvmxn
 8LHdkSlJhQVbUwTLuVtLe+PVRy7V7GY3L1m8HRJvuXw15SgwaW/7rEbhR1LkchfqEtniSerzPHZ
 7sAI8/DMFXd2aZMko7cjJhA7BmF+Wo/J+p4VyFP808OIWdGDyiXsSblQCpk3WWCFFx362yC8Lwu
 tQRUJ62iRllF8oQrOHIm1TU/bAkqh2GqpLmhbEVzn2EdcaRDWP35o5OSoXeYVQ3cM7zuEKo1U1T
 Dx8P5V54BMPiJ5U8gJiS/Z4LDz0Bb4NCJLcez1aiiLHKmGoVLRgpy1qbstk5wgOWRChJuL4MOdK
 qkcvpzdAJq0XzqBcQpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130087

IRQ_TYPE_xxx flags are not correct in the context of GPIO flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning: IRQ_TYPE_EDGE_RISING = 1 = GPIO_ACTIVE_LOW.

Correct the example DTS to use proper flags for chip select GPIOs,
assuming the author of the code wanted similar logical behavior:

  IRQ_TYPE_EDGE_RISING => GPIO_ACTIVE_HIGH

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/spi/fsl,spi.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi.yaml
index d74792fc9bf2..6a359488dd41 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi.yaml
@@ -59,7 +59,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
 
     spi@4c0 {
         compatible = "fsl,spi";
@@ -67,8 +67,8 @@ examples:
         cell-index = <0>;
         interrupts = <82 0>;
         mode = "cpu";
-        cs-gpios = <&gpio 18 IRQ_TYPE_EDGE_RISING          // device reg=<0>
-                    &gpio 19 IRQ_TYPE_EDGE_RISING>;        // device reg=<1>
+        cs-gpios = <&gpio 18 GPIO_ACTIVE_HIGH>,        // device reg=<0>
+                   <&gpio 19 GPIO_ACTIVE_HIGH>;        // device reg=<1>
     };
 
 ...
-- 
2.51.0

