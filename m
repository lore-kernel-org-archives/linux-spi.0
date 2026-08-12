Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB53EAC8D
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525094; cv=pass; b=RmvQ0ohGX/fuiL/pOjxL2bo7xd/Kq6tF8z4GkP32jadOoK/Nxmmmx5A3t0n9vdSG6a3qJKvozfG/64jCDKozw8XnkyJ0SyXNRZwMdVIJ3+GDuo+CqSqpwpDjEZRXSp9JRUnRB+TeTJ6wirynkypGYWNzp0YpldESp3HaIFPUaE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525094; c=relaxed/simple;
	bh=J0DBJDhPyKi4K64Ojy6y17lBqGHCMu6qO5alVMzFIw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELKzkMWl145TFnPKWJG99ZmGC2P2d8KAT2jBoVysY376UwETdZw1E9C0eVbAiq7O4PlaBCZSA58WVghZIou7mjv8SIPLNlP7yDz8vf3rWwvMkFU9qqhZycgRMlukgD6nx3IUEWR/BNsXoqlOx53lLcTr88Yo9kIc8QWMqnkXVgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GLN4Thzw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=grKDoszE; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GLN4Thzw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="grKDoszE"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C8YGlp236303
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 08:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=; b=GLN4Thzw5ppeE/wd
	AoM/dI436IbDimGs9DiOG5iPm7qlx7v6S7ZCsWR5VkX6AqY1pmkxpxFieue1OfwE
	uP6toMsp9mFWD4H8oo74JxFN9Uy2fTTcpLx3+PPSNqpAoRyV8on7fVC/V9hGkHEU
	jNl3i7/7rzkLABjCcbrgPjKcje0Byp9mHuIMQ21dnkMxYoMpUj6/sCSoshoJ0mGv
	sEebEGKjtdgAeNtkyZD6m5oYasD9OiE0K57Zn4jMExI5k71q7lRgP8Sfv0tp4RZA
	GkKGzEYPkJUm+7KevEH3JBqjtx7o6eEWMvOhpmg7vQWgQw50tIJngXLdC7yGIGsn
	jqnT/g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049bvcp7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 08:58:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso2190264b3a.1
        for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 01:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786525091; cv=none;
        d=google.com; s=arc-20260327;
        b=jZvWxB+8832CFnueaZ92C4BjCfUFlBZCVQsPfkSlN29OGTZKryZNzTVg8aGIFCCKV3
         zJFJcvo79KWDdiZkL1RHXaIn0O9HLY50M6+IlLO/6RqvskdTI3yCXXeXfxXpgLroKosF
         i8rIwV5QzppMGr3Ff/cFPPUuYDHIvboitXNUXNj2X2RXH3EXrCwcr57yMDY/wJo7hGSd
         CaIXvYHVywA/pNsh2dQzabzWA+uOhaC0eqn/xplLd99ffdlzm/mpt+HffVmcTEy1SsA+
         2pHSYWAnTh0MeXELohw67ECjl1QGPJgwR6Rc7Rswm6tEGzbe/RiFHAxOFOkoP1xQemIt
         y12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=;
        fh=MdkGRX0J/ma8V8JeCFCKVrp9sc2LLLO0y3dA5M4/AUg=;
        b=ISMEPGVM7S5ncDSHmD2MLW6SVltGvP4Ia2TYgch2Rn3lglWjCS3BANUuw4nzMdo7OI
         oTgNelH6ZKCAN1l+LM62Tlsj/8xEgIzsTN5M1dvkSrYGD4fz1NqFQFo5R0c5MwR4PJJJ
         Ey5a0GJ9a4xEpmpsam4qlgzO4SOqc5vYMFIMKVFStb+9RSklFW4sUa7+jrs38LBLdFis
         bCcpXklKO3JwVEolcpWghVwb51zbWuTBbo9TqZe+/CT/6ewSDdSHTvOmlL6pmwG4foPX
         Ryt5TOuRIy1panBcYGrFf/32PdiBqau50EzbNgBo/3sCSbR0qOgPtHCs0Sg0ybMw414C
         PlIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786525091; x=1787129891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=;
        b=grKDoszE4bHmiPL64Y6bp+0dIoBtk18FS4gYbk2RaWfNjKoQgbD5gN7YTKEdfUJSOL
         thFuj6H/U8RRHtEi8X8Pp39QgOo9tilaU3Ejw2VGlOvC+YKU4lMAWtzepYjXupybn620
         b4462p3hpwAZw/KIu8iNAPDX5qZBYARjnvMp4EVp4qrgMX4/ScMr5VtkBNaZYndxMOJq
         +Ur1Eo/EJdUc/Q1NjW6VewWS+iqW3T3sflf6w8MEnziw0h4adAK2q3bfTBCgu5+rwf6Z
         sqRvJYWUNIEF8e/h0D6dQUQJfvbR1A1wSNpP/hI3MJMb+0DzxKcgIQIqAmDi2ZCPRKwd
         tezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786525091; x=1787129891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=;
        b=FEyN4KaGk1AIYPLJyiZAR+5axdGvTx1OU//D/GWlGnn6Nmn01qjHbyy1Q32nJeGRhE
         w9w8kAGlF4k9TR6WT66LCkvA0Io9f2Hvu1dvfe8dIhSwLv0wAKJUgyZR01AWieiTp8+n
         TtOvZVTUELZ9GGsOH0hnFf8lu+U5wYoC43KrNicHBU5Lhm2L7tYUcyYNzu2Kt623oq9p
         B16DXsOwI1gDr3dm6fQG3R+yMQl6zkkUtvd3NLyXWNuMGT3HuwTDRY5eAH6GG1W3xFcv
         8onUeg3t8qe+CYH+ZYRN9o2yTX0bJb5aTLuS6SUsv+l+QXN1z8fC/VafonqphoY2L3B3
         Z0Qw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2h7nPeb1I0pwfXO0d+6/w45Bk9YaZB1RoK88Y3wZiXogboVKlFzSXDOUWpHX8Y+PRzTZW8KYOYZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrM60Jzi9i5DIILC96oFXQCAG9/OJvHVllFca/1Hn3HUotChI0
	dC+o+MrnM6WmbdtfasspwLSJsQvhNbMS6OWGUo49tXqr1ao4Iv+RdFcKvoSam3LyL79e3hgE4aY
	9NNFJC4Y+6XwU5Co09NuycCqlNawl97pLwprquRUDm/Qh3etE4stGGlOPSb8kUMbG51Tp8kVJ70
	FdrSTxhtpBiJ65ZXTnv9JwPJ4mcl7JdamGrg7YyQ==
X-Gm-Gg: AR+sD11uDFJvClydijMkOdfVZlhZSsvc4TOxQhDw4NlbhgpQoKF+5wngJ2zgduNH5QJ
	G45wKkY5fjiwE008Nu8imywQTGcSBNlojo+0i5+mSMmtN5FGAc/PsF6Num3Z997Cah3nYTu8DTZ
	5qpxQIY1WviSkbdJ+wzEkncE7J3PksItAo07Wvxy9L+rmOmygTMACsKK2cWz6Beu2k7ZBzIpxJr
	DSOhWZc6f6i6TxwFA==
X-Received: by 2002:a05:6a20:3d1c:b0:3c4:1916:9d44 with SMTP id adf61e73a8af0-3cc3f913cbfmr3419282637.16.1786525091149;
        Wed, 12 Aug 2026 01:58:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1c:b0:3c4:1916:9d44 with SMTP id
 adf61e73a8af0-3cc3f913cbfmr3419211637.16.1786525090708; Wed, 12 Aug 2026
 01:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
 <d5d64ea3-9c6f-41f5-adc4-9923381d732b@oss.qualcomm.com>
In-Reply-To: <d5d64ea3-9c6f-41f5-adc4-9923381d732b@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 10:57:59 +0200
X-Gm-Features: AUfX_myh6JDkLkJD-gnKUbWgAMFmmHbyR3eCYV8kAAVu1iWiCFaF1Y5_s5Z16ro
Message-ID: <CAPx+jO_-1tZfZcjae9shyWcKPsj0fM1SvRzC9_JVOvJr--EeuA@mail.gmail.com>
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state()
 on state 0
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: FSKAGfNoVgmi7j6Bz3rMCPI5vHJpGiPG
X-Authority-Analysis: v=2.4 cv=ENg2FVZC c=1 sm=1 tr=0 ts=6a7c35a3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=4tH4gHCIEoDemCCG4kIA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: FSKAGfNoVgmi7j6Bz3rMCPI5vHJpGiPG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MSBTYWx0ZWRfXwO8snVsXCdne
 qlU3x1W0CiaDGOIGimQpc68yIvbbD7i6UxhezKtN91CdGGvQ9rAg2P74ZWmdRgrmMlac8SVH/PM
 EZYWdU5CLXHJxiRtdH+oVDB7c7FvD662QRld6e4Hbgrh3HlBzrC8cXn8qa3Swz4a67bfvV9xJww
 9ubWaSCiHafQQIla/GNRqW5MrFQK0+jONI84T5K5Qi1c/XXV7YgyG3Mj+xpQhLni3iwqMmSm61Y
 LWheXNY9tV6ZMWVJbjW6Hj47PQxz7VEQUY60YIrOQ4Z11mRROlK4DtzXrvQQQdUXZfmjuyh3OYE
 A6nusUzJ4h6TWAkjUTVlMBRpLKjk5qyqy27Vrm76Cf8Ox2GcHgEAtf9Df4mQBtnKIU6uokU3KEh
 1r37A4koyjcsYVncl5hqnYWO4N/Y4jmR74yFye1/y1kL++H+mRQSTyYaTyL/BkIvV9/LrrtB5f1
 lXTTTKnU3KDzrlc+mzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MSBTYWx0ZWRfX5zG/PvglnjD5
 1wnVS5PGgYpZC02QX0cqT7IIJKsmJ6UHl9i6LoXSR+dgALJ/UJT+sChH9HKnM++KQii4yA6+Kww
 hADzVODZRDp75q4lMwJJrX7R7jy24Jw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120071

On Wed, Aug 12, 2026 at 9:24=E2=80=AFAM Mukesh Savaliya
<mukesh.savaliya@oss.qualcomm.com> wrote:
>
>
>
> On 8/5/2026 1:27 AM, Praveen Talari wrote:
> [...]
>
> > ---
> >   drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain=
/arm/scmi_perf_domain.c
> > index 3693423459c9..e390f902a444 100644
> > --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> > +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> > @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genp=
d, unsigned int state)
> >               return 0;
> >
> >       if (!state)
> > -             return -EINVAL;
> > +             return 0;
>
> Won't this cause an issue to other drivers ? how are they going to take
> action based on changed return value ?

I think it's rather the opposite. With the current returned value
(-EINVAL) the driver doesn't really know what to do. It tried to drop
its vote, but that failed - so what can it do?

Moreover, from genpd point of view, this fixes a real bug as the
aggregation for the performance state becomes incorrect during runtime
suspend/resume.

>
> Remove Acked-by due to this till i give back.
> >
> >       ret =3D pd->perf_ops->level_set(pd->ph, pd->domain_id, state, fal=
se);
> >       if (ret)
> >
>

Kind regards
Uffe
