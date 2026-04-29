Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4AD38838A
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436579; cv=none; b=QYyoUQmATuuA4tujaQXQWpnlicA0c8DeNXNnsYpFrjFUfLF0ATSjMCOA+xg98BoQZo7XgjVg7MJQgrdbfJWIUNaxCzOfTmp8CHfUIjMiUAY5tDg0HH9wlhUQ5eGdwxpx6kWctj4MM+gIr9fiE1G1Eiqy/27rbwh1sImtUCCPlvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436579; c=relaxed/simple;
	bh=bGx22Kz0pmg3WWMp05JzY1h9KOF59s6YMghleFOgd10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e8dDXa6iS4oCqO/QB1RBudu6WB0b0yV01JWAHc9NlbuIFp+RS/FVkm6zRPjI2Lscof5WG/yAY6nGpb9vheau2dHVeBzKKAYU2Pt7zCdgbD00rWgPiqLO8XQQh5DCM1xqnNccuhD0LPrcRibunfr72gxBS0zixNkgdtsJKrHOg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bwZAMnSf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hrppug2F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bwZAMnSf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hrppug2F"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T0mVAx2890701
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GPeKcVlNgiAhf/GKZ9rf2r
	J6AvxknNeON9pdTo43Opg=; b=bwZAMnSfapgFO3uQc4EHnUR6Cwd7baY8jgC2HG
	TyVZcYQfj0nEXsiUt8iKU6NMUC6e+s/gPL7nxesml8q5TibZVq/88FMPKbu24TSj
	Qhoh/1Hzu1JD5xrr/sVAc5DhlgqDSHUG37trmMNhDpIKuu9NzOT6xi73I+B+gvmO
	2mW1t2JB4wBm6trAKI3RA4hZ+yXmMbkIau+qyBpPoja2xv7EO4CVcyQ3cxB28EIM
	TrF7A3AE77VIgh8rW5GDeKERaeST4+GnRz8285sBLK5xkGGVZvG+1qKXuHQgM9Tz
	exJ7s10dE9DuisqGNVfWsljNUUDbT2LRb2DNVm+0YFtNIlIQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttgyusgc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:22:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so287600b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 21:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777436575; x=1778041375; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPeKcVlNgiAhf/GKZ9rf2rJ6AvxknNeON9pdTo43Opg=;
        b=Hrppug2FijAf9SjZhUEqRBGxRERJ2TcjfBVOmQydSo5O/Vjf08JjdyfdBgh1dB6j7Y
         PVA+MI/7bQogUfbQOOc7dzeZ4hePUYa/kR58NPxB/9WoN8LIIdQmmzERK6OO7Od9YNRQ
         kGXk6gHLwuVeoZpp+ICJJf3/1M/MU6pWG6dFIpieSY5WgKl/Fj7Tk7O5lMxPP0EyMYAW
         RmTnB3ab9MyqCexDWbI1MBCDcBdNngYbMtNQomR6X96BCF0oCkIPxx9AMHyShvcXRvUL
         pBnH/qz+s5b0fBAteiK1zfbuJCnCo7KuOaMLEttxwXN5/9Wtpqp6ZnXhx5LXvuXaOx3y
         uCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777436575; x=1778041375;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPeKcVlNgiAhf/GKZ9rf2rJ6AvxknNeON9pdTo43Opg=;
        b=ULjmHGeTIHxCiBZ1SjInBy8iu1T1M2912qSFX/3UK7zAXzwDmWzbpF2gN9X6Yt6BIq
         Bu3bouQUpK4/CSQ1u44awgu9zqFZ/5pATN26+lWA6qLzSVjDZ+adJk2d9C6KS97Zsdlc
         GFYmQN9FbGHMAl5MgKILwUKdoDi8ldJyEj6M0eENJ45D99g1bwAMY2hvqKBGtPd1id4M
         Hk3W6ym/i3CMVB0pRDjO7i9yys82VXn+oHLi8KtNCWzW/2JFDISQbmVXDCSTnevf7HEe
         DQcHwm3UX0HEspQy1JljKhGkQ5XwYInauPgQFfXTh96ju6x7M5lY9JGSCGRHT1lSukEZ
         6TsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+29Kdl/TKb9r2IloveGgPceiPY78gLqGT01szNnjffPcs9Nmf8r/0cX1wSEE82kaDer6ggPF3kpZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDRgs/Sn6Bd/TfyeBgK7POwNuIGGMX3iPn19RjDkbmwRlY4vx
	HSXeBacG2ghYjiyjRYsxhEne+iHXIQdyPwOlp798/rmF6Gt//BRmJULAmo7OJKzOkrUQRM+S1an
	7EfrEc9N8REHMK/jgif4XtJhzErr5LAVLWRXEYRfXOjxbbuiKI3DngpEQZsKZP18=
X-Gm-Gg: AeBDieuSYkRM/ulHClv8pBX+siyakZvasO/WFs5Oz72cs6cdaYrlz9WooMwl2us2ATt
	Y2iWLg3GtGsvMgnfUlVevxx8oMiIdfYEp71+0FKn8lt8MW/kKO2bnFunf6PrtVAaPWZVIRmZKX4
	gX3M/IC+sDIjmgZSOWB/cMqV9FyeIeQcWNdbHi11BoRWHO4hegASKPgWeoKyGQnS7hVum0n8c0r
	qtTKBIActc+Z/KPr09uxF0KOLKgLWiRIeapPlaJP/fZ8HLPo7gi+yRQvqcWimRskOygo3NkUJb+
	MWvjw1Iv7rkr3xD/NHdfMV0ixtPDkxTfLkLwu5dys4+5OaUG8Rv02oAC38/UeG0lDzZO3vDq0bn
	us/1JhnpNQsdTBNUm9vyfrxl49OKMcAivnjCcdkWMRKI6iUU0WIUbn/ZOBMcJAv26prsz
X-Received: by 2002:a05:6a00:399f:b0:827:2792:e401 with SMTP id d2e1a72fcca58-834eb487cb2mr1620410b3a.15.1777436575009;
        Tue, 28 Apr 2026 21:22:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:399f:b0:827:2792:e401 with SMTP id d2e1a72fcca58-834eb487cb2mr1620369b3a.15.1777436574528;
        Tue, 28 Apr 2026 21:22:54 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5a074dsm602200b3a.10.2026.04.28.21.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 21:22:54 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v4 0/7] Add QSPI support for QCS615 and improve
 interconnect handling
Date: Wed, 29 Apr 2026 09:52:39 +0530
Message-Id: <20260429-spi-nor-v4-0-73fb1bab03ba@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+H8WkC/3XOTQ6CMBAF4KuQri2Z/oCpK+9hXEAZpEYptkA0h
 Lvb4gISddPkJe9704l4dAY9OSQTcTgab2wbgtwlRDdFe0FqqpAJB56D4JL6ztDWOgpK55VCqBA
 yEtqdw9o8l6XT+ZP9UF5R95HHRmN8b91rOTWy2PteHRkFKrDGTGmmGVNH6336GIqbtvd7Gh4Sx
 0e+csk2nAdeal3I8C9ZZvUfLjacw8pF4PsKBc8KroDBDz7P8xvnckvlNQEAAA==
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777436569; l=3968;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=bGx22Kz0pmg3WWMp05JzY1h9KOF59s6YMghleFOgd10=;
 b=j+zyqfIGiOJWg/LEmcDDpJlAKH/LPSqmOAUF1iysn6lov4WgBjJ3oQKmRZeueascrw+9hcWRd
 YrxkD6YEMT9AufVP8AnH9AAWkKkcxTpG78NsLnr+wQCpApm5hT6EuG0
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: yUYIQNb1K6kwqRWkoYrKadnOB6qPsrwd
X-Proofpoint-GUID: yUYIQNb1K6kwqRWkoYrKadnOB6qPsrwd
X-Authority-Analysis: v=2.4 cv=cb7iaHDM c=1 sm=1 tr=0 ts=69f1879f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=IkmApkmYawgI8k_-_nIA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAzOCBTYWx0ZWRfX5d2nJebxOovE
 bw1DnjbKSMPvoLgla3fcotJsM24ui842DOjXMh0/XZO+NLvqAVRN1dGxD2CWz00rXn1zEGxfDtI
 EVMM6e2heGpmHwkygNnRfSqZf/UDQTjHdaCNa1hyMAENQ9fZ/+PJ7u8kK3gJKgWTj4DdWjwi8FC
 RV12sb6jP1gYnQKyjaCZq8ilKr45vdzGkDJoc4Gdg5+Tu6QUAM5veAdAiDfvtQizlCHEPqzZuHH
 XJE+eT2Ie2/fwE73Eoekz3iaQnI/muvuzQYYo24tyA0SwhRW6KSCCkY4xUxSAutGRfEMcLg+1dQ
 DWKhuwdOtJnw9n1+Bgyb5owtbnqAcZQOHIfSIet7Ugd9m6PKVW67vmk2EAdZiRfBeg8ewB5pzDs
 sBeqvJnSY7ap8WCnlVF6wsQIf3A7fjbHy8weB0RSmdR1F0nWakBHgzm3p7mVsrf56k5lkLQmG0K
 NZq6sOtL0quqtqPfa9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290038

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
Changes in v4:
- Made qspi-memory node handling optional to gracefully fall back to legacy
  single-region behavior when the node is absent in older Device trees.
- Checked return value of clk_bulk_prepare_enable() and logged error on
  failure in resume error path.
- Fixed subject line style to match subsystem conventions
- Link to v3: https://patch.msgid.link/20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com

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
      spi: dt-bindings: qcom,spi-qcom-qspi: Add qcom,qcs615-qspi compatible
      spi: spi-qcom-qspi: Fix incomplete error handling in runtime PM
      spi: spi-qcom-qspi: Add interconnect support for memory path
      arm64: dts: qcom: talos: Add QSPI support
      arm64: dts: qcom: qcs615-ride: Enable QSPI and NOR flash
      arm64: dts: qcom: kodiak: Add QSPI memory interconnect path
      arm64: dts: qcom: sc7180: Add QSPI memory interconnect path

 .../bindings/spi/qcom,spi-qcom-qspi.yaml           | 21 +++++-
 arch/arm64/boot/dts/qcom/kodiak.dtsi               |  9 ++-
 arch/arm64/boot/dts/qcom/qcs615-ride.dts           | 12 ++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  9 ++-
 arch/arm64/boot/dts/qcom/talos.dtsi                | 80 ++++++++++++++++++++++
 drivers/spi/spi-qcom-qspi.c                        | 80 +++++++++++++++++++---
 6 files changed, 192 insertions(+), 19 deletions(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260324-spi-nor-09c6d9e0de05

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

