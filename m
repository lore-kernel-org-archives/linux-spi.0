Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2744C4FE
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306156; cv=none; b=n89KwhMWjZCYixrury8uzFNUZlIKR7PlXnYT1C7kvHUnx6BD6SCT8qWUtjvB6yOhQ/YBJpTrUWKrGKRZ+61HbTvUungl2Hywer+63Zjy4SNY5p5UvESlT3CTIURX1WzQ6WpWPnJVQ+Sr7LBNLW/X4Mg3W9Vdl4ihGFoME0Ws13w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306156; c=relaxed/simple;
	bh=h07MlbR4zpwjxk1OAWIHqfGIVg0JNyAMUwKv5muQyC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTR1QXQ/voci1AfSyb5BCVZUD6eSygTF6AO5jUMfln1RdgDKCox7xgg0GC09wsK6d53cpDAantDR/SZ988w7lKHHzuF2P+cIKOB4ZgQpv6v3KcxAqexM0Go6xi9AfHrT3sw50PXTsz+d/ZFX0nzfXyryutQB9w9juBpqxIaWKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HuwVBfZ1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=In0ktByj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HuwVBfZ1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="In0ktByj"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9LwEB1550421
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 09:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VClMmOILbaRk+It2Uje1g6EoFtr+YGAAo4jOnTeOag8=; b=HuwVBfZ1duPyEjjt
	dPngyi0yTgWEG8Y729IwKskVbWUs5XdoAVXjCKqw2QpTRwmJc5uKMT1IBJ/0djD+
	HxSANLg3PUwV3iXyp1/NomBIn0s3R9/Yf0ky9BOrWeOCCbZscnEzF8FYf14JY4Rn
	chkUS0Sz2rh9BRFplc7sTVqZBhlFe5dOoB48FQrpJ3AfA99z3tAihTFkWKIxH3j9
	/h24T24r0fe2It0mf6Q5gkBX/+9hqNfTUUiq+6ZbXrevS/dF3OsnJjpwQQD2yPYi
	ARJNIL6UhVpmRHIqk1dfhXOVRbrRcc3SLjpc2aqpxMj9tFmgqqvmcEuCi/wzTRry
	kQ7Vsw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6d069n4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 09:55:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso1189840a91.2
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787306148; x=1787910948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VClMmOILbaRk+It2Uje1g6EoFtr+YGAAo4jOnTeOag8=;
        b=In0ktByjg5jrdxOt6hjBCngCHfjnuDDvIRoD7ettVIprOim9BCf9N9VQGT4JxRGuA3
         5aANvWKJCJYiiVXmWFLpwsPpCT7VPG6M9/YipfF4Ejf9RIHT6BRugIq7ynWKXTiCom0j
         oQgsJrSYdvhDfRR01jrGz76iojfKrUojEe+kplosJGzg6WwY9aF8lCyIiYlh6U6kisH3
         HDiekDQkVytvyccBitZcOYSTzvzKONcuEkieGMKeIp3b3DsS6ujTaAhDzp9IXytSoudJ
         G2sMlJtWVtP6f4YqmfjW9C+k+DYC6kS85hXi/KmA66impuxa59ny9tgxVeWIXghSEsoZ
         EnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787306148; x=1787910948;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VClMmOILbaRk+It2Uje1g6EoFtr+YGAAo4jOnTeOag8=;
        b=btS/MJc8QSvoFsx+G6e/YiWE810KjUq3GtuHzDnI8vtjl/l5kp4yhkreCnbz3nbkqE
         6GqoNkX2WSXh7moNbirugCMjnlE97Tin/KKPV4AR1EVnBJbyIZPVkoq9n5MHu5gKRPcX
         F8bdecoAPLYKsjNA19ejSQ/6/2AZIAxCCF5LV0OYWN1tuLsUarbQKebKDd5jU9JQQ/CS
         omT3XElYHeC9BNYPHpf4FCApSLXHGyAzup0X18TmGMunVVEj1sgUs2jyMmfuJ1DXmJJI
         asV08IS4Mh9zFktjTcQm947jVh9TTcn9KVwkkCFBXIwTQxDWa9rB1gu/DfvRLK3KqxdR
         8oig==
X-Forwarded-Encrypted: i=1; AHgh+RqIviQeGTvR8XU7kpT0L5hkYUtvHOXkStmnfxR36ExuNnDrJZluBosaITRJmsp6iv4kOyxfZmqKa5o=@vger.kernel.org
X-Gm-Message-State: AFuF++mUVYMJRYAQRY6ozZqtSZnpbFldqsLEBT7sVyL9Jv0c0UOBCz55
	TjmZ1WvD2jKxxkTJ0p/6Gl/DEzQDWXueM99GF42fhv+RM9UgCVihwuuy9u+KrgB9s0NQcF9srn3
	afWH8Drtq2pPc3TRV6e/OIQsmkYoVb7KJf4knoPgsgzMZW2jPWtogkiR7twXuV+M=
X-Gm-Gg: AR+sD13yW/2z9mhhtPcI0K/7iL4nB3O/A3xKF4QREMlomkwb0pFf8LRDlMwNi11BP0a
	6ltLDJW7KIl50QbPLUnZlRlIugT45+CgDmHFDgvRWtfMJxqgyhV5vyRnIF3Tiyb/0+3jKO3LLt5
	Pt9zAsOaWABu61D9wSINZrbbpyk6b+DjbrjkFZa46fcUYwyHmTW6mWh1YqKCX1okV8ia4R9/nbw
	v/bXjgN7B1YEzfoJbflYUHyxYbKek5kH1maENBbkRS1y772d7fUBmuOUp/D2iTZFxB22VUw3Zne
	7zYdIKhMVpK6MrAt0id1+h2hit9pQuOwXVWAxGPfH+WZyzObJv/0hCihVk6SWYxt0zk7s0fHFGP
	AJYsVJS37a+5gJ61R0ovx5fX0H80huJg=
X-Received: by 2002:a17:90b:528f:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-395c35636acmr10037766a91.7.1787306147443;
        Fri, 21 Aug 2026 02:55:47 -0700 (PDT)
X-Received: by 2002:a17:90b:528f:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-395c35636acmr10037590a91.7.1787306146553;
        Fri, 21 Aug 2026 02:55:46 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4be47d7sm2437968a91.9.2026.08.21.02.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 02:55:45 -0700 (PDT)
Message-ID: <b117d9ad-7fa3-4130-80cf-d7cfbee20fba@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 15:25:41 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Add panic notifier to cancel and
 reset DMA during panic
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com
References: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com>
 <20260818-add-shutdown-and-panic-notifier-for-spi-v3-2-8b62c4bc2d21@oss.qualcomm.com>
 <54e4fa7b-9a95-4871-94f9-65ac55688f7b@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <54e4fa7b-9a95-4871-94f9-65ac55688f7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3MyBTYWx0ZWRfX8vhFoy4YarOj
 IuCf56Xj2oAD0K2+xUUH8JNreJTS6XnMx71d+OAC8SXSCkVdfHgHCIG1pu9ahMdPRqdxg0vx5Hn
 3+QMZ/+bc+F+czgXnJ2iiOJvopeh3Tuw2RYmUuSDtsDYFhdeUbiWO7NsWF8vLsurbbq7wuFmzAo
 XQhQH5EGEa2AycbQjjRNKrmNYR7uI6IZCHakd+6+7SfaFB0ICSNzLAL5G8Wrl6+nPPCLDB+9TpP
 FatKdvTUTGzREUrmbvV9YOaZrwp+pz4rg1n4H9fe2xKqqJZqLiKgwnvRwu7nncX7xlrd8+pH/AM
 U7p3KvLEJeeYqGTp1mX3PFgAkJ3bY5Nf5m7IsUqTphB03+qMJvPsafWPwdpykI7Qz4wtFuKJUbQ
 0Ma+j18RNF6rZUEZVJkCwqfxE2fkbkrriQFP17Jd0jgboLEoQFxbxqdxo/YjfhYlgGQyhxw1Vo0
 slJckjeXi+HuLgIoazw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3MyBTYWx0ZWRfXx/oJm6jbywzU
 LhV7bpyHGNdDmW6JTEdXKisPACWb53S4qxSzOOMb1VFm8VsfoVN/Avzi29vL15h4UkoOzDI7vev
 Wv6R7NSX7NASopVSUMg3xL4lvudjlwQ=
X-Authority-Analysis: v=2.4 cv=DdQnbPtW c=1 sm=1 tr=0 ts=6a8820a4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=01GmVmAJTjHGYBpbkKwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: cCtQ_u6fS56EdlbWXo7yhwwFPLUe2NPK
X-Proofpoint-GUID: cCtQ_u6fS56EdlbWXo7yhwwFPLUe2NPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210073

Hi Mukesh

On 20-08-2026 01:02, Mukesh Savaliya wrote:
>
>
> On 8/18/2026 6:58 PM, Praveen Talari wrote:
> [...]
>
>> +static int spi_geni_panic_notifier(struct notifier_block *nb,
>> +                   unsigned long action, void *data)
>> +{
>> +    struct spi_geni_master *mas = container_of(nb, struct 
>> spi_geni_master, panic_nb);
>> +    struct spi_controller *spi = dev_get_drvdata(mas->dev);
>> +    struct geni_se *se = &mas->se;
>> +    u32 val;
>> +
>> +    if (!pm_runtime_active(mas->dev))
>
> Not completely sure, but why not NOTIFY_DONE ? we haven't handled 
> anything here.
My intention was to treat this as a successful no-op since no action is 
required when the device is runtime suspended.
>
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
> Shouldn't this be under FIFO mode check  ? As i can see SE DMA mode 
> and GPI mode conditions present but not for FIFO.
This code path is shared between FIFO and SE_DMA modes. The DMA reset 
sequence below is only required when the transfer is operating in DMA mode.
>
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
>> +        }
>> +    }
>> +
>> +    geni_se_abort_m_cmd(se);
>
> why abort is done directly for target device and not for master ?
> shouldn't be combined with cancel failure ?

The target doesn't support cancel.

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
> May be good to declar macro for 10usec and 50msec ? Multiple places 
> it's being used.> +        writel_relaxed(val, se->base + 
> SE_DMA_RX_IRQ_CLR);

Let me review and update.


Thanks,

Praveen Talari

>> +    }
>> +
>> +    return NOTIFY_OK;
>> +}
>> +[...]
