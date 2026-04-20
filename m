Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAF83A0B20
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688158; cv=none; b=fxspuKFNf99tNWE1uRadw2fKoLftUJV5kLOj21vm6h/TYBNl3tA7Og+soxx/t0yOa0q7GPnPBWasvG2ZTXG2UMzLCx281UmUDkEeCguie4qqM0cSMhL2vKrQ6f8igdFxH1t0xchxwNN+qeurexLOUhbqeObjn0zhBnnHpX6fVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688158; c=relaxed/simple;
	bh=4MD2WCa9YarWk/OTtFoQpBtFRJ+mxkr3etRBw7sypR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+DKh2zFsSO6IELSd07CEh0H/BjHgSLmGezr+YNZPKgbV7DsPx4bgnQkt0Wm1NczoXMT15bkDsWhX1tshAXf4rc0PvI6FNwVHuUYLN26Q1Mthg6LakBWVFyVtdQVbPydLgF+Jbyf2NcFdsWr1anTZUBaw0xAZUYvshsenfTPgYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E7uroDSx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DX0q2VQ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E7uroDSx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DX0q2VQ2"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KAvSQe3015242
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 12:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mR0GUK7t3Ru3y64U9QLMTeW5
	Sy0+yr82K1og4T8WzAg=; b=E7uroDSxboe6uZDn8dG7i4TWT3x9TdS32pUFZnMw
	dMb+CPuUXkzE88xKgq4Iw2mXn91FDa+aSLukxa6fdufBgdmK+m1YrHfOZC73t+W7
	DMYcMvAM/1CcT9rgpcJjGNOer8Qs/ZGk850Qsj84yC611vtvbDEboJvPo0MKQ8nB
	sB/1As46dXk5pkknmIAYTyaWl9Kg3Ii+oC5kxYKGxd2E9VlBM/0aMProcFsCg9g2
	z8MP7Bf+EZwaNFxazdfIcAn8kW2SIwlmWAko0IWkLbdyJ5s/W3xUOBVBwuZemEMI
	LcVdyLNLf1Bk7VXQHC4O4zvs9kprXDzRMs4f1fgzVddnmA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnjukr8up-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 12:29:15 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56a8c0b9ef9so2098635e0c.0
        for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776688155; x=1777292955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mR0GUK7t3Ru3y64U9QLMTeW5Sy0+yr82K1og4T8WzAg=;
        b=DX0q2VQ2zNvkUz++61Q2tZz16OIjUeKKuyWOYhstNRSIv7MwuB1HBhiC97is+SaMs2
         wciEEw/wooZXfCTuZ8q6WjCawKYRWRRgNI/m10o4k12YgkvI/peRg7VkV9Mnsrvlgzbt
         rOVoByBA3Q8u80x3/71JHWU+OAo5qH8a5gfUODJQ45FtS81hK17G+f9cDIgoMvhjwtAm
         klCunOtkj+v6Y8k3qcGIxCueXb69G+0fe8fjrNxMFd7TNbir5k98nDu39UYSJu1qu1xv
         snjk1RJdxRO2m7NO56CFimRDIXLDwpO7cPkIqX7NCz/gPfWBmZXtnlqxFzSkserE2nkI
         en3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776688155; x=1777292955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mR0GUK7t3Ru3y64U9QLMTeW5Sy0+yr82K1og4T8WzAg=;
        b=DR2D3+8//XjTPFiLhEcEVmiqYRFDdmgB0BEvccMwX/vbn3U6uUuXxMr6mUNz4Bl4hs
         AlfkhxUaQ6Vz/OQtsXgkenvJ1NguSnvTB8fbW/iNhUH6ZHqSLjoxMiysLOeg/RobzKOI
         c3yUG8UIzFcX8QADMVkQmhzSiX005mnjQsJERYTLsDo1Tlb4a/rXWgJVW9NY+USIdUZp
         6MLO7NSwG3qmm4ImUGXk61L2gQVoRCz/LMjswJ3cP59g9122cQ2U1eqrEFobiWaR2SL2
         qpCqZEOdenpxEyOof3koZ3mN/8bItVTnqILkTIga+y4UD0pJ7dajPiglu6bseejSZvUV
         64lA==
X-Forwarded-Encrypted: i=1; AFNElJ+V7W8eWqVDEWvnSmgcSbK4rVws0Xq/6zYO7DzKg6x83/QnLC8E4P170FMhTdAuwKoWxTVNdi7JdnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYqZ+HKpxYiQkV8jJOuV6qycEBPUBkndrx6iyWYcagxZk4cs5
	QjrjQW9fJmKtF6hANn+f+OxnN4K5Cl6Exyqs/wzg9Mniq8Ime9pvuUl/eQgLDwd6JBpfaxqSycb
	23a49BOV74YMaLWrC0DXKYTnSwdFiqKAa+J7vqXbY228Or7/NSU3ivtZJAq6lI3A=
X-Gm-Gg: AeBDievvU9XFlcA5UZ+eZ6w3naFBkFULzOJxwexNmeYXNBndzEJSUb2BQIKKDMmmkKk
	KYb1w7FHpE4NLirM7dgCesN8IM63O6fchJsBAp1g7nGbipqV4Yje8xoHPCMjn6EGh5HID3/klat
	tnSe/BAk1ffWFfj9CKKtl1Mo1b+ttUCMR7sVzc7TXM4o7AbQY7w78A+yErk5ONfAESn4YgSOkTH
	yi8qYR78zVTe+oWlHjjBOGCPF7HvvTzaC+q1fl2SXntMdt/1HQIzOPYaVYVm2+f1n59lDXH504L
	mihqLA8MNp+1ANB6mtjck12Eucgc3n7ap4KcExaAY0m+dVHQDY2TZ+qSSUouXP81FIuJ86Ogn8s
	qICXMAWrvozhslIIOUg26CSlI7q0szFZYLRibOkBrjI9EBga0T7DX00eBojCh/NWz398HpWy1RF
	2wUQhkdNwYf9wSRqWisfqRP4TIKJ80lw2+IzETZJ7L4MP8Sg==
X-Received: by 2002:a05:6102:c93:b0:602:a05c:e9c7 with SMTP id ada2fe7eead31-616f54a479cmr4283150137.7.1776688155163;
        Mon, 20 Apr 2026 05:29:15 -0700 (PDT)
X-Received: by 2002:a05:6102:c93:b0:602:a05c:e9c7 with SMTP id ada2fe7eead31-616f54a479cmr4283139137.7.1776688154657;
        Mon, 20 Apr 2026 05:29:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f652asm23137811fa.12.2026.04.20.05.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:29:13 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:29:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] arm64: dts: qcom: talos: Add QSPI support
Message-ID: <ln66k6kv2jakmoi7nzvoven66ugd4xiagpazgpnxaw2u2ytdtm@42eikb6kyvs7>
References: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
 <20260420-spi-nor-v3-4-7de325a29010@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-spi-nor-v3-4-7de325a29010@oss.qualcomm.com>
X-Proofpoint-GUID: -LiEAT1NQQ73SP342Uo7NWmbGapo9G-e
X-Proofpoint-ORIG-GUID: -LiEAT1NQQ73SP342Uo7NWmbGapo9G-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEyMiBTYWx0ZWRfXxn25yFmm5aQK
 xfF4DB1qizwpA4rgeZaYwWCsInCGhcv4/POBaxeiybMhMEviJWPHhnXSL1oLEAzlIBCLvnE1sYa
 wPXGFYD5Id9xXheCIvJWjX8SfMDKbrIScytVx1L+GB1YXEHkHpcAhEm+W9yXoEVCjpGJDhEmScM
 leNV4EDUlQ83QsJrwPykLOhlfkr5t5GqQx2z1zs4ukpuqmuwka+HTiz9RGYQX6uI5/ry9KeIB9N
 jFYZtBiNpohFHfJAwNVSoy4fLL+C3AbTcDvYrxLNUiMtHVm4D3+y5ovN9dSLdhXQ7qFwoRdrrgq
 1enLGWXlTTY+kk23S/P/jN57xVKfNvctRPkBEDSdiMKMuQmoyodCTp7MQAQ0viYqJWWYrOlaiim
 opG+f90eUOBV/f0Gm+gtNo9u1t7MLavKJXh4QpxMsVF6uhI4pUACPXUWuLSLEHY8JoDPw+6N1N5
 6AMDv+vc+ZlRXdN3vJQ==
X-Authority-Analysis: v=2.4 cv=WuUb99fv c=1 sm=1 tr=0 ts=69e61c1b cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Y_rFqcJ3G5YoWfvBDw4A:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200122

On Mon, Apr 20, 2026 at 11:42:51AM +0530, Viken Dadhaniya wrote:
> The Talos (QCS615) platform includes a QSPI controller used for accessing
> external flash storage. Add the QSPI OPP table, TLMM pinmux entries, and
> the QSPI controller node to enable support for this hardware.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/talos.dtsi | 80 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 

You got r-b's for v2. Looks like they got ignored...

-- 
With best wishes
Dmitry
