Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0E3451CF
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179697; cv=none; b=tgMy+9azZ5856L5AUXj1bXXxrZRI5CFshz4W0a9bO35CDVuxgreI/FSaAstSjz+/6zSZHKW2S0R97OnFixpUiNtofTFs5DyD80RRas5EUKWEQKVXzKaHdhPIcz/iLLNX+Pz0wkCKwWVm3wQsE6OXZ9blGMdGgpyZ+lHmF9YhglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179697; c=relaxed/simple;
	bh=BOLZoKheyS7yxrXmIvch8ffzYL34EXzMewdSr5TayC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hQYYksq+4o3sdU3NTR4mWM2DdmFqrVEvi+hK05CPIeCadZgQi91bmijeaKH7/VYt+tGJH+SdZEqUMAQ9w0Pflv6fZUm96uFj0cca8dF0a7vsW7IrgtSUA4mqsj47jqkVt0y5Jur+wezxYJXX5997ftkKvuFPHUbVHjcd6aWU0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZjxMrP+c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XSCOYqDq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZjxMrP+c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XSCOYqDq"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G3wYfM1610283
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XRdAWTgk0ofBEkNhCQmxjBVp98NxTcEKu+gg7GtTExc=; b=ZjxMrP+cDDh534qe
	352tsUzOAj8dVwWrTOz7PKOf2uVQg8CxDEZ1sp/AKV7oGHcI4HbmZxUa2NlVAl16
	GNp3d+wOYVFKrCy5ZJw4KMjBnJL2V5W+K+JacojkUtx5kJetK4LuuDFeDl6HXRan
	QfGm8OiV96EgOk3WhzTpVBan+0BkbTAz9JkQ7AMSq7ixjzXn0kSBubylyspsg/0M
	lpI4qamQ7sy5ZG6m9XqH2Li60Y5e0Y5ZCuuGQK9v3tGAzKz006SEDJrjZlI7HFMh
	CrZ8biSDHYtdy9eecaJZUQI6mvNpJa8Pn3sdDyiwOpDHMeIhHVZ3ka8ccX7mAXpb
	24kAXw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feayfkbfm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:28:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dad28e86eso6548854a91.0
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784179684; x=1784784484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRdAWTgk0ofBEkNhCQmxjBVp98NxTcEKu+gg7GtTExc=;
        b=XSCOYqDq7djLh5cfzWswb5ZX6dQOzxOTjq40oEnVow+jKxY75Tq8UDNDmzPrhe8oA7
         K/nuPN8SgvhBVl5enxw27H39BhgTgtxWDTANYV60TYYWaN3Onhz6QRPXuOE87Ddk9Uhs
         pi7WpA0kVgYiDt4o1mN8dCycz4LtbsOUYBbMWQdz+8VJekGtEnoh0mSaxQxyNRYMtGX0
         b+JHvMxs03mmOXWcKuX2bSxNU1xgk0YU3GDeUyTNEgxiwJwxmVVWn8EtxNlYiLY56V/y
         rrdQxDH7D2HAJr7KiV25e9oZuO0Y3JC4eY50/aNtwEoyM8lAtcBVY8yYAFaWNH1W9gCS
         kytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784179684; x=1784784484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRdAWTgk0ofBEkNhCQmxjBVp98NxTcEKu+gg7GtTExc=;
        b=hVm3fMzgVUaaRYItRgLNa+s4x/dyx0mWMVVj3lqzSVKPXig2dXfg5SHK+5AHO23rxe
         ONUoe6hjZ1UnffWdJhiGEMItmgjf0yU9Prv8yKVuBDwmv23nLF6hzULlbFltO2A6aBmu
         xE9ygsUjVFsLDbUD4qcYXF8HxA9hAi8K3b6HQT7vxTpDMXryUMuS3mMlfykq18viDrFr
         n0W0jLsLlvn+OqU2ASHBUguXoRhVGa1+rAMapMDZA6CHqiZBZpAeD7tlkS0Vcbe95Hym
         +m9AmEgtIIo6HAi4soCQuit6WVIaeRT1LPCMPFbi8MKuRuejiDDI6PjuVwJjpJgxFmNA
         vjhA==
X-Gm-Message-State: AOJu0YzQmXollpXUiduWA8LC33pPCxco/+ZIcpfG3j7xTzFBTDivMLuN
	FE/vWHESkY96E+FQKHJ9EOVgQxNRE7Bmg0FD+NmpylibvOSGABP6CdYn1806tbFyzvJNTxy1xz8
	teb6HZu++fs8Z3bCzWVcnAOajEBQ43WZum+hsiZ7dDJC3Aa++hDnvVn6fNRlxCFE=
X-Gm-Gg: AfdE7clSK+oG9gJ4LgFOA3pABlNlIx5Gz1LEtqeipDjX/n/4Qr1VNfrsUQwPGK+p2lk
	krNRIHhl5aqTiLvRNv+mZ8xdVkA6Oin2SfArelUGBMlnWY/fkWZrFl3ISZdYtLBWtGDSuYcOcy5
	3ALyyoKwjPyL1o+aM678EhPhjswmCwzWoLxDHZbUCnLxhgX9lrVSLB0DFeJXhbDQOiA9mkcYYRl
	M3DR/B/hYJFiBCA/PxtncXxIT2/snMCYWTN7k/xA5MCzwN56TalrGRuT/dWVPvzta2sQLT0LXYy
	o2VnbbFERhuLvizY8QewXoI03IEf20wMGpgoYqIENgLE5BhGjj6oP7D37T5YHAR4ACA4MkmfEJ9
	mVxysTkLXVIjCQW0MgeoSXYZRftRPRJBkK6SZcHV16wWhjvYR7xHKnb+WmUozSoRMPc4/c7oeCX
	QSpYUufQogxNI=
X-Received: by 2002:a05:6300:2288:b0:3c0:e6c3:224a with SMTP id adf61e73a8af0-3c110775293mr21497804637.37.1784179684004;
        Wed, 15 Jul 2026 22:28:04 -0700 (PDT)
X-Received: by 2002:a05:6300:2288:b0:3c0:e6c3:224a with SMTP id adf61e73a8af0-3c110775293mr21497782637.37.1784179683536;
        Wed, 15 Jul 2026 22:28:03 -0700 (PDT)
Received: from hu-mdalam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e53349dsm7795812eec.7.2026.07.15.22.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:28:03 -0700 (PDT)
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 10:57:47 +0530
Subject: [PATCH 3/3] spi: spi-qpic-snand: Handle Macronix quad read opcode
 0x6b
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-quad-v1-3-636f74da17e1@qti.qualcomm.com>
References: <20260716-quad-v1-0-636f74da17e1@qti.qualcomm.com>
In-Reply-To: <20260716-quad-v1-0-636f74da17e1@qti.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Md Sadre Alam <md.alam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 57zDL8MJODF_JKHRoJpc4SU_bI6Cmakb
X-Authority-Analysis: v=2.4 cv=WoMb99fv c=1 sm=1 tr=0 ts=6a586be5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=FygxKSnESxtamiDJ3dkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA1MyBTYWx0ZWRfX8cavzTzylOzl
 kvePFks3e1bl/PeHP4B6qZVC0d3YLGT0CInV0OLZSmN1GA8FE9nEh/s1hvFgQM5DS7lh6Ur00Fz
 WuGvTtiqy4pEf7wg8shrkwfWmD7INiAoQtTdDsnXKw1VHPfB3YJFrGBD03ByQSpzzW+glH6e5Yp
 r2TZ29aDgxFWlqmSd5KZy0GQGgLSj2VnsZkMNKu2HGiWiXTGeSGNejhqTRsU325nEGsa1TTeEa4
 Wcq6Scd8se/raWUUkl1QY+69ClMCma4cRWs7QHdGBOFOen7pYEUeFYMbenC2TkokICx11/+Vh1j
 mw65FNQTkNnk/ufoX+bKzssXTWN7OOJ5dJ9HjdVVdd0IdzcmVJlr3a18M7bDLQJv6Jk2uu/xeqm
 tOPir/GFF6f7jE5N3MdT0ejk/D8sC6zzhZqKIqOLi6Xn/hnHoyQx/B7FJVXpbJFDUNtTO9SLcxm
 Ml3ko5+DznN+kY7JtwA==
X-Proofpoint-ORIG-GUID: 57zDL8MJODF_JKHRoJpc4SU_bI6Cmakb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA1MyBTYWx0ZWRfXz+vIbEjz+sFN
 RLFKfOAn72web71CFC/5s5Sdi3EjJ6FoWQ65141k1sI2Ncm5XmgVtr/FdR4KlDx+USozz4yChoa
 BVKy/JD2Rum99On1qIld2knv2ZSI8Lc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160053

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
index 5c077f7023f1..e2f5dce15946 100644
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
@@ -1023,6 +1024,7 @@ static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc,
 	case SPINAND_READ:
 	case SPINAND_READ_QUAD:
 	case SPINAND_READ_CACHE:
+	case SPINAND_READ_MACRONIX:
 		if (snandc->qspi->raw_rw) {
 			*cmd = (PAGE_ACC | LAST_PAGE | transfer_mode |
 					SPI_WP | SPI_HOLD | OP_PAGE_READ);

-- 
2.34.1

