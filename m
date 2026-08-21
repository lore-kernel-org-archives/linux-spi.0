Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D983769E9
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327527; cv=none; b=n9umdGoAGuWTUhlXoUdBpIL4NehHNWnSXONeG7b8AIyaaNIOfIcI3lf7HPNeCTp+8wLEv5ahEdr1JA0D33rktd5FQyj8j3QxAXtXCccC2PBVBbkkr6Hzn6mweqcydiKG9OsKVli+UmWlijAl4OPlWBXHEci7QRD7+zN3zfPeVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327527; c=relaxed/simple;
	bh=y1pBzkQo8TaS8eQmv1xfrR/Qh/yC1Qe4tD41jyrb1No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2PFJrSPBhCt7SbTQZ/ekslfY5JpmbkzEdcvpU8gRK7vDRynlOuqehYPeDvf86Wcbbx0qW1WRxJqey0Z6gsEV5MfhFWxn9nW2m8jm1DyKvdWcgpt4Pwa2GIjV8G47b845585JOQAe+owzDwFQye1isQMBeHCloq41In8h/umvZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PUXL8WNS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VPeHeNcV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PUXL8WNS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VPeHeNcV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFmMEZ2416759
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 15:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xuJlWJlbPBKVPZELBploWORVaEiIqXDnDJVuO0tDp1k=; b=PUXL8WNSwIM5ipyW
	ZYGcxxyM6Hy7C1K3ZOMQclA5IF600Uc9ZNdt+zKDuGGwmkAX8In9a9+y+TuBkWmm
	9nAzPWnPRchorjhSWQCW2U2kb4jeEDZHo4Dg5qfCUBKv+m0rjpzFewib6hkQpKuu
	j9yWTD6NxNdl8MQcF5WbjertabWxqX9z1VaBokbqIevYj0S6/T47ioc1tiZBO71e
	ocLNqpd+Anl3pHTjyd5W5Sm15aB0LeHqWrYoq+QW5yfhz0rgUB54xTGYyRzP+ma8
	4BeaMoAdg2LSfd0HZHu89wBTdZD7QBK11gNz5Zz79eiOnluH11FXf2roLD9UvM/l
	3eIKtA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fue2dnx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 15:52:04 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so1077645a12.0
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787327524; x=1787932324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xuJlWJlbPBKVPZELBploWORVaEiIqXDnDJVuO0tDp1k=;
        b=VPeHeNcVu1AARDNe9pIxNaWMi/8McAeM2XUpbvfNx5amSW1FEl8uTUvHGgN6nj+sRh
         CgLU3oTbB28Gq33OLbqX9JbfD+bPnDzSIVMCN3nIELxOGqhzaM0cmPE8NR+BvkdAWYIa
         hCI46ocNzMcd+N6yyvZUsY20iQEbvaI6hUsA9crkRb5e5wkmTcLcPDSGeQSCQ8NsJbJ5
         v+BTsBLfj5ysv0wpXjJ1Jd9QBMnuPCqeIuacU3qiAgOOGYdGUbqAf2dlvjS7udJooW+R
         g+UZ616rNRv1tIz22iZ8P8a70f2lr4gEXyTjz/BuO0xSIEIhuO9HKLz5b2hZYlW8NcAw
         PaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787327524; x=1787932324;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xuJlWJlbPBKVPZELBploWORVaEiIqXDnDJVuO0tDp1k=;
        b=QRk6YQTKlDGqsfHPj+O5Q2Ic/Etx1KiNfhsMyr8wj2MXRPAYn13d9CXB4m8p3RiRTW
         ZLhFJ9+q7N2iWYNR7Fs3SC3qS+GlNYxrjNIOdu2BBxhrYFuUzhsEMx+qiE32ATJz027h
         AfRnZ0ob9iC3px/FLvYp3NT4+qFu6sicYf3YkqKhf5TpwODjQWwXHfcBhcpZjd/pS9fj
         YDLwIYZnnuw8wgiSscm+SKq57eWD1zyNF9079I2dGnzq3rsPklBV2eQXAyY8Jy6tNnwY
         CXp/m4F0JNQ53ndqxlctsQHFlQAfPxbD3ekd9yxtcIJJipmXIQzh9Z7pJq+4gk6IPBEO
         e5gA==
X-Forwarded-Encrypted: i=1; AHgh+RpLoE+t5Rc1oCUnuUFVZ197LV2N9PDlwTmfhhqvF0KWFpQ+LskkQDcfnfnauDqXnFMc4fvIgeRUqHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNxepJYfrvu8FSGtDPt/R+MQnXncPcnsUc5vxYTlHm0+YeJsj
	jCBlkqTb2+fXMFERFrD7SNXQWKddAH+fJ4vciaqLhmWH5ozy0JeUovgJTASV9+O3C5dpPj+nAdx
	uZ6XkXv7zBsu3sz/KQcr25gtUYXeU73vrhXoLoVl+qdNpmFAOXf3ZkOLWG/A+3IU=
X-Gm-Gg: AR+sD12IREndMfpLTb2wn2aB6uGyJ2UlCb1KoKbC5y9I0v+mNJ97wTZFEETQlUjT/2F
	T5+xjunRzqzhkeG97MqNNbBm3aUHB7rOqMYQaZhmJCZr/fhnHTYayav2Zl15dANnWIt1wgZPBln
	+OMZO4qBaJ9La2JmGvs2cE5SWwrxr74IUItkfKC1xu0JhJj98JvsMb9VHW2ZFm5rnfFAg/D4eLP
	hmXjkV9CENs+R5bNjPU1B3nOld4T6jczlpJRW8AnLl4gEZa9kIsQzkFLxE4BC5WJ22KqxgcOpmx
	Bbf0nGInQ/wHfw5u/nwVxP5fVwQ7kO34LaUxw+WY/3nF+ZqJpQxr7Us0Pb5AQlY3Y1xmo/4MF6t
	GOjVgAREhA5bP1DugkD8bjGqp9mZS9IZN
X-Received: by 2002:a05:6a20:c98d:b0:3c3:97fc:93e1 with SMTP id adf61e73a8af0-3cd30105041mr15264822637.15.1787327523446;
        Fri, 21 Aug 2026 08:52:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:c98d:b0:3c3:97fc:93e1 with SMTP id adf61e73a8af0-3cd30105041mr15264689637.15.1787327522619;
        Fri, 21 Aug 2026 08:52:02 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.109.127])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc155464a0asm3035812a12.14.2026.08.21.08.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 08:52:01 -0700 (PDT)
Message-ID: <9b1b7f13-51a1-4846-a030-99f9b1cb439d@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 21:21:56 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Add panic notifier to cancel and
 reset DMA during panic
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandana.chiluveru@oss.qualcomm.com
References: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com>
 <20260818-add-shutdown-and-panic-notifier-for-spi-v3-2-8b62c4bc2d21@oss.qualcomm.com>
 <720c8c7f-532c-41e2-a4b4-60ab0edbb280@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <720c8c7f-532c-41e2-a4b4-60ab0edbb280@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyMyBTYWx0ZWRfX5j7y70Af/lOK
 oM1aXi3bL2+eQ/a1lYQXlYTOd0dUpzVFy6UNq5IaiD6BrQdVjc48efZKtNzDS6aQDWIjomimCRD
 9t9b/unMPKo/x1PIAI3kVOGdTppiJvk=
X-Authority-Analysis: v=2.4 cv=U9+iy+ru c=1 sm=1 tr=0 ts=6a887424 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=6P0G4DzZkXptpLBtTzfX8g==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ZeLMgYx0ftjVAchk_UMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: yjq4WKsuaruZOqfy9sVDMdSXp94A9Q6w
X-Proofpoint-ORIG-GUID: yjq4WKsuaruZOqfy9sVDMdSXp94A9Q6w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyMyBTYWx0ZWRfX3Ck4D04DuikQ
 PbGlBuQY6sPOFEKO/cIRLa2NPCGNlFI7p9aBl3DCXsa+5LzQWnIyDFqXXw0RbKkkv406JzzRGD5
 S/MJ6JvzfU++YvtHGcVyMJWxDNd1Fr/DdNN0U/jJUAr/AfYTsvL+a0Lzwrva0F2uqg/Y7+Kim85
 jao+LzhJP+9+qcQEQ5d9WazDuERj1ioxXpmer3gIiIlu9hadLjLIp51mVU5TGzVYSGCPxDNTXhq
 aPYqV0sBkcAL+eBEmPtQaydtN1k/YPfaGfEys9/ba5BtSHz6ez0ACgWyTYBHWejV7XekSCdS5hC
 NSVXeLlVRv5p8QVAfdpgLRVWCIcVJ5qRq+7in1uQ2xVx0M5aXjCT7+xcD+7Po4Jvj7QKiP99xoL
 IFykCKii5TBoIWy1CZuT2quDUGhmMGGezdXmwE8jCHd/HVrnBZxI5EcIS2VvUOI724OM0mJSVJs
 nYs349Wpa+1sF2BpV1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210123

Hi Jyothi,

Thank you for review.

On 21-08-2026 16:19, Jyothi Kumar Seerapu wrote:
>
>
> On 8/18/2026 6:58 PM, Praveen Talari wrote:
>> When a VM crashes with an active SPI DMA transfer in progress, the
>> SMMU raises context faults as the DMA engine continues to access
>> IOVAs that are invalidated when the VM's memory context is torn down.
>> These faults can affect other VMs sharing the same SMMU instance and
>> obscure the root cause of the crash.
>>
>> Register a panic notifier that cancels (or aborts, if cancel doesn't
>> complete) the in-flight command and resets the TX/RX DMA FSMs, so the
>> DMA engine stops issuing transactions against invalidated IOVAs
>> before the system halts. For GPI DMA mode, the DMA channels are
>> terminated directly via dmaengine_terminate_async().
>>
>> The notifier bails out early if the device is not runtime-active or
>> if there's no active GENI command, avoiding unnecessary register
>> accesses while the SE is clock-gated or idle.
>>
>> Since panic notifiers run with IRQs and preemption disabled,
>> completion-based waits used by the regular error-handling path
>> (handle_se_timeout()) cannot be reused here. Instead, the relevant
>> status registers are polled directly with
>> readl_poll_timeout_atomic(), which is safe to call in this context.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/spi/spi-geni-qcom.c | 68 
>> +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index c65c1788325d..f272bd0cb640 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -12,8 +12,10 @@
>>   #include <linux/dma/qcom-gpi-dma.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>> +#include <linux/iopoll.h>
>>   #include <linux/log2.h>
>>   #include <linux/module.h>
>> +#include <linux/panic_notifier.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_opp.h>
>>   #include <linux/pm_runtime.h>
>> @@ -115,6 +117,7 @@ struct spi_geni_master {
>>       struct dma_chan *rx;
>>       int cur_xfer_mode;
>>       const struct geni_spi_desc *dev_data;
>> +    struct notifier_block panic_nb;
>>   };
>>     static void spi_slv_setup(struct spi_geni_master *mas)
>> @@ -1073,6 +1076,62 @@ static void spi_geni_shutdown(struct 
>> platform_device *pdev)
>>       spi_controller_suspend(spi);
>>   }
>>   +static int spi_geni_panic_notifier(struct notifier_block *nb,
>> +                   unsigned long action, void *data)
>> +{
>> +    struct spi_geni_master *mas = container_of(nb, struct 
>> spi_geni_master, panic_nb);
>> +    struct spi_controller *spi = dev_get_drvdata(mas->dev);
>> +    struct geni_se *se = &mas->se;
>> +    u32 val;
>> +
>> +    if (!pm_runtime_active(mas->dev))
>> +        return NOTIFY_OK;
>> +
>> +    if (mas->cur_xfer_mode == GENI_GPI_DMA) {
>> +        dmaengine_terminate_async(mas->tx);
>> +        dmaengine_terminate_async(mas->rx);
>> +        return NOTIFY_OK;
>> +    }
>> +
>> +    if (!(readl_relaxed(se->base + SE_GENI_STATUS) & 
>> M_GENI_CMD_ACTIVE))
>> +        return NOTIFY_OK;
>> +
>> +    if (!spi->target) {
>> +        geni_se_cancel_m_cmd(se);
>> +        if (!readl_poll_timeout_atomic(se->base + 
>> SE_GENI_M_IRQ_STATUS, val,
>> +                           val & M_CMD_CANCEL_EN, 10, 50000)) {
>> +            writel_relaxed(M_CMD_CANCEL_EN, se->base + 
>> SE_GENI_M_IRQ_CLEAR);
>> +            return NOTIFY_OK;
> Looks like a successful cancel here returns NOTIFY_OK directly, 
> skipping the FSM reset block below it entirely. Is that the correct 
> expectation ?> +        }

If the cancel operation succeeds, an FSM reset is not required. If it 
fails, the driver proceeds with an abort sequence followed by an FSM reset.


Thanks,

Praveen Talari

>> +    }
>> +
>> +    geni_se_abort_m_cmd(se);
>> +    if (!readl_poll_timeout_atomic(se->base + SE_GENI_M_IRQ_STATUS, 
>> val,
>> +                       val & M_CMD_ABORT_EN, 10, 50000))
>> +        writel_relaxed(M_CMD_ABORT_EN, se->base + SE_GENI_M_IRQ_CLEAR);
>> +
>> +    if (mas->cur_xfer_mode == GENI_SE_DMA) {
>> +        writel_relaxed(1, se->base + SE_DMA_TX_FSM_RST);
>> +        readl_poll_timeout_atomic(se->base + SE_DMA_TX_IRQ_STAT, val,
>> +                      val & TX_RESET_DONE, 10, 50000);
>> +        writel_relaxed(val, se->base + SE_DMA_TX_IRQ_CLR);
>> +
>> +        writel_relaxed(1, se->base + SE_DMA_RX_FSM_RST);
>> +        readl_poll_timeout_atomic(se->base + SE_DMA_RX_IRQ_STAT, val,
>> +                      val & RX_RESET_DONE, 10, 50000);
>> +        writel_relaxed(val, se->base + SE_DMA_RX_IRQ_CLR);
>> +    }
>> +
>> +    return NOTIFY_OK;
>> +}
>> +
>> +static void spi_geni_unregister_notifiers(void *data)
>> +{
>> +    struct spi_geni_master *mas = data;
>> +
>> +    atomic_notifier_chain_unregister(&panic_notifier_list, 
>> &mas->panic_nb);
>> +}
>> +
>>   static int spi_geni_probe(struct platform_device *pdev)
>>   {
>>       int ret, irq;
>> @@ -1161,6 +1220,15 @@ static int spi_geni_probe(struct 
>> platform_device *pdev)
>>       if (ret)
>>           return ret;
>>   +    mas->panic_nb.notifier_call = spi_geni_panic_notifier;
>> +    ret = atomic_notifier_chain_register(&panic_notifier_list, 
>> &mas->panic_nb);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = devm_add_action_or_reset(dev, 
>> spi_geni_unregister_notifiers, mas);
>> +    if (ret)
>> +        return ret;
>> +
>>       return devm_spi_register_controller(dev, spi);
>>   }
>>
>
