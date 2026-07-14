Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA438D3F2
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030557; cv=none; b=rEp2T58KFJXJSGELDkfzyiK6zge+al+Vwoikaruf79ECFhumXn6Gdtskt3UXteI3AQ+hTKfI/rb5MjsRV4r1yqDiIa+GxDjpQ9xbqssOf41L7Mym9YVLYdeUbcMt4MZHerTsBF0+FUzP5P9mI0i5YXbKWiZ9J7WKSiheonp5E0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030557; c=relaxed/simple;
	bh=mT/J0p1jnX+6QgzShInZ//DKc6SSmtQWVaUr9yNBCa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gvs1ptSXcdKTENEpgYvFoAgbrwig+Zeo4enT14vMakEi9tSMVy5ui1+dmsiuTwgN6PUarkusBjEAItdso6eh0YVEwtNxmTHQZxmC5VN8B5x5faCs8bFD5KbcqUBfyajV2rVciN8HoUMHxqlpbdHTuYbGQaL1nFk6kHcfvgO3Gdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aGTXvnxz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NG0TyM32; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aGTXvnxz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NG0TyM32"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBNxFj328599
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 12:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Ax64JMF/5Cw5Bh6xQ4LCelirXb5p1wD9gT9
	SFhvRP34=; b=aGTXvnxzp/94nMoX4LiO4gxc94wG3FxlGOugHAFXmNO08Thja62
	auVAWVIARCH367TWQunC9IexljHN3KaiCxUpdJthqacy7enPMWpIB/+iA6n5MuJt
	R8vHN1jH/7Ild+UJUyZ7KIH2fEe9yA4gnjKC+bBhmvOdzVKNsjXwF4MPb3H7lfsd
	DmJ3t1Psd1CtIOhHZh5L2NBsY+w2BoKfYN9h5ZoOYCFXbru9C5UJDwi/35Eqk0nM
	wFgxxusCZ4dscSt32lpEz8mkY/t+jdSLIlp5/6NxbCkr+eaZT+hYsiqDMH/n2/8/
	LeVKTj8PCIbRo24CkHuz8mZuN1GzxvCvnFQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgeq11hs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 12:02:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38d7fcd1f66so6254798a91.2
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 05:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784030554; x=1784635354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ax64JMF/5Cw5Bh6xQ4LCelirXb5p1wD9gT9SFhvRP34=;
        b=NG0TyM32LnLGByxB3ntpYz2KS2Ur16DUzqGGVsxarCwa9cUW7LwdvlHws4zJX3cXpH
         rLsGtNFXCJf5b3HUX69GbOt0USlZREDeB2IKB7lB/MqaJbgBqTRInj7N/Y/9+VjOwowI
         iOqxVPcBP1csd2Ic0MOefbK4BKoEHnoMqpQNQPlBVlZmJq4FXo57O6d4HVx/E/REt/6P
         kZe/6QgzYUPHHT2KOfj34wsIJ52xpWKFok/bVf7GDhKj4qI+jdarX0kTIRPM5MBfopsM
         KFzhA2+LLJiQVv7oDL5vNcwvbiQrPVtK2kerAgwB73/CFUoQZROybF1B9BNiyE13P4bd
         h2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030554; x=1784635354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ax64JMF/5Cw5Bh6xQ4LCelirXb5p1wD9gT9SFhvRP34=;
        b=BNWa0g6RLi7N8MOo24+Vrnkfd3wimxsL3ZlgQtSMSQxb3lXawl5nj1om555FP+9Pyx
         ffAIplw1dq3Jo2tCIY3zYkGlDArga1OeGtdha9Rt8KH1N03lM68t1QQK6NSv2jJtcbwU
         +G4Lc8ZoLWCLmZcORUtwUyIEiBEGlGlsjDEjPJzRZNgJmR4yS5I4lNrMJ5y9SdpJAvkf
         RUMU9lhCTnjCKr0YNTgknMq/QRS/0n6HvhORKS/gOTELVmJKr2uXDZzHh3ANf1Xa/jS+
         4dC1GXs5ATfhSWrFHNZZ38LHsokRRjuuvfdLPEq2c3QjSzhjhptKnjQjV06o6uku9XP3
         Aiug==
X-Forwarded-Encrypted: i=1; AHgh+RqDUd2JR6vvmSWqp6Ox/0c5/lrZtB5v3799v4cDYkXOdxZ0cjKoI1YHf7UXMTwipMm8RlUxvInjBEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNOo15XYMVonyfmFziQcmTANNT/3Evqa+5jUgwaixTfLt5MYa
	8xAZDTXAUh7DuMwAteCNVglFlCab29V1G7aYD/zUtvJmp/urumK5uHjXaJ3EgnE6pQEmSf1LPry
	NCd7no02dPT2KYx1iX8HWrO/norPWJLyETTbcmkLdQjuf13gBKyFh8ZryDxByMSY=
X-Gm-Gg: AfdE7cm78aREGO8HkOTmSr7KzI67BD95R/SmFQkMhOtlvfaoPWreEDDSeR97Xv9IN7I
	1qWLgQXTTzjMWlCnPldhjK8/W+uaRJS5f1b0hANsb6SaIBIkX56ftJzAP08bP9DdRKvVW+rS1Vh
	8+Xrf64QiHOmJoMpIvM9gGNSVaYbZ51pSCTUCOPG/D4avYLJZ0m1iDfTWt4nh2BUQ8O2CuYcW43
	0kvc7I8EaWNBM7XQo0wUGG9SIyUccO807dPUEwVa5PwVfV817zTCIHRDpXfwOBvXyRJc+14cLi/
	1PykyHDIRAoe3XJPhQpwoXazRSm2mlIWqXcaxIPMC/S4v/zp5+yVYjqiDDdxJR5ojIfJZ3nz1qK
	Z2g1pbCzk9VDlfL4Bq/5WAN5pKHZoUZ0M+z2Z47pRVxrwBmtlV9jlv1NPudAKV8KBNpbc4ao=
X-Received: by 2002:a17:90b:4c46:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-38e1add8ad5mr2222608a91.5.1784030554174;
        Tue, 14 Jul 2026 05:02:34 -0700 (PDT)
X-Received: by 2002:a17:90b:4c46:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-38e1add8ad5mr2222572a91.5.1784030553669;
        Tue, 14 Jul 2026 05:02:33 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119d5cf176sm54484812eec.12.2026.07.14.05.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:02:33 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] spi: dt-bindings: qcom,sa8255p-geni-spi: Add compatible for Nord SA8797P
Date: Tue, 14 Jul 2026 20:02:26 +0800
Message-ID: <20260714120226.1788391-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyNCBTYWx0ZWRfX8kMENKLqcTGz
 DQoenSCqmOSkbLHUrO6lIWEIiNgMZZrlMhX32uQ2Zm3aAS554AwbIG3KRLnnCJmKMs0nPgJJNMT
 TU1b2GhL+NWgLJLfI1F8bFGYbLShhpHsaj1sl3cIS7sQ6KnZiJFqOCdUk8KsNjIiWh0oCwApve0
 RximbnLPk5XoeWaddQTnjutkNtGDzYpYwjdPwecVsGHk4bowdNqWa3yGsxmOgaad21J6Cywdhxs
 uCsuBCQRP9HdXprKW1uJv88ILsaWsVP1HK1NJKsHIVU8G7I8UtlVMN3rZJjEoOwgjxQCObG7v5s
 iDEh1LZH/Uc+AMy0yyA2/CC1p0R61LM5HOE9ROgu/GXZhFhOJDZebxWvqRapIUVnPU3U1AXeGfR
 RDqXOgr/S48Q5+rAo2iR4kTy7qV5bWBbsJMDtsMOWJoeO+S5y/lX9FhFDaSs5FjWZg41vhLjEwv
 OOAapldpv56RoZqE2fA==
X-Proofpoint-GUID: 5eYFghJiYjWKixAZ8VGKl5FWIE8YvzkY
X-Proofpoint-ORIG-GUID: 5eYFghJiYjWKixAZ8VGKl5FWIE8YvzkY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyNCBTYWx0ZWRfX3nHkr2c63PI5
 HCLJMPtLcrdelnucBmz34H6TlL2NepvWQJTL50g2c+3AtBnaP0L98BWh84zS2c9f4jlDnzaS/Vx
 Z/alSsFcmx4BBrChCHhN+EN4K8A/ajA=
X-Authority-Analysis: v=2.4 cv=V9VNF+ni c=1 sm=1 tr=0 ts=6a56255b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ZkAwGN3o1dXtv08uZcAA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140124

Document Nord SA8797P QUP GENI SPI controller, which is compatible with
SA8255P controller.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 .../devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml      | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml b/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
index d9347d780ca4..6552303a4f52 100644
--- a/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
@@ -11,7 +11,11 @@ maintainers:
 
 properties:
   compatible:
-    const: qcom,sa8255p-geni-spi
+    oneOf:
+      - const: qcom,sa8255p-geni-spi
+      - items:
+          - const: qcom,sa8797p-geni-spi
+          - const: qcom,sa8255p-geni-spi
 
   reg:
     maxItems: 1
-- 
2.43.0

