Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8535BDA4
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123685; cv=none; b=QQYrgFVwtd4mBi5qfLCHpKgUQ0XtSiVR6tEr6F2fEe8SC3A9f0IWxN6G0ls+746iPAc2htyR12uunmjblcY/DfIQ8atn143Zlc5m6TZcsgY3ihHHIIH0XImNGo1pbua7LP1FTK2pR+IEhvxBATb55SSreOMu/E01FUl2v/E2r3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123685; c=relaxed/simple;
	bh=6masZgFWLsY1wGZmtQvxBGszzHLlTwVJbZ6sdXDkOsM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QVeTDa6wLoojZg56b2L9CxujWJNGF4HOHBtzTkzOW8S8I3SdiGdWXHXWLk+97ZHHRi3/xs6v5aiOD/Nz2TAgC1rmKcwm6sf8JnDxN9b7BtBNVLBk+ysjPB4AlXVtWQZSP+63UJYgrc8Av6jKikjsPS0FOf4efvH1DNrrkeKTljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LuyMlTW+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FgPaWM9k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LuyMlTW+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FgPaWM9k"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IE6Ump353070
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 17:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GgyL6RTmFW5Y2UChe6AMki
	GlndhNLcMHYwQDILdaz5c=; b=LuyMlTW+lbGX/22M05x3nUf6g9ExcU4Hrgzpk+
	rPZYWxwgTJt7Bgn2qBhK/Vub5pIi8yTorAiTvoVCMyCaG2sgqFNpbW9xG7iESe7P
	eXIvlwLSp+O05pu21SsOKlxRjvVevzy7gdtAOAmgxzQvxFE+KmuT0Yv+WFXoHdK9
	e2ClmNEac9hWKDP5qOygGqF7rd+ddWBBgFfAtlhBojXXkY/FNkCHoxZurO5WOMct
	oRPDzFGGMpBlsM8v7IFar6rraKkBfrDGrekFrigOhQHPbntLirZRqG1oOZIROrtw
	EKkMkuQ8sWn4mqV/xMtDQDhNDjQ/b5BqoZTnXQRlShfFiGRw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xjaj8gs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 17:01:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c827bda3052so3942013a12.1
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 10:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779123682; x=1779728482; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgyL6RTmFW5Y2UChe6AMkiGlndhNLcMHYwQDILdaz5c=;
        b=FgPaWM9k7/NFO7j2uquU0yia3GiiMp5yACPoLCryQKb1ciqoedl5IkXjlh/NE9WqNe
         3xvYz4Y0Lf4NrEGQEbN4lulkwwdb21uX+azNogd7gWPjf5Xr3YYEaz1FjKBDZiQ+WPGn
         2C1KCWf5mA4gsVI7aEJUEISwV0RxSGDUBzQlE1OsGjlXEySu/fyHcYspBPuPiCdIiScd
         vcXzzL4sZQvSRivlZmCa9oqnyjo5c1i1LU94NHDqWtQ5K5uUnLmFW7CfiMgNzcIgEwq6
         OWODfglkzfmyfAhRAFVwxeSPq948rVMzV1IipcyEWKFjkx7FppidVao4YeSodAWKEO1g
         5nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123682; x=1779728482;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgyL6RTmFW5Y2UChe6AMkiGlndhNLcMHYwQDILdaz5c=;
        b=SJghwyioh+iohyuRj1xnIVuXhKtolzsNqLVMVHsRu1hOiJgDspIPrfaxiOeYz85xeH
         ZDz2wCqtUrnPaG1XHppAXwEHFbA3qK4u4G37OlNi7rAGzwGL7gV4NWaVLFmlVI+LYl1O
         9GLC9v3Jjar5tcmWuMKkgTFUiE+pNHSQLv2V8ofPNxEru9kuWQlppc0jpirOYcYutE7o
         eR9/H4lqdLmRFe4Ho0qZ+Qy22GwX4EXKW6QBET685hhbCXaOVXhLcesRYxCL71YB2VhP
         h6IEOmpFYIwKMf80ntYBSNZrv3CNIklGIddK3h5RfHCnhO37Lqbzfyau+E8qeAT+PaXd
         UvPw==
X-Forwarded-Encrypted: i=1; AFNElJ+fcGkZF/DcqiqJdYNUdWUcMwtR2x8ptRIOnghZD4tVQm7SQtOoT65GUPHCeJI8HmUwiGID2lSUa9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqwnbm7x3Tvmn6sIVZ3p7I2D1NS5gjogn98mtsPbhlt4a2FNx4
	PX6q7+WxvpTDDv8nFLdCTdBOogwtHottCouZh2yHrzjNJD251I2FFj9x9AGBb39LuBdC+HT7S2K
	u+Q9hjBkV5y5OKYM7kLlYbS733rY4+LuV8ninK1btts/PTSBdf65qUBFXfaauLkw=
X-Gm-Gg: Acq92OG0g23Lv3lgh1GoAxv0fHQjhCjEEqnd5lFBIC9ZGIxHCoU4T6eT1M6bEM2eP9Q
	F89+7AwW1Jipq+mO4YQxpIK5+sEU3JDq+dIn0Q2ChjQTcMikDYMYIeWdRsQO2o1fpP3sEdenrdT
	7s+6aJ6fDNRdsP26C6tIWLLidCcwGlFuN076wu5jRaCk/YS9+ubsS6F+MEVNZu+WvVjZjxtvJr4
	LjMbC7WBlQdjheRLmsLuMQpBLZ4LjsghLhBIUo6+kyKodawmQFxhjANz5Dne57Gl0FANo1v4s6z
	+C9WZLYx1V+t2y/x/R75j8fWxUhCENnawoYTmc2zoL+ONCn2dnh4faqWIGXKx+F26GY5G5vGmbH
	vlNTkLm30aTQYWWBuKArirraQz9Yf/4w7wadVydPEC/Qm8GwqowqjGJI=
X-Received: by 2002:a17:90b:2248:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-36951c97685mr16139263a91.23.1779123672769;
        Mon, 18 May 2026 10:01:12 -0700 (PDT)
X-Received: by 2002:a17:90b:2248:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-36951c97685mr16137814a91.23.1779123662967;
        Mon, 18 May 2026 10:01:02 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695652466dsm5783808a91.0.2026.05.18.10.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:01:02 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Add trace events for Qualcomm GENI SPI drivers
Date: Mon, 18 May 2026 22:30:50 +0530
Message-Id: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJFC2oC/5WNQQ6CMBBFr2K6dkhboIAr72Fc1DLAJEKhxUZDu
 LuFlQsXupnkTX7eW5hHR+jZ6bAwh4E82SFCejww0+mhRaA6MpNcKp5zBbquYXba4GhpmD001sF
 kbA8tDgR+JMBUZHlhpFSFYdEzOmzouTcu18gd+dm6154MYvv+Yw8COJgqBhoshKzF2XqfTA99j
 7M+iYdtkSA/xEL+IpZRnN5EmXFVommqL+J1Xd/iYFGIMgEAAA==
X-Change-ID: 20260506-add-tracepoints-for-qcom-geni-spi-e31457c2267c
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779123658; l=2659;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=6masZgFWLsY1wGZmtQvxBGszzHLlTwVJbZ6sdXDkOsM=;
 b=ofnL7qBGmEtascjrH5VLMbmyqsyIludaIGF85epr6GyAE/f1f2Se5CUX+xK14cKZQBkSMbwx7
 aUKHwQO3ROQDj/7/WO3TYUkklPydqQxVytX4ETTjDYaKHYTEH0AXlyk
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2NiBTYWx0ZWRfX7X/R58dGbphH
 LCUvl0G2MpwupP46D7iaUtRyOa6v0F3u+mjGC0n3ykd75+c1xnIJhCiiX9iUrnle9KZzxMkXTdU
 xWDwm4K/1ToN1w4afzFfIWZeuQxTc+scBxR0x2q9J9W+iEeIMrTyvS+XO0ilCPQRdrrEFWlwMdb
 o4Va5pu5UxjAiVrAZbPywnde4R86VtgFitbE/OUpTW1fcGfAyIGaxl6ftIEav5FoNQwuVgqltyi
 UfP4QZUAeAFZEK4O6ZYK1eBsAnVsct3D+Tgk0THy+MDtxrieu0ZbFp/x50w6SvExfInIvcKsLGa
 Ltfe+PC00rtF+3KHbQfKBPRRdUszZoGSI5nEVdCsjv6T/YM0LC8+R+OqOYkx9NS+/0A0eZJoF7X
 V3tpSXVeZ2jCR5Y0c5680d2MX5BUyfzq3vkFbAB3BSX+Z9pxPJHEgHky6PysYc/+ZUiZw4T2Vwt
 NLO+6wUEiyR+YwiPS5A==
X-Authority-Analysis: v=2.4 cv=BYHoFLt2 c=1 sm=1 tr=0 ts=6a0b45e2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vdy0y8WXZQco5u0MrGUA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: UDwOB6k3X1TCm0mVxxWa-yPNT4pYkw04
X-Proofpoint-GUID: UDwOB6k3X1TCm0mVxxWa-yPNT4pYkw04
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180166

Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
These trace events enable runtime debugging and performance analysis
of SPI operations.

The trace events capture SPI clock configuration, setup parameters,
transfer details, interrupt status.

Usage examples:

Enable all SPI traces:
  echo 1 > /sys/kernel/tracing/events/spi/enable  
  echo 1 > /sys/kernel/debug/tracing/events/qcom_geni_spi/enable
  cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:

1003.956560: spi_message_submit: spi16.0 000000001b20b93c
1003.956642: spi_controller_busy: spi16
1003.956643: spi_message_start: spi16.0 000000001b20b93c
1003.956646: geni_spi_setup_params: 888000.spi: cs=0 mode=0x00000020
     mode_changed=0x00000007 cs_changed=0
1003.956647: spi_set_cs: spi16.0 activate
1003.956648: spi_transfer_start: spi16.0 00000000ea1cf8b6 len=16
     tx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
rx=[00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00]
1003.956653: geni_spi_clk_cfg: 888000.spi: req_hz=20000000
     sclk_hz=100000000 clk_idx=5 clk_div=5 bpw=8
1003.956691: geni_spi_transfer: 888000.spi: len=16 m_cmd=0x00000003
1003.956708: geni_spi_irq: 888000.spi: m_irq=0x08000081
     dma_tx=0x00000000 dma_rx=0x00000000
1003.956717: spi_transfer_stop: spi16.0 00000000ea1cf8b6 len=16
     tx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
rx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
1003.956717: spi_set_cs: spi16.0 deactivate
1003.956718: spi_message_done: spi16.0 000000001b20b93c len=16/16

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v3:
- Replaced geni_spi_fifo_params with geni_spi_setup_params trace event.
- Updated commit text.
- Link to v2: https://lore.kernel.org/r/20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com

Changes in v2:
- Removed tx/rx data capture since spi core had already support.
- Updated commit text in patches and cover letter.
- Link to v1: https://lore.kernel.org/r/20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com

---
Praveen Talari (2):
      spi: qcom-geni: trace: Add trace events for Qualcomm GENI SPI
      spi: qcom-geni: Add trace events for Qualcomm GENI SPI driver

 drivers/spi/spi-geni-qcom.c          |  13 +++++
 include/trace/events/qcom_geni_spi.h | 103 +++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260506-add-tracepoints-for-qcom-geni-spi-e31457c2267c

Best regards,
-- 
Praveen Talari <praveen.talari@oss.qualcomm.com>

