Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8495D7E105
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701753; cv=none; b=REsr45xye3Z4y3bI9CxEmjDfHzcUFcY8lRkQBMtAe60JaxVfTpbta1M0GE5k3LAfbBeVqvJoDQE4UDzOsnxKlskZzsLxJwK/gdwiVpz6eNPY7rHFaB+6hChk46y1FyiKyjHkSV5oEbvEh20GIpzl9KQsPzWxv/L5u3jCynkpjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701753; c=relaxed/simple;
	bh=wcTESOf7AidL9TI2v50Z1dwmr64aG7bhXo2++sRShtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N999kUHXB+4GLNIVBNvj6KQyjn8tNA42DxVL8cBjljXDh6XfoeIaaHr+9fPDfCw2nJ/V7RdieTPR2yleZPRMt/SRhiNcYmW+3YVIyCazlbDqo6YzrBKeRNik5uH/ADG1f6+QG+2Luj6gNYLav2WZRypQeSN8zd47Yn+QWcV0HsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pjqwH6xP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LNjBzL/S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pjqwH6xP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LNjBzL/S"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TAQwAX2501987
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 15:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9l3lRufO4nmq9wcYZ7mtP19dWxQPitgYMjCxPzwqxjg=; b=pjqwH6xPOOqRpE/y
	czy200ckVhFRUSxnQPjs2AibbZuYeW45qXCo3dIFua5hGhczNQZBVp94Ztm7HyWa
	nQDhUgIsNaqbuAFsjLV72NxVPcyLfGN8vUaFt77Ooh5XDc4wy5AsTCiBtAfAFQ7w
	zrcySNRPMQVIJWfc49+Xtejfkt8OreSaNzWw7Q3u/7IcO98BFsgRM7y+W9HBmY1S
	MYB6MLPJ6mblXmC4/wvzdsq3moTffGqsSXD2R7WF+cFYw9wO5ebrYvv9ZX6IlaQE
	J7N4Akj9RHCwaJ7+JUzoCOzmkX9Ed4oNeyUq+4Te4Mp6BlRUnxcC5jDeOrjS8V6h
	Z1QOSQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c05tbs08q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 15:49:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bce224720d8so737248a12.1
        for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769701750; x=1770306550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9l3lRufO4nmq9wcYZ7mtP19dWxQPitgYMjCxPzwqxjg=;
        b=LNjBzL/SdUQ6vESIBAH7o/HWS7qJwEclvouGLGijYoKW5eyBmHzlhSHAlW1xTeCIs9
         Rg1/EIt+sCOHK50n9vjDa3Xi+SD9mv/pPHHZkmfFY40YMcMnH+xl/7jxdqlQEM4ixb+A
         bmcZ5Nbr5T7AO+zF0N03gQR+yQtfQyY+B6CefLlwk/IOpEG4aMcg5xcqaZ9Lahg6jVF2
         fkFkoEpkrQbzn7ddcb0MFAMe7CXnz0rq8QN4b5o/YZJfk21M01gmdx73jU8bXStoZXSV
         N0SgD4U77ox8zzlm2ppyYMXCJCYmi53+kbjVPXTTRKbvnLVwdBJ5Eo9ms3DH4Oc2LbM8
         ekOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769701750; x=1770306550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l3lRufO4nmq9wcYZ7mtP19dWxQPitgYMjCxPzwqxjg=;
        b=P09aMyv9m2+e446YDJpX9ntTMsjL+B79I5r8U5DdEmKNVSpFsPwqYL+JWAI/URVOLG
         EPpWXqjzMhEDrCUY521F/39KHqbWUqU8yNSfvMbhL/+pKQpqGLXwjrHI9EdaXPBqUZ1p
         xfGcNuVuU0aFd/PMZbv+Ey+eEeLqwbtLjQhY3qflf+Bllx63MY0KXIXyp7uSInQ7j7y9
         JONlF5deZszfNkaQFFnEDuLRthI2G0NukdfZBtpLXtliCfhZkXUUwrrZHHBCzX0DDGKy
         BiFsBUztAjllhSabJqDfvYmqsjRp0wkKUq0biAm/ZPxoA8BjnyGMcWsyueTlx5mr/WoR
         XA9A==
X-Forwarded-Encrypted: i=1; AJvYcCXiP6u4fu1RORsQMlvR4aNVSB8qIB8PoxK7yepTXHixq2vlnW9oWgoO4NAiDuFcRdO2TycnQS71KYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRLKM0j5iMOQBZlc5RAo0INPN0j1kGs10zOG8VfI6iqdpdGZ3s
	lZ/5bElvJda2PiEjj51TdmeAr07u2AMiA4B0MSMLIB+Hp6BRiXg3qmi52xGO7Hpzl+J+9OaBv3S
	dQIlSKt9Rw9DOs/6j05f8roe4tj/V6ySYKHdlWDKgcUVoIfwYqCMqmom95YmESNY=
X-Gm-Gg: AZuq6aJHkwaJgn5P4mS531X56XD6La6vWpvy4Uf8vcL21TmWBxk7sHWmrpfY/zPWXbG
	3nWZ56liojK/oGZ+P2Ldxh/n6x2QQOdd+jAVBQ/MYinaXNVLbLL3LZtfc/xm8+SUcRYbOQrPx4y
	rENOkcUG59y8eKtTkOh0AXfvbzerflznRoRvCfsQbuM+CJzPp4S8SFdhwadDxPkka7xjJDaQUos
	jiNfGID5bFxwZ4KvfDC2y5wwnbyt+rJ4pKCZLuEh4ub6osGGu2tfjGFKWJr0KJV5A3RJ723WI78
	9UNQ76XknrWVL2XpYvu8EggrWfACdMDg98u//2txTD3UjkinJ3PlynusOu7qEOYxsUwj9FfImB2
	GU//kzR/k1Uo70Tu0cJy9bXc/ot44XEpWowYyIaCLgA==
X-Received: by 2002:a05:6a20:7350:b0:343:af1:9a57 with SMTP id adf61e73a8af0-38ec655cc0emr7712048637.56.1769701750337;
        Thu, 29 Jan 2026 07:49:10 -0800 (PST)
X-Received: by 2002:a05:6a20:7350:b0:343:af1:9a57 with SMTP id adf61e73a8af0-38ec655cc0emr7712011637.56.1769701749595;
        Thu, 29 Jan 2026 07:49:09 -0800 (PST)
Received: from [192.168.1.2] ([49.204.110.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c64276efbb7sm5048588a12.2.2026.01.29.07.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 07:49:08 -0800 (PST)
Message-ID: <565a54cb-32cf-41d8-87fb-d60be63cca95@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 21:19:03 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] spi: geni-qcom: Fix abort sequence execution for
 serial engine errors
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
 <20260122151008.2149252-3-praveen.talari@oss.qualcomm.com>
 <9d9d4d3d-42bf-4f4a-99d3-19df73f89c30@oss.qualcomm.com>
 <95bdb386-1635-4f8b-84dd-b5123d271b7d@oss.qualcomm.com>
 <0fddd038-185a-4cc0-b080-d12ba973cce3@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <0fddd038-185a-4cc0-b080-d12ba973cce3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nolMw5JfvFuIAiJFROmy9dA6g8nNzwFS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwOSBTYWx0ZWRfX6E/xnPxsMU4p
 XTaJu3t7X6rYnowpWYXAaFc5IFhQeRClFm9JqgtiqLrapI8EEO7MGLv394AzQjTff4Z0FwESuQw
 z8OAZ0WP9/aQZhC3/LFyATDCdSOvUB/1o74cELj9Byrq+HaFMpQH6kbqrqrPHakVrCqo1a4B1D3
 crfXO5nVmfyGbeIPXnNt036VxZ6wNrOdQLbcBflFHsGmKIvIFYblPyBrwh302Xb+Tbi0zOq8KQ/
 2TJxXpUL6Wg8Vj6Z/DlroqYeCxvC3iu5bSTGjcfy32Je/ezk5qC3+zNkGaj5QhWSKNjYyOMhCt3
 a0/r3U8mfl+NolD8AjKFvtZS+dx8+8jdzPsvXIZlODhwLofjpfeQDRz/tV5n9vvIUvHjAdKDTjp
 gyODrAHcXmORXIOMtehr3ozUO3+ldUkqHf5RvmNBKAGW+lQiQr6JAaYn0pdgR72t8qBP1pBCaKw
 xz4BjSHqGiLXQoo1OTQ==
X-Proofpoint-ORIG-GUID: nolMw5JfvFuIAiJFROmy9dA6g8nNzwFS
X-Authority-Analysis: v=2.4 cv=betmkePB c=1 sm=1 tr=0 ts=697b8177 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=hmzEZbfuJy6/QR5cQt8XuQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=LZ84-7LdfmDJ-_vHDukA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290109

Hi Konrad,

On 1/29/2026 5:18 PM, Konrad Dybcio wrote:
> On 1/28/26 5:22 PM, Praveen Talari wrote:
>> HI Konrad,
>>
>> Thank you for review.
>>
>> On 1/27/2026 6:47 PM, Konrad Dybcio wrote:
>>> On 1/22/26 4:10 PM, Praveen Talari wrote:
>>>> The driver currently skips the abort sequence for target mode when serial
>>>> engine errors occur. This leads to improper error recovery as the serial
>>>> engine may remain in an undefined state without proper cleanup, potentially
>>>> causing subsequent operations to fail or behave unpredictably.
>>>>
>>>> Fix this by ensuring the abort sequence and DMA reset always execute during
>>>> error recovery, as both are required for proper serial engine error
>>>> handling.
>>>>
>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>> ---
>>>>    drivers/spi/spi-geni-qcom.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>>> index f5d05025b196..e5320e2fb834 100644
>>>> --- a/drivers/spi/spi-geni-qcom.c
>>>> +++ b/drivers/spi/spi-geni-qcom.c
>>>> @@ -167,7 +167,7 @@ static void handle_se_timeout(struct spi_controller *spi,
>>>>             * doesn`t support CMD Cancel sequnece
>>>>             */
>>>>            spin_unlock_irq(&mas->lock);
>>>> -        goto reset_if_dma;
>>>> +        goto abort;
>>>>        }
>>>>          reinit_completion(&mas->cancel_done);
>>>> @@ -178,6 +178,7 @@ static void handle_se_timeout(struct spi_controller *spi,
>>>>        if (time_left)
>>>>            goto reset_if_dma;
>>>>    +abort:
>>>>        spin_lock_irq(&mas->lock);
>>>
>>> Now that the jump is just 5 LoC, you can dispose of the goto and change it
>>> to an if-statement
>>
>> Is the modification below good?
>>
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index f5d05025b196..4feaf24d47ea 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -167,16 +167,15 @@ static void handle_se_timeout(struct spi_controller *spi,
>>                   * doesn`t support CMD Cancel sequnece
>>                   */
>>                  spin_unlock_irq(&mas->lock);
>> -               goto reset_if_dma;
>> -       }
>> -
>> -       reinit_completion(&mas->cancel_done);
>> -       geni_se_cancel_m_cmd(se);
>> -       spin_unlock_irq(&mas->lock);
>> +       } else {
>> +               reinit_completion(&mas->cancel_done);
>> +               geni_se_cancel_m_cmd(se);
>> +               spin_unlock_irq(&mas->lock);
>>
>> -       time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
>> -       if (time_left)
>> -               goto reset_if_dma;
>> +               time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
>> +               if (time_left)
>> +                       goto reset_if_dma;
>> +       }
>>
>>          spin_lock_irq(&mas->lock);
>>          reinit_completion(&mas->abort_done);
> 
> I think we can make it even shorter:
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 231fd31de048..59567ef6759e 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -161,25 +161,20 @@ static void handle_se_timeout(struct spi_controller *spi,
>          xfer = mas->cur_xfer;
>          mas->cur_xfer = NULL;
>   
> -       if (spi->target) {
> -               /*
> -                * skip CMD Cancel sequnece since spi target
> -                * doesn`t support CMD Cancel sequnece
> -                */
> +       /* The controller doesn't support the Cancel commnand in target mode */
> +       if (!spi->target) {
> +               reinit_completion(&mas->cancel_done);
> +               geni_se_cancel_m_cmd(se);
> +
>                  spin_unlock_irq(&mas->lock);
> -               goto abort;
> +
> +               time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
> +               if (time_left)
> +                       goto reset_if_dma;
> +
> +               spin_lock_irq(&mas->lock);
>          }
>   
> -       reinit_completion(&mas->cancel_done);
> -       geni_se_cancel_m_cmd(se);
> -       spin_unlock_irq(&mas->lock);
> -
> -       time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
> -       if (time_left)
> -               goto reset_if_dma;
> -
> -abort:
> -       spin_lock_irq(&mas->lock);
>          reinit_completion(&mas->abort_done);
>          geni_se_abort_m_cmd(se);
>          spin_unlock_irq(&mas->lock);

Thank you for help. will review and update in next patch.

Thanks,
Praveen

> 
> 
> Konrad

