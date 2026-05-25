Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE530C618
	for <linux-spi@vger.kernel.org>; Mon, 25 May 2026 05:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779686237; cv=none; b=SYwz63he0Wv8bbQnl06gXNZ+0c4kn8+Rzi2DyZasZzxZkerWA8HkyHF4VrgNpdqusOqh4x2r7wbJXEdwiJqW6YeUh4L6I+s934KLiyuleGkzjucKvPnAOOmVctxh3PaatZblU6lB32Dah7t2xSR05ifKo/22LIZXFLwj+nQD+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779686237; c=relaxed/simple;
	bh=TT6fb9wRcDaVAgi9x7/XP+aN+zqiMMogNcrum5LKYb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkhT6YKnmovYq4BeFV/2w1GLvWq885D4GUNjUMx/6xjyLg+LFbZUM+6wX+vZjnL/4RMEmkIROeQqOdAfvwRv2dm7X8ENuaNdb7tHufsKcCuJ5t3BCuFOAsw8pyAbZQD8E5n3Z06aZ6JGpxwBF2Wl45qhB4jif9DNOozRYmwKuJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hsB0i+7n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dKhdZiZJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hsB0i+7n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dKhdZiZJ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OLIsO21772926
	for <linux-spi@vger.kernel.org>; Mon, 25 May 2026 05:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GTcW/jqS+R1fyGppCmwLUjOiRqL28+oajKP5jUq4DXs=; b=hsB0i+7ncjNC8A9z
	LEh2SHbdGGWAJAdPz3eLH0iKrQVFvqfnwU4EG0phGfFvZQnjLV1CeylJ1k1L0wyk
	HlR2ZWonSkI9ROc5fweo/RcX7qNMG5lKZY5hszBcstTklbFQMWE5dQCS4uQ2Up+k
	lZkKt98Qy20iUQyLVFL6gzFYdmSWy4ornVUd91Bz/hWyDpFYUBfnO3eYyTUO/6Ys
	6cvw7rKTPK2t66D+6QdL5CoxTkKC/blrvLY1p0JY6ru4HRgVL5Ur4bbpYZ2stmhB
	Yc8DGG3Z2MHqMIqC8RBxVSCZ+H36F8KBR14eEShzOGhcfnsz733FOiefuryd9b09
	kf7pBA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3jgw4ah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 25 May 2026 05:17:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-368b15eeb3bso17971989a91.2
        for <linux-spi@vger.kernel.org>; Sun, 24 May 2026 22:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779686234; x=1780291034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTcW/jqS+R1fyGppCmwLUjOiRqL28+oajKP5jUq4DXs=;
        b=dKhdZiZJB7v6y1Mv+jXSa0RCILUx6iNylOWB1JBC50c55WSBt1kHI/sxBPA4n7+h+V
         az0n1xQX33g7f3PoA1mUq3RJuGTgJDX3mqdEsk6D3K+fbRPBx69/cLfbAT52d7oMxtW4
         5iIp4GpX03IQvRxH0oxBZsHyVw1NJZCLHXFXq4aMGXEbq0U/ulQcMEy0qZESi+mdHjQD
         +1ny9sW5d9VUS2q4PsPieztUCD9wdNbDhwVO5CrY0dTP9KJk0irnu+ybdF7efIDWneUx
         WFk+Pi5Q7EzYV8c9CHD0XOZcWQ5zpMDcjqSXsKUq3V956niCwcmvlWlqo12BqN80N9WB
         XTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779686234; x=1780291034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTcW/jqS+R1fyGppCmwLUjOiRqL28+oajKP5jUq4DXs=;
        b=s+Ne1stxpKHI15czVT2PCWKn7GHnBOS+QAAKyePaLSPjsp3JJrA9yZVKugyzMwjAOE
         xMA0AeQ1C4h9csaUvnTpyzEXp4gvUSrUtWYLtOFOvFyydXP2Slhehw8KJOXprbcTrBdZ
         uY0bO2z4h8uurscVlss+f2e9sGFExBlMJYbVj/k7WAxAfd6+S2vVKkLH9EJRJ6saXch0
         X3QGpImNon6uoVDM2khPleXffJtJcUHcFk/4TqpTJ3//5JSnTHpkysR71Z3ndUNP5tOa
         t4qs8btuY21F65FYMWDUmXgyjqw7GRgxzXcTzaxJZlz+1xIKbZyOJqQrn2c6qo50zTbD
         53rA==
X-Forwarded-Encrypted: i=1; AFNElJ8HUmMN8L21+0aoHiwUnuGgGkUipXd1cLjybQaLK41RgWo+UA24FWNwi64mn+PYzkOQNmvYnDjHvNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxyRKv4xjBWTg0ktoKZwOVO9C5WMQC9kZistCmYtmMV8kQjY8u
	SlS0j1lSoIv5YLpxBfE9iutjvVKrSNcP7+PkI6w0Hq5qY6Woa6Ab9cwOM0D346Lx2VF+8hPO1N7
	7OxQoqIZtWFCnC0Ba06E2isTsho/NQfMgk8wRCT4dtnzlPyiotvrxCR3NPKkJn/Q=
X-Gm-Gg: Acq92OFmrgFHBO8m2RnLjZt8rv7NptZp4vZblVl5CkvTf7WvnP8wKxUB3batJJcqP3r
	RdBJC6tdE1hCGx4gcSfvKzgLfuUj2x7TdvWwkMCYP8qayJ0Xv7j7Ybqdzds7gmggC5ueHQ6pdBm
	WBkl5kUuDexZKMqkxUI/WIz15b4cJdU6yMib5AXduyIQ76IcS8Knxc4mpNfRfi1wyEfLz5ooiiT
	Qb4fA4CMenZDLISPBi/oXVzZ/PmXjCkorjyRebyvT04OXLYQ0PxEyXwFKbMFmmpTaFZ0DFhqkAk
	8uglJMbZQT5ajL89f2A4lfDCZ4ecFUEjoY4UPHIMwZ5/K7dxabNQsN6N15q5JbNBupPWZHcwtPG
	bGFog5hv9e6QAhDHVFZEg1ZSi1xWp6pAPJHwmTzVtUEOAz156rH6iqg==
X-Received: by 2002:a17:90b:1d8c:b0:366:33a6:9921 with SMTP id 98e67ed59e1d1-36a67422decmr12178437a91.4.1779686233695;
        Sun, 24 May 2026 22:17:13 -0700 (PDT)
X-Received: by 2002:a17:90b:1d8c:b0:366:33a6:9921 with SMTP id 98e67ed59e1d1-36a67422decmr12178413a91.4.1779686233253;
        Sun, 24 May 2026 22:17:13 -0700 (PDT)
Received: from [10.92.183.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852057f9cdsm6963798a12.32.2026.05.24.22.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 22:17:12 -0700 (PDT)
Message-ID: <22a52e0b-849e-485b-ac6c-ae55c2b75be7@oss.qualcomm.com>
Date: Mon, 25 May 2026 10:47:07 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Add trace events for Qualcomm GENI
 SPI driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com
References: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
 <20260518-add-tracepoints-for-qcom-geni-spi-v3-2-7928f6810a79@oss.qualcomm.com>
 <12d8da90-f092-449f-af6b-14b9dd851f1e@oss.qualcomm.com>
 <5c59952f-72c5-4aee-a1a6-4b11b0a542c3@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <5c59952f-72c5-4aee-a1a6-4b11b0a542c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Y8Gu0f5RMA1eLS21DtHOuAeBJEjgO-GF
X-Proofpoint-ORIG-GUID: Y8Gu0f5RMA1eLS21DtHOuAeBJEjgO-GF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA1MCBTYWx0ZWRfX1X2RqX3SWHXN
 qiYUK1eG8BWnPBH/NVFN6a76OcUK41LMeG6a/yVLSzXYxdjl2emYyy5gFrvHemtHEZiOJQTReGr
 SrZWQm01BfFe2QUvNMyJuSMtqpmKTUZnsZ45mTDoY+qEFg5tKLbcmADUngzYfEoeaj/prZJ1sIW
 CcKjql7pE1YuxyLBf5VwnCKGOgBJK8240KrLCoo20qFcbOs+bmTxwLY5XFqmbMd3qcr8zUl3eGj
 ++JfcJE7EEJ1Xcp2uapIqdSGO/TxCRcO91dILagH6k6LEPJJeok+oXXW3lMvZF/LnTHQOsEiXe7
 M6UA6en3VgIpZsx/z1sDU/Y7g9rlDFZVqanb4NnFfaM32IMqqJZKx/9Z0t2YiRH14jOWObe12qC
 7AT42bvWbz05RLMKBSai1rA0bBC/ycloDdxYmMRaUbdVJn+mMZYdjGV+95buCv8IpacQiFS17aN
 ALY4GMaYNOHzG2Xmbiw==
X-Authority-Analysis: v=2.4 cv=Do9mPm/+ c=1 sm=1 tr=0 ts=6a13db5a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=v0BZMRiMjL-9nwr9ESwA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250050



On 5/19/2026 5:04 PM, Konrad Dybcio wrote:
> On 5/19/26 12:59 PM, Mukesh Savaliya wrote:
>> Hi Praveen, one question below.
>>
>> On 5/18/2026 10:30 PM, Praveen Talari wrote:
>>> Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
>>> These trace events enable runtime debugging and performance analysis
>>> of SPI operations.
>>>
>>> The trace events capture SPI clock configuration, setup parameters,
>>> transfer details, interrupt status.
>> Don't you need trace logs around PM operations ? ie. runtime and system PM ?
> 
> The PM core provides a couple, are those enough?
> 
Understood, should be enough. Thanks !
> Konrad

