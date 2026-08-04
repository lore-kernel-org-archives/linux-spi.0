Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAF44BC02B
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873528; cv=none; b=b7WTqP2KwzVWPaSMUiw6/97k6CxdrnEHWenVTQosil7u95j7xQgyhJ8oVWhcpoPrrfFJFganLCp551YZDB1JSz6f1UL619T+aRvJgmB4yx3oll21MnWGEQ8zGsNR1N4r8iKpchEwrrfs3iBWZiMLXX6CGLgJEBU0DUHhH7ZZEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873528; c=relaxed/simple;
	bh=kPzOm1yNF2GSWJ3AQU+hUVYpKCMr/c+8cF2aK6E6Kfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNSNXhs3ApIO/XHX80XZn3DvVzETNu8GIQBaEdwS7j/vNFvNf58LBxGkQI1joL8kGum5yvb5ap+zvn3KzuuURi2xigf6DSjjxgYL959Zl5Ze7cgRrVwAhhvlmEhk/V+YXsxP0Cch1wEMo9PD0neb1iSm23VXkiN7Q37aM1C5dME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fIaKiKX0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q1VXZfzK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fIaKiKX0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q1VXZfzK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JlPBC641271
	for <linux-spi@vger.kernel.org>; Tue, 4 Aug 2026 19:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TpHJgO1V/4sAv63uQnIq4dASzlYb9B2GR2EdD6oSXFg=; b=fIaKiKX01mNOB/a1
	Sy8oAkJeBryckX0ahyvUlp5dWd1hV51E2rErHMakYaNl2ppcMw4VMy4dmBv8k3BY
	aB7jvkegaULlaJQq3SaNCsLQ1HBh7pbltACET5mfF3IwzNRxhXD1bK10hBIyE1VH
	F88X7su5DWb8B0N+BFCuOcrTOiebmALLQYt7f7z/mXLe/X2zcP37H2HPeGjj+MBa
	gcgZEcO5vurNgreOIOaIosTKI7FK/KI3kPrvxakEjL/AuReV2I5k6yYmo282Geku
	qcmQmzVAswFbB/Aq707jBu6ZY3XMWX2a3me2UNmb7lfZdmErtPQi2A5RALOfLtw3
	y+fV2A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3nrsyj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 19:58:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so222872a91.3
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785873524; x=1786478324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TpHJgO1V/4sAv63uQnIq4dASzlYb9B2GR2EdD6oSXFg=;
        b=Q1VXZfzK1tDG6tHi2ZuSGd5i+uxr+N/zNBaqVokz5+1V/j1In+P9zcaGNQ+NVGTmBt
         2OGXayPk8e8DB0BldEZ9fTwIRCGZMf+obfyxCEtWko4LRNm9QqUPlPi6oDCmTeCjxWxp
         mS9wz7RfrTg4pjIzXlyrZD0cBvxUWv1eYYs4y0uEJ8a+WdACLeQCXAgn3KqsoVne1s+O
         rqmxjxP4F1NWGguSYDxcLLk4g/OFv2QDWaB9MdXUJX/hdCu/T488/g1kGoc+6bw0KELw
         oAGwPb6xw9ccqiM4opxAjMkYVI66nzAx8gtd3mw74ExOfzNPu5g2YXONucHssirLiPUd
         iNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873524; x=1786478324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TpHJgO1V/4sAv63uQnIq4dASzlYb9B2GR2EdD6oSXFg=;
        b=EWQi4zjf2hmDBgfEKn4+3RsJfcNi70QD5QEkwUzd+JuD4lCg9u5myFOxRg2kzt5F3p
         rhG3WbU82osdZgLr1kcLGmGjaiGQDs6+poAs/ht3TPTc5u/l7ZJQTS1crHhb/mCbCVRh
         2OMH7Cr/1DUB96nJf9cyPbYuNTNGyUBqrJ05E+L9PdGuR5AHGpIvCT00yfd7kr+UI9wR
         FdBn287cwOj1zBh1REI1QH4NQdmgWECLofiFg+8c35D4P5SFEGAEEeNzl5SKH/rXmuGE
         gYPyuzASomR4tJeQSVJwI/oPm7URkaJARjB6aAWaR6c66cOdOwrZQK0wap4d/Jj7ufb4
         ugow==
X-Forwarded-Encrypted: i=1; AHgh+RqTEazYdKttKSlLy/oFPhKW9bX/AK9TQb4pjkE7hjGaBEx2meuhdST8+yru33u955o/jCuXVjNlMVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLyQKVMhzpesoHbWwvk66b4r6eYyjfX4IqI1sNpwIzI9z8qTul
	EfBAKwVMI3J7D/G5vD7mg25RIyKFAslXOXUveeGpY5/rLOEQjOIvqt3N/3mJvlT8m0W0m1HwvWO
	AWSQZJiVpRNb0VSM1++8s/ICcp0QcoBTsbfIbUagfpun274RZDuzBfzpg2q/7ItM=
X-Gm-Gg: AR+sD11Y6ciDg0aJa47lIBH+8J+YKtWMr9vnP7xpbVO93PQjAdwkzOsUStPZnwM2vXL
	jqKzT7SeIB/nSiyOkkp0iBtFlzomQLWiZYUniUE/Jz8QY+DoMtmP/qLORYEx0G4rZPy7XeMKFJ2
	c/8FqcXlkCL247LuCcTU45O6ocRIvKjuDV+miFjdd3HDRMFB9VXcogXwIsiiQ7MbYIv/Rkdb066
	jOWm4nX7ADot/VUuSeG9XTeFgvHsiISLOyyBqwCWD2WdMD6nLXFyPdsWtrPTco68M8udAXuIhxl
	9pIn0mniw7NG1DITc/cqBG+3MK+TeCGD4WLkKwBNjh/Dvw0zlzYve/88iW1aX2oWzwcUcidBLGt
	MKGb/9HVVGFVRmnXcyBIGVwDnSPnCyfIl/w==
X-Received: by 2002:a05:6a21:3a85:b0:3c3:9070:96bf with SMTP id adf61e73a8af0-3cb85dbd12cmr1203044637.9.1785873523898;
        Tue, 04 Aug 2026 12:58:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a85:b0:3c3:9070:96bf with SMTP id adf61e73a8af0-3cb85dbd12cmr1202988637.9.1785873523367;
        Tue, 04 Aug 2026 12:58:43 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867a68fdsm12316636eec.25.2026.08.04.12.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:58:43 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 01:27:44 +0530
Subject: [PATCH 6/7] i2c: qcom-geni: Use common GENI resource
 initialization helper
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-6-61171ab1cdce@oss.qualcomm.com>
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785873474; l=3271;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=kPzOm1yNF2GSWJ3AQU+hUVYpKCMr/c+8cF2aK6E6Kfk=;
 b=BlEwMmGmdnL96YVYyWO8W4gJizfYcuaJusTDVCj2kLklLmnO0Q7DNPIEPA5R5plJuyZ4KrDUL
 SrUDtE2FutzAojctg5UwO2Ii/QrSYUr/8A7thKVWo/QzqkxlNUiQsaR
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfX3mlw9wIvOYBJ
 ewGRhJ4uQCrICN8Do6zFWfoofRHJqEaGw/4qZv0ykcc0hyu7FAZx7EIRJMLBNOrvEyuSbGYdvNR
 XeHZdIP9NtnQvLFy8DufntzJ18b9vdHp5YOK8kf5mtop2P0/lKix7AcismR76eLyMgUEYV7xwQm
 UUNqSjcKnLDBh7XFwNg0JprFDapXNqp5MWJ9eyOQOR2FdX0S3JePmGd9m74h3ITCjUaYXXygycY
 IuuJ7YCJmA3bByUIPQKbuhy0VPfC7to/8Y7NTvM+7chscaxpBn2fpLklG6r+iA0p3WL0g+y4TpM
 55NJwqi1VnTUgM8QxUhh7o8KTFBbc8wyiran76KmCfkUwQ/a5AxhOE1QWBc5FhuWEW65nSO7Zez
 2bK/mLIEEOsXtg0g3rndRWtjpoTJygGFBn2bFqIbTD03ivNPVxCWHd5R/tCYUENxYSm6zc0iyOC
 mWVFwXXFZfAJdvWaqhw==
X-Authority-Analysis: v=2.4 cv=AZqB2XXG c=1 sm=1 tr=0 ts=6a724474 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ZE09iLx1Z5sgUNS67XgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: AeNeov4yJ_x01v5FGvXXPELYsmZGuwVQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfX6dTwLuLZ+Zq9
 VNBdXNa/kgVIa1LsLE47U8mYDut2pzoW6P0EwexaHy5+5qIQsd7foSk9HQ4mdFchhO6YSNKTkqP
 ews9ug94lXsMtK+7s3FgbPIpDI3xxzU=
X-Proofpoint-GUID: AeNeov4yJ_x01v5FGvXXPELYsmZGuwVQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040161

The driver implements a custom resources_init() callback for clock
frequency validation and bandwidth vote programming. Neither operation is
required for resource initialization itself.

Move clock frequency validation to probe and program the ICC bandwidth vote
from qcom_geni_i2c_conf(), where the bus frequency is configured. This
allows the driver to use geni_se_resources_init() directly and removes the
I2C-specific resource initialization wrapper.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..a23554d101fd 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -228,10 +228,13 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 	val |= itr->t_low_cnt << LOW_COUNTER_SHFT;
 	val |= itr->t_cycle_cnt;
 	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
+
 	trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
 				 itr->clk_div, itr->t_high_cnt,
 				 itr->t_low_cnt, itr->t_cycle_cnt);
-	return 0;
+
+	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
+				  Bps_to_icc(gi2c->clk_freq_out));
 }
 
 static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
@@ -1100,24 +1103,6 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 	return ret;
 }
 
-static int geni_i2c_resources_init(struct geni_se *se)
-{
-	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
-	int ret;
-
-	ret = geni_se_resources_init(&gi2c->se);
-	if (ret)
-		return ret;
-
-	ret = geni_i2c_clk_map_idx(gi2c);
-	if (ret)
-		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
-				     gi2c->clk_freq_out);
-
-	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
-				  Bps_to_icc(gi2c->clk_freq_out));
-}
-
 static int geni_i2c_probe(struct platform_device *pdev)
 {
 	struct geni_i2c_dev *gi2c;
@@ -1188,6 +1173,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	ret = geni_i2c_clk_map_idx(gi2c);
+	if (ret)
+		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
+				     gi2c->clk_freq_out);
+
 	ret = i2c_add_adapter(&gi2c->adap);
 	if (ret)
 		return dev_err_probe(dev, ret, "Error adding i2c adapter\n");
@@ -1281,7 +1271,7 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 };
 
 static const struct geni_i2c_desc geni_i2c = {
-	.resources_init = geni_i2c_resources_init,
+	.resources_init = geni_se_resources_init,
 	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
@@ -1290,7 +1280,7 @@ static const struct geni_i2c_desc geni_i2c = {
 static const struct geni_i2c_desc i2c_master_hub = {
 	.no_dma_support = true,
 	.tx_fifo_depth = 16,
-	.resources_init = geni_i2c_resources_init,
+	.resources_init = geni_se_resources_init,
 	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,

-- 
2.34.1

