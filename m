Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373853382CF
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094620; cv=none; b=l1UtWOqxBrklTwZ2pBoM2X17h3ZIuALf497TkpunjdniQL95N+4v3siJ/ldh2fXL88M6uBhGOihTxcOKf/SCRYJB1ocle4A5p6NnGzLUnQhE2ovQncivL65NuOw94PwlE3SVwxlLTBVoLMInEmIYeYKr9NRTblfbqyb8tAHi0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094620; c=relaxed/simple;
	bh=jAvXhPad+799i4jevYzF1yKIxwEIkQVxLwFv/54MkTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WV8zWzmjOBdMHJSwgcuczl5sXNJhie7gZlOYD397QrSXJrUKb14H+hrMe9RiTLlCbI92tV9zahX6Ktvw2t2kAC90qz5prJIXlyQhdpHjSEhKf5jHTzEy0XtHcKjtWbrnrVGJralR/QqiA0jCEn58ps3ll3ZOGtLR9mv2zUCFhKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SpnE9AnP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NzKsAXK8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SpnE9AnP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NzKsAXK8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M84gN4791167
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1WLTfBIUbrm278eAVvCdHgvSff8YTBI4fGO
	M84er2nk=; b=SpnE9AnPGW6FtUg2xwGhPzth55qJcfyC3oJ8QrqwHpGEr/MbJhR
	/01+p+TskkdI4n4avLJx0OoXhw0K7+skd6aEKHppO2te0OftDnSzZtG2vI8uFvq3
	1jgfhvlu2n7TjnRoOF1yF1M3EoAvZvTD4EaYmfurZk/sHfPbpPk4+uqDXwfWTIxO
	cQuGgpvr6Zfsct656HNnI1Pm0c4IHtAzDdOMUeN5zUzf+ivsFELKhcfBp5m6xKZ0
	DRvP7txcZ/j5rB8bzfUWjHDbQoV1+BtuRWvDZbGqM6NmHz91t3frrrInQOHb+GgI
	Q1HRKHMVjRWLXsyBeK6mJhw+NOJrBMOtssA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu6p1jvar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:10:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6133262e4eso750557a12.2
        for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 07:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769094617; x=1769699417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1WLTfBIUbrm278eAVvCdHgvSff8YTBI4fGOM84er2nk=;
        b=NzKsAXK8nHQP7maksfHFF0ycpRz8lAtL5UBxozuqLxjrhEPefVOICrYippWPK9x5TY
         SFz1K1VLMimwjaFZy8hRDgnZDPKXRxlmqkgYUIBo8ZZjgbihfhGf+xkh4AALaQMBqZ4r
         fy5dhmfC2K8roBe6OqmsO2XZWpNhyC26N5xfUBkfGY1dckH5u3/jJ+00k4vpGF4gNnuY
         7VhhHXLTXgJprGwifIaoSAOwrsHd9OK6/LkNgxgSaxXso/TwocnklhYn2uot+2OOgqbf
         mlB7ovsjNbl+AoAwXqulEzraiiwHY/aTNzcDoSKME5csFcGvuc+n4wWVJwbI7VghHlap
         Vnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094617; x=1769699417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WLTfBIUbrm278eAVvCdHgvSff8YTBI4fGOM84er2nk=;
        b=FJADzg4uPxK7g3jvWKYTulUfMrdD/Degm7Hhyt9XDTkh2h53lkUy35sJSYmbpTsHKn
         b94Wuf+FA8p+0kk0UJB1p7Oeg/pGi7y48L6i/honOLAA/sD29RuXLRYCWD2tW3oAf32+
         sbWzvugkZGHw/0otNGkB9eza00nlqplS3aSsoThFL3Zu38SnKhtXN+Jaz3y/xiSHlK4J
         8NFmJ3yFn4hFSCNGom0iPaOkNBPy+Damy0UEiWCu78ySsQfDxNwH6g9lSPjfne4jVCTO
         05Fjqlapdxt/pmI4QnMQzZRN/u9X/4BiCepNSl6mN0kQYc8XDWqXPCgUSqIl/w13zfez
         svCw==
X-Forwarded-Encrypted: i=1; AJvYcCVq3xHub07Rz6L4s/RWNULG7FzJ21eK0pXw1DBZJjXivQj2r8F6WICVJ4riSRmiV+mApt+wpHithFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJvZgj2q3VEaXijVFI8OgYv3FmXY+AXgo2e9zsX6BCq2i2877
	hq3iAT4fHwXfAgcaAhnYC92OQz0MdiJny/iywyTVLB82mP/IcDgHryQycC76VoLMsXdAS/SoXRG
	Rmu0Cil2pvUUlGkjeB+YSBhwZ5HmZ8/oya1ZipuEipIahP0eR0CtYDrePj1VMFdY=
X-Gm-Gg: AZuq6aKvWB2sazX//JVPG1xizI8m0BtTbS/7XSx3WRX+a04Nu0gUy6OXN80gx7Ohqnb
	5UBcj7Qk+Txbg6nDpqPDiBFTQH7rHqeeG8RjE5gcHRocUeDrodH/1Xp0vpktxg69wl9THHZMExn
	uRHpGBxWntf172S7+74lnlgMgrg3MiC5E7habsJHT34GB8nrHe7PtU5+KA5enjtriJKDEbp0Yjn
	krPwmKXEtK0yIXivofbDCoMq6zQDwRQOMavH1pbD+jikpBswMbUi67I/RZAI/qORlMWtbWFFntE
	EOSke27us1wmo4nHqiOl0dxsbA9QeW0zE4wrD2j5Xp23SmjsklcjadFfU8SeVg8eHCpmG6QRRGy
	U6s7eEHSz4JTWYxCpn431zuGsv/EKlZSUJ3UzTROlPl4=
X-Received: by 2002:a05:6a00:3d08:b0:81f:33a6:e9cd with SMTP id d2e1a72fcca58-81fa03855b0mr17466512b3a.57.1769094616972;
        Thu, 22 Jan 2026 07:10:16 -0800 (PST)
X-Received: by 2002:a05:6a00:3d08:b0:81f:33a6:e9cd with SMTP id d2e1a72fcca58-81fa03855b0mr17466480b3a.57.1769094616352;
        Thu, 22 Jan 2026 07:10:16 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8217c258fa7sm4328182b3a.17.2026.01.22.07.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:10:15 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v1 0/3] Improve SPI target mode support and error handling
Date: Thu, 22 Jan 2026 20:40:05 +0530
Message-Id: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: q8OIV-uGtjIBvFrEFPXU36_hCbSPSWWR
X-Authority-Analysis: v=2.4 cv=N7ck1m9B c=1 sm=1 tr=0 ts=69723dda cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fVkAZgIkOhdXw_bALp8A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: q8OIV-uGtjIBvFrEFPXU36_hCbSPSWWR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDExNiBTYWx0ZWRfXwwEouHufJor0
 dHEZFeUNgWbhZQhUaI5hM/v8XchFlF6EFEfBrgQnKRz0SGgrZ15sfdiYOxAgsGeHjVVxxEeSbpl
 yDzwm273Wz5qmB0ktVGh24+VePGP+M3Suq+qhZjeC2+4j0cYmRLvtKeU4DbHOIHHTgHgw73kog7
 y31H/7wabCMug1vw8/kiec1Bjc4Qgh9bJip9r4ot4E6h2A5feI4bHx04WIHPhLAVuBUCpvRNicG
 jXnneNBX6irQv9vE3d4eM9P0JAXxuDtTfxrIHe3QGLXY2D01dyv380+yv1cxjo++HocVYMN2eua
 Z6AcVpsjll/Ni9CYdfJYQzwShl3gipCtgNdJh8Zmm3GH+2tQlLX2yTtb5pSiOQvF9ZFQK/QBOLq
 9CSdYuic83KJevOihlHYhdgxC8KAMR/zOs5DzhnSdZU15Hys4HKvCTymuJ3e+8DIuR32jNOyxro
 6eFjgn5HL3pachafqng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220116

Enhance the Qualcomm GENI SPI driver's target mode support and improve 
error handling for serial engine operations.

The current implementation has issues with incorrect controller allocation
for target mode, missing abort sequence execution during error recovery,
and lack of graceful abort mechanism for target operations. These problems
can lead to serial engine undefined behavior and improper resource
cleanup.

Fix controller allocation to use proper target APIs, ensure abort sequence
always executes for error recovery, and add target abort support for 
graceful transfer cancellation.

Praveen Talari (3):
  spi: geni-qcom: Improve target mode allocation by using proper
    allocation functions
  spi: geni-qcom: Fix abort sequence execution for serial engine errors
  spi: geni-qcom: Add target abort support

 drivers/spi/spi-geni-qcom.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)


base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
-- 
2.34.1

