Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D490381AEA
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665603; cv=none; b=L1Lxt6NjKDbkVdfmk/JcJnbQXJD34kil9pi2esgzg7lXmgNBhG3UyNBcN2zjNsCv/IOWO62g2X0UraEr1w12FE04ql27/4dpv9SJ3bINiBKQ8cHHg//Jnw4THXeOofu28mHU5cOxFZZgmCanVg1NZvprsnT0amZjaVjqct7GPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665603; c=relaxed/simple;
	bh=SjOl11og03T/5WU6hOpaEUyU6s8foVYXRLAbO8v6ijc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVV95AA4rXWdg48RFeIcfdNcS/b7pil90z/2ixpirTuf19xIip/MdYWiNa1DuEQXgjiqmooH4kPzFrzesZew6fPctW0Kb5XTmNRfAlXrRBQQle5YFPxJxjI1q984lT5hUOT/Y/hnEgKAh9L1rcOp0FtKNA8RfZVhSMAiF0jEB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dIE4jaoB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DdbbJAqU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dIE4jaoB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DdbbJAqU"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JHqkvF1856143
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zx7RVDr/dlI1cRr9QQQoDkEuCe7sJyRehaq1EXoZedE=; b=dIE4jaoBizMleXH4
	bj21mzNlfnld3Bm3gTOwsJBttPd4H0Bu72Jhd+hduGAfZS680zU6KzMiAXApJmvj
	zxkQb1o9DawdJlWetWWPbqXRnDM1XGnGEzkb+sJVQ2q9+bpkZVyQXBDHfagJwctw
	fFSPWYRVJClkTtLoHeAsAeMeDxIjylIQJ3vWeefQk/otMLN9+Rv4dn6XR6M6yM13
	C9oUJSDIlqUvQoxoNIxC1SWnJTm953amsLJKH1qQmq+AHCvjJfKpwJb25X1Ctotp
	sU8J7Y1deW5iHY0d0EiKoZFDvrvb5YJNVkT0h+eX96bX7PkE7saeadYyh1NQy64F
	hBqmUQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2qambn7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7977177675so1073398a12.0
        for <linux-spi@vger.kernel.org>; Sun, 19 Apr 2026 23:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776665601; x=1777270401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zx7RVDr/dlI1cRr9QQQoDkEuCe7sJyRehaq1EXoZedE=;
        b=DdbbJAqUjlV929l8oQwMhhnfBFqsFOSS2WBywemTRhSFjPUB0tLl5xuXL2Qmr3Pjog
         35Jj4vtrrqCp2JinsB0bbIcd4lU9w5TUc59BuXdJ4CM4j+yv8lhfyV3eHpu7VC2RY9jU
         cTXQzWElDlH+6tQ7vmi/XopFD6KKLlZiFVclar0rtKW0wR0jxVbxDoD1ydqF/A2yay5w
         V2dL+60POaGO/HxkXXt8NoMJfWKrdj1p76RO4qSkZLWv7PDsp8DUu5Q9ZQgqQg9W1Mry
         u7iw6kFNMh6xW4eG2osX+0dlToBncZ1J4ZAH4UpbdPidcR+Wv2paZF3KCzRhSGvERNXq
         TCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776665601; x=1777270401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zx7RVDr/dlI1cRr9QQQoDkEuCe7sJyRehaq1EXoZedE=;
        b=nDxdq9Zm66pDBRYpjTLz61PH54Gz8h02183WLWnGeyWujZpt1JDId7u7snnAWti44i
         Wy67VAUZV50y6FwmWu2quScJDjbKYgxuezSv6/zKpQeyyJ03HT+4GXYwPUhDDbUmRD1v
         xRNKUnOW+ufepkAa+jLtAJUHEHEg6/v5caLuFUHJw7qew6b9b8pD20teuZsXWTSBAzde
         pYuz4rcN4UIt7WYiIf9wMsahrjCN7xxRnSsZHcgHlG5WX7xJ4uqrfnBcS3ugcnz/kUR4
         cmNcU1YzYNb92itDB1R3tGI6W4Bn0v8AYXruBRoJqi6eQEzdHXQCmeOBRIIz/FundfwF
         3t8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8ax/4OTzgaBnAtgo2WTygswWI7L4qi98H8+CjGG9ZdDkaLp+iRrDV3iU3sSkiAsJaWZoV13q9j4R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUA+bAtmM8UnhFAVYESlw6UyNWuWETdw3DPCHnc2Vet1vg9izW
	oc4BmQVt7pwvUk8WbHkGg23hBVtyEux0cnMS9ZJ/ML0wjkyJAxI2Mg8jFA47ZVy0oSYLP6pbXn3
	hGPlCIfYkHPR+6COM3xG2qdFY2cuNcu9juC2Fdxu4OEgqrY/y7GOKuyQlKaf2nb0=
X-Gm-Gg: AeBDietcryQ9FlNE80vjcn1fmjzHSys5fDjLB3+bKqp3ex3VS4Iz2jsXNnPr5CB+ssc
	aRUPfd+HWYdiHpeUoDUrXYu3etUHBnnI88t16QBzCXQ5x0ntAv4O96z6dlh5OVZNnp9HbEfWdX0
	oNW4eZ+/A84ddpB+xbMgEDvu8J55tdqRNohwvysJSnbf1aFqKN6/8f8xfri6Q1p1MQ8Qj18X5Ux
	PXWsPXk25Zjz/grlbcthw4dR9e9p8yC418Dwj8L3EprA4amRwb10U720ZIQd3W0VuSqdMwTf9qP
	0QuU6NZ//c8Y/xjqRmqQq4NbfvmouRjmS6DsCDiH6a7jS9WObfQcGFWau5okokWYYtoosLQvGRa
	yF6i15E6yGACTO4LYzkt27qmVByDmdmW3kXXHBdub5kTK/4XYpO+KF29o9n6cdB5HXSY5
X-Received: by 2002:a05:6a00:14c2:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-82f8c856e48mr12421326b3a.14.1776665600647;
        Sun, 19 Apr 2026 23:13:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:14c2:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-82f8c856e48mr12421290b3a.14.1776665599681;
        Sun, 19 Apr 2026 23:13:19 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb28sm9018034b3a.13.2026.04.19.23.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 23:13:19 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:42:50 +0530
Subject: [PATCH v3 3/7] spi: qcom-qspi: Add interconnect support for memory
 path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-spi-nor-v3-3-7de325a29010@oss.qualcomm.com>
References: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
In-Reply-To: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776665582; l=4139;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=SjOl11og03T/5WU6hOpaEUyU6s8foVYXRLAbO8v6ijc=;
 b=FD2DqctI9JKtxi55yA0S7g6scsCBsZesbZJLUAdjzWuZXz9oHUzKhiVeMr1YI7pffyoYFqIOY
 48TLasakF/nD6GcnufC5QSc1gUiMWhH58WpF12HabNL4n3EKLgvNCmw
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-GUID: BT1N8ZAP3PHJMIHtau_tFG-tTv91SKVC
X-Authority-Analysis: v=2.4 cv=KdDidwYD c=1 sm=1 tr=0 ts=69e5c401 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=S70kITjG2mzSNXz8RO8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: BT1N8ZAP3PHJMIHtau_tFG-tTv91SKVC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA1OCBTYWx0ZWRfXx/P7/Vs6N2OW
 xhq2jcFU3vWTfihsxcMuht4iWm3BEtnV+/U9KMqdBRD3qaTr7W25oomevntcgtDbOvR+kWodzcJ
 tLyJfck6l8ynUsyg7qGb1qoq1aV3ZsbyvrP4FcOZanFIM0UKG4vShnKWp42oM+mnQlFhhPK5Bhm
 y73vUWOHLQikSQ8Ve8oJDIkfk1Er85XXTaBvQPcfuHuLLq673XMZnvShDS6K6K/JwVpC4TvvMoW
 GKA7WZS0iWrctl6RNvxSnqhB4jUi3h9XgygdUh8aRZDQ32N3GUl7gUhcFqZES1GKvjunLowo+9G
 Z7Ejm4rMIVcdK3kj0bh4+cXHjun0jA3nEIRk1EWFhLxYIngRJ8YnqYk4VQ3HIUhZ7c7Me4hsAXd
 xhuZGnl/tywOA7q9M0RNT1p7jCWxHRbC3T+qF6JCz5wVihCbaeMvCASEWZWz2+UWfUMAEq6028L
 PX3HsEs/MiAWLPQFd6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200058

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
index 8496c4a9f642..af1098f21146 100644
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
@@ -827,9 +840,15 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
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
 
 	/* Drop the performance state vote */
 	ret = dev_pm_opp_set_rate(dev, 0);
@@ -840,7 +859,9 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 
 err_select_default_state:
 	pinctrl_pm_select_default_state(dev);
-err_enable_icc:
+err_enable_icc_mem:
+	icc_enable(ctrl->icc_path_mem);
+err_enable_icc_cpu:
 	icc_enable(ctrl->icc_path_cpu_to_qspi);
 err_enable_clk:
 	clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
@@ -868,13 +889,21 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
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
 
 	return 0;
 
-err_disable_icc:
+err_disable_icc_mem:
+	icc_disable(ctrl->icc_path_mem);
+err_disable_icc_cpu:
 	icc_disable(ctrl->icc_path_cpu_to_qspi);
 err_select_sleep_state:
 	pinctrl_pm_select_sleep_state(dev);

-- 
2.34.1

