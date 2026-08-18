Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8439FCD8
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059698; cv=none; b=B7B69Vru+BhzrSOFgpqb4RDWOBTTbTGN9goOZqIoBznvpra3cq8LRZFGR9XAxRkVc0+JXBffCislkk/shFmOAkDbSPvM+mfoHsTID7DTj5XZNlyqBS3JwkBVtTsSmEQkWJxTkLXJEsxZTGfd/8FeKk4N6kpuOKHh5zbbORH3TLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059698; c=relaxed/simple;
	bh=RfpT2A8mXmIgd9/rzkJjpIStePeF6g3Bowgnv4/GJIc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LooOre17ldIDc9GDTpXmStR+u9WCNaYY2AfPazRvkf5UcdYr3wAmaWeLD34adIMXReMKIP2OvOiOLudcxL9y3ZBm+Ymi64WGVM4m1Vt3eSbBLgo1VhpiO8MtOTbcKcBKe0bEZwVtz9IbARmN//HPIHznH8jGT3zgm416SLD/pTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YiM8ea8e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AgVxcD+/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YiM8ea8e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AgVxcD+/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDR0Lx1451353
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MTslnVHVNGICAAwDfmm7mt
	HNXgqom7YGBRdt0SDwdBk=; b=YiM8ea8eZhcHPxlqcbSyWkDA/uGnmWBK2ftFTg
	CUGK2Y/IsrcZVJegeyM8Dp2w+abC8nnKb4a/4LvSiNhhlSvEMLoQBGQ07i7EaAxm
	Mt0/mqZVoY9SDQYAVldfNnzH7MtFJIxuEdfloQY8Gm+ZPoslSiU+i5Ox8+Dh5I0m
	4aW4Co9e5UlChScRewQ5OxMXeVl/K1xCmDmh9N/H4+9K3+Jb+6MZztHURd9v6aOq
	GKaY1xbt97BmI933seefRgXtJphb9pKU01NQl9dhPiRgznx8dMCFaOrT/cWgsYKh
	P58BnkTg5pM7TknNzv4ayhHkdXxOG49dvLo/pXSutBCV1BPQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qyx033g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:28:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e9489f62bfso54711936d6.2
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787059695; x=1787664495; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MTslnVHVNGICAAwDfmm7mtHNXgqom7YGBRdt0SDwdBk=;
        b=AgVxcD+/H82h9/8jJOUi1HdSdHpCiFC22oMT7lACkHr2nzdBqkAsnT7jHgVtqz7Ira
         UB9MMUdAXF5ZYuqDuKzaAFOrlLDxYQ+QlBQGt2dHfR37jaf/u5JWePIjLxD0cn/S7NEd
         WP7hTiEKVMNXRpJodXEp9I8AkGpwDA/uPgXuVLFquYfk5A1LW7pjl2SGYrQXhSY02pY1
         haEfkAkhSvGx1/FvNeBpYbl36sqqNOnQZ/ABnpxzhc4cUFodOt0C3d5nOdVvHnKC4mUG
         fkuV5eZxSTYlQ/DxthgKeKIpa+huXKpPxM+UW2UQnUfGCOk+wPJiW7WymLJJLcC9B2aI
         cx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787059695; x=1787664495;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MTslnVHVNGICAAwDfmm7mtHNXgqom7YGBRdt0SDwdBk=;
        b=JtZ/K++tpgd5zXSzeMo0Jrec6h/uSjM19IJiyAQWbdw4EP5fOb5VxLikS9Kuxc4kvv
         gOtqczCniVTr2P2hWieHWke20FHFx1Z4VchW/bSdyRFGy6qGLAz0J4LQR/JP6jUiqRmx
         rxrSYk5tK7O+GHb+RAOzekn4IG2ly7G/Q6VbaKGTHyJPaCxpZoit+J68eZIYinONUkml
         ia4YYvB15LeUm/iiCowFelA8w5fLo3iSbFuXBo1zW8YUDBOgy9U//g1dPbklm0UHMVTw
         kkSdydCUR7gkwDhYEPGAvwd4Ya65VVnH+pic6Oth2/82OhxL5uFqhf+LoEQ8IL6bEcWM
         28uw==
X-Forwarded-Encrypted: i=1; AHgh+Rr38ZNtxJ8t+TGfRdzBz+wSWH6T5BHCNv2Kz17yxhx5OXDOmZKvT79CGz7KSW8/MrV/rGb5871gBT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUP9jzOWVO6+3iDVsN850t7VM+KR+/I+qrGViRs++xsUlyNnj
	C7PGFNTlwyjeXLjqj2tJIRyt75NNYIv3UAZB3EA2y5mQfnyS4vBhaNb5cCSuM1YACrV8uTK0oSd
	eQMiphbWH3EwFQL1NjsuBw+wC6Vi5WB43n62V1AvNVj3Mf/lc9IaqXM7wEGlIKgXnEpChyj4=
X-Gm-Gg: AR+sD10a62VRXWIfT+DooVzXm3d6vd6ndrgvcVgj7kDACkgjG7Re14HYYUCNx3U5tio
	Emrvb+1Jb07NfoZIi06AwaW8ocGBMjhd9SW8KehC2Dpo/179H+K4mP6iYxCkTKK3TK1QUUvUntf
	F0RgH/2qwcY6wFJVEgg2b4lNAT4Mwc1T8P+CvpMkiHk+skMGgkSJlO1q8RXVd2SN0zWTPhIJCo2
	NAu+BMBCwUmmTmlTXQ7itMKAvd2NYJvqDs269McmotWHllyHuUUlTwU1+O2XtQWseSM0L2ZnZOv
	/eAQs4kVEwHAsbMCTLcxlvBoKCCXOt5IRhl1IHWqDRo0AOb5fGaINvcosPIyXnOZNuWvzC5T75G
	Eb3JpvCNoVFvwwtzIoGqGm84WCTzvYBfcFg==
X-Received: by 2002:a05:6214:4281:b0:90a:3291:7ba3 with SMTP id 6a1803df08f44-90a91c5c3d4mr380897856d6.5.1787059695262;
        Tue, 18 Aug 2026 06:28:15 -0700 (PDT)
X-Received: by 2002:a05:6214:4281:b0:90a:3291:7ba3 with SMTP id 6a1803df08f44-90a91c5c3d4mr380896926d6.5.1787059694656;
        Tue, 18 Aug 2026 06:28:14 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4580f611sm32304636d6.6.2026.08.18.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:28:14 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v3 0/2] spi: qcom-geni: Add shutdown and panic notifier
 support
Date: Tue, 18 Aug 2026 18:58:06 +0530
Message-Id: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOZdhGoC/42OzU7DMBAGX6Xyma1s569w4j0QB9u7abZq7eBNA
 qjKu+MUIXHooZeVRvo0s1cllJlEveyuKtPCwikWqJ52KgwuHgkYCyurbasPugaHCDLME6bPCC4
 ijC5ygJgm7pky9CmDjAy96yrrqQsdoiq2MVPPX7fS2/svy+xPFKZNvy0Glinl79sri9l2f9Xm4
 epiQINv0JtOY/1s6DWJ7D9mdw7pctmXo7b4Yv/pzeFxvS168rbBpm2r2uk7+nVdfwAuAfxTVgE
 AAA==
X-Change-ID: 20260804-add-shutdown-and-panic-notifier-for-spi-fa732be7c7dd
To: konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787059691; l=3099;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=RfpT2A8mXmIgd9/rzkJjpIStePeF6g3Bowgnv4/GJIc=;
 b=oFWbA3zxcF7YOd4pszY8PO3OZS4CHt+2oOJsEXSguxcEysq6daxK6KxqioGXVa/YagYfzn35Y
 gZVBiQB5OKIBz98YFEGYgiMdNN5nmQxbYd3q0DJW4Vmqqy0ZNEe8e3g
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5OSBTYWx0ZWRfX7qQhFDt2Mvzf
 mr7e7CgOl1qMPMhlNYr7jCBzp9DivUbZmkocXXswTvuATGxwWRHQNkenzgkliYDgrFJAJCFD831
 dYy3CD2Ia6Ul7+SPkRbktTa1iXvD2Jw=
X-Proofpoint-GUID: zPVktpZsVm-AtMrLPWHwiaoSx5tWoinV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5OSBTYWx0ZWRfXzw8L3e+zAYAM
 VJ8J46mChxfNLOzbBKZCW54frAvz5EbaSo0ZDpCuLSnKvEERkE/wVBboyOK7uAkxdCD02zLKTIk
 2hzQ5Zrf4CdBwetMxHHjjoOUeD8QnwTqRWdDJvSaZj2prkNud6GAEFx2LEGsFNT3sind9/3OR3p
 AKTTawOMsZR41GCsSY8NQdmWNifEs9RIztky/vuX0ySyobKCEa0hQNvj6+dV1Ks8U4wZBidFzee
 27iGOHgHdVMNuYG+9PomYDeXJ50vvXc67rTL36xCcwNqx+KbGo0v4GcQRArFC4ClhlM5kpOFSxC
 UjBUJBpjPIlAve0e2iDGoBXtZx7dr8N0ulw7gRHTl1GXcvIG3fSNDSNWClhItb7JZNmJ0YL8KuU
 Rbchf0IUTCKgqHerww1bWKLDTlf6T8j7NxJXtNMTS3HMOabSpzMEa7q/85X3vtFjnpUD00Q7E1b
 EXUsdE/ZrU1QAUY+tAg==
X-Authority-Analysis: v=2.4 cv=Ad+B2XXG c=1 sm=1 tr=0 ts=6a845df0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=3TSnfN-DnJKibx1arKwA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: zPVktpZsVm-AtMrLPWHwiaoSx5tWoinV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180099

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
  controller (via spi_controller_suspend()) on a normal
  reboot/shutdown path, where sleeping is safe.

- Patch 2 registers a panic notifier that cancels/aborts the
  in-flight command and resets the TX/RX DMA FSMs (or terminates the
  GPI DMA channels) when the kernel panics, covering the crash path
  as well. The notifier bails out early if the device is not
  runtime-active or has no active command, and otherwise uses
  readl_poll_timeout_atomic() to poll status registers directly
  instead of waiting on completions/IRQs like the regular
  error-handling path does, since panic notifiers run with IRQs and
  preemption disabled. The notifier is registered before
  devm_spi_register_controller() so a panic during child device
  probing is still handled.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v3:
- Rebased on linux-next tip (next-20260817).
- Link to v2: https://patch.msgid.link/20260818-add-shutdown-and-panic-notifier-for-spi-v2-0-eb25d56634a0@oss.qualcomm.com

Changes in v2:
- Patch 2: instead of just disabling the SPI IRQ (or suspending the
  controller, which is unsafe in panic context), actively cancel/abort
  the in-flight command and reset the TX/RX DMA FSMs (or terminate the
  GPI DMA channels) using atomic-safe register polling
  (readl_poll_timeout_atomic()), so the DMA engine is actually left
  idle rather than just having its completion interrupt masked.
- Patch 2: skip the quiesce sequence entirely if the device is not
  runtime-active (pm_runtime_active()) or if there's no active GENI
  command, to avoid touching registers on a clock-gated SE.
- Patch 2: register the panic notifier before
  devm_spi_register_controller() so a panic during child SPI device
  probing is still caught.
- Link to v1: https://patch.msgid.link/20260805-add-shutdown-and-panic-notifier-for-spi-v1-0-b5db170d491e@oss.qualcomm.com

---
Praveen Talari (2):
      spi: qcom-geni: Add shutdown callback to quiesce hardware on reboot
      spi: qcom-geni: Add panic notifier to cancel and reset DMA during panic

 drivers/spi/spi-geni-qcom.c | 78 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)
---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260804-add-shutdown-and-panic-notifier-for-spi-fa732be7c7dd

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

