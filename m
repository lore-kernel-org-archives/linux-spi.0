Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752DD3F4DD2
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371579; cv=pass; b=SvhogL//muRMkE9vK0tusbZeJgnbND7l00dy/LH9o+FOWnoAuaPD4UvkNkXr61wRZCkcbrMXqZ7NG/C5eePl+5XlHG7xYG/pVnQ31gM4o8lPd/vpYA0vQlFQpPK8WOCr7HYmM55JZjT5retATxsjR65Wmc5Zv5pQu56E7TF2MtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371579; c=relaxed/simple;
	bh=n+Ksvu/zVWPobgx5KX7GBu9XwArpcsGtQQ3SBCwrIrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3BVMvHtMYLLY6HOXWqI3mkpmxEKKCl9cOpkigSJjZ2DgsJNPT8VHcE97ZPomiyW4tyyOgtBBqKSy+9IsB00nxSfujdoM2BtQvbuFANE3mweqz5CXDeMR/rVjLhVPeD4d1jLvrGQpc46UG4eSyQiAAoO4XsCY5iUqs9xGq02+9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ev1TpKH3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UCSWrhxp; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ev1TpKH3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UCSWrhxp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACj0co1671296
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 14:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=; b=Ev1TpKH3ebEU1fy8
	g+4xebhPHPUNEgczi4RSZlAAra5Cj91TiMJid3WIyK5/K42u1qxUcjk7uUCBQHoM
	D8o21YcfVK1/Y97choME6/qa7CdDIhuHrlaVEOIr7xgiuVzpWUQGLsJRHjecc0X8
	5OmdKvdY1UX2SdEE6NQg2yuWzpmvtnJjOYPGFJ+VOPekQ4vxFoORjT1aoxhP7vvV
	YYapTAPpjm+7JFbvSNZqrR5jaeN6QyO+1y8HV8IIM1yy0lsfCMSKDFY5nXQLSOGp
	AE5sKxscyBtkwJygu9QY3Z06kIxGDzYvIbVbErm3jiF7vYdIQvt+b22j8wAU+yxK
	2sR7gA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v2a03t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 14:19:31 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ef8249f73fso35701926d6.0
        for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 07:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786371571; cv=none;
        d=google.com; s=arc-20260327;
        b=IKKsqqjBdgYgsryoWqNp3i6aGBDhPwJrT4meir0F81XMTB5HpKh5Jk6HNnkPMCCvoG
         ptcKJxsXLTxtPiYNzBtsrqQbQBKCegfkcDKTFsVZaGYnXAK+dw7UlDJHQH1B6H2vVILb
         BxbiH4/ENKjn/DoMBw80V6/WJnJ/gzME57fNIR56hR+vZD8mJ5eYts9fR9ShYCBP8ZYO
         SyDy3nW6LeygwtFwqzp6PNjB+ChTbuHYCdvC7VD7TXZ/PqoWySIi2onoqx5yFOMDH1XQ
         QoCTMGJ18+TqgcrDf/0+WZfK4MFGuzlCJ7p/gYc/DN394DNTkPMCQklCdELmZMlrEbgU
         X0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=;
        fh=Y6e8jPO6pL9ztP438U+C1dIsouOfhuIQ9iddRfVMMj4=;
        b=Cve+Xmd1TdguUFFyuKwbe/d+KanG+Afbsa5Wzw43oRGqYYjmk8l0KqIwybVsbaYWzg
         rAPk+02cROGUikVHgiQ5aAscU8Rkp5lknLGgU01M98VTwZQnW7JrvbZw3GIM22inGoI5
         lkvoHwXbBbFzwFEZn7Z82/yo+Tl2oNU/hCthhjpkgl9qPddM08mHI7Psq/X8Vk2vyFsI
         xNYqZNpoMUDvOuv+qDGRlWNz6X2bFEM951O0q8O5mkB0z0nA96AzsoRClntlWUJM60Mk
         EiUhts+t4hXahmiQosLSfRPTeVknrUTvyaZoOyoVxXgRNImqM0LytO8E4k9jxWJxBZty
         Vv9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786371571; x=1786976371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=;
        b=UCSWrhxp/54c1zxxL6Rv0OqpS43JyRPPHsFf/oQkkHaUQOuChZcrIFqUkWKg3p9f5s
         3n4EjZXaclrirDAZiiexpY/RjB8zKPSQYceo8AasR3z1PQpPvEgeb0fxo/isuIARZGnm
         JhV0uTjMlissRcg6nvjGHn721k/7qrEus1jbl/ZKMYBsYZcn3YkpDdAHKnek8QKgqNDG
         2HlvGa0bplBCE8/Lbm9A8Vhn1apQQQeEqh2E39dnClzQrj/Q/mIPMfcWawvUE4/FK8FV
         wbhn/Gfw8Ko3WABUL6XQI7uUaMwyxTUDlYcCAcvIbaVT3mJuzdGNj2EvffndKF/R+km7
         4bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371571; x=1786976371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=;
        b=WPlB3RN9kKuBY+qls+tewa4RGWFQDpgJbFVVTY7hzrqNKREFyw+fB5fbXEcvrQA911
         4NLSVROtsYSPXI1TEokcPZN/tdPfM9mybB9isaTQD3EmvykJM4alpSBgEnK4V/6Juj1Y
         Qff/gL/Tdzn7nR45j8ZmXYBQZgbk+BLvSUIui1Bht3+4a2m0rvdzVJRvwKSBuYnwG3Xy
         dSvPq83bGYUhszkX9ciNax7liG4M3msoCONK8+V/ajchO3A8egxkG24J03TYk3f5rL4V
         H0jvm7+rK5fNo8gStX9PaGWwF8bbIxlY3a44C1U6Cy+zjuL9t7RsF0Of6H/zzd/Brf0l
         4p8A==
X-Forwarded-Encrypted: i=1; AHgh+RrgpWWI28DGdd911z3xaHZceGUB7MAAGjtzMDP854o6GYY2rnNTm9I1bn+GcPdf5tZG9n7tNLNXS8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFdLaEgce+J+O/esX31sv/F4w0J7oEguSo1A3UImORMXxxU8k
	eMDxzGQzQe2DKitSzIP+yZF0sMnJub9X4xzb/K2Rb2T3JqaNBG7zNkNyan8mmkDmUhXAUFCyIMV
	6dldcUYCEx7/PnwLF8oYZjebXtdth4UITuJ9iA5jvpejMljq0MYNCOo9BNKYsBoFU4w+56K6U2f
	Gf4P8dHMtEy5Vff1fgBJV4W0styBcEx1rkA58TkQ==
X-Gm-Gg: AR+sD13Z4xk9R4cf43vYYOe4XbG+Z7FCamolRVuUKvGAszgRqJRwda9Q2lcaZztBKVs
	iLbjm27iFNg28Ejs13LXMraFRORn+B4HlKhALin3tASenrBAxgcktgMshWCwdTTG2tHEEw6Qxjg
	d8CgsBZp793eeMWiB9zGgdkf6IiQPD9iy8fSupf7QFviN916skS1dt144lVg==
X-Received: by 2002:a05:622a:4c8d:b0:521:8ef0:b4e0 with SMTP id d75a77b69052e-52d4bba4201mr24352661cf.17.1786371571031;
        Mon, 10 Aug 2026 07:19:31 -0700 (PDT)
X-Received: by 2002:a05:622a:4c8d:b0:521:8ef0:b4e0 with SMTP id
 d75a77b69052e-52d4bba4201mr24351481cf.17.1786371570441; Mon, 10 Aug 2026
 07:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 16:19:19 +0200
X-Gm-Features: AUfX_mx3R25JFulSxbPIMFamz2pIVHYPn9K-rVq3DlUVa-mxAozC_itBBx8G2xk
Message-ID: <CAPx+jO9MZTsDpofZ0fR7FxJbrfuAV+soqN3x7ttK-F7o6MkYmg@mail.gmail.com>
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state()
 on state 0
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=S9PpBosP c=1 sm=1 tr=0 ts=6a79ddf3 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=IN2mYG8luz48gvOoqwMA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: vcQI0jXC2nDpdrBJbRC_KfpPgbnDQxXa
X-Proofpoint-GUID: vcQI0jXC2nDpdrBJbRC_KfpPgbnDQxXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX2opX9sgAm/Ui
 3jmnT9EitA4/4SqO8y5dh8F1HcL2Oyo3tkR4hSP0Wfq6D7ToC59he3fJBuMaC7aSgR24M9uL5G/
 2HmvZCmAIAgGrAF15388ME4SLKk+ihomzEm37WUWfB78pshVYNvmRgeBTdBJqr+7GMaDo+Zdzzy
 v4ROoEmhFAzD/F9j1srY9aCOU1vkfmwCuZf3vxl4wDw2jq/XUs/QpsH+1IjdUecXl+c/oTATwVR
 Ie1sRUrLl45nflka4eF9jrqHQavpTBO8oZwqViSbRF+U+sZSiJmnc0/Gi1ThkvtXFwnt1eyiHaX
 s7C+k72yAFVEGmhGtKOdRRTc+m/zxJqhaWgtYqDtDlxEIB6byIV8lwU1L0b5Dt9a1Xr2WdevS4C
 rIpBxQR1itIvyDM5FW4IsEKMoa7P+zXrsst4ESfly0FQbGyhDFiE9u0IU/H4fdEW0vCxjA45+ym
 yBZcKbE2CstJy+GPIvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX/KSx0SBERddn
 ImcVAJdu6JvMYC0Jav7v7NSUYVGLC/GQp9SFIniy/FEYqXByY9RxgaD36qQOySrE5yLHEEz+JZY
 CQIRQt2n61gftLOEbnkhCjELBzooyrI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100123

On Tue, Aug 4, 2026 at 9:58=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.

Yes, this is indeed a problem. I recall that I hesitated when deciding
what was best here, returning an error code or 0.

The reasoning I had for returning -EINVAL, was that I didn't want
genpd to believe that it actually succeeded in setting the performance
state to 0, when in fact it didn't.

However, except for the problem below with the OPP library, it
actually also screws up the internal performance state aggregation in
genpd, potentially leading us to running at higher state than
necessary.

>
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
>
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

I added a fixes+stable tag and applied this for fixes, thanks!

Kind regards
Uffe



> ---
>  drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/a=
rm/scmi_perf_domain.c
> index 3693423459c9..e390f902a444 100644
> --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd,=
 unsigned int state)
>                 return 0;
>
>         if (!state)
> -               return -EINVAL;
> +               return 0;
>
>         ret =3D pd->perf_ops->level_set(pd->ph, pd->domain_id, state, fal=
se);
>         if (ret)
>
> --
> 2.34.1
>
