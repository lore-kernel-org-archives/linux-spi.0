Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DEA4C6F10
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873534; cv=none; b=OdDeokTK8arbUoVTgqtLn+JHgnyHltcrsn9c/MKybCu2PmDEciGvrNGmN8bTVjcUPoawgRK/EGOLruINcKt/6uKTJ2i6pnyYEM9CJD+1Ta+p5OROJjRf6JTto8PwYSC6Hu5s5mG5jCmsBas1SqmEfrLBIiQuJJjcDGnsprDQr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873534; c=relaxed/simple;
	bh=PEW3pWPW2yxbK9ZgACWK44vjXfKNskPlikOmgv7qqng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VApwBTSHRsCJBuPN7tMH1W+dH6mf/Ul+5UrzZFZClBVn1Gbt3Kw3BqlDwFSqYP6yQZmeTW8MXH9Exw9+ojvyAdUwYxM9th0ADaM55BG0hbElCTzjsxCScESziNP0pAavYKnKeSAjxKuHvxQrL9lAzDfacp1E6lmB0Fkypc1bgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k8LaNiFy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DP2QjqCu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k8LaNiFy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DP2QjqCu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JlR6v428154
	for <linux-spi@vger.kernel.org>; Tue, 4 Aug 2026 19:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wdAr2VKcV5cr84m5kR2RCjRBgbEXI4fcK1UWAE6nPm8=; b=k8LaNiFySCNA8zMy
	pXuUMjypcSqFFyzFypasx4p5zkAn/YoIZrTJhwBn86tQtPEYgQP9xMusZNUtPUWh
	7DZoVYfXQw8+N6UufHHSBSgSMfVIUydcICn1UZ4n6xBhCOng+7HuRKARhMUjwdSz
	rmQYABSV8hwYOaJ/Uz6bzIZ76e48AG/JwcBEFvo7V/WodrEE9S9+0M4bjr3oVP2F
	/6uDVU6f/SF9wMfPvtDVv+9elKeuOteFvsPbPskZgucWFGXzbvoXMjV4AAsfgfqk
	5HeuDU7h6X+7fm1HPvaxHiw9ocEH32+bObbalW+b5+AtAIhCiI2R+NQo8fpaspUv
	rlWCOQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fugmgj0r4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 19:58:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb6dd278512so80499a12.3
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785873531; x=1786478331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wdAr2VKcV5cr84m5kR2RCjRBgbEXI4fcK1UWAE6nPm8=;
        b=DP2QjqCuqo2ysFOD4gaqcVcAdNshJVSZWZTDORAvu2yv8TvO3t95CZ87XsDYOclnmc
         Bge0CSfd1RYO37uYbduWzXTmjyjNA4tYj7VewHwgFSRHMeSS1xzqfmkjYnn3wvKnNZtz
         zm7A5b32MimnJlZGxTn7H7oIgOXlJWPqe0aPLM7E2WhZruAD37uy3PtVIgXjki4mMqVg
         XF5roj9ELiojbR8SfW8USqSRq+aSl7JdXF0Qya972xpf2kWgh6a5LdnhCENStE1dXC7H
         ahctgW3xi9htog7zj2917DkZzHLjaKRN7081Y32O2gI3E5TFgXb53siFhv/DB2JiYz3p
         udvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873531; x=1786478331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wdAr2VKcV5cr84m5kR2RCjRBgbEXI4fcK1UWAE6nPm8=;
        b=isBX6bDC5CFt7oMLV7PId42GVhDsfMP18s/TAqHsfAYovWvHhzwtLUIrBh5ZX9wK7t
         ghjK1RE0qnfdrCEmkDFwUwW/e0HQrUY7y+r71P/u73rfygU6nD/U3kuZbh1X2wdGxj2C
         7q+aCxpYsC3we0veME1ROFVB7M6kxtvGP27gk7DNIUyJSRcpRXgXmHY+p5ndhym+5Cgw
         RKzKq9u+4AjVVWmiF6NGdRcA8TbQCa8zWFC1nYqajAI3g+wDkLzps2FuBLvyuIxgiLVt
         MZfIF/0slFnoEkA0Z9pC6bP+UoAcJR75p21Zz0qgUsI71TLjPPcGtGZxp7uSRkqaBkkm
         0zAg==
X-Forwarded-Encrypted: i=1; AHgh+RpfV0aRoFnbcfZPb+gyWovkf8frxAQNfCTqQGgGH6Im47RVETEVz+hfgqkm6IOUkTP7BeHWX2aKsxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeISoAVfSwzAoT2EJa3/mqdYyJk334QMwhbA6bwo5YVp2eoKGU
	IKmwrgBQ81Do+gU7blYVMBwtowmYNPry3O7R2Bq5Jwlqy4QYQrx3b8A3/msaoky/Hx2PbhOlAmk
	7tpW9Nq9958FWESKCwRAJ2b5A1L0H4SBJXWlqiKH6wi1BDPQghuY1n1CeSOim6iE=
X-Gm-Gg: AR+sD13TtnLyV3ziCIzqrSeTR3fg/9IfZyVIsLmUAYqvKbkqCXRsP+ZYKJCopxvQA4B
	QhxiSGye3yX2Bihs7f3DPPbXZ/T8apXnri17f/xwZBPeARElRwDRI2yOpnWpBUkHtLfB6Hr7tSy
	Yz7DNysU4sM0TIy5lp/xatBCE/o9PiA40cQVSbU5KE58r3Rh+sGZocD341dZaizuwcWAMGXLE88
	OwLxuH5Q6z7FPuNl03PZ3IN6ORq1C010Dt3q+BNGkUeZ+PERAx4PUDIbUXn1fEvHR07vkQ6niMk
	clCiWcd1tYc9gaw/arCmZxv/JGTuzLQPvhtzI7osEalrrn/Ki13Gb6s4z6Gm+AhZcMkpRlzsMwr
	uTJ2lrq8URC7aQnf4KSepWjXBxczUEFs36w==
X-Received: by 2002:a05:6a20:2449:b0:3c4:2fe1:fa36 with SMTP id adf61e73a8af0-3cb86029556mr985064637.36.1785873531026;
        Tue, 04 Aug 2026 12:58:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:2449:b0:3c4:2fe1:fa36 with SMTP id adf61e73a8af0-3cb86029556mr985023637.36.1785873530336;
        Tue, 04 Aug 2026 12:58:50 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867a68fdsm12316636eec.25.2026.08.04.12.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:58:50 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 01:27:45 +0530
Subject: [PATCH 7/7] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785873474; l=3035;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=PEW3pWPW2yxbK9ZgACWK44vjXfKNskPlikOmgv7qqng=;
 b=PONuwlbFYsiFqYceOtHQJdj11K7I7oLQ65HO6yCuf5x2ClKcFH/kiYsDzTK/wSVOZeBPvEfwC
 b5xPyxzpYFxCqv9DEc6UG9LydYfd111EEuQhmTzt5eJptXxSTzCPphg
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfXxjg1BOc7/sRR
 2iG1LI1IPJxZZqTwuLOkMhxLq5U/Sj8HHqjjmi0yuoGC3/h/DWebbwf2DtNl9N4CCvBHuFc+zF9
 xH8yidDTaND5nCDTR3OeFlhzMirh/1XgdMdLcaQbYPNRZbhaidQJuhAVDWKW3PCw/1JqbZViw/U
 HydnQU1OQ/OyamMmSmKEOXKk65M8C+6psTRau0UG5jPbMgDeka19YmEivp30iiI9YzQ7oOX5WTN
 dnYX7KaiEviMa4tkduouVrXtjojnB7VJJc52Zb+lg6VPrgUhvhVQpILG2nREwQpCBXTVnzo5xtX
 Trc0OgGLtaow8kBfEhO25Jhp6GfM5P1MI+E5eHoVpVm89tLHZ8r5PAnuV6uOqPUYr7CbqnKal3K
 w8GECwqbwFIqvf8k8BVykEfiHMBkStEpDhS4fhcNdNnjQaYIhMFqkkTFqcbymc9UxsN8GL6X3KL
 Gc7NfMrXOro+eM8QoFA==
X-Proofpoint-GUID: ogdtGGvVL1aNZOc7UJcZP8umSqaRgVeO
X-Proofpoint-ORIG-GUID: ogdtGGvVL1aNZOc7UJcZP8umSqaRgVeO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfX66/jyrdn4f4J
 Bp0vBqdZUjxg9EAKCR4G/FEdAjmse5B6O1B0WaTB+t2RiDugaUsNcBxQts5pgiLiPGIXh2AFG4+
 4XyvBgMUIEmQT1pCdn3DCk5UhzUfrC8=
X-Authority-Analysis: v=2.4 cv=XYC5Co55 c=1 sm=1 tr=0 ts=6a72447b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=jg7x1Z_fmygP-IZMYzcA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040161

On the SA8255P platform there is no Linux clock handler for the SE source
clock; resources are instead managed by firmware via a genpd performance
domain. The I2C driver therefore relies on geni_se_set_rate() to apply the
fixed 19.2 MHz source clock frequency expected by the SCL divider and
counter values programmed by qcom_geni_i2c_conf().

Call geni_se_set_rate() directly from qcom_geni_i2c_conf() so the
configured frequency is applied to the correct device (the perf domain
device on the firmware-managed path, or se->dev otherwise) without the I2C
driver needing to know which resources_init() variant is in use.

Drop the now-unused set_rate field from struct geni_i2c_desc, the
geni_se_set_perf_opp() usage on the SA8255P variant, and the unused freq
parameter from qcom_geni_i2c_conf().

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a23554d101fd..4561e2d235d5 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -213,11 +213,11 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 	return -EINVAL;
 }
 
-static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
+static int qcom_geni_i2c_conf(struct geni_se *se)
 {
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
-	u32 val;
+	u32 val, ret;
 
 	writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
 
@@ -233,6 +233,10 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 				 itr->clk_div, itr->t_high_cnt,
 				 itr->t_low_cnt, itr->t_cycle_cnt);
 
+	ret = geni_se_set_rate(&gi2c->se, 19200000);
+	if (ret)
+		return ret;
+
 	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
 				  Bps_to_icc(gi2c->clk_freq_out));
 }
@@ -975,7 +979,7 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 		return ret;
 	}
 
-	ret = gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
+	ret = qcom_geni_i2c_conf(&gi2c->se);
 	if (ret)
 		return ret;
 
@@ -1272,7 +1276,6 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 
 static const struct geni_i2c_desc geni_i2c = {
 	.resources_init = geni_se_resources_init,
-	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
@@ -1281,14 +1284,12 @@ static const struct geni_i2c_desc i2c_master_hub = {
 	.no_dma_support = true,
 	.tx_fifo_depth = 16,
 	.resources_init = geni_se_resources_init,
-	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
 
 static const struct geni_i2c_desc sa8255p_geni_i2c = {
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_opp,
 };
 
 #ifdef CONFIG_ACPI

-- 
2.34.1

