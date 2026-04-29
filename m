Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B138AC9E
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436582; cv=none; b=YsRbfgPoj+luSLI7QhkVUJwuVeoSyGydhi74aN1OEyrDklx8xDvgCK1VwpfdZVAlqLQ7cJ6G0aGkg92My4KRVSEWJnEH25M/2ppeSjpHFDraq8G/9iACJkhdcQn59sFpN3bRDwMHPtA2zE/PEu5RJ/B5tVByPRBU24j/mtHJ1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436582; c=relaxed/simple;
	bh=5t4du17pW2GAwFsQZwduJ825MCN2mRlucu8HnAoe+JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BKQdSJspdZpsjw1zxZsXrBB7Y7sY1bD5wgJ+XythF+xumng9oPbM7TVk3/dBmDGVfwIccZpKnRR+JqOwYDpxo/EOjQrX/7gSWMkRlpy1xQxwPk6HefIkAy/cQWWLLzyGu06JTaN2JO6EPB5yfaFiLa0+TMVD5uj1wwbbwPetvO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UnOAGdwm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D0Ox7Xri; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UnOAGdwm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D0Ox7Xri"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T2lcde831214
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F/wOkbSklVvbS+H6PhRnBsyYaO1IEl7yP9PNWzZOxPs=; b=UnOAGdwmUEPtLtZb
	GewWXlNg0zKUzI+UrW8lrkqPSM5hRjIADX3+nokWGhxctmcpHnEkmETrpo9M8hef
	8N0m2Y8JGvPPr+5bHhxKx7y88P1ckdh3RsdbiyRZn6HIIQMzB19gcPOEhi6qQw18
	fYqMx+8Zaj2Db7+6p6KGZBNRfmm5BsUoqQ7HCtH3TuB56X7hD/BwYd8rZjRrIpcI
	vIPyR9tz54gfm7p6eXXE01PepdF6P2i2HZDI7Ga8o5tYCLzKsoX7qOUQG8qdQTqB
	DQaWQlS7fWxO34ye9FxO3GWJJLXljL1y9TZFGBt8q6MAXxSxWtZjNMjzdZDOwX5/
	ACbesA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du0wqa0x6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:22:59 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f6b0a7164so16197030b3a.0
        for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 21:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777436579; x=1778041379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/wOkbSklVvbS+H6PhRnBsyYaO1IEl7yP9PNWzZOxPs=;
        b=D0Ox7XriuSeBLN4eOOsmpsBWQX9FamrueOcJipSjW+0fsuzVSqyYYoOLGAD3T/s9wu
         wv/CWaBtOLYPcecszAKzuVNxV6n+vcDIBOhh4qdkCS2wLV6PRXy4Iz80YYKcjXX8pWDA
         76OnVv2E3qXZIIwPhrHUDOLtpuxrS/W2Lq8Bmxttqrl12Iu9YFDgguMoFhBnWYCzH0IL
         meTEILknO/E3srRO7hwpGf4ctVY1nRfBSzxWHgaYFdqZz74ZgYRap8DtSClKMWTq9TQV
         hpnZV4jT0vWipnhzMr98oAfkDlQAODdBZNk1y4n8RcZP8ToFTR02bx1o3pp6DdT08AUr
         XE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777436579; x=1778041379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F/wOkbSklVvbS+H6PhRnBsyYaO1IEl7yP9PNWzZOxPs=;
        b=BWIJne9jO0UWM64XFV349BKXxUnqbGd7rnBy7SGfSSTwi//6iEl9O6PtaSgzEQ7Jmf
         EIYxSYpw2NyuBgdOgINLbObGvkBJTMcp+voymQOqUSCKZLE5y5fHtNw1t5Mczvg0MZIn
         ceUfHUE4hc5yre1opiYc7sZd8rx1VMouJikp3GU21tDeznGg/BhMSmhxsOwbKWdUUA4i
         ZyWR9whI9bsr2N9yvwN097dsyxkbfwrgLGN96Dt1q6Wmq2KzuMRHfnabCUIfKve39fFt
         xNoFc6NeZtV/yoB+EWBSUpPW0VadlfknYL2dFI2WTv+jMiEYkhFVsNSC+OPtyZ1dQBd1
         K6CQ==
X-Forwarded-Encrypted: i=1; AFNElJ/U+I2n/+41v+JSmVFJqnTnbURJdRJ0u1jqSpFy/AtMgPKgPHx2C7mAUYfJ1h1TSaIRv9sVAiWCRyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxvx/QOaSAgGGwBCm6c0S+E6iIT1m6TNYk4JrOOprTi+o6en7n
	xFShsKuGCa35CrAx2DGNiHgT14w5o+rshPtg1LvQ9RC6IxLbfIg7S4mTzp2qrhQMw1YgvRQnFnD
	YWCcJv7e1u0WjxXMDHy/pO61tqrfXfPf01NOJbCAFuP2HVFtrlgP53zw4LMVNzvw=
X-Gm-Gg: AeBDietHRE7mGs/jvG5/b5cOZpl73LftjMoHzPwKE89/Z5ruYuC2E9DE+rMsqNRvhxm
	FhEssVi8SVqE+Zh6wH6huZcn6DpwW7Z/AtuoFfH+TnRywdBbzohjVuwCa5syRsz9wkAQroGbd7I
	gaTabxDrFTZLis+bhL1oysQOHvM0arnT/gGz8N9wMcZoTrwDfT0+lQAyHDByk2sf61EA90DFTvn
	OvAqzsLb7+Xg0zSjxhxrnMK2ujh2Lc0h8/W9RLWy5jaeMHcehBwuZ4fu8x+WW1Y+bYMQ4U7Gajp
	6+0t/uDN2gDVKQtNqGJpPlsT6ImTmcdj4tehpCkbV8rmOvMxqHATn3odO2R7CBckdlNG9MXV1UA
	QU13bL+Dh3yPliZdbB6duCgNtf6C7ZN5hTVz/IOqLqsR9buRw8UL1jdc9+l7dwRhha3/x
X-Received: by 2002:a05:6a00:90a8:b0:82f:2243:e445 with SMTP id d2e1a72fcca58-834ea66f266mr2042968b3a.32.1777436579327;
        Tue, 28 Apr 2026 21:22:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:90a8:b0:82f:2243:e445 with SMTP id d2e1a72fcca58-834ea66f266mr2042934b3a.32.1777436578824;
        Tue, 28 Apr 2026 21:22:58 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5a074dsm602200b3a.10.2026.04.28.21.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 21:22:58 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 09:52:40 +0530
Subject: [PATCH v4 1/7] spi: dt-bindings: qcom,spi-qcom-qspi: Add
 qcom,qcs615-qspi compatible
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-spi-nor-v4-1-73fb1bab03ba@oss.qualcomm.com>
References: <20260429-spi-nor-v4-0-73fb1bab03ba@oss.qualcomm.com>
In-Reply-To: <20260429-spi-nor-v4-0-73fb1bab03ba@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777436569; l=1728;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=5t4du17pW2GAwFsQZwduJ825MCN2mRlucu8HnAoe+JI=;
 b=pzUZDzbK9A5SfNK0sbCQUoKCfOCWnIT1mt2zm8vCLmE0YLlAgvpVQ9eeoVLngHEzQEXJuDmHS
 pn+mqQw4DaNBbn6DZZKFUWaq7gkxifOtM6vrd4hs+GRR+7JdHBQ5kqw
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-GUID: l_Zox8pAkIcVrES18UZiNHtZu9IGvvq0
X-Proofpoint-ORIG-GUID: l_Zox8pAkIcVrES18UZiNHtZu9IGvvq0
X-Authority-Analysis: v=2.4 cv=BfDoFLt2 c=1 sm=1 tr=0 ts=69f187a3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=kPckM-BePm1yi5if5TYA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAzOCBTYWx0ZWRfX2y/HPkftNTrT
 B+1cMEa+R4HrrMYHoVYk5SNBupevL8K7qZbHuaukitYNXSmW4ujYf9mth/817eqJSSBiw6RD3XN
 7UfX3f/aSR00S0phwKlMYIlPoJLOIrLGbSq6B6ueprz0jc5R7cOmOP0pUWdiCx00643aetJf03l
 Jc3ZaCTVNpJi7MTNcAGq6xcDTmuUXYa6uUkvV5oBOgxRQcpAaY3LMkGLoBJePDWaptZvfhab93p
 eV9nt9VkVHoo6xE5gFijpBqqxloV7aEDvCN1mQKMRpjR4wsTSb1YRUWgwV8YXjwumr8F5mOaen9
 mH7lKVnXZ7uDJacAa1/9HoXDQFeGe3v4ezvv8gGrMRqMI4YKQBuVx1bivKUU28LZ2VOp4hJexur
 MBkmyYHjxtkK0kzAwWZZS7u+KXjLwHbHouGlk+QymR7EhJPYguYkZ3yd1OfayL8524vmViFJ1eH
 K4aiww42CsYzp0kPfUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290038

Add support for the QSPI controller on QCS615 SoC.

Move allOf section after required properties and add if:then constraint
to require minimum 2 interconnects for qcs615 variant.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
index 1696ac46a660..ee2199027e89 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
@@ -13,13 +13,11 @@ description: The QSPI controller allows SPI protocol communication in single,
   dual, or quad wire transmission modes for read/write access to slaves such
   as NOR flash.
 
-allOf:
-  - $ref: /schemas/spi/spi-controller.yaml#
-
 properties:
   compatible:
     items:
       - enum:
+          - qcom,qcs615-qspi
           - qcom,sc7180-qspi
           - qcom,sc7280-qspi
           - qcom,sdm845-qspi
@@ -67,6 +65,23 @@ required:
   - clock-names
   - clocks
 
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,qcs615-qspi
+    then:
+      properties:
+        interconnects:
+          minItems: 2
+        interconnect-names:
+          minItems: 2
+      required:
+        - interconnects
+        - interconnect-names
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1

