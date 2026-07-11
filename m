Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2714F274FD0
	for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783738481; cv=none; b=hp7MV1xL7rus66Rg/X7bw01GdBcbPTLo7aJYHFHYMfYf5Oo+Xz3BgiH6Vhf7PcVTkDdxjr7lbvkrqrUNQ+KpUc8mHFxCYIc6wnkWa/I6KSqQvmDXoJXyAP2qXY0yoq8vZOme/o44MQQEJA0PDxm1vKEdHI4HoHApjuIFQ6ggczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783738481; c=relaxed/simple;
	bh=e+5oTDlJE3JeVGw8kwraD9BnLZNaTeaClLqHopfsvpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThGasvk0BDKKu7Z6DYrgEpxpEHQd0zqLR1EE3ZuLgprBz5V425+HlY02gwNR+7CtlUmjSPycQyo1ffnnRZd1TTVDuUMrHW6Co8MRzA5+LjM97ctTx+6RF1V0W5T9W3TX8P2bRps4MxJ/POP+eId3tKKlgzvRRFl9q7h+Yy2+ctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AaYX6Av8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TGxcB5cv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AaYX6Av8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TGxcB5cv"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ANIfma2254879
	for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 02:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J2+OHtFXDardG1nxZZRPnKNBAxjQeEXhfcwumgbzb4g=; b=AaYX6Av8yvYvaJ0j
	PjF9y9PlI6MKxkfvv3zTMKgG/+V8mJJpEBzjezQq02SAM7+g7rL95R3YSjAtcwXW
	Y9LyPpZnfKwqZS0YxQnRhJTLU9658HJtSZEFOJpIVDqv52c2ikA9lrOM+TtxhGA9
	vzzte+HVfSHMgC/wPuT1m+UjKuxLM0vE9EdURBbXE7/Vgo1RoXk7UT2ZVD2I4UdS
	c8nnOqv9bYFWA1FZIKgoGSM+O+KN603LBw8IMKW4743bphihfb1RC8iWIkjXtP5h
	mSiGu9h1p4Xncwq2YIWKlVr1clYG48HWEczuy1mYidpNmoPvs4yrAMVQHqBcNum9
	EEUDXw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xn1nfn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 02:54:39 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1379180a12.2
        for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 19:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783738479; x=1784343279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J2+OHtFXDardG1nxZZRPnKNBAxjQeEXhfcwumgbzb4g=;
        b=TGxcB5cv8addLJROzvfzgAp5IYoOvsmXj7vq9KvTyxWDPfEQRrVpDuXygWIQMtGVbR
         eZ1oKLgadAUjVsbq7jlqN33OvBGUwjP4uV/f0JBKHxE5L5wJexH8O43OpV9zktTR9L21
         JbibRlsTDzLaZoCHYXfm2cD2ILBdHWdDfh1mKV5XXOi/U9iKEMlqvifc/rNeRzh434nL
         8kS8D+8pJaCkwuYGdmfJSkDPmOa+N81WCLjhythXBVVI6WRmx047Xd6WADyqsd3MCWMs
         ty5dpNAcQORfIYhhF4soOlLjgnzIItnhBHQgV0vhLdpSgff34ctiiAAeK/A54fAI+iiD
         rsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783738479; x=1784343279;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J2+OHtFXDardG1nxZZRPnKNBAxjQeEXhfcwumgbzb4g=;
        b=kKH3/cRy/rq38Z5q91zLEBavuRZUyonfRCuouF9XsTqHinYmhazvLTg8Uj/vYz2ATJ
         AMGxjI2A5oj5HEpv1JbIH1CBWvz05q9WamC2rQyZDWGpJ0BpRGObdVGTLeKDdP6Jco2W
         AJEOLQyXMClRuWWZj5q4fSP5iTzdQ37HLaOnJghnXNzWUTMo7EchRoGseD/jGEn4cIjR
         IYW+EDU6cYd514Ia/Gguji5fzoMaEUecwiSUc1T114oH1ijx7nKkFAqaX6h4Vk8nRfQ6
         v22jfoc1MKsYXHa6LW2mht8TwZ/rJwLfI+qsALx8x72gWuepmCwirWqwh8r1hs7ob3O3
         qYlw==
X-Forwarded-Encrypted: i=1; AHgh+RpBm1NevhY2OEA+SluNn7Z02Ldwd2Q01vXNri2hCvYHwrM/Qt7PAqffCE2VjRe3S/EAkkCPsOCgJ68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqnMndi4bxnyMWEnN1MekLNfReriHT/fo86XKcxi8z+TYKwsa
	olL1G7TGP1VQwGMDoMLovNVTB0tDqiEAhY8dDBrgXA1n06BgpQE6pNr/Uq4xV4xHSgH598U4nPp
	/2hy5ovCgPYP5GdQ39rnC2BNppPplHAFuF+OaUsbwesxX94IW89d9lv0Z9tdg+SNAfV13ZzA=
X-Gm-Gg: AfdE7ckEND8MKnYD8kmJgk/z8Zojd7lyM45o1Nqcx80VUTaULBMXazlWM8ytAr3nyXV
	7UiUtZHFrbXzjvUMs9Ne+5/Y19uOcJBJlJbYjNdTczRzeZ/ywJZWgGInurjEBAq5OF2ggkmN/AQ
	FKrtZJ+2afMGidvGmYNBahbSOKsoJEmwilvA/gqskZLAwvdmqHpuLiUGRi/va7y2HKi8cCkw+bP
	gl2X5SEKyzXN3UVI99Pta7A/sgVQFHCf4l76cqS32z8Xg0yReLQG36gt9vf+HJ83JoEjOx4zqJM
	nQhxi67SUESAGYy2L9MkOH36JFCiVlOQRN+wC1fkQEVKwHHuxjLV3fcw4Dd11ur3n7eQ8Da1RZV
	JztEyO2qI51T9Q6K2NirFeIc1CEiaFpXvnA/YXdy2Ig==
X-Received: by 2002:a05:6a20:4304:b0:3a2:f75f:73ef with SMTP id adf61e73a8af0-3c110a65ba0mr1534081637.37.1783738478720;
        Fri, 10 Jul 2026 19:54:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:4304:b0:3a2:f75f:73ef with SMTP id adf61e73a8af0-3c110a65ba0mr1534062637.37.1783738478252;
        Fri, 10 Jul 2026 19:54:38 -0700 (PDT)
Received: from [192.168.0.4] ([49.204.105.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4b97661sm11787208eec.7.2026.07.10.19.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 19:54:37 -0700 (PDT)
Message-ID: <73df1c58-39a3-4f89-8674-43fb2dc36a06@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 08:24:33 +0530
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
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <cc4797fa-6911-45a3-8775-69c2ef32a338@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JJYLdcKb c=1 sm=1 tr=0 ts=6a51b06f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ua2K4HyBCek8nw/sr3ra2Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=o-iBtrM1MSidxli5CHcA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: fZPJ_rvAx3SM--hCvrqmN9rfVfIhW2NP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDAyNSBTYWx0ZWRfX+3CWeNqcnDOl
 eCy1kqay92GsVhdl1Lts8CqLvXf0wf1aSynZNowC565AstBaBnY4J7LTS6h4PuaqudcN3oeNT1R
 vFt9f+4vEAHDSbukEgZ7yJ0HAJm1Cdw=
X-Proofpoint-GUID: fZPJ_rvAx3SM--hCvrqmN9rfVfIhW2NP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDAyNSBTYWx0ZWRfX6G3so7aRSJ+y
 wDlNjVZaBX/MkkA9SRQsYtX8OXydVdm9C0pmSgU8a2qzHGiXHNU9nVfnjVDXShfhtP+2T5XgQOw
 uf5+CuefccRzKUcn6rG/bLwSUIsJN3aQjNfmS9dgEJEj7nKQnNxJCiMrHX2TXwbrZIO+MrelxkW
 lw6DUscQBnZQARFiENdVRjWHlWsKk2WEiDRa3R8Ff2NvUR8Hs4G7zJ/WCyjHYuM6pXzN0FH8DAy
 ttLWcy10m+k2ikBYx+8OQZuC+1UySL1vd0EmzhatkxlDv02LwenjDvgcNePqcgzDsDUcvKhNP7f
 K6gn1yubeZmDVUknqjzC/ZK0+H6p9osmoXBAEUbhjGeIdm8wgjwVrZwPCUvf4auoSMbAJqWM7br
 ELYp2+sgmgxd+cnlzEIzjqmvY0yKC8cf1ojnW27WRtFX+kmRQnXsAJw4jb76FRwbXZQf/Fi7Zl1
 5n/v2oXRBJZ7g2eFUQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_07,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110025

Hi Mark,

On 11-07-2026 02:56, Mark Brown wrote:
> On Sat, Jul 11, 2026 at 12:18:42AM +0530, Praveen Talari wrote:
>
>> The GENI SPI driver reports various transfer failures such as command
>> timeouts, DMA reset timeouts, DMA transaction errors, and unexpected
>> interrupt conditions. However, diagnosing the root cause of these
>> failures is difficult as the hardware state is not captured when the
>> error occurs.
>> +#include <trace/events/qcom_geni_se.h>
> Should this be in rivers/soc/qcom/qcom-geni-se.c (and the first patch?)
> - that way if another driver starts using them we won't multiply define
> the tracepoints.
Yes, you are correct but

If this header in drivers/soc/qcom/qcom-geni-se.c, how it will be access 
trace API in other drivers like i2c, spi and uart?
>
>> @@ -986,10 +997,13 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>>   					writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
>>   					dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
>>   						mas->tx_rem_bytes, mas->cur_bits_per_word);
>> +					trace_geni_se_regs(se);
> SE_GENI_TX_WATERMARK_REG is one of the registers in the tracepoint,
> perhaps trace before we write to clear it?
it will be captured in m_irq register so it is not required to capture.

Thanks,

Praveen talari
