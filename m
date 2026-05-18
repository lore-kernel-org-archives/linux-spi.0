Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068433F99FB
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111898; cv=none; b=tGFiK2M/o08G4vNTe1qqBxdW3rM/sKNtbATLXGCpuqrlSOuhAXzBlgH9WdVkzoQHGyJzpmWzu1WIYQS7042V4jw7AVzu/1BU5XR49Pc7gpsOp/91xHfe75GgYtm6O2GBsdMguf2ICxADugZKXRQcmELuP9YHpljIvV4A7uusAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111898; c=relaxed/simple;
	bh=lHvda2NbFgW89aGtBUROhxE/JDE+sRSb8r8BbzUoSLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQLMOQ6gbuCXetX7DhVuzy7P/pgUGH3x4mpfR6JyyhH3Bd4siGlbXgapJ/a8KIaMmHuasNZ4vrQo2wTohWb4cmocWyp5zLC940+/zyX6QuHuYhLSn7jjLS4MjHXM6Kgwm2GMWi4qkmbUlNd1MuIgLcCk8B00RrDgHLCMSdJT+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oz6SJ0q2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D1nlDL6N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oz6SJ0q2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D1nlDL6N"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I7cKmN352982
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 13:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VyevxfIizzgDB7/P56OEYcISboPpJOah7P6lWmyc20Y=; b=oz6SJ0q2ihCIsKhS
	izEDZsnIZ/68zpI+HyMpKXsv33iN1nCp0OST0FF+9FZGCNB5FfUC5kNt+Ni6xPdg
	ChhH0eMonqSRRpRIidoEZYkb/axB7ewS0aQMzipvLrQuPh0Uq0PzcTL4STZdtMCA
	+l/J5qdEKHydRjm6pxR5n3/qXUmBQyuKogQKMtZH/itAA30B74l2M/b3m2OX21t/
	J9J9t5XFaenSu/E67MCXQjzObmC1IKea7TpmbyxD1cP21mFYjfrl1mtFCcGL8X5B
	nCVJ5PcCMLykSLrx/4Uu/QmE/HLV//OZJ9kUnBtMUHo/zFlItzUHYRgE1v7wQYFv
	6eUxqg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xjaheq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 13:44:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50f1b94ac9dso11635611cf.1
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779111893; x=1779716693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyevxfIizzgDB7/P56OEYcISboPpJOah7P6lWmyc20Y=;
        b=D1nlDL6NM3Dj2yLgQJhqAGTwi4+zKVYe+DgFnofdA05NYWLzvmRNbu8wU5zXlS0PrF
         LA+LqBDF3wsJ6l6KQLdk3Vn3FJuXpNidB/CR3ezifYBWMXZfeOOq+tTIXctzApUpR62E
         /Qip10N3maiPwrUTKY89Kw0cdx1PeetZ+x15mvAwLVe+6ABf/46n8TrP+WizeoeBb3vP
         HcLwx/KCvu+J/gCp/QiXKjVD7enqwGYarInZZlhBOSTh1Hf1TILP0MT/dsfdoOV1+cyS
         J0071sZcf13k3xRhacCz9NQMxqyHk2Ty/HT1QAIZCMbT0mV5I9KMnfcgAma+npYpa4JG
         i2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111893; x=1779716693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyevxfIizzgDB7/P56OEYcISboPpJOah7P6lWmyc20Y=;
        b=Cx4ez7xaYnWEqtOzPR/nBC9q403w3Y0cT7D3zWlddiwX9oHWrvWaoAbqnPGwgbN317
         VmHB08EtIY+8oROJrIwnxPsgyzLjrkik9WnNTmzFvV6Jhl8g1C475zxp7b8ZOCUoRNEU
         ExPfR+Or5DlRehMUfM61emfnHcP02uTmrNGjoSCVYtbNk9nIVjIRV96pfNorCW+tCybR
         KYPDDUoTwiURmLPTjxBUTAzOZO/oslKVFOpfLpKyMbtGZG7vzzfLYLr2n3jJ9n5OHMpv
         0cZJdyW2xYPtCyhRM69k0AVHchM2OAVcU+iMRQMIDrm3m8sVSl42wS9OHv/8rgMk2MJO
         r/cQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DQ608Qiunj1vuotZ4qPhsq7uylXxqyMh9xnpvIlx0QXwCWGiw4vkBYtC/0jhIWve/m79q9cjiX4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzukJl9vIzvy4p27rRIXTDNzp227qp3u7QNLsIAlBQwn7aV50x1
	mhrW2qGVOOLg72kmAwd3sjZhB7M8eMA6Ha+JenVGHUXW7QWHrPCgH5pNDY4nO5LBLhsN4nXc7Z8
	ovrAsGXEEL0qRBh1NS0ftrBywUFh9C7as3GkBvZID71tGsRJmYuA3sIfYfwKCAa8=
X-Gm-Gg: Acq92OESxPzBRYASGZ9pY05QKKX3eIF7cmk7uHdEhZX2B/bKQpcJkUaRfm4Nu+i8ppI
	9Owr50PYd4n0SJ1s9HPTvRAyifa2HA00+Q/mj7gJcBI7YtKx/cM4rHKXHTlISauVuzHtjS8Msle
	delQxqU2BC3Os4TJnfbWVajz88AB7Yl0LhM1YZQnipPNRmyAyRnyY8RsPvVEtlnaGsFFfIuCFZP
	2Rs3NsNzNW0aaU+0nLHi0FTVAX3icCAVZBmyW1l/E3deIOSttnwh1xF40/vM03cnvZwSKnJr7we
	TYQYtJb2kbHRCzNUhj0hANq76bcHrKsnEhPHVl55pjFUn3DVw1bjaErafzgtiAMkSVgMIUwhQRg
	SEewLEb3Q69AyLwZgkvif1P6dQn0ad/AEn5LZpk2MH9Sl30Unty0dSqVLzv7Og+nuK4K6anFygj
	oyP2E=
X-Received: by 2002:a05:622a:11ce:b0:513:43ce:eaa3 with SMTP id d75a77b69052e-5165a202f87mr153359501cf.6.1779111893417;
        Mon, 18 May 2026 06:44:53 -0700 (PDT)
X-Received: by 2002:a05:622a:11ce:b0:513:43ce:eaa3 with SMTP id d75a77b69052e-5165a202f87mr153359221cf.6.1779111892776;
        Mon, 18 May 2026 06:44:52 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b52675sm5248215a12.8.2026.05.18.06.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:44:52 -0700 (PDT)
Message-ID: <4056582b-a6d5-4fdf-8cce-5e2d20b00a08@oss.qualcomm.com>
Date: Mon, 18 May 2026 15:44:48 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: qcom-geni: Add trace events for Qualcomm GENI
 SPI driver
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
 <20260512-add-tracepoints-for-qcom-geni-spi-v2-2-3b184068ecf9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-spi-v2-2-3b184068ecf9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNCBTYWx0ZWRfXyLR826D0WS/n
 mi57k+PlnFfMOqXZ+J+1noE4nDxvCo5wAxVwZHKuk0B1a1he6UJh2NMUBadpORfST7469xmaBM9
 bk00grYekDBBjjUrWrPnu3AQaSMRqpFtXlk1ZR2gXEZveR2UwxzoYjtsGvniamTMbALK4J4cXSq
 wyNv+LuMVqa8kTtQqk4larcf2XFLx5ZGxPfSKtiTog/uLqB72hKEpa2OaB1OJl5N4R1O2MMR9IW
 ugPns+R0CXDQNtyhjbF5H2KtZsafLjehikOvh+8hcAUDOdBg02jwSxWXf5lHLYCza8YVEBYo5Fy
 anJ1aP0ThmoWg0vviIz2Xjh7F4xSxrA5Ly9gPE7ECeeO6aAlJnKBP03bAVyhxRA5Ami/wR+GLe3
 vmFPnGS1Ia63/BwtWf+AptgEzHv9oHGla1Gl/EKPU5DTsIeocUX7oUUjNJC+RkPIRGCTqFgR/y0
 l90oAYgHBP+4JndCdag==
X-Authority-Analysis: v=2.4 cv=BYHoFLt2 c=1 sm=1 tr=0 ts=6a0b17d6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=-Sl1Rx_dgo55JVPCJUEA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: hOnClVip_ETswtdXDtSIQGSG-CuC27vp
X-Proofpoint-GUID: hOnClVip_ETswtdXDtSIQGSG-CuC27vp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180134

On 5/12/26 8:12 AM, Praveen Talari wrote:
> Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
> These trace events enable runtime debugging and performance analysis
> of SPI operations.
> 
> The trace events capture SPI clock configuration, FIFO parameters,
> transfer details, interrupt status.
> 
> Usage examples:
> 
> Enable all SPI traces:
>   echo 1 > /sys/kernel/tracing/events/spi/enable
>   echo 1 > /sys/kernel/debug/tracing/events/qcom_geni_spi/enable
>   cat /sys/kernel/debug/tracing/trace_pipe
> 
> Example trace output:
> 
> 1003.956560: spi_message_submit: spi16.0 000000001b20b93c
> 1003.956642: spi_controller_busy: spi16
> 1003.956643: spi_message_start: spi16.0 000000001b20b93c
> 1003.956646: geni_spi_fifo_params: 888000.spi: cs=0 mode=0x00000020
>      mode_changed=0x00000007 cs_changed=0
> 1003.956647: spi_set_cs: spi16.0 activate
> 1003.956648: spi_transfer_start: spi16.0 00000000ea1cf8b6 len=16
>      tx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
> rx=[00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00]
> 1003.956653: geni_spi_clk_cfg: 888000.spi: req_hz=20000000
>      sclk_hz=100000000 clk_idx=5 clk_div=5 bpw=8
> 1003.956691: geni_spi_transfer: 888000.spi: len=16 m_cmd=0x00000003
> 1003.956708: geni_spi_irq: 888000.spi: m_irq=0x08000081
>      dma_tx=0x00000000 dma_rx=0x00000000
> 1003.956717: spi_transfer_stop: spi16.0 00000000ea1cf8b6 len=16
>      tx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
> rx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
> 1003.956717: spi_set_cs: spi16.0 deactivate
> 1003.956718: spi_message_done: spi16.0 000000001b20b93c len=16/16

Same feedback regarding this part of the commit message as on the
UART patch

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
