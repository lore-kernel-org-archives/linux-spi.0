Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4A414DF8
	for <linux-spi@vger.kernel.org>; Fri,  3 Jul 2026 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091160; cv=none; b=CG4pYIgvzSnqap+CxVT2/7V8rKws4qT3Tzkv72Au9UlhPhiFNr3Pc7elrCDt1EH2JyMSr1dDnUGHznUfn0kao/oJ1HpmC+3z3TKmxVpf85OUdBMQN11l5f1zDAZBrCaZXkzHtLOJUdR+umAMUeMrTEpAry0GGvPXnR/XYQuYQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091160; c=relaxed/simple;
	bh=CxSDGrGNPrn/f5+nMWjh2s3LE8mRw+4kULPIPcanjEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rzB3fL/sS8vDlAaMZBvTRfwtgp5SuqBQV3O8/F6QEKBecjE7CqxaVIlrAY4irplDqE4oxPAWgEPFOil2XhBMbMBURmpktSOwZsFs227LNYLyscAan4PghdxQEbNt+osGKFavJKqx0yjzqkgq5x7GpkJuDluk2aPMCb5daiIrxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LcotVmxO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dj0rLIVd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LcotVmxO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dj0rLIVd"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BQobZ3136103
	for <linux-spi@vger.kernel.org>; Fri, 3 Jul 2026 15:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8y6oQ4O1PrHXWEquRWNJMTThi3u0P0It3nfZ4zz+tEY=; b=LcotVmxOSL6VxQ+G
	rKDzMiieqY5JNcqRoSE3x5EBrye2NY2w9MzLvEkucKlTfV3cvyz6xxZtq0hvQuW4
	1k8VWnIX5/rD24kXq7pD1dwbFGXwhoxCN4HYZulqZ8+y6XbvIeFuEUtt84e3lueK
	vYtv86zAwEiPQEUC7Tg8TUA4Ww0XDD7nS6IYi/VqL/xdqeIvrDLaY6ODmgQ3iUM9
	jsGmNiYfTXB/jnIfnxTueN5mDhcSLiUpMr3K4iYUxsKNiQnlyWvf/Mk8nc18keOK
	OQTNzed/dh4ls5wYiw4554EyGHmfkXo3OKD06cjvZlINJ59+OFL7HzWVHkmM+Lox
	znFXRA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5aup7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 03 Jul 2026 15:05:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c80be91ea3so12097295ad.1
        for <linux-spi@vger.kernel.org>; Fri, 03 Jul 2026 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783091151; x=1783695951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8y6oQ4O1PrHXWEquRWNJMTThi3u0P0It3nfZ4zz+tEY=;
        b=dj0rLIVdkpcZXy5ARZ/DisEBgtjRGUcUGic0NTTdByMSVi15yM7eBMc4vET6q9oCIc
         GlUdX63vOzVe7Rynryp3bqYx9Dw0y0mgxz1ODxEs4JfMEruHO67QVvY3WZn+djubsE2z
         UWQwRaIP5DPEGsXslTyGoalEceCnKLQ/fEqmKDNBQMmU1BPB9S5qjPGIDyutH+TibUSq
         GwceFBy9BIHLbd0du1I6GXCZ5MREcCrsei5kxDtzRnGMo6qJnn0a2WftTf+VeVuOU1rh
         A1TBizRFOdH4NFzkh3PgVQui1nS//ubWylk/aTwhNh/QgFlHL+ej5Fa1R6zHKYqpEoNn
         4VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091151; x=1783695951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8y6oQ4O1PrHXWEquRWNJMTThi3u0P0It3nfZ4zz+tEY=;
        b=aoVwF2p8m5aCC6NOVbMkf6xmCc6LFfSss/UXSARskOellUrgnIeMYZCY4svk9U7Y5h
         ljeRygaXvocHMG4P0U+/AxVlORDQVOJVohFz6krB/mx9K5GGkllYW4WjkzPjCq9H+ELF
         q58UAszHKA+X/K4/pWciWqz7nmlZ5ziVO0OPq1l7DGiEkH+q1ZBt+uUvqQiVpFiRhfQ1
         u3LtGuPPw8UjTUZBxKOC/PGp28kPWoYFkiAt8AaKNTuebQK6Rl5wcIcfu80YbYscnbFZ
         eDpn9u8XraoorlONOyj/+1bl8Xv4MU5JhasYj/ijoaI/M6P0ioamCy7yEJ9yCqP52LOC
         nGEg==
X-Gm-Message-State: AOJu0Yw+j4C6JlaJ6uZWzrmZrR/uDbhNJGAUTAKSw0pWXQM+cAkPy3z0
	8ShZoYnInEJ+RFbyiaWn2FyLbahP441JYwrofAh8/1d0ip/5abznrMU9wB/bXu7juSr56LswpO7
	hZ2QCbXLMZN57QWm+FzHXVdvghL9XyQzy4gmIkpDsdYR7GMJ9QfkxxvFcfBPWuxk=
X-Gm-Gg: AfdE7cn99QyZz3jG9jSxgRiWnOxeDMGzWvOVSCKkoHAZQR92uHZdXhKYLXnUyiaiBIJ
	EIrAdU9O6t+Enwf61GaKxE2ERMDNJVuATwFvEhpli1u+3uHtTJC6xcZRfJeV8wLsuUFDETgFQL8
	tQHV5oSK9KanZBBPPb6/X65bZQuZp5Sw9pB0LHryjyjIKvckDX7YxQtM6cnA1uqGAEu6tLR246Z
	Q/DfYnu2HCnzOhaostLLSN670DqeGa5YvJ4E8fZNPzNN22LQbe/X/qpamE9zuUIk7vCsmhKnXJT
	JIYTPRT1I1v1lAJdbZABt/7mntPrUN3/G3NpAgAUirGuJ68KIryZ5zYJkL/8wuQI4sqEuQqxr+Q
	nr3zgf58e78yXYyTc/vyS+uluIRx9rwC9DfcncPo1t/zV
X-Received: by 2002:a17:903:40ca:b0:2cb:2b50:d9e5 with SMTP id d9443c01a7336-2cb2b50db6cmr505095ad.45.1783091150792;
        Fri, 03 Jul 2026 08:05:50 -0700 (PDT)
X-Received: by 2002:a17:903:40ca:b0:2cb:2b50:d9e5 with SMTP id d9443c01a7336-2cb2b50db6cmr504575ad.45.1783091150235;
        Fri, 03 Jul 2026 08:05:50 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85b345sm32904517c88.10.2026.07.03.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:05:49 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 20:35:21 +0530
Subject: [PATCH v2 2/2] spi: qcom-geni: Fix missing error check on
 pm_runtime_get_sync()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-2-578b78a0cf46@oss.qualcomm.com>
References: <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-0-578b78a0cf46@oss.qualcomm.com>
In-Reply-To: <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-0-578b78a0cf46@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091129; l=2738;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=CxSDGrGNPrn/f5+nMWjh2s3LE8mRw+4kULPIPcanjEs=;
 b=GXpErkxbu5zSV355CLd1HAsbeyFy81q5EchJ5XeCQugAQQ1WDNyNc4XFo1V7ggaPPcEsDlrOO
 Xrq5d/i4PbvC4R9ZwZk0tKpNptXMscb812LA1orTH1BhrYUssUTNfGT
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0OSBTYWx0ZWRfXwC7XQSJMb7ab
 rQzMUbUVAzYa97i11F5yDdaW+thXJdbHMxyD0OsW+liSj3fmpsD7heWRubOzBeqcuIbm8pvWsYo
 yswy+1sSvJx86nL9n/d6FRQ+/tJv/Cw=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a47cfcf cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=rPJgdety-6tgKaoqdU0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: GK3GRKbd-3BKsNX5sgnhAlJSTRDaIoUF
X-Proofpoint-GUID: GK3GRKbd-3BKsNX5sgnhAlJSTRDaIoUF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0OSBTYWx0ZWRfX5P5XnW2u9rG6
 4UnpLCOfi6MmiWFEmcft8SeDeC3MIymMXvwIVpRBydS/XtMeS40v+bBrsm5wZz6jfgeK+pWwhOm
 yg08VXBjUH0AAghDV4ZmaR0pnyJigRJm8kOl5j3t1ZhuK9etDq+E7i2YDNkzy97WbIgjQESlXJA
 PKDlD/6uiRQQPO6oZCQIqAZk4ICnZFqtxWjYVQZTcopBa1M0NkhEvbrpez2fMlF5FGHzkUUlE0c
 pAjLrS/uzU7mcADStgXWd0js3LELeU2l4EVZsa7Ron0UGfk5dVVBdwledJIKVNzLXWomkh82B7j
 aOO+3N7olitbsL9Z5BToooAHD4OTbWps6xqtcX4KsGAQoyYSyibz2qc/OubuV0Uk5MDgTUQDD7D
 xYnMmAPE77W775u9F9BASwWfPditm4wK7FEfbJaszWA90UZ1s2N6/LC9Ve386Nlt8Q2HnryaMWQ
 TVcRYHTohwzLN7i6ZJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030149

spi_geni_init() calls pm_runtime_get_sync() to power up the device
before accessing hardware registers, but never checks the return value.
If the runtime resume fails, the function silently proceeds to read and
write hardware registers on a device that may not be powered up, leading
to register access faults.

Fix this by replacing pm_runtime_get_sync() with the
PM_RUNTIME_ACQUIRE_IF_ENABLED() macro and checking the result via
PM_RUNTIME_ACQUIRE_ERR(), propagating any error back to the caller
immediately before any hardware access occurs.

Since the macro handles its own cleanup on failure, the out_pm label and
the corresponding pm_runtime_put() call are no longer needed. Replace
all goto out_pm paths with direct return ret statements and remove the
label entirely.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 26e723cfea61..a55a3afc0ebd 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -613,25 +613,30 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	u32 spi_tx_cfg, fifo_disable;
 	int ret = -ENXIO;
 
-	pm_runtime_get_sync(mas->dev);
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(mas->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret < 0) {
+		dev_err(mas->dev, "Failed to resume and get %d\n", ret);
+		return ret;
+	}
 
 	proto = geni_se_read_proto(se);
 
 	if (spi->target) {
 		if (proto != GENI_SE_SPI_SLAVE) {
 			dev_err(mas->dev, "Invalid proto %d\n", proto);
-			goto out_pm;
+			return ret;
 		}
 		spi_slv_setup(mas);
 	} else if (proto == GENI_SE_INVALID_PROTO) {
 		ret = geni_load_se_firmware(se, GENI_SE_SPI);
 		if (ret) {
 			dev_err(mas->dev, "spi master firmware load failed ret: %d\n", ret);
-			goto out_pm;
+			return ret;
 		}
 	} else if (proto != GENI_SE_SPI) {
 		dev_err(mas->dev, "Invalid proto %d\n", proto);
-		goto out_pm;
+		return ret;
 	}
 	mas->tx_fifo_depth = geni_se_get_tx_fifo_depth(se);
 
@@ -664,7 +669,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 			dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
 			break;
 		} else if (ret == -EPROBE_DEFER) {
-			goto out_pm;
+			return ret;
 		}
 		/*
 		 * in case of failure to get gpi dma channel, we can still do the
@@ -693,8 +698,6 @@ static int spi_geni_init(struct spi_geni_master *mas)
 		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
 	}
 
-out_pm:
-	pm_runtime_put(mas->dev);
 	return ret;
 }
 

-- 
2.34.1

