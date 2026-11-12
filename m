Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491285;
	b=f8ixQRsEP81i2dO9+5lk3HOE14p6cpFm38nsVM3H3aNqub28O5DsH/u678nTcf7MUS/4
	 3rHSiUmMnTSbtGkoquHxgS+yfO05EUBZo8uR2C2JMVO+QAlGm0EDYJ/xdFTNIvxeKscti
	 Yez8NX5FVKjdWP+loUBdywqtBQNh1EYdGdQe3mi4yk7B25oZ/ypYJC7m136Mvx9338mlr
	 Kxzl5TcW5YuO6AAsqZoz4Hb2nkrpnhx8Vr9vTsKY7OgS5Jxg6PEgOvgmFF7EBasjLQr8H
	 Yg0qn6hToPaGioNoYT6AkIxbwYAl3oIIwXnbSED3dbBDq0EFggxoYbiUsykVNYaB01Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491285;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=U+W2nYGry4hKMV2JuVK3PdNvH+FLPLTAkEAHuaqJzqE=;
	b=pGhph4uqzAeqr9KNc6puYuc+bFGcSzoV9UjT0ZJ+RodPT1kyDI67iCOJJQJgeG5f69CQ
	 V39/Etybt2WPNOJGjdJJ/Y2f2a6m4mDwy2zdHHFsm0qsSbDK9QIOcXXwZuIGayuE9lLzu
	 wCIP7vyz+G7oiDs+dtbVD2tlxFQtmg4kp9Ly620+FiSN0spvQUdZNfXrgohYqAnUhQgIA
	 PyFyoqOk9hbvvJ+b4XW7G2fv16UEmhXDgVuOXQNfBvyOvxeI7M3FGR9g8sAktamgTlTDZ
	 RnOWSidpu+lGYDAL7mT7HMKW15SDT7thWEOvS5wOR1NSzPkhLhwkvcj8vTuSXn1DrVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hq5ed0vU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=be2W0OH3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB103606A327
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 13:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB103606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hq5ed0vU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=be2W0OH3
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9NefS2514376
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 13:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U+W2nYGry4hKMV2JuVK3PdNvH+FLPLTAkEAHuaqJzqE=; b=hq5ed0vUkzkNuUs5
	mXglYr6PA/HYKeuC7/0cQzccV4zjo16sbgqlY0VQr/p4uTGzmXQdsEwYrpzn+b29
	rfs7sSQ85pKLLtRqrz0CJMMbwNPKz2UyHLJDT7dJlM289/k5AJTzDmTiXkaRSFVb
	Yb9UANoH7spvuqsMktXYVVGUaZAxSIGUdU71683lmatlu5MwA4MlYWsC2IDG3+hW
	jAPq/lRftHqp+nGO83WwxRognk073p3HuVJoxPVA+PkI3aUsVs0OtGYRMzKg9FYJ
	goECocsSKnSekf4xYWc5aqavga5TAqBN/I4WpOWq0fWd8ffby2UC44wNZOnjq8p1
	43J/cw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvwm1utbu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 13:48:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f5844e383so124606985a.1
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 05:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794491283; x=1795096083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+W2nYGry4hKMV2JuVK3PdNvH+FLPLTAkEAHuaqJzqE=;
        b=be2W0OH36Sr+oIDxYJx9kEhbnPGhKxIqWsB5jS4QhwS0lAoiYWw2XSrh2t7gNR0sz5
         ETd36Vw80LM5r5AzM9Gf+HMzho12nbd/qXEaFN0bBP2FMwzCD8t8wga9vqWHGhQV/Vm0
         INAch9nBPIjJ54YDdn6XXIzLxvZMBodMca4OmWB8Ua34YE6ZlCqZn8M8nftisYGHlFEi
         5kWu3uXZzNJp8rOhjzuD790Bua5X3pSmLQfv6kYspUiWXdx2E9dsF1tMB/pUN3/R34yk
         bxk0Xq63VaR7KHcXe7Ro0mFW28crTtCJQQ6VMNkZUzxxwWEYLz6oZQPCiv3YdA7z9vOE
         Y1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491283; x=1795096083;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+W2nYGry4hKMV2JuVK3PdNvH+FLPLTAkEAHuaqJzqE=;
        b=PfeD+DI2Kw8qlEQ7bOHG5t5W714trZ5BA1dXgpkln3u9SjokHn6K6XMPcEtfgDHp5O
         11ltQlGA/Jt2SMZvIUsxaUvBsRwS1qh543mUn5M4AzmNh9ye/p4/PBrDSXR13pz/7BBY
         mLrEwVR0+4XIq4gNnHw1bi4EMBuLEEehHQFmMIa62R6Dk8E9X5S/PD/+LNujjnCn5Suc
         0naeR0OuOP+p2IoZ1ZKuRKyojDz7lq5J9g8EGf+ej0oN7MDA+Do/JLiT9vwADS+MS3MI
         VSnCD6pKr/fkgFiGE0VBHz1w3ABA4YbI7BASOrnUbXnRuX0k6oSM3ksQh2p/lhoEAMpq
         0SxA==
X-Forwarded-Encrypted: i=1; AL+hErH3PIUHdicmakn8ysLq5DYjCMWfMqOmaB736r4H7rPr3GS6agwdSLRJH3fzraoc8h5lzMTZB0qwkkE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9B//EXC7RXkzWzm5PG/BvuzN/ShiYtNbWbbCtI7pxytwqth5wI
	258n7xjQ7WVGWw2X64vFhdlxrIWV8ltBVceatX+JflAFlutVh9DNDEzTGo1VknfvFw2mx7QAOCV
	Cy8WmLqsncXX245kk4UPOZoFzA+gnyYHedzLPDG0ZC5LeMUf7bhByDRpHPfdnTeA=
X-Gm-Gg: AYBFou17EnvA1hyzaVRwvE6+emAR4yOWKhnULPaRMT49NjHuNMe89zbshRia/CUJLtG
	Lw7USiYwKzEN2uVnRpcMry+ZjI3ubI1s+NVNBmwMZGA7h5uuBTwZUVdI7MMeB9hp6mat1SdWMp7
	QVwP/+kINC91kEx3kAN0fTkdiFGJvicKi9PCsbCDeoYBAR6UO2iR9221wEeY37Yb9clTChtxe66
	KB0bzkAdSl1szgU9+Y4WfMcZhCW4ZBRAeMCetwNgkk2VY+SY1Lt0cr6cDYG28SImo/BpxAGyGpM
	mmtFRvQl+4QFORl9pwVAdGt3tdWVVMHqHnQs8duMPY3jPn4d+C4cdTCingJqhH4bBFTm/kZyMrL
	ntsSkTarwhAKOey5EFf6NvOHYnT7lviwjZdhdAvZfkh6YgPOFU6qPXAXoJxA+awVq/cmpc6Xo3e
	LdYsE=
X-Received: by 2002:a05:620a:1b96:b0:93c:9c0b:3898 with SMTP id af79cd13be357-947affc1c3bmr930696285a.59.1794491283090;
        Thu, 12 Nov 2026 05:48:03 -0800 (PST)
X-Received: by 2002:a05:620a:1b96:b0:93c:9c0b:3898 with SMTP id af79cd13be357-947affc1c3bmr930691485a.59.1794491282604;
        Thu, 12 Nov 2026 05:48:02 -0800 (PST)
Received: from [10.218.50.86] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c16be05ba1sm325697e87.50.2026.11.12.05.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:48:01 -0800 (PST)
Message-ID: <c9427a03-8b45-4e35-a29d-7ebe30f07ed7@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 19:17:50 +0530
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
Subject: Re: [PATCH 2/6] dt-bindings: dma: qcom-gpi: Add QSPI protocol
 identifier
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
 <20261106-qspi_upstream_series-v1-2-21f43042dd60@oss.qualcomm.com>
 <20261109-wandering-miraculous-mamba-0cf21a@quoll>
 <2fc8f7ea-651e-466e-9346-c47e0a38c5bb@oss.qualcomm.com>
 <20261111-daring-salamander-from-tartarus-4c72bd@quoll>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <20261111-daring-salamander-from-tartarus-4c72bd@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6af5c394 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=dNOB8qFnOFInGeeiHp8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: inRStKusETQSiiLhlauYqWxa0vM0QaTc
X-Proofpoint-ORIG-GUID: inRStKusETQSiiLhlauYqWxa0vM0QaTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX0+nvHX5aRDMY
 hmpCNmqA/ympHl0NF7mVvS1F5rJedhhHs+1Go6kwq/+Urm5sixoH4Y+T2mz9NCaafu6yueU51WL
 Dd2uYBxpJ+xNWsnVKtNC07C2E4+jkWIJgcIG15sxDblX/ceX+H7WQZdSd6K2aPLyMCG1/z0kgOE
 HKaW6jGlq3I3OZsVNk0yA3Keba6m1ufoJLSsLGQOaeCkWzYl4ZDJmj9gAK/psJOReenvR55WgR0
 5Hvs/uiCYtFREpounxbRCAL15nhb4swW6MISBTptR5yLNCh6BGXALrSiJEa0XVYeuO11AvSxjDJ
 HHV8mVGGgYeohe/S/NPBK7/fitRfmkhnDGr3F3/d1wnYXfGxVCwZUR+a9b1isH9xcrva3JY9DV/
 j0BDqdEI4ir8TX39/ezyLtdoc18z83bNaWKtsKFOGqHX+9/8tDPUG2CLgU+Vs+GvJ+qlhNmnKH3
 y/LjBl4mUJ058gVKOVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX9Uo8/FvLGoQy
 BAcEEfZTgW06wyn1Nz3K7l+fYfC25Rdb1rSHIPwr12Mem2OF4CVz/u0tM+0lrLY2gWvHkQJJ3mD
 irFiP4P9aL/eeompwzSCGVGArx0PNTQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120054



On 11/11/2026 6:07 PM, Krzysztof Kozlowski wrote:
> On Mon, Nov 09, 2026 at 08:03:29PM +0530, Jyothi Kumar Seerapu wrote:
>>
>>
>> On 11/9/2026 7:12 PM, Krzysztof Kozlowski wrote:
>>> On Fri, Nov 06, 2026 at 08:31:20PM +0530, Jyothi Kumar Seerapu wrote:
>>>> Add QCOM_GPI_QSPI to identify QSPI (Quad SPI) channels in GPI DMA
>>>> specifiers. Its value, 9, matches the GENI serial engine firmware
>>>> protocol ID for QSPI.
>>>
>>> What is GENI serial engine firmware? How does the Linux rely on it that
>>> we add bindings for it?
>>
>> Hi Krzysztof,
>> GENI firmware runs on the serial engine’s programmable sequencers and
>> implements protocols such as SPI and QSPI. Linux configures the engine and
>> submits transfers to it.
>> The existing GPI DMA specifier includes a client protocol ID. Linux programs
>> this ID into the DMA channel and selects the corresponding descriptor
>> format. QCOM_GPI_QSPI adds the QSPI protocol encoding 9 to that interface.
>> I will clarify this in the commit description in V2.
> 
> Does not really answer. I see no reason why GENI firmware needs ABI for
> Linux.
> 
This extends the existing GPI DMA binding, not a GENI firmware ABI.

The third argument of the DMA specifier in the dmas property selects
the peripheral protocol. The GPI driver programs this value into the
channel's SCRATCH_0 PROTO field and selects the corresponding transfer
descriptor format. QCOM_GPI_QSPI adds the QSPI selector to this interface.

My reference to the GENI firmware ID was misleading. I will clarify
the GPI channel requirement in v2.

> Best regards,
> Krzysztof

