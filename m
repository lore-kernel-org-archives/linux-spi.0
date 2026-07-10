Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12D379EEA
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706410; cv=none; b=eqBlI4W6zbnzUDH2Kl8+GYceq8dojlixlBYIjEqYvO7gvrH/R9jEy3tdScjNzI5Mtf12lLiqiB/X51uAWvwMxnM1BsWxLTKEmzhMM/RRnzR0uEB9wFMJfcGFi1by5W97C1pr9GEYnNUlXH2RK4GJx4JeDqPqyugpnCY/B1wK25E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706410; c=relaxed/simple;
	bh=xHKfaYtwUIkx3shdtSvDnmtCH//+t6oNn2Cl7jEfUR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq2FVL8x7i9ZA/wX8bg6m9F/IifqgSMJLdfK6WCfdKiSw+01xIDKnNFsDjdAzlu18jnp3AwY82TfzaoYya0OgAQ6ShTt9jIHoIQ3Adi76pU/81S2WOxokrVsXEVTeVfq2cpSsdQKB+Oukprr4finlWGBkYRup3n4r5H6qQps21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XRmIuuJ9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CUuhcVhh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XRmIuuJ9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CUuhcVhh"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH40qk1308112
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 18:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sp7gCHgdcpX+eKY+k/SBZCoX5ANHXz2bcvfFyVk4fWg=; b=XRmIuuJ9POsh21CD
	6GDcyNx0bP4OA7lDgs2mBClMNmdpbr72UQ1Qm6QGoHwn95dZhVq4WUMa+JMdUdsk
	iwQQmYkp3EmUsp3pLILqSL/D3EC0dA0gXEeiQEf/4kTXBf3OTwDJfjVU0JltWjfD
	LUZkC2wfl+laMGj4RQC2Gy7QJNI35llla5dYw8K/kz9wvBjXLW6NcbaXR5gU2ZYh
	xH0qG5Xtyu4hUrBvbvqunQpJ1taPts3gMN3ZIEGGuBXxHsoyEACVzgUDncalpd40
	8pELUy83FN4twPlFAVGAvjgnFKIiRmqQGh0tAjR7/MKImwv5lSpwJGAfCBetvqfy
	T2O07g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5dhve1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 18:00:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cae455cf6dso15680175ad.2
        for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783706408; x=1784311208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sp7gCHgdcpX+eKY+k/SBZCoX5ANHXz2bcvfFyVk4fWg=;
        b=CUuhcVhhD/14b6GyUrSWmhPhK7Ssz7v3P0CHxCGitxZfoO/Nm/yodpvCCxQuvEtSjR
         KtPw5IutAUkdKp+dUhUNGx2fjEN8ev2v2DzUhrNoM58kLVQ3NXsWqyGlGXXIJD6sF/j+
         5YyAD8RTzqnXGcnTm+58ySEsYBlc1TyIZm5y4zXYEiQHd/bHFFCxYObccjUuh/NLj5GM
         TdXJOfuNOGn+lbNPkojcaJyw0wtero3Zeq9Gfgup3vvA+gola5t5DLFlLq3onVV+qLZJ
         L6jZxEOsLocQ1eeUgToBPueL860jk8WQROY71jsBWOA5p4aoOrWYPe70CnFGJgjChz2S
         esng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706408; x=1784311208;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sp7gCHgdcpX+eKY+k/SBZCoX5ANHXz2bcvfFyVk4fWg=;
        b=c7kfCKa3u505wCfplylgA1i2ghfiA933QGt8j78VrAoMj4PJ8sXHs/Z7EZPbU/QgMH
         hbhPo0+fh+O1GA1a0pbOs0bcK2Snnx5m3yhCp1HgTlJxeThFmxzFyLkjehkV+BAUCk26
         tQv6xr53yv9zQa0JInKtnuSnrx+Fm/vs6ST3VL09/qiT6X101zAO4voLVj9ARRl6mB0i
         ZmsoK/SeFcRzudrOTTkqVM50YXyfvbi6JEWzg9L9el/C+BeqRMLE2rvRAWdvL2pcgnBd
         SPeUvi1IWcnSg26IY677OB+IhWWUIfotOcif8THPSY3wyB98r8QWeP8RQVkV3TZaTBXj
         c5Ew==
X-Forwarded-Encrypted: i=1; AHgh+RqtmLnSfCWFth/hyuWwi+gHurEjCPxxNuHVvNfKscm7HX10eH4LlcoCMq16YagBNv6IW5Wv9tAxG2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMGpcl0oONJAo+c8IAHC809ivK6UNxvCGzeIeY/3sr3HFU1Gwm
	mRnDg8XE9UCtYQYEfxFgTE3SI+7B2ZqvO6euIK7uNsC/x/v6jRGyWCKiQSjafMV/OWy2iSgnIH7
	OTt7OCABD/LdTheyYcAf4R2Y6zkeRueulq938/GW3yTJUh9CjCkREzrSUmnpQCY0=
X-Gm-Gg: AfdE7clz4SAJyOD+BY/3zauY1JE7YFGOqDZY/R5o/HOdtfhOkU5F4z2ANzzGOz64kYl
	Vt2M0EYl75plVwq0OL8B0Cx9EGVte4CxZNfjJV00g9r1QkUnMsVTkm9gZNqpsSkFmIX32wWoPmz
	mvlbIERW+bYNXmQR9DSgJfT1MnxYAJF3pkh9yOCBumdXJ9gqGTV1yFZhPA6WRNCdwK6P2WNuOLM
	1qXqAFRs6NHE2TBDAGe2KI3IXf4KpJ7Bl6Wu1Y39Fru/Ar42DOk/+nUBeNqmcaX4euuJReiEMso
	M2QTKHGEH0MYTh6vtHDMzXKSup6LXW3YcMKtXDIp77Umt8Il4L4eo8MsOIbqjfD0bbgzd8rUvzE
	IOE9tYV/UH8/iFSKdeHOX5N+Ajwe1TlnGvXaQejSzsw==
X-Received: by 2002:a17:90b:4fd2:b0:38d:a76:6470 with SMTP id 98e67ed59e1d1-38dc77c61d6mr13544a91.39.1783706407697;
        Fri, 10 Jul 2026 11:00:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4fd2:b0:38d:a76:6470 with SMTP id 98e67ed59e1d1-38dc77c61d6mr13517a91.39.1783706407129;
        Fri, 10 Jul 2026 11:00:07 -0700 (PDT)
Received: from [192.168.0.4] ([49.204.105.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm12368610eec.6.2026.07.10.11.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 11:00:06 -0700 (PDT)
Message-ID: <31205f19-1a8e-4f97-a7f7-b6236a52a5ea@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:29:59 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: qcom: geni-se: trace: Add trace event support
 for GENI SE registers dump
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
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
 <20260706-add-tracepoints-for-se-reg-dump-v1-1-48bd08e28cf2@oss.qualcomm.com>
 <a2491042-b7a4-429c-828f-905c07adbc5f@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <a2491042-b7a4-429c-828f-905c07adbc5f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4MCBTYWx0ZWRfX56yzHYyPEuCK
 AurUvvuy9JjcWQh0Y7lwRZDHVZTkuMrYtSKs6StFaq/T71f0Keg0p8o1IeAwEj5mQEQsaA6EkDs
 ZVkBB1pzYWoSbfdebJoIN5PZCKrYt68=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4MCBTYWx0ZWRfX3AxLv/yL0JB7
 u795LSbMZ5+9Dz16fIumGmO3DKnTi8EVtGmGFLyAjcuLgjBpDH7Lg0VXNw9pgDo6a4rz7Rj0Csz
 vAYCrC0mLAnBfwcv7/mZz9LhjKdOhM95fSamz5qzFix+OhYXyyJC1Ua1EoD5F80FnzeZxZ//6kw
 +rj9lHBE0hqhD5GbvlkxS/hb4IM2LC2UiRT5w0BAaVU5WT4hNwZerrXwN3/ZyXXSCUwXuwtrspp
 77X2ksHx0120bH4mQwdqRZ88yAlKpGrkn6/kp1DxcGTePaD47I3rOG+cL4ujElXlzqZ69k/D7z5
 9Z+d3QHzar+Sq7ABCFBxbOLp1ySbIYtMMCsx18h/BRDlCYYLYZmXNubnNL6sbLd+VySDMf7MS3A
 0KuR6yPOTIc4xgkcohjgzOyBpVv+J/Yzc3JLtpvUO5R3NMbT2mENzwLLq/kO6Q30GCjyeDdXQS+
 aCPnfqIESVoY+oqx/NA==
X-Proofpoint-GUID: lvMxJxvylDfMvbvYCFO-yG9zA9Z4mLvM
X-Proofpoint-ORIG-GUID: lvMxJxvylDfMvbvYCFO-yG9zA9Z4mLvM
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a513328 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ua2K4HyBCek8nw/sr3ra2Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=j152-PXcblSeZ8F-r_EA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100180

Hi Mark,

On 10-07-2026 23:07, Mark Brown wrote:
> On Mon, Jul 06, 2026 at 04:38:12PM +0530, Praveen Talari wrote:
>> Add a new trace event header for the Qualcomm GENI Serial Engine (SE)
>> framework providing a geni_se_regs tracepoint. This tracepoint
>> captures a comprehensive snapshot of the GENI SE hardware state in a
>> single trace record, making it possible to correlate register values at
>> a precise point in time without multiple sequential reads.
>>   /* Common SE registers */
>> +#define SE_DMA_IF_EN			0x4
> drivers/soc/qcom/qcom-geni-se.c defines this as 0x2004, that'll break
> allmodconfig builds.

Great. i will review and update in next patch.

Thanks,

Praveen Talari

