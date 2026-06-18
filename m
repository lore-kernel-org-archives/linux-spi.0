Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DF3876AB
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773618; cv=none; b=er7NNknVjA7m/pd008Aqd6NVAE49kPdjI+TsWBagwMaSyefG7SjvYoFtIQoFOskIjh1JY801vId8t1A6qYCcuLSHj+fSH++eEDIkR02EtvC9j5GAiEiOvtp9vAMPPGY3bpJS52qOo5vS9JWOJzNkI20m3abDxVMIjuOR/nPn7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773618; c=relaxed/simple;
	bh=gMNuC434sw4TKzykgftS1a7OahablvxcxKUTW9ITork=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WuBkLIx5pluCwCLncJ+aSuIg5qCHlNeU+WkWZJRRE5I6DnDCquSFvE9rQuCDnWMCrrj5+hDC26ZHcZk2An1dyvR9GZl4PCr5YrpSceBO8Q5OJC0NCwHfNrH6wpJ433dGFZ3kSI1SoIBHC/5XZk129IBvklA3ywHO3884TlQ8rmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZeCJXr+8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LAXlHDdt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZeCJXr+8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LAXlHDdt"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8FPMV1177669
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ix8aZoWaom9SOXXSlu0otD
	Uo/c54wwMpLYm40+hRjqU=; b=ZeCJXr+8Ja40r5bX9mwi2tAogJhtqDUDziZo87
	4ZkDbXi1VtDQxX4AGc6LpWn85p8pUA81mVnzHrTNawzNmqltO2v8vZvP1BSzyWY4
	bAE19cYqJUV2F/NOPLBIBuKYRgBclOXTFv8q6NuXNCfFywuaON8wjb6LdZNKe27r
	cRaaitASF9NTZ5CtjDzLb1IX5XCj0bTZxnNAWIIlwjcyTzx4SdiboLjNuEHztHwl
	k7f9GwKzz3/I4g4d7VQ9TgcKLLcG3TZYs6omHlCqHqPFjg1DwqJI11RbpwSFrkT6
	jvGZxzOZVxqJhw2YIL7JwKBGClCPIuNl3J8yU6jSwlhd4TeA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12kjqvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:06:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d98b6f019so847456a91.2
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 02:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781773615; x=1782378415; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ix8aZoWaom9SOXXSlu0otDUo/c54wwMpLYm40+hRjqU=;
        b=LAXlHDdtFzY73pco4cr+DSSzwigWstGeFEiJ6kpwQ6ZsPThh4jF9EQs0S4wIORiw/3
         W8/JyZFhhhzRYf9877vwXMvagJM3NOeQnPbvYDlBpVc8lfvWeOQAFEe/Z+YmjHGQwniW
         /wokKqc5qiZvhPghjSbV4tYQfidkCXvMMtXObK8/fG5cSZnhjJ4adupr2ajT49sz0FI/
         ijOdRGNhYrvoEopkrq51icL2rruEeW4C9p+k0Ol3FI/GAO29igvEfCh9Gd+zXzzGCDrs
         4mA4aaP/PbgDmJXvvqS5Nh9zTzGRiDSBjU5+xk61G0y23pj6liN2gvLahsARdFKAfklH
         QuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781773615; x=1782378415;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ix8aZoWaom9SOXXSlu0otDUo/c54wwMpLYm40+hRjqU=;
        b=jgvBwR56xnZemIGaLWS/OWGzGWcUmuyWixM3Oo4ssbUNduU9RgNJ60a/UX93BMqL6W
         KCSwhG39VbaCG5sxg4PDm3cAuoB+tfl9NiLGZZA/r9AvScdEgbLyznkwRX8CiUzDYpbV
         EtTgD7nC2V+kFzH3ckNDhtDoWuin2A9c3k85xebI9IVzuC4fPnQiMMgCZk0vAPhELPbe
         h/XacI+5qB0Rxd0mmsLMPKQDUQ9NPgMYDeFTfyr5Rly1ODOrIKmfWuuWV6Z9eIfoPCfz
         42fyNk58MUNsMvPO1dZBY/IXpFmPo6bEIxdFM/dVqyC55NXJPiT325SQ3Mc2wywhF89b
         T21g==
X-Forwarded-Encrypted: i=1; AFNElJ89+kfDAv8646o5SK+hSyJtNPj5hL/5f6KL87p9ksehxU+KE1/D7Kwe+id3e0cnVLaXzKymU1PVjFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxQzRjdpkViEyy8XKrTbnx+yxbd9Fsxdxq6SjNVKRsmITcRMo
	5czh21dBvpXb6o9Q6WRgXX4Ye70xmPBbOPIyBmzzo+CQSt381v5N/M00jS0TI+EkSQ7zs0Fj8x0
	Co436Bh164Unpf67SGeP1ZXQMUlijLfqVAilU58OSHD4cUNgD8xFer1SlRGNmWv0=
X-Gm-Gg: AfdE7cnFH7yvO+NfNCmEHXZpEL24B02EZvBkgCxhXp63bL1b+bsUSOAjkPo7jk8q8BH
	Uz/EAG+Yg2ovJ2kD13Cbt6VyI2jZ0WbpdS3uuO3kjMPPdktUpnSKJ6A+cqXgT65xtcchsjMOSgr
	O2gMTofZOcvS6eFHu8xyXFQ2VYARHC6k6WO+kKYSUQhQyvSj9qYIXnCKCjE/FI/5exjbalWQxaa
	+Ps/DtB/jQyT7o6p80UjKWbd6pz3+B4FF7dvBvKUJW+EmQdL/L1iHQs1ZivRi8+lpJg7alxkadD
	Pt0UF8I4myBNCmpRA1vhV5MKxoe/o/fZjnGSjf+Sd+FxnrRLskBCQgOV5bJslqfDIYc5t0u2oO2
	WjfiPau//5qlPiY5V9aeLPVrJDOb9dAVBOPgNz55Ew9io
X-Received: by 2002:a17:90b:4fd0:b0:369:c5f4:9681 with SMTP id 98e67ed59e1d1-37ce86f50a9mr2018929a91.22.1781773614883;
        Thu, 18 Jun 2026 02:06:54 -0700 (PDT)
X-Received: by 2002:a17:90b:4fd0:b0:369:c5f4:9681 with SMTP id 98e67ed59e1d1-37ce86f50a9mr2018883a91.22.1781773614344;
        Thu, 18 Jun 2026 02:06:54 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac794sm192112835ad.46.2026.06.18.02.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 02:06:54 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v4 0/4] Enable SPI on SA8255p Qualcomm platforms
Date: Thu, 18 Jun 2026 14:36:38 +0530
Message-Id: <20260618-enable-spi-on-sa8255p-v4-0-f5b5067e7e1e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB61M2oC/3WPy4rDMAxFf6V4PQq2EruP1fzH0IWSqo2HxM5YS
 ZhS8u91OgNdlG4EB6Rzr25KOHkWddjcVOLZi48hQ/WxUU1L4cLgT5kVanTa4h44UN0xyOAhBhD
 aobUD7IxzTITomlrl2yHx2f8+vF/HP5ap/uZmXGXrxjnFHsY2MT39xqDZa1NWhbHoXOXAwJBoZ
 g7FSB0l/xlFip+Juib2fZHHqmq9jDFdHz/MuEb+1y31m7ozggaztdsqh9YnV756j8uy3AEgzhz
 WHgEAAA==
X-Change-ID: 20260529-enable-spi-on-sa8255p-8166eaa226cb
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com, Nikunj Kela <quic_nkela@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781773609; l=3945;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=gMNuC434sw4TKzykgftS1a7OahablvxcxKUTW9ITork=;
 b=zkFAEEa1kiZ7dHdF13gsj3SSU54BVQqkjsCJblAgD6EwJi3DHOszxlc3JP/ypJZnlNKgzWkdI
 UPfBbG/zW/SAOvezYNHaI6qVxS9XTaip9jqEnolkwFE0tcmcrlDxCod
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4MyBTYWx0ZWRfXwNugC/n6l5BR
 IkLCUtGKYrvGeaNMC1MF7upchdaThILFTfgoZolvdA3ee+EY+RnpomRXLVrviBergXhhuK9b3OO
 WCASOg6+aSfgWMwcMdl00ropFvK2oL5kttnROcyy7zzvFuwbVqr+7iVuH0gnyWqEmG/KLFOr0NK
 gBRjkK0EkCSbvycNm3Sw9a9JxVy8AXxFvsYcM9pcc5p4rp4bhAWstC1Qc5kuY+2TQ9BA1TfcWMs
 mssdWlJPxim7Yy429kMNBFselUJyjx0TaVCyg29dHrVefoJEZitZSVMeV1AnyHB25H2R9aEzYDT
 UY7Q1R//9YWcl6T7bjV7Uv0yXPPpRPkc2nn44BxeJrSmf/+hRqX3FxBBgtlU2WeYiCj/VOS1jgu
 9ndhjBXlxvRxtlrr6+VwaBuiej99Y84M/MER+wH2ovXOZqj1EAcfvQ8p9xRuUt0P5ZgjrI/wI+I
 /7qambLCGfp+CVUaA2g==
X-Proofpoint-GUID: X4tms-RZu8_NP8TFCAQX5IgtsZA8td92
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a33b52f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=WbIzMIUDzaoW2bUmmBIA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: X4tms-RZu8_NP8TFCAQX5IgtsZA8td92
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4MyBTYWx0ZWRfX3ajQomCPMQiy
 QGxIkL+2ffoK/s1wPNtNf7vLQcCLRCCcDaxESGe9pVnNgg0uuec5AvObRMYc0ieOot5w0BSGsNI
 L/4WvBJKBhxyVeUXwSwCeRIzyMeUdbw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180083

The Qualcomm automotive SA8255p SoC relies on firmware to configure
platform resources, including clocks, interconnects and TLMM.
The driver requests resources operations over SCMI using power
and performance protocols.

The SCMI power protocol enables or disables resources like clocks,
interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
such as resume/suspend, to control power states(on/off).

The SCMI performance protocol manages SPI frequency, with each
frequency rate represented by a performance level. The driver uses
geni_se_set_perf_opp() API to request the desired frequency rate.

As part of geni_se_set_perf_opp(), the OPP for the requested frequency
is obtained using dev_pm_opp_find_freq_floor() and the performance
level is set using dev_pm_opp_set_opp().

Praveen Talari (4):
  spi: dt-bindings: describe SA8255p
  spi: qcom-geni: Use geni_se_resources_init() for resource
    initialization
  spi: qcom-geni: Use resources helper APIs in runtime PM functions
  spi: qcom-geni: Enable SPI on SA8255p Qualcomm platforms

.../bindings/spi/qcom,sa8255p-geni-spi.yaml   | 63 ++++++++++++++
 drivers/spi/spi-geni-qcom.c                   | 83 ++++++++-----------
 2 files changed, 97 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml

---
Changes in v4:
- Added Reviewed-by tags.
- Added return check for dev_data variable.
- Link to v3: https://lore.kernel.org/all/20260604-enable-spi-on-sa8255p-v3-0-43984eac4c67@oss.qualcomm.com

Changes in v3:
- Added the OPP rate restoration in resume callback.
- Added missed dma-names in example node.
- Link to v2: https://patch.msgid.link/20260530-enable-spi-on-sa8255p-v2-0-17574601bd63@oss.qualcomm.com

Changes in v2:
- Rebased patches on latest linux-next.
- Link to v1: https://lore.kernel.org/all/20260112190134.1526646-1-praveen.talari@oss.qualcomm.com/

To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: bjorn.andersson@oss.qualcomm.com
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com
Cc: aniket.randive@oss.qualcomm.com
Cc: chandana.chiluveru@oss.qualcomm.com
Cc: jyothi.seerapu@oss.qualcomm.com
Cc: chiluka.harish@oss.qualcomm.com

---
Praveen Talari (4):
      spi: dt-bindings: describe SA8255p
      spi: qcom-geni: Use geni_se_resources_init() for resource initialization
      spi: qcom-geni: Use resources helper APIs in runtime PM functions
      spi: qcom-geni: Enable SPI on SA8255p Qualcomm platforms

 .../bindings/spi/qcom,sa8255p-geni-spi.yaml        | 64 ++++++++++++++++
 drivers/spi/spi-geni-qcom.c                        | 86 ++++++++++------------
 2 files changed, 104 insertions(+), 46 deletions(-)
---
base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
change-id: 20260529-enable-spi-on-sa8255p-8166eaa226cb

Best regards,
--
Praveen Talari <praveen.talari@oss.qualcomm.com>

---
Praveen Talari (4):
      spi: dt-bindings: describe SA8255p
      spi: qcom-geni: Use geni_se_resources_init() for resource initialization
      spi: qcom-geni: Use resources helper APIs in runtime PM functions
      spi: qcom-geni: Enable SPI on SA8255p Qualcomm platforms

 .../bindings/spi/qcom,sa8255p-geni-spi.yaml        | 64 ++++++++++++++++
 drivers/spi/spi-geni-qcom.c                        | 88 +++++++++++-----------
 2 files changed, 106 insertions(+), 46 deletions(-)
---
base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
change-id: 20260529-enable-spi-on-sa8255p-8166eaa226cb

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

