Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506682F8E85
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111864; cv=none; b=lW5YzW5aX+5MVkKkwxhv1vFmUPINnuEXDkqji8vOmYAnmgi7GShPBqeazQe82WXTaku5QhiMn0xJkbltMUk9edUCwVpFSHSSAFd0pJd4Was+wpfmjo2MW5DPTfdzO5U5YGRXzUwtZjljLkSO4pZPyPr160T3pzQf6Eq5O6PpcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111864; c=relaxed/simple;
	bh=PZPkxgLVIgWDKULzLbz5EJ0WQuzhJ45VhRLCp03T/6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmBcTCz8qZ+XKQqqQvoUmRaT3QAgczeAED7S4pYPv+rkKnYJjqD0HVniiLIcYXvDkqsiJwyL9mgJQptWaSTjae+q8bzZI2wgYVm3ILPog0lSeqCUzKoNNWJVNdFsbEbMFiFpFZwmCDYNvvs97+5Y5PpqaTvnHfNwjaW6uvyrrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F2oPZ/Fh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TLul7rXC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F2oPZ/Fh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TLul7rXC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ICLB7n1890422
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 13:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KMLAnLOji9kv4nRsZe1IlIymkTyn1nxERx4sdod9gaE=; b=F2oPZ/FhxboVPYnJ
	AJxzVvbyyYbe3l5niKcNWMX3PbhXPKr5LR93SX2DFD9cwX2JvGFjTalxBsvSo/31
	JqM9sbYxChTNVByW5+k/u4EJfkEIAZJXxX+2awIX07zPJIRctECGVI+4vh8J2apg
	f899byuYdo97vX3+lxcJNbh43rLRW250tg5RBIDnNc3pRF2jytL9tnn/ZkYVl1B4
	V6hyOG8aEmnqcAESNt927tvwRw6pUfMDyioPr8BwrhbNFFi3PF/5L8YGvjiufP7Y
	zQJ8Ms7tlgqI3IKMTB+2YiL77PpjeAgy5Ad1N3RHZ5at0nAre5eI5w6o9XeXhfTn
	rhYwpg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82pw09qe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 13:44:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50e5d7f4b63so6220061cf.0
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779111862; x=1779716662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMLAnLOji9kv4nRsZe1IlIymkTyn1nxERx4sdod9gaE=;
        b=TLul7rXCrNURNdq15UMrA2vMuyBKtlhr+3JQ1TMFTmJup6OggPl0f9TSTB2VlGTm/i
         RWE03VOCEP5zMCYcZ1sD+GS8t5fG3yui7Q5DBsLR5o+LKCgRzg/v94R3LTGDW0dpT/Un
         6F2lQbg1HKTomswZ8BZcvqcGiVG/9qcGGHGbGY/lQFYe7evjymuST6UpAu1UHALpVsRo
         ZsajuvOYg5fz/1Tdf507zcebJ0yYbRrWOeFXBf3O6gU4nGL+rx822JCkS2Qi+7uYGAfq
         k/sFypOs8r3HB1gDVFmHY4fLcyEVuoAv1pUsIeydhZEr/8z7P/MMF4g9ZzNU+MoMV8f4
         Nccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111862; x=1779716662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMLAnLOji9kv4nRsZe1IlIymkTyn1nxERx4sdod9gaE=;
        b=JJwLwE8Xe+6Duv/hYWZ1VARNx/ZG9dW/QcTLfiTISegXtBPVcjQJT+gxRsx76A4pDn
         LW8OBBm4h1S1YyTaHrmmAhyJjgWgumRnFGedNA3Sakfjjur4gB6J8EOj2TlWzWMOPmYb
         T58KzZaYzDYBdKpUVF1um7L9JRdqEpmib4vljS1Yci3rN4V7BEu6p6pQK27fMF9keYk9
         I8ODAJRy+PC9kmXIzl5hSsRmhNtt/zjcc68KfwGosx1QKqQ0Q2Zdhlc5DRZf/h71xwtn
         NY+e3LosIgPIs5Y9oT79udEmbqNBZ6auxzw6RmWW23LpbkTpVl1ePqufWXAAQfeegVKi
         o99A==
X-Forwarded-Encrypted: i=1; AFNElJ/HoDp6IvcHXUdlnNWU3teikEN3qEWjwa3xasmdfoRvP+rszl3OjXiNGAU9faq0J7pNDsbbKu/iovU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFnucvFGoxN7xdQs64r3wme2aQoBNxZDxGjdTvIka/Aw6iSKK
	HDvkGsyPIHDdicdC0suffaMASDBT5B/0WYyxtYQkml6VReQfYd3QnYmPB6OgJJSuuL0klYlnK6z
	w+EdHf+QRU7dSC/VDpRvAgdqBo++UlawPDlkiWZJgkr1D/HEsSvtNTepvNjznKqE=
X-Gm-Gg: Acq92OEeHFAdA10MRXe0pW28Xle08STRiFRdhzmcNqnhNVvcVVFhBerQ0f/fC4vMqJd
	+SiqOLuYLcll3oIm0/4gJZ+0fMy76wX7F2KXt5sqCHiM1rXSubVKxCoojBA6uNE8gBzqNf31M8l
	kpPBFMwYsSG2fluOfWR4J1oniykr2z/FxTGQWlPIGXr2LKpy2BHjaLgT3JRzhl70BsYp5y+JsX9
	0bCdQkeeDcpncWVLeMBfBAr8u1+qYxmJ2h0yj2Xy7bDprBbVOJ5iggr9+g00Rkys2EHPnimBtK0
	c9jPRT0iRZKPXuiJpWUcOdXNCnxiZx7Dg7mVZqCQOdjRFzUv9d8Ch9Cihw1g+ZiUYXoohEOQjEG
	KKcMB8RrX4Jksnyet8iDx7cxropQ01MK4/4+I8eQ7OC/CyMuNxVds4OkQjOuJdqPM1vtmdck966
	gXFNY=
X-Received: by 2002:a05:622a:155:b0:50d:a92e:fead with SMTP id d75a77b69052e-5165a0c1de4mr138119281cf.3.1779111861647;
        Mon, 18 May 2026 06:44:21 -0700 (PDT)
X-Received: by 2002:a05:622a:155:b0:50d:a92e:fead with SMTP id d75a77b69052e-5165a0c1de4mr138118961cf.3.1779111861040;
        Mon, 18 May 2026 06:44:21 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c313f7sm574499666b.21.2026.05.18.06.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:44:20 -0700 (PDT)
Message-ID: <5dff16c8-5e30-40f5-98b9-c6b423013448@oss.qualcomm.com>
Date: Mon, 18 May 2026 15:44:17 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com>
 <20260512-add-tracepoints-for-qcom-geni-spi-v2-1-3b184068ecf9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-spi-v2-1-3b184068ecf9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a6AAM0SF c=1 sm=1 tr=0 ts=6a0b17b6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=rSx38Zwr_KSaChy-qZsA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNCBTYWx0ZWRfX4yzVqNnTAnyV
 P/aPxMhHxeUnmJQ5ollF8NBblOzSBoXVZ9bBPCcaXyNMH4iFPteB3ilNVwXo0tk5uFxgb3TN575
 TYpEkGcDwfvaRgE7npvjnJ6Aj2S0Y1/x2ZjvqbdWuaKk3571lRPurwS2/htxeJnYJwVwbELSu9n
 YcLgy1N5lVKdE9A+aDUZDf6JzB4cS7COXVrhO3wRg7yY77kep2YCDd8dlgD4vnD+jRcewvLI+DD
 MLnZSj9DgueMtOPPrz0J5U2c/cbGFT9yRj/JbwRk0dHS6WaoDiytRb4Hu/WxVe3id7u8dXHZ7iT
 Ek+rdyUesgqMCxZww4345/zh4HLJZhBkeIRt0AC6EXItm6pJu/AtuIyIhIwotzyIkCKuJUskpjj
 laduj1ysARfP3Nl5I+rMdFC+6uJ9K9j58nGmhDkku6KZNAm2WvubujqA1WaLD/d/zMPxYD8ZA0w
 53MaEXQP1C+IoEV2lRg==
X-Proofpoint-GUID: cYp-PMDu18l3gbHE1faNgpFefUwDeZy7
X-Proofpoint-ORIG-GUID: cYp-PMDu18l3gbHE1faNgpFefUwDeZy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180134

On 5/12/26 8:12 AM, Praveen Talari wrote:
> Add tracepoint support to the Qualcomm GENI SPI driver to provide
> runtime visibility into driver behavior without requiring invasive debug
> patches.
> 
> The trace events cover clock and FIFO parameter configuration,
> transfer metadata, interrupt status to be making it easier to diagnose
> communication issues in the field..
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v1->v2:
> - Removed TX/RX data tracepoints.
> - Updated commit text.
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
