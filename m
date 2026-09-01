Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50E3ADB89
	for <linux-spi@vger.kernel.org>; Tue,  1 Sep 2026 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273108; cv=pass; b=nA0DZCDoRxqbX/7cenh3sIRMvzc6KtuFIpAZ87Tc43o46f1MD/5bqGmlXFSQn//p3Ecru16714teSL8EVM1J/HB/fTfqTotJzHrbsbMw0d17Gpz92NhamVPlYQoZw5Y78qXrdnBmRID9IE/IYfaHC/0pO3CJ9fq9GTSCj8GYRNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273108; c=relaxed/simple;
	bh=CL+Fm//7PJAuTWNWRctOu0wP9tKrbcMfws3PNuylb8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfc3bzTneFTaauyWQOyNMIj1gfAmDkowUoqJt2wmFHSdkrZgmb42jOWnMBN761QmZHBShM4bSX19kf8oiVwvr36ppAVrFaZyYBgMBb8IlMGx9OE+CqozceXDGCe+ueoSRuT5f+O3pdJRZKlvdKL+ScDlcBruwvszm9971CgdNEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TWKV/Sbg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MHUJpS+J; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TWKV/Sbg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MHUJpS+J"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E9tNT2648614
	for <linux-spi@vger.kernel.org>; Tue, 1 Sep 2026 14:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=; b=TWKV/SbgV9p0gmBq
	Ix/czCMtVc6C+fPEUJMX/wN5rmWOaY2sWrV8k3FCPsPVdBHPZds82x79UGxpCqCp
	/pVpjTMlX8ruOOfAB4pzE0il1Minieoe88KD9Sw4VJi1bgOh+zoS/6IfzDz5g8KM
	J4padN2WR4QivG/XXxD+bL//mbXyEPOzB4v81QzF5er6+cvoinwDYAqvjPEBlKjb
	fjX5HcnJIoAASFUUS/1g6Hq2e6QJhqKeo3LNE8Ut9OkR3ueWUadOU0OQD4ljSMCK
	j2mGoFWfUxYrnESW4/FvIxt6z6yf87rCmLVgMvOg92INvotvppxD5od8KkAFNDZv
	mmzjXw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp8ftsq4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 01 Sep 2026 14:31:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8535cdc2433so897508b3a.0
        for <linux-spi@vger.kernel.org>; Tue, 01 Sep 2026 07:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788273104; cv=none;
        d=google.com; s=arc-20260327;
        b=ZrJhDcyng4b1oE9Phi3XsyWn+PsyK9Q1M//dt2riE5rw41hLMKHZuCqSwuuzAoqbPj
         VRz0zJkY98dD+3W0pLQ6LVsxsEAPNORWv8dgfHhLN9Rs7mTcl+TOrJHzNXRQgoWRvE0p
         9JAei2AxV+h7NF5LrwpmJ+zCDvjdOlShHvZqQF723KlDpFzvBvhoQb3jy9FkInPyWW8U
         SvYXHuU+sikY8B4gfxT3TByMpWYXrXKY5qmC2+xHBwCurKGy5QeNH2avqtb+SURFT69z
         fNYIN05VyyY78G6v6Ts61hFMdrdYwTk8LjBKRdGow2AiG075ZcDeSeQ76rPDr4KkhhTz
         TYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=;
        fh=aNGfui/ShnP9ePUObldAZ4CRYlNq1K4O1xegU2G3ZNo=;
        b=fkjmsFCpsE9QLCgpfkIUlA1uvXm5o9DZbjT+4tg0H7QR94h7Z0NIgjXvukqbOYcuAd
         XMfb4y2cw0ny15NRtAziIoD6aPlRnj1AK06so5N0nRoQ1vxzHtZMI4lNTgSKdeXBlu2j
         ZewBOJeb9IRo2df6FdQVto1Qw50knY8hbj3d09U1NbQKVCW1tZd1RPThtcz3JDkuy9Pr
         A0M5219+wAbKvQ2Zo+K88V4VSOCy7nn6/4Xs48un0ooYjBTXAbu0qNExjfu16YCCGdGB
         riYySAvd0AhpVlDRKqcH5/rWgI6kzb0WH0arfoFo4vrFsMqvL4H6iFesSSjcWdmyhHZ7
         viAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788273104; x=1788877904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=;
        b=MHUJpS+JNG++WoSWrEusvWGQMqlLb+1WmCAkp+miG6kasuPoeE49mS8n7EzTVE2WUl
         s95CVfOFKfNjrElcCawac1ADbMDyc8E32+S0feYuZoYFvsar7b1F4KT8ixYVsoGrEzSh
         6VHSl0jYgm+3WW8E9FjvQFb2czYam8VpCI3nQLMCkz5xAqEgDHkFpfuIQph89MTzBSC5
         E/cfUPjZuZkHiZUfZdXQrFo9OD56US+ILdg8evX8Enajd9ij5XyZLZM/Bs91xmFiG62B
         UJANEaiKgCk3ahQGG3i6rxwj5D+ewO0pdoTwlIGI+54ea5lCe/vO+BTCaZeyBW+Lo2Do
         FSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273104; x=1788877904;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=;
        b=owM5fXErOEE9CW2oQfzF42NJSpNm/97EeKc9fpE1QFYL8FEVsCSOa0/FU+xAGYfJVg
         +jsisM4Pk1D4eGcquhKtvjFJnyAuIlKS8nU+v0wpishTaHj/rguws02qanlGZaTbafJ7
         8zReXM3WnoO4MU2rfJGfVzzn1r8uvSMkyXjW181V16IjpyfmIFto7g/YxQnxYRsuKaBz
         1TaDEZOXeHeEJxQc2ZxY9yEoEiv2K47MzoGycYVMxH2xW/oJMqIPlVNuj3hiEDy54gy3
         kh8004WvTD14pq0G1tbr4joWpJr65PWbPEkELJFujgHCh1ql2OEot9ASWKAgzf8JPoF+
         rx2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp3W2CYOrxi0ehSm6726wU5STGfNnTjF5be5BOHzaB1ila5wiHx6GcDc7pzr4UGJsjXS3Sv6m1KMMk=@vger.kernel.org
X-Gm-Message-State: AFuF++mfditPlZFo2Aadb3bNEbjS0RLCRNtf5ZDX089kwtyC9T0Q39Mj
	OkHv0WfddRo8p1QrxW5R2jHn6v9d4urxCU+FGHc+GIGsb/fjJ2HMlLOvndpSqh9xm+JL2YtcTLO
	3L4fnxtArzBevtzzPAptrOtUDzt067dVqxvAmuDGiW+eRURIqh/ZdHKfCzmobTnWGeMsl0TXq50
	jtnxjHyQgA8Y/1mlXN2cUOAYK/6m4XvWU4jzCMkBSiSPWh0OOT
X-Gm-Gg: AR+sD13SpzQ/fq35mMmGiqaZyLj9yvsWUE8PpqqpY645dz39eZO2GtQpWb0PBuS4HOr
	xmpa+i+kEwcO2ysYXB/gE4Of+3LDOavrhAqb+tzHj8KPq0Y3zPGsPKLhP4FBKi5+clya042/eEQ
	SjjbRrd4/BndJ2UHGkb/JU2+zQIEgGibKKJnZ+TtI+hNx6Ul2n8K3aLyrxow==
X-Received: by 2002:a05:6a00:420f:b0:854:b3d3:8631 with SMTP id d2e1a72fcca58-85bcacec88dmr5179002b3a.12.1788273104255;
        Tue, 01 Sep 2026 07:31:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:420f:b0:854:b3d3:8631 with SMTP id
 d2e1a72fcca58-85bcacec88dmr5178917b3a.12.1788273103642; Tue, 01 Sep 2026
 07:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-1-091697dbeb02@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-1-091697dbeb02@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 16:31:32 +0200
X-Gm-Features: AcwNN1WwQtMTDpu5tktdI1Fc85e8Ltr3tWd5G78kHHK2UXE66ekj0IR3sGBbeCc
Message-ID: <CAPx+jO8HQj4PtBScf-w+nQz-9xe+7QxZLMtp=J=sFSwEHVLL_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
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
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: -j75m_89xkCGHerGwsFTTc6tK9vL6TBJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyOSBTYWx0ZWRfX0rh2rEIpkIen
 /PuoLgeRQERIWK3iopFHuGc4wvYtmb7xAghccXggWDcrutTUrLiQ0+D59cn/SZmr5LuHDNARDy2
 NEAHHPeNjD3i4pAOZg42loEqvClmQRc=
X-Proofpoint-ORIG-GUID: -j75m_89xkCGHerGwsFTTc6tK9vL6TBJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyOSBTYWx0ZWRfX2LRIzSSwia3m
 VJzNqPwcBIn/piEojTkIgI2/ksa0X2Egl7DF4hVlF8appEGRzwDyT7IYIC9k8QvrNsiE0qaYVFm
 B1CgMdvJ+xj3tDHl0cXSagsaKG8QuGfQ1FDA9qKmihH8B8vhI9Q5DC+nWvD+5Mk3q2YZuMBd689
 dRYHvGfZF81VWq+5/2xoP4ZJ8aj1TfWav3dfSMjiykMo0tA3LnMdTdafRphm9xdnQ9YI6P4celG
 a14sRj/DKWWSM9CuECYxcOdHvVfyfZrmdu7KKXJpsp1ANMhEu6wGDxoK8g5LyimnNEnUsLdcjE5
 bVGAttGZpGW+Vo/HFU+73RvfPKbxyoa+tRbaRXyQ16djtMyDM+sW84XkQNI8eQKX/7zx/772pS3
 8f6h6eOVsVic42ALG4qEyAcLNWEqi9ZYddRKJA6gsG7Qfg6L1iHnbkAKnBrVXCzK1hgkCl7QKq8
 NbeFtiNhnnHN/d3oTrg==
X-Authority-Analysis: v=2.4 cv=BPWDalQG c=1 sm=1 tr=0 ts=6a96e1d1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=iiyz0f3IVUh47B4zfGIA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010129

On Thu, Aug 27, 2026 at 7:59=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.
>
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
>
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

This is already in v7.2. Please rebase your series.

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
