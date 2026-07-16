Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D13502A6
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180598; cv=none; b=SLBqBLIuz99X7f0Mn6t9c/wbJ06YK1BvWUDRz3E134wBaXlZVijpK1zN/ejFhw3PI6vbSEiddK1SarxdVDCWiPVWB4NPLd+R6RM/8ljSvtAjFjEfU6twd2zqGw9HgzvGY2L2NxePp2+8muVkIceVdNqPVk0R6E/+JzvH5mk1z0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180598; c=relaxed/simple;
	bh=2pMzY50Yewyh069zifH4G518lDVvi5A9FYRO0la5M2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cUIlE0zX8HSoRAIIUf6gXwSMk4Zbx1whKuRuAOyezA/FvpcE0PqZ/1Uzzrvlz+R1vh0+ctDsy1xPzzCYJC2aQyhhCj03tUYM4bIKmJGJjhQC/JclCUyEdz8Ml26mJ17Wd+ISKzATY9SdlKQJTwgkxhj0STvTt7XFEmWgbN5TU0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IShj5+QV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i7bNGBg8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IShj5+QV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i7bNGBg8"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G405b71677625
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ekaw4g3lu7lYnrfe0X7Vk1
	KWzpL+GeT82kT0/uffDo4=; b=IShj5+QV+JDFjrDGKCHMbXI6GLSSICtEWjP6V2
	5H70VcthtzFCkkXty7dsLq+nQ0V8AFA2XvvYBtTTjvBYWKsO1hpretdvoQZsIJlB
	2q2misuEX1doRkpIjtrl0h7do92x+LUXj7ZiKypU1+J+s+0eaJv0y2K0COAsCNqM
	g6YCANcMQ2VcXBqHpoI10iNMGrDp2FoDZpNe2oZc8U7x3ZVm0re+iWFQWXI2/g7A
	Fg+861orX/TJ5d/B0NAB0EWctPrACyTPgf4LWwRJ2nbYhkBTTGg9mzQPZRMZ6SIO
	p8pYOKTIWIXDlDfujURZe7YxFzKgXhSJOeJ/5sfKK7V5aJ+g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feeg1j7h4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:43:16 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8486ffba174so10510186b3a.1
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784180595; x=1784785395; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ekaw4g3lu7lYnrfe0X7Vk1KWzpL+GeT82kT0/uffDo4=;
        b=i7bNGBg8xQ24oMpaOhalmGnk+NGUKsuEx+K1JRZT0SYHm6Fuc916ki3+ZC7YiZCcjx
         uR2rKboKa6dREaOUqdPCsS8JfnhNoudGvOLe5c9KxwXT5JQUtsbSTY57Xxwn05T8Ti+g
         wpej6uT5NH7nNf08LJ/suv4rpF9s9EQJtQb5p57Er+mOsQegvxdxutLD8JRsefCZMWo1
         OSs5SBti9ooQRwZlwzI+lFDD0SClIXRYmAnMgieAxq5suvP949zJFYyEpqXIRkBQJivA
         p2zIY0Y7vw1aPqCInuFysLSENdfIBYY7B15QLxVGVY+X/U5pGo/X2tUFSQ+RvPo8T26X
         GVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784180595; x=1784785395;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ekaw4g3lu7lYnrfe0X7Vk1KWzpL+GeT82kT0/uffDo4=;
        b=ppJA5kO12YhtcqyJTmrNr4PxXA8hGspWRZKN+h69seP6DsTZMV3gzvBX6D4fj5HkEU
         DIwlMZ1h0Y4qdE93q1kYhmpaufZAiJBmsJRKvBuR9sh1a9f7QWG9axlDybpvMAJMARfn
         7XkSQHfXVbokFKDTIOopdnhRfT5ONIoO6ild4F/ObQ8F3tZMzsPz2zaMugqKdTlcn57v
         zbJNlpu2h1E+KPZpoZPq++q28rTuQKfia2lFfazqH0GkNlSP2vmTdfWd4IDH50TZt00O
         lm8zSUOxrnZ47aMYzQ9QKEti5Hq0Bbdm9mh51Qbc2S1QhsR/SHQ0mYLLZ7vM/50u+o3i
         Xbtw==
X-Gm-Message-State: AOJu0YwjwzYBhOlWgMoWNqAtanFAA3j0FJwdDzdxbjOTm+HFhfF6V+w7
	jCm5G7UF99OrB5Jc5RcUXMYUsuhbI+mnzZcpA4Ymtj6fG0Dtdw1BcVY7E5nhqnXIec3AkQoXGlg
	eOhHIZ6hk3zGKWiwGleIbbzIdL6XkLip5YuBzzDruGB85AlZgArrzqnKMl/w5jpXJRRl/ot0=
X-Gm-Gg: AfdE7ckcUq81V6a7zgp+SJAdHEJDxsYP3w8JvPWo6WCIRJwyBDe7xxDnK+wLkuuYBxz
	2V7snCbsKDSIm4fsW7G4xs+zGuboAntySYUeJj5ch+sonvVRZ3p5isA856yALhWebgS1mAjIMHS
	soYRVv0i3gP+Wr52m3itQYNeam2/plYn5UyDhmmGqlpjoBRi0YAtm4OUwEjvHD0gUsw8j+q7TAP
	+OL9TTlhNvg8zI7OZjONnfYmgUa5pSHGF4ixUWupa0P+d348G6d18Swz5GW8wt+55Eszim4babT
	KfBB3B4wG0g/gzJsKVGbllEbP89ZxVLSj4PEH4o7tlh7A3yT4xuz5a0t2WjtMBEG4nCsIXtlQDT
	TXimOeTfMhJvegp1TSkmBc6k2Y466ZHg7T8r1+TAb0nJP66T1IyjRCZi/CwbxqZnEWniLKmJkqT
	UPw4dVwG2CjZs=
X-Received: by 2002:a05:6a20:20c3:b0:3c3:834e:89bc with SMTP id adf61e73a8af0-3c3834ef3f7mr2742147637.50.1784180595049;
        Wed, 15 Jul 2026 22:43:15 -0700 (PDT)
X-Received: by 2002:a05:6a20:20c3:b0:3c3:834e:89bc with SMTP id adf61e73a8af0-3c3834ef3f7mr2742120637.50.1784180594589;
        Wed, 15 Jul 2026 22:43:14 -0700 (PDT)
Received: from hu-mdalam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6f0dcdsm6407084eec.31.2026.07.15.22.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:43:14 -0700 (PDT)
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 11:13:05 +0530
Subject: [PATCH] spi: spi-qpic-snand: Increase ECC strength for large OOB
 SPI-NAND devices
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-8bitecc-v1-1-6eef4bcc3a14@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGhvWGoC/y3MwQqDMBCE4VcJe+5CTDFWX6V4MHHa7sHYJrEI4
 rsbao//MHwbJURBok5tFPGVJHMoUV0U+dcQnmAZS5PRxuqmsnxzkuE9u9bhOho0ttVU3u+Ih6w
 /6d6fHfFZCpjPkdyQwH6eJsmdClgz/9Ga+n0/ANBbfYKKAAAA
X-Change-ID: 20260716-8bitecc-b9be3d2e7690
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Md Sadre Alam <md.alam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA1NiBTYWx0ZWRfX8JKyE5Aidb8A
 iMeBYbD2vCvrlRKmqbOit3jvMnyKWoTYReN1aPdWtZArlrE4E4I3gvWuUaa7oC67YuLn4DhpDfv
 kB2wBrKK1d0rMnrCgn81UNRAuJfk3uovs6OfYWGJR80Qb4ui1qa9YtGf8bx1C+xyd1U6iHiAW38
 xAKzj+zE3XhcE52aVDGyvrxqgiOBbxEASIATpHvUgOa/shfJUTmDd66ld70Mdxbj5czOi+WvzLY
 rz77vbW3FGOSGylacxLVpmoO1fj4IfUrrHiAN1FmYg1QbJbyr98Kuuvl85pl2YFYJGLVSO3S+Ue
 LQYX2dwgnt+6NqQhll+D3h0qsiUsRv/LHDARKbAfnp/RGFnRRiRGGI2FVCQfyg/nhQmHaKtWTrN
 rreOHa4SZOaxr/f/C4ghxT6NWhvhM6nyY7Y/0h5kJGWESNDKNVcnOFM8upgpy7JHGb5UyKxhbMk
 M3hU9OYW8UlOa4+7STw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA1NiBTYWx0ZWRfXy8g5HTafKdP5
 PqR/lufwUHtaKIaXjoeeG6aPhT0Wct8hj9YabbfUXpDpT8CZmUp67wHxHyDK/vjLa5GihBzhFC0
 3nr/pPUhKpMR811d5r+u+O6s82cUmlU=
X-Proofpoint-GUID: iyyTUXIe-cEHjxVctrMUBKWfkqU2OJMT
X-Proofpoint-ORIG-GUID: iyyTUXIe-cEHjxVctrMUBKWfkqU2OJMT
X-Authority-Analysis: v=2.4 cv=SsOgLvO0 c=1 sm=1 tr=0 ts=6a586f74 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=-NaL9wa4eaIqG_6P2MEA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160056

Some SPI-NAND devices with large OOB areas require a stronger ECC
configuration than the default one provided through firmware
description. For example, Macronix devices with a 256-byte OOB area
report that 4-bit ECC is insufficient and trigger:

  nand: WARNING: the ECC used on your system is too weak compared
  to the one required by the NAND chip

The QPIC SPI-NAND controller supports both 4-bit and 8-bit BCH ECC
modes. When a device exposes an OOB area of at least 128 bytes, there
is sufficient space to accommodate 8-bit ECC without exceeding the OOB
layout constraints.

Automatically increase the ECC strength to 8 bits when the detected OOB
size is 128 bytes or larger and the current configuration requests a
weaker ECC level. This avoids ECC capability mismatches on devices that
require stronger error correction and improves reliability.

Signed-off-by: Md Sadre Alam <md.alam@oss.qualcomm.com>
---
 drivers/spi/spi-qpic-snand.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 6cc53586b8a8..19812400124f 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -274,6 +274,19 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 		ecc_cfg->strength = 4;
 	}
 
+	/*
+	 * Override ECC strength based on OOB size to avoid weak ECC warning.
+	 * If OOB size is more than 128 bytes, use 8-bit ECC for better
+	 * error correction capability, which is required by chips with
+	 * larger OOB areas like Macronix SPI NAND with 256 bytes OOB.
+	 */
+	if (mtd->oobsize >= 128 && ecc_cfg->strength < 8) {
+		dev_info(snandc->dev,
+			 "Upgrading ECC strength from %d to 8 bits (OOB size: %d bytes)\n",
+			 ecc_cfg->strength, mtd->oobsize);
+		ecc_cfg->strength = 8;
+	}
+
 	if (ecc_cfg->step_size != NANDC_STEP_SIZE) {
 		dev_err(snandc->dev,
 			"only %u bytes ECC step size is supported\n",

---
base-commit: 19827e7930a5511c68e12aac6e4522f3661a1709
change-id: 20260716-8bitecc-b9be3d2e7690

Best regards,
-- 
Md Sadre Alam <md.alam@oss.qualcomm.com>

