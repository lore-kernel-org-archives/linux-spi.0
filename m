Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7976400962
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525996; cv=none; b=IM7dFeu/lehAbDpXU0TjDXb2KNIRfVOa98rbkDjEw7gCT2k6dBLmNuT/D2Or4JP8E5uU/0eg0M3i81SO3xg2lpsuoIVYiAKXgbM9pED0udK4MqX/Cgz1rUvaE+ORjK/GRck7YB5Cl3AqQejkVY0ET/RiUXKSsy32yA4gAyS5i9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525996; c=relaxed/simple;
	bh=ocgX1pDw3Akkw8kPU55zkyixBru7VgTxC2qT9emL7gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBYhcvIgInT0l6gcNkHWm/kDRju/31aQFkf0JlCtP68ScTo7LKiDW224CdDDTaIy1pJqCbBaP8IQ9ELznHiy8leIdYqxcXZYCyofPFOvy+07/xLEq9avZz2PFN/Yy57wMX1Ztq6d3PA6/9/2f5BWIkrldlbkJZKrWXDK6PHnL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=osRJ3OkD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MlodgneH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="osRJ3OkD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MlodgneH"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C8YVNk2987339
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 09:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	en3WBeGYYKKXUQNTqjZIewPokiWrCYWKofzjGcl8Hwo=; b=osRJ3OkD/txwrGrJ
	lYo1OSnlvhhGF2/i/13Kk7xLHpWivjlqAtdThdDCHwc/s3INThmnBrcB7/pHbgST
	pHDUOtI0/SRtNYiJuVTPGDs9/WB/L/mpnGHwbMmA/vUH24Qm0RkxNIf9rvbvD/mi
	cnohwO9Jl61A45tm9uE2iamEmWawRtIN8P/w9AsuIIFcZfX7IqOgi2PjtaxgCJYv
	t5PpN3VcOt0gsNEFwzU4Q02tQb5bGnmtcqHnZIw5ElWmkIGLV5Tu0AtBuSuJfnG4
	CznYM1wo3J/6JAbGhzpf8/HISfINk1wpHjohJR41rICy2jZLt5tYzRDIxwhleqRI
	17YWHg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049kmgh5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 09:13:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so1330165a91.0
        for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786525991; x=1787130791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=en3WBeGYYKKXUQNTqjZIewPokiWrCYWKofzjGcl8Hwo=;
        b=MlodgneHx3h4LPKC9I1/3d92DFw6aChr4Ldy+qUCOw4dZ5WQZsWuBX/ov5Hwy74fNO
         LLHBFVew17tYR7Tul3u6l4jaLpFxbcbDn1BHltBHgtXWtrUftZqiMyYkpyxKOP0ZWYjX
         Cqk6U+jkj7JwhBNMMFvh+8c2D5ehLQDMc/3bokn2gXUvUFlrtEbTe+VbA/kkpb6gAzhr
         IMVQLe+4LISV7kQTKbsWFblJg0NoIZTdStsMgHCMSNIr0cGBwV2ZBNO+r5xPvMwgfFHv
         lk9nI6n+MvIkiv/3BwOCQ2Ayf9qiM6bWk//nIOA+Tu5ajI+S5oCci5iNw8W06aQ2YU8i
         ONHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786525991; x=1787130791;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=en3WBeGYYKKXUQNTqjZIewPokiWrCYWKofzjGcl8Hwo=;
        b=HT3UTrubbgOkNs6NQDaRAKrSZrH5X6QlE39TJbaIL/5lCGYr564TGnxoIAA5ZJVami
         cExPe0QZqNSZEs0wVYaxmaT6ed8R4fENJpGWTXuZog2CnDE/ZuBSHoNzlT87vBg1BzSM
         bZfvk7VkKiYKfd3xpdp+W3Ettsogxtl8TTKvoCDDGl0XKIA1VaAFSIc2p5F7N8g3WCX9
         46+raJY9/ZKr9MK+4IF+eAlFzF80OqE8gizO5NtOEbRyy+8Bjh5QUXPoQnapym29eKH2
         6v52O7z3zy6IaAgIP3A7yUDh4iTJ95S45eQLeMmT+QzITuwLAfPFUYbvKMQpvkE6u/tO
         Dp0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpaq/DoYI9qDW5khginwijcSYnDCOuXdkVg32gC0y1ubrpPbRvsWUfdCBhobUdUWpId79UgfJOSsE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxiqRtAmcCWflxGVXKaGf9q0gadHlSy1xsr08zSOXzmMh8KZg0
	3TtJT1QKnNuYoXxw9RvsRetqq5PEZbtuCoCV1Cx4aYpkuVRvRvhRu6yD9S79BZ/NRXZEU54d2xG
	FSdjdwwc0qbSo/9O46Mig5Bow8jyE3YJ10+PYqiIUjoz3Yocs/aV88VIQWMDkueY=
X-Gm-Gg: AR+sD101e1hECNtLPj9atlnY0V2nkENVX9UiTkm1pNIZpaL9+KbiGkXfE5Yc1e3YcJG
	A8ECnxC/Jab/CP9J7zrNylcijI/YcX7eQh1H7BT66kheS3iqCFgNAqwpyTRk/xJH2LquCYJcdFt
	UQ6/T7bRnFAfdDRQ6pVn2H/ngA3eryAN7z1CRVPqe4G8C5Pmr7Y/n5onFzSdZKLUmLr30YlG5fY
	zLR4JXLI2mOL5NF/FWJAHiSViqoXnvm5EJEOE+fxBvvZCeNhb5UiATe1pisbJO5CnUfkvKzcUkn
	vGveolWDzIYeEYUyg5kVqjYCMWrAkhy53mVkIiU0WsCw1EZBgFhM11DVtmKJB2Xoth/jwCzvP08
	ylIg9u88qTPWyThpouAVkLLc62dbQhqIJYw==
X-Received: by 2002:a17:90b:3c11:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3930119ed5cmr3829314a91.4.1786525991255;
        Wed, 12 Aug 2026 02:13:11 -0700 (PDT)
X-Received: by 2002:a17:90b:3c11:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3930119ed5cmr3829241a91.4.1786525990816;
        Wed, 12 Aug 2026 02:13:10 -0700 (PDT)
Received: from [10.217.219.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f88d239esm2915805a91.6.2026.08.12.02.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:13:10 -0700 (PDT)
Message-ID: <779ec0da-4b51-4f8e-a59f-d482f8e8dbaf@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 14:43:02 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
 <d5d64ea3-9c6f-41f5-adc4-9923381d732b@oss.qualcomm.com>
 <CAPx+jO_-1tZfZcjae9shyWcKPsj0fM1SvRzC9_JVOvJr--EeuA@mail.gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <CAPx+jO_-1tZfZcjae9shyWcKPsj0fM1SvRzC9_JVOvJr--EeuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oUAUZA0ROCA6gfRJN7hBA_eEbecDvMyg
X-Authority-Analysis: v=2.4 cv=IO4yzAvG c=1 sm=1 tr=0 ts=6a7c3927 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=GpIJag5-aaecOpU0j1UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MyBTYWx0ZWRfX6XR3KAvvZsvA
 TTtFutcXGin7QCVHENiM96wNV9eUhof6b35b/MHDAJRfQsOPLWWI/nuzSYk6ytufbC2RUZR7NmC
 9i2xm2MDxfFExUh/3BjRnB2O8ojhmnfGVVza9kFDiari84AsnzgT9Z7Oa86zno7YC848A8j5kU5
 GqL2PJH2I7SwMDG4bH2h301FCecuNrx2hju3kvFZ4S3BkFah0TKepGgr2UgNXo9D35FWsTg2250
 VLUZu0yzuYE24AaLyqWdAFagxl0vTAs/wZTnru37xfmBX6XlPxCbnD6PEUkN+dgx4uPghOhD3Ij
 HLkWYktUbU6E7qZ3gFIt9UFNRh80xX86d6TteNh6gll3ooXgZhFCz89bS+tN+8oT37eIws6KYFs
 MhrhLTG8Zh8m9Zp/4p8FevWBXrdVkAhIOjUtIeJdWCpwMwWhthbmhvmcvFAIU188UYxpys+C/PN
 rdHzXTTNSjnNfsQfoIg==
X-Proofpoint-GUID: oUAUZA0ROCA6gfRJN7hBA_eEbecDvMyg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MyBTYWx0ZWRfX+92zn1UC1Ovj
 GqVTcY5iY69jSNZ/rFPzgKXQZx91ihSSAxtTtZFrvxV0El4QjbP48qDIVRCg1eKtagP0TAtwCEM
 /vaBxEAiaaVhYm98NbU7Kgza2fuPt1I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120073



On 8/12/2026 2:27 PM, Ulf Hansson wrote:
> On Wed, Aug 12, 2026 at 9:24 AM Mukesh Savaliya

[...]
>>> --- a/drivers/pmdomain/arm/scmi_perf_domain.c
>>> +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
>>> @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
>>>                return 0;
>>>
>>>        if (!state)
>>> -             return -EINVAL;
>>> +             return 0;
>>
>> Won't this cause an issue to other drivers ? how are they going to take
>> action based on changed return value ?
> 
> I think it's rather the opposite. With the current returned value
> (-EINVAL) the driver doesn't really know what to do. It tried to drop
> its vote, but that failed - so what can it do?
> 
> Moreover, from genpd point of view, this fixes a real bug as the
> aggregation for the performance state becomes incorrect during runtime
> suspend/resume.
> 
Got it, thanks Ulf for your explanation and also read your previous 
comments.
>>
>> Remove Acked-by due to this till i give back.

Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>

