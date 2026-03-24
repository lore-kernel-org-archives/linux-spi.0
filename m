Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3EA3F8E11
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358033; cv=none; b=kR1JlR5zEB8xJIuBP7mn/wsQN3Ri1YvUt2rlpLf7poDFJBCvN/Go805m8HTtcbbon9SmbSPwcbzSj+EeK56EB6pm6BRwjGkDS0UXnMmmp/RmJPvtGI+qgkwX5i+zNF+hXnBdvP+bdvsoEFmj9214gAMipxRnFQZaJYj6/Q/fdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358033; c=relaxed/simple;
	bh=XDvvASnCtgHIU18wQG3gP7ai1EVs7srYXyVWBWRgzTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndOFK2WiXwb6ecgBz7jV8ywcXQfNZROzazdbNPZyUi8liWI+d6d8fKBakdlnNVUjpL1ARnbk04S3aVABO61S+5wlCBL3QoN1yk6bO/zOiQzMVsDl32jyQiTticT4SpbyUO8oEp3xnWdiyDrwVNeLwfxnSmQjDju9PPZ0eXg4Ydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I3al6l9N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cLwmNrZ7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I3al6l9N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cLwmNrZ7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OBav1p1291309
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rEqaRn/byj85uTd+j53pd0KBVIryH/O+WbxUbn1SKQg=; b=I3al6l9NiM4e+fHP
	L6LwxsLiRc8CsCFrIyaBHiIPwdXguT8I63e2fjLhaH8WfXxIwXOCMh3tZ3F7kIcN
	i6Tmay2KkIq10KZkszoW/r2kv3l+E3OropepaYwCggsMyRgTQS2zBQoIulP1zmRL
	cUp1Jzc7ibrNeSpTSDpKdSXhJ86Jj5NfhCkL2mZF3W9btaWwG1q+77tmygEa0hc/
	24fydG7PdBtq4YSzMouDMqeaKCLEmExbwdWAXNk65Vimxjk8AgGKhnAowaU+qphT
	qiQggua6wuM1YMzmQGFo0nqiIZQ0jQojcAZBW0XGZldWWTYHPY/ZTY0g2mIcI/Si
	QnTM9g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3sw40dey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:13:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82c675116f1so1061277b3a.2
        for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 06:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774358030; x=1774962830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEqaRn/byj85uTd+j53pd0KBVIryH/O+WbxUbn1SKQg=;
        b=cLwmNrZ7/fBr5prb4gLPssk0t3bHKVHeW5pnYW9b/c0bWNIxG0vn/JkSFLCbuVDbh7
         9HEj8iPubg0C1XTPt+1q7FWfSvb/+22EuGx58KV/cYCoGYQ++YWWJF1hx+zy5Ju5ICFB
         1lWjv1+vMDpTI42SU9QNzCkHrDU1TXxpuihQZjnBqvKnUD9m62nuv3cIEVoOeAdUJMGe
         De1P4A76eZsPnGPgd+uxygZZrlczcHWHV2IRTiGPhTzNzFd0KcUBDDYd8l/ioFmqn6/R
         ZkOL6hYIP7fdnnq3WuTlQ7VAZEodEY174g50+zMLrsrgYO0PP1n5gR3PfQxUdEHVkXGx
         01Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774358030; x=1774962830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rEqaRn/byj85uTd+j53pd0KBVIryH/O+WbxUbn1SKQg=;
        b=lm37AfEyMd/afRfeMrGBeXBzS5S1v7vCo7gUz4xYq88/nLRWMN8YDeuKiSkJ/iYYQM
         7YJwUWLJBh1q0nKpjzI6EdA6y6FYHl44auArHYY7g84g0bxWYSiu8u/zUoE2jobY94Cc
         MNY503YWSaAExwqYC8sSCGDOASjiDyYQSL2FOnIvBtu9S0k3r005APk5CUs+hYz7Jb6C
         SOvLWMlz5uyNsZCKXhe7YbY0wyEexJcYco1L9SFLxZmXeqSARZXmfLcoEVYh+D2ZEkDW
         UhuI2YrzKk25C86Jp02T8kSti8ZcIR4/89tj6OWCzCcl38ecHEbHWWNLfSU+Mq/oicVQ
         D55w==
X-Forwarded-Encrypted: i=1; AJvYcCVcrQsEDt3W4S18xR0uPrzXmcGipSybchi5mn7/uxH06lxNQ2qJCKEPadMPErnDegFXre0y3pv/zeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fjPms7lJeMdkfWtBAHV75mrwzOfSCQL+fh13zngwKanMru/y
	wrQM9l7az0iUsiQ/Jvvs8AFs4iw5Z+A3TcEKisFRmtVBhTKn5LzFKTrRrFTlo6L7UCb8rWuEIQJ
	gY3qPFhAZSw2URNT74I93cmWF7Vi2LuOY3Fy7u4qlXhoW2g+Gs+FZOXcYtZ69n7Y=
X-Gm-Gg: ATEYQzwUxBc3ztNBggJ94aj4Se+jsF530JQM8jZJyItG6HkVlihq5aBkfHld0wPE8j3
	HNzuiBw8H70e7e51gCwmgrzvM+BQGu3n5ZkNDdEVd2PRz/dN6Bd7Qtwex9DkQohePukSjSM8hFT
	tJ006WWEhJc1NI2D4ulk1dOi27EVb98e9YwuOoAx4VTK7wy/qvnSJRxc43M/6X2mAWxx7aIiQyK
	E0Ciq3yHBrECPaUB1IeiPPOxyxN/nMavPHVsd1mT+cHjfBPkeWhp0O+4NMOcDT1pMSLAJuu+syA
	/lVJlSsclaT9HIFveWLp/6mbTn7H8BAV1OTvM7ASGGq49Kw0JW5sxWT1oNl9Dy+YnhBC3RdsDkI
	ZMLQh/DfveydgH58fjFay1m9deYYwloVaT16ggFYeu7OM16Hp2Me++/4OSQ==
X-Received: by 2002:a05:6a00:2316:b0:829:8af4:5eb0 with SMTP id d2e1a72fcca58-82a8c237c5emr12621842b3a.26.1774358029854;
        Tue, 24 Mar 2026 06:13:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:2316:b0:829:8af4:5eb0 with SMTP id d2e1a72fcca58-82a8c237c5emr12621815b3a.26.1774358029198;
        Tue, 24 Mar 2026 06:13:49 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03be3396sm13517528b3a.27.2026.03.24.06.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:13:48 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 18:43:18 +0530
Subject: [PATCH v1 1/6] spi: dt-bindings: qcom-qspi: Add QCS615 compatible
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-spi-nor-v1-1-3efe59c1c119@oss.qualcomm.com>
References: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
In-Reply-To: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774358020; l=881;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=XDvvASnCtgHIU18wQG3gP7ai1EVs7srYXyVWBWRgzTU=;
 b=OX7GwMB8ytt0dtJvXV0wUQx5YuDNMf+K4r9bFaR5vowtht27lFOdDO2pe2+d9Alj4CMcZ5bNI
 yVv2VDbNFRIBIpYPv2lvfvJZWjU71kdUZ2iA6p/Q8H7aDOwy62P7mW7
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwNCBTYWx0ZWRfXwsKWw9Ch9dvV
 aOIMJHWnE2deR7VCnzLv9BcIlkKcpwiVjL0U2wyewSljhbFT71CSurgm/ZITTuv1Q9NgYHu5/wD
 +Nk1WX4bL+FJ6t4qc5ptY0AIrNNuHC1j10QgFNTfSD6LlbqGqMo54YGlqhlY4BDTzw3gUjZ5F08
 bcjsPo2SmheXuYjgmbUd2al7l50H0rN6XYXaRLpNU4yHo2OxCXWe0QJR0dYnkeEp36D4b5yFcTM
 hbqjI3oeoIbp/3aAfv9NAC++YiVyMIPg2l/9GmNKbkBb9lIaQX8SN2GqR3tX6FV091M6ah2hhKZ
 hYnkk5LOFj6e87maLDeWKUpniYJgR0M1KpPskBWh0isjUSNIKGLAqRlJcNK7JUY6uZ2ofYHxYZG
 Uth1gTNDXgK8LC4DINWPCo+UOFhghZBRHv7nYNtq6VRZUsN2hLPD6VQb7JPpJn2tYI03m8AXhOx
 nqaGIFZYcclH1gL4Vtg==
X-Proofpoint-GUID: URotwYtwqzWUufYzWbuJNmRi057y3rhk
X-Authority-Analysis: v=2.4 cv=bpVBxUai c=1 sm=1 tr=0 ts=69c28e0f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=8vX_xI0UiRE_Tro4Z8AA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: URotwYtwqzWUufYzWbuJNmRi057y3rhk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240104

Add the "qcom,qcs615-qspi" compatible string to the Qualcomm QSPI device-
tree binding to enable QCS615-based platforms to use the existing QSPI
controller binding.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
index 1696ac46a660..d9aac33b695b 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,qcs615-qspi
           - qcom,sc7180-qspi
           - qcom,sc7280-qspi
           - qcom,sdm845-qspi

-- 
2.34.1

