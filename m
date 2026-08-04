Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08F3428828
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827830; cv=none; b=r6t4fUC+bcTsFDjJ8/5tCQHCnxUfBj9kfaFKzEBTphrct34+4SYV2CF5fqrOAQ49JprdnRtFGx4ra+QLVUNfmsRK/bwPAFu7zOb652Muyf8NIhSR8G3no9msEhRQFQwAbD+E4aoAXg8RLnUfUnkeYPfSPVDt+YoqgcSanoB90Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827830; c=relaxed/simple;
	bh=Ls46oUW3bm1glu/q7llsd5yplMkVIyezxYsBXy8ZQ4I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F9ImtnQHQofGO0dxs06bKhvDuALXrawC1jCopLPL+GXbmCUP2xzw7JzDu4Ubs4xC9yB364a+qO4Y7udKU4101zhT9QzQC10De5W8W0T/o0mc5ue3WKLT7gItk3zKIi8on4fHJtHRAiMJ4SGSnU+9UvIMgb9uZqQgidA6KGduG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KXbKONuq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ReBLd5zP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KXbKONuq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ReBLd5zP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674184FG2353301
	for <linux-spi@vger.kernel.org>; Tue, 4 Aug 2026 07:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kHN4m1i4fZ9hfNrrNW/cU4
	TdZC3J0BJV+UC4pM93O7w=; b=KXbKONuqoIHsDYQfmg1pF1W2I3AtqZXbqPoW1P
	SfK2N+9eqsO3ErKvLj/3Rojasp7O+J1w9J4z1UbZ2nMyfQTvI5IevuTVzghfTMHU
	aekbH95E4yJrhV2O1dS5aWJscs0Ts4/FdNhf/+hjuUIVCt+SANI41wq2hOkBQVJl
	95vZzGBMu2JZ9VmV9Z3ehyQROkTtYq7p60fGTZTcLLjtZl4cHfG4CQVSMxJ0BHcX
	aF9wAQndmz3eTTCOWbHD8bjYac8y/2RNbHDgcjDA9WppzSUKkXMPcnTY1EFFuFSQ
	rXlCM9k+Vah+6jiGFACR7W6zApW7A1pztMbsOCvDr/QryHMw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu1p8abf8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 07:17:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-522de3c645dso86271911cf.3
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 00:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785827827; x=1786432627; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kHN4m1i4fZ9hfNrrNW/cU4TdZC3J0BJV+UC4pM93O7w=;
        b=ReBLd5zPP4eEpfYCgLlXeu59lk7MsaE6Kb2rOK7Gp3eqIVgW773C1loVayw2994HUM
         1DmEkiNUpKFpSyvaWvais+iXGSJe7i710ycgaFBvMNe8yZL1taxojWmkNLCbUTZwgjBw
         JSA98MaYgLZjJHzLyGi1PC3Re7iPGMEMFQCMNHFISLII3MzL+R/gC4tU2fnaFg4Tpb3u
         uD8KXC2PM/7NdGsv/Dpk/wcOKFHJjFMrvQc1c1dLv7M3fiZuqQD+ljpNYuqqf9UE4PWD
         GgA1oUa+tgkX9iJkELJj8owxeGaogXmo9CAvJVQkp7D05pdazjnZHDL/RNMbiYAWSVxk
         lSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827827; x=1786432627;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kHN4m1i4fZ9hfNrrNW/cU4TdZC3J0BJV+UC4pM93O7w=;
        b=U5kH1Ym/3agP2DPhWEgahGaGbSJPfW4zn5NId/VltpHocLdtYcPWgPfNQogxLH8fMa
         iJz5+TzCdO3JLNSURUT7/zSGuswLU/oI7AxSUJsOPky2biHgjQY7OG/GQahyldkzy4DF
         4N2fVEsH0ZEEhxRrEZi5Ggc8+sYldiPF/JhN9HFLWti0ARjBu70bUWQW5TcQCk+fOO6v
         1xiJThbgvbnnH8uNQpxxc/z2X8RoDxRCnl9uFvXOdyuXgshfslkaoJhOX8k3mX5RKjxS
         Z2KtF9MQhjQ243RcXYc52nVJ9t58qA5s+76MuNRDyhA1CiSVkn2aw0jt9FHQManzGIDy
         wOsA==
X-Gm-Message-State: AOJu0Yw0d9hgFqLVKhWGX4YNYR0yxMFr+OhflrjF+1ETRusuP+tu7gx4
	nXscRJlXfcRsB4Z/LOKjU/r/iMEmIxp6+y27xq+ag4HCWz0d3YpcFuxMIromsb8EHDUIH3YQFn7
	e876/X6npWjEeW43bOtJPaHXOZhgMxKqw0cjxlFpt7dk19YLr97NWEOCBhheiFsA=
X-Gm-Gg: AR+sD10iFFCaK4wIV0pskGAU5cpdJy1wCtnWEwFdzJhI7+ycIg5Qv/bpaFVpAzZ5iy8
	H/jb7esqwKrYyFdUGMuqqKCMjMSMnVPxYw1ReRStKNqS1HDd9Nel9M89xgepjW+QGPOBv5Rb4da
	NrxarJNSTN6RqJk0VybpO7tST6//ObTtBNT3R8B6J3M0PJKzflIv4EEKravZDFfl7hblUTpaNqW
	PE0k2Z2Mxr9QdLGDY8PxFglfNCk3LXCCPzjM0d0ggDs657UIWPy8IqKuH7tgMduBZ9U3rE2kY1r
	d14iHzTOx5kW7M8v5Idiw2WrXkoIpf9ZXa57DdaC9adSJH6mNJvSTXUwkXs4wWVYaX4l6cm+F84
	44n9H8a7XmQhnJI9Wp5Vh52dB
X-Received: by 2002:a05:622a:598e:b0:51c:981:94a6 with SMTP id d75a77b69052e-52b5674b67bmr262412681cf.23.1785827827103;
        Tue, 04 Aug 2026 00:17:07 -0700 (PDT)
X-Received: by 2002:a05:622a:598e:b0:51c:981:94a6 with SMTP id d75a77b69052e-52b5674b67bmr262412501cf.23.1785827826721;
        Tue, 04 Aug 2026 00:17:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm420265975e9.3.2026.08.04.00.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:17:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 0/5] spi: Few cleanups while looking at num-cs
Date: Tue, 04 Aug 2026 09:16:56 +0200
Message-Id: <20260804-spi-num-cs-v1-0-4ccb13dcc7b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwMT3eKCTN280lzd5GJdo0QTw+REEwOz1CQDJaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaAIMz7PBuAAAA
X-Change-ID: 20260804-spi-num-cs-2a41ca406eb0
To: CL Wang <cl634@andestech.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Vladimir Moravcevic <vmoravcevic@axiado.com>,
        Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>,
        Prasad Bolisetty <pbolisetty@axiado.com>,
        Karthikeyan Mitran <kmitran@axiado.com>,
        Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ls46oUW3bm1glu/q7llsd5yplMkVIyezxYsBXy8ZQ4I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqcZHqBPClZfpx1wh5keQDr3zLrCGUMiLQcHA4U
 Zegl36y7uGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCanGR6gAKCRDBN2bmhouD
 13xBEACVxYKsnpFVi9D/eGa7cEiCkwXQkiARdpJdGupvhnpc7wn2ew0Fa47XUSOn7TY8c7ES1dM
 OffyXqsuAzvKWCNnEi+XlD5/tBr63if31kI8qU5OChfLHackqYD97Nll11mWmspja1vHutsZCiB
 qZzVBmlTZJzXPCU+RS8JRiam0Ju1jV4K4Ub9s5WiB7qAyo6Q2Jwf02gWD5LWqJTiNa162HYuHvP
 jl3MqLIeXLIR6JHh+i/92OZIQIBFM+C68zfwlR6FtjVp3YXeNc63dQoCMjAf9on6+updiLJ97y9
 be7yhr9GKCj6tVG2T3T7WHhH83KBzgaDiGQS3sQILTFohNrGnB9oQBaipibhZtkUpDfkxFKqnKO
 Ha8pu1ap61SJS5bp4VgT9ajX4BsV3pUXO4opjafzfo4AlH9sZt8M5oNkFnC09B19Qmk6LxigqHj
 6zNr82vtoITYOa1JufbOpf8i+qhszFl7XYvP8MZv/zqRXYu442PIQ0LQA3AiToxRDhcmvgAEUdj
 +X2dTpftGN2ZIY5Y+CRTOqGy0xLCFqI2qMcVSxCz4LhaxEEgvkYy1uxeNcfXk/HXgbpFq4hM7A3
 P3qwmgyMi2Npu9g/FKbQHzRRhv9Lrp9NQOp5e6CcDDB/fbm6XPuGmOikJONdvZo9KvB432nZjue
 ODfKflWYf9ksuPg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=A5xc+aWG c=1 sm=1 tr=0 ts=6a7191f3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KYoR_bMC0TEJ0A7QCGIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NiBTYWx0ZWRfX5EvbKhKwFi91
 o2YQzfzLJc/LmxBCJhs04JTEYwIAhaeUOZcxFzQm3Oadl1M2Erbfd6USuklKnPgks/b8xeCUmeY
 OxWPJ6E54fZsf58mhDQbuGCIgi3C1M1j3aM1r4kkYvk7KBUeB9rOyLZc4oR1MuC3YYbqaq5K/MR
 2Xb8sTzIkkrpNm+BYK05O1g7vb8IqK5H0EhLN50J4Kw08jJo35t5QEOrvvVLhV+pzB/Vu9zVOSj
 nm8bwtxZFWPrbovXO0W8sl1kfMl3zSqV9W6+gLS5pcOPtkdL2VB/z5S+2AeTgjFuuas/9JuSs0F
 LHE7uX1T+9LMog38vXQXYoXqaH91PKnArZSiKmR2eTqKxo2t7/vnZDhOGImLZ0pLaN33jJbNHqY
 LUKSIyW25pfMB/eaAdwlH394OdPLCqNI73z/ozaTZQHTRY1nlbIwe2bqRNm16QU7/TM8v0Ra5iy
 UFukw5ALhFAYj/bXKkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NiBTYWx0ZWRfX8qBSkOhbBdHJ
 EODd8576rQ1nHyzUM8x/TRpJd+C8BKd2VB0ywvDEEYIQeBwRHmModdpKB48Ao2GgCQgMBjkY0Dn
 HL03F1DbJsg+eaRdm6F4TbG6dNj+N0A=
X-Proofpoint-ORIG-GUID: uufOlu4SuEdLmdxXwSt6fj-DC-JuFa_1
X-Proofpoint-GUID: uufOlu4SuEdLmdxXwSt6fj-DC-JuFa_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040056

Few minor cleanups for DT bindings and Andes driver.

Patches do not have inter-dependencies.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      spi: dt-bindings: andestech,ae350-spi: Drop redundant num-cs
      spi: dt-bindings: marvell,armada-3700-spi: Drop redundant num-cs
      spi: dt-bindings: axiado,ax3000-spi: Drop duplicated type/ref
      spi: dt-bindings: spi-cadence: Drop duplicated type/ref
      spi: atcspi200: Drop redundant andestech,qilai-spi compatible

 Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml     | 4 ----
 Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml       | 1 -
 Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml | 3 ---
 Documentation/devicetree/bindings/spi/spi-cadence.yaml             | 1 -
 drivers/spi/spi-atcspi200.c                                        | 1 -
 5 files changed, 10 deletions(-)
---
base-commit: 415606a7be939835db9b0d6b711887586646346d
change-id: 20260804-spi-num-cs-2a41ca406eb0

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

