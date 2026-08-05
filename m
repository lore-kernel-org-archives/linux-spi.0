Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCB141DEF1
	for <linux-spi@vger.kernel.org>; Wed,  5 Aug 2026 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926540; cv=none; b=h/hw3RrNZXVGxGmxiBpmj2Hqn1lqOEojH/oXrM9CORKcHsngHMF4NGR5HH2JXBQIf0C1UuhkG71GGuY1g4wiRgKxriZg32abMwWe8WE+a9Ix/1rGhut6gFRn1w6lEi5p3PQ19XUihi1GnQFSslMP31vUyBDaBZ2OaZN4ZRU2xQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926540; c=relaxed/simple;
	bh=Lf6xr9Y7uOqDR6OdHVsHoc0OpYyUyceXEfiBt1xgFMo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nEmLSByUUW4WxVhJSMxtF+patWp0ajIfeyYS2JvMVGuaaxpZW7FwY3oOjeuToVGoWuFyKy+Op+p9XiZAIJDG53iTHDtSAjUNdkIk9g05T5gcCTJR1LJ7msnwDZLCzy4QxqwXy6YxoyTJzhplmQSqwpMD1/0JvFALpkeVaK00Hac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C858oAtB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AOsWy5oF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C858oAtB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AOsWy5oF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758dEIA2074096
	for <linux-spi@vger.kernel.org>; Wed, 5 Aug 2026 10:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=99NzGJb1dyEtOn0yPSaOzw
	dnlfhzZnsF9eQvlktn65U=; b=C858oAtBZAZHw4S/+FRDN7asu8Y7p8Q1qMAAWQ
	wU8h+Bjvg331K+hA8GKeKJKT0cKv4ce6LdROKWDlQy6hLBDJytBJeugDKqHPyXGT
	47dXGKcyjZhTawtQN68lZ8CIKsw5Ruhl2rjZIDYNnWj8tNGvOc/q9wZKiS4DMPR3
	PZeHXaKGYSePklkTYdRYvuclG8iUbXpq4NzbDSlqW2LcJjc8fFZkOS1J8dc2iHQK
	rzLzlbjhqv7Am6J5f0q7DsyydfNl/SK8ehet+bIBJ5usiKRmx6b28FWDQN9y2Xud
	0JfamF38fv0dKG9poRgLcdfkdRGCOZi/zcovsf7rM+8IiTqg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuk9u4c6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 05 Aug 2026 10:42:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc73f47bdcso14162285ad.3
        for <linux-spi@vger.kernel.org>; Wed, 05 Aug 2026 03:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785926537; x=1786531337; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=99NzGJb1dyEtOn0yPSaOzwdnlfhzZnsF9eQvlktn65U=;
        b=AOsWy5oFuRzJFDpp6HwEcsDYkIl9wOQpmwdRv/Pn/n98T2/ipXuMsQKF2uEW6m1EH9
         6/QjO8oJyTUpAmW6ONvyvTLFGmpCJBU2k0lfCroGMbws6mTT6f/43F2x7QU5G2k59Lzw
         /WG141NHZwD+RgjvSy9G653+kYBXmQ90jkdLFKlkvHUgT5/vHWaIfLiWmeS5Mg2c+QyL
         xCGDTmgB/tgbry7041zxkM8GJKcsLb0mOfqwThsX7ESRF8CUnD3S0OMHCM7jI7cpzT+t
         zAUX9x2bJ9sMM5Ao/kWzPVKq9TCPwsx2VfxFzBDA90Ivs7FOviIz65v6dynGlLtK0Pxy
         ZRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785926537; x=1786531337;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=99NzGJb1dyEtOn0yPSaOzwdnlfhzZnsF9eQvlktn65U=;
        b=O6vvD8mSEHSpPTu5xIY3dWhuRf7cSun9S8OeCdnFeGpST7z3c/K29JaRucvOKqBUzl
         wq0DSldNM+A3V6t33PwB4IHfmypT0tGh1f27lGdl+jhPheDWIMSrMcDjdI93R0xDUG+M
         poNAzz3C5C7Ktg/MSu3j3HrieysORm4uO+bvdSKirmMJJXSWyR9E/oQlcytZs3qAfvcj
         wI1iZht2JywMOgOmOx3XfxRwTmVv2V6/KjQfG/U95sG2KouqLsmgTvCcBs7ljkCEP2cr
         BIroRK47SgldGzPCV/kk33XAfTsZq+sRIAXKcBurwA8TAjg3zl53mb+VRUHiDGGAehpn
         B1PA==
X-Forwarded-Encrypted: i=1; AHgh+RoelYBk6fn/rPAgMpTOBXqQgkmO2Vu92r1jRfGgqVZglorQwBrrjE0988+OqU0EP0IcwLr55HGkOH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcNLz2/oCTuvHK7mo50xpJZf5J4v9lBVSyz6mSadiCYL7Nnfd
	QnNovRUFHT5oyYs39POcyfGjCwDEweUFYTduygxQCdQOMnIHxhJ+37hacd/89Uxsjyi0FrkYvno
	9Qg/SPjWL00js2FZ8BbpmUS3gNmU59aA5HF4RhyykyiRJ2TrWNKrOc8OfsovPId8=
X-Gm-Gg: AR+sD13sE9PEft1F7VrWSYqJyMAG3CGZB7U/kj3oMlQW/vwu7Ue5dRhGpI32oEqvrPY
	amDg1LgHNICUuG1lCwNXdaJzFRbaspApZhhdputI0EGG8KcJc9KmhZcm5kOmaeCECO4jT7+VcJ8
	LHMpdLT9eN8qKUwqIlLJk3/dT9wwlBI8yDiwoyRbLGiYk2zmoTyqWjgQVqsVVhEuQW7wKtYULa9
	p85p2dbUQRD5EKzwjhcHwBcima6J8HmOP8oTwOg0dxlsHeFy0O13XXInt+zxZpn7fZ4PBJ8ivec
	gwZFaJz7ZZaF2hPfAQbIRyk9RznJWwCFmuqxrU0NSqz78oPiXz1Oqyi2/2H9H39CjJVl4Tu1Esv
	i/823YBOFhPzaX53BR52laCE8nKuKHVUgxw==
X-Received: by 2002:a17:903:3201:b0:2d0:401c:2ebb with SMTP id d9443c01a7336-2d0ca7125cemr69706295ad.4.1785926537284;
        Wed, 05 Aug 2026 03:42:17 -0700 (PDT)
X-Received: by 2002:a17:903:3201:b0:2d0:401c:2ebb with SMTP id d9443c01a7336-2d0ca7125cemr69705685ad.4.1785926536762;
        Wed, 05 Aug 2026 03:42:16 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa49295asm16131265ad.45.2026.08.05.03.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:42:16 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/2] spi: qcom-geni: Add shutdown and panic notifier
 support
Date: Wed, 05 Aug 2026 16:12:08 +0530
Message-Id: <20260805-add-shutdown-and-panic-notifier-for-spi-v1-0-b5db170d491e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIATc2oC/yXNMQ7CMAxA0atUnrEUCiKIqyCGNHaoGZwoTgGp6
 t0JML7l/xWMq7DBZVih8lNMsnbsdwPEOeidUagbRjee3NkdMRChzUuj/FIMSliCSkTNTZJwxZQ
 rWhFMwR/GiX30RNBrpXKS9+90vf1ty/Tg2L552LYP8smvYosAAAA=
X-Change-ID: 20260804-add-shutdown-and-panic-notifier-for-spi-fa732be7c7dd
To: konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785926533; l=1415;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=Lf6xr9Y7uOqDR6OdHVsHoc0OpYyUyceXEfiBt1xgFMo=;
 b=SdBdEm+FPfoA1uCT0y6jPjKuhXLcpjoBMc/vQ9GNwx11H7/goarrnlZc1x+VEJDFmgfk4flqg
 OFWKuIXOXLgAGc50qTG4rT01PgKlMWW36IJ/6/9JUZQ7wlOl44iNWQJ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=NInlPU6g c=1 sm=1 tr=0 ts=6a731389 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GECRcslZSES8WmdQ3KkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: cvQC1Q3m-9ZVLSLhEUO7qEJeLKwqP4BN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NSBTYWx0ZWRfX9RM+HIJ+6ulW
 kaaZXHz1xDJGvBT5magOIazdW5X/3b2JJ5oqMOC8iKMu6ATrFJbp2eyJ0WShYppBWaXUa89fNQX
 H+kEaGMIeYIFY8DiaX5/sm25yZGQacs=
X-Proofpoint-ORIG-GUID: cvQC1Q3m-9ZVLSLhEUO7qEJeLKwqP4BN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NSBTYWx0ZWRfX1OgnY/H8Um74
 XVWaa+k+eypUSj9OpflA4493XHKKwiG90lKg4hseCmoFGqGChZ8sBo4Vx/aG4xACB+y0CxQgPa6
 oJEXeXXcxQXg583eLWtrxTINisc7+ddfC3FRS855Zdki4dZqo67Vav2uWzBiylTckf9iAEnmWOQ
 tnmpQPFQVxVkA89qh1LJh3AeOR0aCm7O/f6gX0sfp1OcUdlVifgMzNc/oli8gdfNleWceFkOh5E
 pHDfgTJ63GlHnlfmeAq2cdQwJ85xlEODoyQM4JxkUDk+8h+ZeatZOdsE4AQgfrzlyx/4lB7Szas
 y+ePRMSgF8trpsvowXprzyy5AZbuZ7CVNk7KCeZaz9z36+c9TOtRR6jUMhBhPiWek63KvxACoDn
 l8D8CBVkmld4Ci5aMxlUVLLYnbh+EPT7vQWQC7snnmTzLfrqIh0uVfuv6SvvcGWUVFJpwe2hxbQ
 qwgKNUBBRcAbuDgu8Pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050085

On VM-based platforms, if an SPI DMA transfer is in progress when the
guest is torn down (via reboot/shutdown or a panic/crash), the DMA
engine can keep issuing transactions to IOVAs that have already been
invalidated as part of teardown. The SMMU then raises context faults,
which can affect other VMs sharing the same SMMU instance and obscure
the real root cause of the crash.

This series adds two independent quiesce paths for the GENI SPI
controller so that any in-progress transfer is stopped and the DMA
engine is left idle before the IOVA mappings are torn down:

- Patch 1 adds a platform shutdown() callback that suspends the SPI
  controller on a normal reboot/shutdown path.

- Patch 2 registers a panic notifier that suspends the SPI controller
  when the kernel panics, covering the crash path as well.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (2):
      spi: qcom-geni: Add shutdown callback to quiesce hardware on reboot
      spi: qcom-geni: Add panic notifier to suspend controller during panic

 drivers/spi/spi-geni-qcom.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)
---
base-commit: 9a4cdc958dd79fc6c3b20b51a10debec6ca09fec
change-id: 20260804-add-shutdown-and-panic-notifier-for-spi-fa732be7c7dd

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

