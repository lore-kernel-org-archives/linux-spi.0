Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BDE3603E9
	for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034975; cv=none; b=qVW/GpncWcyjECWjomJrNU6HKe8ajhmt1d86ySmQ7lLuuEI7n/Bv/077WfDAIC590LOFRM7WpnAH4weNqcfQzeyVrQN2ErkcOD/uHIBMiyTEGFEZadlq1rcazNrQRSBSjjVWfzK4thG/ZKboF+GGn1KoClVCu/C9uK0L/pMFw3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034975; c=relaxed/simple;
	bh=NILZcbeiI8YplRLBwAkLPP7xTpQaJQh437a1V4BTT+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCA2CI1SlMWcHw+15uNIRTFqciSTmAFVQ/W6hOV4mjiw9UgRwXkyAaIXb14EGDZAziDsgl64uzTxWc9Qm67uWcP1W3trfbS5wfvagSI9RRgnQO2rp9GRghsIeFHnMDvozlIuqZrf58Gm5jRvp8c/rXpxIiKji5EV6uBdS2y3VaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ng1A/Ndi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RhOzRvWv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ng1A/Ndi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RhOzRvWv"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A8poLl340806
	for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 10:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w6WSWBIfnFD8I/8EtmPPWYCRyqS1N/zQOy0eFdrQAKM=; b=ng1A/NdiUZi42qVL
	hp/exJJfv5EP/tK/9FuJ+MTaFNb5sttvu0jJhOOsAoGdG6PaRnkDyB2JuvqIiGaS
	QVpa+IAExfjNyAZjNLOax/rQ1gckgcS1XA5/8Ep5FoesevG3cmek/gqXZ8KTUCYi
	kdLeTGP7Y2sXcKaJSed9YuWwRKoUqHE64/+jvfH0YADgE6/etsIOsZMfhJPE/8XY
	L2lz34pJ9jv0YqDiUJPt5TK3u0VQSOCuHyenHNYmoL/ATZ2l70QJiREf1324NV2v
	vKxNh0JMLnX3VLmVuJEEfRy2qvYROqh7ZnQT4o0q55J/QLfpTz967/B84q1aX7/d
	/cj7IQ==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrak8kb1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 10:09:30 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-4566537e644so10481379fac.0
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789034970; x=1789639770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w6WSWBIfnFD8I/8EtmPPWYCRyqS1N/zQOy0eFdrQAKM=;
        b=RhOzRvWv96fHCl/2FArwHJYWfkww8dUbQ9ZFPYozj/5ceCD+SLAXhq+Bazj9bnJCVp
         rboLzmDuHKgu4+TasX0qxs9ksrWX866VXkNl1npSj9MPMoR4D4/rk69R1uBonW41IEkq
         5Ucsiodj+uwonjd0VfdVEiJOYKG4l1s7lwxTbVT1M4IPiA4SvNgEgvGpqFE3ACPDBAXx
         5mgeyoZ5tmSN7/RVuBk/G1efFGvrbCDsDVoGgSFs/r2HDYui0NJ67u69JVePSEJh2as1
         8xHUJbvwSQccS87hdXptI/iDhlzLto2WHdafuYwasdj7NOC/er8NuFVa8efPMfHEYnvZ
         Sg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789034970; x=1789639770;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w6WSWBIfnFD8I/8EtmPPWYCRyqS1N/zQOy0eFdrQAKM=;
        b=RU5DqqZtOd4XX1UOJQkMWH8IIpWcgqGBrch1BjSXjPmRc4sfa1cJr7X9rwGzF8fGxY
         LQveafnuNTMGYT2zL646BfWn8PACKblJfKG6xhE54fhi0+hQp6hkDYQ4JXXs4wIU8Yxz
         Dom3VVyNOdnY4DiuLDCYDqr4lg1glOyCWznLIUw7MRuKBs/POghMjT6jkq4RT2K1D1BZ
         zClcrIoTktRZ6bqy3uW1jG1LsNkQCRMmB+akDrRKEks/2W8pcLsOr96txaNQHYnSPnLk
         UE/E1uiAD2rbacURDOWlH0PBeEXeUxP5PY15SCILO5S2Mopl+uSq6mel7rBPsbd7RV8l
         cooQ==
X-Gm-Message-State: AFuF++lUObXXaj3mEGOQjszaHYb1S/OaUFuY5Lm89aDpWQP947gxtAnt
	TTB5o/Z2r5SV5qC/sJLUZqGqnFEbhLBDtD1EwmI/N2L5fabn7FPBetmf8ZXcw5cSrtTYL2aeBYV
	ErPBLlIzWU1paIuRLJ8vp4jdYBBDJkoFIGe5xs3MfkxS3JAPLZarxeG7OVwSu0Ym+0H+rB0Q=
X-Gm-Gg: AYBFou0HL2wG/1lVYP2La3rgi7UMMBSjTURXbMjDBUm9uBVV/YwY3Mz5uBdUNbpArb+
	NDdCXoiK3ZWpCCPqq19xbO3V/2/1YuTYzqTwIdvLWeCwvYSIySPV9EukRzCOpKtRhyzXoMXHv0G
	VXSVnAwm8ZQDKx8HfIrZLx9nqFCbOogdbxOL+rb55KMaaP06aSyj1P2Tl1azCNE3I++JyU/fB8n
	82ZFDmDwEgxIw0ucW8T+ENCt0najgutxLddLs6tAaoHPp+6MePfIpvYvXhGe36tLcm9xTpbmVwy
	nsb4jdKp7YJcb0qqAduY9RSXU1QCkUTdPDgGyBFPp0+YMGGn7S2l0HdtyqFYPx4oBLJMOn9JN7Y
	KfrPmt3MlvDF0b0OCzih9JuQ=
X-Received: by 2002:a05:6820:1c9d:b0:6bd:fbe8:fb95 with SMTP id 006d021491bc7-6bdfbe90757mr6187912eaf.60.1789034970003;
        Thu, 10 Sep 2026 03:09:30 -0700 (PDT)
X-Received: by 2002:a05:6820:1c9d:b0:6bd:fbe8:fb95 with SMTP id 006d021491bc7-6bdfbe90757mr6187900eaf.60.1789034969642;
        Thu, 10 Sep 2026 03:09:29 -0700 (PDT)
Received: from [10.151.40.248] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm81334745c88.4.2026.09.10.03.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 03:09:29 -0700 (PDT)
Message-ID: <4f9af85e-0906-459d-a34a-37a0f13038fc@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:39:25 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: avoid writing QPIC_EBI2_ECC_BUF_CFG
 register
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260909-qpic-snand-avoid-ebi2-reg-write-v1-1-9b1b1466cc75@gmail.com>
Content-Language: en-US
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
In-Reply-To: <20260909-qpic-snand-avoid-ebi2-reg-write-v1-1-9b1b1466cc75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDExNiBTYWx0ZWRfX7oix5F0P+prV
 XsAZDh2I5Yf802PFuroIjziNVm29URbGhWSFyQzpMUAYhrfmgQ/2TZSwzpuUQ3tpOJ5m6K8hgjY
 9443QZGhXaDTwxiUA5hDq7QCzB7lhVs=
X-Proofpoint-GUID: 03x9rgz0AUXQTGFXJHb3PsiPk_dDBEJr
X-Proofpoint-ORIG-GUID: 03x9rgz0AUXQTGFXJHb3PsiPk_dDBEJr
X-Authority-Analysis: v=2.4 cv=EspHPicA c=1 sm=1 tr=0 ts=6aa281da cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ZGD61ap6ms5yJgAN6_cA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDExNiBTYWx0ZWRfX3gcIgyqBWo7N
 mcPd4Um1r9w0SI6wbtPGo2GKM0KAWikKBqBQWAGNEZvElHsgbU//hEPRtziWc7t8chOIuk8028h
 thUa2gHRPDzW9RWAUmkW5PprVcPr4jAczAltCj5Dl/sEx6lxvIS21tJx0iMSK2ii2iW/Z1USxVs
 gYmBu4oEs0ZbZV8TKEXVswoZpir15I14o0W9jI6AC3TYhsuZMr16aUnRWDlggDQ040S14nqGT1f
 K0TCYpqfc9WN6ZtWtjGB48cCcNfDNq5ohWjBpptRQOPLSYOQ3d9J2JJkUQ4MxR0pwsVXILkjv9S
 3bPi2WBxc2Oc95uAcipizBPDskCrYXDY8Fn3UU7Wy84ALFlb24Hll4LmxMdJo0QNcmQ4RahPK14
 +prJrsijT97STGw+24O/0HHzIECjaXvhkjgL4pimEKTHgtYh4k0SPvT5G8cohUpR4hpAucuDGah
 Y4OL3lJ0SuiGdoaMKAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100116



On 9/9/2026 7:38 PM, Gabor Juhos wrote:
> The description of commit bfb34eced559 ("mtd: rawnand: qcom: avoid writing
> to obsolete register") says this:
> 
>    "QPIC_EBI2_ECC_BUF_CFG register got obsolete from QPIC V2.0 onwards.
>    Avoid writing this register if QPIC version is V2.0 or newer."
> 
> Although the referenced commit is related to the 'qcom-nandc' driver,
> however the hardware supported by the current driver is also based on
> QPIC v2.0 so we should avoid writing that register here as well.
> 
> Remove the register writing code to avoid undefined behaviour.
> 
> Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>   drivers/spi/spi-qpic-snand.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index 61b1f2eb19ce..05efe6313b7f 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -765,8 +765,6 @@ static int qcom_spi_read_cw_raw(struct qcom_nand_controller *snandc, u8 *data_bu
>   
>   	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
>   	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
> -	qcom_write_reg_dma(snandc, &snandc->regs->ecc_buf_cfg, NAND_EBI2_ECC_BUF_CFG, 1, 0);
> -
>   	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_clr,
>   			   NAND_ERASED_CW_DETECT_CFG, 1, 0);
>   	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_set,
> @@ -1104,8 +1102,6 @@ static void qcom_spi_config_page_write(struct qcom_nand_controller *snandc)
>   {
>   	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
>   	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
> -	qcom_write_reg_dma(snandc, &snandc->regs->ecc_buf_cfg, NAND_EBI2_ECC_BUF_CFG,
> -			   1, NAND_BAM_NEXT_SGL);
>   }
>   
>   static void qcom_spi_config_cw_write(struct qcom_nand_controller *snandc)
> 
> ---
> base-commit: cb2ad3c020579bf51fb0d702db9cf64af9698377
> change-id: 20260909-qpic-snand-avoid-ebi2-reg-write-0920452b4b3b
> 
> Best regards,

Reviewed-by: Md Sadre Alam <md.alam@oss.qualcomm.com>
