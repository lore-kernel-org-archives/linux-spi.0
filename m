Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3CF37E2E2
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123673; cv=none; b=tNntJyfij0416uB8mNBgSp0NodXcU6fngAs0sdERmm/AQuYSo4tV2SX9YcU/TAiZcRZy2e97yxVM4ivhjhPEgMMvPrlR2ZJEHkE55iDCFZcD59cDPf3KAsgHBVxLoRJkxf4Pvb9T7bKGIZs+TCi8OtXY0fnvyBc5rjRHSmF7D0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123673; c=relaxed/simple;
	bh=/wGIaUhBxlSuewsn/cKPbyPBkGIrIlpdsbtD3XVrlQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svn50CeqPE8u3GQ592r2wUZAg0pZIyrlyTvOFHLFo+DNfuzyMOVRY9cAIlhKGcl6YvBPIuWCZMrXXYZnceTrTP+OpQnaeXu+5MNF5n7NgnM89w2Azo3Ggrune0X/jFoTUb+z7+4qOsRT4wmPiphSiGIhzc6tGw8e4L0+5j5kTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D5/5j4A2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FF0TuSKH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5/5j4A2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FF0TuSKH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IGFFEh2091027
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 17:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uot5zVHiOWvQW+9qfq21wfXkU0gBHqKnmGA97D8OoaI=; b=D5/5j4A2ar1qkS8C
	kgbVnKtLC/07YjIOXvlYKS2iJzQWvj3VHwuDScWrcp4fQGxNqTXENzsBphgKazch
	BecJRDEt0vOZ8xmTGmO7SUrKmWbQlUGA8Hl7AtToIrbURXPBH+Bh2SE1r5Y3Jcpo
	keYzLUlxjNXnNcTv7A1FMFYaCPjPywWmPtwAljME0YWZyuGAq410q/XWRSmFgd4y
	a4xraVl8y+4I6zVakN5rpFw/UZvpWuqr4YOUoG57mYWqe397FUPc8mNwK/45XJWb
	7t9NRBh6E3Qzmnhb4v4opLPDTKTYGdZp72BIx+eQx3vRdd1OnyvKWnBBVx3I2hsD
	w0lFiw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e80rphmhs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 17:01:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-365e70c39d0so2467926a91.0
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779123669; x=1779728469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uot5zVHiOWvQW+9qfq21wfXkU0gBHqKnmGA97D8OoaI=;
        b=FF0TuSKHr2CWhSU6ou7dYsgEjKu/Fb4dJfMscDh9EXWtVCQ12pRoLq/a4ewN9LrJY4
         W9HKnr6YZ2sa4v+bzyng/yKLXdFtaCU6xp7eiLsA0eZ7XAy/kcNoOeu8wnwYw7aUkM1k
         /WitkX3RwjpL0cJXypyTsyGrCSKSQAurlOn9m8ncmruIarrLZC0WVYvbmiwvX4dX2ZUO
         XfMJeh/gt+F6EWoKPepuZF1uJmYbbwV2Lgt1tCni6lJWI35K5w/mEY7BFNVbuJoOLSeU
         SW71yTzp4WDXbNZ9eA4Urn9KQG9GZLdwGdWq0UhW/OEWFccmm4q8NGo1/Mb9OtFaQl/2
         QP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123669; x=1779728469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uot5zVHiOWvQW+9qfq21wfXkU0gBHqKnmGA97D8OoaI=;
        b=nTAxV/c3z5umC2W7J8bHqmF3q5erLopjfXOJSx5J+BF1MkrSKsYQyyVoxKIe/FPNkv
         XeRkbYmKnpewPrr8v3CHHqcoo07qamIRL4HS772+WSFhxcHi6JZd0Lqym0RXiTurBZNi
         nzQJgVy2LPjSDSXvRWJKQlWXrkUmLw/EIY+vd0H9ByO4jX7syeSUAiIapdKochtAhHxF
         btHIIS3nXa05ckg6G5k+UvuACj9uqilYj8S0Proll08Wx+gENY9Y5d5hdYfkROOZGWJj
         vB80A+sRBuz/aQBKyGSUlRU6SvrM2Rdt/UAjMkfUK0tBChd0hL3Y6iv1xz70NKUdbzdd
         TJ/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8OiA6Arc1NvLFPz3NvxI4FdMEaYCpl1jXgYfJo6oXwtu+9YDE4iCKghArt8W/nNYsPG/xGoCg2ELo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb57pAb0+QFM5s7E9j615nA2pwKYfSx3m3iSHKLZsubNIypNUW
	bBAl6vqqAD7O81bz1Zqq+UdTZvpRukxuLvmIHtUYIhrIBQM5Smaxk5nUvlzKdUMyJSWiLbAmnYg
	2vQvWN45gu/UiMuS39H3IwEJ3l+lf8k7UxFZqH20jAYg0Sx3JcyuNZ4Dxjq6ugkk=
X-Gm-Gg: Acq92OHcSCiQ424gPnntDkZvS1gVuxr1dIf34M7j8R6oD5H+AmA6YPiplBeZQlcDiMp
	0nKtx/IsziYRj6yMS/EK9my4D3lnYVWQXA5VWmhc62dqGLFzPOvq+Rhf5i3ROvbLU1oZJNhPfXR
	OT5jX0+ZA0s0rmRorECrrhdPtLVvAAMmvGZa6PJIWMWZ3eYiYiuuKaMrsJH4CgL/LGQNyHj05w/
	VY0ef+J+TjNcr/wClEJwpJwS1d6k2AesE5KITC6K3/EmizyZdxEtv0RhAHrRm+2asFBg6wyEXlj
	bXR1wrpvSbkOIhWuI+AyalbA9dzE8LEJoMnYKIaDjqCDzmmp0PARjBrFbeQqRMy/j5Def8Mdc2L
	0X1BYDsO5UD1Hpstu3h7IG53WpKbk1kcv9x3vEgpHSmUmJpdmK3T60aQ=
X-Received: by 2002:a17:90b:2549:b0:368:ac5f:d31b with SMTP id 98e67ed59e1d1-36951b8708amr14660952a91.24.1779123668803;
        Mon, 18 May 2026 10:01:08 -0700 (PDT)
X-Received: by 2002:a17:90b:2549:b0:368:ac5f:d31b with SMTP id 98e67ed59e1d1-36951b8708amr14660849a91.24.1779123668005;
        Mon, 18 May 2026 10:01:08 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695652466dsm5783808a91.0.2026.05.18.10.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:01:07 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 18 May 2026 22:30:51 +0530
Subject: [PATCH v3 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-add-tracepoints-for-qcom-geni-spi-v3-1-7928f6810a79@oss.qualcomm.com>
References: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
In-Reply-To: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779123658; l=4219;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=/wGIaUhBxlSuewsn/cKPbyPBkGIrIlpdsbtD3XVrlQc=;
 b=YPm1dG8N41CJijQOOCeBCx1LBG3qYiuz/AhsTBIFw62sYrX8POoGPOnnJ7Kdp19uB+CpbB3oJ
 GgETwGffEydAO3r0mUCdbKG12iAHNOiLcVVbFctRhNyHcWlrjBaO2xc
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: ZQ6mTmEBQ4ndYGc0TnePw6zpcAJ60UvF
X-Proofpoint-ORIG-GUID: ZQ6mTmEBQ4ndYGc0TnePw6zpcAJ60UvF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2NiBTYWx0ZWRfXxWk7ifiZp1Ku
 EwUmGrAxuwJ+QnuMcJ9Bfbv9qvJ8lZrSQFlTeXfwJpDB4P/hcU0niF6Ggc800a1lS4erDONH5zw
 k3EroHu1WwMBt3RbWnd931J5UkAP0kcdvWhg3o0I6T1JY+bOi0offLqlqkHeMe7oBIGZf6g+Xpu
 Oimi0TN1iK/vHE7A7EYCcDuD9S8JrygJSyrmGCKtILfl9OwAHR7Gk9hbSPCSrCkHzZpTdfbmtfs
 JYHNuMqcFdf5C9OSpurM/vBEb2xnRTpbsaGgTkDRlAfR41bskdYmTPifOPJ+dFXsWe0SMzhPS0v
 we0sV9DRj52zSrEZ5rDDTEDY+OwjDjZKdZsC6B0YbSiis5LKZbMed+mRCzBAsiRl+aMmynmkkGM
 Swc1yxGhrRy4mKHFB5gxxbwBdf3xBlKiB5lGjvwpwCAw61iefy5uyNVBIl3kscG5qGOvjoDot4M
 p4TUcnLl28rtqN4cB0A==
X-Authority-Analysis: v=2.4 cv=ecMNubEH c=1 sm=1 tr=0 ts=6a0b45d5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=niy05HpUbDCNYMLfpPAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180166

Add tracepoint support to the Qualcomm GENI SPI driver to provide
runtime visibility into driver behavior without requiring invasive debug
patches.

The trace events cover clock and setup parameter configuration,
transfer metadata, interrupt status to be making it easier to diagnose
communication issues in the field..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v2->v3:
- Renamed geni_spi_fifo_params to geni_spi_setup_params trace event.
- Updated commit text.

v1->v2:
- Removed TX/RX data tracepoints.
- Updated commit text.
---
 include/trace/events/qcom_geni_spi.h | 103 +++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/include/trace/events/qcom_geni_spi.h b/include/trace/events/qcom_geni_spi.h
new file mode 100644
index 000000000000..6d027adf2e1d
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
+TRACE_EVENT(geni_spi_setup_params,
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

