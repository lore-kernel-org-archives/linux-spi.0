Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5C346E5E
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224472; cv=none; b=MUv1X0TgNlLe/w1u63ud+1KeNtToDs2TRyHfZB2A9A/8v1eN5xpEad4/F9PFHXrca+Fhpluf6k4vlpLHHHPMMKZoKT3dPoH+1HON2ZeiY0VIb0Ca/ABcVmR1ih75X+Z7bivM9fOsSc0m3WMgHU17Zjh9sdhpAYiKf5VU4U2g4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224472; c=relaxed/simple;
	bh=axyqzuh+nfuIgh+LK6EsDdGL27Q8CwXPsTaEaTeezNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWm4+E1YWrwnX6Fozu1x7r5nfFohYf2yoiIDWPxkKtj2sSTvV0yPRm60uIXEnUVHZ0bJ9uvix63gYpsXBexHQAlhg1PCTaT/kk+eI8JzyYFPRkNFAnR5sYf3qOCK5egOv61Pya5KBNH4fWtaAaBylfLoZK+mbV2WfGOnjE1rxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oye9RtcC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FlKI+hyy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oye9RtcC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FlKI+hyy"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIVJ81401900
	for <linux-spi@vger.kernel.org>; Wed, 4 Feb 2026 17:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cIOuyFPYn9l0C0uR0YsRIcPMqORnM7AnLgYzjEjzmRY=; b=oye9RtcCXrhouRZC
	AFT1PqkBj3wjjVih85jBl+u7g2yIXHTMapm1TJ+M8fhpvVtV7VRT6ZDgLbCbhlE0
	Ofjc8SUEO97qL9I6IdR57gmB2fzq6KtpMKhL/nDW7l4GziNuItqfyYeGS2bq3gQ8
	t04CEBzwYFfsKC5GRfjV94jSKLJmBrvrfmEdQTj/lTpECo+v4na5TU0Dw8Q2woZb
	66uKKOKryPVZ9T7JsijyL9CcPHOM432M0WSLYZrqBFGgkHfRy4HT7vcOFnXiqe6g
	lvs7Sb5Z8Q5r2R0tLVxmHLqB35q0IwKxC0Ua/MGb61zQ6Qfy9qqSiBc9azN6Hhku
	y5pUhA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43dh1c6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 17:01:11 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d18e652149so1046a34.3
        for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 09:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770224470; x=1770829270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cIOuyFPYn9l0C0uR0YsRIcPMqORnM7AnLgYzjEjzmRY=;
        b=FlKI+hyyeDM2kNKMxj2d2Tf7WUTFZR1tzukrlaHjJb4raf3UxCIO6/U2g8jhC5Jta8
         1TrJsRjcyQIUqG2uW15RYBEl7vuqFQ97wpTf7n5IdrMGXzKVnyWELy0fvJqZnwgLIeSJ
         +K0OoxtfTCc91aF5xDbeiotuwpfeSqWn/JkjBQ57prxQ3Jq+LRnm097wol+HsZfk7Uha
         z5OilwLrMXjxi5Lr0+xqd+Aw7LeMrGSNU095hvi4AW7A9Htl8k7F8iHFQS8/pmgwo+D9
         4u8ZHHEVcMCxLyhyz21NcbOhNrHZOVB3M/2dD1Zei8uRt5QHGNtV4NXfOUZkkuS8tANH
         0Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770224470; x=1770829270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIOuyFPYn9l0C0uR0YsRIcPMqORnM7AnLgYzjEjzmRY=;
        b=FNH/PqDszFhKk6sjhGeHamzHazOxA9Ul4XgYVq7ri3jOSMcxgI6UqBB7G97A7L4Iw+
         5XuFeRlas+3ekjZj7chHlEGMSrA/MHeCK9KS6Nf9u4IJ/Nw/nvHWQEetgm/Ghn+IIGQd
         Mk6IRVN2D/4pCbNODRzCwA1AdDThWCOqub277cMn0kBkjJ1cc6WbcmXoLkqluVq8R6iA
         +2ZZSvPH/2n8GZHz6yjEQtKdihtE3RP2m89xw9w9cpJOl2t1lIMypK/Nj3RvmExQrbuJ
         XHKww7SOU+FHMZ3/CyS+exGmJUiBcLuHDGhmnpBqg7+HusjGKM2QqVgB3ZhRO3yRfuz9
         Gd3w==
X-Forwarded-Encrypted: i=1; AJvYcCUvjvg8sWECp6WLaoDqui0Vb0GbuCNl/lkOT+kpOKhFKIeMJlCEqE3w1IUGt9HtlFTc3IXvVsroupQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZDBv7cFMLcT9tQQUfOdnRW4Zx9+dgTnoROVHXaVYC/JhXsl1
	U80q8Ragdeo3aHHW32pjbGkZ7TijLOk9RpTH+xxwnyK2heTiecoK1oNAeAuzLLrBFmOhL4N6wc8
	0LivdGbr2hHAZ9RAaGsobFiZDhLyOf30wqJyI5axSJSDHkAuJRsTk4dB9nCN08u8=
X-Gm-Gg: AZuq6aKjbQLqJdNMicMBQRkVG01BPI0kVjl9FnTWIAfOHU9+Vstq/NbnA7YMoe10lX3
	rFIYH2ZTxB9275RP0+LPLceiMRjhteqpfPo8QNMpXfqIX7WzUTruUWab9vAp1Bh9OTCrRR3Ulg1
	Ok4dWOHSmXuIhBg5d1JK7juP6TwlFndor+qCSZM8ff7yPndZHctZ8OwF8krtdqaPyiAgVpDegm1
	4shnfdxsq0Tz0Dz9KT2SKg6F0w5iEe/Trke8/6If2Dps7RmJjqkmRq8swRIBJiX/rwTOzuQoQI8
	jNtZ427jYNwdFzCeE17chs6aotnA0VPLJ4P4ffcSKVMthFk+F35ngwHg5iQbBHi24d711whaXkt
	57+FtFbXjU776V2F6UVAyR5D7Ij3tiBuflPdYqast25g37fRb9iT/gjlQxweQR/ceTOk=
X-Received: by 2002:a05:6830:92a:b0:7cf:d117:88c4 with SMTP id 46e09a7af769-7d448c2348emr1443874a34.6.1770224470440;
        Wed, 04 Feb 2026 09:01:10 -0800 (PST)
X-Received: by 2002:a05:6830:92a:b0:7cf:d117:88c4 with SMTP id 46e09a7af769-7d448c2348emr1443847a34.6.1770224469981;
        Wed, 04 Feb 2026 09:01:09 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fcd8f7csm138531066b.14.2026.02.04.09.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 09:01:09 -0800 (PST)
Message-ID: <9917eca6-1543-44f0-b0c3-388a85b80e93@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 18:01:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] spi: geni-qcom: Add target abort support
To: Mark Brown <broonie@kernel.org>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, prasad.sodagudi@oss.qualcomm.com,
        mukesh.savaliya@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com
References: <20260204162854.1206323-1-praveen.talari@oss.qualcomm.com>
 <20260204162854.1206323-5-praveen.talari@oss.qualcomm.com>
 <68908c06-390e-4717-bab2-708de7f5cec4@oss.qualcomm.com>
 <d8415a8f-81f2-4f14-bc2b-23f90879efaa@sirena.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d8415a8f-81f2-4f14-bc2b-23f90879efaa@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bMgb4f+Z c=1 sm=1 tr=0 ts=69837b57 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=E70cyP_rRQkSMiAniigA:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: sCTDnZ0IRGVHGxjpzh_sewDA_7O9EoaT
X-Proofpoint-GUID: sCTDnZ0IRGVHGxjpzh_sewDA_7O9EoaT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyOSBTYWx0ZWRfX6D7v8jS8ZL9q
 Moc/A0Dc/9mhQV8pOgyTRq9rlD+JXFqegqiypY8Mylgr6Cvny1x+JTlF2SgPycvCiDB2vnHnBbw
 FE1Pmy8I1ghyV9MNYF/VWYNX4voai7vuHY5dIPDfV6+K/d3KLegwcDP/UxAwiZsD/MmTnUTKYN+
 Hdp7clwg5Wok6WevhhfQvCOyXpBSMi76resCTp5NpK3NNmzKvjv3falcs8fZM1OraaL8kQpRaNJ
 SwJ0/eTYuWaQhleqkFejg4fM/7lG5j/49V+GOTYQzFan8ZQe2fXEzmIUXOeVnW1stvmjcyCmvgL
 S8raIZFfmIMCg2gOaAUJfT2E1rYovwvybXcKVzMWUiTshnQo09r9UkhALjD06aXJ5DiugeZKXIc
 m3WWwxW/1h7EZMwCLpflCydi/tRTdIWhEOKd/BhPnFKc/mTakdLqfQ5Vh13fOIS2G/hm/NOwrnE
 33M5P1VJrhlgk4P1UPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040129

On 2/4/26 5:57 PM, Mark Brown wrote:
> On Wed, Feb 04, 2026 at 05:41:46PM +0100, Konrad Dybcio wrote:
>> On 2/4/26 5:28 PM, Praveen Talari wrote:
> 
>>> +	if (spi->target)
>>> +		spi->target_abort = spi_geni_target_abort;
> 
>> The same check is made in core:
> 
>> spi_target_abort()
>> -> spi_controller_is_target()
> 
>> So I'm assuming the intention was to allow assigning the func pointer
>> indiscriminately. Other drivers seem to do it both ways.
> 
>> Mark, any specific preference?
> 
> Not really TBH, it's redundant in the driver but if the people working
> on the driver find having the check there saves them having to check
> that the core does the right thing that's fine.  It's not like this is a
> fast path.

Thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
