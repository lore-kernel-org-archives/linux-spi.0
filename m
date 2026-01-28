Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E107313E20
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617350; cv=none; b=M1IX9XA6uSK9dt0y7dNjp5HzQCtCY3Jhrknp1DGhK9W1KwLl7f/i/KmkeANDcFsXL7V7l2G2+zLmour1xk9gz3cg9xsGTRTKMuOZE2pqrFNQWp2+5u4+te6/9s0z4GRohLYQzxgkC53LEZigcQ3HZkEkSI7/InODwkg7iDumpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617350; c=relaxed/simple;
	bh=BFmYWAlpvFX/+2manpRQERqUJt3ncwaRQx6a7NzM0fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCR8qG7f23lJXznujJw9EElvYHizlp6GljZ817jryRCdYqLO+SNt5DoV5V3CsATX6QlY6PvCwd5MjaaFA0zYu1CmElTBquHLkmNFH5vbVZ8IWaV3hFfuj+pI4WLFqIWRAa93ax/q7nwMVtouDdXBz/FYLRC3uZfxUDO25V7mwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hZqSl8XU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FPMlbX9j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZqSl8XU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FPMlbX9j"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SFelui3879271
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 16:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cm4xp5YKm3EkGWrIxhnF9M2qAJpvBH5Bb3MxePIzadc=; b=hZqSl8XUYtd3AQLc
	YU2K7rkc7G7GFzcXuBhta+OFdFVYBNq+/eFjkoXlICR6KTDHf4TfD+/1R1w17ZC6
	bXQge7sXQxcXjOKSRfK4Wz/0jENVluooQUuzcVRNnohqAORvVPzmeOF60HCMlAHs
	bwFEOQ1EjaFNXoXBmUrS6GYaZPuY8sumMRDHcEmhhzNkYPY4CIQNiYQsVA9lOgOj
	oV2Qf1sLVshf9AXkuqMAew4JU4oSGGw0emAKckNr6hv1/KrxR6tFo9Pt0PMXeuhK
	J3M37nZrbBhGFKa1HL4w4JC6VAGJz4352Z+i+lroXCwoMsqdLuC+WwnBy6ID8DKi
	PQ7h1Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bybyv2c9b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 16:22:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso4438894a91.0
        for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769617347; x=1770222147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cm4xp5YKm3EkGWrIxhnF9M2qAJpvBH5Bb3MxePIzadc=;
        b=FPMlbX9jI/clA/DaeEuOBE1swu4GwqnxQDf3rq44rY6pRGqIj0JXn5MOV40uBFTcvh
         YiBqHeNlyZad5A7UDgxAzCkmpjvSSpRpnbt+xlctc5+HF0YhatKcYvngGxKjvEOrhyTr
         XlE6iPsRgSkBi6W2NQbJu2kusbZ7AzKIE/i5B7kWpRf3xal7Nkh54VbZqxt1OUbFuWoc
         MnR1BJTlHhaUq6x4XCfyf1fbZDycFUsuWS7TBtgnF5YTTCKBl1IlRNa1zjAdUtuZA4I6
         /sviP8z+2kizJdgL/rqckA0qOHY676pc+l97f2Ofg16ost1jJcF6gi5sbCCUW78/tK5F
         hxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769617347; x=1770222147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cm4xp5YKm3EkGWrIxhnF9M2qAJpvBH5Bb3MxePIzadc=;
        b=DD7jItU+DjPzHpl5VQYex7jgtLhZyoC5Kv8lInGE+uvajx9dOfNrRR19ZBs6A/h9Pg
         zvrWmglzMQlgQeuoZvkVrgNbb2NYH4FT2oTAnZhc4hyChvYMLe8LmcBFdOOtjc8gIilW
         9K489iMt+en2Z69d/fKiHmhQXARpI23HhzRHgfJXFTt3XSdsRsq4NHW87Y0NMvYBajIn
         VfCAZtcRnXJKHLSCBrhIke3ypYPiI3E9Jrh3/Aa4AH0/4zP7XC6Sw5oitGNyeeBCPIfp
         5zvwq2fUBBv8LxDDrqTCgWrP25ZbupcOMcFqIrLc7uMgHzy0RZc4sGK8vWbvdVawwSBx
         j64Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKGCD6hCplflr7nlTW28onlOn5CEY85ucx9fR8d69mUQN43wHv8C6Bryb8z+5UjUaYYSn/CO0qXIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGHTlSX8jaSuYE6g38G9INW9f/f+WODDpxzk6xZ6KksNobLrLF
	rKgXCF8Jlyf/TpZ2c3bc0M/HG9yZ1TDBn7DtqvO94k3BEDzqbuvEOC5Cj6p4XH2K9bpZa8yZtmy
	20idKk8kNFGy178FsXi2JXyK4wObT3PHQWnJZPPo94yiP3u+it3Htw8MLhFWtV8o=
X-Gm-Gg: AZuq6aLSrN36NT5z1j/lDQLoeW0QpCpYL+ctuE6c7vMnc9o4/C9GhGdbpj53IuWAkQh
	xw2Gy7IRpEAI65Hjpk/xJ9oi8Zq34+C9CEQ6bh/dfKbr+aO/jx8NYECGTbY9cZtlw9H9UiwVToB
	7j5AEmVD5wicO1q8zu/VYi0ppRsotIhClRnb8sUpIMSfc3iJd+gGKWtRhPcwDlCCBdz1EvqY4IM
	jCQsA0OFh5cyQLSXw1birKL4FIO0/GllwNaxJtTkRkqYahnyUfoTPk6/ksym2ox9mLeoJm7cMGh
	YAF1tC9TJig110Bf/xozYNo5DOByOH5OwAS7kC/NNsppkFWnaUHLfIwetAEe/fz5qh7xduFo4sn
	a8h4TcGKzWhj/WApvdY0Sb9Rjfg7eVVwzPQhnHrZfUQ==
X-Received: by 2002:a17:90b:58ce:b0:341:8c8b:b8e6 with SMTP id 98e67ed59e1d1-353fecf4952mr5634287a91.16.1769617347128;
        Wed, 28 Jan 2026 08:22:27 -0800 (PST)
X-Received: by 2002:a17:90b:58ce:b0:341:8c8b:b8e6 with SMTP id 98e67ed59e1d1-353fecf4952mr5634245a91.16.1769617346339;
        Wed, 28 Jan 2026 08:22:26 -0800 (PST)
Received: from [192.168.1.2] ([49.204.110.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f0283sm3487846a91.5.2026.01.28.08.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 08:22:25 -0800 (PST)
Message-ID: <95bdb386-1635-4f8b-84dd-b5123d271b7d@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 21:52:19 +0530
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
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <9d9d4d3d-42bf-4f4a-99d3-19df73f89c30@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: F9KYG5FSQIi50-Ejh81baOqvSni2eqCq
X-Authority-Analysis: v=2.4 cv=ZZ4Q98VA c=1 sm=1 tr=0 ts=697a37c4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=hmzEZbfuJy6/QR5cQt8XuQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Lg4E7-zU6_iSQFpiOd0A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEzNCBTYWx0ZWRfXxMwKtA0qIFJ/
 VYG+5GHvfCA5TXukyIpgRR/rYUU+2ywNk//CjguOQoqgDo+QuKLz1xj8pUQyKBhOZnXgekfJlM2
 zUCx0LGnw3vH3IxWyDmjc3RRZgOLLkmKC9PRuFvscHwgIejldC2CgsydkcN0tHe+l+qabfctORN
 kh6QM+KFbMB1rTE8c0ajmg3fa5t1C4g+4yYfE3nF4XxOw5jxosFr6Gb3zFIxpc1S+/U9HNApyPK
 1eESnd3TRzH/1bjPpYd/VII3Q9MuY6Nyu6+uiGQkAZCmf+yvxPN6YNAUh5Sp98wSlcvmCCX1QEw
 WPvQRq4ZDeKwGS0iWjq/1z/8Dud77h+XL+iWawraKxilotU+TGsOK+C+Hv0PHTwT4awwlg1HVfN
 kuZC7tFKkD+JY9O/pZCMbHxVl1FlrPgSoZeaEUHb67VXiDlbivQiFxj3q7dYZcCjtzQV1Q4v2Gb
 RuhJpxIx1KlunCv4m8A==
X-Proofpoint-ORIG-GUID: F9KYG5FSQIi50-Ejh81baOqvSni2eqCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280134

HI Konrad,

Thank you for review.

On 1/27/2026 6:47 PM, Konrad Dybcio wrote:
> On 1/22/26 4:10 PM, Praveen Talari wrote:
>> The driver currently skips the abort sequence for target mode when serial
>> engine errors occur. This leads to improper error recovery as the serial
>> engine may remain in an undefined state without proper cleanup, potentially
>> causing subsequent operations to fail or behave unpredictably.
>>
>> Fix this by ensuring the abort sequence and DMA reset always execute during
>> error recovery, as both are required for proper serial engine error
>> handling.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/spi/spi-geni-qcom.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index f5d05025b196..e5320e2fb834 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -167,7 +167,7 @@ static void handle_se_timeout(struct spi_controller *spi,
>>   		 * doesn`t support CMD Cancel sequnece
>>   		 */
>>   		spin_unlock_irq(&mas->lock);
>> -		goto reset_if_dma;
>> +		goto abort;
>>   	}
>>   
>>   	reinit_completion(&mas->cancel_done);
>> @@ -178,6 +178,7 @@ static void handle_se_timeout(struct spi_controller *spi,
>>   	if (time_left)
>>   		goto reset_if_dma;
>>   
>> +abort:
>>   	spin_lock_irq(&mas->lock);
> 
> Now that the jump is just 5 LoC, you can dispose of the goto and change it
> to an if-statement

Is the modification below good?

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index f5d05025b196..4feaf24d47ea 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -167,16 +167,15 @@ static void handle_se_timeout(struct 
spi_controller *spi,
                  * doesn`t support CMD Cancel sequnece
                  */
                 spin_unlock_irq(&mas->lock);
-               goto reset_if_dma;
-       }
-
-       reinit_completion(&mas->cancel_done);
-       geni_se_cancel_m_cmd(se);
-       spin_unlock_irq(&mas->lock);
+       } else {
+               reinit_completion(&mas->cancel_done);
+               geni_se_cancel_m_cmd(se);
+               spin_unlock_irq(&mas->lock);

-       time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
-       if (time_left)
-               goto reset_if_dma;
+               time_left = 
wait_for_completion_timeout(&mas->cancel_done, HZ);
+               if (time_left)
+                       goto reset_if_dma;
+       }

         spin_lock_irq(&mas->lock);
         reinit_completion(&mas->abort_done);

Thanks,
Praveen Talari
> 
> Konrad

