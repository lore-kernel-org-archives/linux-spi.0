Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81048BD57
	for <linux-spi@vger.kernel.org>; Thu,  6 Aug 2026 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040148; cv=none; b=if4+Ev/DFNnPh1t4QUUETGdygmU/N57+dCLjor5KvwgdueVavFXvzNe4ZfZSu9xJ61VEhKHsCLEutgOvNYxZZF55U8wIZ2K73by2Vfe4JAGA63qig1Jnvsig9iATltOLLBPyOHVpf1YQCc28qx1eyHofuUfFDkbhpoMEnOS0HEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040148; c=relaxed/simple;
	bh=QLD2yamtBTT01mmMIBqZSbaKauRTUXhhITcVluZWuOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYEPlWhKAewuRLaa9NDuuINwxF0jUgPgkD16gK4fLS56spfo5WKtPGU7TPVQqEXuHklB9e9GzRVGBKn/zEGZYdSMIgsq64CxJsw5R7r9uS2eSY91KzYppaKsnJtbrwxZ1Z/Xn4lWuiM3zU0EgmsWuDMAxSW4yWhLDA7+Wc4BsR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WN4eKVk5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hjN2y8dW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WN4eKVk5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hjN2y8dW"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676I1hfd3252833
	for <linux-spi@vger.kernel.org>; Thu, 6 Aug 2026 18:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+92Af+tfpb+HXUrkG7jzilYoIyo/FgNcZb8HcmlYTR0=; b=WN4eKVk5zGEUI+9m
	OLqDLGMWFyTHdQrseD0iHC3vVe+4hZakp2AXrHNLx5dIs4mGoB51dWgCm7uk58Xy
	3uwmQGvmkOilk4J5tCXR5jZQh9t6wu/ekpdLdwex0Fs8ZGzR1VIFtQJkx+8hednv
	KXCM2D97Gf8bghcH6jtWqT1bcpoo6qDGbQ6PSYtLb7ylN64fPB6cYXyQyIO9JEdH
	5i53wqZVplaPiqOxdsDsgZOpB3903EZLKRk3Bm9+eKn6fggfSxR2WFOaBuBQ8ZSh
	+qj86eMTgOAUsWk/yddP2fVu2rf3M1IGsBDSiaKUjXxCDsnAZ6GAxfjqa5eIn0uN
	PUMqgw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6h82bm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 18:15:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848568a6f62so4206203b3a.0
        for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786040143; x=1786644943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+92Af+tfpb+HXUrkG7jzilYoIyo/FgNcZb8HcmlYTR0=;
        b=hjN2y8dW8f64Y4Ef/I2WtBkdN0e9YbXpq5NbwKHqykCJJkWsDjc5gtdQUEEAXEwTOm
         p7yrR3+JOVyFgP8aNG2bIEY9G305DTusEGhybwF/7S70h2D1QzOd7vG8CfL/e/PzaSxY
         Uu+2ilk1i3+xdz7CzQFe3I/zvw6jIEkbMlCrFV3lgorMI4aE/mlqJwQuRNHGnaHnVEGT
         7WtwXYRJ5aU3oeDQXzxBLiE/ku8ImoAfZ4iAXNc+TVIm7gPofV4AGkaMGhdYn0mO6v2Z
         9xVHfp64fAAmggFuCL6FxYL7rhM3uJgLRtw7jNbsMWIanxeTA0zfPyboYiMmjTToqla2
         8TJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786040143; x=1786644943;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+92Af+tfpb+HXUrkG7jzilYoIyo/FgNcZb8HcmlYTR0=;
        b=ezz3nKEoCrCgHEyRbkeX5xPUbonmU1khyOrAbICetKn27tDZJk+UVZFqRc64bX3Ord
         W8WPwnXjeL3zfC2wry72jQHaNL0iGGGS0sMWk2djIiguOzlpA7b8AE7Qzjy8kCknS2my
         IWMlUKTA59jc6mXnF7RFCyTDEfDHBWC5L18PagijjBJAejyeYKlt/S2myURBASln8Kbc
         kgeK/TsBvYp3/2AkKxWuTGfEJc9Cq0GmUzhwv5EcUd1SLS1DyicsCwS+1+p9MNmazk2V
         xiX7Q9nvXLoQId3hTCs93D0bVoeJXhkrpzidxoub+9XjAJB5sUUWGNsqf+ZXT5AJTshJ
         juwg==
X-Forwarded-Encrypted: i=1; AHgh+RoAskysRv9tXO88MGVQzJEim2VzzIo3xiQFe4msLuXEmnmVMooMhU7RG/CG0AIvuPuRcolPgkwcJz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznwxDPZoXjvF2VsuE73nwrZLELFY50FZ3DL/NYFnH5VGilLD33
	VKyyccRC3Ob/8g3lm3H3tXIwKamkdxpviiaolLEsSRLd5sue5YmWpmlg/j39ToQvzKXR04oEhdh
	jvBG8wSNNJIDrdvXAr0DihckGDaHbBvX8PjnXNivw9KR8FQxhtedzR2PqGQZtb+M=
X-Gm-Gg: AR+sD13sZOjD2uOZ6Virzvh7hS1fHtJ2rUs7i2r95p4hEJk5AA58w3jHB/IiTfuTssp
	yCV/rDFAJKx/3UKnY19DO2Gs4Xcy5qNiS4LIrRmejx81PC7GjPu2VYNFDFJarDd5kNBCc6Je9kp
	X6QOtPMU4SnEwGiDBIN3vW6ut+KgbQNjkx3JrF27B8nnJwnZNzX1Nl26Jg5IvFQ+0jNNL4fSUEM
	EzhB17klzKq/uKYVPmfbGtJXiIBa+BkHw153xAeE/GfKpqPeqVm2Ha1ZhHSSNRuv8jRR0wWtowe
	Urmy8XyVbFYmmw5rHtGc2ZaiWswsDeW79iIYNG2oMV8s8k31mwBQnc4+mXqoqzlaWnVN3F0pf3S
	1MxhGSJ2kOzW9mm1saT+FqJ/01WlIGyHdIQ==
X-Received: by 2002:a05:6a00:3393:b0:848:2ab3:ddeb with SMTP id d2e1a72fcca58-84f2dfc8f8emr20328151b3a.14.1786040142857;
        Thu, 06 Aug 2026 11:15:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:3393:b0:848:2ab3:ddeb with SMTP id d2e1a72fcca58-84f2dfc8f8emr20328068b3a.14.1786040142302;
        Thu, 06 Aug 2026 11:15:42 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.231.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f459ba2b9sm1829259b3a.48.2026.08.06.11.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 11:15:41 -0700 (PDT)
Message-ID: <8cbd912e-0f50-4fa9-b534-7ce1a3c77d88@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 23:45:36 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: spi: qcom-geni: Document device-gpios
 property
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com,
        Krzysztof Kozlowski
 <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com>
 <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-1-c363a9b5df69@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-1-c363a9b5df69@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G60s1dk5 c=1 sm=1 tr=0 ts=6a74cf52 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=uB10XSru4U0CyR2DWkO06w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=NXe-hbaaH1PFlVkP-uwA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: PtDFf1g_GEa5TJOETg1FWFEIpH-W_8oh
X-Proofpoint-ORIG-GUID: PtDFf1g_GEa5TJOETg1FWFEIpH-W_8oh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0MiBTYWx0ZWRfX8SoO0woHVO+S
 5biPqzEECN+pXi7sHeiW+EKxpKdguIM+xO+Caj3q6sZKkbW92YFVWJHdLD0e701mVuRbnFau/1G
 i4BzyRRT+9tH0hq8/WHY1r0HJok9Jb8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0MiBTYWx0ZWRfXyl97+GPVDCjH
 nBft1WqX9mwUt0EzTKNV+Zg5DmNUmtmgkHDqlT+ol1U2hhanPVu3uykka7zEFHQvsDPWduhSuC/
 HIzKf7aouG1kL3C6ZBWE5/Ic/kX3TPOSav8a9W92E7hi/bKlq1PLLTJKtQWX0HV94FgGDLJo0dE
 GspbmvnyyVKuWgvUrIWlSdZvz5YvN/d5ELUf3/GQsZ5B6rBJQgpZomBwUCt58T1JoRcfaJQqzF3
 gYCy8DVtaPDNUcqE/34+M19xm87Szd6FECM9iPin9mr0kGQT+EUbny2BAuXr3gahSEM0R6IdPKT
 tdTYEcbHf1M/hkCD2aBzM1NbljvXVpqpQXeWaZhKAj0Sgxgoq0uzsKeooIJxHOQQtriqyfVaG7I
 10tMTa2wLCgkxaSvuBSUakjCQs+AedhDNar3Xn+08EzKQtW9BticpcLq/8GT6pY/HY+L1h/d8rI
 SDOwX9lgZbMbvKD0jbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060142



On 8/6/2026 3:43 PM, Praveen Talari wrote:
> When operating in SPI target (slave) mode, the GENI SPI controller can
> use an external GPIO to notify the SPI master about the target's
> active state.
> 

Is this active state meaning target is in ready state to communicate 
with master controller ?

When will it set this gpio ? can you describe little ?

> Document the optional device-gpios property for the qcom,spi-geni-qcom
seems bit generic name, it should describe the signal purpose, not the 
device. Something like handshake-gpios OR ready-gpios ?
> and qcom,sa8255p-geni-spi bindings, restricted to spi-slave nodes.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml | 9 +++++++++
>   Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml    | 9 +++++++++
>   2 files changed, 18 insertions(+)

[...]
