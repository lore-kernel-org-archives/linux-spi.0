Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5B21A453
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366001; cv=none; b=aDlgFXqssgSayhxCvLhF07M/1Q18Sd5EpTwEF8o5leAOeaJWUrNphSe5kKPWTXoYei9pzx0lPBVfpgweIQt452ESsAHgcXdkE0PTy480w0ErEDqJUe/nDtTQgeNCNMHH2hTr4gMJt45NdHG4DrqkPGlb300ABVhHLsP86jR4gmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366001; c=relaxed/simple;
	bh=WwZpJ4qBLy737eyf1kgXyhTJOquhD0FEELf75mr6mcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nZ2G1hGIEsIQ++UV9XWPtlxcFhr/UWb9yUd83rQ8VE4Gc0ck1JmMA8EJYCt+nICtDe+HCJruG5kYpSx8A0z3Ua6Re6L+R85LecGHmTzQdwBJLBdgMp2U6zuzFWJPS/k14k8nJejXZhf8pHKIgOHqRe+4iBKxo8cxX6E0Z3ga2kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IlgfTr6O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bOFQKuoo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IlgfTr6O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bOFQKuoo"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3eEa5904482
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 05:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ezExHs67ZowB/e0UR8RZrk
	Y+B+ErVvkQTBeAmwaZ1pw=; b=IlgfTr6OyGRlQRyFblGPuEvYQi5qJdn33V3oTH
	feJ05BNqQnHkduNMN4QqBU9r3cg2B65LfWNK7LHoeShn3fXv4jtdpZCHftzhv1vE
	GcibpHxsaY54UzGqsmKLQJNhZWL5bkECyrtc/8hanYMJ55HeeVhhcIwCis7gNeaZ
	rELzwQA7/63zdK7irfapIQrDUUByyjiaejYt2r0V7RuNB9IETt05rTnp0ytzVkNo
	OdxFUmi1o8hczTXoOc0QoyG10PziXoxaei6t5qxnVIcqmFLbm6oMRs+Yn3J/IIdu
	lpMjVwlLWYdhHoGlFUUWmmb7qOruRinIGryNrVreAKqRpHrg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7dtrd7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 05:39:57 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84534f17866so1652688b3a.2
        for <linux-spi@vger.kernel.org>; Wed, 24 Jun 2026 22:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782365997; x=1782970797; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezExHs67ZowB/e0UR8RZrkY+B+ErVvkQTBeAmwaZ1pw=;
        b=bOFQKuoomhE6eDx7Y34/laU0WXR80Y3I6FknNX8Dqt8kpuJF2dsFrAywdEd2WxDAAN
         Z1K0D3Id15/+I7UBQoPZtz3jH8bHwBdzgB6SWXZf3XA03VZlJW+cy0KkwoVn+rHG5Cb5
         9sWdy4z+lhFb5X8afnk153lVngKisBZtkV9O5UZ9tFM8vo+8NvEAGuIaUbzMWly4zZrl
         Wf8S2WY4kHtroFIuE2O3E7e4dxQTkY+9xTv1NaPGz12Ru695fygQJdTLSPhOAWR/kMYD
         14iDmN42Iw6CfI5KVszJCGVdWlyWZjOWtbk7yqI7wjkBZhkcM2Lo2B4rI36TqpbpsYHL
         HbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782365997; x=1782970797;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezExHs67ZowB/e0UR8RZrkY+B+ErVvkQTBeAmwaZ1pw=;
        b=KmWhUVeXhkWVUJ5gGyq0UWgTcL4u2lX3P8+a3l7lXsfyuKrL2cbWKFL2yM7ytDayU/
         RNRgIYgbIvAH0PGHOfU6Z7yNi9c+vMwXTGExSfMLfKKmCJp6p3hEtxnlm+mv90f8IbC6
         8AbdlwvwOYVNFWhpBPybZJDp3NS5j++ennsQq/gbcQ624EG8e+t7QunGSTbJbNDIJPU5
         51a1jdLwGKC6zUWqsRnAJWGGdIAqX2i4G6Ynvq71Rab5lPKGKfQ8FPEaDzc6kPWJ7Q40
         b7HlIxDG1KTb4sDEwiyMktgd223rkMnB5tY7k9tOvd3zMBx2Ohuf/BCCBVCnQWL6zjjz
         QaIw==
X-Forwarded-Encrypted: i=1; AFNElJ/dn5Qu1l6+vGe0MmjHKD75BymV4J/gI8D4fAjznevO2lsuUE7fajtPFdAJ2bdQEsW1xmc4ctsA4Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxazJRfzufqqC3io+g9A4bcSZTV0Z7N1ImDMZHbmHVR/zhwW8/8
	RpVSX5hsmfVJjESPKtZr9ddKU3sI5hlKa4kJpz+xSMDBeDatk0ihjPHCYJuXb+Uhqf3eWnDouVU
	N7XXLldtUcTU/2uRQc5/a6r1T4aw5JAVReTUqd3HD52dyoMXMmjMbSVlb31Y4Wzk=
X-Gm-Gg: AfdE7clq7CzE8S3P2gPRX46/cAHHRNDV+QIErMfOtHlMn19/pcSb+ro9PsaJJDV46kb
	xzxc/z69cqxGzPOrYb+b0WGRqesTu72WLJhpIwdJrVjqJPBHgwQyRWheiSRXUNUOY5HjM82OoEo
	jsiOCd8bHC4B6AvZKw9PgNKxQPssGOldaadEKigIjNycS0JrSr+h8MW0X05A6L3kmd4OBhHHuh0
	LvMEs4SwlCGjxJXN2rYNLT3Cfe7nOpW490/5FmKIzXaMD3u0LOYxfj000BTe3E6psMvXC/69hpT
	kEKRJIdFDOxc7iflSVcMPz6nL/KZvSqLV8KCzrVhBpqOUo0cNPO+GKqRRp0T5vXTJNoANV/9HKE
	wc+HSxGSCH05sjpr15pLiOr891GpumV6yipLf7tkQmEsU
X-Received: by 2002:a05:6a00:330d:b0:842:7476:2376 with SMTP id d2e1a72fcca58-845b3b0024emr1736306b3a.41.1782365996793;
        Wed, 24 Jun 2026 22:39:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:330d:b0:842:7476:2376 with SMTP id d2e1a72fcca58-845b3b0024emr1736269b3a.41.1782365996202;
        Wed, 24 Jun 2026 22:39:56 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fedaefsm4551534b3a.23.2026.06.24.22.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 22:39:55 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 11:09:35 +0530
Subject: [PATCH] spi: core: Abort active target transfer on controller
 suspend
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-abort_active_transfer_duirng_s2r-v1-1-7439e3585ad7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABa/PGoC/yXNQQrCMBBG4auUWRuIQVPrVURCmv6t4yKVmbQIp
 Xc36vLbvLeRQhhK12YjwcrKc644HhpKj5gnGB6qyVnnrbdnE/tZSoip8IpQJGYdIWFYWPIU1Il
 JOKHtLp1HG6lmXoKR37/F7f63Lv0TqXy7tO8fMEYNQoQAAAA=
X-Change-ID: 20260605-abort_active_transfer_duirng_s2r-ce4e79896e7a
To: Mark Brown <broonie@kernel.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782365992; l=1345;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=WwZpJ4qBLy737eyf1kgXyhTJOquhD0FEELf75mr6mcs=;
 b=ytdW2E41EoFVe/wMqKAmLhnemRvaDDBbvKrbVVSAMcanoXtH25OhMCpXDiOrwI0TgjslOEdGJ
 PyF2jPLaLrICuSdLiyy0GzmawDJ/l9ggTUk7XSm/CvQ+qCWMX857t6f
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: QIAVP17xKu99sHHnmZlnpdqD6GymLfz1
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3cbf2d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=XUkRz5sAuzcGnk6uUTQA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA0NyBTYWx0ZWRfXyhxnFKpmorMH
 3BnwcK06xxDZ9FBxGH7k6DPgbuYq+Pb0cG+EKOdhDYgvyzdqFKYP3oTVOl7aolIGRFilSbWMeXI
 YULk3ORBBW/+YdVLHb4tMt6iSG6qB3s=
X-Proofpoint-ORIG-GUID: QIAVP17xKu99sHHnmZlnpdqD6GymLfz1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA0NyBTYWx0ZWRfXw1VDtCfieGjd
 WG2dA7j86j5djjvAQBLGWHoryqjHDhcSUPkPMrw8wMEY4A7AtiOsIR3QoWHWfaEsliDxE5KuvGO
 SonKjtB354NtuOdWM4N6/tmIK8dWkr0AS2kjOCB5lz8wRVwkhBPtgoIQqJIN5+24mqvDwUIHI2X
 IgKkHbY8QcuL/OdQbSOO0CBmvKA1ggInBzBPl14S1B1hjuu9HJgjEUbuc+3BVp1HHZgmzCwydr6
 nXvCsjM//Lk69/ZUvORUyNBKOcGmorqYx9PZRNdTPnmC+/gZpF67mQ6MGW0yOIu938Cw2wlWztE
 qI7VmjfFFC3wI4esc+C9vAdYvbkYVwonOKmDNxlrx0nsLOIcVItoPbKspZ6+TRb3XiftxU2Ddh8
 nYfhHty10VQ54iZIH7ptOOan6OfSK+61IugK0xgKzZTD2eWgpY3KUhNWHZIplZ4tq79VNEoGTnq
 FstiqBxDxYDEyCHnvvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250047

When an SPI controller operating in target mode has a transfer in
progress at the time of system suspend, the suspend path proceeds
without aborting the ongoing transfer. This can leave the hardware in
an inconsistent state, potentially causing the system to hang or fail
to resume cleanly.

Fix this by invoking the controller's target_abort callback from
spi_controller_suspend() when the controller is in target mode and the
callback is registered. This ensures any active target transfer is
cleanly terminated before the controller is suspended.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 76e3563c523f..2a96921ca55b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3667,6 +3667,9 @@ int spi_controller_suspend(struct spi_controller *ctlr)
 {
 	int ret = 0;
 
+	if (spi_controller_is_target(ctlr) && ctlr->target_abort)
+		ctlr->target_abort(ctlr);
+
 	/* Basically no-ops for non-queued controllers */
 	if (ctlr->queued) {
 		ret = spi_stop_queue(ctlr);

---
base-commit: b99ae45861eccff1e1d8c7b05a13650be805d437
change-id: 20260605-abort_active_transfer_duirng_s2r-ce4e79896e7a

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

