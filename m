Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAE3F65EA
	for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2026 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336109; cv=none; b=CrxjIu+sD3R3Lfu9f/yq4QAhlGnjiqkjrXM+T2dUycPu4VZW2nFXq6em1nsjFm4ODq2y0KWHXhbb9+RaYNfgP5OXy1E8nOhmboShoacguySAWK9J/vk+ty/feumjRKx2oYrlD/wlmkoYmW7o5vOeNGrN6UaoAyMk2lKoVZCs20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336109; c=relaxed/simple;
	bh=cPvVMpFS+a7vYWIpXWCc6esoPLFFshgEOVvwvfroPHo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pqjw7IjsNPetXUurMYD5CPcqtE+2pvk6j+OW3z5fxDa2EcIXhpch2ShT7o+9tY/LrAsdxb+HBWjftDbwW+NPnEOP3n0ofTz7HO7EJtXpfABKy7w8ZY62Uk8OxwvUJiFgkXNNa9n9AC8aYceOGAnrPaDzgMCF7aUvhuuf6gk4wzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MjKtfZpj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JXfSBsVF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MjKtfZpj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JXfSBsVF"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxRgo402161
	for <linux-spi@vger.kernel.org>; Mon, 6 Jul 2026 11:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u4egp0FPPKQnFNDrmVNrFV
	WXSWZYqpj9JbKyoENR63E=; b=MjKtfZpjcvsaHi8zi7TAj0NURUgxkIDXWLBOWG
	JcFZxxkpO6nHhhszZSfPWeL0l9tuDOBU/YqdXyHskRfiXnEVh2j6Fz944fTLDUBd
	OLxVi/AQMoFhM5XA5CNoYSSlsL3+OqIoVGVraHCxpWpfUX70tM+WHpurbYsqgpCy
	KUo4lpMWplOLNGck265YYsqnrxIZYDI6mbJpxaJoMTZQYZ4xDVhakhO3JdLa1gwM
	5QH4VuQVO5kSPRIL9daFo1RO5t2JgjQYDVvj6WdIMO4SrL2x8Q34McLPMbPhGee4
	BCxEquYvIvvm5GSFhqlgwlPCjxRZYFjw5dTvEVcLQ6D6QiYQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gr95n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 11:08:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc86cab84bso17743545ad.2
        for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783336107; x=1783940907; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4egp0FPPKQnFNDrmVNrFVWXSWZYqpj9JbKyoENR63E=;
        b=JXfSBsVFI7NMQeDW4S3OMGsjHHnKJE2VROyfJQwaYtZ/h9luh95hQ1xeZ0ENmoUbXS
         qq8UCEt3DlsVovB55OPfz+5VrlBd/oNt4LkeAy4bOuZ29Cm7yayd9JH+Uf8kvdR17UxZ
         ZdQMPs4g6pHWbsjmWOeL6e0X2OBOAyaGU//4cMopEyRP2uSFUk76DkTzHL7jXdTn27CM
         syftwB6v4PMq9TMwXz8vF2XCJRXG1Qo+eof9lfx89PJHKgkjZemdXDhHeu0btgQ/JqiT
         3OSJ3txqkUZrPfWFiUm+mylgfwwjQW0seqBZ1QQXTunLMY8tZH2CRz8h1gJeiBQVordG
         Wwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336107; x=1783940907;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4egp0FPPKQnFNDrmVNrFVWXSWZYqpj9JbKyoENR63E=;
        b=RVWa1ENnsA69NHK0YkMlqGw7xIXxq7ZMOLGWHAykYCVrQ3yBDSdmAqNKZM/wV7ZwJA
         R8cdDvxJiZWzqfna7NCUnEYUxRB1OH4aPr1R1Fd6zj41hgtrPY6rqD2junz9gfat7CW3
         8SFP8zkF9AdfsZc0L3VAdpSNBjQs9z4qFYi+z3ZyCDYxlcBUyFWTYdQeMq7UWjiJrQv8
         VgP+wNRQYxgNPOYbslTdJWv4yu2U7Xo4RM24A9WUsy19zqvtPVKhr2uIqQp4j44+1urb
         ni+QU7hMl6xCgv4MXHmK38gdcbB5MCBNC9BhZG0anp9cQ6M5HxQrBSLEpTUdHMAZXuxQ
         Pivw==
X-Forwarded-Encrypted: i=1; AHgh+RoeOb7f5PQjt2y1mL3pRXxgtDzFTFLJRWyEkZMEHxwarZ1HG5vEYuW14XhqCjhvmx31AZcTkHkGxAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59bT8YrQVm6PeLX/QsVBmqCoS6qTM1bnuqDhSGwGjuqDU5tzV
	dbeVHjEdf8WFyZEbF/rjr/0aCdR4tPUav2ZNwqrT+KT1gQSYHevYKYzaUK81mPf0QTtwver9kuN
	mqkUQmFBIe9QnSfg5CsUvNmjD0WItHquCBIAnv3GbY/V5XbCfAKnPGTpq4XZ2B6Gx4nAXLn8=
X-Gm-Gg: AfdE7ckckjti6tBZ/8leSYCKfWcWrkGQYaI/AsvmxbA/L8CjVslNRbE4DvIpNb8HQ1F
	3+FNPMaW/VV57K7KgAD8yu9zbpTsneCwd78iXWoSGbjke8c5W4dW/karTkUSYlPizk1mT9VeY4U
	RbLZ+qVtLwZf0pTl7cV1d8+ZFphBZ2TEGlydeN86dWVDimWfI4kxL2qHYTZoWYM3u4zGsCnA0G1
	kMP/riu+w3N3ZMROVpxLbvS/6ruWuRmFb671eBA6DsM94zWb2Y8xBCNjdgwuGsgrW64XitD+mD0
	WWncTgLFFyvsJ7S7S0P234iTj5KiUFLf0weNKmYGFAyvBkI5dXDIIq7/Kx3KsDHXDX/T48NZ+qu
	BRheKLgntM/K/M1+hiFU8Nom2QVzUJfS+NtmX9VHWU9S4
X-Received: by 2002:a17:903:19ee:b0:2c9:d539:61e7 with SMTP id d9443c01a7336-2cbb9e30966mr98705225ad.19.1783336106621;
        Mon, 06 Jul 2026 04:08:26 -0700 (PDT)
X-Received: by 2002:a17:903:19ee:b0:2c9:d539:61e7 with SMTP id d9443c01a7336-2cbb9e30966mr98704705ad.19.1783336106028;
        Mon, 06 Jul 2026 04:08:26 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7871285sm47730685ad.64.2026.07.06.04.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:08:25 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/2] Add trace event support for GENI SE registers dump
Date: Mon, 06 Jul 2026 16:38:11 +0530
Message-Id: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJyMS2oC/4WOQQqDMBREryJZ90tiNUpXvUdxEZOvplRj86O0i
 Hdv1AN0M/BgmDcrI/QWid2SlXlcLFk3RhCXhOlejR2CNZFZxjPJ5ZWDMgaCVxonZ8dA0DoPhOC
 xAzMPE+hMV42uykIWFYsrk8fWfg7Doz6Z5uaJOuyze6O3FJz/HhcWsfdOW8nlX9sigIPhuWmFb
 iol8rsjSt+zemk3DGkMVm/b9gOudSwy5wAAAA==
X-Change-ID: 20260630-add-tracepoints-for-se-reg-dump-c2c8bc875658
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783336101; l=2795;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=cPvVMpFS+a7vYWIpXWCc6esoPLFFshgEOVvwvfroPHo=;
 b=4urCsi2Dzrla0uUv277UYeiWoYnJdDhamQMVKgtiN7YfVCXje2GrFWNbiz8X5+jDHgwESJHPA
 tn4uuXLU6+7AhA5aNEbQmJZFZinZkXzgwQbd7vYuyF570glAh5BEm0b
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: NmN_CBL40Iwp1z9Q-fPMaaYnl7IdAtju
X-Proofpoint-ORIG-GUID: NmN_CBL40Iwp1z9Q-fPMaaYnl7IdAtju
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4b8cab cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=U0NaQwEGjt_KokrWucUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX9QB4W3DLg49H
 jx98XcFvqGsytA/3yJ+WLWnCU+3ymvEzN7cLk5SIt9A8BnH8gBjXAGjC0+PXojr0BfKxeQh4vmg
 uRG27gtuvZghIHpOiPdRGMmQyqVLhK2Jrch0MQJu/u5ohbi7GOaW4QcXtEnWDXJtb92h7hpwzKj
 gohEXBKvIvUOaNyQBDVHwg6tJd8Oop9Hrg1pMIBqb22+hsTsmUJz8SbSJb0N+OTQafHnWjGuE2O
 bcWBZIzmmzLPI3/I+z0f9yrgNpOSJndZdi/bkv5SUX2brTMPBmaPaw34XMsKip+tFa+F0PDD3Kk
 9n0rtWV/MmzFEn72xy8Q1nUxCRaGJklQuuBcfbFcbCZGjr7X4gpaqDoeEKTvchzN4TZbbRs70ly
 4eVG7XpJ1RUYxCsZynKYJMZlIuCFiHLEjID9YLJn0KOeXq1v0/lC73fpI98T1NNGW5CmMz+qnP4
 LkAAHa2IQ8NDTWlnZhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX76ebi/VfQsGl
 0wvhoS5u/TAmP7NRl7BsG7E08m85GDZ1r0z9FNEJc3ZvLI0r/V0bR/3cm58Q+sFnWMKzUlRD4fC
 vVLc3mzS2XyEY0Q+sLNf17EU83uQXr8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060113

The GENI framework is used by multiple drivers including UART, I2C, and
SPI. When hardware-related failures occur, each driver typically relies
on local logging, which often lacks sufficient information to determine
the exact controller state.

This series introduces a common tracing mechanism for GENI Serial Engine
debug registers and demonstrates its use in the SPI driver.

Patch 1 adds a new tracepoint that captures an extensive set of GENI SE
registers, including command state, interrupt status, FIFO state, DMA
configuration, and clock-related information.

Patch 2 hooks the tracepoint into SPI error paths so that register
snapshots are automatically generated when timeouts or transfer-related
failures occur.

Usage examples:

Enable all I2C traces:
echo 1 > /sys/kernel/tracing/events/qcom_geni_se/enable

cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:
114.291299: geni_se_regs: 888000.spi: m_cmd0=0x18000000
    m_irq_status=0x00000080 s_cmd0=0x00000000 s_irq_status=0x08000000
geni_status=0x00000000 geni_ios=0x00000000 m_cmd_ctrl=0x00000000
m_cmd_err=0x00000000 m_fw_err=0x00000000 tx_fifo_sts=0x00000000
rx_fifo_sts=0x00000000 tx_watermark=0x00000000 rx_watermark=0x0000000d
rx_watermark_rfr=0x0000000e m_gp_length=0x00000004 s_gp_length=0x00000000
dma_tx_irq=0x00000000 dma_rx_irq=0x00000000 dma_tx_irq_en=0x0000000f
dma_rx_irq_en=0x0000001f dma_rx_len=0x00001400 dma_rx_len_in=0x00001400
dma_tx_len=0x00001400 dma_tx_len_in=0x00001400 dma_tx_ptr_l=0xffffc000
dma_tx_ptr_h=0x00000000 dma_rx_ptr_l=0xffffa000 dma_rx_ptr_h=0x00000000
dma_tx_attr=0x00000001 dma_tx_max_burst=0x00000002 dma_rx_attr=0x00000000
dma_rx_max_burst=0x00000002 dma_if_en=0x00000009 dma_if_en_ro=0x00000001
dma_general_cfg=0x0000000f dma_qsb_trans_cfg=0x00000000 dma_dbg=0x00000000
m_irq_en=0x7fc0007f s_irq_en=0x03003e3e gsi_event_en=0x00000000
se_irq_en=0x0000000f ser_m_clk_cfg=0x000000a1 ser_s_clk_cfg=0x00000000
general_cfg=0x00000048 output_ctrl=0x0000007f clk_ctrl_ro=0x00000001
fifo_if_dis=0x00000000 fw_multilock_msa=0x00000000 clk_sel=0x00000005

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (2):
      soc: qcom: geni-se: trace: Add trace event support for GENI SE registers dump
      spi: qcom-geni: add GENI SE registers trace event on error paths

 drivers/spi/spi-geni-qcom.c         |  22 ++++-
 include/linux/soc/qcom/geni-se.h    |  38 +++++++++
 include/trace/events/qcom_geni_se.h | 157 ++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+), 4 deletions(-)
---
base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
change-id: 20260630-add-tracepoints-for-se-reg-dump-c2c8bc875658

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

