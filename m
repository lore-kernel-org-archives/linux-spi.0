Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E044685D
	for <linux-spi@vger.kernel.org>; Thu, 27 Aug 2026 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853621; cv=none; b=uhItsCupeuYLVl4h3MucSzj1NneQqq5jX61La2JAP0wCpWsH9gnofDzMKRGREU5H7iEVNUG1zOMCJxjm7I2W+gy08ghnrkcmUuX9++1vFKkDB9O1r8GWEudtTgM0WF/tKyz+9s/X9JmigqmkWj628n7dxsntfVkLYZLhdqY3dUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853621; c=relaxed/simple;
	bh=evZqvwjAfpStMv2Htuq4lxgmNHVsv9xwkVK1wPRutP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+kWswN5V81u9U4znKYqX4vMq+UQdfDK20K+tOFNSA+hla1gXBlPpGqf427fydH7OkztdAlqmbq7mk5IH8Jr2XJXqSvb2qgvu8lqLWUr04JAH/boE3I4jYWMxzedtTMHN+Ns+H+hVA9FJEk4R90AndVzJpxiw2GXbmuUpztKmRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F5VJpukA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QV07Sl76; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F5VJpukA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QV07Sl76"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXujR314015
	for <linux-spi@vger.kernel.org>; Thu, 27 Aug 2026 18:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qrrfuWLil1sBb6og+uepTDULJhDr423OHDhRzRLmRws=; b=F5VJpukA8nWWoEm6
	KEH7FFOV6rDAeXspvFNaG51xo6w8ZQDOBPHNSX/LrFQsATXjoSxXFSBSGYqmN8ah
	QZ8HF2Tzjeg4lXRIfsPMXGoIJT4yo8UV5ZvfkGtWl0ax2ZlJaWObl+Ei3b2YTNoW
	zqZMnz5tO1JcHJf5cdC+l8zDIJJf6Pm6xTQMMi8ziln2xNGard/TvD8tIZ+P0ogY
	Q6BCwLer7SpDqOaT7NoLTpDAYkdDycnSOm6zgR0+nLhxFCe3TAWEleIsqFWUwNaV
	34RA+5UvTlJYumqVe7IW8oac8Z38UF29rfkkvycGdFTp0wmSQ4WKVGnwP6F+6/3l
	13bmgw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak561x4a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 27 Aug 2026 18:00:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c856470fe9fso118868a12.2
        for <linux-spi@vger.kernel.org>; Thu, 27 Aug 2026 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853613; x=1788458413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qrrfuWLil1sBb6og+uepTDULJhDr423OHDhRzRLmRws=;
        b=QV07Sl76foRKCnMzIBNnTaQcBBWABQZh6shTwRo57uZcaNBa1VzhBTHSBjc+7EC54j
         8GmPuWF6SCVboVrQBzFhbqiyBuulTLbpe1uw2JsnSGpCtulAubUHsee8Qib9LTKKJ1sQ
         kyiQOzfzzlzhL2+dqaheR0eVtvNNhEFr+lgiv25FKq4fFWf+ibhLf4WFpK7JGsBKRsaS
         0sFMQ9JdwM50Agl1S4w9/0FJEIl8cxBx7yGluf00SLHqyNXb0QkWNQaX6delpP4Nv1yD
         ff7BTXyK58NFD+jPSMYLhoKbiLlc+BjbqCehET1ynUnOEyRGHiwP4+YV/h7BmRLGtmwg
         vK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853613; x=1788458413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrrfuWLil1sBb6og+uepTDULJhDr423OHDhRzRLmRws=;
        b=dRXsAbNBptj3ngFcOzbqUoG17a1UKD8Z8BHyDkWbGu/c/GcQSDF5TcEhZvNbu4YWDK
         4B+3l0urA2YHJrcO1YNmOjxUZMjjpMGAyzMmVwcFouJSoxNYiWkh5arXa9+XjAvJzHZ8
         lopvADEQY6kJDSfZuNuhH71SkziFFcXQfmG9PLspDK+gtL3Dyw2QzugW7Moo9bDWRfzG
         u1MZ2LzChq++bGWr9HIc1hTmI9xoMwNcuxWKgi9nnvqku+W8ABo6HFkBbjtmeQpz9Wty
         MOyMSXmhmNGeoFYy7PuRQjl+7zrUDgAfhH+PWBiJrTHXxLpU50a8nCSRv/reV0Yio+Yc
         rI/Q==
X-Forwarded-Encrypted: i=1; AHgh+RraLu/YSfUwSuGYS/0dGR/or9BHyZUkyUmG+/2LdPbh8kyurEchOAwyU0BUeKsJqqhr8WVk7ED3wQQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nEWqEvhpkDLLpZCGk73y6JAIrJNDKkOJn0gRar0G5oYH8QcdX0
	S49jU3CBfuR/k3+6lEh5UDhZfUS/PJ6j2/Obh2yzAv/u+QEqsMTH9TmCiKTs0mha9z/mrt1tj7m
	GVqGho/mrce6wSsXFiJ6rl7RqYgTUUS0t2pRMCyIvsnpJ6u+LXgk5ptz0XzF7HeM=
X-Gm-Gg: AR+sD11PJT8aeaZyJe6sM95LFlmcO6m0E2Hg4Xz11baCYKioxD07fpq66X7bbsibb2R
	6cCwoFE8YUzUfXLpHfxqqSeby+4tT1L3H602UI1cLmqX92Y1eHlbz7mvA/YfFI5TTa/gWBa4U/z
	MpFMM3siv1XF3T13ZEbN53WQCj3eXaoWY9YlK4W1NxgrDRyk2uWNcDIIPrv+QnRxi69vINKBteS
	BhaOF7c/Wm/xxclv6V+eylzlButPaiff+u8xa2EMD8meUO0xdSQ3nRcyyG9x1fVhzSGtxsAkO/7
	eJPxKuJH0GgVeoPfJ8M4zcSQwS5QctARqXmK7cQCHSdixqhL/QeFKeqyL903wovMgHisYaDfFSA
	kdaKr6P3hMj6Ye4NYBl1dz4MI83A+lu3oZQ==
X-Received: by 2002:a05:6a20:b7a7:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3d268ef9e07mr1288886637.9.1787853613291;
        Thu, 27 Aug 2026 11:00:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:b7a7:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3d268ef9e07mr1288711637.9.1787853612629;
        Thu, 27 Aug 2026 11:00:12 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.11.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:00:12 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:29:23 +0530
Subject: [PATCH v2 6/9] spi: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-6-091697dbeb02@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=3796;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=evZqvwjAfpStMv2Htuq4lxgmNHVsv9xwkVK1wPRutP8=;
 b=KdFxbJvcWSl6qfONQjLStiRv61vbIt8Jhb3N1xzP3igF569m4oAAYDp2Y2j3vj6Twd3akqVQ1
 UdZupTNLSC5Dxck/9WtwyVDWsi+sPQM65ZnK2Nmh/sQYq1pYpFEOFqc
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX02uN3h38s/3N
 mKNXSn5ol0FgzG4GSwueiTDMN4MZ5arb5av3aXnkW0kwhGQXEFpsdozS7168CUq++vBH4bH7+sT
 sC+0b++QDJm1JkvRGvwM4gxR00aKHpo=
X-Proofpoint-ORIG-GUID: E9sVVu_ekdvpA1yDg4qq3nwJxOxuBoE9
X-Proofpoint-GUID: E9sVVu_ekdvpA1yDg4qq3nwJxOxuBoE9
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a907b2e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=V8jFpX-JU2fdHFI84kkA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX9XaoqOYn/pLn
 ZYjzojiAg6uT2YRwoppUSonk945D4uoF+RS6ImmLn+LgfxGgRZEscU2d2gSrtBn8u/crGY5GMc5
 ZjCq07ywh83r/BShMhNEgWKbMUQWMOEc0D71iiX+HdIAKL3k+MDQQF9gQSkQabua3xatseXI/ut
 Cl74ZEA97V9wfglnMSE0HlbUPP6YnJpPyiZCUdL/wpf/PVQsfXTaUNGJ3iMvl2ayQKHOCAUCdMn
 MSpT6KcAgXVjbRmzFMpGzaTfOBi2r7FCMBoLqO0bwlBfPbA9gSfyF9KFzL5jlMsi0w0nbQg2Prb
 5UIh79iJt35O1SsDp1hzx4WBtAwKsVMXpM//d9+u9MLAN+OpJ1hNDd9Ewb4XqNahnqAUtKKRdIX
 6PXg1EMdrRDwyMa3AfwhWFWZ9G9exViyK6BL+AqwXyKrYd0CGCu38S6s2+R7NgPQCS2zaHQV3tE
 ij0T0AzIRInC3UmWcZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

On the SA8255P platform there is no Linux clock handler for the SE
source clock, so the driver has no way to look up the source clock
index and divider needed to fill the GSI CONFIG0 TRE for a requested
transfer frequency. To work around this, firmware instead exposes the
SE HW supported source clock frequencies as OPPs on the perf domain
device.

geni_se_domain_attach() now populates clk_perf_tbl from
the performance-domain OPP table, allowing firmware-managed
platforms to use geni_se_clk_freq_match().

Use geni_se_set_rate() instead of dev_pm_opp_set_rate()
so clock programming is handled centrally by the GENI core,
independent of the underlying clock-control mechanism.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6566975eb24f..03ce9eff9c24 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -15,7 +15,6 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/soc/qcom/geni-se.h>
@@ -82,7 +81,6 @@
 
 struct geni_spi_desc {
 	int (*resources_init)(struct geni_se *se);
-	int (*set_rate)(struct geni_se *se, unsigned long clk_freq);
 	int (*power_on)(struct geni_se *se);
 	int (*power_off)(struct geni_se *se);
 };
@@ -150,9 +148,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 
 	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
 				actual_hz, sclk_freq, *clk_idx, *clk_div);
-	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
+	ret = geni_se_set_rate(&mas->se, sclk_freq);
 	if (ret)
-		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
+		dev_err(mas->dev, "geni_se_set_rate failed %d\n", ret);
 	else
 		mas->cur_sclk_hz = sclk_freq;
 
@@ -847,7 +845,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 	}
 
 	/* Speed and bits per word can be overridden per transfer */
-	ret = mas->dev_data->set_rate(&mas->se, xfer->speed_hz);
+	ret = geni_spi_set_clock_and_bw(&mas->se, xfer->speed_hz);
 	if (ret)
 		return ret;
 
@@ -1161,9 +1159,14 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
+	int ret;
+
+	ret = mas->dev_data->power_off ?
+	      mas->dev_data->power_off(&mas->se) : 0;
+	if (ret)
+		return ret;
 
-	return mas->dev_data->power_off ?
-	       mas->dev_data->power_off(&mas->se) : 0;
+	return geni_se_set_rate(&mas->se, 0);
 }
 
 static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
@@ -1178,10 +1181,7 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 			return ret;
 	}
 
-	if (mas->se.has_opp)
-		return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
-
-	return 0;
+	return geni_se_set_rate(&mas->se, mas->cur_sclk_hz);
 }
 
 static int __maybe_unused spi_geni_suspend(struct device *dev)
@@ -1224,14 +1224,12 @@ static const struct dev_pm_ops spi_geni_pm_ops = {
 
 static const struct geni_spi_desc geni_spi = {
 	.resources_init = geni_se_resources_init,
-	.set_rate = geni_spi_set_clock_and_bw,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
 
 static const struct geni_spi_desc sa8255p_geni_spi = {
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_opp,
 };
 
 static const struct of_device_id spi_geni_dt_match[] = {

-- 
2.34.1

