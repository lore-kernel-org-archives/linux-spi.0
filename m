Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3738758E
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769686976; cv=none; b=fnWVhsunvcyUrxs1weasIamD4mUDCEDfjLgDNJqR8B2qYSyaj2txnalgAUCJnaY8tAcaWkfwL50T8saV6Sy2pAmNnx8whrZqPep8LRjcQl9ElQep61k/lAS2hr5MmX9v1X5s4hbIlPdMoj/j/rvfgKw0yYNb4HSafk85s1Dder0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769686976; c=relaxed/simple;
	bh=uhMJwo9qnCZ7V/o5pEE/2ShvJ7VM40bR1IRAG+SSFS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8doXbFk5e6fThVLPaG389666WBzwdhcKj2m5Ir0WKxM/JmUi5C5Hj9o8/6pu3KHPCb7zlvuruSXboKDZH8axQsa6mBj7D0CnsqEhsOzWhzBwmzfu8CbMfc0yBbprZ029Y6A8OgqhVhKBxjJb5bzoRd9bmfAmOWHz5HPyhZCi4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R4Xn5jK9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cu59CCnQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R4Xn5jK9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cu59CCnQ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TA2trn2033226
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 11:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	urC/IggVeMYwCukWXNwxhNuF+QGmXdBzmKXgl/kHCS4=; b=R4Xn5jK9WvxwIp2m
	B3097Tv3tBnt7gZzEe7A0ULY0vK98G3IWtezWayvjz7i3tmUDtyNIgn+YivQOUY7
	+YMevMy2969Za+aOD4mvF9RCO27L/lcZELaJaShtWLW8DZfK2BRIW8o027CYDvMU
	BrWCDqlexHBagID8omcWpUDqBit518mw2JLUiRZ1SQUmmKLFeGCXthVKPVl6/OEQ
	qC9AT6UxNdSHe/Hbcx5MtXWKD0iJflD+Y7fG4SfrbnfebwiWpzUETlo4U4JTRKiV
	HlQkc70Hjb7wH51XdUP10Li5BJgJkyjo2eqQt/jb+imhq6CQ2eCcsrKcmLQyI405
	Mqltaw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bytqy2a3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 11:42:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c709a3a56dso31883385a.2
        for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 03:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769686973; x=1770291773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=urC/IggVeMYwCukWXNwxhNuF+QGmXdBzmKXgl/kHCS4=;
        b=cu59CCnQj0i8LaYZNN4XPU8aibVLzSPxElHjHiILSDmWVJW864OVoY4bmNLfkkv0o+
         vRaVkGXPqlMd2bubgcWKT/YJ1ek6nAsh67rcHLNxPREDHEa0e4NxOyngR7m/o9iC7PaU
         H5wyTgq0jR9w6CdmxiNMgPgnzgEVWVWgV2MitgX80Pg5reI2wUvJ80gZ/RuupZJtqMJd
         6G8tzY+Fdq3ERHMrScmfEMf7+fi7ZlU+cDuC+C5wYZ1DQAZe4PZwS1OT+lCT4BwKkiCJ
         dpwR1XjQ3F/dNg2lhinvyNQV/uF+lq8TS+Qkm+VLaf4rxHEAPSSYSSVhIyzRTNd6BHeY
         zgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769686973; x=1770291773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urC/IggVeMYwCukWXNwxhNuF+QGmXdBzmKXgl/kHCS4=;
        b=ZZkNKihEJiKzkbGAWh+JAdTFsxmXORjUOAIHE3mP9Etmn53nBaKSGeU34LxGMBbL0H
         DihMhCR0w8GE6knyUjpOVCN2lgVj1mN5d7uhi51esxz9MWVAmluKfMLFobyMCMUBtIxl
         OCeNYY1BkTJMuDRpw6YAQujEpLWZLY3rn1po+x9IzQP/UzDifnc4R7YDb6UaAflFpOMO
         Ygd0Gak+pmed7wzbEPivdaNHddIyrGbxXORGiIL9kDXhLKj//affLbS0fkNln/EwVSdy
         W7HRrzi2qLBLneszQvN/omO/S3TT0ubkFLY2sMnqYJcK8Td+AMnjY3jyFifSu/LABCcU
         3cOA==
X-Forwarded-Encrypted: i=1; AJvYcCWYu42cs3blkAt4sAGVZfm+cLqzaF/pGkHedAaweKpCAlK8vP2PeK6SNAHLIowFPwoNwIHDtWATQbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqDpXWzgyYeMEbJHGTANXQqTrGlS+JNmZXmz1n7tiKcvR7BqcR
	cjAGZhIcARIaLdppyko8kRC2dmGoGeHrqI7ghjUo19BKp11+Gs0LguJ91FW5LQKN5u/xTEpeIEL
	4U1zWukqdg52lhu/fJW5x/bD7t/hfQIoIPKSnJnxtxqx1BLc4X19GCQ7+JLQSY4A=
X-Gm-Gg: AZuq6aL2RBur+aF5JLz94UXg660F95oijK2ebeAbX3S3TPGVcZnCEDOQa2EOBnh4CXz
	QtH7gsfd6cHgIirH3DXufFvyf0AuXl1BQCeAz6O0PI3gFc063fA6iq0OR7A3ygEZr4FBmy/Sai2
	N/yziixa9i7wTJFysTXur1WO8izm7NBBxj2KqS7KJehJpdQk+W36zfBpIH1BNLX/yArXJFU88xh
	OBQ7d+cl8nekL5exrHD15XYO8uj7dpoyGAfKu07MWNYh0SpTvUhwT3fXLtqX7jbcBFJvrZxQ5hc
	iKyAMtYX24xAwevYpaAaC/cv8fju6lB1xRvc3YVFbUe36zbX7l3upUZnZYsjgZ0ZkXo+EMjDkbx
	+BB0Or4iV4NyJXhqfT4pqZe6cFpjjKQ4XTr8Vnpp3EaM0sUo/K5isMlFbnTPn1Uv2knU=
X-Received: by 2002:a05:620a:909:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8c71b40d0demr249894085a.9.1769686973414;
        Thu, 29 Jan 2026 03:42:53 -0800 (PST)
X-Received: by 2002:a05:620a:909:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8c71b40d0demr249891585a.9.1769686972920;
        Thu, 29 Jan 2026 03:42:52 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ddcf8aa71sm112265966b.14.2026.01.29.03.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 03:42:52 -0800 (PST)
Message-ID: <7c0883eb-3147-4b83-908b-b5c0ff909481@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 12:42:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] spi: geni-qcom: Add target abort support
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
 <20260122151008.2149252-4-praveen.talari@oss.qualcomm.com>
 <64961e27-e316-47d1-8ab4-c4868754adb6@oss.qualcomm.com>
 <700e3ce3-776f-4ee7-86e2-40608deffc0d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <700e3ce3-776f-4ee7-86e2-40608deffc0d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA3OCBTYWx0ZWRfX9uJgseSYn0Ow
 z3yzOJWvGGP8rKQ77OQXslFySYn+cSvWdo+BzKOQ2Yh+T9aZi1MG4EkLtE48ORzM+i6bNC1hfhw
 djWuBAll/nwRD1c8vNFn7uw2cI0XIu6msNXUzF6Bqj3+0IBkfkhgTCVUONWDDdGn2eP1eXcFj4M
 LUzSs55s0Gq85HyGK7MqFQkXbLDmj7HhKCy8NR9aPXOrjibnRLjpZk/H55hKnDHN92ohXRQqMWn
 HoWIN7MZPyNdHfRf4lG5bO45D/wXYEBwqMMurpDiGVCYqOLjutPL4mMoNSa24g9Vw1vCAX7/RZj
 vSN9uxC877YeAD4uL0wn+pNJ22JhnWoWn/GcAwKCjqh9LRtcAz4L/tNvA2tjqYsuy2a63omwjMO
 4EriJJcPf2EaM/NxGdQXYxTsouuYoOWc+UA1ff/aWr9gDGj2/0eqFWMcTOVPgDT2G+F5ISNhGbo
 T/SlmNIo0OR+IVpdXOg==
X-Authority-Analysis: v=2.4 cv=Je2xbEKV c=1 sm=1 tr=0 ts=697b47bd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rYfZC6WfGBFJvMEZbqsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: xiGXwwfzuf--56Do4-9a4jzpm6SPZmWd
X-Proofpoint-GUID: xiGXwwfzuf--56Do4-9a4jzpm6SPZmWd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290078

On 1/28/26 5:28 PM, Praveen Talari wrote:
> Hi Konrad
> 
> On 1/27/2026 6:51 PM, Konrad Dybcio wrote:
>> On 1/22/26 4:10 PM, Praveen Talari wrote:
>>> SPI target mode currently lacks a mechanism to gracefully abort ongoing
>>> transfers when the client or core needs to cancel active transactions.
>>>
>>> Implement spi_geni_target_abort() to handle aborting SPI target
>>> operations when the client and core want to cancel ongoing transfers.
>>> This provides a mechanism for graceful termination of active SPI
>>> transactions in target mode.
>>>
>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>> ---
>>>   drivers/spi/spi-geni-qcom.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>> index e5320e2fb834..231fd31de048 100644
>>> --- a/drivers/spi/spi-geni-qcom.c
>>> +++ b/drivers/spi/spi-geni-qcom.c
>>> @@ -1009,6 +1009,17 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>>>       return IRQ_HANDLED;
>>>   }
>>>   +static int spi_geni_target_abort(struct spi_controller *spi)
>>> +{
>>> +    if (!spi->cur_msg)
>>> +        return 0;
>>> +
>>> +    handle_se_timeout(spi, spi->cur_msg);
>>
>> I can't help but notice this function never even dereferences this
>> argument
> 
> Yes, you’re correct. Since the argument is never dereferenced, it is safe to pass either cur_msg or NULL here.

Would you like to send a patch removing the unused argument?

Konrad
