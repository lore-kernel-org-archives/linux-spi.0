Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235421;
	b=Rub6D/UKue1ja6JOgkvgk/MZXUCX4DfPSdAGA24ELE7kXTxkZ/buXaUlRJkEVvCnI99p
	 xJiHUkXNLKds5JsitYTo7wY8NcES3Rn4BKpxQX6IpEsAzCKQggrZe7uLr72EjunFNOyj9
	 Q7NgnbhzNG033uIAfRrC4a7Lzo45I/S1B7ToHgOjo42iSm7bz2MI5hiGAh/L151I99Nah
	 e6u8zmcCDl1XfTFTizCrtOGs9y8utbi5DJ8idWHNc1bYPL9TJCoRDXgwK+wAupgKj7ynl
	 n/IU2+ufbOxRYNH4oqDPxySlVYSXM1Xvz2J5g2z0AFhlem9Qnkh05t/t91/Yfz5yhVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235421;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=js3PUCSX9RGe+iWVpuwLPjnKS299ziJYM/TNs2sZ3KQ=;
	b=roTv6LbeqRuzDN+UZS+E2BCv/ptgoSnd9fDCiNZC+ora11WrsT9zUOzQiwxNq9GnESgW
	 l5q5vYHupopWyS5+OKhAeLZ74mClpn/AxhQ5cvB3T9t0xeGPZKa2Au4bzILguX75BJkS1
	 6yjy7+z7yLOoNZjB5R73VmyoTcUzMKiERzYzaMwfplQIYaHjaLoIY46WYfiHCftFQNnmz
	 LAJ2YNIqCZsYhz9StDvhiwpk84WW58iZxaNilgA8vKnT/rhYy01/MAj3V6MBkGSs97V5q
	 RXguR2NUDcwueK11jO/cfOY6pmoaEHVnzo/Cebyi9flWT66Qi6q7K8OvCWCyLKS7qLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RA3bYcBw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="kF1vO/0c";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2524E606A323
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 14:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2524E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RA3bYcBw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kF1vO/0c
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DEr3j336353
	for <linux-spi@vger.kernel.org>; Mon, 9 Nov 2026 14:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	js3PUCSX9RGe+iWVpuwLPjnKS299ziJYM/TNs2sZ3KQ=; b=RA3bYcBwND/tNCjZ
	cLdRZZiLcq9T4Tklbl+Dt6rOJWygToA2gxZOesvz87r8YJ5purBXw4hmnECJLmV8
	JNno1dtpA/shkpgHDlc0nPGYa2QnJ3eMkSd3uPTk6NA55ELLs2fu8GK9g6gZLpIX
	mia91lxuavmbHx3G+WBQXIpPXFOizggz8ZEqmvj1/2dB/xcO5gdF8tzSs8dp7i0E
	Otwdmouv2odcrSLJErRe5e901TkYItRjVrEH9Xo8/67C9qKwprXM8suGai1rEOwH
	xuW7/FbPLLoiln6bhPuywPK80bb5LRlwVaYzY9ljbx6O7ux/5/YvlTD2kAqxAILJ
	DtxdyQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5rrhe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 14:43:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae6fda7a00so904454a91.2
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 06:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794235420; x=1794840220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=js3PUCSX9RGe+iWVpuwLPjnKS299ziJYM/TNs2sZ3KQ=;
        b=kF1vO/0c41w+oEce95lRzdSo/125zmTTbMBK/gEKuWnJ3AUUap2TrdhtvZzIwnWJNq
         +Bh0UI6BjZTqL1aINIuusS1WG9ScQb1bAgOt78eCox2a7Ee5tfgwAJ0r0GVoUxEQU8V9
         SdiS6pFKiu2oxxeDMwMed028B39dS3KbijljM3TSmCpvoY8XwzeTqZ6njpsM9zRuAF3P
         jbvDIlqm2RqEzy3igVzl6OyJkkEq9Upj6BjSEfA/0++X3BRUlnjPNDGMWhf7y03Gw/c1
         GR5DhKRrI+GrLT1N/+RlcAyPuDoQTsgjWJud3hm9c1bnmXID1T0hTXuCPDJYuXzlqSo6
         1A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794235420; x=1794840220;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=js3PUCSX9RGe+iWVpuwLPjnKS299ziJYM/TNs2sZ3KQ=;
        b=Pp/OeWhC1fXtfYnEzdkqbxbr0i3JvlABhR6xCofopOk+D3OCmxBP2RpVtQgFXz8Uwp
         rc8gAZr02NfUprlZRcrps2q22humguDZq/qCpYQUGYS6e5jYi2dxI9Z6NqpGOMj8Fir9
         jLZz/+ijTYMIBHj8dNk2+umqLezF3FJmdenUETFxvzcR60mZy3b3ysc/lOsoxquCvywn
         CFIUL6vtfSLft4FiP+fV5llfx/fDgKkNpiclWFvsjPR0ptQpZkUFPXq6sDEl0wo0camm
         rR+u+jT0n2yJTLLU/lzD0xgE/7YUf9ROcgB+Q+EJDZa9du+VZWBaDYXPC6fSQA7LOXVl
         84FA==
X-Forwarded-Encrypted: i=1; AL+hErGID+krKttmIOsc6vW912N9vHiOpsSt5UH+OQRLIitMlTVr954Lfr03ZlyhTede2n8b6olQUbUhO2Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ihs35FX+WY/l+NCHp6HLinbD4PdU8a0GzqWac1/wnAjmLvNxk
	Gb7ZQQ6LRYlhLw/kFQqTLLRYGzClBsAJYmKL75PvEJzAAQeXXYPShfvmlSp5I8PlHo9pM+FtGlx
	op3e9PAd079nP+mcbNyoWY6uKAzyB3xTbS0VCm7ChmF+uol1siobFv+zs7/aHDMQ=
X-Gm-Gg: AYBFou1qu8sUupObq5QWJw3f2DQv971PNiYIUg4T+ydKUGUsXnN1b2rxQbH6dYZ+ABP
	fYHRR1L4ulAGR6i1tZYFzAZ8TQZKFJDC/97SPkFjxGMr4Wa3kHXeeAyUtMnA6XLjywxb/UIKL0q
	GejWISzE2Mi7ScylK4NuNRPI/C0V6Qsduc1fiq88V8OTvFoiYrBvZByqkSVbqDgueoIvw5YCfw8
	HNCD0uX2Doby+XepvFligA/8yAYGZfhlW2bjxfXu5Pnd+PIsfzaLZWwHJxIWIZqlPnYOuKK48xL
	DGFWS3Izh8cwmCILnCZxBTHm6iIjoC1LJK2PvIEpTB0vVg2RBpCTtEgkEUI7YQPAPMQyk7Urvpw
	BBPgO53/CppJI7kE99Ff11ti6DXkbOF14l36/8rzgBxH/v31ZagK7C46voy390Mis3k8qfnBaH4
	gU5w==
X-Received: by 2002:a17:90b:5807:b0:3ac:c98e:345e with SMTP id 98e67ed59e1d1-3b12d3d2aa5mr3285276a91.45.1794235419717;
        Mon, 09 Nov 2026 06:43:39 -0800 (PST)
X-Received: by 2002:a17:90b:5807:b0:3ac:c98e:345e with SMTP id 98e67ed59e1d1-3b12d3d2aa5mr3285256a91.45.1794235419245;
        Mon, 09 Nov 2026 06:43:39 -0800 (PST)
Received: from [10.218.50.86] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b12790befasm7129841a91.13.2026.11.09.06.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 06:43:38 -0800 (PST)
Message-ID: <61646f06-87f1-48da-9b88-8898bb488af7@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 20:13:33 +0530
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
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
 <20261106-qspi_upstream_series-v1-4-21f43042dd60@oss.qualcomm.com>
 <20261109-stimulating-oyster-of-respect-620b7b@quoll>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <20261109-stimulating-oyster-of-respect-620b7b@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1OCBTYWx0ZWRfX1BDnrTjmfr+p
 leMVAnGKFgmV1VTlaq5JvHR/xC+hfUMi2T5B9TCJkgmlPIfCB3l24Y522kiGM9eJxwd9pnkQOFE
 JC76MWv15ie6Z3eneCwvb2X8DUchW1w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1OCBTYWx0ZWRfX1In3sz4oZJRl
 t0LuT0l6pCfMOfWeCg3w8NysPE5xPSuLah4A+0MuQTTO88hOqZg15cdjR6TVVAi/LhOBRt4RaPB
 oA+6lKcFPTEOl9LJ6JEmRt9A02NBAxxuwTJ3iYKwvUlLi4OAKnMe3lRTfdmjdAvvdosx0Adhy9u
 wLRP04XehYJnA1Twkjr5s6Lp2SXPJQ5fRy/hjDUOS3Gzrs+ODdKIhWy78WeznCa2VElFa3NwyBH
 /ai4uJRP9GZU97SyT3krLAiDajvH1S3AUsMZDH33fL7ZvQh/uikvgfNcz02TkHQ06KmZLcEzVtU
 bK9LJHXmQWJz2xTuO6uannsHSHodWA6umA6g8NSRoUqSPYJHcQcKhL/uRXPwr5qmosE9DEMK+Cd
 KL0uAIdCYYCQXqJ8oyu7MNoS4mnnhF+y5xxCCiFbZ52+2Pe6WxK9qXgsZ2Kpha8PsEXL3W+v9UL
 Q4rtPBMqQgFGPKCqIgw==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af1dc1c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=rLV7qYPEkEEFJh5gh6kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: iF6pXARx-ql1j-W11VFSbReaH8fXy2ln
X-Proofpoint-GUID: iF6pXARx-ql1j-W11VFSbReaH8fXy2ln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090058



On 11/9/2026 7:14 PM, Krzysztof Kozlowski wrote:
> On Fri, Nov 06, 2026 at 08:31:22PM +0530, Jyothi Kumar Seerapu wrote:
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
> 
> Why are you creating holes in this array?

Hi Krzysztof,
The array is indexed by the GENI protocol ID. QSPI uses ID 9, while the 
existing entries cover IDs 0–5, so the designated initializer leaves 
entries 6–8 empty.
The added NULL check rejects these unused entries before accessing the 
protocol name. Appending "QSPI" directly would incorrectly associate it 
with ID 6.
> 
> Best regards,
> Krzysztof

