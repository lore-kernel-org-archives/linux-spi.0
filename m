Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456803B994F
	for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693991; cv=none; b=Aa0lF4ytu1wHLwzLpCQZbHxDAGwDwdd6Mb8yPg3whAiuyO5qShUeSY2qm/ZC2bM+25qqyd/LZ0GQ4YZp+UetqTW9s2q0XcS6RSzlz3C5Oh48mbiF9mMx/r/Avuif713b4DC96d3mOBPoU8h6lEh4mcnimEWkgUoZi9p0wgtO768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693991; c=relaxed/simple;
	bh=XBkfdZqma9YJXH4WQfN/4BdC4I4nvOEcDzN0FNhnRUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HC236ww3sJopwQJalVo8p2hYCik+42Z103/oFrAtH6ucRNxDzlCErkmAY1gwhyJxelMQQ5WbM9JRB+JH2iDMAeYDCyQvou+COE1yj8eVicw6VZy2ujMi/WyTON7kTbnRvzeCQLHYFBF/uvxfWKUTpJ1hdirumkUDQfNtUqyfieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=buHvTJXr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H+w3AGWd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="buHvTJXr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H+w3AGWd"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8UXg82217646
	for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 10:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	28m5qJHxJ5Tg+COf1JCEhZftnpMn24hnH5Aw1jUzrv0=; b=buHvTJXrJICsoivI
	+YU2p6u+FK/5qV5gnZWGkCfUAuZ8NL8/jkvh5D+L3SdKsj2dd89wOXOPikNgXs0e
	c/TAqM8lDKffSD/Sesd+dpgFL/oAnrHapOHIqFqOHXoxDX9s7wtvZfdpQ2/5XuVh
	N3dTRzaZwD0W5kiB4rAdsPkL7CUCd06l2AL8vJBg82DbsLfPznyKC1fm0Yp7mLzN
	BNlVgmMzsXitpe1j+C20zY8GAppmBpMVIGBbISOJfGBlH8Vsbxw/LgqpXSzbkj+L
	OHCtyLR1dQ6YQy1eFHtfRfM925NgYLO8hSlHGB9KT0nra+B78xbNiknYI88T/nWy
	OXpV5w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueerat1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 10:59:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915ccc2d4d2so119364185a.1
        for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781693988; x=1782298788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28m5qJHxJ5Tg+COf1JCEhZftnpMn24hnH5Aw1jUzrv0=;
        b=H+w3AGWdw6XByTHMUd2UuIHrcqJhsjoKTjqKaXq3fWylyuDS5HKImw1XcpohFZrt/D
         2HwmtGRb11OJqAcR9TknjJillfovc+kCw7mk64+HfUIgvNHUnqieSLMkWz2WuVV/6Vyy
         INWj0tfo6aRIobEQqS2lWOEERLxlK/WWazWp0UtLMsyXG+4dHTO9QTK5F7Mi4cgkRKHY
         udgqXnQzIx7z5moVlUxhaR8+FkGskpBQetIldOFfdEVfupNrhl8jVisxIK0vdJHxqLsX
         nmliAELKbvonBHtXjxdJm2JnTKK4DeHh4/pz0Vx8duEknOSpY43hql0EN6vt+v33lnOZ
         6H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693988; x=1782298788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28m5qJHxJ5Tg+COf1JCEhZftnpMn24hnH5Aw1jUzrv0=;
        b=dvpGSx+Ax053e3ciH2PcFPb9fThjzLshp9MBp7YwfqezK9cfdHg7AzMwjE1scGUIKE
         h26qi1FW8lIneQaXr5pNI94jKGsyHCfU02zxqbn4j+wncBTXxJhS7bS07dE15jkNJkdO
         2C18bcXiSpGnzlD9rIAQx34GaTR7kHUwr8i/nDbZoZEYmU4jKsRA6jYmA/m6XIAtMOBT
         o/eLEKuYysmrdZOdGin+LmcsH/wsNkkkOAICGuawZ7g1c2anoRTOKY2xZub7zfZg17qb
         RsmBbxczhYy7X33KD3OJ3DNubKxF+qtKIUOhh7jOIRiK5Aakx3vehhK39XRNXm6VMT7Q
         wq8w==
X-Forwarded-Encrypted: i=1; AFNElJ/DBiIi+29cK7ZyLJbGeDVGfXWplOnozifUJlFw5fMZ+YMdNmi11lXVr4AtNpjPnrHCzdqWjGHGbWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGXMrc3XylevKJcfHmBS1QfoWt+oSv3DEAyI9k1DDZ75MiGWSk
	kWzyEIiLVeumG9MZNY6NTDkLc4s0d2Fviy+A9MvOrvWtozQJYoTOZJmJQ1XeZbIroexJlv2/WzF
	m4ubu6cQpMqdFpjyT7eK+IRuKmHQ1c6YFhF2okSbdJM9aMgJAvHpKGv/JsljOjR4=
X-Gm-Gg: Acq92OGGDcmteqqR3UDKk7/hm0e8qrT1SvxwTJvigiOp9TMX4iuuwA/7amyolFG7S3A
	OE+mklVfE7UyfAR/mwNXLJOs271plTlA9sympajna/ehWWfuTyv8M4RojJ0Agp24nKTgL97E2Zr
	zk70wI06KqMlUr+og3oH2bwvN7ge6SQ7Fp0fVYEwcEn91tNZgzIh2/SpLRlQXW06U6pkCYVtbn/
	oox+PHC/22xV4rWN9boUKHFnKTBKNU0lsUl5fpn/rmHwtb3tVc76lHc9vm2Xu1xvnk35tEvQvs7
	gavZYk609THCkluFtgUUtAlW3tG1yebjqIgDFo5tOuEL3mjEyyfUcsXuqq4QQ2LJG1p8lWOVQM6
	BTiwlCcJga4rcFkM/1M4SsgoCCPdGi3QBlQU=
X-Received: by 2002:a05:620a:bce:b0:8cf:d953:b4ec with SMTP id af79cd13be357-91d8acdc2e3mr362782985a.3.1781693987618;
        Wed, 17 Jun 2026 03:59:47 -0700 (PDT)
X-Received: by 2002:a05:620a:bce:b0:8cf:d953:b4ec with SMTP id af79cd13be357-91d8acdc2e3mr362779785a.3.1781693987028;
        Wed, 17 Jun 2026 03:59:47 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb8341840sm791241866b.43.2026.06.17.03.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 03:59:46 -0700 (PDT)
Message-ID: <ff8c29a7-9b45-4ec6-b10b-4df93f37ba92@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 12:59:43 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] spi: qcom-geni: Use resources helper APIs in
 runtime PM functions
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
 <20260604-enable-spi-on-sa8255p-v3-3-43984eac4c67@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260604-enable-spi-on-sa8255p-v3-3-43984eac4c67@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwNCBTYWx0ZWRfX5iyB0BlsMCcn
 oEmbP/kpcHmabzzYqJ72cSkwYpy3qzNXTS/E1tXpMjKGELPNRucC2F4RGq5V0NGJrw757WWT8Nz
 sH2xAE5MdepuRWbYuTOlu5iom7pT9O8=
X-Proofpoint-GUID: -58wo6XVxKA4opvwORhTbFJK5KHGy4TG
X-Authority-Analysis: v=2.4 cv=d4fFDxjE c=1 sm=1 tr=0 ts=6a327e24 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KDfMXkAB15iQ4YLeNhcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwNCBTYWx0ZWRfX8pQnMS4EOUG3
 829RFdXls27qWCUeOMK2a7xv3wW4z68D5PvU59+K4nwPCEsi7YuB+Ob0z+Rp5KEy447cGwih2WU
 t85TxfVqi6GL0nWjrfBhhvgZrcpgglIJHrzs4ftdCDIvuT86HL3APWQqetk1HIGexMQVpSjeC3O
 QGCtFvIpMncoqxavvq6OsihgNOZY9azM/D5bmj1oqo+Jqvke2feh3gXcoNEOtQP58BdCczPWjlj
 BAHwAGxXIsntNCRZao9plfCEwDoIekxE9zKsf5RWB5W+vdJgeyC4EWlXhiGdSRZ4cvtk0B4VjBK
 NpUMpWKbv8e1C0Rp1IpgJhwfQQnQroXX5oyUjlW+x5CNu9MhkWVuKePHL85xstMuU1VKNpRbWuP
 h7hUQIKmajuWEIUoFm4lPtCZ6NHLtzaK7kThuusBVxFlnGeCl+iLYxPNb0TkjvE7wwwMuugpjDl
 UmRyjPKb/r/fdcthszg==
X-Proofpoint-ORIG-GUID: -58wo6XVxKA4opvwORhTbFJK5KHGy4TG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170104

On 6/4/26 8:50 AM, Praveen Talari wrote:
> To manage GENI serial engine resources during runtime power management,
> drivers currently need to call functions for ICC, clock, and
> SE resource operations in both suspend and resume paths, resulting in
> code duplication across drivers.
> 
> The new geni_se_resources_activate() and geni_se_resources_deactivate()
> helper APIs addresses this issue by providing a streamlined method to
> enable or disable all resources based, thereby eliminating redundancy
> across drivers.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
