Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006692D0C8F
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787031304; cv=none; b=lR3F4/d83neQr12gF3LzraT0VaCi6yzfL82mkoW3+km791NlUrIoiOdHtGOOmvlHlxd+B3stskPlAHfCgzPjBmh0AVX6NsDrHc/F2PeSWBIi104BVICVvJEJ4EqDPRNJW9r5wcBFSzGMXsGeguujkkyORj06VZc0M/a0kvgfOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787031304; c=relaxed/simple;
	bh=937cBjiDkSVjUvXYFLJRnSxbQ1op4kLnG/ZQ4cZKCIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjsjjSMgr+rTdqc8qxYkpqtK2Nn/0EdYKOVYg5HCa9ThastjF6yUHyB+itcxkt04R15b8PJhZW+XEfaZJy55zC+P6HyrsLfsElpEsiwbf9JFFjn5T7ZS51cMecrGp1S/x/fBoE56Ty8vDjKo7XD7pxR9JqUPu3nm6TNYbmpsPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mke5dGlc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JEnwii5v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mke5dGlc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JEnwii5v"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I3G6g73833956
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 05:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y0SIHNHEr1GKYCbBglF4YzbkpCW6i3Jo/GjHjnWOyG8=; b=mke5dGlcJesHo5UO
	n1tomtdA4100WkAc9vaWTtfb/+lMrLFAYlCPl0bNhXrN3cZnBi9IBk5tG4z2OOKt
	+KJxWxn5TPwBo3miAsCX6xSFao/SMjdkD2cUDgeJvZcTgKEG/OnheED9X7uggTuU
	jrF7TG9jv75/50jfOnBJqnNgxwCZ0WGYhwHgJo4FGHZf2fvko15Yr7nk4//KLr9+
	k6YkcLfkuipXX+uwBfTaG3i7veO+SPzGZ0xlv8SNV/NcyTZssY05KLiQ3qLtH62n
	UVGnRsIc7wO1JNTTalBT9XLeZR+9iH0g1G7nr7Kx5WQbR5kE4YLYbQFr/+hTmx7Y
	g8LU/Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fba8hc0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 05:35:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca8aee88725so6503645a12.3
        for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 22:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787031301; x=1787636101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y0SIHNHEr1GKYCbBglF4YzbkpCW6i3Jo/GjHjnWOyG8=;
        b=JEnwii5vBv3dBSIzKrcRjawLBjOeX3gWHr+KOC3gWcsyjs7fyYGZ5ohx7+PhTP4Lza
         ZJTyNmIyh60ZPNDSa8bkJQmXOXyMerJgEIX/3zlBzdTRppieKbVngWkfkpqoDEE2PM8R
         p5Qoh9GnV72KWZuDQjCGj2V/r4ly9fgkxpVY33dLe69GuLS1MoQfctPPfZggODTIy0mr
         V1uzIwvpe9WsuxUdj2aFrN+WGeICTt09WV3JKCbfVoYPdTtZogiaahRwVET2SlqcJ1L1
         wDgePUGqYNuXzlXoN0wyI9TMALK0nFqZ9FtO4Icoy42ssDwtia97/1MaAE9FK6JSu4Mo
         IBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787031301; x=1787636101;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y0SIHNHEr1GKYCbBglF4YzbkpCW6i3Jo/GjHjnWOyG8=;
        b=FUH3whKEQwR19zntgXe9QhMMsQ2aBjJ6qu1Y7RyV5h6PVfpCThv7L9L6tt8NN8KEA/
         mpnnFqV/tzFCV8Q1FYH6YO7bumjKLFJhLERIoNK0Mo702KXb9FCEZEzgmZbcjN0/2Zjz
         FYtWJXIqDHuNg2hNVd09BHsi7V5oWXATZl/zbDwe4jEqQjudiyIS3C1O/8kxx7rQwyG+
         7HKSjxywLwK0O9zz1BBl/LgDjaez7hwGa8cKAguogjnG2bOst1taZmQyrG64xZpL/7Sj
         LbSoNIwpXSa44OTRmOc00GLciPPM50ltKm6adco1RdJBsjFjGAdyO8Bj8iwJ0ADQ9eme
         4w+w==
X-Forwarded-Encrypted: i=1; AHgh+RqvTLxV2EwzDrxt4doPc/ADwMg7CEyGMk0zW88dcgiinOgtUhnRjgQlWTl0WYGKxAv9eSCxv69W9KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTcjKhNRFAipoMHd5ZQPtuKUCKdd0zHi6N+oylqUSf8aCkoIjh
	azrIfU4aHCdAEG2G1dM2F0L7Hu+LkTJVl5tTpENIa3RlGnlBri+yvl2EutM55CB4JUpENeWKxh7
	NjavXtbD0x+P86DLipJmfEVr2BuEGvTh/R1HZf38Lh/SA2N8rnvBxZfW6KsN1fAk=
X-Gm-Gg: AR+sD12JmTDmj8+3hbMt9MFWoh9PS1r5PqUMX12+l4hm6iwVqKME4TjdRglOaF4Gmfi
	p21EslEFu4EdHrAALBVcqChWLMLaViHcTfhyK+eHFGnupwJf3SXcKJPeyrDFzSWdvl2vKxTLYy2
	0eNYD/yLOjNkUphi9nJRmMWT8iGhA6U+UgGdYVBWm+XptmM//Aa2BnNH5vRZhWb65NqLPwIMS/u
	EJ9jwMIMUtqYfIx6tzc6RrgxddCMdLFFmdwJAYnmTFLh0zUZEFaZdDsbOJh+ff7PUcCIrjbkOJT
	0Q4u222dHpX1SKJXA54AoOtIT2703hboUnVioG3Jk23p8emp1L5awiKBbxAW+mFMK19MPQKXfyr
	g0/lu8HGJZiC9tkj1Kv9ac9h0c8c9bPs=
X-Received: by 2002:a05:6a21:6d8a:b0:3cb:8810:631d with SMTP id adf61e73a8af0-3ccda918cfcmr7367964637.1.1787031301326;
        Mon, 17 Aug 2026 22:35:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d8a:b0:3cb:8810:631d with SMTP id adf61e73a8af0-3ccda918cfcmr7367883637.1.1787031300761;
        Mon, 17 Aug 2026 22:35:00 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13c03320esm1572687a12.25.2026.08.17.22.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 22:35:00 -0700 (PDT)
Message-ID: <c9544d41-0782-4632-9d5f-a06c0314e90a@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:04:56 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add panic notifier to suspend
 controller during panic
To: Mark Brown <broonie@kernel.org>
Cc: konrad.dybcio@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com
References: <20260805-add-shutdown-and-panic-notifier-for-spi-v1-0-b5db170d491e@oss.qualcomm.com>
 <20260805-add-shutdown-and-panic-notifier-for-spi-v1-2-b5db170d491e@oss.qualcomm.com>
 <92fc6c7b-ea87-4577-b200-2bb36388f387@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <92fc6c7b-ea87-4577-b200-2bb36388f387@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzOSBTYWx0ZWRfX5roufKBkLcg0
 LdWAO7ecBbNOjgTQcSPvEWaj8PL0na2uHs42Mam+d8vYk5ac0cMw2FC1GwkywPJ9wVtfDo54CVl
 YCwrfHK65ISaDFof0vp7rTMlUbJpKz8=
X-Authority-Analysis: v=2.4 cv=VsITxe2n c=1 sm=1 tr=0 ts=6a83ef06 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EIQud5khxiMJNvOwFl8A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: GGxly6eUJz22Cy8mZmszY-EEgiIXf5RM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzOSBTYWx0ZWRfX/bp89uBEopti
 25lRfS45VzM1jL2YY/onhmKzvJY4Oq+bPc5bON7M2RaOSV2U4SIGGl+OZLxAaZOdKc0SGsIVJPZ
 FdfGmb01pj8XP4tV46Dsz1kNG6M+qmfSvoFoz2+yKOhDsz7iIhuJy8VkalVfAf5PxBW62wAHXgZ
 hk8REVYyLEqMU+McvRXUgRfT5reYpHrxVPj6e/scn2bCoz/sVdbmvvDPu/f065qiOXAiF4Hz5QN
 IEphfRWL5nRs+BiKqSvAwILgirKEuw70CMJxzmy/0SrTWfTKWFRVqHEIIyYyWMyK4/Jvt8Nqzt0
 ERClcEsebiJnRwyc7/T9CxocWDZejhCPAfTo8kW6pn0621kuYdeW5KlHl9Reu+3tp2CWmfP1/yg
 g1T9bmaXRxWnZP2KKcvODHhMkpGD45i5Sf9k1CyOc9uqOi1tkFQOqp25hl3RZr1w9LCKU4KtjSU
 48oRPzNQsNxxNMj+ENw==
X-Proofpoint-GUID: GGxly6eUJz22Cy8mZmszY-EEgiIXf5RM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180039

Hi Mark,

On 11-08-2026 20:06, Mark Brown wrote:
> On Wed, Aug 05, 2026 at 04:12:10PM +0530, Praveen Talari wrote:
>> When a VM crashes with an active SPI DMA transfer in progress, the
>> SMMU raises context faults as the DMA engine continues to access
>> IOVAs that are invalidated when the VM's memory context is torn down.
>> These faults can affect other VMs sharing the same SMMU instance and
>> obscure the root cause of the crash.
>> +static int spi_geni_panic_notifier(struct notifier_block *nb,
>> +				   unsigned long action, void *data)
>> +{
>> +	struct spi_geni_master *mas = container_of(nb, struct spi_geni_master, panic_nb);
>> +	struct spi_controller *spi = dev_get_drvdata(mas->dev);
>> +
>> +	spi_controller_suspend(spi);
> This will take locks - are you sure that's OK in a panic handler?
Good point. I hadn't considered the locking requirements of
spi_controller_suspend(). Looking at the implementation, it can take
locks and is therefore not suitable for panic context.

I'll rework this to avoid invoking the SPI core suspend path from the
panic notifier and instead use a panic-safe mechanism that directly
quiesces the controller without taking sleeping locks.
>
>> -	return devm_spi_register_controller(dev, spi);
>> +	ret = devm_spi_register_controller(dev, spi);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mas->panic_nb.notifier_call = spi_geni_panic_notifier;
>> +	ret = atomic_notifier_chain_register(&panic_notifier_list, &mas->panic_nb);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_add_action_or_reset(dev, spi_geni_unregister_notifiers, mas);
> Should we have the notifier in place before registation, what happens if
> we panic while probing a SPI device which is probing as a result of
> registering the controller?
You're right. There is a window between
devm_spi_register_controller() and notifier registration where a panic
could occur while a child SPI device is probing and issuing transfers.

I'll move the notifier registration before controller registration so
that panic handling is active before any client device can start using

the controller.


Thanks,

Praveen Talari
