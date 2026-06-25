Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A95258EE9
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402981; cv=none; b=uMzVCbDBc4WnVF3f8gC4B0kYr9jQPe5iy3fnAv2+C5nTsLNQ2VAcB41W/XHdIRk2T7sLowsytxcwLJm49qG/JpSz8LYMsBwzOfSp23ZqSnRJmEpi+3R12LwqEWvPag70cLGWVTeak0mj1mrgXcm2bMvGl8oCpv/ZLvkps5ENsc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402981; c=relaxed/simple;
	bh=Qg2DWASAieOm11wQczT1rsri3HzntJrGim/Ejsmsblg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Dffkbz9qcF5UlylRC7m+uH4TrPpeSI4B5u3zktuNWAGD/0KAxnCo0OR4MuyrvWK77Dd9BgmyDU9fKXS5x0x3lDM7mdZRx/y5izOD/MCpE7SlHlHcs1fz4RA8t3ULqDYvSDNM+1l20x2USd+Su8mnPw4hfm3T925KNTcLHBPRzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QYWWU3yf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hgw4OCd7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QYWWU3yf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hgw4OCd7"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PFen4P2544307
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 15:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=t9Nok5MFqNfnzbr0sc8Oz3
	wNmGbIKAOcP3OgZ1/l6JM=; b=QYWWU3yf1l/m53cHK2jftFbddNvRW6VsYlbWHW
	QxGfTwhJTKXccHJwd4xnK8+Tw+zqvDDQvBaJSns/aJOIqPi1Ja8brp0ATUwcDL3B
	2E1EUfpRn2DL7uLfa9FYg8WEpwvdHHBbhk8ayuWvjM1jh/2sxUOh5/cUFi48RE7P
	54zZfhBLct1+FFfFIpXZSDA4GVi3TS/zFl0UqBZ0fajZRko/aHvMDQqD72KTPlZ5
	SogXgXK/XlD/1hEDQfO5TPev1gMvs9dwcceG7wk82Y+fIw7fJWP2iMVhVpKwbbjT
	roJL5Wke/Da79mRavEXSTeVvvxKPiQAsliKWq/b9A9DL/9Xw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q2mpe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 15:56:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37d4f23eb37so13161a91.0
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782402978; x=1783007778; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9Nok5MFqNfnzbr0sc8Oz3wNmGbIKAOcP3OgZ1/l6JM=;
        b=hgw4OCd7mEkqCiEtAc3lhlTVmhbHBZk+k6bsUjJgQvTcSCJxf8UhR66i3J9POGgH52
         ncaUI1C2p+1lCJ2RxlkTlYX/+SVnDsA7h6IRrPu9OHv6A8mt/e9rkN6g3oUKx08D7r9R
         8ympDAI+O5dAHT2hw8Z4vGiF7SmXxGsUUaqk0YzUn+n8s6jTnDaoRVE67dv3j3CwXygO
         r/SfpdPQFU6yFDzkqy7wTx7e2A4V1pYmz9JZ8vIVi929FCkxB6lWNDvK+6Qc53bKa2mN
         VMlyjd1J9jzdX3eRmVtOPs9S6h8GXkWHSuf6nQHSOV1ywIAsS+OAZOs0NmAJPQpv2tpj
         RhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782402978; x=1783007778;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9Nok5MFqNfnzbr0sc8Oz3wNmGbIKAOcP3OgZ1/l6JM=;
        b=AkdND7ZoYQwMFph1MJeRD2jROkdghJgu90ujHdJebmlsEaLf0TA7ATlANuVBvGM0FP
         kZfLf7lSrMbQNUe7VmJ2GePfmClL2hHLt9Dx0VIY/faEsS091qNu1izh8ZVzQiPaWdWZ
         s3zxgDM9B/ybddn7KIRfBQjblkr+cij19rvtJoTRKIMCcvpV/Hhfzam2a8jknpDhfp9z
         ZYQNbxMsS1dGM6buqm95u1fCVUOqbHt3uSgTCKZgviw5kGvFk6x7oCq7eLgif/m38dZg
         01wcy6j0Dk38wpA+8AGIh/NB1ipfW9RQIBGLYYnxL9CShqdnfIrRJ5evjZAqFgXvwOPd
         h8+w==
X-Forwarded-Encrypted: i=1; AHgh+RodagUFLieM/1FjSOOEDxKXeWK1nJiGHo+h1SUGAkWP+EdYpJmnvOwDqtvjAIq0IuzLCDrszhgJP8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrGcoNXk+Xi0/ZuDoPKezFiokrU/WYUyD0/G6MtU7TRTLelmq6
	cuRg0AmOLM1QT71AqQDeix2e1mX7EgL5MqoRu3j+DxbQ1YHcPhlZsbB/OB1H4tj4UfCBN4Lu7F/
	0sGYnLb94HRLy12cfXxn3Z6OEBUc9ZiabxWe4/RgtaCqLt5PUjFPDrCszhrHQ7x0=
X-Gm-Gg: AfdE7cl1VsQ1gQ9SjRCtyw3xSamFFANjY83z2YOu3Elu22LnPxzmhyykVzKn/wnmyGC
	inn7sN12QVGb09xHmIYpMC6juXIHwguoxCAnkv8QyFgMDpmBFk38x26BoSuFcW1U99gC1qsXVIq
	Z7Wa/5y9hprN5eFLjjo5qtQcm2OnkTj7B+raPOFjHXfNkKRstnJcCEPNxop5dD8xzF2gsglEoen
	wlBrJViHTxf37Ik2W1G/Y6Pb+4ZdnpnkTkBq3jUAuWwcQs8Jj4MO0c18ZhuY0O9+JTyB0v7TYs9
	Uf0NgW8NKAqPWrjvLkiTbyi0lWqO7g2FEWlNVapay1h2GMK37Mz6bZG4JGQM1/L6BVt2zlYd7bw
	CFMS/ePYGR7V71y4ZKO9VpfH4TzNCDiFLcv0oczZn8MVk
X-Received: by 2002:a17:90a:d005:b0:36a:fcf5:64bd with SMTP id 98e67ed59e1d1-37dfa18f2c5mr3104226a91.2.1782402977578;
        Thu, 25 Jun 2026 08:56:17 -0700 (PDT)
X-Received: by 2002:a17:90a:d005:b0:36a:fcf5:64bd with SMTP id 98e67ed59e1d1-37dfa18f2c5mr3104193a91.2.1782402977006;
        Thu, 25 Jun 2026 08:56:17 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df4127356sm2106212a91.17.2026.06.25.08.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 08:56:16 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 21:26:02 +0530
Subject: [PATCH v2] spi: core: Abort active target transfer on controller
 suspend
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-abort_active_transfer_duirng_s2r-v2-1-1d6f724406b6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJFPPWoC/42OWw6CMBREt0L6bQmUt1/uw5CmlAvUCNV7S6Mh7
 F1AF+DPJCeZzJmFEaABYudgYQjekLHTBuIUMD2oqQdu2o2ZiEQe5VHGVWPRSaWd8SAdqok6QNn
 OBqdekkCuIYWiKqscCsW2mQdCZ16H4lp/mebmBtrtu3tjMOQsvo8PPt57P534Q+djHvMiTSpIs
 jJTbXGxROFzVndtxzHcgtXrun4ANAuRw+kAAAA=
X-Change-ID: 20260605-abort_active_transfer_duirng_s2r-ce4e79896e7a
To: Mark Brown <broonie@kernel.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782402973; l=1533;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=Qg2DWASAieOm11wQczT1rsri3HzntJrGim/Ejsmsblg=;
 b=kFNqq9vy7xxsqJMS8fbUkyiJ09h2xFvRsqZpyCmhhjlLz+pUi1/+sMb3/5Sdj2qRlddfMH2vG
 PSOz6pdTLkcCCsoI2d40oYUpoZUyLyFay/4j62ji2C3H2dvr3vOviEX
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: kHKfm4ZK5s0rfImdHuMB6EEoCDbiUvMx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEzNiBTYWx0ZWRfX2wHGVrfm7RzA
 ArKQ6fFqDpi7GHXZ6DMqOg84px4E2BsxUmgEBN5cM/jSQKP2GmIWVZGjjxcu2U54U4PoDgqFdI8
 EfgVR5YiIQ5XR+cgt2j8UFlLC6Jx4pA=
X-Proofpoint-GUID: kHKfm4ZK5s0rfImdHuMB6EEoCDbiUvMx
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d4fa2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=XUkRz5sAuzcGnk6uUTQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEzNiBTYWx0ZWRfX3CD2ZW+hte+t
 c9/0WdK+WAAMjPUi9JtxCFjBAFHpb/Rfia9fENU1ylQ1SzeMWribGvaLvtfXB3/wG/7VVFYVaeE
 iGRQPGgIORKO2BgtVoLrRPQgqnOwM0pnxorKeZT3sv4SrsBJjHlOiYIZTB6oQmnNej72j5b5me+
 iE29L/8411IdV4lnSR3SvnNi9h5znzeA1QXI4ahifZAZMaPUmsN+y+ilRo3WRDCgS/BjDGF1Fwp
 Mzr05VT7/Qt0s32eiLLF0n2kB3GIY/TA874ej+Krq/MTmouvd5Cv0MKIhfNjjEYl88KwcmYujJU
 CdEbIw3M5y+MD85Vxoz0F84UAoTfQKsOthQGq7SLSxRR/sGLnXiZkpPTp1nUqrVEY/jZBpm1isd
 e1nQwlaXgVvttFBve8RKQ3uADnhXbi7pjJRKKPeHGLno7J14q0Wsh0hNjdKkVcEMpXj8GVQ9uj3
 BUoIDFDZodEQgQ+BJzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250136

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
Changes in v2:
- Added extra check of cur_msg.
- Link to v1: https://patch.msgid.link/20260625-abort_active_transfer_duirng_s2r-v1-1-7439e3585ad7@oss.qualcomm.com
---
 drivers/spi/spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 76e3563c523f..e9e68e2c97fc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3667,6 +3667,9 @@ int spi_controller_suspend(struct spi_controller *ctlr)
 {
 	int ret = 0;
 
+	if (ctlr->cur_msg && spi_controller_is_target(ctlr) && ctlr->target_abort)
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

