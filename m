Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A930AABE
	for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694315; cv=none; b=prLwutqNw+Hbg2iUTraoxG+/eP/PVh6TZpev7qTlzEzqFxxFSjbJPtgKedopTx+y+ozhPwqw1x/2YWhJH3zN8POUtX3801hmbLleAxRf1U1cKJbbmT1uyHssq0kudEL6kl0zuf5/9y68e282Hr7l/O7ieRkOSxte3YQbx7iJLrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694315; c=relaxed/simple;
	bh=eEiU8vMu+5O1vd1w6lRUiGs5KR7SZ5QpDvtIFlNlRTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAGgzZJ77st0f2uIrshBzwtaF9MA9J9zLssQLm3gSYxJQqNXWZgiBnkyzvQ1c461BKIYO4WoXe39l+10oWssMVwZsHcNo03KAvhbm5AKFNpWMAKOMBq7v6Ad8yIxTHv6cOxIN06VvvnWQjE3Oeclq/NSpJK621/SyTst7EChEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jGa+OMAW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ln+IoiOk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jGa+OMAW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ln+IoiOk"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8W0Cc2056678
	for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 11:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qj70XiMRBk88XSknFY6Ir5XzqLm8axeDAtiCmENjOvs=; b=jGa+OMAWzW2QNASV
	RBhcQINUjagf0ZQcla7SH4cLO/fG4+60rqMscZWpAkwf/C2OMNtmHZxWWUKTtSv7
	/oY/yXoeIcwDjr4AfJN1m9yHnfrDpCWN73Wc/iF0/q17X3FclXRdxDSjjKgCgzRM
	a1SnLoNeTUbyhEhMhDckcuLOZK6rA6c5SajdnW4DXcEgR84qlcSFBfhxpPkZvqp6
	GVahBusdh/Ui43hOBMHHX4qt66W5GBK5JOI2Yzvu4mfGTh8CLWDaH+jW8NoaWHWE
	X1Y0j1xXRuwj+n6/CHANhdCHMWwqRE0FJRODDTaVgX7ra/KtaqyDCiO/XCBVH275
	fBNA9w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesat2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 11:05:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915827fb1a3so48288385a.2
        for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 04:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781694311; x=1782299111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qj70XiMRBk88XSknFY6Ir5XzqLm8axeDAtiCmENjOvs=;
        b=Ln+IoiOkYz6u+PEe5FIvnPwIBKZDYH09Lk3fX5rxjfXoBM7zKHtkNydcS2KxeJ9jmS
         0oTcSx5SRPQ0uIoSk+Y87QDDHtid7vy5jEwrUPuGpZD8nI/usTG8hgKThSk8gE9rgRMC
         KzJ8Uyp2CG1Ub2mHGBX9uNgu4AXHNHEt/PRtG2nlgGIdkXBcqP6yu+0WMq5BLE7v8y5A
         H2dnOSG738ktKlkLDvXTVSVoZk8hnpS0vQDBfCHjwz/TnXfgJSEPhlIULTr4JDo3HwBF
         hrZrTrQApnxSw6kXxT9vpft54etS9DuH9nG4hw6sQXYpHTVdG7CdRu6maPRdiVfKnxda
         0eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781694311; x=1782299111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qj70XiMRBk88XSknFY6Ir5XzqLm8axeDAtiCmENjOvs=;
        b=USJfGWjZWS0oUioOfpEHihLjl1zA5agKFZ/siIBuH8vO24NmFkVXe1XQTkZwYCf717
         eZKFGfQQl0aHS1i5jDnJk4l/JVBhS+ntAdj9BDqY9IPOG9KXywhwRqbS7qw5pVD/5uY1
         2YC5ng7nYDih5CMNnNtk0Z2QKn4ih2RAjow6TgzADjGFegZZq+EkKlEYCeer8bUAJUIP
         fTOpIlVnhFacarEASehbLvHLJ/qSeJShDkpA0tWmYVXF2hxIGpu3wbENqUpW2J/rqCzK
         hvqdqVoxFs+VJnkMvGqiWdEYrOQyfQT4Z3aum8ak66Qa16Q1V/HumBgeIj8KgylgQBAk
         nhxw==
X-Forwarded-Encrypted: i=1; AFNElJ/A0PXuIQVwhwmxqCa9Vf8L28L2O5+IOy7+X3FFTMxojL0WkLz9kh15Jh+qzLbfVuk3JBDq4FG3Qmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsPI8UE7ZO+6jajix7al+VEdRV52I54JxD8gCqnlT7sU3XA8f9
	3BAK1/PRVzE8Vs67fGLI4p1iLEnmfUkGI8Yn4upTdIy79otUEaPT+SMMFNj19vZiy7ufoiayNK5
	kZsfretofIqfmH0S2V4ZXklaqczUAI+wvQE9NJNbsG7Q7r9KVJzSUywe7Yra5Erw=
X-Gm-Gg: Acq92OGMxHqkHQWHfYvIkZnJQp+ZU9lFs9VTzmzRxYI42UGnnMBu5a2Gk5QiZa9Lq4T
	caaCb0DC0JKj8jyBpUwA39Oj/HJYD9Tl8VOUMJplsUEHPY8sR6219iNlvs46sWMhqZ5q7NIU8FC
	KQqX0egGEEphHRHSjz1wde1FO59TXCAonlwg2K4ECpdn4CaTHqd+iE1x7QYN35KGexnrqXl6InV
	UyMOdhnf5sjwzs4THMTrXq9f3XPEp7zX1qGMK59QfTVqZys7+ghfF/gFveJDFh7TAdV536ma/Ow
	oXA8cDfN0KwOSuL/y2QdzcXwkSUaMeak6jTdVDtEJqYXWfuXAKLT97BJOONohFzcn0kvR2hykWQ
	N4ovAt2ToI3hXAub8F29e9IW01IWH2R+Gaag=
X-Received: by 2002:a05:620a:6286:b0:914:ea37:6f14 with SMTP id af79cd13be357-91d8aae2593mr337700285a.1.1781694311554;
        Wed, 17 Jun 2026 04:05:11 -0700 (PDT)
X-Received: by 2002:a05:620a:6286:b0:914:ea37:6f14 with SMTP id af79cd13be357-91d8aae2593mr337696685a.1.1781694311144;
        Wed, 17 Jun 2026 04:05:11 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb8b23f8fsm760459866b.53.2026.06.17.04.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 04:05:10 -0700 (PDT)
Message-ID: <d4d01a6d-4c9e-4822-b0f6-b98e8ecf34f5@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 13:05:07 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] spi: qcom-geni: Enable SPI on SA8255p Qualcomm
 platforms
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
 <20260604-enable-spi-on-sa8255p-v3-4-43984eac4c67@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260604-enable-spi-on-sa8255p-v3-4-43984eac4c67@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwNCBTYWx0ZWRfXzk7mCjzWq+p4
 82W/l1s1Z4v78wx57nLzE14oAO92oxdh68LPLpDACKFubJXnHxIM4fxDeuzbnuNqLIcvdiYjSeU
 dcTtFn/JC+1J4+RUMK3539/89yCF2Qo=
X-Proofpoint-ORIG-GUID: sFMnHJvpKijLuu-4P6BeWxhTJBnHhfz7
X-Authority-Analysis: v=2.4 cv=R6oz39RX c=1 sm=1 tr=0 ts=6a327f68 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Ow8ltAAN0bl1iHkyYvMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: sFMnHJvpKijLuu-4P6BeWxhTJBnHhfz7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwNCBTYWx0ZWRfX0PMFhVGiFa8F
 Bxb6ymu3rqpoC8qfelbGb7zE/v4gd9UZJfI3M32JlUkfE2jzfbkUpEsS2Lu1J+b3Lnh7A71VygP
 1SsIrEXbzij1R23fEZGKagmRIBD+NBaioQ3/XoquOkWWXZibWAfZkDcvQDmBj7YLYUtRV16Z1Ka
 6nwY0tPcMuQ1bAAmx4V6BBgDaD5XTXCayHvgSp4XFS+HO3GpCTcYmVNepNQZCzwovD9wRuN+3Nm
 Bw2gppqnBzurGYrub7q51uN+BWSLmBHZhUvtmiaxthL5TbMrejutdjYLaTBy0aHS3PwyPkGJfM7
 zO/NapwnFyCUJRqQ51J5sbhDsobNbyus84FvC4zVx5grKM1eAGSS9NoejYnR8XhQ8PFqSvBgrFx
 vsGRI+nAdxZvJD3vdmpVF29od5u3gcSpPcxEaPYpfstlAZuHS4Er0jJOVkUB/OOBgoHYBjimGrw
 EqbG17Sk9v3NsIXUXVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170104

On 6/4/26 8:50 AM, Praveen Talari wrote:
> The Qualcomm automotive SA8255p SoC relies on firmware to configure
> platform resources, including clocks, interconnects and TLMM.
> The driver requests resources operations over SCMI using power
> and performance protocols.
> 
> The SCMI power protocol enables or disables resources like clocks,
> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
> such as resume/suspend, to control power states(on/off).
> 
> The SCMI performance protocol manages SPI frequency, with each
> frequency rate represented by a performance level. The driver uses
> geni_se_set_perf_opp() API to request the desired frequency rate.
> 
> As part of geni_se_set_perf_opp(), the OPP for the requested frequency
> is obtained using dev_pm_opp_find_freq_floor() and the performance
> level is set using dev_pm_opp_set_opp().
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> -	ret = geni_se_resources_init(&mas->se);
> +	mas->dev_data = device_get_match_data(&pdev->dev);

This really needs to be null-checked

Perhaps also the functions within that are called unconditionally

Konrad
