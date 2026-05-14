Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC83A8755
	for <linux-spi@vger.kernel.org>; Thu, 14 May 2026 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741152; cv=none; b=GPoJ6LVEvmDJa/wrK/cd8x/srclEsA3sIcvYYPSujdO7c+agO+VagUshbjkLIf9qy0lYSNeb0/fnvZUeWcIH5+6n4IzxNgEDxvb84osIfFgR4rtMxBvPe8BFBBUYWJMHYqr9/Zoit93XR8nkFThIkayO1zBtV/xON83T/+Wjnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741152; c=relaxed/simple;
	bh=jBEDtYGEa2IKZ3W+O1lVxJfYt+vX1gTebqiOx8/EH/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M97i76Xc8arQJA+nFQDQxAtofSQbNLdQlX60D5pR5HZUyANhIX9En2mVvSUniPKO2xtka6LVXVuxoGZfA3b5PEFiN5NCQhJY5eh+araGl7+il4yQl9D53jc5BvQVuKw+S10lLXtekPvcrnVcVv8j4SjT9mQTF+UthRkmPHq+vnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N+2AjhuZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TIK7eQEZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N+2AjhuZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TIK7eQEZ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E3DERI1936360
	for <linux-spi@vger.kernel.org>; Thu, 14 May 2026 06:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=B92BQ+6HWYcw7rNENNk7fQ
	8re3zw84yQz2S+EvoqcHI=; b=N+2AjhuZzFkbY1pZJAusdpkX/M6Pqr+VGFgocc
	m9z2pVKVPbqRwecce8bC/eXplscD+1+S7DYaGtOwWrlE6UlMHjC8tplTCNC8DsVi
	oCU1Dd8/ebohi5YwNwc3dgDbPM4FJtzbhi69LuTpYEillvi+vN2ALQWB/rN7v0XS
	jPP0RcbujzPVN+1pmJnKuWqiLokCkgvlPLxfjXvnb+XTTxJRzAjXc1a28lKO9NvO
	Vtz4Gwky0+J1rhIErSpyESrayBvHQCYI99TtGS8zSHTt8j8TH8i5Z+tJjr91a++h
	tCMVSpwxHtmQGltSl7tj+4fSPggCXCDwEjHaTUag3XwMdfvw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e554a8tge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 14 May 2026 06:45:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2babc42244aso142619355ad.3
        for <linux-spi@vger.kernel.org>; Wed, 13 May 2026 23:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778741148; x=1779345948; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B92BQ+6HWYcw7rNENNk7fQ8re3zw84yQz2S+EvoqcHI=;
        b=TIK7eQEZkVwbe1idzL8FRqWW5bw18sVAzZkoHRA418wEusWiY79Zpb27m3mo61MEwj
         bxUPNqiGZnY95nfr+LpkGDPHUixEMu5veUHSuKFzlv1Rm85ZWwVzqdnDA8wAPASUnVsb
         hDHzTLU/uTSW7CW/CQQI8nguhkDTUVNbu8w/U6MgqmSGP9+UqG4apdZso8bs0b0WNBKH
         QxAxp5IaPmldikLN9kcblu9h9xcORA6j5w72o7yrT0Rj2K40Y6LmoI37MGpD+YUUD3Qm
         WDlNmR0RuROjrl7R1VTvrpeoqrLOezOQFVjDqt9QU6hVkOoqcs0LdX0JnTyjBkKojnYv
         kczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778741148; x=1779345948;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B92BQ+6HWYcw7rNENNk7fQ8re3zw84yQz2S+EvoqcHI=;
        b=d0a6tYAIrSGDhMBYBd9t3qduyot0PHmfx7WU5o2E1fSeOUGFk0+cOzDtGLC28XgGwi
         VaBbOWo0o6NIRnRVR5SmQSt008RA/Mv5TijomL1Yntje1Uh7FJNqbHP+yO4IyMi/IWNO
         yTbyI8c2mhDNBgBlL0RQ5sK9vJNTngg4lczqNnRo0QqNGaMupdf6/fG0fntoh29E765V
         uhkFtzB7oxzIS0ctX6D9dfw2GflrYGoGZo4W1X/RHeLhon3F25kZZ91PDqSZ64GmN91/
         W7h52USbu1TyVhtiuJry2uYaXzglDE5AERF8H6oYPYDO87HWpTROuJQhbF5LNBBElYNo
         oAVg==
X-Forwarded-Encrypted: i=1; AFNElJ8LfTK1eOn5biC8iLhTdUBgi0TYSQno08TaFOtssvzmsQf4y5u67Nsxqyc4Me/Bf0D6loDhdpiJxJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDkZL9l7E0smLCxYqH4iK/Ohkrq0wxtNIrXCeNtYLJX4ytJELc
	DcC/d7GKA8FwgPjL70muCoos4aGLr1RxP6LW+4RAYtpJRbXh+Pc96c5lD9CqwM0WR8vXj+khbMi
	uYUlWNRnMQHhaJOnmPjxRNM+zu8EgUccpubRiBNkS2DSj51+zBTvq2PEFES+T8Gk=
X-Gm-Gg: Acq92OE4VtZRRc/zcJY/SRU33z6d+kqZyOv98satdxtn2AAZ1mHqzfsaJSFYeTk870p
	LQfqKPyI63EM+1PQWL0TKM2X551XvC7fi7EZQdKDcMqhmHSDn3vPADx7jfIyRrEyrYTSpzghv6Q
	WKAKDNnum/QBcKOaZf6XXIyABeU6sCl0ZjP7sOwd7vMvZKBXvjm7ur1GESkoJxE/CpwYl198lYr
	zoA0n5lKxsZLA7Teshp93w80HTRYn3r7S139+3liOjP34F5BX5MweDMz3T8tP8n+yL4AsQND9v0
	fDltMq4vvhCvWQqWWJ+mfT3VwR4LuprM4kNRz+MmjrfxxbOnb6+ZUe42RxLUzO2OqI8levD5AUl
	34l8TX6P+ZKHSt2gvra0DchKOJEHuxiiW9RtLHODvDWHJKGIAAVAFIGO4yAgRasgBt+Bwt9sol4
	iSwG5k5TQ5V0xgEIQAjEdq2haWGStSUc9omp1CKxLtI278pg1U1VU=
X-Received: by 2002:a17:903:2c47:b0:2bc:7d1d:b677 with SMTP id d9443c01a7336-2bd27708c94mr73287845ad.36.1778741148005;
        Wed, 13 May 2026 23:45:48 -0700 (PDT)
X-Received: by 2002:a17:903:2c47:b0:2bc:7d1d:b677 with SMTP id d9443c01a7336-2bd27708c94mr73287465ad.36.1778741147511;
        Wed, 13 May 2026 23:45:47 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49c9sm13387685ad.49.2026.05.13.23.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 23:45:47 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH 0/2] Enable QPIC-SPI-NAND controller for ipq5210
Date: Thu, 14 May 2026 12:15:30 +0530
Message-Id: <20260514-ipq5210-nand-v1-0-cbdd7492e826@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIpvBWoC/02OywrDIBBFfyXMusKMxjz8lZKFxrF1EfNsKIT8e
 6WB0uW5cM+9B6y8RF7BFAcsvMc1jikD3QronzY9WESfGSTKCjWVIk6zloQi2eQFu5pJe/SqJsi
 VaeEQ31/dvbt44fmVrdsVgrMri34chriZgtvGS+qpRofkPQdVVQGlci70oXKKNLbBNgr+35ji9
 8XZQeQ9QaW0yNygrtnsGrrz/AAztfxw2QAAAA==
X-Change-ID: 20260514-ipq5210-nand-eb7e15d0d371
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        sadre Alam <quic_mdalam@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: u59DsrcLXp8h_h8UGYVork4tuEVerZaN
X-Authority-Analysis: v=2.4 cv=Wag8rUhX c=1 sm=1 tr=0 ts=6a056f9c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PVFtU_vroSRoQC6WWaUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: u59DsrcLXp8h_h8UGYVork4tuEVerZaN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2NSBTYWx0ZWRfX1s4tQ5MuZYPU
 TBt418zTBzCyyIY8cHRQHLICRI9o79CzFaGpLGnsPmV4+1OiCi1cbeC1D+TcEq0GltaF/+XzuKj
 3+6OZ1Wx38LcFI6hI4zMADNyXS/DEvFQ+GLpmh6PPts3I2ghECSnbezheNw/jh7ZNg00WnuMvPM
 K2F1+AFZ0bJPAwB2FF1fH7HnfcYFfY7AGw7fgY/x4YVbB/hI4Fhrdhnkt3o7QB08Z2NPGxCMXLf
 ehCsZLxrY0mep66KZg1NjaGI/qgsenGCI/jKAW+kzxc4+5AYsYj3WlZ3chWjBscaUkQFNntInHK
 WGGoCL4bRr9MADtrCoCHxCYGGs+sPvNe8MxNf3DxZ03kWioSCuiYw6NxzNIJlI1N4j9VskVo1tI
 I6wutrRnnAynWS434iSDofg0UuaMu0K7Mi5MFoxsIXFE7ZWURo4iZAOd3G6JeFKJ1yRZmMXKCuJ
 YonNQ+3Dt9Adk7lm2aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140065

Document the NAND controller binding and add the DT nodes to
enable the QPIC-SPI-NAND controller in ipq5210.

Functionally depends on [1]

1 - https://lore.kernel.org/linux-arm-msm/20260514-bam-fix-v5-1-58f6edb34969@oss.qualcomm.com/

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Varadarajan Narayanan (2):
      spi: dt-bindings: spi-qpic-snand: Add ipq5210 compatible
      arm64: dts: qcom: ipq5210: Add QPIC SPI NAND controller support

 .../bindings/spi/qcom,spi-qpic-snand.yaml          |  1 +
 arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts        | 42 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5210.dtsi              | 29 +++++++++++++++
 3 files changed, 72 insertions(+)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260514-ipq5210-nand-eb7e15d0d371
prerequisite-change-id: 20260514-bam-fix-142a0ee8057e:v5
prerequisite-patch-id: 9e9abb177bcb562f5a07a4865e9d88e82dbb98b8

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

