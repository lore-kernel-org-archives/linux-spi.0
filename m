Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2B31A570
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 05:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006517; cv=none; b=SR5FJze+zz2AUUR6+81EqySB5hDg2/FMihKorlLoBSpd1wwusA68D1+eFzdyoiW4oE5cmoMcSzlSJzEB4t47O3xxvY3ad702y1K/UymV9bH1OrMPrt2eKgTolgUcLyGs65Um6Sp0e5H4ImIVZSGNNuk5QJSfXzv/xB8GfSDMu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006517; c=relaxed/simple;
	bh=TuAodXskmsk6PpOUP7bcreyJUVtepgakQ0Ia6qBO6yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbmWJTtfxVYE8RqNXgw8ulL0BM+xPP2SwrdNmp8TEGVkgtLJtMc/MwRqenoX/vdvMutkoQAN/1Twgh7BLBwEfgDHm+SptJotDODFqjYgl9ks3ShKxITT1dBni2+IUNHiA7vsbuFQMFbJkxCaYi8ucvdfeLyKc/brel+ALBXpXoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ga7ciTTX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FQVFj787; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ga7ciTTX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FQVFj787"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E385Wq3556609
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 05:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A9GY5SmmKpXBp0S4UpoTVLYAhXq0hiNnfIA35k/Yeeo=; b=Ga7ciTTXlZHchP5y
	CXm0Hb5IiuHPAAzHw/LV3WURvZcT8WuNWYzDJ7olnGQ4qtHhZ19Wc5Bg+J4CcEto
	uMAnHTYeRCPgiAKVmSi3YWrHOm860/8BOSfSUKvQQ9G3Q7cW9XQQT1AaRu1rTSKA
	uua4CfftwzQmZsW3kuw5kGsNZ/H03sqvD8xT7dIJ+K9axjzEMq84ZQb+Nyykl6GM
	RzNIzkHkp4QotepVCvPzSznMH0bzwYR4t0ROcXbuTbRzlNyD/oa8PvjMWz9OVKRB
	GMn1uZyu6jC0c5/vb8GPKUxe8T1ZDSh6J38Fu7kpQRq94YLpol26Ctq81ONeYn5o
	UKXftw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44ct3ag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 05:21:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c916d17dd43so6730772a12.3
        for <linux-spi@vger.kernel.org>; Mon, 13 Jul 2026 22:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784006511; x=1784611311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A9GY5SmmKpXBp0S4UpoTVLYAhXq0hiNnfIA35k/Yeeo=;
        b=FQVFj787dafAwEeiJ7rVH5Vi/BBHnlKHlshOHIqs2IdztPoIFAxZBZZbx6Gq92UBf2
         dhSWHuK+GPwZQkcBgPs/aIw6VVQQ4ELM7IK2RY4JzwUiwfTbexEvRc+ynl+xcovxCcrl
         1EUGM1Up0YRoFK7qWp+fHzC8W8PbNVewVbOAYFAOTFsTDJX6zBiKApJOXQlknel72nGM
         bEr3cTiaq8HsPx+yrdDK6Jt7JdDW4Oz3hqhOxlMd0ioitny9Bimba7NRVGwPY5EjTamJ
         Oz1XAOlRp6z+9r/+mFpcgwR/iekOefQFGJYSGvp18r1xfy06l6GsqZKMFoOFiYhg0Fsp
         cBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784006511; x=1784611311;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A9GY5SmmKpXBp0S4UpoTVLYAhXq0hiNnfIA35k/Yeeo=;
        b=qatDFAwskmEvjrCpbrTUYh3WeBAOIxbpHQMhz/m95MA8a8ZyGF3I0/KWP8awTVja5R
         0wT9Lg8m0ywW9bK31EaalNoTY+O4WpbagXtPUKMVoSb2EibnRx6kJQRqQWcmOzV/ntXy
         3BBjL08j37bP9yejEBf0tWe+JXw0qzRYIwWCJz/Jg4DFXmY3evIBRkJ/y4RvNxt9jJAO
         Z78BrHUHTHKBHgsPbt0HNg3vA080G5zRFKYtzXSEgMtKTXPA2DltWnTayKotZXcIGSWn
         B+6V2iqzmABibvJq36zweRgW8dIWMG2KREFlinAKYH5JnXdaUSSIOgN5XXzKd40Ddfoi
         5HPw==
X-Forwarded-Encrypted: i=1; AHgh+Rpl7GJ9NxX6kx5gfjUezQ14QzzybI0/eo6lH450pww3e8An6oDq4uaZwJOB/Ywsdc5rHXVgY0jaV7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyYTCwJNni9Syu4ACM/FXhL5N5WXCXshpNEFeO7LWEaPS3VpC
	xrLYIzTQKpfMAUdaLNfG3CDZhvx0W2wVSWRF3teVmA53B/05fOPDyDALtFq/Vv0oGqAkDlUIsXW
	ZOBicNbE4TAmOU0mKNHyocwVNKSz8y0Besy6f4SRNx+YPRr0WLR4LswJilL3HiVM=
X-Gm-Gg: AfdE7cm3YKVf0wYTLyI8Lqr1amjBWYunONNnTiyKoUIvndXlSonxtn3gJz0t01tPWUE
	LE58AWQs0+CsHH/sXHWn4o7y+22sn6iIV913OoFQMg2mMeO7uOXmcZ1031uPSyBDmC6gPUHQ3wv
	pNDHo0ylhNiMHJYhqDms+nkhT2fB9qWJYFV2+WuEcte96uy4ikt4bZVIdcNXYCeK5KEdaztUpH8
	kJcIemvAarjEhDGm14EWrhQvjM46UgonTFIiTQR0FduGZJt198q7CueWtn6Ab1yrldXCjgg9A0G
	Otz8ZWes0QRlLsIHKulVHoBoOTFuw0UxNi9KgKgnl4MYuTxcfViiijep+G/Y1/LrzUfXQ/eQPmz
	UcBtIjhR66yLVP9UnfOD2jcnUk8v49O6v2VmggY8jQw==
X-Received: by 2002:a05:6a21:4cca:b0:3c0:9c19:65b9 with SMTP id adf61e73a8af0-3c110a66059mr12624707637.65.1784006510611;
        Mon, 13 Jul 2026 22:21:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cca:b0:3c0:9c19:65b9 with SMTP id adf61e73a8af0-3c110a66059mr12624675637.65.1784006510017;
        Mon, 13 Jul 2026 22:21:50 -0700 (PDT)
Received: from [10.92.197.28] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm42074011eec.15.2026.07.13.22.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 22:21:49 -0700 (PDT)
Message-ID: <788b1ebb-db13-4f6f-9e92-46802d7027f6@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 10:51:42 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: qcom-geni: add GENI SE registers trace event
 on error paths
To: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260711-add-tracepoints-for-se-reg-dump-v2-0-ca1e9ba62359@oss.qualcomm.com>
 <20260711-add-tracepoints-for-se-reg-dump-v2-2-ca1e9ba62359@oss.qualcomm.com>
 <cc4797fa-6911-45a3-8775-69c2ef32a338@sirena.org.uk>
 <4bcaa245-2127-45aa-bf05-48e275c0129c@oss.qualcomm.com>
 <72cb70b0-d89d-405b-b2b9-807e028d6fd3@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <72cb70b0-d89d-405b-b2b9-807e028d6fd3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nMMpAuxsUQzQ2W0t539ZrH-Sy6KxqW1Z
X-Proofpoint-ORIG-GUID: nMMpAuxsUQzQ2W0t539ZrH-Sy6KxqW1Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA1MSBTYWx0ZWRfX4oWoxd+06gfF
 WdQS8zFVvYN3pKCu8x/jnD9gprqRO/ODmXD4Rc59rQ1cfllJSDd7fu0gyYAwQqRyxXcOds/BNj4
 pGHEdOO0LIazgnTf6TVaziK/caQtswM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA1MSBTYWx0ZWRfX7+zXE6iIwxlR
 56Uex7jw4+usnlkV0DCxoFCM9jMXjsfUDqR1dMUpALOWxwjz/TgOio68ITrNqXNAkoVscmHJvRT
 n2kl9MrqjRUIJYKxDlKDdJW6cuxCX6Unej0IjGoTxw/5dJ4QNw84eFv3/EaZwmauf2Ksep2HGY5
 xu9hviikro5/hSZ/AFn94curBgXxKp4+KZqqyJzpNbcTYgkLfg++aFK/4oS4e6N8amEd4VrGa+M
 qFvgdnHhuGjPY8/KSMW2Bia+eaoMWVHetatzV3qjF4f3aN6neyS4bANTJEMw2ZNEUtVtoMhDZwU
 rXsNop9FizABKMb/lNBxDhceTDagfJv62kpKcqrOh2NR9XqIgv7HaH1vBv3i8+wHF0ikLw9SDCi
 pM59wmQ80PfDNBdow0+Tok1W/EWOSoXqNJ5mdi0zIwxSxxpYkTnfZh3tD8+Nj4cvEbMdy8xDjk1
 n3M6HFMtsaHX2vDZkBA==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a55c76f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=JsoTjjDMo91fjAJr_joA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140051

Hi

On 13-07-2026 16:16, Mark Brown wrote:
> On Sat, Jul 11, 2026 at 08:21:02AM +0530, Praveen Talari wrote:
>> On 11-07-2026 02:56, Mark Brown wrote:
>>> On Sat, Jul 11, 2026 at 12:18:42AM +0530, Praveen Talari wrote:
>>>> +#include <trace/events/qcom_geni_se.h>
>>> Should this be in rivers/soc/qcom/qcom-geni-se.c (and the first patch?)
>>> - that way if another driver starts using them we won't multiply define
>>> the tracepoints.
>> Yes, you are correct but
>> If this header in drivers/soc/qcom/qcom-geni-se.c, how it will be access
>> trace API in other drivers like i2c, spi and uart?
> The header needs to be in the users but the CREATE_ define that you cut
> needs to be in only one place to actually create the tracepoints.
Sure, got it.
>
>>>> @@ -986,10 +997,13 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>>>>    					writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
>>>>    					dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
>>>>    						mas->tx_rem_bytes, mas->cur_bits_per_word);
>>>> +					trace_geni_se_regs(se);
>>> SE_GENI_TX_WATERMARK_REG is one of the registers in the tracepoint,
>>> perhaps trace before we write to clear it?
>> it will be captured in m_irq register so it is not required to capture.
> Are you sure that won't lead to user confusion?

No since m_irq can capture most of other bits as well.

Thanks,

Praveen talari

