Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234D352FA1
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094631; cv=none; b=FeCE60HxhSidSKZNblbl9atsUAjPmk4UeOQZ0HY0FDEj1qTSt73GbdM46UYTi2lGJSNCw7MJ2fqk0dO8wI2uHc2gSKGUpLZnv4Y4mnZFiCrbGN1rKxTv1vdPTqA7Sq4dqwbOn9y+P9k3q5yfH+ZVP8kxS1gYqe04f3SYRwTH/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094631; c=relaxed/simple;
	bh=C4Hy5jJgJFgiJtT3bfjDFpiGxmP13VJ69+n4ZwRm4iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IO0MWCbR74/ZKRvQ3YNaPygu3G+sKU4r5OXbW5KGEPKZCs6ucC0fMho4sdnhueSnZChEUbJonPSuBgl8YaDuGCuUOSEGLIFQPKFLX9bWSEepjhaGWb8iTSE3B7gPw7jiYz2yow1RI2l901A1dEM0y993SHqzFcyAcVCoWGXIUzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DWlLbwaU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R9COu89r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DWlLbwaU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R9COu89r"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MCvOH03902081
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ALflICnLm9d
	AF6K/Wk1dDN+VobBIOAmN5UmZDdeZ3Sg=; b=DWlLbwaU89OwpYB5NALN5kI0wFo
	6SdDodiRPewHE7XycaYJDXRV6Eby2hpYMKW412A9UzSblA/fHA++H5OZ858AUigN
	AuSPYns2szMwS7diSmRV69XRGQcpgZXqSq/o90ueO5tsG3I13lmqtGAuD4KLBFin
	SxLTlNjZ/AxR0Lq7F+zPiIeU8/8O3wBZaOYLoq7lBwpIcczzllnQxFBzHVfI7mwi
	H1IK8epNZ+9rzx5nOIJ9YAO3SWNutC4a+k8gUz3RXNYQUmrABrxvhJlmiPSmPYWS
	egB60wp6hbx7d55wUCknbfmdA7fFRNaZ48uH2Hw9RAZyEvAVtFDvLBReppQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu4khk9fy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:10:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81f4c1412b8so182777b3a.2
        for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 07:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769094628; x=1769699428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALflICnLm9dAF6K/Wk1dDN+VobBIOAmN5UmZDdeZ3Sg=;
        b=R9COu89r+IaD3z2dFRTBn1hAaWV2F2u0F+DVwSwQouLoHiRsHCtRj25wC89YIjRP3N
         pEdduqzdBNbsj78BAk8xub71Y37Et8CmrHrurUl0XrRn2DomQ3tFusJUv4i1cHtZnJuE
         da/fQ41sEPAexCFN1N/HljtD7De5L+9ubfVkS77yph9RnkcO9xgWz5wzUuN8dYKc5JRq
         GCSpgk7KtCfG1TFGHQruyugU4X87MSQYjrAhOp3n8qmytgedFt5xR6iVE0TEeX5itg5y
         E9W5N914XB1CJHiWivPDvyv2t5zjSdiAQRjdZMyXN8CPh6FsqGczkbfguQChsvC1Vu8U
         rAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094628; x=1769699428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALflICnLm9dAF6K/Wk1dDN+VobBIOAmN5UmZDdeZ3Sg=;
        b=fGH+pxl3/Kz7vCXX0+qKPdmfmK4UtTvue70SR7zQH3gpd60Xl/zL7z7nZoqZRqPxNE
         QLy3JvlhjBnyE5Pl5yJSU3TqL1iezv1rXOfGJhfBDpSTXwgf2vfGggX0Jtjv6ha1Ja0T
         YA9AW+y4dXIXwV8eSGX5UOv63H2/MASsevyZiK+/dYW+Aoahetgl0WkhOd+lGYUnWwyd
         gXkylO9hCOfMOZWDol494d4HjkdWTF6/ZXjJT3/ObsVvKPEcyzRFzUrmdjobQLhbJAa4
         bK9/WePCpS6loGJCsp3f9Agbk7qEJPhNHrA4Bnd2appUroyKBfwy/kC6oCGmeYVCor7j
         9FCA==
X-Forwarded-Encrypted: i=1; AJvYcCVkB5O3d0YBgSdn6nX+wbfUZpOBUr+n1zzxahOO3nEJTLNUBN2gfcd3WLK3GvKIrfYRcuGU+taYkuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1MupJ2XPm2cC7166ceBL/g/h4sYsg1EaANQWdg035d3WSVfOv
	l8RXQbnnZlUfQiPREJOh5qekOA3cw8RTV6a2aruw04J3QydCgjtuaeBmLIE+4hHTffk+RJK2JPp
	LzKTkdcVxUQYh0WFqLsT32FzPJ+I+EoeBoVvDicGbvqRB/roV/r4F3Ui+2BxMqYk=
X-Gm-Gg: AZuq6aKzsQy4W9gRrnnBFvLlKCMKlo1DxrW19Vo3apOxM5C/GVpu3ar6z3PlYnIv3ra
	KMFLYeUnaFS8gecPqO1C6Xbx00okQkIk9ETPQka833O1OonKnkaorTdv05tQLkXiV6TN78v32F4
	BGt1V938iiDcX5rx/QQnARVX9y1vkW9gOTp0B+kphJzrM1+R6FtlkJY5/O41JO61DYzF9bYbEBy
	kTKL80ijVwXrC6CaKN26QluizqGwBfOl1KhCHIW/fgcJaELXIBhEJ+6Hl8hR1Ci8YElBe7DjILK
	hLRMKWej6SiBClWAmIesdmMsS9wFSP9refS3d65uHSrrs3HS1sCYb+Yn1ePaId1uSdvfDkKvBTG
	m0te7KN+x/Dp+NejquenadN24Ils2o79ilOOa3/5+gdk=
X-Received: by 2002:a05:6a00:4b0f:b0:81e:a17c:b439 with SMTP id d2e1a72fcca58-81fe87e9f3dmr8191830b3a.27.1769094627766;
        Thu, 22 Jan 2026 07:10:27 -0800 (PST)
X-Received: by 2002:a05:6a00:4b0f:b0:81e:a17c:b439 with SMTP id d2e1a72fcca58-81fe87e9f3dmr8191782b3a.27.1769094627030;
        Thu, 22 Jan 2026 07:10:27 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8217c258fa7sm4328182b3a.17.2026.01.22.07.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:10:26 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v1 2/3] spi: geni-qcom: Fix abort sequence execution for serial engine errors
Date: Thu, 22 Jan 2026 20:40:07 +0530
Message-Id: <20260122151008.2149252-3-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
References: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDExNSBTYWx0ZWRfX9venL2yKhZUD
 zbsXukY8uez3rOfvqpZ43X+dC1FxUDMyMh20ivRGOGV25qW6x/rgIv/bq7VFZk6s+m4WwNq4zhS
 dQ72bK1eij2I/hfH+Y43WMwHuhl0g39tFrkXchZaBHQdQVYfAo8tkZGu8W4lsCLD16C0VGAHWoo
 VMOnF9d08zPXTLZE0kWBTYGlDdaoD3Nob0pP+9K2ZFkz19yYNeZ+kTEBpKjhuaYtSWMWqIbRm61
 QlmCPBkCL01TbNBYofyuzaAtdP8evAbmFPLY9vo9XoKxSZt55tNovK7/0hOUsLuWCCu10m7DtGE
 OVo3Khamg9e6adUFRS6IfmAr0tVm6nWzg9HDd1vKeH8wxNvHOHNlxL1JTljS+Xk8eHvzsoxPOuT
 IyHyB9ruCA48q+OrCSjd5kck6Jpic8BiuTsVIt973gNtCKUdGt7E9/ZFCFbieHRtjGnPGBv4kbF
 93D8mtPeWMjN3e4pFVA==
X-Proofpoint-ORIG-GUID: vgUPDU4jZwXXnw-tFgXDvLD7rgMzHBXM
X-Authority-Analysis: v=2.4 cv=UOjQ3Sfy c=1 sm=1 tr=0 ts=69723de4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=PwoySFKYIoUPqChjOH0A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: vgUPDU4jZwXXnw-tFgXDvLD7rgMzHBXM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220115

The driver currently skips the abort sequence for target mode when serial
engine errors occur. This leads to improper error recovery as the serial
engine may remain in an undefined state without proper cleanup, potentially
causing subsequent operations to fail or behave unpredictably.

Fix this by ensuring the abort sequence and DMA reset always execute during
error recovery, as both are required for proper serial engine error
handling.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index f5d05025b196..e5320e2fb834 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -167,7 +167,7 @@ static void handle_se_timeout(struct spi_controller *spi,
 		 * doesn`t support CMD Cancel sequnece
 		 */
 		spin_unlock_irq(&mas->lock);
-		goto reset_if_dma;
+		goto abort;
 	}
 
 	reinit_completion(&mas->cancel_done);
@@ -178,6 +178,7 @@ static void handle_se_timeout(struct spi_controller *spi,
 	if (time_left)
 		goto reset_if_dma;
 
+abort:
 	spin_lock_irq(&mas->lock);
 	reinit_completion(&mas->abort_done);
 	geni_se_abort_m_cmd(se);
-- 
2.34.1

