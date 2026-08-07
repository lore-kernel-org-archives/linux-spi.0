Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578FE442372
	for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118654; cv=none; b=Zy2slsmCTA8FyNIwVQdV9ESLqplzRqTQbpOsiZPhrgp3NNHsW3P8jo/EIBu8698JSS731ge3gBXB7tNWXVUccE7wLeQuSNlFxgzkhyiyYdHHfdKU3ihAMcGtyIO1IpwoCIBGeeb2xzfJ1AWzrCP5UvOTJQEd3KDCLdH7wQzIWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118654; c=relaxed/simple;
	bh=5WthjTG2xxpTxvfqn9DfKN3A/9y6OFDPyYaFEWcWowk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bRxYKINgYK5cNk8zMU67vl5/XcQcwt1Et9KxNoh36nRHEKs0jr846CPwBcDozIszuqbJHlmlJFO6WRnP4EOtaE+KJQ2DvUtWtK8bomb53qiWZVs8I2D6nGnl45+MJs6DEP7OA4mEeOkCcJ71Ilv38y6wf0FfW4oRdnrpgdZlYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DKhvz/Bt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BCZSUCQO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DKhvz/Bt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BCZSUCQO"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677FRWeW1911756
	for <linux-spi@vger.kernel.org>; Fri, 7 Aug 2026 16:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nf3EsI1y9Y4VvhefJ0IVqY
	GkYHIBiRVhxPHu6hseVCA=; b=DKhvz/Bt+HiHHA+gDEuHqDmux9Y86PTOQNxGEg
	Z8fY5+tvGyccYHPXPOzqhLgAuroPi+8jvDQtl3XzIDYcdBVML1bfxPb9MiExX8TN
	Q1m3fTtrvvJg0ckqv1xiNiLEYS0rBc/jInZURY7vTfq3UXToVJyasbfMhgUR7jzM
	QOrjLvVpa1nRsYnM3jESjUlld30KRKdbYwSQJNumUWHY86o4tbkPJpiB7E9eYYjQ
	XuTg6rIhpUyJDjMIePptt4n3hcBOrxu9j6tiO1XLk6HYYJ9lDA2+IMZAgqx/n8en
	zHvzQ6dnqWaRjw0KqeDCJTXWToZM32AlEYKP8jU89dj2M14Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwcjb1jq7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 16:04:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso4513433a91.3
        for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786118651; x=1786723451; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nf3EsI1y9Y4VvhefJ0IVqYGkYHIBiRVhxPHu6hseVCA=;
        b=BCZSUCQOu2EZgZ7a5e3+b1DAb1Jd9pk9t6zX4/3VB9dW8ktgKWHc7j7H44e42jcgrR
         PhdDBwV54iQVoPOQSZGzLZ1Q4TccwT4Eew0M4VYUEgDTb+c0s1bxYUq+fbSjCEdecQu0
         mk8BGd0319xB0eB/7Dhsps6zObM9aMp2QmlITgFxnycGRHgz3cb62kHEf5X7xQdjXDWS
         1r+xIcfJslEHy5wedT+ActpSFN/deBlUgtJYqlcuLKxSmb5GdFEVAyl0bRQMMeVjMqiD
         uRVtus4qzTACL4yGq8dsTB9EAeHn7byT0BHT4KEF+rvHhKs7qn5vrH/Q5MZWpQMAiMzr
         1p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786118651; x=1786723451;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nf3EsI1y9Y4VvhefJ0IVqYGkYHIBiRVhxPHu6hseVCA=;
        b=joRS2CxCnnvu33iMjKxZ0suMGqYrTdhu+euGAO9/c4q1wkr5lOq8xX+BERaSD1/r4T
         qb1a1UUI8MBgdRmeOtTY3igSd7MG61X9gvCrDd0wtD9iCZEoQINYEf6lPoZAOBdQhn9z
         NkdC1hfHiLtfCS7rzMPZx3DuLI/ohxT4RBFCY3yyWqp4EsplV0NvZnTGJj+neJHEV/p6
         qWEflAeQQdklBvpYSYMfXRU48ipN6iWa29keMQB63J+M29V9nqilUzZ5Vn6xsrltMP3D
         CfNjK8mrc0wOdLU/Cg/XNQtzBqHDmNzhSldxrrmv1jP77Gd5beP1/BUk9l/ycc3rnBze
         bD9w==
X-Gm-Message-State: AOJu0Yz2iCFIq5vTVRnRfuIiPl+4CUhIirJ3brft7iJU/SROi/Imlq/3
	QeVAJSKk5OVXL1MslG0leWt38D6IZW+FrJn9fSSxLYxsPhLKwS+nNompnrBVV0bQFCKkCVTh3Zk
	i7f5SeNwhrjp9sa4i3lg87m7Y73Zfqp0DKiueuxv4FXMXaWJnvxUV2/Ox3/vwFY3FHs4HJzI=
X-Gm-Gg: AR+sD10kMXIS5hb82ULnxmHo3z23EPrc7tGDUWectzMBP+5bDcjkmQIma1KiyPr0HuF
	boXrDmmgIImSPwz/Kax4i3ZUkj7j3dlXaQrB1OSV5eJivebLtyQYCgKG+epTqy9ZdkoYAHt7Lsm
	sHMX40qtgIQQ9eoboINZf/EQ3iDqzwKjevVT7u315svucE3WHUtT9GWdNVQefJgfl/zIVMiwOUw
	kVWC6xPLYr56piy4dH/cK6A8Ee0wpmQKm1QuSrXXY+9RrCG+r2wo8PFQ205DwkzvHfbtQ2RBqN0
	JqdBlN6u3TbqzG5XSJeMJ/nDPTB3ls0t80k24D37lX8HnOqDGEok4sPUGKX4VUYMYgzWr2I1+pU
	LgsRN995LocK6q074gutFMZvm/G4hx2CYrrop++h6PY/QI02GrzRBmT83XDcQv1ce25juViHz3I
	WlKO372Ivnkuk=
X-Received: by 2002:a17:90b:6cf:b0:38e:e9b:ffa4 with SMTP id 98e67ed59e1d1-3903c598e78mr25724489a91.6.1786118651247;
        Fri, 07 Aug 2026 09:04:11 -0700 (PDT)
X-Received: by 2002:a17:90b:6cf:b0:38e:e9b:ffa4 with SMTP id 98e67ed59e1d1-3903c598e78mr25724394a91.6.1786118650680;
        Fri, 07 Aug 2026 09:04:10 -0700 (PDT)
Received: from hu-mdalam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199bfd8sm8337541c88.2.2026.08.07.09.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:04:09 -0700 (PDT)
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Add quad mode support for QPIC SNAND
Date: Fri, 07 Aug 2026 21:33:54 +0530
Message-Id: <20260807-quad-v2-0-8ec821e2f22b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOoBdmoC/1WOPQ6DMAxGr4I8NygJNKmYeo+KIQVTLBVofkBUi
 Ls3hKmLpWf7e/YGHh2hhyrbwOFCnqYxgrxk0PRmfCGjNjJILhXXQjE7m5ZhI7W6FkJLUUJc/Tj
 saE2aR32yQztHWzib8DQeWTMNA4UqG3ENLBlvXMER6MmHyX3TG4tIif+Li2CcqUJ1umyN0CjuN
 lAeR+9DmscC9b7vPydIfobQAAAA
X-Change-ID: 20260716-quad-ec2765317214
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Md Sadre Alam <md.alam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX9ThiDHy39r5X
 JqkHRH5YM2q4UW40fbpV/QC3fmL+rIbAd3h8G80gPrmEp8FJ6fp+pF150fdIWlYmMGX/Dr9wvVk
 Nr9xuuSV+GzGts6e3w4y2c92pVACk1zUApUDnVfeF0jKXehs3H8NzVnKscT0fi0+0gHid5RH7Im
 vq1Egs4pncQdYeaTDjLq1TS/gSQrOqzYYwIBVxVtusQP0/EfTichH5h5eyAB1KkZx6JZeMwiLmL
 d2GOk9CCHOO19W+hk+o8c5UlWOgK7NetzHnOC8cXokab4aDi5KyIA2qLqGZBriXgxFrgHtheOmO
 SEugC4rrWNsNr+65GZyXVJmgGUjZlQrLi9lTgD16qLHJ+mSWlyPwBBlTVl1//NoBvrcUU0HWjUI
 HZkbeh0viQFRT+o0f8UB0Qiy/ExiiTXDdTKGJHLA8f1ie7IAmpCram6sZh4t2w+IRUhknKkEYLj
 ztZ9V0d5rnHb33zQ15g==
X-Authority-Analysis: v=2.4 cv=QsBuG1yd c=1 sm=1 tr=0 ts=6a7601fc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NJlDZn8G7RColAB3xCoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfXzETAqksK9sTD
 xzvKXRpjzyYc8WTD6FBhRc01ptNz5kKLSDNtxCgSR9nvGzJpCy7NN1B6MBBPOecxWNkZB85qJ1X
 g2Pl8b7oN83X+4etKrqkbEJVAa3MRlQ=
X-Proofpoint-ORIG-GUID: qwmaKss1iPTimHRq39kIT_dR7ve1whLG
X-Proofpoint-GUID: qwmaKss1iPTimHRq39kIT_dR7ve1whLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070125

The Qualcomm QPIC SPI-NAND controller supports both single (x1) and
quad (x4) transfer modes, however the current driver operates only in
single-bit mode. This series adds support for quad data transfers and
includes a vendor-specific fix required for Macronix SPI-NAND devices.

Signed-off-by: Md Sadre Alam <mdalam@qti.qualcomm.com>
---
Changes in v2:
- Removed incorrect if check 
- Updated snandc->qspi->cmd with quad command for further read in quad
  mode.
- Link to v1: https://lore.kernel.org/r/20260716-quad-v1-0-636f74da17e1@qti.qualcomm.com

---
Md Sadre Alam (3):
      spi: spi-qpic-snand: move command mapping helper
      spi: spi-qpic-snand: add quad mode support
      spi: spi-qpic-snand: Handle Macronix quad read opcode 0x6b

 drivers/spi/spi-qpic-snand.c | 155 ++++++++++++++++++++++++++++---------------
 1 file changed, 103 insertions(+), 52 deletions(-)
---
base-commit: d56fa0b2bd2d9b2fddc10e8f5bdd42d56676935c
change-id: 20260716-quad-ec2765317214

Best regards,
-- 
Md Sadre Alam <md.alam@oss.qualcomm.com>

