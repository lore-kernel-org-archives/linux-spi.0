Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76BF2E8B98
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186533; cv=none; b=jOFkx+2aS2eHPg76E8Z8k9XSmzjMcHTTUy0sU9uYrJj0RtykoI2qfx8NaukpM3vT7dQIGBjjoy0qGWGc3Ipuq/hRE8SY2htxz3YYkBKNfT7CdcLRvRzICW0OTI0DSlXcEY2UtkgXbsUYDIg5ScFzcWpCXtwItIVF+c6iu4soG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186533; c=relaxed/simple;
	bh=giVYQbZ3mh3S8oI+9IBZ3fGJ5muN4sGFK18wlU97hJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mG811qLVoWbZ/Ku1d9gJhpRDKcBlZr6WfOT1x2pLhTxYhjWxZfkkhkC97GgyzpkbTe0srmfnuKHolMyrX2QxtGibxTPniSTmuRC2QeDofWQrg29T1BDVYpYNqsLbAXTZXG+hVRtofrRASN0afjlXxRv2dGwkmOZIDP2X0Ul9UW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=obdR7SFb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fTVQS1yo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="obdR7SFb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fTVQS1yo"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EG4TE22005522
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	as9+0KYxE7ralBTHQ6IymqjzxFcbYhhm7JSJz7ngJ00=; b=obdR7SFbc3pgQqsn
	zpiT6LsAYY3yaiCcPz4lnvuaa60IK4LGYq8JWvOjyeOh1bpd8hjEv0NGw4TQTICI
	KKyVnfZ+osqpYysVweIZAnAoRaGoWsJxlL0kkOeL7uPtd9SelGAORw+xjsolyp40
	P5NoaS8dYHaLjHgGxjvLrrspk2KYC7rvDGGSw85n2Q+wk0H5erykMjSJp1fbGRxw
	PqE62AD99D8JuRL9cprn9zB+Tz73V05OFVUyI6kfJXSNbGruo0mhWU4vPCK5LN7n
	Cm7CSKhZEtAZD+OQs7rZKUE3N1giYrcwk/fGyPHMEodmZ2sDrGSgrPxajs3EFOPh
	9LlX9A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrsjr8k1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:08:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24611696eso43312915ad.3
        for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776186530; x=1776791330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=as9+0KYxE7ralBTHQ6IymqjzxFcbYhhm7JSJz7ngJ00=;
        b=fTVQS1yo0gFgt8nbzDeUOx++0BbBVKT6wmNRfMZoac7BEQfwuhMr1B9VxKXJauGmJO
         216/J9iA92+nVBRzLWSZmXbuD9Ya27w58t+McTuVja/rCiKfzQJU7tsGP81UMyfGv9VG
         H0W3fTXyEL/+J4/BPAlz5Iq/SHWZMfvDReSJv99qKrnN9xcoM4PTfYiAUihllXI2psNC
         oZQBPNwLszUMZQU3J9nPcr3Z66Z8EbzpZWCZBXMC9wsWDLORLrQB4enkFc1cu6wJiPgx
         9pEEMmdDMPAUyupbjVvEhkO/5ijXPH3Bu+j2SOmiQOKDKLs7Rnb8uoJlWhiqdXK03SC1
         hnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186530; x=1776791330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=as9+0KYxE7ralBTHQ6IymqjzxFcbYhhm7JSJz7ngJ00=;
        b=AO9i9PeGSz9mzRI2h+vG571UGUq4W6DpcuEEdlonnzAQRTXaum5d3H955QEKYKxgNu
         Kbx+ag+yXvepU3Rxkblp/KdzBijz3at4wOtfqjA+NGfLySeXgoIHRu5JZcqYLjMmoXe4
         FKc8aGpIFpJJSotoNtl/QvS0ePwRxrOk+rCyDKR66OxMFpLqBDR4lRdSKYaNwP13Zjq7
         LGHz4aIQB/gFW+Cr7M2XzjHtrXpk4MO1DjkdmuaQmbI8TBmFpyBYm2fOFLgCzWoAQk5J
         l5/SGngqZYolTUv5iDW1XNHQabhN0ZrjDR6LHhYe5CXymh9T4ZRV7OOl/zqqFkPBlQOc
         0wQw==
X-Forwarded-Encrypted: i=1; AFNElJ/80M8ORaj+mY6x3HXymRa8Kzu09YJguSBzuAXKAcWL3oAxSWT/JIqUCSA9TCBAxgjecRvW/dnSh9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVlGHn8kWLUGJ/GRZdE6sfr0fdCdH+qEr619Dk05HEoLjwQQlN
	ivHKtgvCZov2Qp8eeFf10PBMxslrvcwlJylSi5d6mp5nScaPNpwKUukZan9gOblBsjzj9be+SVn
	rMJ/+RUfTtjvoqoGDfcZVW5xDY0U3ZiUwSVMUT1/oSfCO2Uv34tlcBXpapvy1xfI=
X-Gm-Gg: AeBDietRBraFyDG/sz8fcTrQe6urqXgXySQTvEXiC6w93Q6N2PZX2pC0rEtlnWeilDA
	y5du0+srahE/yCIF0HZ0z9wf5qQF3DedSBlm68dcs9jvUeER+Ivn0zWkWBOahrVT+YR6mKHYoEP
	3mNyJfEU2p29YJiSxEzoyhaZ1oup15NKzGLgNiQbi/bBF6cgZckMRthHPC1k5ukv9K+ykjTX6vl
	3jmvCYKg/Tp1zh12SYz6rpK/biuSquZIczGlifAUVZIknUs3Zdik9LK5/pz+O/qwTnzamMVvzMq
	zA9USLwWX2UKmAyOiXZGOHvSoF7NH0GChWf1bD6LbyMhGne5EtMfHT/eUMOmdhmMPY/N+46m5uv
	Yv74fcbkqMCOrjh1dsgGuJqyPWuN7EcCltDh891MG43FinFH9Fia089zrgpSTH6IkYhl2
X-Received: by 2002:a17:903:fa5:b0:2b2:5857:6011 with SMTP id d9443c01a7336-2b2d59e0f95mr192515005ad.19.1776186529789;
        Tue, 14 Apr 2026 10:08:49 -0700 (PDT)
X-Received: by 2002:a17:903:fa5:b0:2b2:5857:6011 with SMTP id d9443c01a7336-2b2d59e0f95mr192514525ad.19.1776186529205;
        Tue, 14 Apr 2026 10:08:49 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45d1ab540sm97535225ad.40.2026.04.14.10.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:08:48 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 22:38:21 +0530
Subject: [PATCH v2 3/7] spi: qcom-qspi: Add interconnect support for memory
 path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-spi-nor-v2-3-bcca40de4b5f@oss.qualcomm.com>
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
In-Reply-To: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776186510; l=4136;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=giVYQbZ3mh3S8oI+9IBZ3fGJ5muN4sGFK18wlU97hJQ=;
 b=CtqfqCZbGAhjUNnMk7Dy6KV1IIkNZkWmoudLduXchb1c27DT8VjF+TWBXYWuWyz/MzYQRx9D5
 7a/2+mujXywDof0n8isbDlhagmRr2dRRYHU+5td7jul7GgVSJgbbQ8p
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=WKhPmHsR c=1 sm=1 tr=0 ts=69de74a2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=S70kITjG2mzSNXz8RO8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: dLhBOCp6Op9p_H6kt15yJnNl5mw6lXwh
X-Proofpoint-GUID: dLhBOCp6Op9p_H6kt15yJnNl5mw6lXwh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2MCBTYWx0ZWRfX0iK/mM2QcSR3
 Rk/M6zn5rrY5yuCPVFzo0gWUVYTMnx+YU+HLEZIu+s4+AdYt6nffkEFEvdwAR6I2xdRtIqKeGID
 1ifjieaeQQAigEQvdXznK1NjmMcVqte/TCcqZhpwaRv/rP7T6MwaN1KXzLVOl9nkINhNdWFniUT
 hwD7/tohBuUFJAZnrN0/xn/xbARq/nZP8WupWv0KFpVf01o6JbO1vO2oh8CRJBSaJQppN2p9awn
 BJy1TRNj/HXgqCy1nJn/2bVGCh0MuqrAZj/WhtcNS9uCSrz7AYzqcA4rNGhbkeT9dVRY2wo2Cl+
 OuNRuE0HaBHOSXuQ4NQ4lOM+YAeHDMi6dC0go369m/U8v5ztij/0yQ9Q4MsqRxZc1UY0OhQLQN8
 9Rr4AkNitoZ+85vX3qWWADy9DKwOw5L0xWNLL4mje/NPEgLIPczMl7bQQlEoUe0c9HLD1mpl5g+
 6W6mUOBs5CAkBG8t0lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140160

The QSPI controller has two interconnect paths:
1. qspi-config: CPU to QSPI controller for register access
2. qspi-memory: QSPI controller to memory for DMA operations

Currently, the driver only manages the qspi-config path. Add support for
the qspi-memory path to ensure proper bandwidth allocation for QSPI data
transfers to/from memory. Enable and disable both paths during runtime PM
transitions.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/spi/spi-qcom-qspi.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 38af859713a7..c89d50d67dd2 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -174,6 +174,7 @@ struct qcom_qspi {
 	void *virt_cmd_desc[QSPI_MAX_SG];
 	unsigned int n_cmd_desc;
 	struct icc_path *icc_path_cpu_to_qspi;
+	struct icc_path *icc_path_mem;
 	unsigned long last_speed;
 	/* Lock to protect data accessed by IRQs */
 	spinlock_t lock;
@@ -272,7 +273,7 @@ static void qcom_qspi_handle_err(struct spi_controller *host,
 static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 {
 	int ret;
-	unsigned int avg_bw_cpu;
+	unsigned int avg_bw_cpu, avg_bw_mem;
 
 	if (speed_hz == ctrl->last_speed)
 		return 0;
@@ -285,7 +286,7 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 	}
 
 	/*
-	 * Set BW quota for CPU.
+	 * Set BW quota for CPU and memory paths.
 	 * We don't have explicit peak requirement so keep it equal to avg_bw.
 	 */
 	avg_bw_cpu = Bps_to_icc(speed_hz);
@@ -296,6 +297,13 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 		return ret;
 	}
 
+	avg_bw_mem = Bps_to_icc(speed_hz);
+	ret = icc_set_bw(ctrl->icc_path_mem, avg_bw_mem, avg_bw_mem);
+	if (ret) {
+		dev_err(ctrl->dev, "ICC BW voting failed for memory: %d\n", ret);
+		return ret;
+	}
+
 	ctrl->last_speed = speed_hz;
 
 	return 0;
@@ -729,6 +737,11 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_cpu_to_qspi),
 				     "Failed to get cpu path\n");
 
+	ctrl->icc_path_mem = devm_of_icc_get(dev, "qspi-memory");
+	if (IS_ERR(ctrl->icc_path_mem))
+		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_mem),
+				     "Failed to get memory path\n");
+
 	/* Set BW vote for register access */
 	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, Bps_to_icc(1000),
 				Bps_to_icc(1000));
@@ -832,13 +845,21 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 		goto err_enable_clk;
 	}
 
+	ret = icc_disable(ctrl->icc_path_mem);
+	if (ret) {
+		dev_err_ratelimited(ctrl->dev, "ICC disable failed for memory: %d\n", ret);
+		goto err_enable_icc_cpu;
+	}
+
 	ret = pinctrl_pm_select_sleep_state(dev);
 	if (ret)
-		goto err_enable_icc;
+		goto err_enable_icc_mem;
 
 	return 0;
 
-err_enable_icc:
+err_enable_icc_mem:
+	icc_enable(ctrl->icc_path_mem);
+err_enable_icc_cpu:
 	icc_enable(ctrl->icc_path_cpu_to_qspi);
 err_enable_clk:
 	clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
@@ -863,9 +884,15 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 		goto err_select_sleep_state;
 	}
 
+	ret = icc_enable(ctrl->icc_path_mem);
+	if (ret) {
+		dev_err_ratelimited(ctrl->dev, "ICC enable failed for memory: %d\n", ret);
+		goto err_disable_icc_cpu;
+	}
+
 	ret = clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
 	if (ret)
-		goto err_disable_icc;
+		goto err_disable_icc_mem;
 
 	ret = dev_pm_opp_set_rate(dev, ctrl->last_speed * 4);
 	if (ret)
@@ -875,7 +902,9 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 
 err_disable_clk:
 	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
-err_disable_icc:
+err_disable_icc_mem:
+	icc_disable(ctrl->icc_path_mem);
+err_disable_icc_cpu:
 	icc_disable(ctrl->icc_path_cpu_to_qspi);
 err_select_sleep_state:
 	pinctrl_pm_select_sleep_state(dev);

-- 
2.34.1

