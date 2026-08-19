Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB952233939
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148052; cv=none; b=d95YhUYczLUG+jiky5b2YMz0DZRZMXFcvk0MdknqQ9r+xgDUkc+lYB0i/HMiZgtKjrFnW9UQ9xU0uZ9SX+T448Wj+UbQYyHzOVn7wdf/Sbo3tzIbiGuMnPevjPe2mhjzrV7j8rN6Q65d/AdWB03tjckp7kZABW2Bs/+E627wWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148052; c=relaxed/simple;
	bh=62e1kUMESzzCwuPSSGbFS0/epS4ablyVxUFHfRq4wfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRceP5vUUsrDtYjVO+hz6oiEyWQsCzEjdE6lHIuQ1sVHvQ5dguk3e8/ZAF0k5khIMnasyRJy5sd8csc66s+shjS7PyC6n9ao6JTXTqjzs3u9U4/4wwpSy/YHCfpXjOjSfgrbYGihj3b4I8kQ9xY8DQBbG70AGX2veg6F5SdVwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RKpRwjQW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dikIMSZX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RKpRwjQW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dikIMSZX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD0bbn3600882
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 14:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nF2NpJFe2HGshGcRjWNfEWmWVrM0+Bh1qZpz0JDv/hg=; b=RKpRwjQWmEDYC1k5
	hms4mMV3ZkvzUyIf1+wcPVTqDIWwiqp4T9wJVhzHnO/AMcYn97K8TgFKp1RSt7Zg
	V/S+HaSEbrEJ9S6q9hp8b0bjxeO953rtTJH/S7jNQAGkJJgboCg6BByHR8miTEwW
	dEd7iSTzbsj/pT22tmZ1S4GWQsT68Q7/94XscwmtiyYxM3R15s4GBlY11xU6J4b0
	iU946LqKzbzVjGZl0z11VdCrojPPbMTciDsZ6kewgm7ftAQzRSYHAhWjOnb2zUTr
	jq0oN3hUzXwBUn9dxq7LpWSDh4Gf7KzQZ3m7DKfbCP7uM0CBAfIhVw9K8pa9ThPv
	h+6Y7g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm3j62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 14:00:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930a312222dso18527185a.2
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787148049; x=1787752849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nF2NpJFe2HGshGcRjWNfEWmWVrM0+Bh1qZpz0JDv/hg=;
        b=dikIMSZX1WiraT0fLjmVAS/wOiaQkC2hbpvCqpnHjeo6OkOduud6rcWafj/o8S5lS/
         vGX/0aRT+zYFL3W3jOZl0EsCC0RPTuxbm/8HaRR/x17M8GarYBsh8+nCAuSWlCO/Q+tU
         0yHQB9N5Xso1IxcbAXydT8U9AAkPgXTS2HQ8hKw7+f6enA8CyovSjyEmuZTANvQNOOIB
         dS/tF6I3A4gdkYFhuRefB5KSpV/jPa8yQXCfXTLbZpipZeBUe0F9X6TnUv9x9YWAgKMS
         izpH70JwqkUbzABdXfFcAafFSAe0nDyRPhjSL5vyH20/chGpXRnvyvqZR3J5jU4JN6FR
         aLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787148049; x=1787752849;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nF2NpJFe2HGshGcRjWNfEWmWVrM0+Bh1qZpz0JDv/hg=;
        b=CrfUVmazk+TraoCMO6t9vO9XkAne5IOMgvzh5HTaUikrbwIHSHyFIcz9fJtdNhHHsr
         AB2tcDrxrtwL3pl5JZpzrDNjrv4pDz0c948kcTpFbofuWwqkJyCm/SZWdgzZHhNtJNWJ
         a9xGSuPtf2BTo48GDWWFlyg8KGCf1hm/RH3qeVhrWCs3plkAS62ZeXMpR+9Y65sJQ7Zt
         7syRvXxMRghT4+aAjHVAMDT11z0QJjIcZBRuGP0tx9r6ONPeIppRWYLXXWipYzKOCl0y
         FzBsENPccllQhnCfNVeUACkd1e6tRAtIi8zUwhIUMEYIURGqzqpFDYNZQjMaupIzcFGb
         LOvA==
X-Forwarded-Encrypted: i=1; AHgh+RoHzTTvIG3tu5goszs/vIFir24k5hsppXq4Y5V28x607iqBpRwO/h4hr0MD65fYoxPZ3bpFiHdWo0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN02NUv5chQI8JnfHiD39ZfDR8lMfGvS5Wj+2tn2xSeMnqiP9t
	JfHUKZnrgCNLy7QogGA1fL+Jq7rgeoAtiDb115mPWpt6Pu5HXVyanVcNmz0rIKw8ZmmMA+Abgqb
	k7aqpbJCizy8CbnC9JL/4F4nOBP2CRH9vmh3DDB8xgRtAIr2SeKQ4qANKSrbeAA8=
X-Gm-Gg: AR+sD12TywA1hb6G8u4w7X85vpBtsFaGyYKuA8gv6lARWBoM2orvQntQHrH0lKNVYbW
	zH86uYN3NrNFNl+CHYkHbxEi+BgrRY4zLHRz4JFCnWzy2h/y/HLDama6YX+RMzRPB8pp77X9SCE
	l0D1Zuln80SZGhmV+XE74CNCN+d3zQZHig+CyO0zkEIiKB/1hWylwdreG//4G/A8KA2Q8ogYIVK
	05EYSNNj3IzD4zRsSCi1rESdhQDRZIelrwX99g2v9J6F7Q/p/6E3nwSw+nzFFbuPlSjas9Rh8tj
	rgqXxqXaqHQHIf9lNepf+Wh9uN9mrwGVF46t2USgZeh4jov+wQiYl/SNQj/BdFSXIdel6OZGlyt
	Cnuc9OqCnSeKUZ3wwfGAutpnL
X-Received: by 2002:a05:620a:708a:b0:92e:5ef1:9072 with SMTP id af79cd13be357-9371e6a9beemr349782285a.2.1787148048879;
        Wed, 19 Aug 2026 07:00:48 -0700 (PDT)
X-Received: by 2002:a05:620a:708a:b0:92e:5ef1:9072 with SMTP id af79cd13be357-9371e6a9beemr349768485a.2.1787148047869;
        Wed, 19 Aug 2026 07:00:47 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4788e791dsm533593e87.65.2026.08.19.07.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 07:00:46 -0700 (PDT)
Message-ID: <09f10e30-f613-4a22-941c-1db63b190186@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 16:00:44 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Use GPIO to notify master of SPI
 target activity
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com,
        Krzysztof Kozlowski
 <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-0-e1c9e0dabbda@oss.qualcomm.com>
 <20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-2-e1c9e0dabbda@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-2-e1c9e0dabbda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gwwT4JDcXNDLqARLWdqNEmR4UX08oiy4
X-Authority-Analysis: v=2.4 cv=bth8wkai c=1 sm=1 tr=0 ts=6a85b712 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=OIFkiNoqZ7k2w5cL0_IA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: gwwT4JDcXNDLqARLWdqNEmR4UX08oiy4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwOSBTYWx0ZWRfX2xJErsnbrZdd
 rrCpts5Zc3H2Xrk/vEaincqLzqn/4pRPNqKKmAhtSyB4KLwR0gqTbjYSUcGpbUDs2Li7bXWAVwe
 LDw+ckGzyk5dwa7z/DLp4Yq6OAEhTN5xnNJpz6met0IDpdv4QxvyL//QnnWHFCmMijSDG7GMNcc
 Iq2V7My3utR7BmAmUL3avhGkpGB5GmfsPloFq1YuFyTmeGB2oqMqbmza+a3iyL/f0HbkmdDyCqE
 qUoWOpLnIK9Qz2mxIyMgZ9HnHyYZnR6UwpFwimNKdQMSSJ8sruHBhGYCUihPcnssMSHtOEy3CwQ
 YnKmKXMtsnSuUIn+pNeyDvQP/ZrNk5ktMTdYCgsLIcl1OsxAwVc4bJtHCeyGJh0JQ5hrYMzHhkD
 /XdqIkoioJ9yKAdp4viNUsj+WGg9gJjEQw51KX/x4JSNknhvGQJwfvU+1lr9qUtRC8hs3+aCyzp
 pGRmELhbubBU59QBgBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwOSBTYWx0ZWRfX/8efhJnwXCSV
 uRXCaLOBdKKw6FFX9uRsI+HCEOqp8G4HSV0pJkhYqAU1FIn7qO3gHko7VzJHTb6L3mLjJIKtJay
 RUfNnA6pp+AqTQJUPyx+UX0n9tDjEbQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190109

On 8/18/26 3:38 PM, Praveen Talari wrote:
> When operating in SPI target mode, the GENI controller relies on an
> external GPIO to notify the SPI master about the target's active state.
> 
> Add support for an optional ready GPIO that is asserted when a target
> transfer begins and deasserted when the transfer completes, is aborted,
> or hits a timeout. This allows the target to explicitly signal its
> availability to the master and ensures the GPIO is released in all error
> and completion paths, preventing the master from observing a stale or
> incorrect target-ready indication.

[...]

> +	if (spi->target && mas->target_gpio)
> +		gpiod_set_value(mas->target_gpio, 0);

FWIW it seems like the gpiod APIs can eat nullptrs

[...]

> @@ -1131,8 +1144,16 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	init_completion(&mas->rx_reset_done);
>  	spin_lock_init(&mas->lock);
>  
> -	if (spi->target)
> +	if (spi->target) {
>  		spi->target_abort = spi_geni_target_abort;
> +		mas->target_gpio = devm_gpiod_get_index_optional(dev, "ready", 0,
> +								 GPIOD_OUT_LOW);

Is there a reason for the get_index_ variant specifically?

i.e. why not just devm_gpiod_get_optional()?

Konrad
