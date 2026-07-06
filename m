Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688F3FA5FD
	for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2026 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352809; cv=pass; b=j4kVE/mdIS1QKKzKQ9s4lhMXXIOtZIiGorzR1XIOXTWsHwZYphglSCxc2OwGWWILPjLC4KPW9UNqeoKD5U8OW3TeuYUhxZSWzEOq20byUV21Eu2sR5e4VhtGh5kh9nMcLfcgGGqCw4jt4VzWbdOKaav0vG5XBWt+mSUjPA6WQi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352809; c=relaxed/simple;
	bh=OT763+765AL37S5BJLMMQbirCxNjzAlqlQVzlwCI4Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyS3t5UGdVoKSJG7nfrIphI9Ko4RmGKmFJ9TC/wLT6AZaglftzff8O95XGC0r8F21OwRat9TRLswp5u99tAqGsdH928VtPRn7SUg8zUbsbqGUgnBoU/VQHdYpnOHqeOJiVFSHzH64Lac2Hk0SD2M2J8fiRT8PH+GpF6HS99VxBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZOlsPwHz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GEAVzxHm; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZOlsPwHz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GEAVzxHm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF7JQ990237
	for <linux-spi@vger.kernel.org>; Mon, 6 Jul 2026 15:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F1tL7ezKmgwPKPnJpdHXHHXoZTxCOuZrev6KT6hfwTk=; b=ZOlsPwHzz3/nLKmD
	mSazt2nRu9GtZ0+YjI7Krw93S8LOBlHU4p3rkx/C2yIXPJIgBIRFTlox35JOlumq
	ltVC9qqV2Nkf0VAvnssny5+1VQXgVZo0yAtbFxWwxyJ0ztuyo5bmRLPlcgKNTPi7
	RuFInMYyg3oAoXgywhKVuuF9IZJJHpv+5m4JLyaG8AyhOP+2+Bnxhy5fBoNHHt59
	XlzxeDfgZ3b0/h/9/LqVm+fcQsfZH+MRJpOlS/QdAUGjlsxbKmIMzDannw7pW6cL
	Ao5y2uvUQDeowET76q2qeK8zaXxcs3ON1S0y9FnWgr0Lf7RkvxRUbpzXNnR5I6jI
	6M8kfw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gsk9e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 15:46:45 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e9489f62bfso6640846d6.2
        for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 08:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352804; cv=none;
        d=google.com; s=arc-20260327;
        b=ZXv0iiz26h4qfXnbqitKvpQkazE0d350UpVVbC7scvL7yvOzqr20hVU9K0/35su9Ge
         1T8J/SrbPDy/FkoM6o4E/gpoypMECzI4GSjeMYrC8YwaRHgjc1gej09LclHmOCeZoT/W
         /C4PViuHcxgxOX8t4Tyq3+o6+4GT/orozGeJPyn8kMl0nmqhY/Zg7jhdJz6wF4owGa68
         8KUKhnO6fPI+3zfmULcddh2KHK1OJdNsagJmoNmblhYXezjh5eaADEc0KGljUVv0FBLR
         uu9Fz3XzqSEEXyhKaxvTQM/F3M+lcKULB34O9LAMKJJpA+WZfVZFboxno5IERssoNdZM
         sccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F1tL7ezKmgwPKPnJpdHXHHXoZTxCOuZrev6KT6hfwTk=;
        fh=SEJ2IUDod3OpuCSxgknVNSZp7p9pf73vT89cbOVfB7U=;
        b=D5o5vAM80WGX6Fl4v1v2qM+m3mDC0puw0phR8Jlc/GIyKU+fOEaMCdFEXRYnhyczkM
         P8waJQE7OeeFgpxUT3Jsi5nFVBoTl7GyOSTNgZ4UsFLkO7V30UR/au6tSOqKNC6R4f9T
         g8ZNOiW3msUd5LrA4tPNUBB5lP9X0dqw9H0mbKwQs71ZitOAjsZxcOl6f6zwHLFl4bQU
         EwloI3RSpdwyoMDhGRJbXqlq0vw/ynbKnVS3IJMprN9YeJ29WYararYtoOHQPxZmP47S
         AUTQzM7tjKutn5tzzVn3exBAnYvFXgRAG4bp0JXwozsb2YCuJKD0hHl/mIOcQn+qGzli
         TGXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352804; x=1783957604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1tL7ezKmgwPKPnJpdHXHHXoZTxCOuZrev6KT6hfwTk=;
        b=GEAVzxHmZT8MvGlOeA+dm3eELmrJL3uldb0hEDt6XvS4AFnYxXYJ+GWy0cTxdp8ySV
         WNLYI9SSiF80oGvLEccx2tsxZd76V0MXkPUeSoDlS//eeoGQFxXW2E11Nk2Bg9YxAO0V
         8w8YzakGoUY0AMCZCsS0GmcMYvZ3A9DWzDbdMFwGEMWxRX96ZEo1pHpL/U7tJg6HxHlv
         7ldnKsH8PoDwI1vdhyJCATI5KxqwBStowIUJzcoSqjewZop1g0fpTb5gtkCDZR1/3q4q
         XVvp6pD/T9xrD1cK8wEG0rwYxzpnFtxicgm0erDVfRMKXMgOrIUIu9oEVddgup3G9eIy
         +hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352804; x=1783957604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F1tL7ezKmgwPKPnJpdHXHHXoZTxCOuZrev6KT6hfwTk=;
        b=oMb5OavHvXP2mC9kR/7//ckHQQkzDTjdUYnj68zYybMvAV/A5bgoNX9BKQZ592K0/D
         8bEuJ9SGKhf2RQKc09dgsiIIjoDyjouv7PhcXA/u8D00n3lmnBf/pqz9uAFI9uMoah3p
         pK904tKxGgm+wAT1IB+XZHOZXWDWpU4rGAt+vzA+O/Bu+RRrK+y412jeUJC6ZnELHboj
         ir3WZHehwxypJdzw2VjV9nmAhB5/lF8kARW3CDDZLvGJunTG14OKPKEZRsNM6weUp4Lt
         GZlus/62rA92KsM7ne+eHkarrCvQheEP6CeqLkyqY++uVMt6FsMfvDa68WMopcfkYg6D
         gdqg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8pIn3zHCofrVzjUdiCruHwk+svwjNoWDn6h4feH4Ea5dIziRLgk7QXLGBgUyWL+zr/sR2E/AQakY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxab9LH7uy0i9wLroWFEqX7RUIu4eFAgm7OnP8Waba0RZV0RISP
	5whi7mM3D9AxDnD+LwrgaiSEUti3ohTGl+MWEhu/o/r9fmyMLQVnjtajmdZcdFT4w4VSstPmK8c
	S0Yd/KlCfn7Q2N7dXqlOrf56txJ76tMB9urKUFjTS9jX+YZ+lR/CJ2vs/PRvCqTTwF/4ixUm3LK
	L+oW/i9Qt8n7/ft/2V2j/KPwpzdTz1HMIZ7XT+2Q==
X-Gm-Gg: AfdE7cnCOZpu2kZbJf9dSKfRRc7oiUHNhJJ5++ZfUT144HKatFkZg6+axeHEmHksQmS
	7t+5zISPSd5g75PYyZ4HAJN3bWLCWPY3HcHP/QbyniHKOjFhAtABdXcAVQ/pSNVU2X8PYzOjpSB
	FE/Chp5PRnoVK/R5suylGQ6eOf87Kcjs1X95MM+KI16t1cmjeKcuVVl3YJAr2zLcTd5HIw
X-Received: by 2002:ad4:4eac:0:b0:8ec:235c:7a66 with SMTP id 6a1803df08f44-8fcb4c00ee9mr13393766d6.27.1783352803839;
        Mon, 06 Jul 2026 08:46:43 -0700 (PDT)
X-Received: by 2002:ad4:4eac:0:b0:8ec:235c:7a66 with SMTP id
 6a1803df08f44-8fcb4c00ee9mr13393296d6.27.1783352803240; Mon, 06 Jul 2026
 08:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609142139.1563360-1-gerg@linux-m68k.org> <20260609142139.1563360-5-gerg@linux-m68k.org>
In-Reply-To: <20260609142139.1563360-5-gerg@linux-m68k.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:31 +0200
X-Gm-Features: AVVi8Cfdl1DNUQnUfsfYJ-HKaMqWUP8hicUf_E8fyBBfHMErHTWhOeyxDX2mfns
Message-ID: <CAPx+jO8YPs-B1AJA6ShZTNMapFhmQgS79h7EHL7ZWQ3rc4g+qA@mail.gmail.com>
Subject: Re: [PATCHv2 3/4] mmc: sdhci-esdhc-mcf: do not use readl()/writel()
 on ColdFire
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com,
        shenwei.wang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
        nico@fluxnic.net, adureghello@baylibre.com, ulfh@kernel.org,
        linux-mmc@vger.kernel.org, linux-can@vger.kernel.org,
        linux-spi@vger.kernel.org, olteanv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: sYQIeUGwHBZysFS4PFPj66h20_Z3ray7
X-Proofpoint-ORIG-GUID: sYQIeUGwHBZysFS4PFPj66h20_Z3ray7
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4bcde5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=tBb2bbeoAAAA:8 a=IpJZQVW2AAAA:8
 a=GOXD6VkAu_hHpBIGSSQA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=Oj-tNtZlA1e06AYgeCfH:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfXzmr2lWn1N1LJ
 uCbrXtL1IPVlf8bPx4TT/OQG2NBKpSkMT6Vb3Mqdk7zchNcluAtcpGntyMHE+R9Z9eDMc6LJTBy
 yyFH+pP854mPLcBoBX5nf6B+YgCQF75/OAhJk4UlmjYf22ruIlChMB/iOMRVwW+xS17hKXvAsq8
 wt03euWmWOcP6/sNm+qy3KzXxTDO+w4Tg/hXqSHcm+jLVnq6H2hCMTH0YyFmpdgnVDPazwtmzmT
 oHj36tmsuqQszNWivGMviIslgoIthzmS0iujnCboC2yZgjo0DEpijaEB7L1HKPpUQE3tvvSDN3V
 jXWDlGv6oIcF3iT5Tfh6eEcCliRmZ+/bG/pgFVC2EBwtvjHWExZMNmBQKhzpkcuAAG5L9JqfqCY
 u4mF61Vzi7erykb1ifnD0kXrVpKs9wAcRpdfIl6hQhbfyv6UCJ9CS36HxVbbWocaaSbA2vktHlb
 br68+CJYKUesTwdmLkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfXz1Il1Nq1sFAO
 AEDXsdOjt6CAQUt3G0wMJWuHQrs9o4QU5nYy8iChNpmHDWMWUM9gkfuS01rZ4sbsz8CK35iVS8f
 sTojoJFN6HzGAaLKREnyXy2WZmkOGYM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Tue, Jun 9, 2026 at 4:27=E2=80=AFPM Greg Ungerer <gerg@linux-m68k.org> w=
rote:
>
> The implementation of the readX() and writeX() family of IO access
> functions is non-standard on ColdFire platforms. They check the supplied
> IO address and will return either big or little endian results based on
> that check. This is non-standard, they are expected to always return
> little-endian byte ordered data. Unfortunately this behavior also means
> that ioreadX()/iowroteX() and their big-endian counter parts
> ioreadXbe()/iowriteXbe() are wrong. This is now in the process of being
> cleaned up and fixed.
>
> Change the use of the readX() and writeX() access functions in this drive=
r
> to use the recently defined specific ColdFire internal SoC hardware IO
> access functions mcf_read8()/mcf_read16()/mcf_read32() and
> mcf_write8()/mcf_write16()/mcf_write32().
>
> There is no functional change to the driver. Though it does have the
> effect of making the IO access slightly more efficient, since there is
> no longer a need to do the address check at every register access.
>
> Acked-by: Angelo Dureghello <adureghello@baylibre.com>
> Tested-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: moved from RFC to PATCH
>
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-=
esdhc-mcf.c
> index 375fce5639d7..6853521e8b2c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -55,7 +55,7 @@ static inline void esdhc_clrset_be(struct sdhci_host *h=
ost,
>         if (reg =3D=3D SDHCI_HOST_CONTROL)
>                 val |=3D ESDHC_PROCTL_D3CD;
>
> -       writel((readl(base) & ~mask) | val, base);
> +       mcf_write32((mcf_read32(base) & ~mask) | val, base);
>  }
>
>  /*
> @@ -71,7 +71,7 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host=
, u8 val, int reg)
>         if (reg =3D=3D SDHCI_HOST_CONTROL) {
>                 u32 host_ctrl =3D ESDHC_DEFAULT_HOST_CONTROL;
>                 u8 dma_bits =3D (val & SDHCI_CTRL_DMA_MASK) >> 3;
> -               u8 tmp =3D readb(host->ioaddr + SDHCI_HOST_CONTROL + 1);
> +               u8 tmp =3D mcf_read8(host->ioaddr + SDHCI_HOST_CONTROL + =
1);
>
>                 tmp &=3D ~0x03;
>                 tmp |=3D dma_bits;
> @@ -82,12 +82,12 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *ho=
st, u8 val, int reg)
>                  */
>                 host_ctrl |=3D val;
>                 host_ctrl |=3D (dma_bits << 8);
> -               writel(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
> +               mcf_write32(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL)=
;
>
>                 return;
>         }
>
> -       writel((readl(base) & mask) | (val << shift), base);
> +       mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>
>  static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int re=
g)
> @@ -110,24 +110,24 @@ static void esdhc_mcf_writew_be(struct sdhci_host *=
host, u16 val, int reg)
>                  * As for the fsl driver,
>                  * we have to set the mode in a single write here.
>                  */
> -               writel(val << 16 | mcf_data->aside,
> +               mcf_write32(val << 16 | mcf_data->aside,
>                        host->ioaddr + SDHCI_TRANSFER_MODE);
>                 return;
>         }
>
> -       writel((readl(base) & mask) | (val << shift), base);
> +       mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>
>  static void esdhc_mcf_writel_be(struct sdhci_host *host, u32 val, int re=
g)
>  {
> -       writel(val, host->ioaddr + reg);
> +       mcf_write32(val, host->ioaddr + reg);
>  }
>
>  static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>  {
>         if (reg =3D=3D SDHCI_HOST_CONTROL) {
>                 u8 __iomem *base =3D host->ioaddr + (reg & ~3);
> -               u16 val =3D readw(base + 2);
> +               u16 val =3D mcf_read16(base + 2);
>                 u8 dma_bits =3D (val >> 5) & SDHCI_CTRL_DMA_MASK;
>                 u8 host_ctrl =3D val & 0xff;
>
> @@ -137,7 +137,7 @@ static u8 esdhc_mcf_readb_be(struct sdhci_host *host,=
 int reg)
>                 return host_ctrl;
>         }
>
> -       return readb(host->ioaddr + (reg ^ 0x3));
> +       return mcf_read8(host->ioaddr + (reg ^ 0x3));
>  }
>
>  static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
> @@ -149,14 +149,14 @@ static u16 esdhc_mcf_readw_be(struct sdhci_host *ho=
st, int reg)
>         if (reg =3D=3D SDHCI_HOST_VERSION)
>                 reg -=3D 2;
>
> -       return readw(host->ioaddr + (reg ^ 0x2));
> +       return mcf_read16(host->ioaddr + (reg ^ 0x2));
>  }
>
>  static u32 esdhc_mcf_readl_be(struct sdhci_host *host, int reg)
>  {
>         u32 val;
>
> -       val =3D readl(host->ioaddr + reg);
> +       val =3D mcf_read32(host->ioaddr + reg);
>
>         /*
>          * RM (25.3.9) sd pin clock must never exceed 25Mhz.
> @@ -245,7 +245,7 @@ static void esdhc_mcf_pltfm_set_clock(struct sdhci_ho=
st *host,
>          * fvco =3D fsys * outdvi1 + 1
>          * fshdc =3D fvco / outdiv3 + 1
>          */
> -       temp =3D readl(pll_dr);
> +       temp =3D mcf_read32(pll_dr);
>         fsys =3D pltfm_host->clock;
>         fvco =3D fsys * ((temp & 0x1f) + 1);
>         fesdhc =3D fvco / (((temp >> 10) & 0x1f) + 1);
> --
> 2.54.0
>
