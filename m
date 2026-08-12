Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0863191BA
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513605; cv=none; b=dG2W1/a5w9ceBcMPGPp01TnwrR/ZXAqBBf3ganufQEHJCzAnUO281TYTGFdHOWZmAyBtrarAvH2bs42ML/Q5zoytTICt/b1e8yzDbA4Xzn0WrSRGOfxUzFs59yqiUtOGnRlbl9m5xD/7+WfVEy+jjpS8iWKPzZTq9/VCaENa7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513605; c=relaxed/simple;
	bh=NS8vk08ZDdbMm9k/jRmagXJTF//VZNaWWpx1yMIUGLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEPoaE6FD7k/v3v6PyRzwhfCw+FtBEd6twApqW2qNWdcYmX6rFwrti/pu4B23FPUcp+ab6z6xk92HeecP5xAvkEs1xNitttOBoWYrlBi4RZu1aMPiEusjyf/H1SUylF3sWN1X+2h8tfWYu76sZWN4JSqqpNPBiHt5ogBzvahqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PssAq2WZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lj9iqCWA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PssAq2WZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lj9iqCWA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C5iAVG2604859
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 05:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k79W5VytlE22NwXQ2D0SB5fCnUEmPnGZW3S60sW/g/0=; b=PssAq2WZHZvQbKSB
	R8LhQy7O4XrTOn0ad7u8AGoD6sRKmfOpiTH6HT+wr60i815CSQCbqRFKZVER/CTe
	rC2b30QLsDTHedA0rTPzqfiRgR3Kepsk60Ju9t6kVrOcdenTuf+4JC7vh94G3cn9
	GVhspJ3Xf8sAMeZSy5ZziOnVsnvhWujTMzf7AsFkj773CzXuqLhVO/S6vOk6FFn5
	VUYYHc9aOdOVwsJ1LHVZzkm8Lc/q9fqn2cjo+d2MZftQKDivwcSpYlK+ZzNN9fXJ
	09YzU0MH0fkCRTJ0IJao9IUInF1p5PlItXYxmthJKClF6iPG94LIWjIoEmGta5JZ
	13xAKA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049kkpq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 05:46:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so815143a91.0
        for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 22:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786513602; x=1787118402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k79W5VytlE22NwXQ2D0SB5fCnUEmPnGZW3S60sW/g/0=;
        b=Lj9iqCWAPtyz7tiSBjwnb2L9RxDEgyIzP0XD608XKNAQ/Y2t2l3JV6+ZcnS+bI8nnZ
         Xu1Fhp/UksSpVkYgDc3BBFCvRJ605KseNefctO6zN+p1A5nh11NZCvKxXCjuU7dyr279
         3S7WLGqDHSzHGpk+Y2TmyKEYghPTiGxc2dMOCyH1ozO0eyZSY2Nqe4XrfrY/KDDJx3PT
         HVWtkT5D7kIPF8GKbetgy4AfpM2i+Dk+yOPqRCyUr7t20F7A7+sGEPX7PPKpRUK7o4pp
         fqt3g4NmHcGVh2WI+CH07ZajzWALHeK+cwLXVA/gBd+WctldTQcgpsQ3DBP3nviR4zsB
         MYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786513602; x=1787118402;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k79W5VytlE22NwXQ2D0SB5fCnUEmPnGZW3S60sW/g/0=;
        b=lMvRx3FbtrLZzLxjKJvVj195ydn89w7OXRemNHYbee3Qc8ockljPDAyt2+yHjJQjB9
         19Qmb+2LkOugBcy+svlp4rMw9XDtwYJ51h9AdIX076/v1h/2YZcWwnphKByKlk1hAuGB
         DJh0JdwPOG9lMrY/PgBFnZlOcVvu+ZyzSooGLhXs8EbiQTns8jsjfFAY1LiUEu+SGgde
         HEJMMjdsvbw7Xjr3a8o7Oi6gw9LERv1Vl/lMBYR1w/rirA9YXTQpAK3yr+Q0EHRkMj+T
         j7oq0JtnrqgsSsVN23Vw55dPk2ebwkgeaV/nwA/D2s21NbUkMAYRCnlvAE46RSmtEwBT
         wS4A==
X-Forwarded-Encrypted: i=1; AHgh+Rpi/JUHNhacYjKlVSzJwftnA6tTbR0ye9hG8HtSaDXtdo+AA+EhxJ7NiG0xdA42CDsCNiBwg0CTQEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSD1DtTPspjWQYQ3eQ6E+pVBKZWo6ofvzIVuoPT34UhJ9Rkyr
	VVb04rt9wksKgjQC4N7KBgYA2jf/GB57PY4qjeEBhE21CGQV8+rWdWeQfpLtSBq+XCrXOSNp05T
	g+dqF0jHCzVuhZgX4OvnCuFcBMUCgY4M9st+FgQI51EbJDeFBHOTSxeGLDmV32dQ=
X-Gm-Gg: AR+sD13jSRfBICV8dKY4gWdL9B8Nrn0jOfmwF7ohH9zAxQKt7Y5xQV+Ru+/xXzYvHm7
	Ov9j5qugdY2la7SXvUpN6rcK0zMrSXMm9nXM1ND4ZtV2BIugf4BHZiiqmiE2SM6tZQ9oe7Dnzpp
	vTDZUrgEBS5Ey2LmLw4UMUwRbbNw3gqSlNnGqPneuMtKsOFxqV3J7/mXzanBKbXBmXJb+GYrsmv
	WzodqN0WcUZSNsyHDCQX9SriTsjWjC7IR2SNdRLrMrpNUplcm0a6JcNE0eZqXcuMxyM83RzyGms
	BpiiNMsNH9weNNLGK6hqSsl1zeX/Ldz1j/apWuNWAMDs65uv+le39jTGwcc7IhX2T9xKspvR5bE
	0v9Yv6mdZz6X0nbtspB+TyzEktwCWlEOpGQ==
X-Received: by 2002:a17:90b:3943:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-3930164d6f4mr2498723a91.14.1786513602146;
        Tue, 11 Aug 2026 22:46:42 -0700 (PDT)
X-Received: by 2002:a17:90b:3943:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-3930164d6f4mr2498676a91.14.1786513601574;
        Tue, 11 Aug 2026 22:46:41 -0700 (PDT)
Received: from [10.217.219.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8896c20sm2208498a91.1.2026.08.11.22.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 22:46:41 -0700 (PDT)
Message-ID: <3aaecc8e-6f08-4e69-a24f-f97926fe7079@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 11:16:37 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add panic notifier to suspend
 controller during panic
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com
References: <20260805-add-shutdown-and-panic-notifier-for-spi-v1-0-b5db170d491e@oss.qualcomm.com>
 <20260805-add-shutdown-and-panic-notifier-for-spi-v1-2-b5db170d491e@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-add-shutdown-and-panic-notifier-for-spi-v1-2-b5db170d491e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: C7TOmjyXFUNkxTsuKYwdAHWPaRlL-vpE
X-Authority-Analysis: v=2.4 cv=IO4yzAvG c=1 sm=1 tr=0 ts=6a7c08c2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=vaKURzcQWfWGSkE7xxoA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0MyBTYWx0ZWRfXxPVtZ6LNXRt3
 b1Qu/0uWTEwWgIt4ck2oAs+lM9OzCaQe9377LQrL9loqkdu9hv85TQM5FbH5jw8VOQdCQ5cGjwR
 Aj7D00mZJLbfZw5n93il/N0F8FD5EN5k7rcsCE/k6qtBcukWSLGnC5ujHVBeEPRduWi4IELVTFa
 6nOQHuZumCSnCNfGy0en0Fw4NUzSu2Rjb8ZywOo97hIguKbxQu1bjmIyHGHAHhs7CPesGwWWe92
 TkiNpSXe7bNyVUWimn+37dD3CmPd+P7HD7LesbT056nnCxF/S62V8vAEv3Qlk8bLt2Tk7MyaITD
 vkraXXnn0EGe+QVYHt9x9CRQ3GjHJyt0r8FXu0ave71Nhj8BCkzAqqKitKK1mAMf6zPaLJ9exFZ
 uRGyUGEwSsTt1lCN0hO9S/gjjSb5m+WKfOtgoi74roVBKz+NbyL43OnGvnMOWDjHE8GUh4wW2F2
 dXCJXYmSAcIJ7lzNTQw==
X-Proofpoint-GUID: C7TOmjyXFUNkxTsuKYwdAHWPaRlL-vpE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0MyBTYWx0ZWRfX7ENui2Bhgf+f
 M88YRrxgTsrQZnmB9uk+UIJw55GACrfELhFJs2dta9NbH+RsGlKjaoGFURru19fX49oENBVuRDz
 MsKGVkuh3h/8/kTmepj+VV4q02Wv3N0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120043



On 8/5/2026 4:12 PM, Praveen Talari wrote:

[...]
> @@ -1073,6 +1075,23 @@ static void spi_geni_shutdown(struct platform_device *pdev)
>   	spi_controller_suspend(spi);
>   }
>   
> +static int spi_geni_panic_notifier(struct notifier_block *nb,
> +				   unsigned long action, void *data)
> +{
> +	struct spi_geni_master *mas = container_of(nb, struct spi_geni_master, panic_nb);
> +	struct spi_controller *spi = dev_get_drvdata(mas->dev);
> +
> +	spi_controller_suspend(spi);

Add a line space before return

> +	return NOTIFY_OK;
> +}
> +
> +static void spi_geni_unregister_notifiers(void *data)
> +{
> +	struct spi_geni_master *mas = data;
> +
> +	atomic_notifier_chain_unregister(&panic_notifier_list, &mas->panic_nb);
> +}
> +
>   static int spi_geni_probe(struct platform_device *pdev)
>   {
>   	int ret, irq;
> @@ -1161,7 +1180,16 @@ static int spi_geni_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	return devm_spi_register_controller(dev, spi);
> +	ret = devm_spi_register_controller(dev, spi);
> +	if (ret)
Can you add a trace log here and below where ever you get error ?
Hope that will help in case of issue.
> +		return ret;
> +
> +	mas->panic_nb.notifier_call = spi_geni_panic_notifier;
> +	ret = atomic_notifier_chain_register(&panic_notifier_list, &mas->panic_nb);
> +	if (ret)
same here, add trace log
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, spi_geni_unregister_notifiers, mas);
>   }
>   
>   static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
> 

