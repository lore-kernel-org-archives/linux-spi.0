Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000C272E53
	for <linux-spi@vger.kernel.org>; Wed,  1 Jul 2026 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914587; cv=none; b=kgr6c8mLFHoLb3PNBFy7kCFADLodMFOTpPVrq3/UTVsBTwVld+CKqJXvQPvfSpYjf6gZ3xiC2iBdX48CTLG+obOL/5/WY8EBA1me/tooulfVRmSGJi4QZnjyb0NXxB6yqnJHSsh/lqxD8ZMB2rEhGgLK6Fuowpcx7HX2GjK7HqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914587; c=relaxed/simple;
	bh=NF44Jcy3ZEM2REPEE9g+v7xbiWG874cAQ/xirLdkdwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaa5W2QyS9DfUSNu8yNXB2uj7aaQsb2sjxp1CFHR3BuVHMGG/8tNHMQIOE1IqJz0+PlMM9gNAX61C1wM+8gALAOzr7eq7YNDjEyn1Vd4wLP4Ic7om2K8Z1pxEUuODSoxG3TZXpTGNw6HBU07waJ/nmD6Nioj0sguvtAff7Q1o/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZNtmuHem; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VaTbgB34; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNtmuHem";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VaTbgB34"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8RiH761296
	for <linux-spi@vger.kernel.org>; Wed, 1 Jul 2026 14:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pJFraxmRhYUBByvs8pJiT6kFtV1EB40Zmi27aKul/MU=; b=ZNtmuHemfu5Cs/kF
	KBpVLI2VD1oH2/ZFM4FlLzoVvrc5FK80HTp/P5+avueVq79+tlQ/OUPOEZMd1HBQ
	jzY73OS05wkXE6RgrTHSptEUh2knH9K5V0xLIgkS1sQPCOP4OmZM96RLdP6cWCgQ
	xM1wsz9fMuP9mfBBnIT11fernNxn/bZGQGQkJeshjriR+gA/t6V9s7U4pceiuKlD
	JUk73pdrr4M3EyoEkGZ9jS0VMYPst5hjjQiq4IN5HHKo+TxezXE68assXcDIMhgR
	3V0MDSqbYP78r1zJVVy/n5lk0FDJm3GaHqanFh+xrh0JawKCV/VpCzYYJNM823pp
	zDVRww==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw4ea5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 01 Jul 2026 14:03:05 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-664c75f3961so1602032d50.3
        for <linux-spi@vger.kernel.org>; Wed, 01 Jul 2026 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782914585; x=1783519385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJFraxmRhYUBByvs8pJiT6kFtV1EB40Zmi27aKul/MU=;
        b=VaTbgB34kNG4g2qY1c6v2FUDnS7uhKRMyAd8eJVM6USnTY58xSzKCM4cDH36AjwLn2
         ExNql1Hp7CJEzjRw42ltapKo4nQoEoCHwrcEzpq77RgRaI4HbKIeQAVInlgdLYfdEpHe
         idI0wQuK9PfNya+ibNba79tgQqM1/yaERrM2e3UnYmtE+Z/pSiqqOUUhkOtYYCruuJYb
         L5aU3CK8VyTMAE+swAG77g7ZUTX6/Y7sqrLwV5P1pAZuX5nIyna27w3O/C1yrP6qIG9e
         +Z4xXK3ddwg9gMcLmeAFAIABXX+RGouQSTak7H8nuGlli5bRY3AC8IjKsAsBxvvJnm8B
         fTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782914585; x=1783519385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJFraxmRhYUBByvs8pJiT6kFtV1EB40Zmi27aKul/MU=;
        b=ozhApRdsz3VaVE32M4RXw311hkqY6GZaRJXARcVFEzmo9+QGa0mgEJiLxvMZaW+bbf
         gjP5ugiJvEJDWHT13wHjj2dh3wgdZuLgNH2mHJXqecCqJ9LIf0ER2u4JvQ2UurRCHuB1
         rX4JKhGirkvcfTUL6/5k8ZtjuER1bPGTW5paonXadZ9vzLjzyLotdqlFm+bqOJbnaORF
         Jl+wtl2xzI3umL7UmwPey0NU58WJ4XKCCeRtpr8HRf6QdW8pDBMINwvl4jYb0kbfx8N2
         gARWhpmjD88lH7K5idsoVwVnBBDHigPnuUMtlX9Bzz/wzsSfnNr3hkQcBI/c/KAfNkQc
         ggdw==
X-Gm-Message-State: AOJu0Yxpar3wGCCJ6z7lRMhHZ/mkRXOzwssfFqTjJ9qSN0015+R779gQ
	sTAGhH9iEAZg8kCDNH3A6PfnzutJn+eAPqscDekoZ7fg+n7gI5qG51rojOH3mT3eHbkwUzCTDhh
	38MrpWgsq3AMeQOzGgw50l4VfeegPYfUkIIgbGiU/3n07gWmJBOjuR6Pkim1jVr4=
X-Gm-Gg: AfdE7cmBfconx0vVkm8W9GiWnKrcKNJnhiMUIYwiL4ZCPkjRy7eHNdmnCjqzbiFlrVC
	bnxfruZfZUstotPoBhEa1dUFqE5GOuDk4GkXQhRPrneQTs/wTBy0eGXfF2qFM1xDw+XerjPnaNQ
	9X5UXc6gBMs5vvoWU297mA39V7OOK6nfKht0e6aBGRGfjo6cNihReV94uYO0j1kDq/obmNqshPG
	tC1sfjN6T2c6Fop+ZmSOz23A1FPqMVjx48X/RRcBSFeaPE6qPk2KJqwX+RxQ+MHqrm5K1bIAU3X
	ND7k6RWH50RIXtR8ARngxukFdRhMfLKvVIX4oULdzmgT3YBSH8yMLIXSUWJv4i+Nn6cZgKVZJZH
	64vUGghPSo3uZkVjhShETYIMBhA4tfe8f/d8+4+xF2dGjrrlnhUG/T6F1Ig9D9KnubgoS40+kmk
	34CmZJmQE=
X-Received: by 2002:a05:690e:441c:b0:664:ae6d:ad2c with SMTP id 956f58d0204a3-66521d0fba4mr1467511d50.70.1782914584565;
        Wed, 01 Jul 2026 07:03:04 -0700 (PDT)
X-Received: by 2002:a05:690e:441c:b0:664:ae6d:ad2c with SMTP id 956f58d0204a3-66521d0fba4mr1467320d50.70.1782914582494;
        Wed, 01 Jul 2026 07:03:02 -0700 (PDT)
Received: from ?IPV6:2401:4900:1cb5:7738:ad40:715c:2410:3e18? ([2401:4900:1cb5:7738:ad40:715c:2410:3e18])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66500677dd8sm2351665d50.7.2026.07.01.07.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 07:03:01 -0700 (PDT)
Message-ID: <48a525fe-9cf8-40d2-a712-f3e9db18533a@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 19:32:55 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: spi: geni-qcom: any planned QSPI support?
To: Carter <carterd1016@gmail.com>, praveen.talari@oss.qualcomm.com,
        broonie@kernel.org, andi.shyti@kernel.org
Cc: linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <CAJ+nLsRXTc=3LagGVdNiAPttL38tPVub_UOKuqJq91J9U0M+9w@mail.gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <CAJ+nLsRXTc=3LagGVdNiAPttL38tPVub_UOKuqJq91J9U0M+9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a451e19 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=Bkeujvi26ppXrdUSQWQA:9 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-ORIG-GUID: JEMK_AEeKpelo3Jj95KHQYiUkxl_LKsw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE0NyBTYWx0ZWRfX6xvqBjqvh5Ph
 wgaTD6GfjWeg3LmM7oxhOSr7syPNJiW4HRw1TzSwscDDj9Bho1fvYkyjhAnrCbfRI+jYBIo+Z9k
 4cVWaiWYpgNGJa84vzLcqpEnRYdBGWc=
X-Proofpoint-GUID: JEMK_AEeKpelo3Jj95KHQYiUkxl_LKsw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE0NyBTYWx0ZWRfX+BuHZQyCNseG
 ofejSdYOsOkhV89Z6bxtFdyN+KtRqz7Z1VQgJ/ATBcy5agBaeWpTKDh6xFD4Admb306G6y7NA8p
 IADf0PP5hCbGdMPiLR1S5OQMHxV4O8qTDIbSi7jQJXlYW2hv+xYde4vicMG9M2zK+NEdshdWLHL
 3usSV1nC622yyDM9JlK5XP2E07pkAmpd+EVlKoOWWW6C18GD374zbww10LXDNTH+7YoibhSglOy
 rbURzqILwAQmU++WI7bgVKqhGuzYyKauTsex4R+9qv2wFqy8oRG/69IQ6arDUypjnkPaXO8uTdD
 T40Dxuza8YohnM7FuNhabjXgYERTfoBmOGYZ1VEwerZMpjZqc2O/q9CdiMQ3LtIg/ipYk9e4BZ6
 YBVdGkVUIIaaV/YznGKjLOzaFMuYlzE9G7ie9c0hB0Iy17FC4rlDpx4FiVVkvnFebOnscM7aP/0
 uOhAjxDCRvt+xWwLAHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010147

Hi Carter,

On 6/5/2026 10:13 AM, Carter wrote:
> I hope I've found myself in the correct location; I haven't ever
> officially participated in kernel shenanigans. I've been working on
> enabling the trackpad on a Surface Laptop 7 (x1e80100, "romulus"). The
> touchpad is an HID-over-SPI device (with a driver patched from
> https://lore.kernel.org/all/20260402-send-upstream-v3-0-6091c458d357@chromium.org/)
> hanging off a GENI QUP serial engine (spi19 / qup2_se3), but it
> requires QSPI transfers - the SE reports protocol 9 which is unknown
> to the mainline spi-geni-qcom driver.
> 
> I did find a patch for this driver online out of the linux-surface
> community which may have even gotten it from another source. The patch
> seems to work, however it is very low quality and I suspect it may
> have been vibe-coded. I wanted to ask: is there any active or planned
> work to add a QSPI mode to qcom,geni-spi controllers? I was unable to
> personally find any related patches or conversations on lore, but I
> may not have been searching in the right places.
> 
> If nothing exists, I'm happy to make an attempt myself. I worry about
> getting in the way of more important matters as this would be my first
> time submitting any patch work and I am bound to make mistakes, but I
> will attempt it where that is welcome.
> 
Thanks Carter ! Yes, we are working on this driver to upstream. It's in 
our plan.
> Thanks for any guidance,
> Carter Davis
> 

