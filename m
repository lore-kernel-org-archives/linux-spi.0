Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491183AE6E2
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327790; cv=none; b=CdvPSstRwOYTrF085GbodP3gh3KDsbXA0kScIwMbWEMXoeU1+S261bD2Es32oGFZo29hQegxqoNqG2j9bQInQPKTjea/eCiAlpiua7pvTSOknxxsWAw1z4MQt1QQOxGHETrs+gIUJ0bIVytJoD5xfsmqmKDelHqzm+7sxKSCI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327790; c=relaxed/simple;
	bh=fyZaGRup6hPdizM0Mte1GZ6esSt8erN7rKBIRrNrYC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOWu+yGCqr8bH15DaXDRacgKFP8cCuGTfDHk70h6E1EFWiUQw2lg2Xlu1dlO1x8oPvyq7SATDDL5Aa6loUQRcrSGawR+Emkf8wbqtXb1l4LhJolI9cKjiZW0JBxGqFoFPNRGBtHeh+FE81FRkxapOmX0LzSNVwIbxNb1XMJsnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eeKHTRYy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Buelvu5o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eeKHTRYy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Buelvu5o"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFm6Ld3876557
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 15:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SG9NDd2LgAPZDinHwmDiEH0f0DghPC3ZLUoy0BE5OTo=; b=eeKHTRYyR8aXSPqf
	3TwqidDz6pmBBqFByP+f9gDvNj7lU29tTGRIAJaXcCkMxdKqupmgwiCTPfLF9QWw
	F9JVvk/LrH39/PSu4jJ+4rKyxKSr0jprX6Vd/LD3Tzvt1gpzO29LtEe14M5xoqhM
	H84NUoBdtETDQTDs4H/PnrQGe23QJbfxvhaV3AzluayIcvVBBeyW4V+iR1VgLL/1
	h9F6ZOMP9yWSUr8+IlOVSdwGK1u3j8Jaji1Luft+Wo41pg5mcI5g2h5xAMJgS8Nk
	ElpS7dvGCpgvXZ15ohVbpKgHDnYa8qs7v2HTwuILVm31CBKUqxat1HXXFyc4NRxx
	FcDJdQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fg9tfq6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 15:56:20 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8eeba1d9e47so7328496d6.2
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787327780; x=1787932580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SG9NDd2LgAPZDinHwmDiEH0f0DghPC3ZLUoy0BE5OTo=;
        b=Buelvu5oEdzczpDENCF6wtE48dIgO5MfoGGbmpEoJn6SbQUV0J/0aWOkAwBB/d/Ojn
         NV3jtkaafQWzrfgF/qGsh/pFV40UEz2CyiJZXQi6Z1y6lHrSuPGIArRaT2vIe+4sU2VU
         o90IRxF0peQvzFZNGZsSPC8T+nUyM5heqcPtEaVWSzN4PSKEvt2pGikZwGAAIY1ar0Fc
         3p4usV9N2RxBc/Y8vIGvIW0V7w0mObod/Tqr+jvYJJjYEpTqSnj1iM8KTmbKbJt7hH//
         /JyEQcIHSWrPxDL1ddvCPUzvxRwf12Pp6HousMEYklbrLYNcWv1hAVxPqCfKf1m4NdqA
         iIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787327780; x=1787932580;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SG9NDd2LgAPZDinHwmDiEH0f0DghPC3ZLUoy0BE5OTo=;
        b=coGWazZ7vZC0OhronT4lh2pvsCNvkzuY2p6Bfg9gIIIEQJuC4SUs3G0LFoApuZOPCI
         pUIVzwvzFE3ayOF+oLialS56APZil/F/Is1SY5UFBxesGkWOtNjbOUC/tHzTcjFPKGgI
         EfCzjNMu79BNcZDksZBphYQLcLFLiEdYVf4zPBQNc9biQUZH381DO55KdUpgRvUEMJuS
         i7ZRTRO8B/kS8pNaT5/62BeMYJ7RRoNyARzri/Ip5teZ4TtcO7G2UINdW9HZ27ptVYjk
         ZIfBJVVEER/jJVbUIRgEMoRF8argKg4AWygFzyRpNH8VmqzS+4LbcRxa/lUw1TxIZR7/
         N7KA==
X-Forwarded-Encrypted: i=1; AHgh+RrRpexbItU+xgBV4tuPpM+mCfaSrDWC3x4DdNeg8t5UobqE4J8gcymOZIREzMS24za/FDCa3PFdebk=@vger.kernel.org
X-Gm-Message-State: AFuF++n01NzIiFxch8uB8IKJBNLpqt9FIN3PgVIp8/Dd6ESEMjz4VxEr
	3HK9VFc6TtkCqpsdnXwmtlqf6o5HPqzZHSb8rZZK1PLQZQHkjcaSRpIN1WgVKjT+8O5YgynMlSU
	npGjApk/BDblPOUVhJYQHy2BqBOAgE2XAgWSys6UjWL8h7dRQvklTzRgKqDuMlJM=
X-Gm-Gg: AR+sD13kRf80kD/fQaJjwIycDNMR+kmKiX0UjEPLI+HnDwLRaI/UD2qb/JtutSiuTEY
	/Lux/mw9JwRRqbDQl7y3VSr2E3ebnPDvSc4hm/xSqEa61q4cz5dQwB8fCEyrtq4Aqgj0XEbE9f2
	sAI5Xpvua/i/689mWEOW2lffd9n2XB8WV3fS1ZdWrOroO6LthoUxkX7Hgp3YCIOGSAtOvfWWpSp
	kwmkyNGZI11y7xK8HC6fuqXyPu86VFetdg4MmMQZSN3zuYdPs2NEpJL7CDwlgzPtLgU4gfnvLpQ
	NxHdnhfVHz/edgCsvq9R4BirCgmTKK7S736EGA85FsXa2PZOKv9Sd4A25FlKdgA/AuUf6KinHzO
	IvOXpF9eHsuZ5fpJJYN2K4CYqtVWksnzK
X-Received: by 2002:a05:6214:8002:b0:90c:87e7:e2b6 with SMTP id 6a1803df08f44-90c87e7e436mr42803716d6.5.1787327779625;
        Fri, 21 Aug 2026 08:56:19 -0700 (PDT)
X-Received: by 2002:a05:6214:8002:b0:90c:87e7:e2b6 with SMTP id 6a1803df08f44-90c87e7e436mr42803176d6.5.1787327778984;
        Fri, 21 Aug 2026 08:56:18 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.109.127])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5edb4f75sm65109296d6.1.2026.08.21.08.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 08:56:18 -0700 (PDT)
Message-ID: <e76ec63f-db1e-433b-882a-4d25d9a0cc98@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 21:26:13 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] spi: qcom-geni: Add shutdown callback to quiesce
 hardware on reboot
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandana.chiluveru@oss.qualcomm.com
References: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com>
 <20260818-add-shutdown-and-panic-notifier-for-spi-v3-1-8b62c4bc2d21@oss.qualcomm.com>
 <d1dc6098-65a7-45da-a8eb-109e42f5f178@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <d1dc6098-65a7-45da-a8eb-109e42f5f178@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyMyBTYWx0ZWRfXySvU+e0pVyaT
 VZNOvOlKb+7UkMMLEDp/CWB7MlzrWw7A9ox1y9RbtLSD9rUMe4COpDoAly40duhKzAyI+y2yvCg
 apleor1Pd17MqBVbV8kwcomVpy9o4dnD8EsUDzBjGpdYwpLnixugup5gIFXuDTURfwjFxDnMkNM
 YHq1WvEoqD0z32TYLuNyofZtMcOua7SGLbBYAWRe6Aq0b7A02LE04jUiBWa6BfN2kJFBGBKfrWX
 ibPDnOIhSKfrOheFfczF9Xg+CRGAK1F3IVdAuchztWCtB9GVKRmXc4qnbLLegQBg57h4v1mo08C
 uUnoaDieYUp+w975C1PBx0x+t+AHR+XrO72eL/tT73S7KrEUiVW5MV1IfiLoiQ4CKvYanJ8Qs46
 gxFxnlaz15oHwJQpqYfCG/+7+bi6eNXV1fss/drUE0SxORwAcweChdkkKdkvALIW1dOzOHvcCvF
 zOfGlgvEeFZDLZ6P0yw==
X-Proofpoint-ORIG-GUID: khrAyWDtsozlvA-xT5yuOQI0TwC4j9hp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyMyBTYWx0ZWRfX1IACeC5M5Dlf
 scHOHR+TByqzcpqUxmzb0o3ty9NYjpqM6TwRrDnMak6RxQLb/qezUSA5tLXUUg8e480xiMtYzea
 SHFC+qICEwqg0kCK9ct5ywmo/O1KdmM=
X-Authority-Analysis: v=2.4 cv=Av/eGu9P c=1 sm=1 tr=0 ts=6a887524 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=6P0G4DzZkXptpLBtTzfX8g==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=2n5QlrmeVAYuqZsnN-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: khrAyWDtsozlvA-xT5yuOQI0TwC4j9hp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210123

Hi Jyothi

On 21-08-2026 15:59, Jyothi Kumar Seerapu wrote:
>
>
> On 8/18/2026 6:58 PM, Praveen Talari wrote:
>> During system reboot, an active SPI transfer can leave the GENI Serial
>> Engine in an indeterminate state. On VM-based platforms, if a DMA
>> transfer is in progress when the VM is shut down, the SMMU can raise
>> context faults as the DMA engine continues to access IOVAs that have
>> already been invalidated during VM teardown.
>>
>> Add a shutdown callback to suspend the SPI controller and abort any
>> in-progress transfer, ensuring the DMA engine is idle and all IOVA
>> mappings are retired before the system resets.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/spi/spi-geni-qcom.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index 6c57f8309a3b..c65c1788325d 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -1066,6 +1066,13 @@ static int spi_geni_target_abort(struct 
>> spi_controller *spi)
>>       return 0;
>>   }
>>   +static void spi_geni_shutdown(struct platform_device *pdev)
>> +{
>> +    struct spi_controller *spi = platform_get_drvdata(pdev);
>> +
>> +    spi_controller_suspend(spi);
> Hi Praveen,
>
> Don't we also need to power off the SE resources here (e.g. via 
> pm_runtime_force_suspend(), like spi_geni_suspend() does)? As-is, 
> spi_controller_suspend() only stops the message queue — it doesn't 
> quiesce the hardware/clocks.
The primary goal of this shutdown callback is to ensure that any 
in-progress transfer is aborted before VM/system teardown, preventing 
DMA transactions from accessing IOVAs after they have been invalidated.

In this path, spi_controller_suspend() invokes the controller's suspend 
callback, which aborts any active transfer and drains the message queue. 
The issue being addressed here is not related to runtime power 
management state or resource leakage, but rather ensuring that the 
transfer engine is quiesced before reboot.


Thanks,

Praveen Kumar

>
> Thanks,
> JyothiKumar
>> +}
>> +
>>   static int spi_geni_probe(struct platform_device *pdev)
>>   {
>>       int ret, irq;
>> @@ -1241,7 +1248,8 @@ static const struct of_device_id 
>> spi_geni_dt_match[] = {
>>   MODULE_DEVICE_TABLE(of, spi_geni_dt_match);
>>     static struct platform_driver spi_geni_driver = {
>> -    .probe  = spi_geni_probe,
>> +    .probe    = spi_geni_probe,
>> +    .shutdown = spi_geni_shutdown,
>>       .driver = {
>>           .name = "geni_spi",
>>           .pm = pm_ptr(&spi_geni_pm_ops),
>>
>
