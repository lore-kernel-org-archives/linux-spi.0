Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0DB3FC5AB
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678392; cv=none; b=szrEpnx7KFU7Ew2FSaseuqmu2NMIXb61MLkGIMidRjzquHZUeMF/AdW+hZRH3v/EUPjTcKw/32XVexOA9+B3T+MqzCy4MtsXScEWP/EHdsPKjHaFOfjobxht0mR4WrV/pbJcu5Q9r6beeeYz3Ld8z+hVpXEmQv6/NmOUMFFK0eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678392; c=relaxed/simple;
	bh=fp61jno8++niFT6E61fh+qdDmseCUv/upWK5jKW9rF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=px9E8yTWutSDqVo7AifeeN03Cb+9VeNqtrJjXs5d/zYA1RxwumTntykXn9cHxacVY2yDN1Wv3n0gtabycG8IleFXD85NOM9zBzMIra5C2QxuThad7svD4v82Md8C1SseiOyp8lS+0Ks19jPv46fV5+Ijf/9INEFqjOSTioGYY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PvQhTW5/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J3H7cvl9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PvQhTW5/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J3H7cvl9"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dfTo000391
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 10:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SzbP8oJYA7lcUAvmgkMoQ6cRClvc0YKd16KRtgIXt4M=; b=PvQhTW5/4hhjrrgA
	97x8FdCr98oqEst1fYU3R2AzLlMri3EztcmjXQEmfP9rIXZSoCXJAEmMmmNk0BaK
	GgrLTOjooFFW2+YRRaQi8NENS0KwqtQ28HQQa6yGLRzQiOokZ74boC0nvUECFYXF
	W8v9oOkFArWQT2Z2HztJzl2p5NbYiL5RyKxKH+lJ0RdV1SBbD/QOKwqGl65T0Kls
	1Krp2A1+TqCq6MjYZWqU8ZryHFjAxK5RBGuvybVwiffXhnyH0QB9cLC+LgJxkVfB
	DPYWn9V+gh2Ri1TRSKhYY92rjGr/tfN70eTg6NeDflXCLd87ew0m9Sc6z+lGYdtY
	BA/0xg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24us7s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 10:13:09 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84857446424so1456805b3a.1
        for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783678388; x=1784283188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzbP8oJYA7lcUAvmgkMoQ6cRClvc0YKd16KRtgIXt4M=;
        b=J3H7cvl92HkhugqYBmQcNDuHwQc1kSTanpTYAfp+6x6iO/5bQV7H8w4RuZJhrAjVyw
         W2J2TMkauEbwo6yyWFY8YmdvERR0XKtSh0azooMYTfiL3AQfD3GN8213lWm65EddyqAp
         9Qj7Xt9v1S2cAy9Y99+R2WKZSEdZ6ydvwcp5u2u4M5eeiszWDMWZKNwJiYm6AvhVxSvo
         LPZiNa3YCpIg41LCQ7GCvaX4XjNc9X3DATrVX4jVfXsLOw1tVBbynfN9UM6DFIWybHWw
         iSus6LLc5vv82SAtuvsORrKx98tJ54sE8Rq9wNJWzUd0o3uNIbzSEkyPAOZeQZ20DtAo
         GQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783678388; x=1784283188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzbP8oJYA7lcUAvmgkMoQ6cRClvc0YKd16KRtgIXt4M=;
        b=R+PiKXL1RbeOWvt0+pcZvQLqC9W2iJFQbfUPVHkyRDjV7dfiT0FY4GUe/b9lxZ/JXJ
         kJ+llufmSKXyteazu4DPwxLsmvlq9OaygxPp+2rIXNXn0tlrSH2pnZdYz4nPxEqyOAs1
         McWtnTFB9vuFjxl7VXrMlJm6tImIpDbz8vFYz6nIdI7c8WK4ZIiWRgVhNwspFwA4Jrus
         FzMBmCH3EjgUVGuhUUosKbyBKBHAU97FWGXliSyuYEplzCOgEHLsSzuFMPrXTCYEuKra
         4kqCWy00Q1paS3iOkTQentYM01fJq7wjQ3GjotymKZVa7P3k9bOHI3H/Z9M43fCn8O4L
         Kg3w==
X-Forwarded-Encrypted: i=1; AHgh+Rof3GsqhmaPFCbIPEpXc7vWTNhFkZqVkR98r2AiAK05xa2S50ByeDle0ScM7YlCQx6bvV6gOLnt9iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+t7YZpYoNf7c7NBkafW6zBffTDL2+/lpM7mLPliW+f1479et
	4wOBjI+PIY82axtb2FGbPqnGHEu+kuGZBgjxI2xosmG6KYj3otx8NgFQKM2VrtG5mTPSbt3RMTj
	qhdNxXtXVi1EmbogFVEXZ453BWhvC5fTLArLMO2UMnU2bOvBnmiqKjINWidXPfnw=
X-Gm-Gg: AfdE7cnyXEEAvJn3AIX2PnxagC22zd8yZvBtSZp9w1BNOkzdycRkwwWl2SYA7JcR2by
	OGAlSxcfQ30S0THt+WlPJu+LY8A9rQnGDK8K1sWoPGFak4WmuRfB4MofRVeZ5h/BpKepIS1CU8o
	PnekIhCf22IlG0GaUJFR7z+NYtJ57hgopO3VQ5chZAbZRnUePwBJ6CHur8ZoWUXzxn/jpox94oL
	wUVEM+tueEa8JLyDK0lpfZz20PwZT2dUqG4C6mbeWzPIsZm5O+9zeiw4MfTn1mTHQe6C4Ih31aX
	6PwnBoWh4Lg+BTInh/0dOlajyPifGwRzBIlxEOHf9Nrzj4nmlvOFgPlr1/8pWLTO77/A7M1GwI6
	lL6VYFNbR+2klBDuhvpDHIJN20XeYLxKwtFgEVtmbQJfK
X-Received: by 2002:a05:6a00:288d:b0:848:804d:9c5c with SMTP id d2e1a72fcca58-848804da18bmr438258b3a.38.1783678388536;
        Fri, 10 Jul 2026 03:13:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:288d:b0:848:804d:9c5c with SMTP id d2e1a72fcca58-848804da18bmr438231b3a.38.1783678387676;
        Fri, 10 Jul 2026 03:13:07 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a96fsm9977815b3a.46.2026.07.10.03.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:13:07 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:42:43 +0530
Subject: [PATCH v4 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-1-be81d6c15043@oss.qualcomm.com>
References: <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-0-be81d6c15043@oss.qualcomm.com>
In-Reply-To: <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-0-be81d6c15043@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783678373; l=1909;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=fp61jno8++niFT6E61fh+qdDmseCUv/upWK5jKW9rF4=;
 b=GXSYLi8r438TIXhUlxg8cHoKyYWoGVzcZUQcWC2ddFq1Wud8IbjmowbFPWlatss/e0WWZvCUa
 nMcPZtXkklCDp/PDbkouYtwW0n6usAERIFxGeC2QhTHh3bnb3YoVwj3
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: LimbARXwCkxMHpOJnrYrt-_ai0rUE3qH
X-Proofpoint-ORIG-GUID: LimbARXwCkxMHpOJnrYrt-_ai0rUE3qH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5OSBTYWx0ZWRfX4VCBlXt/vZRd
 aCXCqn9URbaXaP2tkgtVCLkdpM0qqp8BF0XyJI3HLotZUpMxm+xJcJkczmSIRTV7DyWR50ngZ6f
 avvEgU+MKbZxkPdrLWuWGzMWH4fghis=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a50c5b5 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=TpI2hjkGOM-ZtQ_OKuoA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5OSBTYWx0ZWRfX8d+u9/vwFneR
 KiMFRfne248YLhES82+jL59W+2deR3Y1Rdoqsp2rSOYygX2YfFysp+jOWYbk6FZpV9KbiWAAmVD
 kDN4xwl+bjxSjOtLGVDpqsXfaL5YZFUak2rue32dHgjUmGlUuXJhnSbhiWwMPiV9W3KEk07JVg2
 5ze0ayOMZ+WooViqGgPA9VztQKdvwRxIrVEj1wk39bIb9EnTOtr23re6UlLVaM6gA0tsbeTHY32
 Xk27ztt0pshc56H6/zuxbaqm4b7Rff64c9gk1TILvvBaDhrlEmHAB202BSa8kflSwr/uW7pAicX
 HCnISJmSsKfZPXHKPQIT4HgzhSJG6u7iGp7Okpla4LUOgtYsK2DZrUeHUlIBIKRTcDVbELI9SQm
 367t/AVCcBAwHyXwEflD2prWmlXNn4Z+krNqbNqe5Ntmcw1HhDqiatAz81ASQgRKewh8Sy05bw2
 vCFrUyYZnFEFYTXLYWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100099

When a runtime resume callback returns an error, rpm_callback() sets
power.runtime_error on the device.  This causes all subsequent calls to
rpm_resume() to return -EINVAL immediately at the top of the function
without invoking the callback again, making the failure permanent until
runtime PM is explicitly re-initialized.

Unlike suspend failures, resume failures should be retryable.  If a
device's resume callback fails, there is no reason to permanently block
future resume attempts on that device and all of its consumers.

Fix this by moving the power.runtime_error assignment out of the generic
rpm_callback() and into rpm_suspend() at its fail label, where suspend
callback failures are handled.  Resume callback failures now return the
error to the caller but leave power.runtime_error clear, allowing the
next resume attempt to invoke the callback normally.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/base/power/runtime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 335288e8b5b3..fab38bc98113 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -469,9 +469,6 @@ static int rpm_callback(int (*cb)(struct device *), struct device *dev)
 	if (retval == -EACCES)
 		retval = -EAGAIN;
 
-	if (retval != -EAGAIN && retval != -EBUSY)
-		dev->power.runtime_error = retval;
-
 	return retval;
 }
 
@@ -751,6 +748,9 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
 
+	if (retval != -EAGAIN && retval != -EBUSY)
+		dev->power.runtime_error = retval;
+
 	/*
 	 * On transient errors, if the callback routine failed an autosuspend,
 	 * and if the last_busy time has been updated so that there is a new

-- 
2.34.1

