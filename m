Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E447607F
	for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118666; cv=none; b=I6tWKopHNFe6OIxrvZTxnHr9CD8mYbwwuIb2f+UfNmBmQNACD9mQm7rT/uXVrskRkNk50ia26YHtstoCRYKoD04nR15figEyu7/A79pnncs3Z+ac2E+vnxUWiMeGy798X5mBNOGPQHY2kBnZkKaVaFTIA9AAHQEn7cU2m3fwAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118666; c=relaxed/simple;
	bh=IWPoidckTkUCDUTtIIpJEWOGkTo2Wd7LukBSrJluNS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kuCbm9RkTFC3+l4Pl4vyh06ZrtpDF4B7Ph1nTIg3DRQuCIQZk7aUHbeLF4RaQRcJrPCxEn5AbuU0w3tfF7Z2jgl6d1Z1ScyGGL5jjcEPOCfca6QuaY+2oHB7e1ir91Zj6w8YGBOl6ir8BTv0G1Envd8kIgRJmSdBico7uA9P69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IIHsZmDJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HGJcsuyw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IIHsZmDJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HGJcsuyw"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677FRUYp1095585
	for <linux-spi@vger.kernel.org>; Fri, 7 Aug 2026 16:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MKafyX1Wb/XkrOV9lBc+42hvctUQmClx/XghBkmhpvU=; b=IIHsZmDJYpG96qjn
	B2VTNH33vkcVgVB9pzSuC3Qy9the1galPocuRT3rtudgVPSfAxllPb60RW+F7wA0
	V5UkaswvoSw6PvEb26++ptg2CMLgL+mdVuFwvODzIjsJssgqzqd0Ja8X1jhqGitc
	tm5DBVkmt8RdhoUnAszVGjPvwH547hVHvxE5ulz7xlCLhrUuzNF540J4l5iDQyIT
	9Td53i7zttedGxUTCB1vYKD6zgat8YeI0XCFzdqpVIFWGPLVaHehWPf+h6pmKnIg
	xcMIuAwtyvdQCMWIWhZsLZ1a+FNVNSOtL9RsABwvyXagoTOEd5589fcM36yi32Sp
	5FPZ4g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwgem8ku6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 16:04:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb92868263so3764663a12.2
        for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 09:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786118661; x=1786723461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKafyX1Wb/XkrOV9lBc+42hvctUQmClx/XghBkmhpvU=;
        b=HGJcsuywy99npCKts2Jz2sVqXWc5y5mUvsz3dwXJ6M16cxOpJxe3JKpjuXXnJkfHiN
         IzP+DNzz7E/qIMdVy/t6TIc6cTzJbeGJhjWge8bKVUMtDqWjPmHdBZ7BOG4IMxP813Sw
         xIznE5n2Lf4CCiL2hAkEN140mM+u53AV5Xv/vx6b5OoPDLUOfO4ppRMJLN+kMo9hKdTh
         j1Hgdep4YHEA453HTvq6kkh9U6sZIxpNzweM9J2jbqElaLYDjlX/J3EesDmbXNAd7AIv
         T2GyZVhohypsKXcpcBwDHUBQ9vDx/GefapiACeU8m1wgpwGBDIP5djtIe1LDyDkVMc+l
         iFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786118661; x=1786723461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKafyX1Wb/XkrOV9lBc+42hvctUQmClx/XghBkmhpvU=;
        b=eqJRvI/McoAM7G0/i5A0lxMTfmpdkDAXqgLwDa7hv/PUTJrVPhqIEqwtt04F12IRL0
         F2TDK7b5hjeO2gS+FW3YzNa/HIhNKcoGIUEVGg1QpZQs/IENpc+MWLNnvZaAMxiib4bd
         E24388cl07GtABi8QmqOyd7rHsZ3p5SEu196BccyR8uKuVjqyLN6pCce4CTGoKSwBX9X
         TTX0EEwBrNJd4cRgPGe7fsmz9qcYz68knDMDq/hTZSRWrRlIeZ6ijVyYlu4JSkfZbq7F
         ExIxEfA+A19+jb9sNUptIGz6KHoNMo8x9rdo4e8kBKqFSxtuOzjgK5/SP9RgStfMDVyU
         vVYQ==
X-Gm-Message-State: AOJu0YzjZPLfOlrK9jyKb+2vDgc2jWTh0Wy8VpEtGW+Xh19LQyjN/V9o
	OB4WFOknEsilGX1Fp/njvxmLQ//7eeIQkpOBMTBQGxFesX0/Ot5AbfmwaXPmNwBiFiLp8sz2wGY
	tHRJzYGScFgQeDmwU9KxJB+ZJ7W9UyNFfUmHQtp5z53rGzWm+69rU/QcvvOJ/vBHFicv0wQU=
X-Gm-Gg: AR+sD13VDncwfyxMmwcJaG050MTAPJkZfr59CleagJZJzyRoDJ2JEZqzyWnJEqxWafx
	dwKZKfpKpvMYfbsu4vgmrqeEjXB+ef/Ur1HblHOinCQSc4WYWmL3rod2rCC2HSrfqTAPtK0UzB5
	VvaO2a2OhDuDNe50W5AVpP+c6/Pks44k6r52imhRXbOggYyUkToA/mbZSmO6XMIxmYZMYKuy5xM
	T9Meys9JlxEjfSH6a1KRm8/PKNMweob4ovJ8DJ2rWHp7D9yaAb7b8P+nvkaq2n+hqgVO92p6INj
	CSt31wbAcBD4XttQqgMbdetf8NYiR5rqRnJ8wwS8dNeUSdNhv8KKithEXONU+FWnea3plq99cXQ
	w5JQ5esLXVgslXjhP+3COOCcUOZiklxtdiGL5zC147AEt/xJHTZaXtP8qyJfB6c30y5ykLwy1tE
	hIZHpqSKTl6WU=
X-Received: by 2002:a05:6a20:9e48:b0:3c3:875d:704d with SMTP id adf61e73a8af0-3cb85ee77c2mr32272954637.25.1786118660918;
        Fri, 07 Aug 2026 09:04:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:9e48:b0:3c3:875d:704d with SMTP id adf61e73a8af0-3cb85ee77c2mr32272837637.25.1786118660388;
        Fri, 07 Aug 2026 09:04:20 -0700 (PDT)
Received: from hu-mdalam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199bfd8sm8337541c88.2.2026.08.07.09.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:04:20 -0700 (PDT)
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 21:33:57 +0530
Subject: [PATCH v2 3/3] spi: spi-qpic-snand: Handle Macronix quad read
 opcode 0x6b
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-quad-v2-3-8ec821e2f22b@oss.qualcomm.com>
References: <20260807-quad-v2-0-8ec821e2f22b@oss.qualcomm.com>
In-Reply-To: <20260807-quad-v2-0-8ec821e2f22b@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Md Sadre Alam <md.alam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: cA0Cx1uPx_M19HLrZfTdUyjKUNLGZmup
X-Proofpoint-GUID: cA0Cx1uPx_M19HLrZfTdUyjKUNLGZmup
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX6bN24CqyP01r
 SGzhd9U0ZgUahmRIowDbNYHj7FVjI3i9dEJKiKiDU1ouhVXp5atkWA7wkVfGRQXAMCKrVIdFvVv
 M8yazM077U+rPH+f49sSpaPQTGIFjvE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX5QWA9kozTxRI
 N3ro4HOPePp6dy51IQvu9I6wRJXL0I/rCEm9N1Us9TD6tYEQ0E1LSyS5qmib6uVLkjwRwRAgbWM
 GBMsHporJeToSf0eO5JYzgtp0KyYLQNW8+8Js5jnzQAd8pt10KmPBdGYiWOURIHpcTU+0JdMFA1
 o6ilMorwPc0PpD5lPIYo5NTmBrxxoAiOb7XT92dP4B9XVYrLBh4wbDD3EHJIV/iCA243i2fD5FV
 Ks7gACYK3dcG4xTSNK50kV+Pzo+ttW2tbAigxrQ1E2/t+NW2oDFM2KDlha24KOGzuIUA2u/DYhR
 xvdwU7M9DUB6IiNfB1b02PoH7m300X7qT/LbrKv+AmvNeCnop/LDJzXZeZTcNfMOMACVfpfRy1x
 /hFKojcWJZ35beTS9Ifuy9B+AnyZwdv0YMr3rCqU3Nx0k0PBl2cj7T8JJ2oR7iXvVCDl+7YEX5Y
 BOGpB4z5/hBwXCa5RZA==
X-Authority-Analysis: v=2.4 cv=X9Ni7mTe c=1 sm=1 tr=0 ts=6a760205 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=FygxKSnESxtamiDJ3dkA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070125

Macronix SPI-NAND devices use opcode 0x6b for quad output cache reads,
while most other devices use opcode 0xeb. The QPIC SPI-NAND driver does
not currently recognize opcode 0x6b, causing read operations to fail
when Macronix devices select this cache read variant.

Add the Macronix-specific read opcode to the command mapping logic and
treat it the same as the existing quad read operations.

This allows Macronix SPI-NAND devices to operate correctly in quad read
mode.

Signed-off-by: Md Sadre Alam <md.alam@oss.qualcomm.com>
---
 drivers/spi/spi-qpic-snand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 6ad2f96dde8c..61b1f2eb19ce 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -52,6 +52,7 @@
 #define SPINAND_READ_CACHE		0x0b
 #define SPINAND_READ			0x13
 #define SPINAND_READ_QUAD		0xeb
+#define SPINAND_READ_MACRONIX		0x6b
 #define SPINAND_ERASE			0xd8
 #define SPINAND_WRITE_EN		0x06
 #define SPINAND_PROGRAM_EXECUTE		0x10
@@ -1036,6 +1037,7 @@ static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc,
 	case SPINAND_READ:
 	case SPINAND_READ_QUAD:
 	case SPINAND_READ_CACHE:
+	case SPINAND_READ_MACRONIX:
 		if (snandc->qspi->raw_rw) {
 			*cmd = (PAGE_ACC | LAST_PAGE | transfer_mode |
 					SPI_WP | SPI_HOLD | OP_PAGE_READ);

-- 
2.34.1

