Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242744;
	b=XPUne/Lrf5izoFjX/14nV2R9g3LhpzB+HKkyoxNkVZ1S1uuAxH0YvhYdCXZ3VDTypzsm
	 U3CX9CziUqd85nX9fJHtxY7+ecYwK/kjImabSRoE/quySG8mJn6B7kNgFu3zAsnDD3fim
	 +W6r9sX59xwKh6qo9D483p6yLDaO1/iQJTraQsf8WIQdYUB7dG6sAcB77I7dTfBRe8Frf
	 YSAAayjHEd0SGq4qTI4l9q0GDLl9LGhibPmN83p1OQmkRH0X7dVn9lrNi4p6RPe1WOf9X
	 azxvTkucGphGTMvEsEawS/4f03xmmRDdwOpK0jJzW0/s3S8qyvaNc5pcI/If9+41fKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242744;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VBx+pQ4H2H3adUQa50cH2AZAKCnEvci20+6PQw1MHT4=;
	b=tNRb+eFe83rqdWSTuXJsC1EjQxWOMoCNO77nxGfFjXVznviEqsS2aKMJio/n1IT1V9iN
	 Wtkn24YqYqCGJsaYV95E6d+Jgk0YGV3blPiubuWaX5Off739HlOEX9NAgT/VLVkShAXAF
	 Vv8xGdjQp8vzcSGluXxw5u0wa+EwzihF5kWQs8Lek+jn2CMX/EM7QV2WGvQAYnKzGlM6N
	 6BsQy3MReI7oTKM4IRl2JGhMnKdlV3M6t7XIwhp4tZhrzHriZOtrxWZaWgCrHHfJr+Sjr
	 Tadv3Qy2iJnZyCzkd32yzMQut980sIlz0wE8xpD9brAVHoM6SlkvdQZcYWbSpojGBcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z9znmG26;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kHrtfwZF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D301606A33A
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 16:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D301606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z9znmG26;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kHrtfwZF
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFGBB359372
	for <linux-spi@vger.kernel.org>; Mon, 9 Nov 2026 16:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VBx+pQ4H2H3adUQa50cH2AZAKCnEvci20+6PQw1MHT4=; b=Z9znmG26EPaUKSEV
	VRmBdJyuq/dFZiiTn1J2Anbbvsi4om2vKXrB51eY2pi22iW3s7MXTtByigsccPqU
	rOTBswiRDzhk1/Pdgh/sPuXwW0bsjZ89D0S0Cueyfs2L2fxwl7NnhCrSulkvepbM
	O2KFLbserTnhvUk7KLKVorj2eQNbC0yS5EpJA8vDz2246cgugo9CWPKNh52oKoha
	QDc0a0ue27Y9ssBfOe8zk7IruUnT3Ku2hSp6rAcOtsCuy7by17IGXgre47d9HMB7
	Qu97Mp2Hz2vxE/OjDX07IPjKVnTA6BJ1JfSXxKZg1wWHYmEnNiqP0y+LOU4awjtX
	MLjTXA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2jky0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 16:45:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2381064eec.1
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794242742; x=1794847542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VBx+pQ4H2H3adUQa50cH2AZAKCnEvci20+6PQw1MHT4=;
        b=kHrtfwZFqd47WfddUOdWZKA/pr9I3C0Mjh5EpKkgM5wYv+wYIdMAD8eboLskQ2D+OE
         R10tXlf+XCJ3U4KLHiCEIl4WJ0z9k/1rpPcU5sIpQveESP2qbB4AqO3Bew05Yqi6JE8c
         q+Ka8CBpY4U0AFE0+3tw7XK6m9mC5ystpbynrbOYm30NaWyfYNXmQf0OLHUqcDMHU3wl
         9TKdyZ/pQHrVlhpNdTZZmomKW/TTeDZDgq0bCYcHkffvrPve4iNrtpoqV+o/24XlUK/I
         LauKMk9O9JYrYRDetrmmhLEFrSgx7W7PGL438LEvR2bMVoRfOnr/erTr1pVWtZ/LDO2N
         mpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242742; x=1794847542;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VBx+pQ4H2H3adUQa50cH2AZAKCnEvci20+6PQw1MHT4=;
        b=lWTFkyJa1fZZgJl8v6kVJ6VUTOM80lNNOvb1xmYnJOIRwl1FmszHwm71DQxe2ZokkN
         OTR+UFkjXcNDq0LKHorhNaQa4Es6BeuEQFrP7krqsIBWzxubF9kAXfzxl2DHfKmAx61/
         RgYjdxIQqy+TDq1He2vtOkLj9SWwC9U9dfG6NDF5qpJ5xKxpwVsz2rSNgOewK5rLrPC6
         YC9uV+QlWAEnrXzto3V6U0BTTyfeNa/eUN/U93s80oiFi1Ttawan02uZS1Qcq8GOF6Ls
         q85tRFAqI8XJu5vvn5jE2+zb474e6GtUCCRxEwywUamptlLBuWXmXPyYg61Yh7AOi+un
         dLRQ==
X-Forwarded-Encrypted: i=1; AL+hErH8ufVj5FsTfIZVUQxMcc8LIv3/PWtuYnzQwk6VpWYxrEGKmxJLzn3pkHG2srOMMEv9b7DgTskybVk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tkExyTL8nDLMKyQdT4nzMWNGx8E/Lp4Chs7UVI9f+081s1Xzt
	6IjYYPjmcsxj36Jh6L6ikmIEZ6npUSkC3ZNqHblQV+w7MAag86YkDuBU8dn6LdWt2BknBr2cGjv
	h4+9dof3ftWfTqRoZl2AcE5/gE/r/XINiVouyjthZajhnCvdtOUCMPTwSUrFgjBc=
X-Gm-Gg: AYBFou2AW83ICbNrMflsVOAn5fjfIc6EooZRmv5cPAu6PVgSlp2XlI9oTRfiEBd7D3z
	bUW1l2whwE/8F8MCWxqwjXINV8HqIYYFM+ca+R1iIL3C+LsQj6nuhdUKbaFHRsEKxX1I2YwS/6j
	gBg29GYRrfGIUUxpTWu6ogkpGqVzD501GAKHcl2gzgRj0zeUWRvPNviqrIZXK65mukcaRg6JxDr
	8vAeiSB/s/4wfutSkkdSGtcQDCimteEHKP6KhB14EYzn2wJsAPbYe67uUKKPkOLFffI9rGFjfJr
	ITiLc8LwoMsQSH4ARCyN3VlMMPrNdCCT3AJn1qKDXmmmWruRPjkh6QX2fBa8aelYp/8m8uHo/de
	mKA2JrRoX1XOwqRjvtOxO3BEIfHXOxLIEJaeaH60AwCyUqqmEA/4s9pLA6Hk7fWBITBIfvvpuYp
	Rx6v3wAbYTaFOI8/SUVjVQzIchEybXT3IlE1UOvp/NxQyXYotJKKg=
X-Received: by 2002:a05:7300:6822:b0:369:9af5:7bc9 with SMTP id 5a478bee46e88-37256bf17efmr8459357eec.23.1794242742070;
        Mon, 09 Nov 2026 08:45:42 -0800 (PST)
X-Received: by 2002:a05:7300:6822:b0:369:9af5:7bc9 with SMTP id 5a478bee46e88-37256bf17efmr8459297eec.23.1794242741349;
        Mon, 09 Nov 2026 08:45:41 -0800 (PST)
Received: from [192.168.1.66] (164-34-238-49.southernonline.net. [49.238.34.164])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372660f385bsm15132197eec.20.2026.11.09.08.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 08:45:40 -0800 (PST)
Message-ID: <37560f54-ee44-48a2-aa33-5229a4087ccf@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 22:15:33 +0530
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] soc: qcom: geni-se: Define the QSPI firmware protocol
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
 <20261106-qspi_upstream_series-v1-4-21f43042dd60@oss.qualcomm.com>
 <8015c245-5bdf-4088-bdce-7e81b3fa440e@oss.qualcomm.com>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <8015c245-5bdf-4088-bdce-7e81b3fa440e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af1f8b7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=rh678R6S33b4aGV2lqlmMA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=rLV7qYPEkEEFJh5gh6kA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX/5k72VPbLEUd
 z3H2niLSb9i7Nr/Pym/TFT9RJwhrogsJi4crkQN///dwFSdKb03soHNutgkS+gH4dU6+Es0fDAY
 tJhUvZYavwlzkIwyhv5pFkDCfBy7Fx88MT2sVRkxSvF3Inks8GXNfWz++382BXdeaSWBsLs6Zlm
 X/7eqmXBIVy2acdQttNrgUyU3nJ0EMTtDpZ6pVFWtz/eoDAu5TPdYlGjnXcuvlSKKsa3VCkcDLC
 b6c5GoSEQ82/RlKCQakhNXj7Ex8Ig5Ub1lRDYCaFxkUKnqRgbDs1K/Az2GWsQXt77OEKOBYPr/B
 nwhGLavoU8fErnTUqpMWvmsCaNh5fxwxNup2jh36EDAw+EkFIBWXY4Vsu+64XD1CYHCQhsx1BLZ
 qcCWRyuP+gthK+Og4sTM4ESm2ILR7tn1K5koVONFZzBSoA5lwIrDs71OEwxzrBjrsYGiuXL8D3H
 Bzb0sr6OCleS1UalE9w==
X-Proofpoint-GUID: 7sLRKwIVVOyUbV4YJMiKkhXk2ntXwMrg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX/W6T1arddkh0
 28Dwgoa1r5zgp7wBfIYsbeC1/rcEpdTbvPt9YrHcKooeU0oladwUSN39F4Ewt6U1OteZe5H2Sci
 RFtPvW9fB7+eN2lzlQfimz0OjOLytHc=
X-Proofpoint-ORIG-GUID: 7sLRKwIVVOyUbV4YJMiKkhXk2ntXwMrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090066



On 11/9/2026 8:17 PM, Konrad Dybcio wrote:
> On 11/6/26 4:01 PM, Jyothi Kumar Seerapu wrote:
>> Add GENI_SE_QSPI with firmware protocol ID 9. The GENI SPI driver uses
>> this value to request QSPI firmware and validate the protocol running
>> on a serial engine.
>>
>> Extend the firmware loader's protocol-name table to accept QSPI.
>> Reject unused protocol IDs in the sparse table before looking up
>> firmware.
>>
>> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>> ---
>>   drivers/soc/qcom/qcom-geni-se.c  | 7 +++++--
>>   include/linux/soc/qcom/geni-se.h | 1 +
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
>> index 873bfbd6b2b7..396f3d81d292 100644
>> --- a/drivers/soc/qcom/qcom-geni-se.c
>> +++ b/drivers/soc/qcom/qcom-geni-se.c
>> @@ -122,7 +122,10 @@ struct geni_se_desc {
>>   static const char * const icc_path_names[] = {"qup-core", "qup-config",
>>   						"qup-memory"};
>>   
>> -static const char * const protocol_name[] = { "None", "SPI", "UART", "I2C", "I3C", "SPI SLAVE" };
>> +static const char * const protocol_name[] = {
>> +	"None", "SPI", "UART", "I2C", "I3C", "SPI SLAVE",
>> +	[GENI_SE_QSPI] = "QSPI",
>> +};
> 
> Please use designated initializers for all values here
Hi Konrad,

Agreed. I will use designated initializers for all entries as mentioned 
below in v2.

static const char * const protocol_name[] = {
	[GENI_SE_NONE] = "None",
	[GENI_SE_SPI] = "SPI",
	[GENI_SE_UART] = "UART",
	[GENI_SE_I2C] = "I2C",
	[GENI_SE_I3C] = "I3C",
	[GENI_SE_SPI_SLAVE] = "SPI SLAVE",
	[GENI_SE_QSPI] = "QSPI",
};

Thanks,
JyothiKumar>
> Konrad

