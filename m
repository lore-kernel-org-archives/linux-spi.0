Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1BC33F377
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526205; cv=none; b=n35crQH74ia4YFQiMDoUptQebsK9e/Lo8LK9mO/eKI7/y+8/mXJnYve+NSDOy9wfbteC5+CGhfMawJvDvD/TWQkIYIZi/VF2ALfjlQZrKrzV+WozbE7wGAgI4asYmRA1rNB41U7doggdKpIeItgqVvcLs6FXZaaMvtZh+qJgRjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526205; c=relaxed/simple;
	bh=8PeQBj34V5c0RfITfinu1f6KT50KbVyD4JOtxTy+Nho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAlvHEIF5z2Dy5TF6s0ERag7I3XilrjsQE/u72pZrcSJz5wGMRz5hNL5CR63WPKLUF3TerU+DUlCZUuS1BG1hlfqC6lvFwQveYXTMNMbMunnANn+JxK+Puh3niohhLoZY4RDfcnWLI9X2v/jjzJmAR7HfCRdQaxkEOUjc+KldvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bp77X5vD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bbs7ONnv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bp77X5vD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bbs7ONnv"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FApQem359516
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 12:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E7sv372Yo1BuVVOPLRYh56YSH/Q4RtdRYSnzm2ofdy4=; b=bp77X5vDkcJ9TRlO
	306T0sfA9nlwh8v+9OgMwcah6LrWn5ena05Z1+Gbh18jWOaHLsnmbNJXJKOw3mG1
	CZ2t0VZhQ3s+MnPK0zv1ZfxsI2DbZbaP0putJQ7rdDkdIRaiC1UPSv6eH9NxdwX/
	qplscIVCNHWxXIY5EacmiFTruZG5g7mhF/p8nNxiX0Ok1yGCHVNynp+KLrw/4MuQ
	Ha8n6zfKWfEOSyBBEGAUFfojV9GtGMSIxihBcVLda92LtsdWhZdaY0is6uMrtPRq
	XWecAClUyFeteVMKEHWVmoFNWEJNi/UNngE4sNGPYJ1WfgGax4hQo+e7KIhaqzrF
	k2xwFQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2c946k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 12:23:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-915c1997732so726514985a.3
        for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 05:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781526203; x=1782131003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E7sv372Yo1BuVVOPLRYh56YSH/Q4RtdRYSnzm2ofdy4=;
        b=Bbs7ONnvzZ41NO8AQ8PLtqE9J/c4RZ8RW3JMMg8EQ3vFLGqSddEhJ7MxF9DX24nomU
         koKChcMB2kBRsY1zQdHiEe0FzxISADuTT7YQYHCUidgWG3SlfqHgvBJ8MZenOyW95V8/
         dSmHV759misNO6wPib13DjfrLlrowCl7xMCMyCxqbnfKOhW7hhJ1SF0F9mc9vOecWJL3
         tfgztMqfaRjaOH+4NFdH5/Qxt+5+hMHz/oBzRDpulM0EXNJCxAxIKYJbBzs/FyHFxrwd
         CuO+8gyZ2bVouA7c511eqb07zQ8kOLlFN212O3JYO0tqYXoN2g7ZzwbFUwzewwrOcbeQ
         SO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781526203; x=1782131003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7sv372Yo1BuVVOPLRYh56YSH/Q4RtdRYSnzm2ofdy4=;
        b=sDnyu5QJxKEvrDaiAesvYwm7cPgvMIWQjeJECs9RSj7o2xiF2WIoqxnAMYzhwkQ/gw
         2Ya9yE1oyaf/E5K2tUpRI9scUVi/hQJ3RBEZKd3jzh+oUvx54gOW8MPQllOXAOtSqsx3
         fBuJbApPvb5YcaDVBzi+iqF4jKRop2JSNWkU3aBczpDBFnc7+6uHNtDHsK/xlnWTfRse
         3Zw7F9ROuyPUxmGSkk4haANcO4jYrYk91nu7EcMXdeBrbXiaHEgo33o8wnIYB2bEhS95
         NY8rJ3hOPwTQ2E+bvNWQOl5R8g6uuFHFd4gbcKg+7PVo2NfgyYdxZ0X8UOZizdHQlCVo
         TpDA==
X-Forwarded-Encrypted: i=1; AFNElJ+t0gLmknzKLRNW1tb2k5JSxTh9KalIkTYruY8/yYSpHhzBqJZhs6t8Zvgfg5QKd6tpYbl/AG3vHv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEMv5x4Z1lfaRz5pyQ108Bmg54hiLHV54zx8Xt/UK+bxqhikQ
	w41tm6BOSMUAWdL/KFhh46Qac1Lz1umtPmAc4hn0v6Wfwo2T4aKGXHjkU84FsBIsku143sXRAvb
	4hxis5SAmvhsDZZvSA1uNu9BKC06yKbFyM8a2FFyy2ov0/jUDYeyJxGpKtDoJYTM=
X-Gm-Gg: Acq92OEleHSxfDg8Qj6gQB4QLg0OLtCebAKmvBecIi6lr2Hlq+UdAKqJVbjGLVpdmJc
	WtDfpKhFJ8xdIPRgZdTU0uGrVb4ANDcu7i5yoK8tWckxi5bPiLHLYFXee+aXAJWyZ9S2U6Pw43j
	lwjb/d8+2AEiQh4wR7fulhUd16Q8idUkj+eA8sIv/Mu9uQVNTBjhrYfpkrFgkhwBZRAluMIEjuO
	qhsIRvT7NgZyDDVeDJBil6FtYCkBzJ1zPKuB6GcaAZt4uAugFJ4RIDKeqkofj5nIHCwzTWe+7f7
	iJrS6+ekiep2ZLNvLa0o3so7dfd4FIjQCE/cUA5qt5a/5eYuVSgJQoHA8W2Xn2cQMLDaijU6tAe
	P4HIjf4X3uY3WjHU/UxFmXE6Hf5JHKdFtGH/WEBtM64syBie/gd8fu0eLcaNroABU0oPyFredCX
	UWi2tl25rjY8DFCXRD6sXyTPje0c4DNGu9BHg=
X-Received: by 2002:a05:620a:269e:b0:915:3d27:a816 with SMTP id af79cd13be357-9161bd388b8mr1960981885a.49.1781526202982;
        Mon, 15 Jun 2026 05:23:22 -0700 (PDT)
X-Received: by 2002:a05:620a:269e:b0:915:3d27:a816 with SMTP id af79cd13be357-9161bd388b8mr1960975485a.49.1781526202441;
        Mon, 15 Jun 2026 05:23:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1b3253sm2757033e87.68.2026.06.15.05.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:23:21 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:23:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
Message-ID: <q4t5f4aiapowojbz2vh7qmcwvia56gc6ytzj3rys7ingisubid@ddlwb3qi5zdg>
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
 <20260614083424.464132-2-mitltlatltl@gmail.com>
 <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
 <CAH2e8h5Swn2mWoz+t_nrSw1=hQttwi1Hx=dg=cd9S3QRnHjpSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2e8h5Swn2mWoz+t_nrSw1=hQttwi1Hx=dg=cd9S3QRnHjpSQ@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMSBTYWx0ZWRfX0hc8Lfc5i5dg
 TKcBdKF8PlGSekoH4XpwG+lFRAg5hHRIPktZEzHNKm5Pk7Jq5/iy/CO9XrLNT9890cgnt/Chw6R
 BptbxoiK2q9df9C8y4RvcK0hzCSrs3qqhQOhedKw+Yzbi2mOFBmpmvQfna+oFjsRqZQa3Jpx9YE
 4hzHnlM8DTxY4Kbs7z9LFKxljv5Hi5Spx9wBCVr8VoZ4KBbzbN53M+Ypp/91DwQYMKArJXYwtkH
 U7SOYuJ4NIKjsb8KHgWiJqyQu5QhpHE6oxX4BJbsxbln+cEU+5OoCsQQpPWgXLcK7pI77L9ptvE
 QI889aI9FDvA+A/mpTfD2FfteGgdcPabP1MlugQnSKJf4NWxPdU6S4z51Uhh9TmYZ95dKw/78TL
 nTKMd7R2Q+wTmg+qW9/QVPzOS1DWVYPeXUUMNU0LdLE5LRTlN1WSFaPfyffzrmyyBRzFiiSvDgQ
 Fyu96H+02BKerJD+0Lg==
X-Proofpoint-ORIG-GUID: p4kiIK_0jMeHk2MCZts7b2swRDOyxOoj
X-Proofpoint-GUID: p4kiIK_0jMeHk2MCZts7b2swRDOyxOoj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMSBTYWx0ZWRfX8fBv7cG6zJva
 nvpLpx61FIdkPKhQ0cV2bBv/G4Y7geIRbHHhCaC2RNbToWSEGA6gH7kUiNPoqGjb3TnCt4algZ8
 P429qyYuZh/QLkc8ih/2QTzcEEgTnSo=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a2feebb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=Gh1C-VzVOIyvPQshHAMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150131

On Mon, Jun 15, 2026 at 12:25:32PM +0800, Pengyu Luo wrote:
> On Mon, Jun 15, 2026 at 5:18 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Sun, Jun 14, 2026 at 04:34:24PM +0800, Pengyu Luo wrote:
> > > Some devices (such as gaokun3) do not disable FIFO mode, causing the
> > > driver to fallback to FIFO mode by default. However, these platforms
> > > also support GSI mode, which is highly preferred for certain
> > > peripherals like SPI touchscreens to improve performance.
> > >
> > > Introduce the "qcom,force-gsi-mode" device property to hint and force
> > > the controller into GSI mode during initialization.
> >
> > Ideally, this should be decided by the SPI controller based on the
> > requirements. Another option would be to prefer GSI for all transfers if
> > it is available, ignoring the FIFO even if it is not disabled.
> >
> 
> I have read reviews. Can we check if the compatible
> "qcom,sm6350-gpi-dma" is in DT? If the gpi dma controller is
> presented, then we enable GSI mode.

Can we just check for the dmas property? If it is present and if we
could get DMA channels, then GSI DMA is available.

> 
> Best wishes,
> Pengyu
> 
> > >
> > > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > > ---
> > >  drivers/spi/spi-geni-qcom.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
