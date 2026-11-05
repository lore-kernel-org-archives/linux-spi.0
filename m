Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793845043;
	b=wvN0ja6XMmgu2+Yodb+TZE95HnU7D36KaUT4V4/9dFlRm4vSDKA/n1ToHJFudufSV5s+
	 ZPmIDv78XAlFg35Yl3eYRqZ7U5IcnUvwIGqGnqim+Y9Zz7hGYkQEcTYmlXzJyHqto2WVe
	 8rKgWngK3OogRmUv1aBMPr99qwt/BMX33PqZx/G/h7X9TIrQ7jmr5QDp2a5vG8AOTJ/Y3
	 S1SIQMAkHGHKtZA088p2w7YZs6Dwp4j7RTnCf/mrj4WU8rUMEyAOfKEzIaBoqDuZBETE0
	 zcO7Nxck2WRNtJ+Cv+35HJiT2dM9ko8vmamrWt0MdasBQmi1e6YefO5TeJ2NcFUsc9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bEcKF/O4mjOe4JAG085pq/Q95rlmJbBO1sT0SY3GVGw=;
	b=2S5OJRe/0FUcHD9xRik8mn/sBWV1vkJ7r04Tcjsvy16kRPjR/20jUPA3jMzkw322mhuH
	 /jOetebtOrRz94dN/6xINbNze2h06cFFV8lpTFLPt+RknrMdusch2SVabxHylXB3yNDOc
	 q0CPLQ92Ko+hB2CC1Blzy5H2pusnCoeGzRQ7w2R9MKawz6hnWhzxpkIfcFvXj9VVjWB2F
	 QVTG6YV4yjpQCALwZr1HUDloVJAd/RXxV/BBWnxWYjJD/+aA8lKY1RMAbwayYupG5epWe
	 g8vBOQ/aOLuBOGhu0CB/ai1Ib2qHFws5B6wLJof7Bsu4wD/4Ru00xdfeT+LymuDR/+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ove9ULU9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3A606A326
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 02:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6B3A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ove9ULU9
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso196993566b.3
        for <linux-spi@vger.kernel.org>; Wed, 04 Nov 2026 18:17:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793845041; cv=none;
        d=google.com; s=arc-20260327;
        b=mws7XWJQo9UygPRtprPJVsxzwlMP616J26whjO2u4mri4wsRKMW4vaB3LvjVRaF3cs
         MEgeyEBshWH97yll0+zW6x7jEMwi7wJFupMjboMZWfFdMIF0OfKuHsXxwQ4n6pk6dklO
         6i7WA/tOKBE57W51Ljl8r/ykAU51m1CiUgP32nYPaVBMKyf+sowgWywoAzPliHb/Z6uL
         lMZTi4KOiDvtlQfiNPUVG1i7YsUqKSjg6WGc1FJxU8JyWzrk8yCbErdMOxF5351LIVAd
         dOMzG+pNJRrXfdWjoLFDpG1P7HLY5RmP5Z4LBxJJrm0MX3qTnBRslVxRruFK1YTzv+xm
         UGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bEcKF/O4mjOe4JAG085pq/Q95rlmJbBO1sT0SY3GVGw=;
        fh=Km6s7o4xp4MPU5+jIgKCj/l0Vp8JSQK/Hv0q5EW9QNU=;
        b=jrNiOVZ1+qxB+0oOmADB5/Mbrrgqvu2zSM+ptRsv+X3TzNz5InujWNIcMvAWRLpz2o
         pmgVFUg2FQCS9doUmBWA+CGpxCpkPEJyfCpmkKjsKq3MB9mmqvMbtkUBHUJKhlEvAD6O
         EMhVAPfkRX8mHAdvK+FCcpf/WeYqWBTUDy4MWqTN0q/cgtN3avo6wBPKPZ2gJW1523By
         NZe6TQ5sSob9xDo4CEDHjwN2M+pjl3S2xFhf1uRVAfICQUNIo+d48aEXayojbsnmeXli
         qNsypBglD4J8CA4iYolJsvfjGGhBBxSNcuH8VyJ8dFFIQHMf9sBPpkmjKNXVRA4KoBNz
         Yj1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793845041; x=1794449841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bEcKF/O4mjOe4JAG085pq/Q95rlmJbBO1sT0SY3GVGw=;
        b=Ove9ULU9XnCqeyQjPcDkKpHgxJnCRr45bvz001coNFm/TAhHmmphgQoGOa1qO88oB3
         uisuIrro85zQvvftgWeLh68Mmpu5wexEaWuj8ogGpm6Aj0lFLX6BzimszbYa0Ef7ItDL
         mk+hzcogKnpgvf8jXXzbJUV+1+1qXQaCCNdtX8s5dLNjE+jM8zNQuBta4I4zoUV3q3Mx
         bYjZbptyzmf9uX4agacaYCor+dTxPFXRgb065/Yz3xCNoi8CBMZ1Ve/RqGWWJ16dohSH
         fNkRvTukCq2UogIDMGZgx6zU16aRU5La7GXSkfUpUcqd+v6D95a0sf4wYNTWWgnlb9Z+
         egVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845041; x=1794449841;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bEcKF/O4mjOe4JAG085pq/Q95rlmJbBO1sT0SY3GVGw=;
        b=WaKPw+WAvOVslzaDJ0D4t6bVDmbmzEt9QpIy9nJriGZvoaRqbLhJZBYJOzC0r635+M
         XzPNpAdRcoQHOU2jCFOa1khMr/EmImSm519hk8A6gBVH9nCdIzfQEC7FsaTREsk4WjBR
         a43KzTFbaIyUjZM9zFWWFGABhBbv+B4F/mDuLkEaBgGJ/5U8YG05wJVrvjd5uSAwgLYb
         MEXNANkO44Ii6aoyT2IVmD9MaPTIIFVwwgSwUYP4MlxPBmkqYgZ8WrE7M3OJV0d6fx9J
         Fo3Mo3nfI5Nn/NlE76n5GjIWNGcu7tRTvGuCSUDim8yc6BFcBmo0wtGvUX3VT1q1Vsji
         VJ9g==
X-Forwarded-Encrypted: i=1; AKwUvByeiWRIxpoPJA0L9alTwFEIE4V+D5taupr9fck7Dp/e9BBSR9Ys16ISNO2bNWmoEkoCilryu3XbiJ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YWcm9V/pgirBMiaUA4pfIZyoKGCMPFun7OZRf+zToXpc+q4Ey
	oiJ5lqGr04Dy7BvAhSpz99w6iXr8zV5KqMVIj5s3sLrzyAoNa7q2vA8A6cWAizBE9vf53Xqu87x
	728PdTmOIkX9h2yG9aHAKRbu4O4VvKuTfmScyjd5QIg==
X-Gm-Gg: AYBFou1YOxdoodwPPihGirWw+TlRtrlGYnqBOy5RgaglaVUvid1e2/dG4csbwXGJJRt
	KoDws+EIQ0gJB+UYj8iTwQGFm67v9ZI39doE3n9w+NiYmDBLi8pEppKI29/qarFdyipptWLFlKf
	H95d2LifZnj8mFa4OhuET0vIxT+uX32oSQpmRCdgG+dxWdX2bQz3kTgo/yWzpBHR/0UmNyPPzYL
	CihVOQcPp7wnQVWK/4WnjIB/zEAYjfryXpDoqgsewWOo90gLb13wPtyomMrzACViksOwdbCBfy+
	k4KOH6JABcLinB1HiG5QH6NEAK+v0ExzP+0S+L8zF57ickyp458P8MEvMvu271JF0DEfTTQXksz
	O6tuCSGMGGI/l4hyJiEFCx80B/KKyaknafPT5nw==
X-Received: by 2002:a17:907:d309:b0:c37:8ccb:9b76 with SMTP id
 a640c23a62f3a-c4ca7ac07b7mr1636880566b.40.1793845040724; Wed, 04 Nov 2026
 18:17:20 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793689461.git.zhoubinbin@loongson.cn> <ba943ed040b1c6a04a88612c1a62c04fefe876ba.1793689461.git.zhoubinbin@loongson.cn>
 <CAAhV-H7FL1oc0sS_Dm8kcSg0dTX5G8ZfQfQvfWEr_gXQWGAqfg@mail.gmail.com>
In-Reply-To: <CAAhV-H7FL1oc0sS_Dm8kcSg0dTX5G8ZfQfQvfWEr_gXQWGAqfg@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 5 Nov 2026 10:17:09 +0800
X-Gm-Features: AclHuK_2BcbzFX_rzqMbxRCglEi3yqwv0qPwa0bq151X-OhcwcT-Bwyik7IOUsY
Message-ID: <CAMpQs4JsFjR0wpF-EAXFrA0MnC46gdBPc8OLcknzEHn6R_+DMg@mail.gmail.com>
Subject: Re: [PATCH 3/8] spi: loongson: Make suspend/resume registers PM-specific
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 6:02=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> Hi, Binbin,
>
> On Tue, Nov 3, 2026 at 3:08=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.c=
n> wrote:
> >
> > Currently, the driver reuses fields like spcr, sper, spsr, and para
> > within struct loongson_spi for multiple purposes (runtime setup,
> > polling, and PM state). This state overloading makes the code fragile.
> > For example, set_clk() modifies spcr/sper during normal operations,
> > which can corrupt the saved state right before a suspend.
> >
> > To fix this, move these register caches into a dedicated struct
> > loongson_spi_suspend_store (lss) so they are exclusively used by the
> > PM callbacks. Other functions (set_clk, write_read_8bit, message
> > handling) are updated to use local variables instead of mutating the
> > global PM state.
> >
> > Fixes: 6c7a864007b6 ("spi: loongson: add bus driver for the loongson sp=
i controller")
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  drivers/spi/spi-loongson-core.c | 80 ++++++++++++++++++---------------
> >  drivers/spi/spi-loongson.h      | 14 +++---
> >  2 files changed, 52 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson=
-core.c
> > index deda754e214d..9f3acf583984 100644
> > --- a/drivers/spi/spi-loongson-core.c
> > +++ b/drivers/spi/spi-loongson-core.c
> > @@ -40,22 +40,23 @@ static void loongson_spi_set_cs(struct spi_device *=
spi, bool en)
> >
> >  static void loongson_spi_set_clk(struct loongson_spi *loongson_spi, un=
signed int hz)
> >  {
> > -       unsigned char val;
> > -       unsigned int div, div_tmp;
> >         static const char rdiv[12] =3D {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 1=
0, 11};
> > +       unsigned char val, spr, spre;
> > +       unsigned int div, div_tmp;
> >
> >         div =3D clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz),=
 2, 4096);
> >         div_tmp =3D rdiv[fls(div - 1)];
> > -       loongson_spi->spcr =3D (div_tmp & GENMASK(1, 0)) >> 0;
> > -       loongson_spi->sper =3D (div_tmp & GENMASK(3, 2)) >> 2;
> > +
> > +       spr =3D (div_tmp & GENMASK(1, 0)) >> 0;
> >         val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_R=
EG);
> >         val &=3D ~GENMASK(1, 0);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val=
 |
> > -                              loongson_spi->spcr);
> > +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val=
 | spr);
> > +
> > +       spre =3D (div_tmp & GENMASK(3, 2)) >> 2;
> >         val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_R=
EG);
> >         val &=3D ~GENMASK(1, 0);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, val=
 |
> > -                              loongson_spi->sper);
> > +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, val=
 | spre);
> > +
> >         loongson_spi->hz =3D hz;
> >  }
> >
> > @@ -107,8 +108,9 @@ static int loongson_spi_setup(struct spi_device *sp=
i)
> >  static int loongson_spi_write_read_8bit(struct spi_device *spi, const =
u8 **tx_buf,
> >                                         u8 **rx_buf, unsigned int num)
> >  {
> > -       int ret;
> >         struct loongson_spi *loongson_spi =3D spi_controller_get_devdat=
a(spi->controller);
> > +       unsigned char status;
> > +       int ret;
> >
> >         if (tx_buf && *tx_buf)
> >                 loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_=
REG, *((*tx_buf)++));
> > @@ -116,8 +118,8 @@ static int loongson_spi_write_read_8bit(struct spi_=
device *spi, const u8 **tx_bu
> >                 loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_=
REG, 0);
> >
> >         ret =3D readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SP=
SR_REG,
> > -                                loongson_spi->spsr, (loongson_spi->sps=
r &
> > -                                LOONGSON_SPI_SPSR_RFEMPTY) !=3D LOONGS=
ON_SPI_SPSR_RFEMPTY,
> > +                                status,
> > +                                !(status & LOONGSON_SPI_SPSR_RFEMPTY),
> >                                  1, USEC_PER_MSEC);
> >
> >         if (rx_buf && *rx_buf)
> > @@ -148,10 +150,11 @@ static int loongson_spi_write_read(struct spi_dev=
ice *spi, struct spi_transfer *
> >  static int loongson_spi_prepare_message(struct spi_controller *ctlr, s=
truct spi_message *m)
> >  {
> >         struct loongson_spi *loongson_spi =3D spi_controller_get_devdat=
a(ctlr);
> > +       unsigned char para;
> >
> > -       loongson_spi->para =3D loongson_spi_read_reg(loongson_spi, LOON=
GSON_SPI_PARA_REG);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loo=
ngson_spi->para &
> > -                              ~LOONGSON_SPI_PARA_MEM_EN);
> > +       para =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_=
REG);
> > +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
> > +                              para & ~LOONGSON_SPI_PARA_MEM_EN);
> >
> >         return 0;
> >  }
> > @@ -171,8 +174,12 @@ static int loongson_spi_transfer_one(struct spi_co=
ntroller *ctrl, struct spi_dev
> >  static int loongson_spi_unprepare_message(struct spi_controller *ctrl,=
 struct spi_message *m)
> >  {
> >         struct loongson_spi *loongson_spi =3D spi_controller_get_devdat=
a(ctrl);
> > +       unsigned char para;
> >
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loo=
ngson_spi->para);
> > +       /* Restore the hardware SPI Flash read path */
> > +       para =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_=
REG);
> > +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
> > +                              para | LOONGSON_SPI_PARA_MEM_EN);
> >
> >         return 0;
> >  }
> > @@ -231,38 +238,37 @@ EXPORT_SYMBOL_NS_GPL(loongson_spi_init_controller=
, "SPI_LOONGSON_CORE");
> >
> >  static int loongson_spi_suspend(struct device *dev)
> >  {
> > -       struct loongson_spi *loongson_spi;
> > -       struct spi_controller *controller;
> > -
> > -       controller =3D dev_get_drvdata(dev);
> > -       spi_controller_suspend(controller);
> > +       struct spi_controller *controller =3D dev_get_drvdata(dev);
> > +       struct loongson_spi *loongson_spi =3D spi_controller_get_devdat=
a(controller);
> > +       int ret;
> >
> > -       loongson_spi =3D spi_controller_get_devdata(controller);
> > +       ret =3D spi_controller_suspend(controller);
> > +       if (ret)
> > +               return ret;
> >
> > -       loongson_spi->spcr =3D loongson_spi_read_reg(loongson_spi, LOON=
GSON_SPI_SPCR_REG);
> > -       loongson_spi->sper =3D loongson_spi_read_reg(loongson_spi, LOON=
GSON_SPI_SPER_REG);
> > -       loongson_spi->spsr =3D loongson_spi_read_reg(loongson_spi, LOON=
GSON_SPI_SPSR_REG);
> > -       loongson_spi->para =3D loongson_spi_read_reg(loongson_spi, LOON=
GSON_SPI_PARA_REG);
> > -       loongson_spi->sfcs =3D loongson_spi_read_reg(loongson_spi, LOON=
GSON_SPI_SFCS_REG);
> > -       loongson_spi->timi =3D loongson_spi_read_reg(loongson_spi, LOON=
GSON_SPI_TIMI_REG);
> > +       loongson_spi->lss.spcr =3D loongson_spi_read_reg(loongson_spi, =
LOONGSON_SPI_SPCR_REG);
> > +       loongson_spi->lss.sper =3D loongson_spi_read_reg(loongson_spi, =
LOONGSON_SPI_SPER_REG);
> > +       loongson_spi->lss.spsr =3D loongson_spi_read_reg(loongson_spi, =
LOONGSON_SPI_SPSR_REG);
> > +       loongson_spi->lss.para =3D loongson_spi_read_reg(loongson_spi, =
LOONGSON_SPI_PARA_REG);
> > +       loongson_spi->lss.sfcs =3D loongson_spi_read_reg(loongson_spi, =
LOONGSON_SPI_SFCS_REG);
> > +       loongson_spi->lss.timi =3D loongson_spi_read_reg(loongson_spi, =
LOONGSON_SPI_TIMI_REG);
> >
> >         return 0;
> >  }
> >
> >  static int loongson_spi_resume(struct device *dev)
> >  {
> > -       struct loongson_spi *loongson_spi;
> > -       struct spi_controller *controller;
> > +       struct spi_controller *controller =3D dev_get_drvdata(dev);
> > +       struct loongson_spi *loongson_spi =3D spi_controller_get_devdat=
a(controller);
> >
> > -       controller =3D dev_get_drvdata(dev);
> > -       loongson_spi =3D spi_controller_get_devdata(controller);
> > +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loo=
ngson_spi->lss.spcr);
> > +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loo=
ngson_spi->lss.sper);
> > +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loo=
ngson_spi->lss.para);
> > +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, loo=
ngson_spi->lss.sfcs);
> > +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG, loo=
ngson_spi->lss.timi);
> >
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loo=
ngson_spi->spcr);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loo=
ngson_spi->sper);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG, loo=
ngson_spi->spsr);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loo=
ngson_spi->para);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, loo=
ngson_spi->sfcs);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG, loo=
ngson_spi->timi);
> > +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG,
> > +                              LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SP=
SR_WCOL);
> >
> >         spi_controller_resume(controller);
> >
> > diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
> > index 35f95b161842..b2e73fa12420 100644
> > --- a/drivers/spi/spi-loongson.h
> > +++ b/drivers/spi/spi-loongson.h
> > @@ -29,19 +29,23 @@
> >  struct device;
> >  struct spi_controller;
> >
> > -struct loongson_spi {
> > -       struct  spi_controller  *controller;
> > -       void __iomem            *base;
> > -       int                     cs_active;
> > -       unsigned int            hz;
> > +struct loongson_spi_suspend_store {
> Maybe loongson_spi_pm_state is a better name.

Yes, I will rename it.
>
> Huacai
>
> >         unsigned char           spcr;
> >         unsigned char           sper;
> >         unsigned char           spsr;
> >         unsigned char           para;
> >         unsigned char           sfcs;
> >         unsigned char           timi;
> > +};
> > +
> > +struct loongson_spi {
> > +       struct  spi_controller  *controller;
> > +       void __iomem            *base;
> > +       int                     cs_active;
> > +       unsigned int            hz;
> >         unsigned int            mode;
> >         u64                     clk_rate;
> > +       struct loongson_spi_suspend_store lss;
> >  };
> >
> >  int loongson_spi_init_controller(struct device *dev, void __iomem *reg=
);
> > --
> > 2.52.0
> >

--=20
Thanks.
Binbin
