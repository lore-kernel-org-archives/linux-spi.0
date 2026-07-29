Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2431714A
	for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2026 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338016; cv=none; b=bwSpvzrXpK0fzV6APVjvGxXJIKLDGa2NzrQIDS/slu5mcHDe/tLlO2wIdlhO1K69yxg5hPkVk5egCYdcfgi7DDPI5Ut1e/pcCIh6qPQ6OVuZMT961R/G0OFVQfElBm18EdxQUsER07tBPDuJL1wjdTqzg7i18WV1YWS53pCDFM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338016; c=relaxed/simple;
	bh=BoZ2iQRgXeenL07kE4at2D1QGKWFWQM+Ut3SXTtCoTc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XaXCsl79ZnhSTgY3Q+lBty5X5vbCUrvh2eZyMPiX5NtQIU5/txE0R1Fuf5dC5eLmpNvfkvrMfcWqWJf6tjLaObUDCHAPdRWHj4NoP8rUFBcg341+M91oDNhzRVt/NYjgvbu225iyn9hUznNu0Ehsu8a2sODa8xADx/BV1Yls3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k8sFQVhS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fwlhv1ad; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k8sFQVhS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fwlhv1ad"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF2jdm2327526
	for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2026 15:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vH9yOHhfULnixC4HsnGBRn
	v7zbCi2gW7q7pMT5OKVwU=; b=k8sFQVhSGvS43qLh3bIxikjfdkFnyZZBvQAg6U
	gDgP5rZRH/6yAGRd1jlJP4s1CStgns6//Qj9yc9iBAvrPMam3p6W/oqandRRFHyu
	hNSuyXiLbpCg35zTh8KrphAAhUzi7nxYb2dEkL9jBWufFElFVM7Ng8WIGSlAMM2N
	dlRyzZxIzbl0Qt9oYOuICoSZHCDSWPNKkDgGo/S3FE1onEbOS/n0iewV+mp6uuRq
	IG7OeBse6v96yzzguQzpvVWBDbBXpLZFYiNZUFhquu3Y/lzcTdn9AdvjAfSzGNVB
	mHhBVprb0DtUclHEHfMc+fM8oYbmpTcax4s50UJyN8Vf6x+g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgrch082-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2026 15:13:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84865f326efso1232137b3a.0
        for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2026 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785338013; x=1785942813; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vH9yOHhfULnixC4HsnGBRnv7zbCi2gW7q7pMT5OKVwU=;
        b=fwlhv1adR+HS1BNuPXedSkSuX+O98I8EY9Ss7z7GrpAiKjuRKrTOq/d0lt1w4F3eiQ
         shi9hQyVhvdj0tO5N3iMOBJpDQoChapHRKR3ZHYIvqSZWGOXb5WL8f6bYSTNHhpxd1mq
         MCfHw3et9I0GYiJRNr1BjMH7RwMQcuaEX6S0Lzd1XyglHDlD1DSlPLY1k8Oa3fkcQGdU
         iSruNaiHelg/CzIhnWs3CMIB7WJTB+h16w5UZr/WXqQxV7QDqCvGSveZ0TiJmcMI2fxD
         j9IvS+wjvIg0NI7Z7QeEVTHeRiklMrFLhT/r3pVEpJ0ytFmS1l/3TJHoeATW5x5WmTpu
         ODEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338013; x=1785942813;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vH9yOHhfULnixC4HsnGBRnv7zbCi2gW7q7pMT5OKVwU=;
        b=ZNlYYLBRRc1lgkPPVheSyZnJCGqNX1Vu9PJeT+nbEUnpCa3fro54b1ErEUZx900X9B
         zLYEoVO7S320uReFiYYdDurqxqsJGlzRl5f5C/5HE+t/JltK6vqh7JcQPz5XQK0fGL+k
         VHVN501wKIOMRxAL0r3NuXSWmeue2jWUaPGqmpHBh+vK6u9e/nVndE33YgP89d+iEBdd
         lFnX+Nx+YOSUZAb7lMFbomuhCBhnnM88IsKqn/WdBCzZNEI3IGHaQBnqzu5i2kJPjaas
         9QWK39Fg2ooWEvwxkGLejDa+DUNZ0GeyMZomjDpfSu854DJUsQtbgCGksF40RSkP856U
         BBYw==
X-Forwarded-Encrypted: i=1; AHgh+RqczlnwLYfVmm1tPdT8w5fhVOHymeo6oL8JvZBlXHNmnhSQG/eaO1R2q6Uh3Fc0F9Qc0/8PybLo9xM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi9eMZdX38gMFgFMRynySA9AFNZyFmBZ+HaTH71FwJzJ4HEViB
	VeJYHUqSydHFurPiKT9bLPJamQZtUQx8rTc0WHdPiPxUeBCfGD+2j9Yln4WYWWT1328/Ka+14ri
	Cn9SgsRF4qltmSMq/vUjp3pNoOW4aExbV/wRcArecBvbqiZ8hlBuTWFDY83LkF9A=
X-Gm-Gg: AR+sD13hLzqbAFndVW9TpiFVIw60wsdmObC2VRvh79vQua/8bKBzpoPU7EHBFrEsOIQ
	Z4pkIQCrsOqMg8Z507HdVXNvkhQklMb0w2usArhmR3JhgFcOTLzTy0Q0So/Gie3DwDU5Tx2+Om7
	YrO2+Xc6xL4YzjqhNFGbopNw9ZJJyEZfK0lljzSIQpPCGFUMZEIHekrmbg3iD6VOWp+9paf398I
	STF3wDkqq17jsBFGaHZx/mEXidHTIUTWLkp44J8aK11R0iQege5dKkIOj4ggWJorrD9+cgMj6PE
	Rhc+lMpIyZZs8Un88FIfieJpj1IfNGTiZl1h0Il2ryUs9rxy0AZMbKTWa111bjScWJHpJevweQR
	1Lp/MQJJt4fTJynNQY1omnjtGDT+btF766w==
X-Received: by 2002:a05:6a00:17aa:b0:84e:88dd:5942 with SMTP id d2e1a72fcca58-84e9332ea08mr6854388b3a.41.1785338013053;
        Wed, 29 Jul 2026 08:13:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:17aa:b0:84e:88dd:5942 with SMTP id d2e1a72fcca58-84e9332ea08mr6854339b3a.41.1785338012497;
        Wed, 29 Jul 2026 08:13:32 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe238ffsm1617920b3a.12.2026.07.29.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:13:32 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Add trace event support for GENI SE registers dump
Date: Wed, 29 Jul 2026 20:43:24 +0530
Message-Id: <20260729-add-tracepoints-for-se-reg-dump-v4-0-08bbd63b0ed2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJQYamoC/4WOzQ6CMBAGX4X07JqW3+rJ9zAeSrvVGqHYBaIxv
 LsFLh5MuGwyyZeZ/TDC4JDYMfmwgKMj59sI+S5h+qbaK4IzkVnK05KXGQdlDPRBaey8a3sC6wM
 QQsArmKHpQKda1lpWRVlIFi1dQOteS+F8WZmG+o66n7Xz4uao9+G9vDCKebfWKl5u1kYBHAzPj
 RW6lkrkJ0+0fw7qoX3T7ONhc3TMfrSi2NZmUcttJSt7yOq4/qOdpukL83+90z4BAAA=
X-Change-ID: 20260630-add-tracepoints-for-se-reg-dump-c2c8bc875658
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>, konrad.dybcio@oss.qualcomm.com
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785338008; l=4199;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=BoZ2iQRgXeenL07kE4at2D1QGKWFWQM+Ut3SXTtCoTc=;
 b=D0Rm74DmLyPTGh1zy1ieO0AmFq53gz3l+txlx8XpPoUG3t09FvT3OUBVyPLcS765ALAgdiOPq
 W+zc8/QIG9xAwpFvgt7Tc0gU6YVd3dZuEPA7jX9ZTehFWp8SeTPyMoG
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: frUecQjSXntVwriH8HjPC6HW-eTSnlM4
X-Authority-Analysis: v=2.4 cv=Id+3n2qa c=1 sm=1 tr=0 ts=6a6a189e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=7d_E57ReAAAA:8 a=kZ60qkYGOAwhCc6MxdMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=FO4_E8m0qiDe52t0p3_H:22 a=2JgSa4NbpEOStq-L5dxp:22
 a=jhqOcbufqs7Y1TYCrUUU:22
X-Proofpoint-ORIG-GUID: frUecQjSXntVwriH8HjPC6HW-eTSnlM4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX7YoZpi0LACLO
 u7R5loiwcds4d6VqCwW2M9BF4MBkwxWeljhXbq8BWGFhbOKsoqbu0jN0X6OtBp34FlR3V5aL1EV
 csDBeDFfeU14xK7wWaEwzKvt8aTVlLY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX0p4tI3TwY1E8
 yOH0P4nJ8ruXyWs1N2WMT9DubIm1Leqg5RAFpwiqn1tfIN0PRxjVpr3UZYvRYK+5dWAvKKqv3cY
 sJuAVKuOUztpT+md6Ae0C1vDMyAETSM82GlSkTTdkX+GypQxkDfS7HOdBfVQxuzibu7jCSvLP1E
 wBoHo4/Y8FB2ms1o45ub/CsJBMtC6X3rCcdTuVMjcFtWlYrOvsEaITBgVOiG/enlVLNFrKUK35s
 Y1Qu72584IHslHpT7BMvDVLQCafulltsppfW1d6PoGVfDsHlJpt9Q3QQQLRtg+89S8+y3ZNMTBg
 bActdMoChCP6vDZ6TkEQvizqUjkKjNPOMsf2UjsVrFvi/EdInzvisuPBPvsLMmEVWQeNwszqn9j
 hH1LbFuzYOtQFKaSSxWDidDTpAmmYZK24Co6oAiiZUlD5E6XcFWE04JXeVh0tLcrajOFEWGUe8F
 MSD9kVDhGCMVo9bSO6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

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
Changes in v4:
- Export the geni_se_regs tracepoint with EXPORT_TRACEPOINT_SYMBOL_GPL()
  in drivers/soc/qcom/qcom-geni-se.c, right after the
  CREATE_TRACE_POINTS include. Fixes modpost "undefined!" errors for
  __tracepoint_geni_se_regs / __traceiter_geni_se_regs when
  spi-geni-qcom.ko (a separate module) calls trace_geni_se_regs().  
- Link to v3: https://patch.msgid.link/20260715-add-tracepoints-for-se-reg-dump-v3-0-0f787f93badd@oss.qualcomm.com

Changes in v3:
- Trace se registers before clearing tx watermark reg.
- Updated commit text.
- Link to v2: https://lore.kernel.org/all/20260711-add-tracepoints-for-se-reg-dump-v2-0-ca1e9ba62359@oss.qualcomm.com

Changes in v2:
- Updated SE_DMA_IF_EN to correct value.
- Sorted hearders.
- Link to v1: https://lore.kernel.org/all/20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

---
Praveen Talari (2):
      soc: qcom: geni-se: trace: Add trace event support for GENI SE registers dump
      spi: qcom-geni: add GENI SE registers trace event on error paths

 drivers/soc/qcom/qcom-geni-se.c     |   5 ++
 drivers/spi/spi-geni-qcom.c         |  23 +++++-
 include/linux/soc/qcom/geni-se.h    |  38 +++++++++
 include/trace/events/qcom_geni_se.h | 157 ++++++++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+), 4 deletions(-)
---
base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
change-id: 20260630-add-tracepoints-for-se-reg-dump-c2c8bc875658

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

