Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491FA26ED46
	for <linux-spi@vger.kernel.org>; Mon, 11 May 2026 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778467819; cv=none; b=mpwtX1O4dmC0wAGkmILPPa1VARfl4rvhkgaAU+6vapY5bYyh00ASy4EXRa5Gl4EPDlH8NrfbQsZ+MVBIf8AlzhI9/+dTybFYeJh6y/AqCu8AbtvQTxmfphGmPLZiv0RrxYjWH0jBn2YGbFIe81QLClUlJZl74UdG9uf2FT2g3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778467819; c=relaxed/simple;
	bh=7CEpYxzjG9fIv0yHhRZqWpmwWgSC8zbSJ88P6IVPJYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FThIo7qV0pfESqRglabI7Zbi8XNcmqx6uNElOvA4ioQm7z4wBfl1npUqiqZsa45Gyn7rJLA1lVWHWy7uvG2PrAfh370jC0lE7Wfd1eeOC3G3SYBg+i5MoSOh0HuL+lwafBAlA/3Gm2e8tyou1YATazGFHY1DYCyoWAlYVbNzvnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XcveZUs9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LmVTUZai; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XcveZUs9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LmVTUZai"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ANHPsc028292
	for <linux-spi@vger.kernel.org>; Mon, 11 May 2026 02:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AFrXtXBDcGtYWCCGYy7o+Z4QHvQ0PhoJyB9RJytsiYM=; b=XcveZUs9ReAEQ3dT
	eJXcseiAL+gXINniTwpzmLVBPOOjvgeXlPJzsG0lIF+dOJN5FlOABJ91JAJqr6kg
	jJxvYPVtMY/jKsu9O4OlOUj78f1zvj1EkO5gtvSpdyDY9U7y8xc0wi+Ly++OvsDQ
	qD0fdKAVA2qi4sde3qSugqEdYteBnf3VF237JfUU55HAkgq5rKDvLFY74K8nlflK
	iFKMQinTFUodfLV/N2nxfQSaVPo22iEK2l0K4RMggKg1lY9k/Wma+/V62zXHnnLK
	R3Kh0+d1SSM2r/u+ee+yWeEPvQoVbDk1D/K2mJmb0OwUOxQyxBbRIdh3MvHtmCkI
	H42pnQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1wa9c3s3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 11 May 2026 02:50:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-365bba50e82so3674617a91.0
        for <linux-spi@vger.kernel.org>; Sun, 10 May 2026 19:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778467816; x=1779072616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFrXtXBDcGtYWCCGYy7o+Z4QHvQ0PhoJyB9RJytsiYM=;
        b=LmVTUZaiGZnTaoonK72mBMVXJ9MyysK47FZogfx6dQtmYFULiKMly2N6dlwd6uUYQX
         51O11/DbgOdLUsMrTPF2v80oIWBbR7MoIo0Ha5o1Ct0gwmzgPj6uc3LeRBc+lk7bo0yn
         ARbS3yZLEllhSw/mUSZsdYQagFssrg5Rt5TUunTgrT5M0YO3GMlv+uMtZS7yQtEj9gRb
         brYMMR1hRv++cYo/WFNgToyH7137DFuG0upQsFO0YSq2wiPrAELKVH/ALGPXmIcIsKWM
         vlhABHaALEaLsSPluNVfHeWxSbg90XYzNgpK/CUp7kGEIX9W+uo0isennzd8MMRL1IC3
         TccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778467816; x=1779072616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFrXtXBDcGtYWCCGYy7o+Z4QHvQ0PhoJyB9RJytsiYM=;
        b=ZAUyep/ZVCR9kIoRMVHruSUOZ65e6y6QWjZrnF73TUCSWLyk/lWsH17V6vsGFEyitI
         MaxjF63picCPaxQYypdeO08al++OiPUVnSp1s2N94FoVJ9+ZDYNNB7uh0Ww8m/tOl8Gj
         b6YDnxoZF2AmpInU4I+4rX7nbd7eCzFTs1h49IKdWyw9MDAqR7cqFJPU8y8nsLClCRAY
         G+wM2YpJN9CtIsrnJVwTh2PrT0wWet19gdRCNdRWus1VsQ1l7E+MecZvz5YV0luS4hg/
         OW6iownugi/tdovcLheg/wbTY1bRCj3kxQwVYQ3OwPBdiCxw2noyhBDt+GkF2X3s70U3
         rUyg==
X-Forwarded-Encrypted: i=1; AFNElJ8LE0F5TX0wLYsohVtLnDd9uBq7KwB8t5lT6eUIwJuSjPhvejBQafW/a3SU65CDaaWni/r2pLO0YHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG/TkI68VwKpuoq7Axe5BanSm9ad1d4Hxqa6KlBazmbO+YXYTm
	FY3sR2u/HyHyFNWER3mIKmBfF2Tfz2c9Re+1PkJz0xgfs6JBcQk+IbWFOhQMwWRfvXWBNXnGpqi
	z6uF1In658vso2sflNLHEpsxaw7iVoKFqYeGTNZuMu7OlKu0mB5SRzEu8XQla0To=
X-Gm-Gg: Acq92OHYUfpiSTP77PeuQuBo0+OD4tuqjQ160jb9E1Sh6vLUm2uARFBBdtZCUauGhnd
	HQq5WlDJVdHRYOTq6RdWZ/iAs2X8upunklZhxqXT3GFtBdyLMfzHN780suIpZAbHIpADw3qx7v4
	r6Gl0YEECWHeRhlx7q+xIFI4k+w3ETHblIHRHWoOiJ8OIXip6YEnPu/E7ppoXKYs82h6I95b1EV
	qLEbcHINUjy+ECDW6RXDYeXfxDd4qZVCbDNmZCnMfKOpFfB653UpVFEVIeyyUT1X8Cmlp82JqkB
	twFVbIoNzR5ag7EB/b3QTDRDL0zM3YoSLijY3iXZSEO6srnDolFZzcqrtRlM6AhQdTdtJDI68m2
	wZVyMvugfn5f5qJBpFZ9RgKTVYDyqxgfIOBEPfBMyuKtR9pQWND7rpw==
X-Received: by 2002:a17:90b:2f4e:b0:35f:c46f:2b0 with SMTP id 98e67ed59e1d1-365ac080c4bmr20842086a91.14.1778467816130;
        Sun, 10 May 2026 19:50:16 -0700 (PDT)
X-Received: by 2002:a17:90b:2f4e:b0:35f:c46f:2b0 with SMTP id 98e67ed59e1d1-365ac080c4bmr20842054a91.14.1778467815512;
        Sun, 10 May 2026 19:50:15 -0700 (PDT)
Received: from [192.168.1.6] ([49.204.109.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d623fa47sm5901498a91.3.2026.05.10.19.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 19:50:15 -0700 (PDT)
Message-ID: <5ffd5ac5-fa9d-4b4a-9c65-2595271a98eb@oss.qualcomm.com>
Date: Mon, 11 May 2026 08:20:09 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
To: Mark Brown <broonie@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        MukeshKumarSavaliyamukesh.savaliya@oss.qualcomm.com,
        AniketRandiveaniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
 <20260506-add-tracepoints-for-qcom-geni-spi-v1-1-c957cfe712d1@oss.qualcomm.com>
 <afvkiT50ZUEXZ-YO@sirena.co.uk>
 <e4651363-7c1c-4ae0-a97b-b64841424c83@oss.qualcomm.com>
 <afxJmZ9MkP5eJkQC@sirena.co.uk>
 <59e36f20-891d-4a58-8cc4-6822d03daa23@oss.qualcomm.com>
 <af3spostNgoRU0Vv@sirena.co.uk>
 <4d90b061-95ab-40d4-83d2-13425e992d4d@oss.qualcomm.com>
 <agB8AgF3qVqDw60Z@sirena.co.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <agB8AgF3qVqDw60Z@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyOSBTYWx0ZWRfXzFdEA+PLmWBa
 t6/Ae5OQRKFCjq+kFeJ70OnAsnguT+Q7g/QTAnexoZeQuWqK7e9BE+V56tKaFZXiwEa8x9FldCy
 9OfBFfwBmRmihW1up7TvY0Q99Qm2KCz9B19Jss8p+T4WB9unxoSABD4B4dAl+RQ6aAzJ33kkjZ5
 3Z6lpTDM4f5eZaqALiAVZ1N45ZB2LhmiLVG+av/keCckCfR1xnKgTkMQEUibExIArv06UG2/Z88
 oFO+A0DXBtl+8e6gEtTpSO1+AiJ1exRtzHFTagwKmT7zvaq1y5+7lj3mOXxeCR9Ue/FP7eWyfQv
 LSlWLnyzV94EJYPn0XsiK0g4CSAL1kVBGqD4L60YQesE0pIdjqhIVqM1aIZIt1rcHnqQxpXJRms
 5dUPuBW/TiUFUEY8NxAl6bPJH9bqoPZk6YjuVCqslDHx7MUnTKGMWWWOPqdnPz9+ix9GUyM+wfB
 x2Yhpaae6a7L/ottD7A==
X-Authority-Analysis: v=2.4 cv=HO7z0Itv c=1 sm=1 tr=0 ts=6a0143e9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=TOgzk8GLwxQW6KRttr6vHg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pozBpaLkQfaUl8DsMMoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: tussyfiCFO4yshim3vJrbM5OkWno6Num
X-Proofpoint-ORIG-GUID: tussyfiCFO4yshim3vJrbM5OkWno6Num
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110029

HI Mark,

On 10-05-2026 18:07, Mark Brown wrote:
> On Sat, May 09, 2026 at 07:37:26AM +0530, Praveen Talari wrote:
>
>> Could you also please review the changes made in spi.c ?
>> I would appreciate any feedback or suggestions you may have.
> Please just sumbmit normal patches instead of sending partial patches in
> reply to another thread unless something is really unclear.


Sure, I will send the patches next. I just wanted to confirm a few points

>
>> @@ -1658,6 +1658,11 @@ static int spi_transfer_one_message(struct
>> spi_controller *ctlr,
>>
>>                  trace_spi_transfer_stop(msg, xfer);
>>
>> +               if (spi_valid_txbuf(msg, xfer))
>> +                       trace_spi_tx_data(msg->spi, xfer->tx_buf,
>> xfer->len);
>> +               if (spi_valid_rxbuf(msg, xfer))
>> +                       trace_spi_rx_data(msg->spi, xfer->rx_buf,
>> xfer->len);
> It feels like it'd be more helpful to log the transmit data before we do
> the send.

Sure. will take care in next patch-set.


Thanks,

Praveen Talari

