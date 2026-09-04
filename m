Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF653DEAF6
	for <linux-spi@vger.kernel.org>; Fri,  4 Sep 2026 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508616; cv=pass; b=fL7ekN7nbSrRAdklwXiJ2ly0vKXTJ42Nv7SZMUxBygIPqnVQE4LPtJ2Zt0sm18qmBZsy4zCP5KVAIV3EBgXzRCRqJ3ViNZUMCe+eE+O6tNBskUjCTbL9PnLvddTqB4TYjYj7+TAkYAqjvZYZtYKuF3FiYXrIu03DLRmaI+b4rgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508616; c=relaxed/simple;
	bh=aRX+Nb7hSCvEAQ13DkJCkSxFgBFsa/ETVg/ALEwOfh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXZnbl9PO2V5WzA+pHgCCoyf9m2xTQl9qixD22EED9BRoiDg3mHa17S8m9cErkS2qT1dw0Ms2WNvHEJ4czLgM8hH5wdxeZL3j5mur0SguMZkViwJ0JQ8xv7oQeX4G15z6ZofhPnIyBupKeZwMs3VDz28ClFPJgiHNpCKQSpyX1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lyMe15eq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hHR/XFgg; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lyMe15eq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hHR/XFgg"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847maON2838343
	for <linux-spi@vger.kernel.org>; Fri, 4 Sep 2026 07:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AsK6CNkPzqL+25hJDO5/FxatvGOrEq2Iq+btxLgvqQY=; b=lyMe15eqUhFeLFRb
	ZvQ0jwRyMlDf4mFoetfSpQzEYtL0ch88a/gfxsbX2JtIdepnq+rkvGYgQAIF6v9e
	gmYcp/V4pNV7LwqvRF0oYLocep8S0xOkDji5fdOx9fOSaMk69L39GDys5WkISYZl
	pejqQmGAmG78zYbDoAFL1nQFAkJaG6RaDB5fBDzjeTM89qI3wnMwkzcQZO30t8h2
	bqbETwMMnF72JwJQEshfEVrj/KPRGa8Suz3/9z7Kji2cuAoL5x07XOL/lPFDQptt
	GVKoUAwfrHe8rAgW4FXRSLVBVcBcJS/cwbn8P3M4+hXKcnpUA9dV3BU0D306rwo5
	q/4KZw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqtrfnv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 04 Sep 2026 07:56:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso1009688a12.1
        for <linux-spi@vger.kernel.org>; Fri, 04 Sep 2026 00:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788508612; cv=none;
        d=google.com; s=arc-20260327;
        b=GXoNraX6u6j+rB94itxcpRpBmaX26xo8nk/WqnLoeZAWxNRuPaNeWkIYKkn/iAV2+K
         coOTR+bMXeiwyjBY2SYl8yO2lPceE5eMKHIf1n6ArBH4ymkj0eLoS2W/pYX4Sm4QAypj
         fPI8VdIQjb90khwpu7fe7BWo1ezczrWVZSpw8CCd1VMUf4EY7VH1KniJhSq/UNdor9Ch
         SiVahJryDG7SwPGX/OYOOqDZ8sjfd31hOFOPQzZLFoGn7X//AipdGW1Joi+tkb8sEiUO
         NZ9x4Yfjz2UYkMvD8/GdV6m/UN8ldMBdK7DSU0oBQYwoq1G5gU9Qiw/hZN6xdgXvM56d
         5SaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AsK6CNkPzqL+25hJDO5/FxatvGOrEq2Iq+btxLgvqQY=;
        fh=qClDRhl6psJ1Z+jPHaCYOUfhUJthSaca3v1SGAEEy+A=;
        b=DTqr0azfChQeWDa6I1+pDCe8/uo0sK2Zx0Xc73u8ORGIjmRORjyguUP4QMciPliNts
         LyA5mgi5Ihuok1UNC8eGxcsmxzma7mM2KTgH1GUMdq/4HvqdYRchg4gwTBp1ZL46YJRS
         ilP4KyQjUP8tpxiMO9gasGqoIL+QcS54VKhVOau6b6+u62FORu6e2DVZQNF/Iqcp/YOs
         1VemIh6J8UhyTQl05Ayw7gaB368opF/VPPq4N8ZkBAI/NSVe0IuTirJd5d6ICETrTL0e
         0N+8ONsSCPwu0po77jD3alv1DdrXVwP28+YNtcTW5N107GdKC5w39yHfyGHcIPb3sT3B
         f6jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788508612; x=1789113412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AsK6CNkPzqL+25hJDO5/FxatvGOrEq2Iq+btxLgvqQY=;
        b=hHR/XFggVzTTLF5GKVJcaMbI2MbWz5JHpEHV0F2Ecjit4MJ5Tn0qfjJuNrUIT/DVjj
         MkVFSs8xJxg4DuMwguBIJG+afLWox6rkfh4INMqZsVYwFulKdi/K06Im6d2K9oj2TDNf
         SnfZE7a739zF1s8SsvKYSVga10a2nrPd8kFjIuB/ynOVFqqKUH30aStnkioFwjpUQel9
         fxhSEs36JgV3oDH4qpt/JziKW3roIxTBF/EVNpU2Get2uiJk83bVwjl5eaZGknQMY/03
         AaWXwErc4Lz1sfP7/zaR+dw15/u0tjXQ3LI8JogpUYWH31BvgEUYKTgD5V82VqZfdgSC
         8OdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508612; x=1789113412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AsK6CNkPzqL+25hJDO5/FxatvGOrEq2Iq+btxLgvqQY=;
        b=kXx7ij+8aui8+19UAHut6lO5sYlSOTKjN562ATk8H6cOWIX0VMx6Ar6kPj/FH+agx0
         YjYLFs2ITBGZwWoYTVgZhJJNalw4v2qKvPz2+QH2NqpvjjS1utb94jqMgIT5iB/m03gV
         /bsJcEGLu0+aSPTDD4kZtaLbaUiraBO991hcec+bJHhFQPJwTz9gMuOVYZBjI1WVO6v6
         PGPs368Uw/UzpccZTzW1dxSX4Vav95hWybp4TcQ7ROm7DltwUJwvD5loXrz2G5g2AZ5g
         qFT1+pT/G2XJEsWTtm2GIVBCeFH4FboePytZO2CIX3MzUubAeZCFEd2rdjFmyyf6DVJa
         3dBA==
X-Forwarded-Encrypted: i=1; AKwUvByxmk98/tWiFip1heQPR1DxeZgn2EKGiRhcnhA+2KkTl7osNUpH9UOgp8U3uY8P0ZWwPC7z97eRyW4=@vger.kernel.org
X-Gm-Message-State: AFuF++lCGE49p6Q20HWiakGpIVo3mRncmP+xsZEsrJ4U/ugpr3WcXVmO
	QLcbWTNUO5CJ7DoZ7ZnYuRuzltHh/XfmYCEppk+ku3QGsxaCTpQYWFNhcVZO5U4nQrsStr+o8+W
	ioRgkiT6m1JX+t1zJNLE3x20MRSi5M9DpNN0h/X4pEwRczlvjKz+Zp8sVP7A34trdnsxzESvEMP
	F1nRzI8MzTQ6A6d8/Y0ibK9hxj/h2pWJnDn3Ffrw==
X-Gm-Gg: AYBFou37RfuXnordOtVm+1V0/K89WC6uw8Zxj6SSvPIDHycOC2+HnYlM+TeRkIfRHDL
	ahLsKxHn+IyBat2qdkTGc8HF3VuGOSFrn9CcD8tXzr3zKHZf5LxQumXet50BZMoWlDvwIe3IYNf
	bo7FDOw0Ch1nsQP4rYFlcf1VI0i22OH8jcGzVsi8A1rapFGNu3Oibwey2C6A==
X-Received: by 2002:a05:6a21:3989:b0:3d1:af47:5f80 with SMTP id adf61e73a8af0-3da39f77bd4mr6420636637.11.1788508612174;
        Fri, 04 Sep 2026 00:56:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:3989:b0:3d1:af47:5f80 with SMTP id
 adf61e73a8af0-3da39f77bd4mr6420552637.11.1788508611689; Fri, 04 Sep 2026
 00:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <CAPx+jO9fcvBsxe9yx9oK=0EXmpNwub5ba0a-TGk1WRFaRGsqpA@mail.gmail.com> <177884a8-902f-49be-8fcb-b2bec3ec7d6c@oss.qualcomm.com>
In-Reply-To: <177884a8-902f-49be-8fcb-b2bec3ec7d6c@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 09:56:39 +0200
X-Gm-Features: AcwNN1UllrxbRYClFejSTOv1mPezdKyC-qM3m7DiYE7HdwsmgFFrqN7aqxA-MZ8
Message-ID: <CAPx+jO8bXn2F3cWz87Ozjrh00E+a_UWBrHeUViTEkTL87JHW9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] soc: qcom: geni: Derive SE clock configuration
 from OPP table on SA8255P
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
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a9a79c5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=D1j1bUi7ZpnfGdUu11IA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: LNI4Z9cX0DYxgkP_N7Fn4Ac7glV6xAx7
X-Proofpoint-GUID: LNI4Z9cX0DYxgkP_N7Fn4Ac7glV6xAx7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA3MiBTYWx0ZWRfX1kr3539SZnE5
 1jqkqd4BYo+BQkp7IF64yAB2eH1m77KuoUnjnyP+bEG3rFF/Y6UkHqU8/kfPzF/FDL/hhDRs6Kq
 8Y/EkebhEvhqJq41hBPGzE7y1phQSdU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA3MiBTYWx0ZWRfX0lldaI6sgTrx
 7Yv4mtZa6VtfiB+ZOuYxlJnjYUCBer0qyc0I1H9c7fzMpI8AxZL+BmOlCx2UQ5xI8WecJYrbQaj
 UlppnOOcMQdVhg7VMIGkzrfxhdRoswCNJ9h9kL4oItZkNQ3T1/cWawJlUwVan0x/Y1nzDxxt79+
 IY926FOz6C2TBBrh14VvtP6nl0PApEMVvyW5j0O89f7aLXUeM1yNfNxtppjdNWbsgLHVkLvZC+F
 uv9JZQd7iRiNMPz6QsQBXGAQo8PxlkK2vMlB6gWpcx3FL9Gm0D0ig79tSPdoKDu5ILhQRRCbKS5
 0Wxz+V6Jw3bm9xhrnw+5jfx3QargjNDJImhmoLkobzf50nxqPw8gFDvtMQeYt/d6AgjmJJA0OSj
 MbTXtVRHAY2UauEbV2heaAKwk0r7Axyha5GhZY6vxTuGM7dOHVbgmpfr5o6F7WsQLs/w+h+bFeP
 epzCeiA0DHnTkr9EOhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040072

On Tue, Sep 1, 2026 at 6:48=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> Hi Ulf,
>
> On 01-09-2026 20:22, Ulf Hansson wrote:
> > On Thu, Aug 27, 2026 at 7:59=E2=80=AFPM Praveen Talari
> > <praveen.talari@oss.qualcomm.com> wrote:
> >> On firmware-managed platforms such as SA8255P, there is no Linux clock
> >> handler available to determine the appropriate SE source clock, source
> >> clock index, and divider values for a requested protocol frequency.
> >> However, these parameters are required when programming GSI TREs, wher=
e
> >> the hardware expects an explicit clock source selection and divider
> >> configuration for the serial engine.
> >>
> >> In contrast, platforms using Linux-managed clocks derive these
> >> parameters through geni_se_clk_freq_match() using the source clock
> >> information stored in clk_perf_tbl. Since the firmware-managed path
> >> lacks equivalent clock information, protocol drivers cannot reuse the
> >> existing frequency matching logic and instead rely on a direct mapping
> >> between protocol-requested frequencies and performance levels. This
> >> creates a separate clock configuration flow and prevents
> >> firmware-managed platforms from deriving the actual SE clock parameter=
s
> >> required for GSI TRE programming.
> > Hmm, this sounds like moving backwards when it comes to keeping
> > drivers as portable as possible.
> >
> > I understand geni_se_clk_freq_match() has been around for a while, but
> > fortunately its use seems limited to only a few qcom specific drivers.
> >
> > Rather than continue down this path, would it not be possible to find
> > a more generic solution for "geni_se_clk_freq_match()"? Can we replace
> > it with a common clock/OPP API? In this way, we would not need to
> > sprinkle drivers with calls to platform specific  code.
> I agree that protocol drivers should not need to know whether GENI resour=
ces
> are managed through the clock framework or a firmware-provided
> performance domain.
>
> The intent of this series is actually to move in that direction rather th=
an
> introduce a separate flow. Today firmware-managed platforms cannot use
> geni_se_clk_freq_match() because clk_perf_tbl is only populated when a
> Linux clock
> is present. This series derives the same clock-performance
> information(clk_perf_tbl) from the OPP
> table and populates clk_perf_tbl during geni_se_domain_attach(),
> allowing both
> resource-management models to reuse the existing
> geni_se_clk_freq_match() infrastructure.

Right, the goal makes sense, but I am not sure the proposed solution
is the way to get there.

We really want to avoid having generic drivers like (spi, uart, i2c,
etc) calling platform specific functions. This isn't just me, it's the
general way for how we do things for drivers. Of course, we have
exceptions, but I think you get my point.

In this case, why isn't it possible to use the clock and OPP
framework? Is there anything missing to make this work?

>
> Likewise, geni_se_set_rate() hides whether the underlying implementation
> uses
> dev_pm_opp_set_rate() on a perf-domain device or a regular clock-backed
> device,
> so protocol drivers no longer need platform-specific callbacks. The goal
> is to
> converge both paths behind common GENI helpers rather than maintain separ=
ate
> clock-selection mechanisms.

The OPP layer already has some capabilities for managing clocks. Can't
we use devm_pm_opp_set_config() to prepare an OPP table with the
relevant clk data for the devices, as a way to abstract things?

> >
> >> To address this limitation, the performance-domain OPP table is treate=
d
> >> as the representation of SE-supported source clock frequencies. During
> >> geni_se_domain_attach(), the OPP entries are used to populate
> >> clk_perf_tbl and related clock performance data, allowing
> >> firmware-managed platforms to leverage the same clock frequency matchi=
ng
> >> infrastructure used by Linux-managed platforms.
> >>
> >> With this change, protocol drivers can use geni_se_clk_freq_match() to
> >> select the closest supported source clock frequency for a requested
> >> protocol rate, derive the corresponding source clock index and divider
> >> values required for GSI TRE programming, and apply the matched clock
> >> through the OPP framework. This removes the dependency on direct
> >> protocol-frequency-to-performance-level mappings and provides a common
> >> clock selection and configuration mechanism across both firmware-manag=
ed
> >> and Linux-managed GENI deployments.
> > Rather than adding yet another platform specific method, would it be
> > possible to extend the generic OPP library with the pieces that are
> > missing to make this work in a generic way?
> I agree with the goal of using generic infrastructure. However,
> geni_se_clk_freq_match()
> derives GENI-specific parameters such as the source clock, clock index,
> and divider values
> required for GSI TRE programming, which are not represented by the
> generic OPP interface today.
>
> This series does not introduce a new clock selection path; it reuses the
> existing
> geni_se_clk_freq_match() flow on firmware-managed platforms by populating
> clk_perf_tbl from OPP data.

So geni_se_clk_freq_match() is used by two consumer drivers today,
drivers/spi/spi-geni-qcom.c and drivers/tty/serial/qcom_geni_serial.c.

Beyond the $subject series, there will be even more consumer drivers
that call these platform specific functions. As I said above, I don't
think this is moving things in the right direction.

If this can't be solved with generic frameworks (clocks and OPP),
please clarify why so we can figure out a better way forward.

[...]

Kind regards
Uffe
