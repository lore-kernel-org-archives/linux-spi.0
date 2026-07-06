Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132D3F88BE
	for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2026 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336492; cv=none; b=LSCFwV9ky8wvmNxIs7aQq/DUPNrIltFKhotVcaWnUhdv3lQ2LDkz7EfnGZhv3eKQzTuAe8T0aTuBRwg16iPsWQjhIaB6lQktPxoBz6vzd8qY/eCMXZQl7DOWNuONJfzgQc+RQ7e/v0LgaJYssA332/l4S89awdai7CYaOanNRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336492; c=relaxed/simple;
	bh=pldE5CZLBTXY06Pv8lOXvJTCcU5SIy9g4xy5SdPwp88=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZqqTdMuK1BOXWThqJyHa/9Ja/zevfo/sUZbOJdNXNfLqn/5gPJ+TcfKgNzj4XoJcmR+Z/nr4ad7ECgNuZXin44jT+rZdJVrMjJNeVhFDJMwsRpjVrk0S+KyjNiRxYx8M9EEPtceEHzNUfAXJtqD9UPlgKXo229YekK5ZIFRSnGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CPs5WGtm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I/Oi8AYh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CPs5WGtm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I/Oi8AYh"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxPEg369534
	for <linux-spi@vger.kernel.org>; Mon, 6 Jul 2026 11:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SmFemL0KIIfwmXMSiboiFKmy50w+ZsTOV5sITG6jZnU=; b=CPs5WGtmsOa/TuTP
	9g943atZbLy6V7FNU0IDjAiOLDtbzgjsBbtkvuB7pYTkF/Tcnp3bYaQAhYP78v6A
	b7ZKY3UeGepRMAaL+SYQ2BiPKgiqoB7C3TuT3BymdlWZfkqd0EAW9c3kEpr4d74p
	jaZ1qyCrKBYfZLXgeTXzehoexy6f8WFe2CLNryfMXVKj4eokBWGsDPvCi+wAcaEB
	Jil61pqnStfHsEB0H+3tBZb5fde9AhSlJpIhzBsvPBq0xv3ETEL4Qdy7Nka5cEVH
	g/ocE+rj3tev0R63C7O9n4wUSEiAi1LqoJktdpT3zw5TGdMJ6AZ9j+M0WPepQ3qm
	SHrNrA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h98rrf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 11:14:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915f6ff639aso530097585a.1
        for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783336490; x=1783941290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SmFemL0KIIfwmXMSiboiFKmy50w+ZsTOV5sITG6jZnU=;
        b=I/Oi8AYh/oy5D/inCto3FC9rI1CUq9FXD6qa5atZ1R0IcKolyn1+2E/KF9Ma+flv/a
         ssFydzDhHFz0pBg3rry0yhqafYrjjpUW+Ou+3HXmhVmRlGtdArP/J2Kvmtlwlvyyt8GC
         f0RPxazkE1I/lLV9mN+GrMaeDXtm7K32N/dwD4Bl+MHKY2qAaJ4gAYLaGvIEeBB5EhWq
         IxyLgLUu9QTW/iaAvJKOnCHLe7cys3nvSH2EjDjksVTLmPCEw88tG60VkmNp9yjue+FD
         8sAZuH7ZJ4vJnDrXraRnKxSCNDc20xfPe1TVMqEqfprtAzxi8h/3sN8kJAfR6vHA6mVs
         plEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336490; x=1783941290;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmFemL0KIIfwmXMSiboiFKmy50w+ZsTOV5sITG6jZnU=;
        b=qzZJEasF20aGi8MPEF87kVyjApuQg9FBSF+Ab29/JDH1Ig2pZeJyKzEvshs3sU8jzm
         qe1vKcC9shkk8XsNdVoMYLxDsVRyN+wwVC3SJz31nxyiHxdtSQQUi1D5/ctH+0oIt2F3
         tyTbVtiximDCQNCjf61LUGPWmrBgKV80cfgrIwdxteFf71Z/fYjoHHpipnWNIKcSu1mP
         gKpXrvZPvuXtA481qkQw/7NxpSjQpmouV2T4BD0fWCh/MdRoTQxMDwSDtQFSWihGfYQI
         Hy29LkXz5OEwTBQUnCSCOl5y+qFuTwY4+sWbBCBZu+K6fJrTYKUALjL3L3Gx4dqg+U2W
         cfJw==
X-Forwarded-Encrypted: i=1; AHgh+RrLu76VStcAVJ+xcE/bpJ50dzXC8fJCk1zrsCNoDsiMRQemRpEUBvzndU/FNLH0EwdNpb0c+hqnWBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/lEnN+/8zVsXXBaIsg1aL4S4/5lixMR2+D8a+0AjnAoL+Cux
	cQ/nRx58wM4BodmNRcQRONI60nlZ7Z1yA9wE5b5HzJh76XBvQ7LMw0WPLuGgHe/65MDIEKPXuFC
	Sqmx3Gb0IiR+ZfYH+HumDw1t9Gkb+EVPtv9fUYisisXtUe9hNB11+wZ0GYXjFFug=
X-Gm-Gg: AfdE7cn51uHlU+djpsxr8khb3aR28IzPhStrjJribD6KaHBN7qXr1I1m0DvML2WREJG
	ylx0rlGIQP/gXIjYnByua+gvWPOFNwgiKdbHK7t2wtZtHCc6UwpJ7se65+2nZWfpw+WQHFnFuL7
	2y/lEJItKSJndJMvCc2tfJgE1AyFiQqCeoxg1oFhH0T82EFTz4x8tcC37sUqLENALQz1w+AEmBQ
	BAlmWTlj6mR3XtFt4hQtcvq+L+gKVnOqhQJW4/DA0HHa//0pSfRY3F12cEDkIGcj1ceyFbNzP0v
	5otw67WbSuIAtWX7f3EmEZrhY3vHKb9X9dh/Rnv9Z1JmsuOW2a140MFAzd0hjiW/WIwujm/gIoo
	ElcLjsfmZFAb4DnGYfXZqfos11abiclAKyyysBu1L
X-Received: by 2002:a05:620a:2714:b0:92e:78cd:13f with SMTP id af79cd13be357-92ebb50944emr10933685a.33.1783336489770;
        Mon, 06 Jul 2026 04:14:49 -0700 (PDT)
X-Received: by 2002:a05:620a:2714:b0:92e:78cd:13f with SMTP id af79cd13be357-92ebb50944emr10930585a.33.1783336489368;
        Mon, 06 Jul 2026 04:14:49 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm21725161f8f.31.2026.07.06.04.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 04:14:48 -0700 (PDT)
Message-ID: <b795c8f6-f0a2-485f-a331-22078b002826@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:14:46 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] spi: atmel-quadspi: Simplify probe() with local 'dev'
 variable
To: Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260705172737.120095-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20260706-plunder-fencing-b9ca15ef05ae@thorsis.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260706-plunder-fencing-b9ca15ef05ae@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: woisxb7nhVDYmVL31wojE1akjf-lY2ke
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfXzhGgdig9vum7
 kkzJMy9j6DFdNJmK8mKt5EqnhZ0QRShwzfOVof2JlYq6Q8EeWsZXuHcufYjJBn9kwgS0qc2WYNq
 6wvmZrgm7HeMR3LaBvxdan121dVLjzM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfXxguj26WdF+Xt
 7sDSQUnM5CKjIwyyn8ot/oowNreKUZ6XJhR+tZsQCw66jSQ0zjm/rxwq9K6ijmS5i9odguJjAwP
 CE0i3Tuq8hu9cg1SuO358SLWsnJ+9zcOZZHW0gIJHdCb8XgpCTWo7/SQ1vINEbpTWGvwsNqAKy6
 YcKCpWgvszVd8iltVgIK01O4p8z9mDu2z49ib4sW37jDZYd+DNodqf/hCKufKX1zxLAnmF0rUJ9
 cdqUVLeZewF/xtkvs1EUuodfNa6/LnHnIUkmwiLZ0ZlCGpWdnx+k/BMKcZRWJUvzMYWDqBQAspO
 R9g63DWYgMc2SXcP/y42ZeeVLR01Q29z4+tgrdXjszLStrMNDhRIFxV+7WaON14Rsn65YFnrQ5q
 xu6ZA6TjPd5liBT3cCkAPikHp2Y8ULSvgyZ9M6b8+mRgMdVWi8LH01cwZQlVZZhPBP55lDBYaLU
 vZQAnuxIL+0v9p6aCng==
X-Proofpoint-GUID: woisxb7nhVDYmVL31wojE1akjf-lY2ke
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4b8e2a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=G27ZhN6lH2JbNpaoIAoA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060113

On 06/07/2026 12:58, Alexander Dahl wrote:
> Hello Krzysztof,
> 
> I think you missed some.  At least the two outlined below, but maybe
> more which are not part of the lines covered by the patch?

Next one does it, no need to change the same line twice.

Best regards,
Krzysztof
