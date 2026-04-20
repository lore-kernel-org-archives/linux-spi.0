Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EEE378823
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665590; cv=none; b=nWvBCuJ31lunuRK77OzDyFXD8SpH8ZBAvDOfuSSh4vdAhdU/O275cI7rVe5qZLT1tDEPRwh/y+5IBu4enRBLbdGMUa/+2IPEV1mgcK8+XFOgBhmpFiW8xcmRE1Gn22ZEIzo1YXf+wQ94Qex+XY6dmmvJSg4Avwo0tx71A/oP5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665590; c=relaxed/simple;
	bh=RM2c4wnHu2llAa0LGukFWmGGdf2Sq6KTH6ykg7vqkuI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KZOwhE1rAWwhfMBgb87glrxGexQ6Amwk0xJKsj+zHRueIKx/1FJOXTjaBgpbryW4cHcp5StMPY+ZRk8Sb2AfmBi3/d96qNHAQw/5BH8j35hoVQACc4aznxDjFgEcVVt2KvygcYVsZgfPXKnzlZfX1TrjuXEEr26RmAnbJLxsJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aLyU1kAn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bnz+CqcV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aLyU1kAn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bnz+CqcV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JKwtuN300691
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Iy+zbMbgWDve7zvxrXJ5iX
	qDOoDx1v+HHEDvyPa5CIY=; b=aLyU1kAncQHx2guNckOV/zjKDEGZi1+AyJpet1
	PflGzm1onD9aWnWbUUEjrYfiizMv80ZKFQbbLMeeQM7etWt0U3GWCsPCXJjkMWmJ
	dzxrlhXWtOLpJOGJuyGGyFLXRFQ2vobvuDe9n8+7Yy3HyHSwN+Bp+L1UZK918Arb
	hGezyC5yNBFCBz+cc/rgsUQuYHcIdVY81j8lqxCb2HKY0Sip0LSPpy3Zd6IDggZM
	4KvI52nICVHUj2Lj4FoGKZUHIWNKUPOzZq6472CbaH0J/0OJtCNLEZfuF2tlQo9U
	uLeasL5E2DcJZ7bGvoxil3eA8pyOfZZd9eAdX3TT2IsYvNAA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm261vauu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:08 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c7976ded5c5so2359267a12.0
        for <linux-spi@vger.kernel.org>; Sun, 19 Apr 2026 23:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776665587; x=1777270387; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iy+zbMbgWDve7zvxrXJ5iXqDOoDx1v+HHEDvyPa5CIY=;
        b=bnz+CqcVjwl3QbZnCNMOklCfcogKNawqIvnZbSk/oqRPNbrXdP945Bj/kGXx4Su+cQ
         88mmRD8MeWf9xmSmTVkUsThwHWwAhFXiFnMsumedSRs0mf9piIIRKBY1IXG10eVgow7U
         sM4dF/kZgk5pbRIodqHejA+YUTDv9Dr4ErBQC/N0QNJgEjC58Jc9jlr+OFB1YqzaQ0L/
         p900Gcm5RM82foGkAxClY/C2n/ZVs1ybOunxYRkjTEWDHlK03rp0wjmQMfUhANuDB1h1
         lZ6WMkYvhKy3/5Lot1T76ZSZXCf5xNFJpgTjJ1fDyZ9YztxFCq+MT8V7wi0czLEMt1sa
         5d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776665587; x=1777270387;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy+zbMbgWDve7zvxrXJ5iXqDOoDx1v+HHEDvyPa5CIY=;
        b=GzoiI9n8wmqT0hBt4XsNmjEBf+l0qT6X9Pk4uiucV9eS/LNYXnCIshNSC6aCnvY9lN
         6Egk+A/uRwk8P1MtVjLiUiUF0oeZ80cEXnQgyvwlN2h4Jho1Gl8fETbmDijy3j05640B
         8sIe5P2DtcMAsi814/12oO1ZTN9ChR+ICNBHIIyC88iArptM7kDScNta8q9oDjuaG5oA
         1jjZo98fWi+2Eu0LExqMkRATRMaBFl/s2PoeUzWz42oe0Q+bv8R6+SyoHiW1Degs81l4
         9aHAGSVbdoHr6L65DPyoVB9EwK08zqzuKKGbkO8Oa3smHhiA7oqBI04PIjoiMk8u3hKP
         9lMg==
X-Forwarded-Encrypted: i=1; AFNElJ9e6uXpCzYjiYRjwhj7PJLjyvhgKdMN3MR10d8PQiVbLJ1SglKb/ch10gHXd4TfObyOHOZzMyw97O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytDi9hsTkQF3Hnnd6e72Rqg3tBF6iVBKxE2TnvniEsrsylcIUF
	eoerNuCSFHgT3OkLlxjPHyWQk+2AzyPFRl/wQuZtdub/MLy1lz3WhSlorJfXErzz+RIi1o0Mr6R
	c5aXt0pkvVZ0bWaF7uO3tF5USxjlTTte2BKoTzzkXfglqnUr9htu+ed6Vz5dQuWM=
X-Gm-Gg: AeBDieu8W9b/AvCM+DMcpd11PYnQoB1LrAObHrD3+mqeKYrPiWxgopl37RrSJl7UI3H
	2uj/ev7Eo+ESyjxgXnV5CNsmmVhW8G2zTpFR5YGMJmF8+IUfLsqfxE6pqRI5onXvEAsKOhI7tnl
	3K4rEuZq/kspMDgsJbD4+zVT7vPVlHWDxCtsRT/nf4mkHdVMQuNnvkWOrK2BuYxGprEWKuXJegf
	4ONF3yljb7lNlfsgy3xaII+vc6tWasDesJQIQVNug9v1ciLzhr8CWwy4n9hlHIHD22P4FzhFBEZ
	HSFw/V03ducwhzPZeqoVQL8mZ576M860IgJ/D9UhZp7K9wuZJPqXDPFIR27B1zf8nuhn7wd006h
	VKgSPKL9tl15QMoCZFumjffIXJXYCklmY4YzMc0vDq/ynLg3+YFZ7Gs3nNSzx8PB+y2Mj
X-Received: by 2002:a05:6a00:17a1:b0:82c:e83d:a9b0 with SMTP id d2e1a72fcca58-82f8c850e93mr12591558b3a.21.1776665587284;
        Sun, 19 Apr 2026 23:13:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a1:b0:82c:e83d:a9b0 with SMTP id d2e1a72fcca58-82f8c850e93mr12591532b3a.21.1776665586745;
        Sun, 19 Apr 2026 23:13:06 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb28sm9018034b3a.13.2026.04.19.23.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 23:13:06 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v3 0/7] Add QSPI support for QCS615 and improve
 interconnect handling
Date: Mon, 20 Apr 2026 11:42:47 +0530
Message-Id: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN/D5WkC/22OQQ6CMBBFr0K6tqQthaSuvIdxAcOgNUKxA42Gc
 HdbXGiim0le8t//szBCb5HYPluYx2DJuiFCscsYXOrhjNy2kZkSqhKF0pxGywfnuTBQtQZFi6J
 kMT167Oxjazqe3kxzc0WYkp4SF0uT889tKsiU+20NkgteYIelAQlSmoMjyu9zfQPX93k8LJUH9
 dG1/NJV1BuAWse/dFN2f/R1XV9lgUYN9gAAAA==
X-Change-ID: 20260324-spi-nor-09c6d9e0de05
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776665581; l=3533;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=RM2c4wnHu2llAa0LGukFWmGGdf2Sq6KTH6ykg7vqkuI=;
 b=vW+pzUitkyOrIgjBmqcKuy6TK8VhOpd1zpsC8Yc0uW0NkS7EuBVm4CJQExsA20QSSYQWJ0YB4
 2liA9z4c34fCU0WrgXMCFvm5FA0/wazNdWrB0h4CU1pLyy7vS2Nv0vn
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA1OCBTYWx0ZWRfXzz0+sWvEFY28
 eVXFsAOwyrkXGo7QzqMyf0rDkfSiDFNvcPFy/CmJdrCLU4g6+7OX4pOlduNsKLQXNjqJjGTzmJq
 5V486ioh2I/33Rv4+5gnQcZ/tE/Ud6Nvwm5ZBJ8a2zaqs3cRisv9ci288AQHqRqKeJdrx4GLZuO
 /7bR8PQ2EszUR1WDCM3R7ct3T+Lxl/izJA+/KIxyjBeVQ/6iAhVQwDbUMNRrzwjckSBfu4wwfHI
 QsD7+RSN+gKygalGJ82LeVjwGNM51b6OvHzGaUfnY3+kGexFv8arHgv4degcuxc/LUkPwkuoR5F
 3a4oLExEfnpuT7gyp+dHq6mNUucCAwaIUVJ7o/YAwCPlM5bTMNVFbm1IuB+6aebAa96AOtfafYd
 GBQTwsn42H4CQkjbDDR6VME/pdlQkKuSMGx+rLaDj0VUC/x3blEXNqKtFJFKnGuof6m1MWAaoCl
 +8yabKjCxwNYZCF4Whg==
X-Authority-Analysis: v=2.4 cv=dcywG3Xe c=1 sm=1 tr=0 ts=69e5c3f4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=i1EFcCpGWxuPUXEeyfQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: sY0w42nK5WPkzmMOh8XFR4GRW_71euYI
X-Proofpoint-GUID: sY0w42nK5WPkzmMOh8XFR4GRW_71euYI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200058

Add QSPI controller support for the QCS615 (Talos) platform and improve
interconnect bandwidth management for QSPI controllers across multiple
Qualcomm SoCs.

The series consists of:

1. Add QCS615 compatible string to device tree bindings.
2. Add qspi-memory interconnect path support to the driver for proper DMA
   bandwidth allocation.
3. Add QSPI support to QCS615 platform including OPP table, pinmux, and
   controller node.
4. Enable QSPI controller and SPI-NOR flash on QCS615-RIDE board.
5. Add QSPI memory interconnect paths to existing SC7180 and Kodiak
   platforms.

The key improvement in this series is adding the qspi-memory interconnect
path. Previously, the QSPI driver only managed the CPU-to-QSPI
configuration path. Add support for the QSPI-to-memory path, which is
essential for proper bandwidth allocation during DMA operations when the
QSPI controller transfers data to/from system memory.

Set the memory path bandwidth equal to the transfer speed, matching the
existing pattern used for the CPU path. Enable and disable both paths
properly during runtime PM transitions to ensure efficient power
management.

Apply this change to existing platforms (SC7180/Kodiak) as well as the
newly added QCS615 platform to ensure consistent interconnect handling
across all QSPI-enabled SoCs.

Testing:
- Verified QSPI functionality on QCS615-RIDE with SPI-NOR flash
- Confirmed proper interconnect bandwidth voting during transfers
- Validated runtime PM transitions with both interconnect paths 

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Changes in v3:
- Added missing interconnect-names constraint for qcom,qcs615-qspi.
- Changed interconnect tags for qspi-memory path to QCOM_ICC_TAG_ALWAYS
- Fixed suspend sequence: now disables clocks before dropping performance
  state to avoid brownout risk
- Link to v2: https://patch.msgid.link/20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com

Changes in v2:
- Moved allOf section to bottom of binding schema
- Added if:then constraint requiring minimum 2 interconnects for qcs615
- Fixed runtime PM error handling with complete goto-based cleanup
- Added proper error paths in suspend/resume functions
- Changed interconnect tags from raw 0 to QCOM_ICC_TAG_ACTIVE_ONLY
- Link to v1: https://patch.msgid.link/20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com

---
Viken Dadhaniya (7):
      dt-bindings: spi: qcom,spi-qcom-qspi: Add qcom,qcs615-qspi compatible
      spi: qcom-qspi: Fix incomplete error handling in runtime PM
      spi: qcom-qspi: Add interconnect support for memory path
      arm64: dts: qcom: talos: Add QSPI support
      arm64: dts: qcom: qcs615-ride: enable QSPI and NOR flash
      arm64: dts: qcom: kodiak: Add QSPI memory interconnect path
      arm64: dts: qcom: sc7180: Add QSPI memory interconnect path

 .../bindings/spi/qcom,spi-qcom-qspi.yaml           | 21 +++++-
 arch/arm64/boot/dts/qcom/kodiak.dtsi               |  9 ++-
 arch/arm64/boot/dts/qcom/qcs615-ride.dts           | 12 ++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  9 ++-
 arch/arm64/boot/dts/qcom/talos.dtsi                | 80 ++++++++++++++++++++++
 drivers/spi/spi-qcom-qspi.c                        | 76 +++++++++++++++++---
 6 files changed, 188 insertions(+), 19 deletions(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260324-spi-nor-09c6d9e0de05

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

