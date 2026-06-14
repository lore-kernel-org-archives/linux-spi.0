Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5662DCF52
	for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781471937; cv=none; b=PVhUuPpYrdHEBrmx3aeeGMoB7bn3M9Y/Iz2bThMbVAST5fhpRFIf3nQhv3o/cia+DtL6SshLXzsX252YyQci1W+cs+PgxgCB+OrNyDrdxu98KvL9sUIUuHUX2TV48fFHeuqBGfeqXUSD56plQm1ENk/zULKquH250lWgntOkLBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781471937; c=relaxed/simple;
	bh=0miKinNiBWvUoPN9BaGwPuXb4iIJkY74GJPYKVpbCws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0R4AZyx+7zIEix2BAsChD4wSNBG/mZm+qaNXeaFYMSY1WU8i1uHbRbO8EN6XmFyg0pl/SICTjLPge7LEfL1E5uX8VmJ5Gi9Rj9MNy6Je8/gE6grI8Hp2yTJd7GoNyWTxtrUhmIiXEAxFFQ+417RM3u8RqdXzSOqnHKYNzoxSBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XRoyeQE2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WZLBdipS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XRoyeQE2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WZLBdipS"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ELFFeB2753884
	for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 21:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MCsu8KfWh71txzBAaRtP4I1n
	CwGiB4nR9paTIiDThd8=; b=XRoyeQE2h9Aa67gjKufT3yr6h4UUkS6q72vh2qR+
	6rRKrW+I0AY9RMoyFHoQBsg8q8qvyj2zBat1G5YjkcBB5z92a1x3nc3Y7aTUFO6N
	MGduQ0zNpy3hQrHiiOqNGLcOEfM8SIWPNKOaD9HY7kOlEKe4geeRxbNRj2x5KqMN
	A2aTklMiucdvUrBHkKwvKf62Oku+ntATzTeFhqgGuAeW4QbBL/fggHkKfv4w1l4m
	qsMXKHSp+yqyJvdqOaIfoT/k3J0RH/LY7pNn18eUqj1nPe5a1q+2l+yDJLblXJt0
	NBt4ld+90jJ02kui4DKnS8gmPJqU39HyWFCjcloJ9uZ09Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryc6vkg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 21:18:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91598af506cso269450285a.0
        for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781471934; x=1782076734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCsu8KfWh71txzBAaRtP4I1nCwGiB4nR9paTIiDThd8=;
        b=WZLBdipS9bu+r5x8cVeeOmbpSsfNBoDDBVkUr/gGHi6TF7dqBe8h+mkead2Xn9vWv7
         yMA5x0oX38M/dzUgIG0LJXGeVtEViJ4h0p0optc+D/vEYZqFEw2vpS5tHVpcieFvN5Hq
         PFcBRKAXLnE3RTdunRca1pAYcSSwMYRF1K7TJ6HF0TWbNU6yywhioTH0zE8AYaAyjYbR
         6DHEadGrioBr8aM2Xcgnkwl6H0LZpgel6nM6fo/+EPIvIg28ABh1t/ZeonzAUHSYfdF9
         nZm0xLHw6fkb8IFtXFICFMcWghi44L7cHaCrobcpHPcLyMInpIspnTOzMsdNvsIYoqUg
         +bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781471934; x=1782076734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCsu8KfWh71txzBAaRtP4I1nCwGiB4nR9paTIiDThd8=;
        b=VSAO89bYK4C/Xp0MZVS/oXpztdB9iOUmPB40L1OYyZZCZTqlQOzb7oQpj3l3WVqTB1
         J53GaeqoYNkZwZ4n05aVt5gFt2rVeawWWMJylOx6SEqrRXYJ59edObv/L6G/GtiIYB0V
         bb+5jS+CceFPN2WD5nYk3G9uajpHaUWoyVtYtC5Q5JOP8g006kamyUJGp+GiXKLVK35G
         Rc+i4EYRZ9N4S7sPdEzP/J2sdK/jIAqepIbORzqPQj+vRl7eZNsSjxXXlm1+OhQhCyGt
         R4Ph3Pc8rfQzIL1BvbDAzeYERgoAllL8TJVvZOtPGRgc0P1RR4MIjuRwQuWSadPxiJ6e
         R3nw==
X-Forwarded-Encrypted: i=1; AFNElJ/qsVUMhk6fEhB/ro8GRXI8fyxxKXmPFxhMn/ODiaVzl9YUpTQayeEq4crLh32VMF8NjFqNw0lwgD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3TYew1GWOeR3I4+DiKzF8Ets+3GxtM6yaz4k5ZCXh5I8XXX4e
	ph1aLKnsfc9LMlLYslffafpcLZssDLGyo6tSYshAKVTmKKvPo7/pGj4jtZ7bsJh3GbpeH/lEbC7
	stWuf3eylWVOTAhT5iMAFisRzA2rgYYP68WPhM62kuQ/Igq/YXBzwE8n1uEDLcnY=
X-Gm-Gg: Acq92OFhSToNYrxs7IwBsmb9RNfN8ZMyDIC4h/HBPtPxg1jmJR7CLmO5nvUpUsN2ESP
	O/bxd5G9EpSeqgyIUFeQuVTWG/jqIpkFMAhcxlYHrn59llpk6pL0B2LJX7DXBl+TuRzO9uEX1hI
	/ZY0CYnR1Q700Gc3oXJ2wbeM4MokNAiF9rP0KR/3vuiNEXqW5DNiaVu1wUOrlOhaHMCXWeQWI4O
	3K0jLWfQUo9YPjqmziKqZPoCaTvLpnHC+eL9ZmntPyXetE64Jcsg7s9oJRNPfFe65ftZBaY+TZu
	UBO1Nb4d4mhG6fn6MD/Y3Uf8jjODv3AkpUgWKjoPy9apDZ/72ZByiQt5Zbo4o8jXSRpn0FGPJKF
	8Dik6XDgf8rwtSB9hdGAvFt2YJYwWrQOIcus6IHq9oyET1uqdbj5R46X1MmRZd6LtkafQOBcIUA
	EVx4+yrRimGYlIsL1YusR6tw+gKR/nl3j+nHI=
X-Received: by 2002:a05:620a:6f0a:b0:914:bb8e:915c with SMTP id af79cd13be357-9161bc576e1mr1799151785a.22.1781471934098;
        Sun, 14 Jun 2026 14:18:54 -0700 (PDT)
X-Received: by 2002:a05:620a:6f0a:b0:914:bb8e:915c with SMTP id af79cd13be357-9161bc576e1mr1799148885a.22.1781471933635;
        Sun, 14 Jun 2026 14:18:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1aea92sm2187663e87.63.2026.06.14.14.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 14:18:51 -0700 (PDT)
Date: Mon, 15 Jun 2026 00:18:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
Message-ID: <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
 <20260614083424.464132-2-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614083424.464132-2-mitltlatltl@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDIyNiBTYWx0ZWRfX5y3U3AFxJg+O
 eqbvw5EQlQS5SLLVkPcNoi/cIFKZlLDOke7ugTvxwyGrU2eFYY0AQ7wLkiYp4yKxTniZ9un5G41
 ozZhwJDwT6SdX2zG10nBLiFuuVQNZN8=
X-Authority-Analysis: v=2.4 cv=Oop/DS/t c=1 sm=1 tr=0 ts=6a2f1abe cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=cGGWfqFj7ohIeHota6cA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: L-85n_cHlNbDWTD6CwRpH5DlWrfmZ1qR
X-Proofpoint-ORIG-GUID: L-85n_cHlNbDWTD6CwRpH5DlWrfmZ1qR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDIyNiBTYWx0ZWRfXzvCXudA+QqZT
 jyzTs4kNO01pYocjPp5khA8fIqqY2SChnlCbvcJsan3yoeGt0P+qCjfDGZ7QSNslMcm+m+SefVK
 K83512lZqVfQgrNtKxaJ21S/B0qdm0NahlIjqBYAiRAXr+8s9C3m0QVufgIhy0vgJ79lGqrn1p8
 8B8uinoYy246Op+A6JiMIXLZAp+k1e/Bipvjyzi7pPgAm3l5DzBCxVDMUlHZnHPEH4gQjZyJF7D
 llalAPF4ohLbmboW9MDxfuVI8zEa1d9u2p/RFkMRKwga36qHKD7YMrQHm2pxEdRu0Gf//5yzY5+
 4pLalCmYdwb8h8PrYvCIA6F4AF1sNweSgoR4pOFu0Alw0NZYB6FnKmvCyU8S2KiXb3oKqtKzbvE
 Qh6JgBPk71e1wMq/5GJFpk5pGDfEQDVpwc+vLKTjZvj7yMzkhlUcBmyNbLPpwLaJq6CJUsixQN3
 3EpPgVmem+imJP1Vebg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_05,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606140226

On Sun, Jun 14, 2026 at 04:34:24PM +0800, Pengyu Luo wrote:
> Some devices (such as gaokun3) do not disable FIFO mode, causing the
> driver to fallback to FIFO mode by default. However, these platforms
> also support GSI mode, which is highly preferred for certain
> peripherals like SPI touchscreens to improve performance.
> 
> Introduce the "qcom,force-gsi-mode" device property to hint and force
> the controller into GSI mode during initialization.

Ideally, this should be decided by the SPI controller based on the
requirements. Another option would be to prefer GSI for all transfers if
it is available, ignoring the FIFO even if it is not disabled.

> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

-- 
With best wishes
Dmitry
