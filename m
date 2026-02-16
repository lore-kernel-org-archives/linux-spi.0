Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4B127FB1F
	for <linux-spi@vger.kernel.org>; Mon, 16 Feb 2026 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771232304; cv=none; b=L/AqUQnbWTSyAr1bKJ6TEPxOgySnH2Ar6PDSrbso5itDNktfz4YTb3Mud01vKmLH9syShFaMDK2TPUv59sRj/hP2pEgGSXcQ5ooI4/FeOXw1jNcFRbrkQB2Z7vKMdfWiOp0FGL/PHsHu6NPUVdiusWW/JmCnDyBpP3yQWYinWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771232304; c=relaxed/simple;
	bh=XQCnyPJQzVxYvr61i18j/+QbSb66ztJhWd78xIkKraY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eK8xlRYA0qvEcYEt7aiMe3BeZJzhmrEHqcPjwvjNNCHcay5H6qBNE1QYe36lK6DlG1jRgmkNdMW/TxTRmPot6+LkjPbFwCKEf9asnB/nm4l34D+e9JCrPK6EK+DtwqWtmCLGlXu+Gm7+9wymvPcVe9sJNNAz1yR4tsIaZpy1JU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULX1z3fa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DDurf6DQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULX1z3fa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DDurf6DQ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FMVMwD2266914
	for <linux-spi@vger.kernel.org>; Mon, 16 Feb 2026 08:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=4grS4vDw5dv2fIpfBzaeHOn9ObfDze/Cena
	QjYJmbPE=; b=ULX1z3fasCSlAzu68vxdEiljLMsObjj12fNzu2uI57lGWTonId/
	q5IEtNWrfRy0fVRMG5astktZrdT1eaxZtm5Iqlbu6mNW4e94xoagm8TD3O+splTm
	ApKl0vQOQ9/e/Sj1aJrmJ5jg+ngOCDNicpzRERTBEJALN+cSn1bhIywtAAyrOerK
	QnZwa/2AeaGrlWbBaNTyltKBIgbBMpWen/vm39smIJ7uU00r/8zgu7e79q1Zd3oh
	U+Yow8fnVJzciwxHIpYiBrEPMT8aoUxuFAEIjguaKrHajxT6SGE/M/R+xh66UeYD
	KmkOL2dgEUJfzweq3e7G5E97T6cZ2z2qh6A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cagcf417v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 16 Feb 2026 08:58:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb5359e9d3so1230338485a.2
        for <linux-spi@vger.kernel.org>; Mon, 16 Feb 2026 00:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771232301; x=1771837101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4grS4vDw5dv2fIpfBzaeHOn9ObfDze/CenaQjYJmbPE=;
        b=DDurf6DQc+RDOFTqDRcWPYCE/OZt/7gsjEhrMzoNiC5trKYRARkcFH4vO6kU2xvuY5
         YhXxWUZnZ784WBQSlY/H7ZAWGpLk9E3ShPUAcQ/j3QZOQipy0q+FgC92iaa7FMw2FBiF
         lAeCehWuNqkuOyzBy5xgsDT+/9G3Tg2kgTM8a4DuObCG5NlHFuSpagZAUk64ToelgZaF
         PbP1NKCdm2JC6Ih0vn9ax2TPjKnl/Wa0aC7nvhDAgcbyVTXjx0xIsKSaPqzXEY7+jp9I
         ztf5wpfRTNjgh1aoPXV613+3DR19Ma3ruKSc2M93NB2CbeEphWk2s3Owco4C0s/nBTCs
         teXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771232301; x=1771837101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4grS4vDw5dv2fIpfBzaeHOn9ObfDze/CenaQjYJmbPE=;
        b=fMZ0IiCRDzOfVZTIJA0I5JwO0vJG6c+Ar8tNFewQmnVplHO6uB3Lj8IRaXlL96YiVg
         yAhG3T8X2+/fDnqANUEY5d37Xx3Wtq0TdtNv8eoV5OxngCwcme9/faKcZfG5Mi7b7HNO
         rZ0KCgy88gZ2DPvRRs54mKs2fSL4yW6n257U7rHy4MN7EI8iX3ARgJ20vxGM/HqxhY1A
         NDp0KO4SOq5ic3C0ReKUQsKolhTtdE3bkF2IpdFzwKQIe/3pSRl/maS4KdldcbYVcUna
         50P6fB93r5RXLLtW23Ki3GGK9/r+dQl6RBSqHppwbFWMDz4Hww+tODXwjXsFdkNEHpoS
         LLpw==
X-Forwarded-Encrypted: i=1; AJvYcCVeu8b5Kf0ZPjy9sVCS2WjtMSYN5RK5TBppGPn+n35JzCTXiN9jd90Z76jz/1s1pNtkfwn2CFy7jsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgArFjRe/6wpMKAxuScOimXsMJI6aXcEdfyeY4ORAxMWv8a0S
	ZBe9jv/E6hrQiKjtgApyXHAeR+WhagB6ydNL4Zc30tzLJBA/lPGoOG0j3AeGCcwFyEJFVwLYhU2
	C9fsTwfpfNtHucyaHXzgAihhy+E/11kZUQD/UjKDeqUapJupnL3zoXbnxL6Vqn5M=
X-Gm-Gg: AZuq6aJxVmp+8dzcz2egBp3ec5hLhYo/rvEueDvbRNUT6crvmYufxHTX5/AdDbOLG/e
	a9AOm0MkYCBgtDTq+UFK6sYuVQqxnWFFURLC/P8vVbE5wgRdrDQ4Ox8mVe9fINNphvO093T8BQu
	FYekGgowUjE8h1TX6OKOIlmHQVY1RjjtlBQE9sGdoRjg92JWCQQMpPx9WNDq3M1toJ5tWth9Lv0
	Aiw+Sg+yGAVtW/FQwCZCKo2F9ZrVrCYNbwOwcp4edfT2GSYhE2a5eXonti3maCbNyu+llCFAZw1
	6p5yw2vYxFky2IAjcCMM+lvGa8cuk7IB/AyqkXu50pqoRM3YxQYCPwaYIM486J3RFfHqoFyjZ3a
	K9ytazEHQT+e/goDdQYVMjB/fHttMzX9Jkj/Hyw==
X-Received: by 2002:a05:620a:19a4:b0:8b2:e9e1:400f with SMTP id af79cd13be357-8cb4224b5bfmr1046448785a.4.1771232301362;
        Mon, 16 Feb 2026 00:58:21 -0800 (PST)
X-Received: by 2002:a05:620a:19a4:b0:8b2:e9e1:400f with SMTP id af79cd13be357-8cb4224b5bfmr1046447085a.4.1771232300958;
        Mon, 16 Feb 2026 00:58:20 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a420b1sm75752145e9.28.2026.02.16.00.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 00:58:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Alain Volmat <alain.volmat@foss.st.com>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] spi: stm32: Use NULL instead of 0 for pointer
Date: Mon, 16 Feb 2026 09:58:17 +0100
Message-ID: <20260216085816.69888-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=XQCnyPJQzVxYvr61i18j/+QbSb66ztJhWd78xIkKraY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpktwoPLSuKARQ8bypqMLbyogxrTd1SpNDCK4Xa
 k3um/HtrEKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZLcKAAKCRDBN2bmhouD
 1zhYD/954EhXNOna/XkOpCBJvRV7QyNkhRrlgOHPdpM2QLVLp/rOFm5BZTGoW1DGy813qm+wzMM
 gioGdxgx3GOPwCl5Af/p/AptAaVRZhCKmwNoKM1ARR59d4cIVPPHXQQ5YEu13ED2rvbNvxyo2YU
 TRm/Z7Y6mMTBGxDMGUS9UEzKBQp+IiTUnLIHDff1wnFJoeYg7F/+HMq3/8WDHL7VksBqxUYe9xw
 p00D7WSmxdjKL6ZZ58TfHBSmrRBbMWJIa/gqVxkJh2lNom3ztADtDUwZXpGvMtfk1JOfAF9iwOr
 4ZWRrdM3H0lMU9soWgu7Mzz9EFJ0UUXX5MmkQtQmYlrctq7gPscTzQImkbiAZUyQJTj255Ya3Vg
 TeoTz04pPt3Xs0/wOXz46Tn9T+fFN7jf0UUGS5k1DvMjRxvcR0h2wIQmjcovMQZ28Mf/ghra1Tl
 BTjiJlg1YDl1N3b51r/8ydnE2a2UiZDw6ObUnB6JLytV9RJhveAmRlTw939l0SsjrM+dDuHBdDz
 fIKydXp6fVT8umyE0gjb7+Mww2/HU32dNNxHWTf/FEW8ZUj/ThWtag+9F97ELx6+sdtg26ensrX
 5v9l2syWdlkJcZUHhEYjvhFLf0x7KW1Udi0yY02EaiR1+k3S40FG/QKHL4KP7ifBx6FniWAznGJ cBtjk4LkSmenVTg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XPKvNBy9IyBPlYHiTz1Kp0kwIxo-2o8p
X-Proofpoint-ORIG-GUID: XPKvNBy9IyBPlYHiTz1Kp0kwIxo-2o8p
X-Authority-Analysis: v=2.4 cv=Sc76t/Ru c=1 sm=1 tr=0 ts=6992dc2d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=S3UOEAcGOv3Q9y8fZdcA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3NCBTYWx0ZWRfXyfYuJs6QxwzC
 52LbAIDNa5ljOhfcCsE7IzoP3/fIuY/Yzp5QuI8bNkbF609u8wgYdkiUsEhzZ/rZgl3cs8b2wXG
 1HCrkQPjyyTqrhIxITpE50ym3S4LAsgRNcxjw9SVK8bFRCl3GoMqlkafDmw2gwMJcUKQsEc+5gR
 6v614S8jEo7XdE6bpFGnnLie7ozAzSjRCpq2YEQb/DzIXWJBcUo86h8PHpUYS6XEQVvDA8hU+SP
 rFztiE461ryFRR6Eo0w0AQLjSNPmJRkkjMk95gfKVoR1iZHTr3OhZPT/+GoYKGCBdmpOG3BsoVs
 hA63KW+8OV7ni0QYkqT+Sxz6D9B2fC/J5CUTK/Wcy5eUGMLAU1w+AOpJH17a+HW0Bj2Uo0FC9Lc
 K/w1RDOvxcxMFFMdYzrR8CLjX1RmJB7zwY2EyWJnwhmUoMczIHvS55BQ4liLQLpD/35tF21uF8y
 3qUlwkTN+DU8fFVt0fA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160074

Pointers should use NULL instead of explicit '0', as pointed out by
sparse:

  spi-stm32.c:1659:65: warning: Using plain integer as NULL pointer

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index b99de8c4cc99..38f6bba38b07 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1656,7 +1656,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 			ret = stm32_spi_prepare_rx_dma_mdma_chaining(spi, xfer, &rx_dma_conf,
 								     &rx_dma_desc, &rx_mdma_desc);
 			if (ret) { /* RX DMA MDMA chaining not possible, fallback to DMA only */
-				rx_dma_conf.peripheral_config = 0;
+				rx_dma_conf.peripheral_config = NULL;
 				rx_dma_desc = NULL;
 			}
 		}
-- 
2.51.0

