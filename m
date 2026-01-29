Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8365B7E105
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701831; cv=none; b=gGnnJ/FSmPuDMEFK2UGNsvmeqwsG0SoHTpNVQPWKGoHyLK7jyb2Vx/tnPaEgprY8xDubuG/QJg0Oy+mf973Xq85qgyA2Ke+KLqu+Y7xXY5jQ2wtxlaMd7ojpQzSsviHOVIjntbeAgKiiZlW0QmEom8fFROye5FfJp0nkQa2Zv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701831; c=relaxed/simple;
	bh=KhRISFZhCh2PBhuIa1I3iRGv9gWtlFhrslYGUwut7JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlS4zzvZqbAHxk6kR+SGuglfs7T4jDXFNHmx7JxrULUAaOYmJEe2ZX54RQLwfZ6UQ/TjOBSy5OD+crr7Lfwjx6CXX0kxuxzejarYZGUEOPvS9sBRXf6Y4dtsy7m9k537nMe5lIntDr84ralmvWv3o+3qBSJkv0zC8Udnmi5upB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=odwVmYOB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MW9lx+xe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="odwVmYOB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MW9lx+xe"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T9qweP3712037
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 15:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vJw2Xxnpngqa4TD4UMnudb4MC0uCGRAj5VSnlg70YdA=; b=odwVmYOBKWCBkt1A
	6TgAPJKndejKUV8a9eRQR4k6ZKUSC7t0sYEpX+qABFqPCDpo6wG+LxDEJxKphp+7
	/CkThqP0rYZVIgsFqo1jtlNH85OKwMsOUfekT3800PoN1J5NadWJtEDxH7No1IV/
	icBWKxBoapKzPp9vITAMbjXPfMwzYRQDdhlmSskZJKInqcNcMlQsrBdQH3281EHh
	JCqzniwzFXY6ec7aMcOeM+NQQGzHqfycA7Be+fk/djIbCTkoGPx90X6jrs/qLbr2
	JjqwDaoojaNpEFWMpGkKVoVRrxwGCp+FIY7A7Us9WvBjeYFLGwsjiD5ih4LQy2E8
	wvkgFQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byxcuafm6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 15:50:29 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81ea3358dd3so986130b3a.3
        for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 07:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769701829; x=1770306629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJw2Xxnpngqa4TD4UMnudb4MC0uCGRAj5VSnlg70YdA=;
        b=MW9lx+xeb+f4jf0NMbY4Qej5AY5i9G2FKTSQzSNn0Wd+Luw+DNYr4n8l0WhVkrFXci
         KfLGa6+6R9U9pB40E4fBKCSK8YkqQBUHr+pAssq+nC6saO+5iNadsVzl21Y8p4e0EDr0
         1QkowMCWp5LSh+48kluAvCrp2mTHfA8DvEzCkUUt/j1AuknycXDji+wmCAyF+LSlqQbf
         wTdZRd9D31PCk0mU7XE+FaI3RKmkToV901FtvOODTP1HrXu7MsrGNcDcqgvltkckFiDK
         OE7IXKtsHM2cYzst26Zzt9JHg/bwXw+M/U/Qe93pRLIeuelcGxOUUrs5b0KVS1UtsBOT
         4wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769701829; x=1770306629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJw2Xxnpngqa4TD4UMnudb4MC0uCGRAj5VSnlg70YdA=;
        b=ZOGKGbADptd/KoUAME1QkUWFRrpIpgzPffPKzznwxB5Rp5+LjUODfHmmNnZo42G2yN
         KMhZmv553mNuWXMt9UX/XJZ1NzVerSmcbVp7gs38ahI39S32wKmUaNP933GHRhrSGq1e
         V5OXFNqC5MQ6Qra6MV85BDMOSCcyawepQY8YhhOXccOeDYGfsmq7a5V8c/kShyKPHhGM
         ycj6NrqpyAEHIXkPWknqTXMgZgaB0fRDfDlRl45ios6esW/XBtR/nVdW0j7/uL6e/B0E
         lPLOm6BETCJ7zyvl4ou6tttyVqPLjR4OkxBOnzjPZV4ZL36lS/wVhAuhKQbtBj0mFbva
         YCGg==
X-Forwarded-Encrypted: i=1; AJvYcCXdEuP9FhzbDqcqMSBf9L/EUOVehLbgUx+VxriiIHuF0U3T3xMSSeEqZO6JQATE1bCUKJNIeCCdpvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQCFbG0fESOGdx+D8Ey82rt/DlnPRAEXJ/olBxbpnCoRKoTfG
	f8DCbAw7D5+g6yATeN3ANRO9y9oYz1wGrQfrDGuvqSWCaW94Jqd9I2LZ5gHjHrmLE4cRIrP/NN0
	Pu/9d9Lt0lsWm9UdGY4Z1/sysCUw5rxnkcWVJMnfxIRJZAvpCFozCnOglsHLjydo=
X-Gm-Gg: AZuq6aKSUAeynAnlz0/IQIXpiMNABJruRF30emrsdcreN6K6X1+5bc4B2eVJ1CvUvVl
	deouVYubRE9ObJatBje+j7oB8CzHcTHZJSB0awqWZ+RxNmqhwWn7AkacnEFlqhUL9oRxyoeyA2p
	qLt6hvDVX+ro2k02ECu/gb5m4DM9SzhYChxJyiD45ygX0DBiiASqZ9jswaej+IuWGt6YynoGc+o
	n4lYLwRXGFC+JYRp66U79fm5PhVi8rrPc0ZrnLwgMc4QU5/rfZj6Et4DYW6je8dbXytKuynwsd3
	wh2gxJxljQP/okjRO13r+xa7ASjh1CztWoyc5FKIqR4rIXpAUOnGARCARDZTXgFSWazhjG+GM9/
	rY74MP7ib3zcXVpqbtZrZS3qqLWww7ytkTIraa7Dn+Q==
X-Received: by 2002:a05:6a00:9295:b0:81d:70d9:2e96 with SMTP id d2e1a72fcca58-823692c4b64mr9972772b3a.54.1769701829037;
        Thu, 29 Jan 2026 07:50:29 -0800 (PST)
X-Received: by 2002:a05:6a00:9295:b0:81d:70d9:2e96 with SMTP id d2e1a72fcca58-823692c4b64mr9972742b3a.54.1769701828472;
        Thu, 29 Jan 2026 07:50:28 -0800 (PST)
Received: from [192.168.1.2] ([49.204.110.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfd71csm5733189b3a.35.2026.01.29.07.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 07:50:27 -0800 (PST)
Message-ID: <49ad7aa9-ac4f-45b3-9b77-8902b414f0d5@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 21:20:22 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] spi: geni-qcom: Add target abort support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <7c0883eb-3147-4b83-908b-b5c0ff909481@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <7c0883eb-3147-4b83-908b-b5c0ff909481@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwOSBTYWx0ZWRfXwPjJ+tue64ld
 vH88G1eJda1sC93APOl4bs7/nHbp6azbvR/2xq75JP0vog6f0zLWisq2yrEpD05Pe2VDLIDKIuX
 mvVZs4CmC1ClYhKpLl4LKSVYnfwqFrTIDl2p078H60axq1J0e/LQpdNu61VtJkvoZ2QNlmQOV3H
 V6rX50Q4d3xPIejKlnBIeSJOw4qUqYNai/TXuh7/qMx7qHw8F0e4ZO95u/VwivEiUzgh+BA7zFc
 A0XnNkYRciXuF1e5fOOpMCvadvsEMhvdwIHlAHMfm8PtkifRoYzld/unxj5lOPZUw8/OyEtzrnH
 XvpyYYMTY+Ks6qxaT512b3C1DCnstQq2n5krilrv1kdnj7bYbCYyIalTiPzEDCPJY98NprfYgLe
 L6PiBnSNWi369kJxgnJ2PJO5cI/e0G5LDOocTpkXXi5h8jTTodNE40bzuKV1Tz6gFUPpjbbSefi
 bvMzFot3oTGhoz4IbGA==
X-Authority-Analysis: v=2.4 cv=QpRTHFyd c=1 sm=1 tr=0 ts=697b81c5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=hmzEZbfuJy6/QR5cQt8XuQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fMn5tOcbCyIVrqCJyPMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: sNJ5ivkA0FfHrNSBtjru4R8A17yPgtHm
X-Proofpoint-ORIG-GUID: sNJ5ivkA0FfHrNSBtjru4R8A17yPgtHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290109

Hi Konrad,

On 1/29/2026 5:12 PM, Konrad Dybcio wrote:
> On 1/28/26 5:28 PM, Praveen Talari wrote:
>> Hi Konrad
>>
>> On 1/27/2026 6:51 PM, Konrad Dybcio wrote:
>>> On 1/22/26 4:10 PM, Praveen Talari wrote:
>>>> SPI target mode currently lacks a mechanism to gracefully abort ongoing
>>>> transfers when the client or core needs to cancel active transactions.
>>>>
>>>> Implement spi_geni_target_abort() to handle aborting SPI target
>>>> operations when the client and core want to cancel ongoing transfers.
>>>> This provides a mechanism for graceful termination of active SPI
>>>> transactions in target mode.
>>>>
>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>> ---
>>>>    drivers/spi/spi-geni-qcom.c | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>>> index e5320e2fb834..231fd31de048 100644
>>>> --- a/drivers/spi/spi-geni-qcom.c
>>>> +++ b/drivers/spi/spi-geni-qcom.c
>>>> @@ -1009,6 +1009,17 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>>>>        return IRQ_HANDLED;
>>>>    }
>>>>    +static int spi_geni_target_abort(struct spi_controller *spi)
>>>> +{
>>>> +    if (!spi->cur_msg)
>>>> +        return 0;
>>>> +
>>>> +    handle_se_timeout(spi, spi->cur_msg);
>>>
>>> I can't help but notice this function never even dereferences this
>>> argument
>>
>> Yes, you’re correct. Since the argument is never dereferenced, it is safe to pass either cur_msg or NULL here.
> 
> Would you like to send a patch removing the unused argument?

Sure, will update new patch in next version.

Thanks,
Praveen Talari

> 
> Konrad

