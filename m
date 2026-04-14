Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9592E541F
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186519; cv=none; b=RmM3UEHGy/+1MyQLHtF8J89XuOZ/59mDe1b3C4NVngS+8pvSsWXpNrBS1UUdAZWl0J2HMpRObARiQ1ap6kx++t+IXAulE1iWF+f0EwmlFtgzdXiX4AJ98uZf94KsdrDVj6YM3GgHdcq8mYr+Nul7vZWn/L4zj2K8bW8LTy2Bjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186519; c=relaxed/simple;
	bh=HftimpV8MSkXZw1i0z7r0ar6Azye4jTekmqYKLHE7XQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iAHe+njXprvvhf9woAaeBSIcnwV3b0ItlMBJ/52q2FVOmb/2vFIE0aim46DePzpAQ+XQn4fdPS14/QtUKzNR1DojkyJunJd4WlRaWH6Q7KU4t8eywXCa1RRgZV036UZwOtJ8cH7QkPaBW61CU6hhTH/LbjuR6iqrZNN1Bi1CItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DMLH64p5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SXUpV2zC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMLH64p5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SXUpV2zC"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EG9JiG731034
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OKtABV8zSeNV8l0VrQP3Vp
	vYQwHyasK44FDm5fHDl78=; b=DMLH64p5ty49AWbM5ZJct4/2+14vR0iCSZCmhP
	2984iuLvBai7ZayAGRCI0e7LdGzO9npyHciZb5FaceMlS0oDRI4t6SRRmP+URunW
	SWPR/bMfGvRXMmOvB1ubSD/puZOzytdScBVuZWZk3i/ND/an8fr14F/m8C5Jcggb
	fRhddbsRheNWmegJgiSfrgNWGBWbSx8Nf7JHgZ1vb2BPTv2sJgWlEhP/P21O5wrD
	zYMKiJkDG4K6OwLVMShMXZbSGqHUHVRelB1kKrN4tLP6gQCCUTKgosRflCtNr/HB
	9+GEOFHpF4l9KiNAwnSYiWwsazlBU/2Ii9JG2y5/VCp6hvXw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhruu8862-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:08:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b258636d16so56751535ad.2
        for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 10:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776186516; x=1776791316; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OKtABV8zSeNV8l0VrQP3VpvYQwHyasK44FDm5fHDl78=;
        b=SXUpV2zC8qNoKufHVM0Shp4Wv7FinRHOxyjscaGr1MCnbFNaN9LdEPupValtKZbt+a
         OdxjbllMR5MGKgScGPQZ6yt4vZLlrsEy/OYclDrhgMHVUtmJFOLoYczNyPCK+YKKx1mv
         sBmw8w8ZFZO2rm18QHORZ0aohmydIiORsOfua3EnHNvW0Ikf191LK9+VUcjXvxVEbZSD
         RQVJ8NFTH1pxlzYnY6X8yDkQgTBpNHxLWZHnHT1EF3qHQXcMnwejJAOlwsUcn1G8bFKb
         Hm1sUuNp93KV2pTSehc3sWClp03lQR64XBJ87Piqr8eEKghZXDLEN9OCBd/6cRm23Fub
         KkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186516; x=1776791316;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKtABV8zSeNV8l0VrQP3VpvYQwHyasK44FDm5fHDl78=;
        b=XxKDHccyglAmphz6VCxqo3b8C5ZY9vV/wInwWD66uGZhridGNc/BI2ThlRFjEv6T5T
         ncbYvNZwpvnDCFBY5f4M81105T432tQYheiW0LNKRt5kXTD6LLvllnRnAMsXUCRPcPGV
         BkcokBQROvZfL9CGcS56gyzmgBVWuszI6MnwjHHR7rTFm++2gNulb9XeNsvpZI9zo4mI
         45cd/arGJfXhJSTNhskzsZZhbHhaq80zLzaT1O7X6LSEVGntQWLi5W7zHHEJXlgtUi47
         9Owt0DthOzKZGSOo9YHGKVtFc/xTunTjtUyFYEQAPAo+TRk5HJ3M2SjyNxhsUZIZYh1z
         d0/g==
X-Forwarded-Encrypted: i=1; AFNElJ/8KOJfs+Jg8qWxWQVh0oaflwFePqU6cRNWmSMXtVbbM6Dk+7m/sc7eu1RKt7etBscrNqI7gS72bV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn/tbUsDULZWOESHA86+CqRPESR5XVBMGKGfcAo/cpoeuU9JWG
	hyYsDHSL967YE76bcYSrBgXG1CarRQcq88d6ips5EDJnKWHVNcQxLCuqYV/BVUGlDAEU1hdHK7+
	eQ/dayK8g0YO9Gj6/e+04y+CPB6ujsgq639NjG+wr3FPKWgSMHtWluM9gT2LNHvc=
X-Gm-Gg: AeBDieuH1OJUDWq88mOFcS/FsSJxj/aNhLfDwr6R8n6mWfvCtIZTBt0mRowylhiFPun
	bax5rcalNkvSm3VbywKPYjubd+JmkTj6S2zV6Cq3kX7A7zWhp0s7mjmhNL6L7aDAv2GV/C78SZA
	ZFE8VqbhB1pbYQlKECln3oL+qYIiECpHYABc0+CqcrmbAs409L3KjtS8BvfTyclQcy8HfhpDTdB
	IUjRVJQL+lBDQPTRDqfPBCNysQpDnMRjRdHKQk0fqNl2QKxoEA4r88MYfKFCGChgMbWEjRR/zbs
	7z+bTl4WEYVV3xJoQcRdWBInT8aPaVgxzu9KmvJYIExcuOOjSvlKP2Euz/U76iGqqAzjQTqzeYm
	tG1zED2EgQ68agVqG8wzWINjHno0dSsVDitoUQN9vv7QWyOY2CS+a+XDVPJ8d4SdBFhYJ
X-Received: by 2002:a17:903:3c65:b0:2b4:586d:2e5c with SMTP id d9443c01a7336-2b4586d3429mr102100195ad.2.1776186516337;
        Tue, 14 Apr 2026 10:08:36 -0700 (PDT)
X-Received: by 2002:a17:903:3c65:b0:2b4:586d:2e5c with SMTP id d9443c01a7336-2b4586d3429mr102099665ad.2.1776186515563;
        Tue, 14 Apr 2026 10:08:35 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45d1ab540sm97535225ad.40.2026.04.14.10.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:08:34 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v2 0/7] Add QSPI support for QCS615 and improve
 interconnect handling
Date: Tue, 14 Apr 2026 22:38:18 +0530
Message-Id: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJ03mkC/2WNwQ6CMBBEf4Xs2ZK2CEk9+R+GA7aLrBEKXSAaw
 r/b4tHLJC95M7MBYyBkuGQbBFyJyQ8R9CkD2zXDAwW5yKClrmShz4JHEoMPQhpbOYPSoSwh2mP
 Alt7H0q3+MS/3J9o51ZPREc8+fI6rVSXvf3VVQooCWyyNVVYpc/XM+bQ0L+v7Po8B9b7vX4Ru3
 yS3AAAA
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776186510; l=3173;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=HftimpV8MSkXZw1i0z7r0ar6Azye4jTekmqYKLHE7XQ=;
 b=H0QMCEeH8WRkVBHkdtYsNm+fr5B4HUQpop+yoxhuQh8BG34ajKkkup8LvHDJaINwlPAp/V7VN
 UGhjan92SfdA0K0U0vix4wwVy+JW5b8EmIM32CiJ9JsBWcxowTNesoe
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: OJKULVjQbHqFmjIThN-eb4hz_q5uedpU
X-Authority-Analysis: v=2.4 cv=dpfrzVg4 c=1 sm=1 tr=0 ts=69de7495 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=i1EFcCpGWxuPUXEeyfQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2MCBTYWx0ZWRfX8khHJLliJ17q
 4Jbiof3E8EwMCv1m+mxrATe89tagejZh/iv3LsD/7Dz9eeFwb1iCHFvMmjy2r7TWQDsCS6S9VdI
 yPR/HPYEeK2MYyvV1m1uvRzyncXPJXnk6ALrYk/XIUYpVFVsJg6YBWltZGvw74kV8CrugaYrF5g
 G3Z/Wt6x/XQMUdmDFwn4ZjF7i7kZ+3tkj84p2laWm33D6TbYfeZWsk+5GscIhfTRtOhWwqdiiw4
 BHBzK8edfwNcwqjVy5TWk2jqHYIzfZeSI3dghNdOWkBMX3lf7i63foo693cu1vcHTGybJvkMFMP
 umZS/qUnMW6HDoPHPau03KqALBVY5X6HjegQt+Lsgj0UR9ujyW12MkfB798hbvUY06NsA4jQVvw
 1qsY5uWU8E6m1JK3u0oGwfPtag7PXWVF3tQQwGumANkwZZ5hPs1Aa1F9JesJ1Psbw1xAc6ToFLu
 7oilK32VRuYDE0oTNRg==
X-Proofpoint-GUID: OJKULVjQbHqFmjIThN-eb4hz_q5uedpU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140160

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

 .../bindings/spi/qcom,spi-qcom-qspi.yaml           | 19 ++++-
 arch/arm64/boot/dts/qcom/kodiak.dtsi               |  9 ++-
 arch/arm64/boot/dts/qcom/qcs615-ride.dts           | 12 ++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  9 ++-
 arch/arm64/boot/dts/qcom/talos.dtsi                | 80 ++++++++++++++++++++++
 drivers/spi/spi-qcom-qspi.c                        | 73 +++++++++++++++++---
 6 files changed, 184 insertions(+), 18 deletions(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260324-spi-nor-09c6d9e0de05

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

