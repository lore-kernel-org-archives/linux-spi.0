Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E462472A2
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667742; cv=none; b=JYShNydv+FYdMw0hUdE4X3UoQEyWCps0zH2m6xwxpRY7s5Tfj0JQCLQZpejGuDw/lwaq72+an2U+2A+ZF2j2oDYKD8siIlUqxGAPJlsaAniRmudwvjuU+VMAA936vof6GHiTSfpJlvqj0Is/ap+dywI1Xcz3TNIbC+u14Y7MhS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667742; c=relaxed/simple;
	bh=VjPa5dKBAL0HC5Ak2oFuEazOPoP1X2PPGkhAT5vG8+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiMAT+rmIOeDhPO7Gs9nS11bwkFqQHvCoHKvd5nZl4NnOiDuD97hzAdzZdz7XZmiz/S7VpaUxpgQtbZSyffuBuJRwG7mWwippV2shUSHuLakW4r0IGWUeDk1r8olCnSxpjAo1zSXfzgoorfK0hax9zc0Ghdu1IUAmVNC3aisdE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e77zl26j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UIJNeIqO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e77zl26j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UIJNeIqO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBkYOm1068005
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 13:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fIboW9VuwE0EORPl7TKuMP0oFZdyasnxlARwx2DUE0w=; b=e77zl26jnmtKd24Z
	kvoS9enBzZRClRgwEQIxDDzM/H6edfYJ0M3wuT49dP8cbhpz+NeHyYQCu6lsA/hK
	KZaBsWMh2OQE46d4IAYglcIOfWT3c6hHc/Z8qspEMrvO+Al56XH9sscBC1s5oxil
	RyfZTibsCKwRMJ3JbXGpLEfMjPFee6Z6HXqeZgBZyhBtWlWHpfR9lt5yqM5fKro8
	eMEyOLCuqw8lWN4/wBEWKtB3EOXulKCCdDUkdcFR7zFMEDWZLs1B8baM3raC/LVs
	E3Ua2q/+6F//1Nfgj5NFqMiZYnmc9W6yhH//MU2xhP6qf0E3MMYGzluapUtYaQsB
	fEZpxQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw027e0kh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 13:29:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd90210336so248997085a.3
        for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773667739; x=1774272539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fIboW9VuwE0EORPl7TKuMP0oFZdyasnxlARwx2DUE0w=;
        b=UIJNeIqO7tik4tSy4IWZsTvDlQIVxFmO/tM8WPBYiUgE1UYsknX3GPhxcuim7Q/0wq
         1zLokzwKG7JTmeBPIj8WHkktoJqw1cewtPUka/PDnL0teZHb2aBVVx8XQrkEmpooJlRM
         f+A9kJd2UkvTjnwR194OJAQGosmPTNf3r2BCZ4d2Ixx4QJAf/W0Vr+0v1jepPox/CobG
         R4re/mqC/TUjZjcPzvgIZ2vToYoc7MVpUlHzSwATimK7dcQJRZh5Ha8UQwGtb2xzTKCf
         qpKlL/qbPZ6z2Vg06DvTj7PS72FjWJSKnAvjHkZB0FPQB85q3Lwqa6MWxTGInOvrPaA8
         gPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667739; x=1774272539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIboW9VuwE0EORPl7TKuMP0oFZdyasnxlARwx2DUE0w=;
        b=KGfneg7mZRSEfC4SKR6rkOTxIb4hIV7ZaatDBhqz6hfac9kJYdPv3pmb+WTcwcv7aK
         nMTotHWW4tpwW8/rMjiE5qaZYYC6RNLUk53cXymGho457G79f2Mn5TfEoNy+FfbpbJBZ
         jFiPybgpgVdAfUeFuYdgghDA7ZPJdTgoiTObdJuAJN+3ljV3a/cwCrmGqdarDPMEd/Xu
         uxn2SshlV28gv/2njeJhtFl0jhr0CK8EFfCjrBL8cd/m5r+8+OzI3GYi862YecOdfBMp
         KWx5Ww8ayOu+1rekBagq9e4lPVSVxLnqmgCgObSqtmOfo4BSPISzkBO1GBR88nIS+mUh
         k0Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWx2/b6ezrxw/iUn57xQF1PRxM/PzmthkTWsbY7XJJoXEWtYUz1PC58Qkx/dr1oNWZSKc004g4l0yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwybBdyl6BiiPWX/sjybhJ7DPqpQn+Xec4Tw9v8FJXqD3htNPDb
	+aXrdTYMF31Lhm8pXmlteK6QD3diA4kMe9jWEImgn7bhPeieieoLmXSfJvmgxTuZIcf4bYkYXLt
	h8TV+9doPVp85VBOJ+A6J0L5DGQ0UTtsQRyPQVvyLeBJiXD2gD+gvyFZsj2DHKy0QmnDrypI=
X-Gm-Gg: ATEYQzzaD8eKAyWRyuoQHqA18KAz/YI0hTHspKL93sjEQEIWrV1NytPQbQ6BXNuSPKo
	4+B4zeym8b1Na7wiE06TWYOePDkO8n5+BZv+qXFqVsltduKiMD6uLdVpIur1ydTHP9BGzZtZW/f
	gKnjxlid6CtaqiH4Q4b3yXqt7zrakJMj8cqtJi3iZ417hi6kmsVm66Ub1+vDxYsv5hSOH9hAsA3
	jp5GGNrU6fVhwpzgEwhm0O9wP+fiOnOb8cvrdboQpRHQT06cQPOkxUwyrObnIVRoR4FNqDCfwmX
	TRGyAbsJEH6tgMdb9f97Ai5AGDD15YzHSuxdtd6LvNflRTyVPE1APu2kPg2xjCY2RmD5yTFn13+
	qFCO330NPGkdrj5NpBn22183BSiXIGx7iJkPX2lb707inJyxP7VMyTAcQ0yDtAs5BpE8CZ1ZISa
	SCYYk=
X-Received: by 2002:a05:620a:290e:b0:8cd:8736:9fc3 with SMTP id af79cd13be357-8cdb5b8a614mr1344673385a.7.1773667739390;
        Mon, 16 Mar 2026 06:28:59 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:8cd:8736:9fc3 with SMTP id af79cd13be357-8cdb5b8a614mr1344669185a.7.1773667738744;
        Mon, 16 Mar 2026 06:28:58 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156033a29sm3400429e87.37.2026.03.16.06.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 06:28:57 -0700 (PDT)
Message-ID: <2a6698ea-c7b8-4038-b4ed-7a7c9acf3d05@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 14:28:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: geni-qcom: Fix CPHA and CPOL mode change
 detection
To: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Jonathan Marek <jonathan@marek.ca>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        bjorande@quicinc.com, mukesh.savaliya@oss.qualcomm.com,
        praveen.talari@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260316-spi-geni-cpha-cpol-fix-v1-1-4cb44c176b79@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260316-spi-geni-cpha-cpol-fix-v1-1-4cb44c176b79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SCerrM8EJT2M7ipJBqvtjk8z8YdRBB2Q
X-Proofpoint-ORIG-GUID: SCerrM8EJT2M7ipJBqvtjk8z8YdRBB2Q
X-Authority-Analysis: v=2.4 cv=AqXjHe9P c=1 sm=1 tr=0 ts=69b8059c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=tN-bM4_ZalV-NnDHEpgA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMiBTYWx0ZWRfX+YSa3/OrxGez
 Im44uCpxGgC91BwyO14ySfyzllxqu7sTdd1RntYBGGZFqpdxaIDuVLymnMTciafiZzYPY/W2YgK
 UJi0LW710TuS2zpTCSvkDDse5LSzHmOq6u06UMsxGhs6zmFNTAmXQLXuDY4DySVl6bDdZVa4IWG
 Gfj9ej9yl2zx+nFoQ0c3k1qUmH8hR3JOzpvrnIhtUMhpNRR22FFKpYZ0C40VIXs+J/gJxAKJIR3
 6oHL3G0FPLtWeofSm1jWdph6YTiHAB5hccM+Agr1cMefbq6ex35GFzHQVJtIu5Ylxuq26hFJEMh
 97BYezR31+gpXf9czf89EVE6N45E681HvWMBJs3o0uHR8qG2WmFhImKkS8DV5zHeA1dM7sVNgvt
 WGac049n+Huie8oQShd9QhxV/p/VzgA1XTIdTAlyM5N6tPIABkiDMAFUuDY+akhWb4DXQkL5io7
 P8gabsMUeIHnxTxvV/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160102

On 3/16/26 2:23 PM, Maramaina Naresh wrote:
> setup_fifo_params computes mode_changed from spi->mode flags but tests
> it against SE_SPI_CPHA and SE_SPI_CPOL, which are register offsets,
> not SPI mode bits. This causes CPHA and CPOL updates to be skipped
> on mode switches, leaving the controller with stale clock phase
> and polarity settings.
> 
> Fix this by using SPI_CPHA and SPI_CPOL to detect mode changes before
> updating the corresponding registers.
> 
> Fixes: 781c3e71c94c ("spi: spi-geni-qcom: rework setup_fifo_params")
> Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
> ---
> This patch fixes SPI mode change detection in the spi-geni-qcom driver.
> 
> setup_fifo_params compared spi->mode against SE_SPI_CPHA/SE_SPI_CPOL,
> which are register offsets instead of SPI_CPHA/SPI_CPOL mode bits.
> This could skip CPHA/CPOL updates on mode switches and leave stale
> clock configuration.
> 
> This is a single-patch series.

Note this ""cover letter"" is unnecessary for such single-patch

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
