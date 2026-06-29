Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A92C324C
	for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782711363; cv=none; b=JAta7m/vcwqJ5wFze99AT79q63PzOLiWPVgUAEBeKskpXAobqY+wsVexO91SmbfWvDefIgtt2xqj1gxKRH4zg5eFJ7v44bBQL9MIiFqZRJ4TG0rgf3V3njRkzoGVjlM62QXDknNcDYg8gmZaI6T8ivGvO9RQ2BJaCuHYWmxrOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782711363; c=relaxed/simple;
	bh=tv1mZI4KEvM2V8q6plCcGch8qL3k2C6y7tULqw8J7NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpD4Y6nEJD0zEUudLfPLDrqaR+PPRqEfOuQ71qkgUtjS+yKYymH+xMJBF0xr0QD1QcqoGIURT75/XKROhyzmVOB1sSKUcxnM4AxG46jMcP0PhB+qgN8Haw8FE1SkcJMNsjMaSJ7+lIsSa6Qf+MyDMgyOjn/YkuCZrbZhPSzfAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kms/lHB3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dHIzXJnm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kms/lHB3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dHIzXJnm"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NF011729613
	for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 05:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Yi4ev90l3hg9+EhL4WZIfvzByHsix7quj5Oa7F0Z58=; b=Kms/lHB3pUrNLcfM
	J2ms+8hjVuXdP9L6K9Srf2a2odC1kMIPxInyu99OMG7MDzvq6AWT/AJygP7xcjio
	4mToFebGXAv2ls1ea4wB2FCUgQDaQAjb+V4EfMF4KYih/MmzpNziyTqByALnW7d2
	dRaFomFa65n6U2UadSc791Gd+AL2SzaAoMe8WWIDAkCKQdtPTi027d5cOIX52bRF
	PJPZ9S9HRgJPHqyWWkB0td4U1uLZUEYPKsT+x3BjZu9ec9d9vxcR5+NfkgD8zGH7
	SQSXfUQmpvYoFGKPkbTD8CAPTAYpuHID2tUiQQ0RcSRVzSxPkz2+kYe0hsQ5aALF
	4QDoqA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7vj3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 05:36:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30cb2bcbf7cso2410404eec.1
        for <linux-spi@vger.kernel.org>; Sun, 28 Jun 2026 22:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782711361; x=1783316161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Yi4ev90l3hg9+EhL4WZIfvzByHsix7quj5Oa7F0Z58=;
        b=dHIzXJnmgyXkOt6QUtKUV/E5ZZLsV9AvUVWNQrxYCmZ/Z0rni+vRuXgGpSBI+yn6fA
         XaIg3mu1xncognJsVoiwxMVrBJ89K4ktlz1qtlG8qG+xGU49usifaCHruMw3u1d8Okmb
         dLg1uTe0NHIcVw/j5WDRQEtiKAfzgpYkv5HOUlorKMbbjagnfFmYlrpa3JbEt1dzcmPM
         iSK04/oGgvmviL7H5eey9xc391vK2xERZ0Fw2Bg+TW68p1+HVMUOXy4ZoxEaGROgOEkw
         UBsGLlbRRXxOCNSHd4Wrclf9tD35o9oH5A3i3uH+QoiM6/GJ+2y5OZ4vRcas+6upwG9S
         T3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782711361; x=1783316161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Yi4ev90l3hg9+EhL4WZIfvzByHsix7quj5Oa7F0Z58=;
        b=Lh3mObpumDcr3hWHNu5gobEPIrQZjum+VJl1bFiWrQd9uAodkG1Y5fQHxY6Q50KijF
         WJ9gUIrem4QNKudjHGS+S58PdBxCG/A2kQyrZn/lhW6NMMP8rOSxD3lIB2cogU+bUQzR
         +QGLz4f7mg+UpZT4GJ56Jt2jZ8jyNRP2w0ZOeCHK3SpXp9cF5Rl8C5DP3t1V+iZy/NTJ
         nS7rbl/zqJIZsc+iSPRoQLT/Sj1u9ZZJPP/zJ5//u8spt7H+XRcwxIgUgpcDEf4eoNEN
         wbe26Zoi+g7LI4Xvwrep9LFRLE5AOJPXa6HZUYRMT1HjxR+sSnsl4USwE5DRDJm/EIyF
         /AJA==
X-Forwarded-Encrypted: i=1; AHgh+RqCC67t8P87Akg3HKV5J7OlRQ+aSO4Ngtb5bzHInBAa0wxqGhzwvKrVm1NUfnnSXPJ4YIx+w/7YF1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwxAoCCxuaiKzSxhlnGRQjTCLGtpHP5jN7QtxE+yZOne/D4+BJ
	A6mTUfyEqKh80QCQyOm7SRdTCFz/IKUSipFIq4J/iLWSd/uusnAhtsn75WHGcTt8XnO9rSyl1rC
	F46ARryMUDc8IXJfElxIP545YvtjARcXMEHNYfl0PQ+tDSG3mZ606Apc5VhUmTzw=
X-Gm-Gg: AfdE7cl2zHEDjkuOOy/O9DnOiEyngfE+l0/YKHv5ys+CAu4QorW33mHzNWrsBeSt1RT
	x08QOTpRhnBhmfk7i3Yo/nL31OqoEuJvpGyukTVtAgHxRdaeH4Xi0O5HRLn7RrmqQV4GE9vqjWT
	bprmdyLiHQDM+T0FdgXBQsMg5hZYJlPT7h4yI2+NYL+gjT2OMxRlUpxu6H53ZFtKLaXgouWaey4
	M0iploEd689UKghr3Nr57iXWxPhbNK0Opr+ADqCpgF9xw6aCzLjtVM81VDvLZ+gpvbYcO9pjWGE
	f3IhOIXqK7ztIY/7qNNKa2j1h1glBJdxbVPjyxL2vtr9C+PF+jjwsu+E4FtdvT8GeXPWsxi+UeM
	svFqa+3UYlhZTKmZdSa03H2kBxA7rqBVNCLxKT3s0Fx16
X-Received: by 2002:a05:693c:3b05:b0:30c:ab4d:da49 with SMTP id 5a478bee46e88-30cab4ddc47mr8830433eec.45.1782711361371;
        Sun, 28 Jun 2026 22:36:01 -0700 (PDT)
X-Received: by 2002:a05:693c:3b05:b0:30c:ab4d:da49 with SMTP id 5a478bee46e88-30cab4ddc47mr8830401eec.45.1782711360877;
        Sun, 28 Jun 2026 22:36:00 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ca5f15024sm32011581eec.17.2026.06.28.22.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 22:36:00 -0700 (PDT)
Message-ID: <c29776b4-04b8-4c59-8f1e-d766bf982a2f@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:05:55 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Pengyu Luo <mitltlatltl@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
 <20260614083424.464132-2-mitltlatltl@gmail.com>
 <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0NSBTYWx0ZWRfX93rkIukAxEf0
 OAJmOTkB2UGLSCOpaNA8Z2p0dgMAl9MTWVLu8066cX0YRHQV/DGcOKUlbyAQxpM1pjo+ESYsgZi
 2xNs/H0WndOogL9OoYgsk844wQW5yy54FzW/X8Kerjrz1MieRgR+vq/GsWyJXXkq1Zw0a3MnLDW
 pAKtApoNLnxPKe6dR+9NfSGWyu/Szd1oALnzoKd7ArOk78jJx+fHhj1a1UqfYJ6mA8jEmbX/e+u
 FjVLunVcNjWONQoyWCF4/Gv1+Vd/YI9imYg4L/C+wQoLZe8DUE03TXn55n/0kf5pL3ykLYdT8dt
 Sp3ayDzomg+F3uEbv5HxzwE+Y4pgihkJl0LEgIbXC8rQWsLD1YRAXqdD5/ZUt9XcrLyyge91XHu
 Dg+VLNFVthYWHTIOlsUR9zTHHpVx2RcsA+WuFznJ/jAXFXJF1yqUGQnM/JRrap0ZNlmgt9Ll/d7
 WQqYl7WftIWA5NA1sPw==
X-Proofpoint-GUID: 6Q1hw4wXoclemKPvgh4DLO0Kizf-6_St
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0NSBTYWx0ZWRfX8QI27xKlDvYS
 EwrvjM31LdJ9f6OGDoFjI1wGSVHk4sUnQNypGG3GwqjngWs3ZkeosQNjPJRmnOhDX14rMrzY3+u
 OnGAPpVdKECzi1a6mWgh2H42s4rpKmw=
X-Proofpoint-ORIG-GUID: 6Q1hw4wXoclemKPvgh4DLO0Kizf-6_St
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a420442 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=thXrHHpa5qkMojcJ7kgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290045

Hi Pengyu,

On 6/15/2026 2:48 AM, Dmitry Baryshkov wrote:
> On Sun, Jun 14, 2026 at 04:34:24PM +0800, Pengyu Luo wrote:
>> Some devices (such as gaokun3) do not disable FIFO mode, causing the
>> driver to fallback to FIFO mode by default. However, these platforms
>> also support GSI mode, which is highly preferred for certain
>> peripherals like SPI touchscreens to improve performance.
>>
>> Introduce the "qcom,force-gsi-mode" device property to hint and force
>> the controller into GSI mode during initialization.
Why to force ? You can directly configure in GSI mode. Note there are 
some configuration done prior to Linux bootup too.
> 
> Ideally, this should be decided by the SPI controller based on the
> requirements. Another option would be to prefer GSI for all transfers if
> it is available, ignoring the FIFO even if it is not disabled.
> 
Yes, it should be decided in advance and configured accordingly for GSI 
vs non GSI mode. Because there would be limited set of GSI pipes, which 
will actually make must have GSI mode device run with FIFO mode.

Why don't you decide prior and configure for GSI mode ? We don't need to 
change the current logic of deciding FIFO vs GSI.
>>
>> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
>> ---
>>   drivers/spi/spi-geni-qcom.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
> 

