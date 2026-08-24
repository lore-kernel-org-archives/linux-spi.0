Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE843D4EF
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581576; cv=none; b=OKuTqxnjNBSW40H7fO+/VSAqylHqf7nDf5Fr18ZIyYEUKwOq7/EiJ76hw4yZkSmr+u4gTgylMYzM6EMN84ZyffIYKc1Y5XiU0InSwv9rFCfQP3SYmBypKUP5GeLuuIeFj5/kE4gOCuUy4C+cPXQkdxAV1Y40g0ZIe3ZrGwdj8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581576; c=relaxed/simple;
	bh=0ShdK6homdK1I4Ywr5MsXY3zf48ku883tIe9a+2wHr4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NGHxujYGASS2kGi1t3a/jkCtS1pqDPMmfMQUp1NfsMwv5D4S27xxkfNUbT77NN5THhUygfGbCe+ux3mVY4e2SdFCAC5BI5I/2iheiqQRiWzNDSFmeYG3eRgl5dRDOcQi0z0BWMFaqk+VuMJZXBvcVQ62mTYGXFNvDM0TsPOXaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HNqfA0oq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=drTiUr8N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HNqfA0oq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="drTiUr8N"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCv1jS2949942
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 14:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WBLWbc7fIPLRFV4iwOUNp6
	Gtzj8ymWvJS14YqGKh6GM=; b=HNqfA0oqJ0O49IeT+BuprgDmxxTlv0V8vwVGQ2
	/pnnK8yF8wD3JIwu/4fwm6WhwpNdAUwwLCCyak2MxLC+ENiK+zymPBmsJ8D0hF0I
	yaTW8xY/VJFuP4FqlFM8jelC7mRW4OuRDwdGgDsup7bvOreHSovuic4G5QNdPPx6
	Q25txM+1c6/n+7cVgcQaoZDOHUXLqK+L8T3LC9JlYhhzHkigKYNwjrZ6yJI5r2Ir
	LKVf1dCmgBe9TZ7oyoKU3ycVF5x3dUfgNPnkA9c7ZCpzTE3kfMqIwtXceYBFqFIp
	0b5Hd4XPIAEWmprItx6lUUnjNFTC6b93JiQJk0Md9LSyR6Hw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8j7r1j3t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 14:26:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dff6253so44946615ad.1
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787581572; x=1788186372; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WBLWbc7fIPLRFV4iwOUNp6Gtzj8ymWvJS14YqGKh6GM=;
        b=drTiUr8NSvFmO9G064YL8TC6kyOjkaTv9e8GmBy/2vUMGyqvFVgNsNMp1boqld0shy
         Oj+uB++R1HMywE9a2Nvf8bi4Cm6Kofg7HEJEJmpScjTZUm/EB/H0vZctnx8ss94aAkbA
         Cs2gucqYZjcXwD2lw98cghL2fN+65kk5brg+0uUXzoqAzWvrD+5Ul7u6ARKZ6UeM0QYM
         ZCvGHsYspY5o2z+c5R0Ib457Y8tmBbCQneUzLBPM/jlP6Nltk572sgFyZHSPhm0Up7xk
         bAeVDzm2XmKQjRGks6+4vyYw9byU7EYVnUg2fVxOiqw5BK0zV8JKqjgptWfum7xVOz1G
         KN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581572; x=1788186372;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WBLWbc7fIPLRFV4iwOUNp6Gtzj8ymWvJS14YqGKh6GM=;
        b=mfTSpG4aP6tj4VP6drR4wAfNudqhXgz0XNCHI36g7egDi6fj4Ey/9J/Dm8C2hVX33q
         lOVvG3bEs8pL/MBbQ7YRWlwvbukI8x75oEts34yJNtiaskdpP5YiR86hRzdHSl8qlYCr
         Tv1mhgQxqc/rk70xtcqOMYRNu2cycR3fYxPEolWTAHwafZ3keydVue56gNzO8WZLEhhS
         MDWzzI3Np8Gpca538S2Vz6/08gtQOq78Lb3yU8JIddKRDRN5VPfzF9MVNzrnMOzVDKow
         cCcoS/G2JnHkwVeSOw1fS3fq+DVL/8RU8vnXtNfnWtg4O0vG3Uv7LlMxUZE5JhGAnEtr
         a8rQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5btrprgPe6DJDrsdszvRq5B59uezT4kCODMQ0Km8Lcg+IgwYipgbMzxV7o04UhQiiSf0Pg50kSRo=@vger.kernel.org
X-Gm-Message-State: AFuF++miBu2vKyABq73mKxFea62+Ra/E0xqiUfhlD2rh3HfFmEblNCIG
	8LHCrcAK7S9fAxq/8di/x+pi9ysGSyV/Vj1tLIcRGOJ7HN8FOkjyJKuY9PJQjI7m3B+bugoNwR6
	+pG0PzMzbZBwPLi976sTIR63XRZX0LkTqJ1LZ3hBTxU/zheHL+rwdq6ulXla/Y+8=
X-Gm-Gg: AR+sD11bXTrjaeaQxCMvYouivf+ROjdqUBRhktpYd9CU9v0Ls8YONUQVHKelihxV4OJ
	bO8rrG4n7T3QGBV4KSqd88Q2bJZQkIGjBOIwcD3e7DYLdYb4TvBZMzauSArHMz0IG6gnWqhlpur
	HQLT9EMmaubGuLaeoxMUFKxrionqEzkC1fb9mLB2KV65pM+OBVvJFIydpkKE0me6VeUvpBBhBZh
	iGKhgFstxxtMT+/unaFHN7+s4MS2+HmpTVRGJFf3GMKg0nMXUy3cGc38Vw/DmpQIeCapGfNnLla
	Vlf7fm7hw0c15/3sMlKLipTAtn4tkx7jpFvXamIrHXy76dDlfJ6yzFk04v2LNtWzCYkrvbAXR9x
	nUH38HH48kduJr/3ZYmaz6KEQwHDrMtfD1Q==
X-Received: by 2002:a17:902:ec8c:b0:2d3:b109:bd7c with SMTP id d9443c01a7336-2d61a064bdemr393425445ad.4.1787581572247;
        Mon, 24 Aug 2026 07:26:12 -0700 (PDT)
X-Received: by 2002:a17:902:ec8c:b0:2d3:b109:bd7c with SMTP id d9443c01a7336-2d61a064bdemr393424625ad.4.1787581571695;
        Mon, 24 Aug 2026 07:26:11 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676761fbcsm18523275ad.4.2026.08.24.07.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:26:11 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v4 0/2] spi: qcom-geni: Use GPIO to notify master of SPI
 target activity
Date: Mon, 24 Aug 2026 19:55:58 +0530
Message-Id: <20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-0-fde2ebf043db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHZUjGoC/53OTW6DMBAF4KtEXpfIP2BwVr1HFFnGjMlUBVPbo
 KKIu9ckmyzaRbMZ6UlP870biRAQIjkdbiTAghH9mEP5diD2asYeCuxyJpxySWuuijmC7if0Onk
 9+oRu1YOJCYL2TscJdTKhh6SNTbhgWovKSW4UsLKpK5LfTgEcft/J8+WR49x+gE27szeuGJMP6
 33Twvbeg2+o/D+/sIIWVkhhVFt1Tqp3H+Pxazaf1g/DMR+yr1j4k8PqFxyeHVV2DJwTrK7cH45
 4dpoXHJEdYFYB7UzbduYXZ9u2H6sZbmnZAQAA
X-Change-ID: 20260729-use_gpio_to_notify_master_of_spi_target_activity-5f62a9e14875
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787581567; l=2479;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=0ShdK6homdK1I4Ywr5MsXY3zf48ku883tIe9a+2wHr4=;
 b=vClp/Vnl3qxxU6XUxaggYIocXx5KsFznab0WvxYNbzLNYsnzX96SfSCWijywuhyNhcvSr6CgI
 87RRfxRXGpZCYMGHJya7tMO1nhCtwZ0vsHqGGAxoditVW5yRdCquisr
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMSBTYWx0ZWRfXxSPInZr1Os93
 qL8qTS9+5XIV2oi0NkLnyEQNuyINu+5FB8nW8QRVY/t08MjE4/+qV5b1WaRvx56LHPVqBGZud/2
 Bk5nN13z83qeHsnuJ0jNgmQLe3qKfRpKpt1BJs3Re+iaKKi4ILGaKdsOSA+UAnELceR8Aib7uU6
 pLSjdinHu6bq7mLN3Bft3+aPFeVJBY73z/CxkhZBjETnn4iikfet0zbEZXFrwYRkaGijn3o+oHt
 joOIjcmvnm7GhjFYAvmTnlsVS+TBMxmS7es/cYtjL/hghGVf3I+/MDfGhC4G4k8ivDlhAAvTfse
 CXEyXMl/lpMhzqxfxT4m9UU9uaWf7oC7it8a7mmrlB8ij5Pz1TUOUwSR4nOyVTN8c+299o5k8IT
 TER7PqNqDdJ1lD6GSodA1V9l3H4GJymxICPLcIjK7WGjKh7sepi8OWm8hhKrSkLREMigAIhG4iZ
 SzA34jNXi07M1JY8zqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMSBTYWx0ZWRfXwzp+AkkH8Tzq
 XUUCk/soQSYSAQExVyPmuSN+P1UsUtPytg3AEC6Zo4X/jAEusnGeF1o0h0wHvWAInKWvxY+EeK9
 irNGpzKM4DlrOaMgS7vJRwvUlgvjyjA=
X-Proofpoint-GUID: daO0jiiUgBMLJ9fwzU9gpnIJlES8XGLv
X-Authority-Analysis: v=2.4 cv=IL8yzAvG c=1 sm=1 tr=0 ts=6a8c5485 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=Qt6qZxy4Ex0I4-ZmshwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: daO0jiiUgBMLJ9fwzU9gpnIJlES8XGLv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240121

When operating in SPI target mode, the GENI controller relies on an
external GPIO to notify the SPI master about the target's active state.

Add support for an optional device GPIO that is asserted when a target
transfer begins and deasserted when the transfer completes, is aborted,
or hits a timeout. This allows the target to explicitly signal its
availability to the master and ensures the GPIO is released in all error
and completion paths, preventing the master from observing a stale or
incorrect target ready indication.

The ready GPIO is intentionally made optional and is requested only
when target mode is enabled. This preserves existing behaviour for
systems that do not require the signal and avoids regressions on
deployed platforms where the GPIO is already controlled from userspace.
Targets without a ready GPIO continue to operate unchanged by using
devm_gpiod_get_optional().

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v4:
- Used devm_gpiod_get_optional() instead of
  devm_gpiod_get_index_optional(), since a single GPIO is requested.
- Dropped the redundant mas->ready_gpio NULL checks before
  gpiod_set_value(), since it already handles a NULL descriptor.
- Renamed target_gpio to ready_gpio to match the property name.
- Link to v3: https://patch.msgid.link/20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-0-e1c9e0dabbda@oss.qualcomm.com

Changes in v3:
- Rebased on linux-next tip.
- Link to v2: https://patch.msgid.link/20260817-use_gpio_to_notify_master_of_spi_target_activity-v2-0-94d1eff3175f@oss.qualcomm.com

Changes in v2:
- Used ready-gpio instead of target-gpio.
- Updated commit text.
- Link to v1: https://patch.msgid.link/20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com

---
Praveen Talari (2):
      spi: dt-bindings: Document ready-gpios property
      spi: qcom-geni: Use GPIO to notify master of SPI target activity

 .../bindings/spi/qcom,sa8255p-geni-spi.yaml        |  9 ++++++++
 .../bindings/spi/qcom,spi-geni-qcom.yaml           |  9 ++++++++
 drivers/spi/spi-geni-qcom.c                        | 25 ++++++++++++++++++++--
 3 files changed, 41 insertions(+), 2 deletions(-)
---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260729-use_gpio_to_notify_master_of_spi_target_activity-5f62a9e14875

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

