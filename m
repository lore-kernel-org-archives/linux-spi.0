Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC52BE7AB
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119582; cv=none; b=H4z55EAd27Jv77uoTm0K39qCcfkRq4RcfW/PQYZF/VfSGU8/HJoekCjWmntxZfWUZFskYser7o8DtbTp8TEZQyyQf3zwWELPvwdgzBplcyC4i9Xqj9mPkN/zDHSMYS+6SixyPOPwFf01MULZZvnL3U5NlXuY8H7LxKAPaW4YQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119582; c=relaxed/simple;
	bh=kV7wA03t3xolDsZur1Y4hsiu+lY9W9WaJm5yxNmK5Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWd3pWYS2y0e9tLaBtOJPSBNV9VxDTFIQWnf+PKbnr887INSmxegQIN1nVWjdI2MwzPkrF0Qkc8xkHpchw96g5Vw/4Z0ZILHt+Gyt0aUtaGIm/DIi6q7FUSUSczH1snpi2yr9np9Mgs/bbBLcDVEwCG1StqSBgERHMI0yYCw8gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KDO9gHtX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CmRwxocr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KDO9gHtX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CmRwxocr"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IDvgHc2188872
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 15:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	csR+wJpOLyPA3FCSrAWppws3sLkeJRysSK8h3qz+NAM=; b=KDO9gHtXEixHeMmG
	bumNm3ZDsHLjuZnYBvOTQTXPPSuc/28CGNelObvbJBJr+Nr7lU9YrXE2aeorvxjF
	oFQOu6D2NMTW5YPQ4AI62/WPQt9Cnhd8vgV7haghtzE7WLop9aGqNOwYucNBQ692
	R/f1zHpdLLedMNYgPZbdTtyuv+IVH+KMXwNNs3EMLvuyeyZbrEs2Kt5tagpOhZnt
	6WQtikJjsnrqeV6mRnt0epm6Ti49DpvVdTmFCR9pqQrMzBI32uLnwz06kXdajOV8
	inem7w10KbtVHwzOyew6jMMqJ58/jOq9MRBlVbCXU6Ojt3XApm0tJR7adKIztl0F
	ve5AtQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xkuhysk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 15:52:55 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-13537722193so8584435c88.0
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779119574; x=1779724374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csR+wJpOLyPA3FCSrAWppws3sLkeJRysSK8h3qz+NAM=;
        b=CmRwxocryRWW3ckPbibELGcXqga3V4D3FBg4rTTdjnbC15FS7G+gLzJPBCfiy/skrI
         rlciFvyqI8m7gnKFNkbcPJ0yVudleQRecmYKixDusXVLvj8Wczi54G6OW1PX03+LFxBC
         eDc4Z24zF3QmxejfXHCBswe99TnrPSCKNmLdRehkaYspt3SIkm8FrGmg3y88bSWuEH+r
         Mdoo98dm1Py6myRRQ6sYdYVLCjc9EHdCUT92yXyxgIMcSBcF4sI/LJtJ4rBILsXEp9XN
         +UJkOH9YyCwB+dAdyDdrpBgAu/LNGNiHohIhrnO814GhSsgwuilbT3QbHR5vCOPJIpb8
         bY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119574; x=1779724374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csR+wJpOLyPA3FCSrAWppws3sLkeJRysSK8h3qz+NAM=;
        b=U+DRGTRKTM89P+HyIcgwwXQYEJGW6mkdZEpyl9mejdxOIxZ52J9CtdlaCsDy+V47sq
         2gglB7c+om9NsUDYitaNfksH1+XpyN/z1h3kThge+o1RmQQF+32ZgDwBXd4MJzh2Xuz/
         VV2mfbenu/Bkve/Lml50AOOWbDNiWEh7s6ai0WUXwJdLEX0q8vxWYSWzsj9nUkq6OVqh
         m5WWo6IbCFFOC4VTyMmaV7wzMzqLki27nTDscXPtiwQ+hI2pZuhxvCKGuCZ9bL5uSSmQ
         x0Q6Nax1u3zGp5e5vJRGb4rSY4l3aZUikq8WtZK/vS9o8IYSHzU3cKOlVS6LthLlZ0+B
         vLKw==
X-Forwarded-Encrypted: i=1; AFNElJ8/M5D2/hlrzwbXp/4sFLM4XRrYHVc0LjR2Cz1z7TyNvEZkAibU0cPwweq2GSwEcxHNXf/v1NDDI90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqBU7fSYCtfwP5sWCNvaIostsXSV8cnbRXQbrU8jPX26W65P5l
	z8MOV5zuDxHlki0ED5tuNm0WqwjedEPHgYBCfPB4KvCVrOwJhCWo/5TOGfetN7oscSEFR5deJxS
	/Kf1MvRhSkZLEX4i1xvqT91panWg+u7Jnb6oWY1JpN6zJS1x/8w1I2IYx6mnXq0A=
X-Gm-Gg: Acq92OF+qQbscbX3VZHfG3ogkbrsCvCl7kBuiaHI6UJe2zK9sRxNWTQdbTSzPudRRME
	RAIoscEYABXq3IH7LKprwNw9UAYENnR6KhRpClaJOSeAB/dc0zCaN3R2iuyzg2Ra4r1kDcPuSXU
	Ne5YpTgSUYrcgH2gTyFMvRJjIcbVFOfaaoCM18CNrErz+KapsjA3Re7Da+/5EcwePgVAVapfnUs
	GeUXtWFUodAgcMxkT7SCaTxUAypf3f7Cfk3ExYNuXsEHIfM8fcGGOnepwvHsVjhlEfwEGbzG8DT
	9LEn+PBAXyJnAhj9r7mzrYihF/AzLuJp35M0xJrOzNw1cojgguZcLvfcqCUb62/7LLtZyOfh0A4
	F/kLsN5r3jNk/gCg39s1tNef3zrEReE4X8+6B04EuXMz7CcI8K89mHw==
X-Received: by 2002:a05:7022:ff42:b0:134:cbed:2b35 with SMTP id a92af1059eb24-13504517534mr7018465c88.18.1779119574059;
        Mon, 18 May 2026 08:52:54 -0700 (PDT)
X-Received: by 2002:a05:7022:ff42:b0:134:cbed:2b35 with SMTP id a92af1059eb24-13504517534mr7018436c88.18.1779119573402;
        Mon, 18 May 2026 08:52:53 -0700 (PDT)
Received: from [192.168.0.6] ([49.204.110.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2352f2sm20239854c88.10.2026.05.18.08.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 08:52:53 -0700 (PDT)
Message-ID: <3b415d4c-7d09-4ddf-847b-b5a3d94aa5e3@oss.qualcomm.com>
Date: Mon, 18 May 2026 21:22:46 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
To: Mark Brown <broonie@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com>
 <20260512-add-tracepoints-for-qcom-geni-spi-v2-1-3b184068ecf9@oss.qualcomm.com>
 <a713082f-e84e-403a-af1d-c6fa0c5d8613@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <a713082f-e84e-403a-af1d-c6fa0c5d8613@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE1NiBTYWx0ZWRfXyvejCQWBo67E
 RhQfGQ5EuETZmYknIjQ4gXKdrGVR/5m0Ac0LGHQFW2QwoOA8BnZfNhnnTWEgXo7NC/6zYwgpLBM
 jbBsBtLDnokppirvv4HIfZ4QsJFXAZDf5suCJYB1cXs7+bCn4CDW/UnsxbzRGIazRjQ1+P6RiVw
 AXbno2NxPUc5Dq3a6qkO2WhzPYA4poj4mB4B8HmDFTSzOTiiXJ7NC/pT8RWi96Gap5jAUzewAF9
 s+fTVq+QMx97AQRGtuRMFLPBvlErdtD8ft+K/Ude3Rp0PyaICjN+V1jgnMd9wcaGe259BtOSWvm
 NyjgnjRRDccDWKYLRNZUWO863ePxskxbJTcWIcUXfTVFpAk13kEwhXsp+ofesvNYK6W/xsb1ad3
 9CBo0Pb2Zi5t6v6AP3nPY/VP+EJWSCKB/TI76YU9Cqg9t2GpW/7z1oih72sliSeT0wkPi7c/zjp
 8gnWLjRCSpOUElLN40g==
X-Proofpoint-GUID: JzBqjk4XSk4uu7ZiQh96VEbFL-GddzG6
X-Proofpoint-ORIG-GUID: JzBqjk4XSk4uu7ZiQh96VEbFL-GddzG6
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=6a0b35d7 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZQCjlrEJpO1bLG4YfcUt8w==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=rWy7ofVw4T7H4fDcE_kA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180156

Hi Mark,

On 18-05-2026 19:37, Mark Brown wrote:
> On Tue, May 12, 2026 at 11:42:52AM +0530, Praveen Talari wrote:
>
>> +TRACE_EVENT(geni_spi_fifo_params,
>> +	    TP_PROTO(struct device *dev, u8 cs, u32 mode,
>> +		     u32 mode_changed, bool cs_changed),
>> +	    TP_ARGS(dev, cs, mode, mode_changed, cs_changed),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u8, cs)
>> +			     __field(u32, mode)
>> +			     __field(u32, mode_changed)
>> +			     __field(bool, cs_changed)
> These don't really seem like FIFO parameters?  I see that's the name of
> the function where we log this but they're more just generic bus status
> things.
I agree with you.

Can i use below name or any suggestions?

+TRACE_EVENT(geni_spi_setup_params

Thanks,

Praveen Talari

