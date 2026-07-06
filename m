Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9490F3F7872
	for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2026 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336119; cv=none; b=th/6FNvaO5PadGy7bIhb07yW8/AlcJU92cy4ZbxhbUpE6Eef2LnS0os6mPFXCpcNXW6U+wYPbKUAEWgj5ICxuyu3+j4a3OqkNyLHUPT30NQNO0Oe2aVRJClr109pu70rCwaK1GBXtaWY7El4KHEx6jRrC0suUMc0PgYVbfnoOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336119; c=relaxed/simple;
	bh=soA3BDJ7EjqA5hWfm4kj9buFogwtZYzZXE0zhdq8A0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4uHy7fyZY9NHkQ2TH2ZgpjbGjzyCT7Y1eL3DL4BeispQH4PqyO3nes1oRXwyEJgfxx6lfPXNK+ajAv5HutyAdgQmZpTVwevu1UUBLMZ7CXHN930nN6IY9upPEun9KyWn3eZ9yDwagNj9U6s6bspQx1IIvr5W60dZoXB+i/So9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cV++0cZH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fEJawWEm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cV++0cZH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fEJawWEm"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666Ax9e3391059
	for <linux-spi@vger.kernel.org>; Mon, 6 Jul 2026 11:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lOTzOSxHynqZ5lzAB097GOfQw5XXG6mSt3mT/6tBBeU=; b=cV++0cZHir9gZelD
	8opZkpEb2tUMwX/Tf4NQ6gd90/l5hsfsuOJZu5svZNBwgtXP3fnD54CkfBL2sqVY
	GwDYS0O+1cDURo1LEkXBCCG5UHsee26Kl4NVGDKH4+NI9wtLmyPCLRSgbq5rYeDo
	NDYiBzbiBifBNGcCaTmcrrehPQ9ELXf739xdhygNMj/mCd8kOMAx94SKuV2bW47S
	HZL2/gxe3FrNmMF4dlnIXaERGvlQ561BVjzGbc5vSvcSCzlGWqbgpxbR6NGEt6TJ
	7f7NYomZ3bxj3+5Q0VAmQnfrekyqQgVdeBtkoRxQ7Jd1c5xwRL4GFA2N5usbOZJI
	bamTkQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgrdt1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 11:08:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c354050c34so31515995ad.3
        for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 04:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783336116; x=1783940916; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOTzOSxHynqZ5lzAB097GOfQw5XXG6mSt3mT/6tBBeU=;
        b=fEJawWEmI78u4fBnfmZQtDfe5K1WVEN7r+ttvnyKpE4kIXRj6f7mb0oP9i0Xa/DLBQ
         TWsf80Pa1cV+f9bNIFxtrFHyxWZF2mWqW5HLQQf4PTntAuXL14K7NNg1D3d0do/iZojF
         enFtAIP5bOeg9V+NOWEkLTPI2KoxaiQyNrkvmbjrmnJVj7obMuYKhF7s045f5OCEB/fE
         rRjh7zQSoHKgdxHM3Emmk9FscKudAuEjhE3ZMmZWVx+k0t9nhYptW9ALm/pwApDuoU48
         AENo5E3Y1Wtg/SFP+iEz/2GGjK8HSPrz9Kfge6leCxspvAWMaAcwe0TfFnZLzk+4PX82
         kVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336116; x=1783940916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lOTzOSxHynqZ5lzAB097GOfQw5XXG6mSt3mT/6tBBeU=;
        b=G5jOhLnBayY/eBGFb/htZAccl9eIyy6Vr2OxfloDGnN6RdlQ6R1XTT3uu67hkXCqIH
         u+n3VVXfwxUQDTHeE3sEKoKHCNxwDcuq93Bcwf+Q2am6GTA3gs/zE0MIZAt6iFGklbea
         XByEUtklNjO5/f89lOwMzFMuuKAU+5gGQ0kC9P7MpzP7EQtoUZF6X5SPVKhFTLTXXE5z
         6W413Xfxo8Kf1PYMsD+VUcy1I7aNxe2OTxSrz6PFdTq2/wPj4fl+bpTANpHR8RHl9Wty
         T5hEphKa3b2ATDdkXeMau/1pZjAiG2MuSHskbvEb7D4LsqmkzNfvdG5AC5UvNpS+Hq2k
         V+3g==
X-Forwarded-Encrypted: i=1; AHgh+Rqj1RJzLrUIl+3vWf8mfyvJLMQqNAvHubfPsB0V7EwkyzessKyKd7YxAvcMsl8tYH9IhoJD+Qia57I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcgg5KyJ+iGiduzd74xBXAv9zFBt1tIEV1XP/5Q5+MnkyCyCEQ
	+Twb7StMvO7WrLiiXYDsh0abL7KbT9Im0p3Ulqso/EbDQNMV2VJaUfOEPIvyYfsLTLuu3TLFxC+
	naPwG27vUgHjre9BihjwTMH/3eXFsgxkzE5OEj3ghjouD7prPHDVaNPTmXqyvHDQ=
X-Gm-Gg: AfdE7cmODSxS5NukQ9z0UV50XJJLIEFzfThXURsI/3LC1S8CCiCdPSXWbG56EUaXJbL
	2KuK/Hs41EYLczD1XyQxvg8MNlXDNJOcpkCucYEM/bjimxkYGkofZpG94GdkECYldLFBSCgZMcc
	ziqaeR4ycY2519EOaCa8AguOusB2WgzBzkQ3waJhQIj/bhR/ArF32XerAC5qSh05VshDmU0wxmR
	W1uywAipB8HdFrzQWCgQpE/hUoLsT1ClP17A+4jRrhJDqL3rSEp2VTHfR0cI3vZzUEydPNjdzYO
	1bsOaztYZdw59n+LqE7kQi17x6fbrHyW5aTQ8yXwprRuNZzWSHXamYVV065X7ZF+0J/6wm8rAHt
	xHjcZZw7UMGT6qqikyV4OWLvOjC+7JWLoDXfd+dJdIZOu
X-Received: by 2002:a17:902:e78b:b0:2cc:98b4:e7e2 with SMTP id d9443c01a7336-2cc98b4e9b8mr39301065ad.44.1783336116104;
        Mon, 06 Jul 2026 04:08:36 -0700 (PDT)
X-Received: by 2002:a17:902:e78b:b0:2cc:98b4:e7e2 with SMTP id d9443c01a7336-2cc98b4e9b8mr39300675ad.44.1783336115518;
        Mon, 06 Jul 2026 04:08:35 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7871285sm47730685ad.64.2026.07.06.04.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:08:35 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 16:38:13 +0530
Subject: [PATCH 2/2] spi: qcom-geni: add GENI SE registers trace event on
 error paths
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-add-tracepoints-for-se-reg-dump-v1-2-48bd08e28cf2@oss.qualcomm.com>
References: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
In-Reply-To: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783336101; l=4376;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=soA3BDJ7EjqA5hWfm4kj9buFogwtZYzZXE0zhdq8A0g=;
 b=mshxjBsL4s7tH3/JNjX7VohPwJ6AxOs8q2vboeGbMu9861OFrOa9dNhHLbd1IS0UNdTmCZMq+
 Dbzv6JONoEWB8yTTTAFAoIihszsrJxmOBg40lz5nQzZHmkNfNyh8wXn
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: pLP_7iICVyrKDtu_FA9ZMyiW7zxbD1XL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX9+Z4rm5juWIb
 2Y3F+A0Js7OUSSJLG8lXYkuNMCnKThivjTEQoqdiRlDwp6xWjaCxluebfaA5XhiDM6stRCU/Syp
 Y6ILXOb5vvJ24j6pshaXQT5nbpQzYKDCLS65jGfk5fa8z3Ar/AJ7WyCg4yD29nVc4R8MdjNucvz
 WruCDIUUI1rYXuQxV+4RuLxzZKRDp6T2zn/5N951s6qMFZ0oH2oUfQPRzibUjCU0hI9YbawyIX7
 Vp8MBdXuVOyn8g0PceXssF22vlb+VpG22avqZa7yLApWmJn5x+llLiXsnP/iA9QX5NKn5JJV7+I
 AC3aw3V4+pcU5FVqd/faIXo4VoKcKUv0Z10mSdJEthZ3we7IKxNey2I5Sl9TsfygNkndcq+aw4m
 20ETzeGP7uulQ3Or16o4aFTejBZjIamAGVmqpCdZ9/agLMb8TjSsCP+m6OibnjsdhT3c3tVpfea
 gZ1BzKjxUaNlBG5/ulg==
X-Proofpoint-ORIG-GUID: pLP_7iICVyrKDtu_FA9ZMyiW7zxbD1XL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX4soUuS/Vm4cL
 ioZEdddH7nTVnCnFlhVuC2q5C5+j7W+lC2WP6S8mB+YFax5Vm79sSojAv7v1eVm4W/5tfeHEy4E
 FIXFQCzgjfkfCV39VhZIDzg3oIq3UEQ=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4b8cb4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=SuVZUjzzKY3ZPv7-dKMA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060113

The GENI SPI driver reports various transfer failures such as command
timeouts, DMA reset timeouts, DMA transaction errors, and unexpected
interrupt conditions. However, diagnosing the root cause of these
failures is difficult as the hardware state is not captured when the
error occurs.

Add trace_geni_se_regs() calls at critical SPI error handling paths to
automatically capture GENI serial engine debug registers when failures
are detected. This includes:

- M_CMD abort/cancel timeout
- DMA TX/RX FSM reset timeout
- DMA transaction failures and pending residue conditions
- Unexpected interrupt error status
- Premature transfer completion with pending TX/RX data

Dumping the SE debug registers at the time of failure provides
additional hardware context and significantly improves post-mortem
analysis of SPI transfer issues without affecting normal operation.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 26e723cfea61..7db0836308c2 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -3,6 +3,7 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/qcom_geni_spi.h>
+#include <trace/events/qcom_geni_se.h>
 
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
@@ -184,6 +185,7 @@ static void handle_se_timeout(struct spi_controller *spi)
 	time_left = wait_for_completion_timeout(&mas->abort_done, HZ);
 	if (!time_left) {
 		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
+		trace_geni_se_regs(se);
 
 		/*
 		 * No need for a lock since SPI core has a lock and we never
@@ -201,8 +203,10 @@ static void handle_se_timeout(struct spi_controller *spi)
 				writel(1, se->base + SE_DMA_TX_FSM_RST);
 				spin_unlock_irq(&mas->lock);
 				time_left = wait_for_completion_timeout(&mas->tx_reset_done, HZ);
-				if (!time_left)
+				if (!time_left) {
 					dev_err(mas->dev, "DMA TX RESET failed\n");
+					trace_geni_se_regs(se);
+				}
 			}
 			if (xfer->rx_buf) {
 				spin_lock_irq(&mas->lock);
@@ -210,8 +214,10 @@ static void handle_se_timeout(struct spi_controller *spi)
 				writel(1, se->base + SE_DMA_RX_FSM_RST);
 				spin_unlock_irq(&mas->lock);
 				time_left = wait_for_completion_timeout(&mas->rx_reset_done, HZ);
-				if (!time_left)
+				if (!time_left) {
 					dev_err(mas->dev, "DMA RX RESET failed\n");
+					trace_geni_se_regs(se);
+				}
 			}
 		} else {
 			/*
@@ -382,10 +388,12 @@ static void
 spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
 {
 	struct spi_controller *spi = cb;
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
 	spi->cur_msg->status = -EIO;
 	if (result->result != DMA_TRANS_NOERROR) {
 		dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
+		trace_geni_se_regs(&mas->se);
 		spi_finalize_current_transfer(spi);
 		return;
 	}
@@ -395,6 +403,7 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
 		dev_dbg(&spi->dev, "DMA txn completed\n");
 	} else {
 		dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);
+		trace_geni_se_regs(&mas->se);
 	}
 
 	spi_finalize_current_transfer(spi);
@@ -941,8 +950,10 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 
 	if (m_irq & (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |
 		     M_RX_FIFO_RD_ERR_EN | M_RX_FIFO_WR_ERR_EN |
-		     M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN))
+		     M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN)) {
 		dev_warn(mas->dev, "Unexpected IRQ err status %#010x\n", m_irq);
+		trace_geni_se_regs(se);
+	}
 
 	spin_lock(&mas->lock);
 
@@ -974,10 +985,13 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 					writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
 					dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
 						mas->tx_rem_bytes, mas->cur_bits_per_word);
+					trace_geni_se_regs(se);
 				}
-				if (mas->rx_rem_bytes)
+				if (mas->rx_rem_bytes) {
 					dev_err(mas->dev, "Premature done. rx_rem = %d bpw%d\n",
 						mas->rx_rem_bytes, mas->cur_bits_per_word);
+					trace_geni_se_regs(se);
+				}
 			} else {
 				complete(&mas->cs_done);
 			}

-- 
2.34.1

