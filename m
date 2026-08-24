Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058863537F1
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583506; cv=none; b=h4id0UdDQrte9wZQzBevJcseIs+bigrWcHVEOAj9M78OSoYNZsKb7eSHz5S7mbQ/dhvZr96Wc68gFryz5Kn33tNBeVLqYkDnZyFb5OIqskXJ/eVU4+8gbGVt+22+Ii8PYYfT5x1RVedkrQwrkjbsOhd55d90hOEZ/mcLlfKA9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583506; c=relaxed/simple;
	bh=sV7LRWxxlIj9O5J0NrZ/m+X+w/pYcNHRDRmxMkRNZp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvese/2FwE1ORHJTaAuTTX9kfsdR1EPrQ+RLwiYwTckF+GnSdaeoLnJatpq1u8TM0C6g+HfvBiP/d7lRIX7uZdKgKZ3PpDjEfhwuRDcbEKH/k/mUIZjXXHr1P3YnFpkklcrpvCePdORpQSuB0KaRAWcZj/5e9lxjC4mED17/xdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhYN+khC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XGAOayD3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhYN+khC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XGAOayD3"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCuuls2480196
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 14:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7yMYGRsSAF5SF9le8WlaBTBssyzRoC8qWApQAK5q9q0=; b=hhYN+khCexrhNx7F
	hcjOxeBDx6yzO9fGZ2FoohKEcthI95fq4Qfj/0meUoSBcsYJQ8kdxKUoOMPAcgQp
	tkh8rhNwNMplykSjFvQ3CjvhnCyosVt/rHHmJfL7rApeP1bdrikr5jJi/N8NZUIc
	iAZb5/SocjoG1uIKO6q1M1lgfcp9ItNFV2F2MZE9nbXWvRBqwz0QJSnZ4cEv+zjs
	RhrHR1nNozoUOVlYXvcI92TzJBqLWt2W8ogBbLl6SGUMPLzX3FkEWSrZ8EsA2IdO
	BdQ8np/5F1WammAerUy6VS87ItnPfp0mvD7QbqDWDA0tbvdVwKdDYFgcMf96Zme1
	e9LH2A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kdshc5w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 14:58:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c9e97b626so6320581cf.1
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787583503; x=1788188303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7yMYGRsSAF5SF9le8WlaBTBssyzRoC8qWApQAK5q9q0=;
        b=XGAOayD32RmGqN9lsYGe2/H7Em5eu5roo8cna8WrAgs9Tkt36sWXUFMUZ4rqg2UjG1
         JU6dfQoWc+G8prjFmapRFt3Hl8mV25nfe1uapfdcRcfW7Q6zIaKRusQoOv1KZ8jAsqGB
         q+xjYADNay+fw6VgCZDsZ/2dUWLqM6EiVlDzMvYvsJGgpGdBzvGKECjonSWYZYIHG5qa
         7ojWysWK0hLID6b/iCvC3uHCVPF4sti5XzElJdPBU7MEtxQu02I+6M2slBUAgkLIM5hZ
         w+x3K1EHBYtK39RpGfwkqiqivOr+0Fk72FQJCxGRKgndMdwRBA5n9sXpMkMGKG28wKtr
         pdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583503; x=1788188303;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yMYGRsSAF5SF9le8WlaBTBssyzRoC8qWApQAK5q9q0=;
        b=kTEOnSmcN37qsEC9SI3+m1bevLwVCpBDuIWHbh0nDG6Eo+VXGRUIGIi38PaljJtL3k
         aYQEoT05YQHGvR4IZyyXz6Dlgcv/gkBNZSGsfIgt6FY2P1yY9w0el2RW73mir5t1vwhT
         ByMiCbilmGZ28LRmY5qjKAR2nmCeSuvmfUL1iv7YAMCQtSGRBQmPPWSd0wkg6FaW6Dzf
         Bbw87IJE+zLbkZIVCozCQExNNCBSTyUHFq3+rC5MU5eAGynkkpwv78Ei8rpQiBMfZy90
         ojMJy3x1DPlQej5YRkL9xjluq6ftWa6kG9DbfYYuOi3n8sUa/4e6inpbVvSXK95OZscf
         QwDQ==
X-Forwarded-Encrypted: i=1; AHgh+RoWFxV9rZ2xn/bOYN+Vi4dpjglyEbVxzMo/t1z+LzR7nvGb3HmjN34ehNgXQLE8+AEhdgATBbeeb6k=@vger.kernel.org
X-Gm-Message-State: AFuF++mvOjo9sOJps279wAWoVgI/fvs1yG/E++SO1ggk/CqzJZK8V5ll
	5TyjakCpKGGkmyTr/aHXjK5htHrSGECPf+mnmmGcPpZwh6TLeEbaBOZKuF2ZLtTmz7MOaKGMqFT
	2Ozpf4foyKyvudAB2gIu/Uk8WT3DToUK5M5eBsfSiMNClj7ewo2NXNQFKK7ziksI=
X-Gm-Gg: AR+sD11eTal1p+5evyZh8hZoVxVozIZcB45BWCVXartojeg6R4PWnAJkb4H3Cli76Bx
	28CrzDMDXVIK2K7lvJALZrYvBetiOQ5wakUwDSJi8jL7x/1QnIhs8ZQyLa1rH+hzpFR4GzCF01y
	4TV0w6CA5utQ4P+zZWwaUp9nSRCKu/UWqsH5x7/E23ygbyFsQlXN0TQAIsjaiKGUR5auaDRJD0j
	UXMqseOOrCs3rQVEv1fb/eEO1K8h9lk/sBZUTHU+OQJccXFkBTeRLBk5gers/Yq8bzpEcn0WtMc
	2yOZVHIT1iHGNR3MrYKOd3tfGAiIEyHo8nSZx3F2iW9aCUEhIxVtC3FU+KTx7U74ncXkRxdczif
	wtAfOV3LLL2oEemnVuArvM0wD
X-Received: by 2002:a05:622a:34e:b0:52b:4ec6:52c1 with SMTP id d75a77b69052e-52df59fbd50mr211834391cf.3.1787583503277;
        Mon, 24 Aug 2026 07:58:23 -0700 (PDT)
X-Received: by 2002:a05:622a:34e:b0:52b:4ec6:52c1 with SMTP id d75a77b69052e-52df59fbd50mr211833791cf.3.1787583502825;
        Mon, 24 Aug 2026 07:58:22 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm1453437466b.25.2026.08.24.07.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:58:21 -0700 (PDT)
Message-ID: <5d2504be-0691-4174-9d98-7759205718cd@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:58:18 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] soc: qcom: geni-se: Add helper to set SE clock rate
 via OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX//HfSNvLZVK4
 040WQco+YFIHL8L9UoptAvRhijSytsCQbDV4UL9gysBcEVjA8fSeCEourczx5F419OF3TYFGFOJ
 YFMusbXT9prN10F0sNAHAUq+ZEBLPtw=
X-Proofpoint-ORIG-GUID: ZlVgWhkAd-jnIWOqfGCPBCPTKNmY9ZNb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX+V/PkiSm2F7y
 Hu2hipkzmzLFrvuBlHLWlQZGGaJeK+VS8ywMeMwcUIlK0W8ffSoRGOngoJFKX81kJkwbp/WjN84
 RgTw8Z7aqsEL2JYUDOzvY5EGzZJdT65LxQCCzTztfRc9j6JIAgC3EEenvWJXjxP4RaDnOmiGmVU
 LyCdT3TSvk6q/dC23QkM8YlECNenPRP0Z9I/rRFEOvMXBzE2bbuCeftMgBN0EUlojTgflVLaOBa
 l98xpEsC2fN28+/09QjD6MzO9g6cRdIMcXD/kn/p0leNYeOULVIyT4nAZjpLwd6zkTjWN5F1RMS
 DEdLvEFMElrr7y9KRBICt40k4d/hxygZpRnMGx1dfiTC9GG9PuvIJTPVItD6e0BTrrhjtsx2vtF
 DcBNKDT1Q+V96X2iJt5qGjVdEPQl30Jfo1H179SWowCNLHGT3m06axFEWAyEUrtJ5Ovv0OqP/HJ
 Hj1HT0S8CGs8xceXKGg==
X-Proofpoint-GUID: ZlVgWhkAd-jnIWOqfGCPBCPTKNmY9ZNb
X-Authority-Analysis: v=2.4 cv=d8DFDxjE c=1 sm=1 tr=0 ts=6a8c5c10 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=ieDA_EM_2LYBYmKFcIMA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240126

On 8/4/26 9:57 PM, Praveen Talari wrote:
> GENI protocol drivers need a common way to scale the SE source clock
> through the OPP framework. However, the device that owns the OPP table
> differs depending on how the SE resources are managed. For Linux clock
> managed platforms, the OPP table is associated with the SE device,
> whereas on firmware-managed platforms it is associated with the
> performance power-domain device. This requires protocol drivers to be
> aware of the underlying resource management model when requesting
> frequency changes.

[...]

> +/**
> + * geni_se_set_rate() - Set the SE source clock rate via the OPP framework.
> + * @se: Pointer to the struct geni_se instance.
> + * @freq: The source clock frequency to set.
> + *
> + * Applies the given frequency through dev_pm_opp_set_rate(), targeting the
> + * perf domain device when the SE has power domains attached (firmware
> + * managed path), or se->dev otherwise (Linux clock managed path).
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int geni_se_set_rate(struct geni_se *se, unsigned long freq)
> +{
> +	struct device *perf_dev = se->dev;
> +
> +	if (se->pd_list && se->pd_list->pd_devs[DOMAIN_IDX_PERF])

The latter will always be true if the former is

Konrad

> +		perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	return se->has_opp ? dev_pm_opp_set_rate(perf_dev, freq) : 0;
