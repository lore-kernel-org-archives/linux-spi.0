Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88CC3DDDBA
	for <linux-spi@vger.kernel.org>; Tue, 12 May 2026 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566422; cv=none; b=e0No4qtTFnVFI4RE+ddpod8tK1Vs/6IXkEB3VwjnZyx7o4qH7Y402gdCekDeu5WFliP848/Z2TlUsdGwI8xP74byACXZAUN4QBKzJBDbTveTDk9f+Lytt6tn/dBey6MvKPjR+OUV2ICKViSucWh1zo4jPuAsCOhY6hTTl2gYrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566422; c=relaxed/simple;
	bh=nhlgkVfDWgn+TRcBARa7NMZ79rHyudShi2Dvyt2IBC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a1ww/y7qzykeIP9G0YxADagnf5jnMp/+sgbqeTO8hKGaaAVAkDdJC9+Gz4R8h+sDrliic3c/oUexzqqQBZvOeCocEU/cfAz4JaMRdc0NTCimA4xS2USP/x0Qh2mFOaPpix2YKAct/SptwMLt3mzkDg0tSw/LBDhoQxzUsnSkDWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H7e8O3pt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PBxZAsME; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H7e8O3pt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PBxZAsME"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5PHiA2187559
	for <linux-spi@vger.kernel.org>; Tue, 12 May 2026 06:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wVKsegk5yrtLSMKIfMnOH6O9mKt5aoYLnvSKHe6uEls=; b=H7e8O3ptyCiRYvnz
	CHWpfvPUSZi4MbtHWTJRZ2OTdMgTLwIuyn4gNLtGGwsdK0wkX1eJ85HKURz8o2Lk
	K/+q55vCdZB0yTR0T7RXfbQcn3SJChxmTuS7zL1AuUByAc8CvmLEWQCf9AJdu3V8
	8I9kxpQ5y646P3xydkOdMi0dG29H0kdaAIi+V7ynfCJjc1soMtQe7hDi9VB7Y5s6
	JV7Ag3O6jyo+/yMByzWm8cHbjzOo+82kDNy66aTZ3CJBGSoYfwFmGnU7HCK/VgSX
	tTG3Y6iLARQFivAkpyGHTO8x7FJh6x6T6E35+efp5c40aTCYW57wudV/4NMjVJ9+
	ilFAkQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0sq1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 12 May 2026 06:13:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-367c2d149efso3726652a91.1
        for <linux-spi@vger.kernel.org>; Mon, 11 May 2026 23:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778566402; x=1779171202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVKsegk5yrtLSMKIfMnOH6O9mKt5aoYLnvSKHe6uEls=;
        b=PBxZAsME2TdfefAVv57aNMOOOgQDfXo54v3PtG73h866yERZgxInHrd9XJLSlQc45k
         VT1pi3oAYOLAznRP01oajlK52Zil5mbXRA2fXEcbQ+WcpY2eNxE/DKljXfLjB4Pka2Vk
         rDR3X0WJcNW21K0xXAxdVOfOljTZEZIekIvVVnfJ9IqrVqb7vv25iOic1N3IWS4CIrGf
         AK+VQJLpx6tN+Q0+xrwFcWY8Rc0iQVq3SwYpU84i4G8BNTnd84gUGIPyt9nKFF00BaiY
         hfdQr+evhBzX4Zjg2ndT3bJjybP542wSbktPmq10wdaU3b2tAqM/paVqi2uYpT9xq9Mn
         ApKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778566402; x=1779171202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wVKsegk5yrtLSMKIfMnOH6O9mKt5aoYLnvSKHe6uEls=;
        b=Rdi+050XYpBygMv0H/55pUjfEH501hloKqxpMAK8d01mtIzkaT8jEf9vrWhTjZisg0
         bjZEY9yF50+i6xhBE8KS/l7MoAKYXRiEf7fDjuuEIABd9tqQCvhVQBCjQk3ZO42n1nfU
         4cnu/ptWMp5003/laiddY0JY06y+KhQHUcZUKks9/5lBO5MkVEh1QB30ixuXmSpOXv9Z
         chzLnbIJGrGzMoKP057cWZW1EARYdKyJbOW/IdLsWmBKWzmTQv5agnbLGrkciP4O2Kzp
         PUcfvY/q/Fs2GElfKGLU431pXwsaHai6pHH2o2PFQKNfvOJeYCZ1qvp5jc4ooPfcWsCP
         ifHg==
X-Forwarded-Encrypted: i=1; AFNElJ9K5SbP3y7bHK4BGqP7UFLz+VHIWuVgTInBDJmFAlsOeA9jNNz3PFDZSj+etPS/9+xpKySsHpzpZI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0i4aG6DYBKi8j5Pta26W+b21m+bSmkqdE+zlcyi/9PKXdgarr
	0Sdz/LpXQZRcBBpEkpSY1V6oxO7g5xc9bj5/cx7VehoLv6yQtF0dOzQeJNtwfh5uoXA/FNRhwdc
	5miQTsuVOLKhawlIlvT41Ns+bl79vW7oc8HBlk9OX1kpy3h1pu1JHj/25bWrAGsc=
X-Gm-Gg: Acq92OES/GmiiSgj3v1PAVZd+f5VDQYiP2XSYx59bWshlQq0Qlp0Ktw83Hv7x6npahL
	wt5ok87x006ijjHAAfOJ8j+I2ZDRxku3oz76EiKB8oOEMqMLiKlado6OdQNry8LfmVjntU3xitZ
	x4MaFopaA3T0nZreyEXtgNBofSG8q6Xg6cQcpnXy+7ptHyneu90AjmATvGOXE60PMSM0VVCocqi
	VoMJSQ1BtihIq/Tf28iJKCpRZZN8uaJHIfZBpc+u5LgAN78NDuPLnLvxBA9ewV2TjN7JrMKPKJf
	JD5Rveu+I42wfOm4307IpFEagpNest4knTraKQHu5BWzbsmbP82ywAkynRSBTUwDndZZqBNOt6J
	KENA4zAwbXN4jj/jURl515TxrI6Rc7jrgggtvqmicHsMorDdFZhCP7eQ=
X-Received: by 2002:a17:90a:38c5:b0:367:c442:3f24 with SMTP id 98e67ed59e1d1-367c442412fmr8907713a91.19.1778566402265;
        Mon, 11 May 2026 23:13:22 -0700 (PDT)
X-Received: by 2002:a17:90a:38c5:b0:367:c442:3f24 with SMTP id 98e67ed59e1d1-367c442412fmr8907668a91.19.1778566401523;
        Mon, 11 May 2026 23:13:21 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368b00d2131sm842518a91.1.2026.05.11.23.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:13:21 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:42:52 +0530
Subject: [PATCH v2 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-add-tracepoints-for-qcom-geni-spi-v2-1-3b184068ecf9@oss.qualcomm.com>
References: <20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778566392; l=4051;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=nhlgkVfDWgn+TRcBARa7NMZ79rHyudShi2Dvyt2IBC8=;
 b=I3gkvz/NlpoT0yJ+STIDXSejHUNnROwikLsZy6Lbj+6h+xssUg9KupkfdlUmyGUc9Dq0HFrAT
 pyVvYnkdu7CA83BdwtT78TLjGAEYppDcULnJASYHAZm5txpikDA0dVL
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA1OCBTYWx0ZWRfXwcLWsNKGrQH+
 xc2BSRmJGUM7nIQIUI1uQl1ZpCwvgEw4MsEfi0aoUzfKcQJuE4agg3sGwTdvQTUuuI2LXRaio8u
 hQO04vxYrC/mIH4nDtDqrdwDPqA9FcFva66sMQm2ZZUNT4a3Iq3PXjQwdkA9yXf3AvSdqtpKZmb
 cf8ecTrEMR4kqZIrJ3ekXjAcuWFPzX/YAAKOeaHU1kn1XqOHyQnS9ZxzGB4BtSw1dHxTD9ayTty
 LGFK8aymuf450BmefQcIkF0ud9fkBCafcsnT3HnNRe8en4KtethIn3ISgnXs1qySZczvj10clqR
 sgGDE/dPj6yQeY1TMKdz/L1fzvAdGz8MbUdGJ3p6QrWE3HdlnAvQpDugXnULtLntcU/qckmcgOz
 /qm6BmZdfLANpnxCUKdGDbDnYmyq4VTbl8G+iMwrwnQHetFT9D62eYe2GP0zcRMC7+CmIYWIel+
 vJn4WupCZIcNaOJLubg==
X-Authority-Analysis: v=2.4 cv=bpB8wkai c=1 sm=1 tr=0 ts=6a02c503 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=uI40SpaImk96dJ2R2O8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: OUnFZBuQdQ_CFNRbHyAgmU92v3_htxL0
X-Proofpoint-ORIG-GUID: OUnFZBuQdQ_CFNRbHyAgmU92v3_htxL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120058

Add tracepoint support to the Qualcomm GENI SPI driver to provide
runtime visibility into driver behavior without requiring invasive debug
patches.

The trace events cover clock and FIFO parameter configuration,
transfer metadata, interrupt status to be making it easier to diagnose
communication issues in the field..

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v1->v2:
- Removed TX/RX data tracepoints.
- Updated commit text.
---
 include/trace/events/qcom_geni_spi.h | 103 +++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/include/trace/events/qcom_geni_spi.h b/include/trace/events/qcom_geni_spi.h
new file mode 100644
index 000000000000..5f39dab47e4e
--- /dev/null
+++ b/include/trace/events/qcom_geni_spi.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_geni_spi
+
+#if !defined(_TRACE_QCOM_GENI_SPI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QCOM_GENI_SPI_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(geni_spi_fifo_params,
+	    TP_PROTO(struct device *dev, u8 cs, u32 mode,
+		     u32 mode_changed, bool cs_changed),
+	    TP_ARGS(dev, cs, mode, mode_changed, cs_changed),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u8, cs)
+			     __field(u32, mode)
+			     __field(u32, mode_changed)
+			     __field(bool, cs_changed)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->cs = cs;
+			   __entry->mode = mode;
+			   __entry->mode_changed = mode_changed;
+			   __entry->cs_changed = cs_changed;
+	    ),
+
+	    TP_printk("%s: cs=%u mode=0x%08x mode_changed=0x%08x cs_changed=%d",
+		      __get_str(name), __entry->cs, __entry->mode,
+		      __entry->mode_changed, __entry->cs_changed)
+);
+
+TRACE_EVENT(geni_spi_clk_cfg,
+	    TP_PROTO(struct device *dev, unsigned long req_hz,
+		     unsigned long sclk_hz, unsigned int clk_idx,
+		     unsigned int clk_div, unsigned int bpw),
+	    TP_ARGS(dev, req_hz, sclk_hz, clk_idx, clk_div, bpw),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned long, req_hz)
+			     __field(unsigned long, sclk_hz)
+			     __field(unsigned int, clk_idx)
+			     __field(unsigned int, clk_div)
+			     __field(unsigned int, bpw)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->req_hz = req_hz;
+			   __entry->sclk_hz = sclk_hz;
+			   __entry->clk_idx = clk_idx;
+			   __entry->clk_div = clk_div;
+			   __entry->bpw = bpw;
+	    ),
+
+	    TP_printk("%s: req_hz=%lu sclk_hz=%lu clk_idx=%u clk_div=%u bpw=%u",
+		      __get_str(name), __entry->req_hz, __entry->sclk_hz,
+		      __entry->clk_idx, __entry->clk_div, __entry->bpw)
+);
+
+TRACE_EVENT(geni_spi_transfer,
+	    TP_PROTO(struct device *dev, unsigned int len, u32 m_cmd),
+	    TP_ARGS(dev, len, m_cmd),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, len)
+			     __field(u32, m_cmd)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->len = len;
+			   __entry->m_cmd = m_cmd;
+	    ),
+
+	    TP_printk("%s: len=%u m_cmd=0x%08x",
+		      __get_str(name), __entry->len, __entry->m_cmd)
+);
+
+TRACE_EVENT(geni_spi_irq,
+	    TP_PROTO(struct device *dev, u32 m_irq, u32 dma_tx, u32 dma_rx),
+	    TP_ARGS(dev, m_irq, dma_tx, dma_rx),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, m_irq)
+			     __field(u32, dma_tx)
+			     __field(u32, dma_rx)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->m_irq = m_irq;
+			   __entry->dma_tx = dma_tx;
+			   __entry->dma_rx = dma_rx;
+	    ),
+
+	    TP_printk("%s: m_irq=0x%08x dma_tx=0x%08x dma_rx=0x%08x",
+		      __get_str(name), __entry->m_irq, __entry->dma_tx,
+		      __entry->dma_rx)
+);
+
+#endif /* _TRACE_QCOM_GENI_SPI_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.34.1

