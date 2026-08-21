Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154047D95E
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309385; cv=none; b=SwNSo3iHnHjL74wTmg0wr2EEI7cB/lbbbcl+G2U+Pdi0gyyd2WPdjGHYybF4UaOQROpm9vbMG6+4rkD/G6TN/nfAfET6j+8pmotiB7xRbkEwAjl1crjh7we4kX9KNppqK6a39XpjcF7mjwLTpkpL/EsRzxqdTAIA2bUvU3xhqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309385; c=relaxed/simple;
	bh=l7u4bBryKZVvb35aHWz+IPbfRsJqnJN7CUBiQHkMSTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyD+t8zJwJcldursYlBpKNRUztGv/4b1DFVdnsqtVlX93ox9Hjt7Ata1nhDavrNtQvpN5QRxrSv/EFzLX0n0m/+YkZETLKP34Ju/QIAfajP+9CJNO4nciBDP3C1te3g4iSAVkoBiRs13lybDYIe0NlvwvD/bX9Bpafy0R9/x+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S04epNZx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KXkIrFpR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S04epNZx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KXkIrFpR"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9M3PA2006429
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 10:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uQhCkUKtUlslk+Oa2QJoz7cqjjacfjKxCRVUWz8cEjc=; b=S04epNZx7lm/3xtW
	J5zYlpXSzRGbvBxVgNDfKc/uLrpNBl2hJT478/JNAT8IS40Fo17xv2OIrR+wLcA7
	oMyzng2jsUFlO9k9FMKqQcGTm6at1zKpWLDiLb5WTfWbowbM4NpqbMEXLlZZalYF
	jEhNYpf2GOfK5oqKy1MmXHc7ZGMlNg76n3MCQIozs2cbCzf7aiAEDqDjf+NlXF+g
	JAu4XaiE2UOLJr+mmUtr27Io+1+y/YCFqyB0sho2Z4eO11zrgTHWO2Cn3ThplmLG
	+2kx3bojUn4ODKsPPW2nrusgzsWWU0XSCNsAaI0Ymj4yBEA4ANyFJc6++E9F/VW5
	P7nu+w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gddh61k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 10:49:39 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so1174548a12.1
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 03:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787309379; x=1787914179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uQhCkUKtUlslk+Oa2QJoz7cqjjacfjKxCRVUWz8cEjc=;
        b=KXkIrFpRrsrVtjjiM0QFKEAy+U+IHei0cDH/PDAimfudKVeQfMWo9y9bxngkSpYCHC
         9CMlbzxtUG7Q7YFgFWAQ1SzwxiyTllPB1ImgqHwkRGOveSZN6Jwhs10y8Rp4/yQUEkH7
         7hI8jSON7ljM6y28ICkQfDu9oquPQ/Zyrictb+nqrI5eCIDD5QsV9OcHq9RCd8U0gNag
         KSPhnQmnSd50+O47fS2S5xppq4to0m7Q8G2uQMf42i1BXJOKxKTb+5JQ5A6cfy77V7zM
         obR9TvBBOoX2KF0KoX81bI1t1rdySAet6dfG/r8i5MDl5CLcxiE5u6vMIDuVPxy/aDp6
         ZSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787309379; x=1787914179;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uQhCkUKtUlslk+Oa2QJoz7cqjjacfjKxCRVUWz8cEjc=;
        b=kSIh8+is3zEhLut4WnLHFIC7qMsbwVcG3AYHVnbzdT96VAAB+Ze0xO+EsPEh6x6m2c
         fPFazOdbpfCz5Su+C7/4bt5Aw/GFk6BWO0RFQOOgpJy9B1BphZyR9fPqRMiUAj46ngoa
         rHhrt/3l0O0wePZgwrw6Igd11dg5wG79KCgwiBZ7BimDAhfbkfAqkMq1FMYaYNOeJrKp
         NZ6rEfW59mOmT/lmlYCKWIwZtN4FU2auLq6c2R4yURNZWWboW9Zv6EoPKYk/r7cB4/Bu
         TbZTN0JKhqutEIwA5sp5DxdWO+rjNLTPZEjuq1OpbSNhP06vd7V7AuJkvfuv6VcVt3kN
         Aqkg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0jOJupyZOqBkPCfEv+oHl3dVEVfoTNIIcAJgEuHX3RhrEIS4HIETNv9q4tTS2m0t5s8tj6trRAr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fboYyWa8Hd4bykDeDlnwQ3O9heWX+KSxbplX1Q0yFHtktVPq
	0LTgMG7o0Zp+OjoOay5rDqR66B07sEr//khbwvBaX8n+xFtTpd6EU+Uh4HWHOSl+QoLRr8dFQv7
	sc0Fx6XPrux+RvbCeCwwTqZ0v4fdtMyvZIfE0U9OxRadfkL3/8xh2lZw1b87Xzqc=
X-Gm-Gg: AR+sD12LWQPFY4EvMZKqokmwnUDmDD5kqR5a5JP9yv0BiwXD/t9NtGiyRNGK577UbiY
	sN/5BiVVxYYfZkAxInHZXjt4A1aeUo20hbkr6yF9pgnYlbZne07Rmrfd2pjnv+tHf/mSySuahS5
	oWcRBh1RIRneHZQdjbdkTlyK5n1jD9c6Xia83hnS/JFD2cY/lIWKQ8kFqYRTt0AscSFgimLDMH/
	G5MH17J8hlKAneqBslhVEYkGoV5NMM6ue7WoKvj2FIQIiGSsXbfq9kgwP/+sqTbIpWMIoaGGFOW
	22s09d9O0UcG53Mz1eRYD9AuBe36Ayq8uaWaPfcsZxEvdaJ6PYjfWqbn5D66AvG4q8J4eDKyMBs
	pztsGQqVr6b/Bmi1/p9Aw0crNAMHLFjo=
X-Received: by 2002:a05:6a20:9145:b0:3c4:46ca:334b with SMTP id adf61e73a8af0-3cd3076a57amr8239978637.9.1787309378632;
        Fri, 21 Aug 2026 03:49:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:9145:b0:3c4:46ca:334b with SMTP id adf61e73a8af0-3cd3076a57amr8239919637.9.1787309378213;
        Fri, 21 Aug 2026 03:49:38 -0700 (PDT)
Received: from [10.218.50.86] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1657e1f98sm1714195a12.11.2026.08.21.03.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 03:49:37 -0700 (PDT)
Message-ID: <720c8c7f-532c-41e2-a4b4-60ab0edbb280@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 16:19:33 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Add panic notifier to cancel and
 reset DMA during panic
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandana.chiluveru@oss.qualcomm.com
References: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com>
 <20260818-add-shutdown-and-panic-notifier-for-spi-v3-2-8b62c4bc2d21@oss.qualcomm.com>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-2-8b62c4bc2d21@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX5i8tSJ9hVA1s
 9Pp1wlQBJT7bnxNOv3wGUkV7i6wXjcOOvg1qsAVyi5JwdK6RoqezCvOFT6SO3C8uBNVZOgOFBEI
 llCsJ5Kdvhs7rYABQAn6le0xTM6UMTY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX2qGICMbizlzp
 CFomX9pHpdVulGYPGS4JulsU5Fdz+Tp1ARubCBAIl3DHrRrLcqvU9VKgm3hFX1n4qQGLDXRtrjq
 FWdGqv6cn7fdqpqEJpD74ht18r7gmsXUv6NsLZT40dOGvpXiigrn1PuzJuGs5VkXUlR2FG0wYwI
 EVni6qgtWlNTRZKvIMcrxwaAFnTodFNs/Fbb7iESa++8ipBIysA+6bbvqL+FeptWWzEGO+pobmK
 dQaLusTZqEl0gtDjgBB83SKsN/noZXXHembHNr7roWA4qK+xrBbRfaE962qPomqEkMp3RS9CwYp
 YS9QrAqMUBNjfWzV94Tk1YPzuYUmrE9EAOfOJqiNOHagVRcZxiMnIvM4hsJbYKVOUKv1uyOddZb
 n5UzgaaeNIYfhiddm792TUMJWObXDxH2ehJ4fCDVPGRteKQLlkxJT53SAMXqMaaO3pWpYtKZ/sz
 KM8wcaGcWfpTqtCJAug==
X-Authority-Analysis: v=2.4 cv=ApHeGu9P c=1 sm=1 tr=0 ts=6a882d43 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=_wxJVZpf7Xh69hwLhBsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: lZxHcCAj8y_k_thsbbJxET1esvEHTgOZ
X-Proofpoint-ORIG-GUID: lZxHcCAj8y_k_thsbbJxET1esvEHTgOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210081



On 8/18/2026 6:58 PM, Praveen Talari wrote:
> When a VM crashes with an active SPI DMA transfer in progress, the
> SMMU raises context faults as the DMA engine continues to access
> IOVAs that are invalidated when the VM's memory context is torn down.
> These faults can affect other VMs sharing the same SMMU instance and
> obscure the root cause of the crash.
> 
> Register a panic notifier that cancels (or aborts, if cancel doesn't
> complete) the in-flight command and resets the TX/RX DMA FSMs, so the
> DMA engine stops issuing transactions against invalidated IOVAs
> before the system halts. For GPI DMA mode, the DMA channels are
> terminated directly via dmaengine_terminate_async().
> 
> The notifier bails out early if the device is not runtime-active or
> if there's no active GENI command, avoiding unnecessary register
> accesses while the SE is clock-gated or idle.
> 
> Since panic notifiers run with IRQs and preemption disabled,
> completion-based waits used by the regular error-handling path
> (handle_se_timeout()) cannot be reused here. Instead, the relevant
> status registers are polled directly with
> readl_poll_timeout_atomic(), which is safe to call in this context.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index c65c1788325d..f272bd0cb640 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -12,8 +12,10 @@
>   #include <linux/dma/qcom-gpi-dma.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> +#include <linux/iopoll.h>
>   #include <linux/log2.h>
>   #include <linux/module.h>
> +#include <linux/panic_notifier.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_opp.h>
>   #include <linux/pm_runtime.h>
> @@ -115,6 +117,7 @@ struct spi_geni_master {
>   	struct dma_chan *rx;
>   	int cur_xfer_mode;
>   	const struct geni_spi_desc *dev_data;
> +	struct notifier_block panic_nb;
>   };
>   
>   static void spi_slv_setup(struct spi_geni_master *mas)
> @@ -1073,6 +1076,62 @@ static void spi_geni_shutdown(struct platform_device *pdev)
>   	spi_controller_suspend(spi);
>   }
>   
> +static int spi_geni_panic_notifier(struct notifier_block *nb,
> +				   unsigned long action, void *data)
> +{
> +	struct spi_geni_master *mas = container_of(nb, struct spi_geni_master, panic_nb);
> +	struct spi_controller *spi = dev_get_drvdata(mas->dev);
> +	struct geni_se *se = &mas->se;
> +	u32 val;
> +
> +	if (!pm_runtime_active(mas->dev))
> +		return NOTIFY_OK;
> +
> +	if (mas->cur_xfer_mode == GENI_GPI_DMA) {
> +		dmaengine_terminate_async(mas->tx);
> +		dmaengine_terminate_async(mas->rx);
> +		return NOTIFY_OK;
> +	}
> +
> +	if (!(readl_relaxed(se->base + SE_GENI_STATUS) & M_GENI_CMD_ACTIVE))
> +		return NOTIFY_OK;
> +
> +	if (!spi->target) {
> +		geni_se_cancel_m_cmd(se);
> +		if (!readl_poll_timeout_atomic(se->base + SE_GENI_M_IRQ_STATUS, val,
> +					       val & M_CMD_CANCEL_EN, 10, 50000)) {
> +			writel_relaxed(M_CMD_CANCEL_EN, se->base + SE_GENI_M_IRQ_CLEAR);
> +			return NOTIFY_OK;
Looks like a successful cancel here returns NOTIFY_OK directly, skipping 
the FSM reset block below it entirely. Is that the correct expectation 
?> +		}
> +	}
> +
> +	geni_se_abort_m_cmd(se);
> +	if (!readl_poll_timeout_atomic(se->base + SE_GENI_M_IRQ_STATUS, val,
> +				       val & M_CMD_ABORT_EN, 10, 50000))
> +		writel_relaxed(M_CMD_ABORT_EN, se->base + SE_GENI_M_IRQ_CLEAR);
> +
> +	if (mas->cur_xfer_mode == GENI_SE_DMA) {
> +		writel_relaxed(1, se->base + SE_DMA_TX_FSM_RST);
> +		readl_poll_timeout_atomic(se->base + SE_DMA_TX_IRQ_STAT, val,
> +					  val & TX_RESET_DONE, 10, 50000);
> +		writel_relaxed(val, se->base + SE_DMA_TX_IRQ_CLR);
> +
> +		writel_relaxed(1, se->base + SE_DMA_RX_FSM_RST);
> +		readl_poll_timeout_atomic(se->base + SE_DMA_RX_IRQ_STAT, val,
> +					  val & RX_RESET_DONE, 10, 50000);
> +		writel_relaxed(val, se->base + SE_DMA_RX_IRQ_CLR);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static void spi_geni_unregister_notifiers(void *data)
> +{
> +	struct spi_geni_master *mas = data;
> +
> +	atomic_notifier_chain_unregister(&panic_notifier_list, &mas->panic_nb);
> +}
> +
>   static int spi_geni_probe(struct platform_device *pdev)
>   {
>   	int ret, irq;
> @@ -1161,6 +1220,15 @@ static int spi_geni_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	mas->panic_nb.notifier_call = spi_geni_panic_notifier;
> +	ret = atomic_notifier_chain_register(&panic_notifier_list, &mas->panic_nb);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, spi_geni_unregister_notifiers, mas);
> +	if (ret)
> +		return ret;
> +
>   	return devm_spi_register_controller(dev, spi);
>   }
>   
> 

