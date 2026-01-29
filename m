Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E4385EDC
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769687334; cv=none; b=fbg83O1GAkBB78ufymP6S8PrSDo7edJtyCAWQfOEIzVneeRAKE6LNbQV/g6ckVLvi7G06enyBWJTxJsuKL5vvtYRDCzKs0W4JTv2/KAUh6MNAe7gC4kp6C58p2IBWt3zxsAz79QGCj9FLtZsWv+ssxVZx9uOB2X2ZQEoqo5rsiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769687334; c=relaxed/simple;
	bh=XGtEW9sYxxEQoEJ86svblR5vBIkLxNGxvEMFBIp++AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKAyGTgkdDjR8VOZzxN+YmtOvolRC10aX4JFrV9DTwUVBbwkFJh8mPYnWPlHLRSenmp28ZzMu1FYZQ6BKmz/Bss5Nf0V49vRNjYtIbcC02mrd2EAcXIxXZz5wcbzR8LuDOzP7IIbk7nnFbb/nPLuvMTqt3FvgT9nEua6ck9hPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l517gSHH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g0YE3QMR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l517gSHH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g0YE3QMR"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TA7IIg2033208
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 11:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KT3r35ycF4+0WV4x9asOenPmmgjU66IYBmCFl+LsQ8A=; b=l517gSHHnUmEKlFG
	zMk8IpdPpRaZcfcWD6U3gb+4JvEfK1Jj8W1g4rgmcuYNQMJVcrLriF7/ya9WHtvK
	A2M02/z1g7fDSlB0Ej6giLO+WImEzNAO3i0CD1cur5ddHlMvTDPqtFsb4ADe6Sdw
	ZWJZjkrL5NK4ppu+ERR02KYFhlk9hrqAV0z3qf9GxNfr6KhY+ODG9NYAuffqGlsF
	HuZ8T0WUaVtTCZiv4b6euako4T/WSnTO/GDj2PSX84YePQhjQBCO2WwDqOE0D+TK
	NOsY1Xh26PTpQeLpvk/qi8x6iH8TAdNeV5pOSKWD0gA+Nq2Xvnz/maCz4fGXAf6v
	1Fl+iA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bytqy2ajd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 11:48:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-894662cba4fso2526546d6.2
        for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 03:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769687331; x=1770292131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KT3r35ycF4+0WV4x9asOenPmmgjU66IYBmCFl+LsQ8A=;
        b=g0YE3QMR/3wW1k50TGq0xtcb4Sjjo3CqrzCdkYiIOQzm8XNv9QDqg9YkPnYGwQZGzj
         UT99i6wooFeBIX+lvv/07kS5VEs3GYHO0+T0aDE5psVjnajoNGtWPy9qZPCfzOmqaD2R
         XPGZiGh3uDMLTn9kcM9x9BqY+q1To04EnY8Z8LtxtfgpOCjtMer51P9c656wqIeh2sdT
         C2TrlUHuZ/bNrtW5/5Qb5juL4LQ9MRhHUBCc16xD/9qNYLyb/R89L7+7dpGCXEiIjXby
         dD6+sB4kVAzePRxMNqXCm/LhHjJOvK9RPPCNDijFgBohEob/QG/zaLFBl0yCW9yhxLXU
         PlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769687331; x=1770292131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KT3r35ycF4+0WV4x9asOenPmmgjU66IYBmCFl+LsQ8A=;
        b=dh6hshPhsvOCAvDgQcG/NwhoxHRiWN2xy5GUVFOEa43pRv0rsT75fNsD7pIrFt2quP
         qVlwYDNELsQK95h1H7m+mDnL1YV9dQdK6jxtbpzT8g3JTM9C9sjAkfMHImkDe4weRXcK
         dkYuStOdaM5uxhwOhiYLAYUNJp0JpktpeDWaWtpPl5zZM0W6FeQKDCekLCzm+YhmvluN
         EkYVkX9+k7k6A3ZpjGLTzW248EpZ3INl7j/RC60vJrPKeZjxVaUOjY21lC2PUn1ARcGc
         TFc9N5lcIzpWNzj1VhMK8by2MmIHW4f1+IJF1XEEt6qHDKtRDdoE3TYZR7UUFv5vFRCX
         S3DA==
X-Forwarded-Encrypted: i=1; AJvYcCVPEsPKpOJAyWIoAVbPNb49cyUA0CNxI6eXupSMozbkTexbi6E88vhXzYCZcl3A1crtTQGrwgCQdbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7kzcvf6Bq/3HVbvDkKmnvAj4YmykrSgwyxdZPOlpJnko1MQGL
	fB9wvr6TUCaC64iTBCoznTSkGTDrfp2SClUHBTkx8xNx38XeO+/qre0qAteUrIk7hg6pPcKoGtP
	h4uJ42MSFAmW/6klnlc3FbrBms8SLkZ2fP3WLeb3vn7T3N/HmKv8sbO14GfUkPsE=
X-Gm-Gg: AZuq6aLmjMFnStpOtfO3u2Csrmlk6VbCOjCe0n5j5fOQy4QJVWC/1h4VxUCDQvUj13Y
	hpoDEmH08xHE8Ht3nAJKcn4K6c4wNJFmVi9fNjNK6pzZpirzCPngfjIQl6vEjsc+sZXHtPhqs8T
	45uaFrxOnhb4DXNU4b7XI9EeMNaTBOyw9Ze19r4RKC0SpAfa3+xFshPX1A48oMiw64r2yQcXd2x
	WrrMmMjhDPP2W1hzG5jZbflYmnCjLMWL4DgPcUbWB+KQKjc8g+Ve0GNG68QwK4O7ZySncYyOW07
	Eks/uv4Z0+FNiBg2A1WNAsBwTKIHF59ONmlI1yBbwmMHwQkP4cSgJyHdFcQM2vXGn95R2T6OlJq
	ZdFiX07Gldr0kQIh9txzO8IJOELkVoCoiZL/YsksxgQyXvIhVuP4yWcAgUdDbwebACrs=
X-Received: by 2002:a05:6214:600d:b0:894:6c97:691b with SMTP id 6a1803df08f44-894dcd48128mr40187786d6.6.1769687330653;
        Thu, 29 Jan 2026 03:48:50 -0800 (PST)
X-Received: by 2002:a05:6214:600d:b0:894:6c97:691b with SMTP id 6a1803df08f44-894dcd48128mr40187576d6.6.1769687330151;
        Thu, 29 Jan 2026 03:48:50 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4256a4bsm2782251a12.2.2026.01.29.03.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 03:48:48 -0800 (PST)
Message-ID: <0fddd038-185a-4cc0-b080-d12ba973cce3@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 12:48:44 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] spi: geni-qcom: Fix abort sequence execution for
 serial engine errors
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <95bdb386-1635-4f8b-84dd-b5123d271b7d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA3OSBTYWx0ZWRfX+ZlbBQTt16EE
 VqUynAzAdkEKproIpLszF3BJHtPbQXjqk5tLFw9sp3we8WQ0Xp/O8P8CeXdK0Xqc/0mc0MBTRxp
 5/8r+SS+GBximLVf87LJ5vlfgiX3qt560sMdcSYmID1Ikfpj4viISTBd6chfBBEWbIy7sZX0zXH
 ryWuHeQccF4aMrwFFVL6/h/MzpPdKTTyxMU19kYF0GU5s8O/3xmBlNP2+xPjHlkUzme7LgKkDoj
 ZjujZHf8Y3cemHq1X/SDyPk+pptaKwJpjPHsrRG7qVia34J0zdpJKQVIyZgJcu33bXOgrxVP7Zj
 baXmQUwX1Fs1DLxVbT1JiCZcBUxqvS6988eKs78pxtNv0wz9x1/Q22yJOWdGjoiaL+d9GSQRweH
 BJxqPvZksm7kmpExoHHvrASd9dcEcOAXvDPpNt+yL6NHXevMj0LRwp9wmtkJWjiTBAwcY9Hc8ss
 PWiiBOPRPgP/6suIkCw==
X-Authority-Analysis: v=2.4 cv=Je2xbEKV c=1 sm=1 tr=0 ts=697b4923 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=0IK_tM0JmRZ4naO6_g0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: GbZHIX01DyVIFPXT1Xni5IPmjYZpFMXq
X-Proofpoint-GUID: GbZHIX01DyVIFPXT1Xni5IPmjYZpFMXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290079

On 1/28/26 5:22 PM, Praveen Talari wrote:
> HI Konrad,
> 
> Thank you for review.
> 
> On 1/27/2026 6:47 PM, Konrad Dybcio wrote:
>> On 1/22/26 4:10 PM, Praveen Talari wrote:
>>> The driver currently skips the abort sequence for target mode when serial
>>> engine errors occur. This leads to improper error recovery as the serial
>>> engine may remain in an undefined state without proper cleanup, potentially
>>> causing subsequent operations to fail or behave unpredictably.
>>>
>>> Fix this by ensuring the abort sequence and DMA reset always execute during
>>> error recovery, as both are required for proper serial engine error
>>> handling.
>>>
>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>> ---
>>>   drivers/spi/spi-geni-qcom.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>> index f5d05025b196..e5320e2fb834 100644
>>> --- a/drivers/spi/spi-geni-qcom.c
>>> +++ b/drivers/spi/spi-geni-qcom.c
>>> @@ -167,7 +167,7 @@ static void handle_se_timeout(struct spi_controller *spi,
>>>            * doesn`t support CMD Cancel sequnece
>>>            */
>>>           spin_unlock_irq(&mas->lock);
>>> -        goto reset_if_dma;
>>> +        goto abort;
>>>       }
>>>         reinit_completion(&mas->cancel_done);
>>> @@ -178,6 +178,7 @@ static void handle_se_timeout(struct spi_controller *spi,
>>>       if (time_left)
>>>           goto reset_if_dma;
>>>   +abort:
>>>       spin_lock_irq(&mas->lock);
>>
>> Now that the jump is just 5 LoC, you can dispose of the goto and change it
>> to an if-statement
> 
> Is the modification below good?
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index f5d05025b196..4feaf24d47ea 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -167,16 +167,15 @@ static void handle_se_timeout(struct spi_controller *spi,
>                  * doesn`t support CMD Cancel sequnece
>                  */
>                 spin_unlock_irq(&mas->lock);
> -               goto reset_if_dma;
> -       }
> -
> -       reinit_completion(&mas->cancel_done);
> -       geni_se_cancel_m_cmd(se);
> -       spin_unlock_irq(&mas->lock);
> +       } else {
> +               reinit_completion(&mas->cancel_done);
> +               geni_se_cancel_m_cmd(se);
> +               spin_unlock_irq(&mas->lock);
> 
> -       time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
> -       if (time_left)
> -               goto reset_if_dma;
> +               time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
> +               if (time_left)
> +                       goto reset_if_dma;
> +       }
> 
>         spin_lock_irq(&mas->lock);
>         reinit_completion(&mas->abort_done);

I think we can make it even shorter:

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 231fd31de048..59567ef6759e 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -161,25 +161,20 @@ static void handle_se_timeout(struct spi_controller *spi,
        xfer = mas->cur_xfer;
        mas->cur_xfer = NULL;
 
-       if (spi->target) {
-               /*
-                * skip CMD Cancel sequnece since spi target
-                * doesn`t support CMD Cancel sequnece
-                */
+       /* The controller doesn't support the Cancel commnand in target mode */
+       if (!spi->target) {
+               reinit_completion(&mas->cancel_done);
+               geni_se_cancel_m_cmd(se);
+
                spin_unlock_irq(&mas->lock);
-               goto abort;
+
+               time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
+               if (time_left)
+                       goto reset_if_dma;
+
+               spin_lock_irq(&mas->lock);
        }
 
-       reinit_completion(&mas->cancel_done);
-       geni_se_cancel_m_cmd(se);
-       spin_unlock_irq(&mas->lock);
-
-       time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
-       if (time_left)
-               goto reset_if_dma;
-
-abort:
-       spin_lock_irq(&mas->lock);
        reinit_completion(&mas->abort_done);
        geni_se_abort_m_cmd(se);
        spin_unlock_irq(&mas->lock);


Konrad
