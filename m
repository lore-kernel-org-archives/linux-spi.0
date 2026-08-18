Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5BA470EB5
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059706; cv=none; b=AzWOywd5LjWqhKmN1EA5CT888k6MWVtLZJy3wHVU3NFfU8ZvRRU5IamsEWEtOHRcAQ/M1lUNY3Cv7dE3fT+mO00oaSTs2GX1hbC4t0JdGsiLd70dQ4E8s95dhQxSYYI36lknz0OFBWgM/l6xqL8kGxCx/hEHHbzjSRP73bpKt7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059706; c=relaxed/simple;
	bh=BpLYbDTze5uFtkiCRqcEFWa/uhNMG9l7EwehucHfhME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/tYlJLx3gPsnRu0CgJJ/u2gws5bZoXNgklNVLNmiKLFr3NDo3zg44VZQQtFSWPicTnY0OiVKL/M3f6v4zsWrVUywZRrxDRQRWJ2I4brGM1L86MVPBIcdW8vv1+kQWs5a4iFrmnUkD5sMj3lsSdydVvOIQTwQ+ovHMP0jMYGsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IgjVVis5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JPF+Lm6Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IgjVVis5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JPF+Lm6Z"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDQwtO218762
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3mgtIdNm+Qcja3pfQQpEG06zXdPExxszQT4cQ1BBpI0=; b=IgjVVis5adGb0887
	AK3ZpaD/sEdq8TaiDYx7uoAckyxGKBK4bH3xAzRGZsIOnetnT4KQwRG/c6MIUoeu
	3GIMoOnQnDXDtxQaP+G/MFopW5iSezk1nqxa+QZb2UbKZKUqTolqeiwIQZKKQhKk
	CGKSct63HX3/sRynAhHRk9mGxmec3HTbA5VI8zq9xwhL1xI1GpABYQV66jnL2Ktm
	0zZwstb15RgI46HPT/Bc5few+hGIRPVjLubhDLh+aUk4bv0zY1if0HMwK8dOR6ry
	Zj4zZ7RFyHdgxd15L7W9FjXhwvmBeFXmSPBRYmrlmkz/j77GYitVaPrIDklEvzMi
	WX1k3g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ebptn8x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:28:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e538afe65so560965585a.3
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 06:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787059703; x=1787664503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3mgtIdNm+Qcja3pfQQpEG06zXdPExxszQT4cQ1BBpI0=;
        b=JPF+Lm6ZFqlPUUobRbR3vYWRU9vkSIs/wecp/t3r5qsF0E0RLyLjf3JxCfkWbZPf4+
         tfiN0S09VjfQ+wqHpJCln0O7kwx4K2xQJf4O2bhId9yQ2s2ebbXHe6GJqDpde972Yna1
         Uj611Ro/DqE0nUge/GzlcLlovxzjgZxvugYdTjSrW/XmlKtKbHy3DB9UzzecVM1brKYK
         qj93Wi93bT/2TiZ0cApJloWu5D85g/ZMpgSuj3sXj7ltJMnNg+Dt/6cK2cjqohap1uTk
         RZUCCt+eXWTsoRjc97Lx9Nur7qMU8fexoHwiJdeBEpJB91GAP9351fWldNYey8LLEutJ
         WAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787059703; x=1787664503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mgtIdNm+Qcja3pfQQpEG06zXdPExxszQT4cQ1BBpI0=;
        b=GwJY+BodU1y1MXBGT/2/EBwYu4v8SpwSOQgC211NQNvW2+hmuxVx5R85S9xfk9OSz2
         yvsLtYi8ZF1LGWho1cqYrCikIU60+KlW5M5JmRKigrNwC0ZOg9oomxUo2wazIWjTrbFN
         32H1ohGFFlJsg/CGVMhIqZpH4WwKyo/yjcr1AJiAdw8YHds30jOO+uKLskuEqEAPQF4d
         bcxCsYjbid+FC0T2iBc5UCbBkwOWmooUqVxOfeLud6SqBYk3d8PhKS8d7CK4zhbl82oI
         MAcTUdlrnanGQ/vrFViKlke5wLAvgzAmHqYU4Z3gBjZFdifd3YIi6zyoG/ZytSRP7EtM
         hmZw==
X-Forwarded-Encrypted: i=1; AHgh+RolF7dDYf4hEWU+9DEkWSb5ywZrOdnSbvSqotPPqR+PprlLqb1Qh+O6EdgD7h7uqxKh1k5HCk61mNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6ib4sbb9A08SQvVbXwerBhpVryhBP3x/BBY4OoCSXQXJcMmp
	D0TiBF/SwRuTjcibynJXja8ytMs3uM3guuMoQsqiEjVLJTJZgLjiVGqM7HcrwFD5pDOQzzef1zB
	b0avab9mpDW991eO2Bq4c8kNFwYhwHFHYnq81P1o40LjA437/m3pk/SRxVbDjoro=
X-Gm-Gg: AR+sD11hGOx36luHYCdBabeceZNDMbqK83mLODsHi6n3K3eMLl1Ct91ZLGSxPuQuDLI
	XW54DwvqFpZkE028Tod9kqrfHUEZpB2f2eNvTwmnaqXSaMBeFVfyHn8qjB8s0SrOa/hs5QiO5aW
	5adk2EPQ43BlQscmKsVxYpE9LYEpTRWzehpJSzOrfatkceLlXbANo8h9hioG1Y/FyIysbZMQJPj
	Rv5FZlYpVXJQrXn8ZmxwvV3LN7lY5yZkc/tvRROaFdi9fsn6EV4g1kgK2jF5v/GU0MaZW2IUqdE
	ijFvsTiXOOpKxntWJCU2h1iWtK+C5bP+Fgrq0hLtB48W7bscP1PqMy1UDlPWjuaqKIwQFSeL4jt
	lm3dXkaKvajKOTsGBkYxV1NeJAQwACf8UcQ==
X-Received: by 2002:a05:6214:3209:b0:907:bf98:c8fe with SMTP id 6a1803df08f44-90c4b3b832amr82744516d6.23.1787059702684;
        Tue, 18 Aug 2026 06:28:22 -0700 (PDT)
X-Received: by 2002:a05:6214:3209:b0:907:bf98:c8fe with SMTP id 6a1803df08f44-90c4b3b832amr82743446d6.23.1787059701954;
        Tue, 18 Aug 2026 06:28:21 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4580f611sm32304636d6.6.2026.08.18.06.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:28:21 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 18:58:08 +0530
Subject: [PATCH v3 2/2] spi: qcom-geni: Add panic notifier to cancel and
 reset DMA during panic
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-2-8b62c4bc2d21@oss.qualcomm.com>
References: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com>
In-Reply-To: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787059691; l=4545;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=BpLYbDTze5uFtkiCRqcEFWa/uhNMG9l7EwehucHfhME=;
 b=LWzceMtLaSx00PKV1NOaClTV6SVIcr+ol8WyWfyRqz+P3Md14Lcxe88mRt9e1rOLsaHVg7AkC
 KXAFeL3wo8aBclbdhwabWuT3a9B265E0sz5akh2ws3lQsGveno0TdsH
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: EUgoH7HQQwFEC7vVLkyf-D0w50EnrFEM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5OSBTYWx0ZWRfX/C8XioAxZdbx
 mCAp/bYv2vReuh3JZsCVcYctDl/sfxYm2B1RwE3GdMO0SX25Bl5eluncMTvyvbBX06AIhFM/PIL
 uAKxPNlmEBeMZdrmEN1zBgAlHZCzWVSwHGvmrhVzAIlQlmyiybcsFv5S+sMM0s96ZqpCHHO7eGx
 VicB+RBBHbNTp3daEMaaCdzsxO0WIiCRirrc5wQN4V7yZ917cS46ywG5YLUpRbKyT/bI/QlLiSh
 BR9HytMgOqm0r9GgLhgvncC6QxItnfGVlSeEC9BYdcqKB1G8ozkvjOl7GZECT3j5/Zu3mHfTn15
 pRGYLGJuNcUQYIVL4chhT1U66HuMZRVuUrQQPS2Q3QfY3PFbN0x0rUIg/Pc0e2hcwLnbZuqJC/9
 9xjhsbgsGZdHUboer+jZXahtVxN7+enaTxphw9DtPCdgDhvGlbGoTOXI7nhimEg82dbd8n1Kpxa
 ywlkCIWpL+2GlQv+rdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5OSBTYWx0ZWRfX07aOqLNOYgSv
 QrVimDrTde2dMqKClpjbC3Rf3WQWKfbMZqQtoHcXUGQXjhtzy2boQHSsJFVvvgQNwd2qqWuISZp
 OMZ56a3lTEuH6zxuFJ1h5nXzJQS+ZbM=
X-Authority-Analysis: v=2.4 cv=FsU1OWrq c=1 sm=1 tr=0 ts=6a845df7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=xoWfBlptTmbWqyQa1LgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: EUgoH7HQQwFEC7vVLkyf-D0w50EnrFEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180099

When a VM crashes with an active SPI DMA transfer in progress, the
SMMU raises context faults as the DMA engine continues to access
IOVAs that are invalidated when the VM's memory context is torn down.
These faults can affect other VMs sharing the same SMMU instance and
obscure the root cause of the crash.

Register a panic notifier that cancels (or aborts, if cancel doesn't
complete) the in-flight command and resets the TX/RX DMA FSMs, so the
DMA engine stops issuing transactions against invalidated IOVAs
before the system halts. For GPI DMA mode, the DMA channels are
terminated directly via dmaengine_terminate_async().

The notifier bails out early if the device is not runtime-active or
if there's no active GENI command, avoiding unnecessary register
accesses while the SE is clock-gated or idle.

Since panic notifiers run with IRQs and preemption disabled,
completion-based waits used by the regular error-handling path
(handle_se_timeout()) cannot be reused here. Instead, the relevant
status registers are polled directly with
readl_poll_timeout_atomic(), which is safe to call in this context.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c65c1788325d..f272bd0cb640 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -12,8 +12,10 @@
 #include <linux/dma/qcom-gpi-dma.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/panic_notifier.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
@@ -115,6 +117,7 @@ struct spi_geni_master {
 	struct dma_chan *rx;
 	int cur_xfer_mode;
 	const struct geni_spi_desc *dev_data;
+	struct notifier_block panic_nb;
 };
 
 static void spi_slv_setup(struct spi_geni_master *mas)
@@ -1073,6 +1076,62 @@ static void spi_geni_shutdown(struct platform_device *pdev)
 	spi_controller_suspend(spi);
 }
 
+static int spi_geni_panic_notifier(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct spi_geni_master *mas = container_of(nb, struct spi_geni_master, panic_nb);
+	struct spi_controller *spi = dev_get_drvdata(mas->dev);
+	struct geni_se *se = &mas->se;
+	u32 val;
+
+	if (!pm_runtime_active(mas->dev))
+		return NOTIFY_OK;
+
+	if (mas->cur_xfer_mode == GENI_GPI_DMA) {
+		dmaengine_terminate_async(mas->tx);
+		dmaengine_terminate_async(mas->rx);
+		return NOTIFY_OK;
+	}
+
+	if (!(readl_relaxed(se->base + SE_GENI_STATUS) & M_GENI_CMD_ACTIVE))
+		return NOTIFY_OK;
+
+	if (!spi->target) {
+		geni_se_cancel_m_cmd(se);
+		if (!readl_poll_timeout_atomic(se->base + SE_GENI_M_IRQ_STATUS, val,
+					       val & M_CMD_CANCEL_EN, 10, 50000)) {
+			writel_relaxed(M_CMD_CANCEL_EN, se->base + SE_GENI_M_IRQ_CLEAR);
+			return NOTIFY_OK;
+		}
+	}
+
+	geni_se_abort_m_cmd(se);
+	if (!readl_poll_timeout_atomic(se->base + SE_GENI_M_IRQ_STATUS, val,
+				       val & M_CMD_ABORT_EN, 10, 50000))
+		writel_relaxed(M_CMD_ABORT_EN, se->base + SE_GENI_M_IRQ_CLEAR);
+
+	if (mas->cur_xfer_mode == GENI_SE_DMA) {
+		writel_relaxed(1, se->base + SE_DMA_TX_FSM_RST);
+		readl_poll_timeout_atomic(se->base + SE_DMA_TX_IRQ_STAT, val,
+					  val & TX_RESET_DONE, 10, 50000);
+		writel_relaxed(val, se->base + SE_DMA_TX_IRQ_CLR);
+
+		writel_relaxed(1, se->base + SE_DMA_RX_FSM_RST);
+		readl_poll_timeout_atomic(se->base + SE_DMA_RX_IRQ_STAT, val,
+					  val & RX_RESET_DONE, 10, 50000);
+		writel_relaxed(val, se->base + SE_DMA_RX_IRQ_CLR);
+	}
+
+	return NOTIFY_OK;
+}
+
+static void spi_geni_unregister_notifiers(void *data)
+{
+	struct spi_geni_master *mas = data;
+
+	atomic_notifier_chain_unregister(&panic_notifier_list, &mas->panic_nb);
+}
+
 static int spi_geni_probe(struct platform_device *pdev)
 {
 	int ret, irq;
@@ -1161,6 +1220,15 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	mas->panic_nb.notifier_call = spi_geni_panic_notifier;
+	ret = atomic_notifier_chain_register(&panic_notifier_list, &mas->panic_nb);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, spi_geni_unregister_notifiers, mas);
+	if (ret)
+		return ret;
+
 	return devm_spi_register_controller(dev, spi);
 }
 

-- 
2.34.1

