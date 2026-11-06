Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977317;
	b=Yq13/Gy6N8i0ymi/SU79uw3PmU7E7L0ROdYw2t8MsJYHqL7gWwKNmNW35LlsYEsDJywE
	 ymEbaN2OUKeZz9euCfcQtLsUPvZOgv4BjFklsG95Mf9Js3VWgGC+yeg6/FS+btfDxC6Kd
	 xig9w1cb0jMFCnR4omMg6fEm9gTtMpWNXTQFtdXbPJJeAQVLH2jdCCcl9jPn3GBDhK5O2
	 fb20U7VxT5jbTroeCVYRjFz1dOY6rVDNrMU+Pugul3y/OQS+IujDkB9UgQfuZWp6SXuwH
	 BGotiLaxJ+0J/eahRDABMD85GvyLbHrFnP38v5+mbkj6iVOSt6h0UPgrT0sOdjfzMsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977317;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YlRX2h9r/M7y5/J/Ewe1L+KbEKnvM7owZqTGSJa2SZs=;
	b=UGQ0n3ct4CLtxQXw7Da0RA45fc0kUpqIzS1sPtUlExxH8DicQqNGC3B58gDtTquUAkMk
	 j7u2hun9YTwq/Ggm5kPX3kblZ8g7jE5/St9JXdBWD6sNfo25+GWesfB+0yt+Q3fCg4Slh
	 6J+NnCtNfOSqdVg1H6XUXUY8IEdkLHS55V91J3SRvqutdMYPHW0QddVjy58puFj5A/Vdn
	 KYksyhPzfFVxChtS0Jvcx0I34Rve7/3eNvBhTdrpoXgMejnzBzNuC2gcLsiuGAAOiHWPF
	 122YnQQyjhnRQHFOJzRoXWGxV++HK55jDDapx9hNU0N5xms7gZKx+biwnpjzDlKJvwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IpPNuUns;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UH4mubwL;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1AD606A329
	for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2026 15:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF1AD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IpPNuUns;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UH4mubwL
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6ExvCG3324808
	for <linux-spi@vger.kernel.org>; Fri, 6 Nov 2026 15:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YlRX2h9r/M7y5/J/Ewe1L+
	KbEKnvM7owZqTGSJa2SZs=; b=IpPNuUnsui2joIDxMx5HdCY8husIcj08vS9KY6
	ZUibYTbFfnKieTvHPHnTB7xwzC4mTuqLb+f+0Wekxqb0wCw/3r/RtUTlp6pcdxcK
	YRd+ReLYF8CywfaUnPAPe3kmLq3exlrCHcNESxBi8iUiWEYlJON+p0kLclKYF1yC
	heeq1p6JtLqNEPFyCR8MtS/2sHEwQMkMFQWfJGJnLEGaTpWj0CE6G8wQeTwB7F4X
	9mEUMZMcam2j6K7c69+HzuiwIF5u9GclPuAmQGXjh+TwcvIPsZ+OU650J/+3sEzH
	hF5s/DPr8+rR74xspjWIIbEmeI23CEkObHqqJF7WjLFi23aQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9bb26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 15:01:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdae10aebfdso442012a12.1
        for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 07:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793977315; x=1794582115; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YlRX2h9r/M7y5/J/Ewe1L+KbEKnvM7owZqTGSJa2SZs=;
        b=UH4mubwLRNi+uA5+H3EJpU7sNt/MJXsY/PFrgk3BCGI271d3WKB9inw/qyxH8Nw4F6
         56pUKxYvZCM6neE4gsG2RyJTv+Jfb7efv6it/ddFK4I0ebn3pmL3Nmk5zF+QxJfW/LkV
         sE5d/w5FGMIMZmQgob6VGjoo0ekwhgCgamJxG9E/NDAtNKceCdRmPorR9xeeYDc9Dsp7
         rkoCS6ZqbUNKwWqZCOwrcKNnWx0jETy2ur34avWUW30J1geN+BjWtvvWM1roNJrnKpFL
         IU9e/OF6fx+v0/ThbwPA0d/d7RrotIRZ4E+jC6rKm/DTMo4mNxnOL75O/LtYXLqYblv8
         VxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977315; x=1794582115;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YlRX2h9r/M7y5/J/Ewe1L+KbEKnvM7owZqTGSJa2SZs=;
        b=RReUk85oCnxvc3AaZVFl7t4Iw/3mEo7eMBPQJX1EVmF9QF/yAUFYSbpEbmTUnZf6v2
         S9CPYA9vZsR3+tJLL/ekA2zN2sYbPYj12obIRQ96G2l8AyhZy/d4thrrnxjX4by8rjuM
         6cSxloiWmkf4MO5H/BxzlA6kaIJzOpNx93SkzyuXjHMj0MFnEuKQhmez5icG3kkk5LYj
         k7ZddwZP1Nwncxwffw/5JpO1r2X8Aq9UaTGVEofmm6vVQ1KYfxJgXSlvDtME4T3h3yhs
         HbjFcuqronyObuRQQNVn3Za7XK/cebbmuUN3AJL3rP5gK5McRtGMGXVrTSJQ+Smn5YR5
         XDYA==
X-Forwarded-Encrypted: i=1; AL+hErG0iuLKJWRxiNy4YEd0SoIemNmdkFgBXMYzOOmhQO7PmZu7Yx2qzBjXMBB9oi+5bVS9QcA52+Tg9sY=@vger.kernel.org
X-Gm-Message-State: APuU4Z85vBMwvi/2oGuHXu919yjicYnOH6NhxcOYLVFLS8jCVxuGtmCC
	kW2qKSWqXq0XAUQYyIVmMvbMn6wyCe3YH67Dd0gMIBg6zeaf5Ef77m15VRM321DxgPbL+8NQD5H
	aLZ4d+w5f//C5AEsMAoYXgf1iy7ZrWBjC4i1QRUsBnzYJsNOQkpETlAF+CPqEPM1j8ruf31k=
X-Gm-Gg: AYBFou3fhTMVHAzi98Cx5loq6bimyyrlaZ1i8RPCSE63oPovymhfVT8xW0COLkcuGM5
	4pg5D3LTQXGm7vuc9g3Yn8Exz1cDrCum/MffiOjGpdGq0s6SzL7zvTHPtuILIt1QCKfFHlCO6wS
	WNhyDJv/2b2dNHujmp3LG3gFaMeOXsAl1d3a/AkgLGX9v/QUueO/6qQex9p1mT9uH6C8271F8UR
	8yQZTa/tgy1CdKDyC9eEGX9jQ8/ehLqgwdCWMX5nNOuMzLNyWutA+sK5H1C1c4RRXEzakSBt/tb
	ORkSECfe+lKyMxBNr3OCwjdHwVtlnVINSyGH1AiR8rwt35oFk7WqfKKEu5sm/Eqm7MjlTc/baVb
	t5XbXs6bTSWkyKd+mcpmTMOB+TZFm8IidHGywrNcY3bEIn1f2LuG5NjrSdObWG2q6Wd+PkcdzcP
	Kk6vi/ViX6
X-Received: by 2002:a17:90a:da86:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3b0db60977cmr1689166a91.3.1793977315346;
        Fri, 06 Nov 2026 07:01:55 -0800 (PST)
X-Received: by 2002:a17:90a:da86:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3b0db60977cmr1689128a91.3.1793977314752;
        Fri, 06 Nov 2026 07:01:54 -0800 (PST)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc1bc1e6sm100032a91.0.2026.11.06.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:01:54 -0800 (PST)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Subject: [PATCH 0/6] spi: qcom-geni: Add QSPI support over GPI DMA
Date: Fri, 06 Nov 2026 20:31:18 +0530
Message-Id: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/r7WoC/22NQQ6CMBREr0K6tqT9FgRX3sMQUvEjNZZCPxAN4
 e4WiDs3k7xkZt7MCL1BYudoZh4nQ8a1AeQhYlWj2wdycw/MQEAqBUjeU2fKsaPBo7blvuZZIkD
 lqI5QJyxMO4+1eW+312JnGm9PrIb1a200hgbnP5t3kmvvp4D/iklywbNanUBoBXmaXhxR3I/6V
 Tlr4xCsWJblC89vg5fRAAAA
X-Change-ID: 20261021-qspi_upstream_series-850249e432f5
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793977309; l=2393;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=sT9UgwhMsmzsH1VR9CYbGXTbSBlB1pzQsIePFqgsQYI=;
 b=C7A6XrHKQ4XQj59UI1RyunXvtophOtPfyUZ40INZlB0wVQ1WwavhDZi/XQdHdag/KPYoESnrp
 /DA2fyYU2OiCiJkgXkeSKhD9clZFrHFuhY4Ck116NuLNZOju5EM/9dr
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-ORIG-GUID: Zx5WiLPj0W0TR6ZYUa0slhbgcTn_Yw0-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1OSBTYWx0ZWRfX35RHSGSjy7BH
 qiFDfq387EYkVjLnXT5py2qLSuIOusguwAVcZySVEdEEwjpbwP6vIOFBLkVQLLwX1SszkprQa1F
 sjCq0uM2fDzRIxQsgFKMtebxG/pHhrcyQqZV9/a7l5Y63CB8ORC2O7e7Vq82bsq5IXDo7GNOx68
 khUNbqd+aKYxWaF8U/OgcLVaG5bP8Vr4+f/mUXdSuX2d3BoKQtiwuq1Tz/EJdzFotrH3bkbQlDe
 6DoV8YyZZu4N0UgpqigKys4fp2JZZbX9WKIQLmvaJfrKkWhlQ/wNqQR+2IhRqLOpSCT+b4vknV3
 y7LZq2MTp8nAhXFGIclTfAH1oa4PZ9seUlpxdEm/bEaBfGefms0A4FDfeLXrqoHUSYWoIu0bMCx
 zUPjAa1d8aY9fHMCMyLgvCkw6Ivmh1vTJ/7Hl/92UAg+jGz2uEwcQriMAySvN7USUV+2sM7uWlv
 p68w6+qpIqdlkknjCqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1OSBTYWx0ZWRfXxy66Z3ISlqlK
 rNnAEhOgf63qowVf3J1oV6KnyDlTrmUZNJcjIvBIQ8UbwmE8QYT2AL6mdVc8iX8kNCr5lKB92QJ
 BSOdnJ1tCfo4gPTrdmTlV7k65upnK/w=
X-Authority-Analysis: v=2.4 cv=WMzqzXsR c=1 sm=1 tr=0 ts=6aedebe4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Z6aUeMXpdRP9Q2--PI4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Zx5WiLPj0W0TR6ZYUa0slhbgcTn_Yw0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060059

This series adds QSPI support to the Qualcomm GENI SPI driver using
GPI DMA. It supports single, dual and quad SDR transfers in controller
mode.

GENI QSPI reads require a command/address TX phase, an optional dummy
phase and an RX data phase to execute as one hardware command. Add
driver-managed message sequencing to combine these SPI transfers
into a single SPI_TX_RX command.

The series is organized as follows:

1. Add transfer_one_message() support, including completion handling,
   GPIO chip-select sequencing, delays and DMA buffer synchronization.

2. Define QCOM_GPI_QSPI for identifying QSPI channels in GPI DMA
   specifiers.

3. Document the qcom,geni-qspi compatible.

4. Define GENI_SE_QSPI and update the firmware loader to accept the
   QSPI protocol.

5. Add QSPI CONFIG0 and GO TRE formatting to the GPI driver, including
   dummy cycles, transfer mode and the TX-then-RX command.

6. Add QSPI support to the SPI driver, combining read phases and
   accounting for them in message length, DMA synchronization and
   timeout calculations.

SPI and QSPI transfers have been tested using native GENI chip-select.
GPIO chip-select handling has not been tested on hardware.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
Jyothi Kumar Seerapu (6):
      spi: spi-geni-qcom: Add transfer_one_message() support
      dt-bindings: dma: qcom-gpi: Add QSPI protocol identifier
      dt-bindings: spi: qcom,spi-geni-qcom: Document QSPI support
      soc: qcom: geni-se: Define the QSPI firmware protocol
      dmaengine: qcom: gpi: Add QSPI protocol support
      spi: spi-geni-qcom: Add QSPI support over GPI DMA

 .../bindings/spi/qcom,spi-geni-qcom.yaml           |   8 +-
 drivers/dma/qcom/gpi.c                             |  22 +-
 drivers/soc/qcom/qcom-geni-se.c                    |   7 +-
 drivers/spi/spi-geni-qcom.c                        | 455 ++++++++++++++++++---
 include/dt-bindings/dma/qcom-gpi.h                 |   1 +
 include/linux/dma/qcom-gpi-dma.h                   |   6 +
 include/linux/soc/qcom/geni-se.h                   |   1 +
 7 files changed, 446 insertions(+), 54 deletions(-)
---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20261021-qspi_upstream_series-850249e432f5

Best regards,
--  
Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>

