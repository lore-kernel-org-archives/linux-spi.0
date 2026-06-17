Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC93B9604
	for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693834; cv=none; b=iFO+sbWsKBHulZ91lWJ2zufiYTvTYnt5PcX5pARSV2Fc8iH6IXE5VCYNwQG6D7LlxE04dkr6BylePyKjaFyrAxKVYvGZhjs9jx+aCXKOlodXegiXAZVlZ84p12H+v6L2Vy4RjxS78kU2Xk+e4DbTDc/DyWrS9lNHizhFaK5pnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693834; c=relaxed/simple;
	bh=kDkKS67hN3RnVTeB7mYSl6BC188BCbO+mJkU8ds4bNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1kTx6fJzJTcT4YzDDDzvWTEZ6nXN+xTSs1MJSb5Lk2lN0i8IzC7aGnL6k72tu8lH5INsiqhlKMX/y21rSHtSz1jyXvztYNabn4gka1mqhe7QVB7uxn0pHwbt0FMw8mthIZbogQ9gTapyn3Nue8NP983oFGJpMu+tS/knX0FXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lth+AvOz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TqkNxUr2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lth+AvOz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TqkNxUr2"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HArjLw2596310
	for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 10:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P7KjoRg8s50uo75jYibfLq42V4xZVCBOHimACuml5Pk=; b=Lth+AvOz/tqHY0bb
	AiWakXPKnSdnUlJHJKPAoylcUytC8X/a3+st6cUSuYrdUPTBDBjs2meJ4baJM/d9
	v0dSD7x37n95NEX99DKGVrxCtWxLDTqtebFxWQ4EUQMmZVrOayrrYiUkBUxQSQgI
	3GcHf/S+Y5PgUIzJrGbK7/zXyZXKngCT+mUssA8swzSuQpGa+EquhasrdtesSiez
	9yU8Am5GWm3GNhqv/Aq4HfZ23p930GKaQ9Sw5CuMXWHkihWNHx9nN//16AQFkAuo
	RVxWXad/la5Bs+vYZpBSLHCVZqU97M724tiryZCbgeqWDoziuDFbBSljlbv5bmlh
	X4nfng==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef2atd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 10:57:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51968526a68so9268461cf.1
        for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 03:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781693832; x=1782298632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7KjoRg8s50uo75jYibfLq42V4xZVCBOHimACuml5Pk=;
        b=TqkNxUr2X0toUDwJOo+tuyoAp0InoLyXR9Dlz83jy9FIIFbcT7jISSQ2NE7wk4tUO/
         LR3R0LbHdTS+zeHbzYqEZNRjzpyWWXDqrHc+sdjANO4jAgcGh+RYVk4juI+PeDT2E7Tp
         7tWv8Y5o4bLh/jWfha9FoEn/KR+SxoDdcY3x46pDBg10dWKifwzKSVmJQG8Pd2Bgm3Mg
         xn7ex9OrIzLu3jvukxXt8fVvTuFcp3ESGV0sCXh0bNNZxDrSeCfJ0j3ZcfHJS7HOxxPh
         V6ivAZ5Va1T0iJuOkJTPXX0+CkL8VL3rpcvrDQUEfl5bT8Kv3TxGtbNLbqsHEIi2Dl6Z
         lSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693832; x=1782298632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7KjoRg8s50uo75jYibfLq42V4xZVCBOHimACuml5Pk=;
        b=Tp/lwuNEbjxv9VZUyToYLOrx0FEJmEQpWvTwiZV+FRsEr/A3LW2yJqHAE6QDTtnvFp
         qfHBkDzw7/yskyODTHGPmINROE+T46CD0tM8uaAX5ez2fOg6espF9L4MLIFsfPM5ngUQ
         m4ID9/ce/UgFdX5eU/A4Z6FNj0w2cgXWl7ttEMdvgOvO1/HhtTcUkLxMb/X0Z+vXWSGD
         Czg+A3683FKaf8yRCtOnEN9TawXIhpS+sscO8llMYFk9CJqipiJZt11hlpoaIVUMV296
         ZSvw9Nb9Ueb5lw2nqQOmFus+XzlA1HiuZpfcblmEz6bC6ydSuR+QRS/Xwz0rmOuIDdYo
         GLQw==
X-Forwarded-Encrypted: i=1; AFNElJ/WOSW5CETNAstYnKfqk27S+MeUKONocaHmeHUUuHZ3qhif+6UKAjXMp+dezPuzjuJFHHEdoXD/wAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQEiz+tci0SIH0Gn1CpmutLRjEQVxvOksaiLruWOnnLf/EVDH
	PfAKQYaaa6E9WsLJNlfXbR7jA2kMkVl6ThNv0S24HMY234mqvnyZAMrRmKlP/9XLwHa0Z1JTAKi
	fQj6SUQ1tOfg3JjAqIoeUl6YZLT9g0sOdKy0EDUB/cXefTEZPvTSrgIwz9YLHjAI=
X-Gm-Gg: Acq92OEliUIzNVqsrV6gjDWGD3Kc6A9/hw29Zx7vqpLd+Y0QciE401aQL2PC91d4Xdr
	x4Zv5KlpTYwIxZnMYs4lgSRi6zKu4+w2xVUX7YxhsyLqqgi0KXhnQaN+GSqurbo9VUqARqC5apx
	Vdm952arAQR0sonETjWcQNwCXafpESATODMMvEVRS0RfcpAHQPXITFVEKMM8+Z/qYt85wNzSWlL
	FmWNUmH3oufh6GAfzwNHVbXedzCgifqaqSb+e7/d9d6mpiV8eze2HPFE4hfdrpUREiY/BTxkSDM
	OdbuFgmvMNrYGE4KDOP9GhniuZLr3Y/zLFJBi5vIdbpNBz826ViHLVi/lV7PuOyFdFutQGcfyg3
	lj2Z59DLuFsW8kKuLMon9Pyo8UU+JVW7deUE=
X-Received: by 2002:a05:620a:f01:b0:915:7d6a:4f99 with SMTP id af79cd13be357-91d8d5b295fmr353261285a.5.1781693831886;
        Wed, 17 Jun 2026 03:57:11 -0700 (PDT)
X-Received: by 2002:a05:620a:f01:b0:915:7d6a:4f99 with SMTP id af79cd13be357-91d8d5b295fmr353258885a.5.1781693831507;
        Wed, 17 Jun 2026 03:57:11 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c01d667f63asm507620366b.19.2026.06.17.03.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 03:57:10 -0700 (PDT)
Message-ID: <8a4cbd27-6a91-409b-b6b1-047becb57480@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 12:57:08 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] spi: qcom-geni: Use geni_se_resources_init() for
 resource initialization
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, bjorn.andersson@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
References: <20260604-enable-spi-on-sa8255p-v3-0-43984eac4c67@oss.qualcomm.com>
 <20260604-enable-spi-on-sa8255p-v3-2-43984eac4c67@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260604-enable-spi-on-sa8255p-v3-2-43984eac4c67@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F8hnsKhN c=1 sm=1 tr=0 ts=6a327d88 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=G_i3bwEB9gotEOBRcW0A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwMyBTYWx0ZWRfX3m5IkbaV6rEa
 GAI7GrnzqCqg7UMsREv7TK5FoaJY2J+ADlR6c7t50hC4EH+C2NRlvB+9+EBLWM99L/JaS//1IKj
 FKsJ3td9WceWTyiGVgnSQhk7M5haaag=
X-Proofpoint-GUID: W_27eyzLnEPpHCCgFCIjYqwHtwloAt-c
X-Proofpoint-ORIG-GUID: W_27eyzLnEPpHCCgFCIjYqwHtwloAt-c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwMyBTYWx0ZWRfXz1DDKP10hbl0
 +KK6FPmg9Oc08V8+vzUic1ZWSV/JCfLLgq49afnl6BJ9RirHdzgfBRkaw7GC0iZxECoRKyaOJ4y
 Vv6E8KOl6cJk0+2qngf/nKaE/MsE4PX5opUKPWljNWvpyrN1cGjeLaxLirMlwOY3WBk2grWhrwi
 HVpCGMj9BErd7NQldlbJ2IhNSqF+tj21sDEtTNlvi8QZJNboCyzQedoRabALAldzjqG4j3S00uI
 WVA8dpeiUoLt22NvpVwPRvxi7RSbJZz6MCjdmy2iimQJCSsQiEpsNZh/PdtzDQbOl+csysKLB5t
 z7NyhtE8AXNC7kYTh17WerY7Sg/D+KjRPQNprJswjpw6uzR7zmTRKmUk6PefIUiUXcPpf3h1K/d
 GlCISa9RviUkL0gVVrdWYABlQrrgFuzjOaHpt3Kq+/xjKj/gJAKhzQ1tmG0MISjryKZiyTsg099
 038nccTuCuvs0gVP8CQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170103

On 6/4/26 8:50 AM, Praveen Talari wrote:
> Replace resources initialization such as clocks, ICC path and OPP with the
> common geni_se_resources_init() function to avoid code duplication across
> all drivers.
> 
> The geni_se_resources_init() function handles all these resources
> internally, reducing code duplication and ensuring consistent resource
> management across GENI SE drivers.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
