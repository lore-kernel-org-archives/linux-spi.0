Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBEF4C77CB
	for <linux-spi@vger.kernel.org>; Thu, 27 Aug 2026 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853607; cv=none; b=ZyNfCIOSaEQAPwfIblK4PPjWcSMgTYWMp2Wu+ZbXduQ4ITMqniHzTxLK0J7BMBVO5BQw1GnhvPz8VMwwIU3I6T0oUA2uT6j8MtM6xuJgYEIxgPrrHXHrH0Op0ztQ5LHkCVZWAOFfzdrqNcHcJ3F0ocZYW6d32jarF+qT2ZB+m3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853607; c=relaxed/simple;
	bh=uYtf63EywauTBDLjs8uD8MJtcy5tP9+vyAB+Hmv6QH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pKbS8qS83KivLVQKwynayAaoKxNBTfO7mfwxxgJWhdlrkw56tC0DHRDQxnPXwAX7wUjm6wj9VJO7PiXkvzc49jp8akoPk/saE0Q83vOHxGThP461Y9FkKke4Zx6UpinhlHAj+bUabPanmNQnsIy1d3RPwy5+A5hzLslNyNDJ0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I+Y80KM5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O9nEls7A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I+Y80KM5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O9nEls7A"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXl6f553913
	for <linux-spi@vger.kernel.org>; Thu, 27 Aug 2026 18:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nYbKd+3GajDDr0jOEfWiaOSW2NcTlBpxJd3GfO91+J4=; b=I+Y80KM51q9Yk2+a
	j4H/8pee737PHnA3HwQtTl5QnWER3ePY9GPJX8rYztgUV4jZuiM1lGNdmJVKnETf
	SyXWlrQFiQETA7yFO8fsTd3V7kA+KBlc6wNhE1O27MWafeUT0WV/RB6AtPhJ8po/
	8q3I9byjRspDJKIwxpqYn0lgGppFENeSo0P3fMOH2AbYWXIhXcXomPuCgem01Uqd
	IvUcx02zBKzCLsJkkjh4fNNISTR23DxSvAVL1YGy+DzJUcRYQQnN7KcxHPXE0nC3
	bIo85WSQ6Ui9xKj8TEb2b02hiwIVsnwrD+Ppx0yJuSrnVupxG2yKGIsghD2/YEDH
	0HG4/w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fhqg3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 27 Aug 2026 18:00:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-395543dc382so271259a91.0
        for <linux-spi@vger.kernel.org>; Thu, 27 Aug 2026 11:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853600; x=1788458400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nYbKd+3GajDDr0jOEfWiaOSW2NcTlBpxJd3GfO91+J4=;
        b=O9nEls7AGMfzmJqYa8CfKB/XkBQaGlkqhT7s3xHxiUs6qtBolpq5V1gUboTvPF3wfa
         GxOPF+iAVigDYebzIwmyAjNgf5qm3opcAFciSABtUu8d0HBmzvaA5qBWi4oV4bVMnE88
         Hk4tdEGu9jbIvEb+awm5K/cAOBprHeMViGmseG0ws1vqw5ypWOwF8TiEVE9wRaNMcVfI
         1+Jannx7ynzEcebPxZmGj/t71bCBj5iEyMRJlHfNdufE6WhrMRHauhRIjvOb4L5x6c0p
         s9HIaCNL/9GWxIjfafjwnXYEiufujZmG2mXF87Ze8y3xhk3O8BshzGOR5egAraH01NL2
         SMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853600; x=1788458400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYbKd+3GajDDr0jOEfWiaOSW2NcTlBpxJd3GfO91+J4=;
        b=PRBUCwK3uACygoqg0+13XtS1tEKhsjMRACnzQVqOmKhpvNQjDtgACir3hC+j4Xkwom
         CP77sUUwyVqZTtwTyoSr7NgDWLn9LQH20TnJMA469QAIqUer4lQhv99Y9UFyM3qEc9W1
         TguO3BayQp+LAeTs0LSevWrtZ4GIm46u/s1s3Jeg1+uCxN59HDT4OsNghqyr0vJXeXn/
         SP4x4rIpJBI5xNl+MvC/Vl+dM/fi2pXKwGRzD2YLJtFwIg/S2BylRdJ+X4GyQZIEDWZf
         Pe9rh4Ldg8RWpnqGyAGQU5A7TYzTlLOdd5IKjEXRzfqyqQeE86U3TEDN0SNd4kmgcZgr
         r56Q==
X-Forwarded-Encrypted: i=1; AHgh+RoEfomTPvQWgyHq3EG3K9fz94+cNY2Gt0slUN8pmHcF5c13C/RnHAjZ0LR3SByZcZVA+kATGs9PgTM=@vger.kernel.org
X-Gm-Message-State: AFuF++lEiAtBAaGVSLtXH6ffRLoZpWGUek7HPB4nJz6Y/OMZsgFeSzUn
	AI8QvjJXfHyMxvRi/XIejYD+SgR/nbpMiQp1VmzjP4+Pj+YGvUwrmx9qqzztfqnp1ydQC8iwMZx
	L4e8fV3eZNqym7UsFi11jcxloVC6kbJruBHiRqesg0Y0POtYD4RilIvEJKyiuSuM=
X-Gm-Gg: AR+sD11c2RntKa91l19RVcPHOD1R9bK+agCZ0pZohgi7jD2Rek2GLUImNbexWK/23O6
	DgvAXj9+t0IK4eSZuFP+0yCGWhO2O4vVfiVTaWuCmVFPL/eTSmIqtu6BkOpUXwZvzAww95dir44
	Xib8rpbOx7QlFlgN0cpceiiNHCCHio+Q8evEPIUyvPK5+PieqQprY7hUySRmMR0iGBIX/t+z+/u
	fD/Nww9JvX+M4y3Ft5RIQfxMK2K5t2PMDLcinmBeN7KAsl64XyJNATg0fXdufX83mWsq5wSUu4L
	JMQlaKH6h9VMLvm0I1CpsdmLBPZBpsovqw20oxmLUD317fCVpqgdVrJGpnLvslnsQL6qF6mlZBp
	0FYnhvycKREXvriXs/+YaobsFRkFsW3rm6g==
X-Received: by 2002:a17:90b:1a8c:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-396d0c0ffb5mr1795735a91.0.1787853600021;
        Thu, 27 Aug 2026 11:00:00 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8c:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-396d0c0ffb5mr1795630a91.0.1787853599347;
        Thu, 27 Aug 2026 10:59:59 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.10.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:59:59 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:29:21 +0530
Subject: [PATCH v2 4/9] soc: qcom: geni-se: Remove OPP rate reset from
 resource deactivation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=1510;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=uYtf63EywauTBDLjs8uD8MJtcy5tP9+vyAB+Hmv6QH8=;
 b=yuYXtqOch5+JdddKssp+xdvmeKhNyCOF/ql/3aH+DBJ9+vZFPKVWOtB1ybZnNXz8rc2iiV8As
 /p7XPI4/WDQAeVMiG8xWSUmsqYQmJgFqpH9oY3Y4fem4xv9ACoLmXqJ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX7M5ZfjVYac/j
 xEh3D046LmHoT0QWbslEPlcp3X/AeC1t9nnW1HjkMjoEuiOGhGHGYWMmgPo52kFeTXMluI+u8Qm
 hTdCa9g5mfbTorzMixH4F3MkcwinYG8=
X-Proofpoint-GUID: tT0hEwsTgHbguiM8gJiABxrfMwsU8SqX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX2cFwhoWCpH7X
 LXb/nAi5Ll26RB4xDAqxHPB2TXrVhn07wDqythJkeXeiMBovIF78RWgyLon8vPBGzLAX4RR6H/e
 6gJwyBaN25LOFOXzyUDV1bKcYiN5ycVVb1uEU9CmZKfcUocnEU888ULXiprQzxMcaG88hNVsMyG
 hy0oaPnz554h1gSRUhMZYiwPmxaVJ6/4ZOmusb1kWzsCGWOS75jC54KpkpJsdtrpyjxowzLUkAV
 QlxISbhuVYc3vakgT152GabcQfB8DrKtueeHawrOEMAe4fXyMsjyTouixkNka6c+ZOkaPp4qTwm
 cNZD+SL6BBK/qeCuCaWD/yjidw4PLF2YxtjwS3bbzXiK3JDlqrzm0XaBVTZrQ0LZ0rJmlaBkvaA
 crkDIyGT4ECj5184rSRCcWTdGcmRY+vdDPR54HhFec0TZKyVht1PCsebD3EBWcJUTNvSAw0C4yY
 FflH+fG3nctGVfiWFmw==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a907b21 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=dehDsB7WAhqrwfXEkZwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: tT0hEwsTgHbguiM8gJiABxrfMwsU8SqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Remove the dev_pm_opp_set_rate(se->dev, 0) call from
geni_se_resources_deactivate().

OPP resource management should be controlled by the consumer driver.
Additionally, clocks are already disabled by geni_se_clks_off(), making
the OPP rate reset unnecessary during resource deactivation.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 04f58a6f26ff..d4f0544d73c4 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1039,8 +1039,8 @@ EXPORT_SYMBOL_GPL(geni_icc_disable);
  * geni_se_resources_deactivate() - Deactivate GENI SE device resources
  * @se: Pointer to the geni_se structure
  *
- * Deactivates device resources for power saving: OPP rate to 0, pin control
- * to sleep state, turns off clocks, and disables interconnect. Skips ACPI devices.
+ * Deactivates device resources for power saving: pin control to sleep
+ * state, turns off clocks, and disables interconnect. Skips ACPI devices.
  *
  * Return: 0 on success, negative error code on failure
  */
@@ -1051,9 +1051,6 @@ int geni_se_resources_deactivate(struct geni_se *se)
 	if (has_acpi_companion(se->dev))
 		return 0;
 
-	if (se->has_opp)
-		dev_pm_opp_set_rate(se->dev, 0);
-
 	ret = pinctrl_pm_select_sleep_state(se->dev);
 	if (ret)
 		return ret;

-- 
2.34.1

