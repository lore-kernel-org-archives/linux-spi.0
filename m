Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF827280A
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784426913; cv=none; b=IUm//DYvXJHgw8k8YC//v/IWaJp/1ZGvKOONtxUsVhggipC0fepdXUoEYYspfTaZiP4xQmrFTBmaP5i5u0/oh9U+gcjkx5FUkAQlSUMGFn8YB1D2qyeKKwfMGD79A5MePk4pHQ7/PfmJGFYu2sI78MQhsjKVik/n0kxg26X6dMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784426913; c=relaxed/simple;
	bh=kdWlN1B24Q6VKMAxP6/Hwzp7Jv1wwzj1dE9wrvjjOD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6X5UdLxOrtnI1oAWYFmlPg5OMAYQf5AdiCpBtDb+nr4A/oLkTsznOvjWwttcai1yOtc0NVUMWieD8s8D2HtjTNrO86fHmzo/UShia7AOHm7gctxQtDmx/bYUZl1ReDHzGpR9zaCighNu4dCjVQp9swm4V2vFeBtPue3cX28mhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZhSift6x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SuEjmOXP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZhSift6x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SuEjmOXP"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66J21WoM3423433
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 02:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v5PtlqNjcSs4unf7+PEYRQ0YSF7XRPuFYxXj3KTAnZ0=; b=ZhSift6xgUHC7KZx
	6POYZfXPYCDWHVfR5I5bqKmGTZ7Sp1vH1V0WdO2tsDjR2eaLKLRFrVmi94hpLnYl
	vN4jv/gLRFLSsaC6Hi2he/HBDcCPA8AqqypafbXl2C2Kws0vADtYN5R/KXsqTX+N
	iQqZoh938sulWp7SelMon+w86ZZvg/xJKkVKdRvqSjoRUws1Uh8QUj/sxA+LsNVS
	+01EPbbMOkgW7s8E2RD2Xyv5Tm0l8OuCiluCgQ3xdsgxgQlEVeXOXEyOHxB5747A
	R9EXTr2k0Clh00WQUgablkXswALaKRZr2udoWCZVFnPH069w5yBGlXKiWsQzy5ZH
	vZZj+A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2aaswv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 02:08:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cd01a14e81so130932225ad.1
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 19:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784426910; x=1785031710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v5PtlqNjcSs4unf7+PEYRQ0YSF7XRPuFYxXj3KTAnZ0=;
        b=SuEjmOXPL6t+jfwoX0OuVZZHXxyE5o3AnPb8HRiHhVwZLXCN6581LucCkDykrxp/Yc
         gnlax+gDwVkfZZqHZ2BOJ3nTPQDASrPSavSAqAJ98b+NR3X1dt8wI5IgH5LhOm6Kl+jV
         Y5WA31edUTSYtUoe9SkrZX1yxEU1w4ke2JPFlcCjibMDL/yMvbHf6ADOpNP2ratbqVzz
         UIsxkyz4pqh0h31yWnVoJ//Aefz3INWCAQ2Yjgne1WIKsPHYHpq2r+TmyM6E6qI858Of
         bAX/PIDNoapm1S3iqWJ0qDMFLzT4llKFg9IQfaIcy1ILEbgMVXTQ4/Pk/cHEQLQWyEDH
         8cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784426910; x=1785031710;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v5PtlqNjcSs4unf7+PEYRQ0YSF7XRPuFYxXj3KTAnZ0=;
        b=jsw+1YPGlIRh0Kfpd0Kohp9oaaEah72tnrFzAdluBkm1pxZ30ZIi111jTm5v91Nqw2
         GaYazrv6MAK+71rh9UMEBw12EV2RUUfssavcQ2O7Vm04P/0vh11yr9kAw2EcuqevimRg
         WdInBUtLDDLiLlaDluLYc7pAqzYc++TAYzAF+Wlgsrvq31HRERxvSw7RP3ZzBtj8n+p/
         XL5K5qPLeQN8zbdLk6LCeZp1y2do70GvRZdXDGBTdWBmYoOYAY7lNuurMW41YNtPP0dS
         vjxipwMfJuwRsVgT9h4GqpovQp9ldcnJETupcQC7An0wcJmnXcJ60SnKccM3x1FK86KU
         zCcw==
X-Forwarded-Encrypted: i=1; AHgh+RqXqf8lnkkFEdIEuByw761hVCdA2l9yYLfEqWkvUgA7vtAfDyUnckISI7VZ9MFU716pXPEeoodliVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpoM6l9wmB7oH5ZdV1RBZ8ICtNW+OuwFOZzyoOOLHiC819raJV
	oAk1zdlVSBRP8Sqwn4lIWXypm53XlACX+y1o8VOG/f5Tgui/okFb9yxU2m1yqxRZIXx5NN0z8Qv
	xzAcddYcUnNbvDa5KCEK6F2gqrdAXwFfZvotnNDrb2NF767VPbPspM464svwbs6Q=
X-Gm-Gg: AfdE7cne5pjjkDn6+JVZ8dh9MpXpEarCHffgirken9nXX9Sm97c6gBsRZMoFwdjLBHX
	LWKyAB55/Yxy7AJSnXKa6FwUw5/R1v8foXG7YQt3GPWh/8IXHCNzXqIL/2IJDhv5vbIIb+U2knV
	OADsGL7eaaKkgH32jtFJSZvAdP0veyN/DKfd/73T9aqRuD8eP1emcTcFhL+218gHvWe2Z9vK6ig
	OAAA4OOZMaRXrvhKh3eyKm9LClhYZ+MpeZhnaQsi7cy8PhD3D4vJdxI5dfrNdsQkBREx7uDFEK1
	r7NrVgnlXABvHVG3asHdE5tzz7Jf7KdpLCIFVc3KPT1gHMoetBonel0hCXrXujmgzT8Ogeufr+B
	eTWpg4hpnL+8lubqS
X-Received: by 2002:a17:902:dacb:b0:2ca:329:3da1 with SMTP id d9443c01a7336-2cf348abd80mr100376825ad.16.1784426909971;
        Sat, 18 Jul 2026 19:08:29 -0700 (PDT)
X-Received: by 2002:a17:902:dacb:b0:2ca:329:3da1 with SMTP id d9443c01a7336-2cf348abd80mr100376485ad.16.1784426909491;
        Sat, 18 Jul 2026 19:08:29 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3474100fsm34318815ad.66.2026.07.18.19.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 19:08:28 -0700 (PDT)
Date: Sun, 19 Jul 2026 03:08:23 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
 <Michael.Hennerich@analog.com>,
        "David Lechner" <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel
 <p.zabel@pengutronix.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan
 <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Marius
 Cristea <marius.cristea@microchip.com>,
        "Marcus Folkesson"
 <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, Janani Sunil
 <jan.sun97@gmail.com>,
        <linux-spi@vger.kernel.org>, Kent Gustavsson
 <nedo80@gmail.com>
Subject: Re: [PATCH v6 3/5] dt-bindings: iio: adc: microchip,mcp3911: Add
 spi-device-addr
Message-ID: <20260719030810.13a090e1@jic23-huawei>
In-Reply-To: <20260715-ad5529r-driver-v6-3-cfdf8b9f5ee3@analog.com>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
	<20260715-ad5529r-driver-v6-3-cfdf8b9f5ee3@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ctbuin9M7kycyexwTa7EKJZzrskPP0vR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAxNyBTYWx0ZWRfXwgvglh7JRs1F
 07bqa5K6d3t7VGZBdVBYPKw37EoRgin7j/wJIGTW+kK1Qlbx/G/LCXZCJwhpR2bxpnbG7keS6fi
 JjxwpINQuiIiCuvLn+ffzoN7LaaDrg8=
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a5c319e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=gAnH3GRIAAAA:8 a=279Z2W4kbCX7q3JdIJsA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: ctbuin9M7kycyexwTa7EKJZzrskPP0vR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAxNyBTYWx0ZWRfX0X7VocwdIaae
 NM7Pf2amG9njFWQq0kwg+3KO44mHny6UhG0V3f4C27cP/0XDwu1f7sTUK1akdZIOMXWV1V1bEch
 F3njnQud9DqaPbrJGL39Mm/jzDHnT9OpmrkBu5DEZWS2gI3EpTkXEsQQUhgmqQwfn4WgWCvPNm2
 EmM/5q3YqT3taXuqCJaugNNzNJ91xNEmLGfD5jUc/iCF3tjnmlKsH+fjDHQtpdmm+JSHKuVL5+j
 ACJ9uZYYzeFgRnLKzla6ggeqxDktDn1BeqThE2i6rComaD5PxF69Zyh5I6rYtIojyr1TXab6tl7
 pvbBBbc0pqqrCy/JqKnY8ax7PF+j8Tr7PyKC+z7gJxAZyEi7trYnVJtG5SXEKptfhNn82u1trNF
 w7jc6cpZxn6sR8ioAmJT6PUQAv4+ju8xRHE5rQh+w4+b1dpsHwsDHIvRQP0Pev+XzgzaNIBvLRg
 RiztXumPkTaa/4BIudA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190017

On Wed, 15 Jul 2026 13:41:06 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add the generic spi-device-addr property to the binding and deprecate
> the existing vendor specific microchip,device-addr property
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> index 3a69ec60edb9..4a60df06bd35 100644
> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> @@ -57,6 +57,12 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [0, 1, 2, 3]
>      default: 0
> +    deprecated: true
> +
> +  spi-device-addr:
> +    maxItems: 1
> +    items:
> +      enum: [0, 1, 2, 3]
Needs to carry the default as the old binding did.

>  
>    vref-supply:
>      description: |
> @@ -86,7 +92,7 @@ examples:
>          interrupts = <15 2>;
>          reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
>          spi-max-frequency = <20000000>;
> -        microchip,device-addr = <0>;
> +        spi-device-addr = <0>;
>          vref-supply = <&vref_reg>;
>          clocks = <&xtal>;
>        };
> 

