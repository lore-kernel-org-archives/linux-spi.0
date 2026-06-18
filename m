Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FDD37E300
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781759267; cv=none; b=BfxiHmhN8A2smPctC/GzNhcOEUwqfdjhrDZk+Pq+XQXkmIH3//DYlaWsGH7i1+jqomxlrPcKMNa9cNRpSU0gg6XZg/ntiKPpT56AZHC+IFTQvQmnfwbXpgU6dyg8O79GuX4nvlj6BHw0TBIG+GjFH/8glDQfmECtHncSiaIdPIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781759267; c=relaxed/simple;
	bh=B3ziYdbDhd8pejGixMLf8xvt1EMsUg6EN4/WBF/GqmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjtjyUzRkN4P6gBcs0R08Lt9rP/en8eKk9ZRD95/eCPmymOwrlWbpMvWhw5vbKw8S75TV7xjs0jlE69F7DyUcRNhpFu5SC4rhtLuTN9B0tLyNuYlNrGi4mktFBgtJiT/W5NDsrMPhSWS84sbRfijdZ+eKOI6eXB7+MSZJrWuiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZW/4EAL5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IG18Y1n1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZW/4EAL5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IG18Y1n1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I3iVqW329880
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 05:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i9/tMblIXT/+IsiJVmvct5WjsscMVhiD/oY7oGSARsU=; b=ZW/4EAL5LCW6/DDf
	CQihhQ5N0xu18TgzoeCwD9+Szv+fMWrbnCq5Fg3EY+U0Rv90LxIBIjs/pYYWOlRT
	9Z0WNigW1l8FKMBZfDjwdsuMUXy+I4qkijdct/9b8G6agaGvHOCjtGeeOGLDg5iJ
	9VDCfgU/g1mUDXCqKubplMx9rZDBTnF43UUYUwMyzpQ7Xf/tSOVJmwWyWYRUepFh
	AUMfyOVSL2ohi8W9rA2jhRgFIUPTGlYJbUAFAS5AxAYUWqz4a/olTtrHz4JkUNQR
	Zn0TwyvsZOEWtgBGaAlIbwcjHxa3Rjz+NVTcrVw11ETKrDGaGMViTKEN6ApPPTV1
	nqKg+A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vkbmc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 05:07:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304f23c55b2so526458eec.0
        for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 22:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781759264; x=1782364064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9/tMblIXT/+IsiJVmvct5WjsscMVhiD/oY7oGSARsU=;
        b=IG18Y1n1IfhxO2ySjrKXv6xcLjg3uSmu1LP3lGpd+SIS1EJuudOtBZALb1JoM/1NtL
         RcfWoiiFimqZL4cs/HoYRWy4we/db8uVGVs8SlvLBA/wArDNXWY4ydQlWrRebEcAGkGp
         ZSC0GZo46UZNKS+OVHTMHrFdMi5ITUop8uSKoJR1JzDMvJOqp/iskofaNdu3tPprc7bX
         Ut5/0DtmxTjmRpWGWscwZ1K5it+2aSGG91av9CnLKMJ9podSIXgnXp2uWGGzX0s11ev2
         Mf7U4hjpfE5wmbbppSSTfJhk8EwRnO4pvto2fVGFhFSIhrm1KwyrS87wZ0fcnUjji1sI
         UnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781759264; x=1782364064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9/tMblIXT/+IsiJVmvct5WjsscMVhiD/oY7oGSARsU=;
        b=TLOaiM/oCyp06tsFoO9GTIS4cFROQ9oRX8qEtS5WSkRkzSFY0tgp/L5nOAVGvmimpC
         GyFIbjBlIZ3LJOfPe6UqBLuof3shbpvpEGyXSq8bGGQeegJrnU6+wZPdpmPeJpaLb1sz
         F0G3LNF1403wcvpqMLdrqqyeMadB2q8rOb5rFrhhqfQ+u/rIukJfD/CiV8zQnzYHtij7
         IjwpA465a6Fd9RL1yteUg6l/1Y1iziqgoLFuGpocaTrtw3x3TQctgjj/w+5KA/FOqlBE
         OSmn97GZNIQvXiP9toYiosWrwsAjvXwLDrC0HilL09HUf4aPaIEpCGjyF3tC9qi27b+j
         ih2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8WRZnI7gG5taI7enWzgglhfaouCLDtZWckToazH0a5SzvIX+xMLBlRiRFxN56ngTOuXXdehWgOVhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrW3ACp9qeE32Yb2tZrJyhznheOS1kntQ4Wxu1I6MI42ejiZ2
	L3EpXcZcAKJXq7BuqWSiuPUCTuO40lCfG7wdr64roZ4s5NdDCT7hjSiue55qVW41IXg0NkST3Pw
	edIYu9va7cEsEt8pGjjLCDjvpWQbhXImwWUrxvLy4LaNimZ9sUtJqAItQs0+t2z4=
X-Gm-Gg: Acq92OGzn73xrucedg813sSqtBRdHI+63lt0qKDgIKiZ44nmqxKCjL64LBlu6fYvXUS
	Rp2OH1arT/O4BA/K0QOjiKH6inx7zDWDn4NrOUBWg/8mROxmQcQJ/yJK/S/7zYQyJedgbUEgYsu
	3VTF908t/SXkr1ZZaJZgCOy01B59d4PuU6r6yDWNbNN1YRKXvfKtAhZZz3oatF0O6FGZxRoVP+d
	W4Dzwq4n0Z97vOREz93Yn1tEfUHjR8kwJw0JQ8PhoHLJDnt/DzE4rYyFip8XlXITrFfXB6QGQ4w
	YNntadwx8xSSGE/kvSQO4EooFA29qB+r316gSnLDHEofi1+HwdilywLN4AsA2TIINPdataOHrIl
	94JAk/vTkFz1iE5+C7AJKG5x8+nYEOwrNLzxxPLkAer4=
X-Received: by 2002:a05:7022:3d8c:b0:135:578a:cde2 with SMTP id a92af1059eb24-1398f6f4707mr2821605c88.34.1781759264420;
        Wed, 17 Jun 2026 22:07:44 -0700 (PDT)
X-Received: by 2002:a05:7022:3d8c:b0:135:578a:cde2 with SMTP id a92af1059eb24-1398f6f4707mr2821569c88.34.1781759263833;
        Wed, 17 Jun 2026 22:07:43 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.107.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b910c51sm17780940c88.4.2026.06.17.22.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 22:07:43 -0700 (PDT)
Message-ID: <d2dd36cc-c5ee-49c4-ba5e-7ea0e76602a1@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 10:37:37 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] spi: qcom-geni: Enable SPI on SA8255p Qualcomm
 platforms
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <20260604-enable-spi-on-sa8255p-v3-4-43984eac4c67@oss.qualcomm.com>
 <d4d01a6d-4c9e-4822-b0f6-b98e8ecf34f5@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <d4d01a6d-4c9e-4822-b0f6-b98e8ecf34f5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 480R1IDyuCBWGZuKfWRtnnmXqxJqxXcX
X-Proofpoint-GUID: 480R1IDyuCBWGZuKfWRtnnmXqxJqxXcX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0MyBTYWx0ZWRfX0L3OFDLE76dk
 xjM4C1sp+ZyhaMTfN7aMHG7Z0+tEdvSIeG18uDZGJ4apKbPF2/xyi+ZFyZF8aiXGUZmlO+9cow8
 BBr2EdB3arOWFecMrJQa2XKJKCskmEWchX6WdE91ixFIAjMqP7ftZo4IRNWnRayRrduSEUpk+nD
 O1/Ubgi7Uq4Hk/HVc/bdd0zo6XLeiO7SPf/MDIRaOJZw64x8c1gKrGRRLpYuuKCQIJ21fyFYT/z
 RaudmjR0O6apCLWSiFxY9kZn8IdVLYXbolQ8OX9nhx72pEdRjLXFGZpbaC+3ttc0OkGihOww4Fr
 X4nkcgy6xgJeR5vhQLrwybTOsA7QIAWjHuAZ26Vm71F2yfarWscSgqiBnX3GE3PEzyUxSsHiFqq
 zKR8yMHy3oictuD9hBuaZvyBYipZSDuqGa3ncUIZfeDIn0SawS11Pz69KzIduiVdvGZb+cxO6ms
 A3XBBeNVa6Sj2NAHm7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0MyBTYWx0ZWRfX4NfOVav/TiXB
 tm9KhOY3uW8ALoHCtxJYkIMnug+IdH6LpkR5owX4d1BLTslXUMLi2IOof/HkVJ9/TXaIij69Ilz
 JPvOnzUJlzm3QxObvOfG/MOA+GDFiuY=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a337d21 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=6s0eN8wnNFkjVaM4b1XlIg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=vRCb6_dfN601Ubi85e8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180043

Hi Konrad

On 17-06-2026 16:35, Konrad Dybcio wrote:
> On 6/4/26 8:50 AM, Praveen Talari wrote:
>> The Qualcomm automotive SA8255p SoC relies on firmware to configure
>> platform resources, including clocks, interconnects and TLMM.
>> The driver requests resources operations over SCMI using power
>> and performance protocols.
>>
>> The SCMI power protocol enables or disables resources like clocks,
>> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
>> such as resume/suspend, to control power states(on/off).
>>
>> The SCMI performance protocol manages SPI frequency, with each
>> frequency rate represented by a performance level. The driver uses
>> geni_se_set_perf_opp() API to request the desired frequency rate.
>>
>> As part of geni_se_set_perf_opp(), the OPP for the requested frequency
>> is obtained using dev_pm_opp_find_freq_floor() and the performance
>> level is set using dev_pm_opp_set_opp().
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> [...]
>
>> -	ret = geni_se_resources_init(&mas->se);
>> +	mas->dev_data = device_get_match_data(&pdev->dev);
> This really needs to be null-checked

Sure, will add in next patch set.


Thanks,

Praveen talari

>
> Perhaps also the functions within that are called unconditionally
>
> Konrad
