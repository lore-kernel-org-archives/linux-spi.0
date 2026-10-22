Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672093;
	b=BjyPYuOFqs/s4kYLUcOLTJRVIVnt2FYOoeAO7h+GbDouD+YavaLOXKga3miRuaVQA6gE
	 7e8l6mi43wX1VP4SusXJc34mJlfCSso/fTsK8A329VBBUUhoyyBNw/9byGJGVCyD7XfEI
	 3KTcjYs0NERgabxIX545qBgckyM1QtKTFrZHv8r1lIl+Y9c4SfiQQPnSViJBG6wYl6CLu
	 MowNH3cIRNL/AMbyXkjoQJrvQCKnKD/4fJYbiIyt3DgsS/74btn9CHKfgvQH7uTJYklWG
	 qZqX5lfyKwV2wFpDSFgqe+QQEvoUw52IwvMXJ0HpENyzbKK51u2ki83koYyosdP7ldw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672093;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=;
	b=P6tL8savDQ20gSkinp48GU9MGDCQjmytAa9tDPsZX62Jo8H91Z2Oed7zACG+7WAXbdmM
	 sxPbs5xp72w978zgF+0G+8WZ4ScJUkOenEGGdsE4UhXi+lITGqhIBEHuygiK0ynBUb5LT
	 3sdauIfcEHCbU+2O9flHipR9Fqhxq/81enOFClYx358GC3VeVovvfRMU+Cs3SrxM+YCIe
	 C8NdZXZD/66Uxr/26HWPmmaPYYk0ew6I/wPzhE8huWVeMYRJbSGtkvbtiLEP20SrfTkGo
	 Oh5yaEvqe9lF73rVLyL7HGvkFs/iSTIg6NX5suT9O/ZQ3SUhAiJ1oXB4APfaqhHJwuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qk7LeKmg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="YDDvB//5";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9A0606A323
	for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 12:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE9A0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qk7LeKmg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YDDvB//5
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA0BGJ2918772
	for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 12:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=; b=Qk7LeKmgKfl8ASss
	r/S31nkFb5YhbcmUSm5td/BECe5v1/SgAUKL+3yoqW/lRibA20tcdz8GOCTejfBg
	SJnhc6mDE3oLYQ7nfvuFZ8AOxYLsPwr0r1E38ln8TXP18dG+8EWHGPBJlKfBr3fE
	VcGF4BIJOrqH5FDylxqT4Lq/KDCj1IJpqJhG5yfK7/MIdqpE/fgqBrq9Q/nILTw1
	IzY44rprRytmIoIGq05urfI+V3wtpeFQtS4HFrD3I/HhyzSUlG0u+Vhxnhui2rLv
	qbPfovCQT1cJYHYgXzKW0O4anTJTXMj/jGOLvJ/icvRKkqNw4umV6qAIrYgHlM58
	W+/f+w==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ab7es-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 12:28:11 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-80a4a17618dso1662067a34.0
        for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792672091; x=1793276891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=;
        b=YDDvB//5wUrrsMjA+YOjITn6gFH07RI8ByXRGm5tbEi/x3FTKojCVivuRWJ8C5RsGE
         hpAN++kQIO2OzyiQI61LcvkrklJLzwQhpZe0FPXz+0w977W+VaOzM0xrifW2TDcLrySu
         ntOAlduDV/IVdjKapF8Sr0LDsRgzDICMUTekO0VJsHXE2UjAySxZ6INfhIbHZwZsf/y9
         otgi6zR74w7vRYgkYAy4l2d3R4CCVY9tNUrFutkieB20d0VTUXkEcX85/XMgBYH/YwCi
         7ePqJ+8bn2e1Jp2AVdwBRmo2ZNnqF/m/kfZDxOIoGZ6cgr79hzVrAZCvEoZwSqBKuQnl
         Dt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672091; x=1793276891;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=;
        b=DYTQ1Xr8hlQZc78DSRJMJwmQn9fN9PSXrPB0aGc13WjCWlEVjDcAglq76exKMSd5ps
         qeu6nkNuEDdoxE7BdshR6FnW/kPKoPGgHaa30JzRoIAEhl+zMruQ9tnPT5Rh5qdGRWk+
         ZsDhe8wO4aKDA/SkxptOABQ65g0bd3GJKR+cWHXpD5iFAOcnpQW/v8O//J5OYXM5EDzw
         YUqWCkNjTFYxykWHdLxTYZAp2XcynD1EnK2CcWtnDFlwe+oeDEnzRyO3pyfS5Xw0AN9U
         Op+uMvEFFMnJsTjbPEPtPOkJteEiY/rOkfPROoOQpCsaBKmBIYnHd+wBsxHUNxUGyh4H
         ujUA==
X-Forwarded-Encrypted: i=1; AKwUvBzwwNJO2FB423lUypT96IY+o0lQvxJkHRep6wOQBun/jG8Fl4QlIUNkUh+FW3EWJveOTPyrcMBOj4c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqXrDGOSLbOAjrZUKLJnC6Ndcra+Ynvf+LCx+xMLf29KHD4c+R
	DejzDYj3l0L8gL8d1niyBRoonirKNYlFVWqF2410PUORQpdLNFo2F6tAX7+EYua62fH52Mp/9dy
	7oJg/WLeXXwVK9z0ujG566Q7WrFHenDvl6BX8qXW0kBiNhen6fIsg1c2gfeUau0w=
X-Gm-Gg: AYBFou19C3ZifSOxOSG7gCTVEUUhvhAtVVNgeuwlcH+DuA0lBsn8PxyGkmxNw9rY5zZ
	cv6bxbXdVvD78C3EqjbPiY3vgnL4KI2I76V6Kml0er4Fq8wTM9AKjLHgKJ+TkELf/ykyo3Zz4fr
	EqoJr9Y6fYxy9AzYXSTNEtGLYyv/hd6Njf/yJd3Fi6+fN8KAUAsWWRjj2f3MU0seCtLkDh4yIjh
	vnUGSTa9gvLSebW5qkzYSmtPeDVDgWifbBj/qKMDgkGskMcciNo+t5hzBuvZJGrKVc/Lpmoaf00
	+8Z0MHJ0d76j9z5wpC75SGYDDN8eDgBN/L1x1IOCOw5mY7/0uEknbkC9xGgg2NtUl9NhUB+b6En
	4PA1UKYX4q+ubfz0xQ7+c6NezhPr1BV/b
X-Received: by 2002:a05:6830:6f88:b0:7f9:555:1def with SMTP id 46e09a7af769-84e30c31e32mr1258618a34.11.1792672091172;
        Thu, 22 Oct 2026 05:28:11 -0700 (PDT)
X-Received: by 2002:a05:6830:6f88:b0:7f9:555:1def with SMTP id 46e09a7af769-84e30c31e32mr1258609a34.11.1792672090792;
        Thu, 22 Oct 2026 05:28:10 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbcdd9d82sm4892517a34.10.2026.10.22.05.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:28:10 -0700 (PDT)
Message-ID: <d6a3a783-c6ec-4f93-83ee-ce30848917d0@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 17:58:00 +0530
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] i2c: qcom-geni: Vote for SE clock rate using OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-6-5da1096243c9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-6-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JudkP84C c=1 sm=1 tr=0 ts=6ada015b cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=gi_f2RLh3HdMVU9WvNgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: CrmJm4GsHZni9LI3r0ifH2gHpqatvclg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfXyucCkzphAX3m
 ZTsBdmQoKIxggec/FAHp1einciX6QsXajtawUi95Nm3XlpwMVgapVsmGgicHWcIVAOA4neXqJ7h
 XyWiJsYPEk5yJEojQlBjmicpoZ0wTOs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX4W4BPiZtI86e
 xklwE6frDidJCKS3ZXLYTc1shqewaINdgES7BDK6NnRzLkLL3bjJvoVgMt04ZxiZaXTgFq3rQuc
 YFB1m2g2EAcHp6P7EEexeyBkEAEbeSvx85hHvWA091fCiIEn3wKUe4LI0K2fUM/nl7uvhs0EJUe
 TNmd0VnT6vEdPdLmLDkT7HdGD0/iObMm9YiTOmhu6n3XUjldo0q4cIPjmnEcy99c39ZZn7WvldH
 ZYIz5mmRDqIws2h2yAMuz2e7cs/KEMJE14Fy+hlzB8z7f4JD57+O6fBei/dmzb1L7vvCbfPoFHO
 xnBdSYg9NHCp+ubOB4zWo/Y9WKmnP6XvpzapbUrGn/Mz5EOIL8Vz8bIz28M+qhaYWQpy9DqhVHd
 6Cam0nj+AgfRONh4z98aJ1tueVh60mz6GwSpVwsw0tYv4TYEJ0toxBLkrYHUju7ktltQpM7O7gR
 I/CuC/gj8FOdOqO+AjA==
X-Proofpoint-GUID: CrmJm4GsHZni9LI3r0ifH2gHpqatvclg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220049



On 10/15/2026 6:28 PM, Praveen Talari wrote:
> The GENI I2C driver selects a source clock based on the requested bus
> frequency and programs the corresponding clock selector. However, it
> does not request the selected source clock rate when OPP-based clock
> scaling is used.
> 
> Store the matched source clock frequency and vote for it through
> dev_pm_opp_set_rate() before programming the clock selector. Also remove
> and restore the vote during runtime suspend and resume.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
