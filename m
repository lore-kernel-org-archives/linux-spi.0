Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786567;
	b=xm7hvlLT8uGd2DQ6AZa8BBH2KWtcOh7cgqV+qLTk0CTSkF+mPNpdOCI4OV08UzSBR67m
	 GKqPl8mb0y1EFJ1MGKJB8mCAiom9ASZZeumc7Hy76s4BZk+UakbGyeF9c5k/17Bqx55N8
	 Tw6L7x8/kQ+/gs8K/nErwRoT6hTHkfZ7HB7yAvYhzhl+yqJmYbffAVyzXF02U2btZvfP7
	 ouAyE6PwmVYgBsTlnZYscD52dxPr5oTP1IZOfWrlOW/kztTNHcsy+kWblmKn0/20Q2dhG
	 rDJuudmdEyf3G2873pzFqXmPe28IDuaDBdY8a77b410QmM3xIue7I9YpB8K22tR2wHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786567;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OsbxJZpAZx1h36y2vzu/iL+NpozhILVCBKZvXimWDaY=;
	b=kB8WsnJU61PTsf1WMqgS90OCM6+vvdQQ3Uk4dxuc4g53eNmi+Ze3NPVTn8eiYWlNL8f6
	 U7TaM7oJXAIySbqCj1cWTj4hvonsOg12jfmFIFSkiVp6WhMhvwB0otFV3+PG2+rs8MlVH
	 sRvz4NArCwh0gC50eQBH1R0th8JlqHNb4LK49Gxuw8dinEjUxrilOxaACotljPq1fFAwM
	 ZDAl0sjGM0BXoyr48oPrEWj62Ia4Ywsyi0TD5Fr1OtguEYU9uQIfibe3mjLIjcwx0N8vQ
	 PJKExcmxiWroDPoNGBDH0LgdY/LRuxyq37qLu7dtwPsO8egaqyW/djgjEgvl53dzSyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dK0tn36H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F765606A31B
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dK0tn36H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E981F00A1B
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 10:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793786566;
	bh=OsbxJZpAZx1h36y2vzu/iL+NpozhILVCBKZvXimWDaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dK0tn36HQB0FgFCOs6lMaQtn970fqm1+UitCSCe5sQFvw/9ooxnBe19Q1qR7HsHJC
	 OLm3g6zAwih81SeU+hnHL7nbWR9Ex7v1pEteOBwcebvEY0XGrZcEWjCdqLIGRl8qbA
	 i+/+s0xMytH1ixwQLsAsNsP5ZQP3I93geQQYzg+Qkaz1y244jf7B9RaC3jOKssqtDt
	 GvKt+ew57koXKm6puSxc5idn62dN6hdwyTaPN9VS155FKzWIXKg79itjkIjHxxXib7
	 Z5WXPJnpxSF2iOT5eyC0+CKMbG7YGXvh7xyO0r8GM+hoEz8ID7p2YX1vlDWQaxDo6A
	 gaGzPhuoYMdJA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso90012166b.3
        for <linux-spi@vger.kernel.org>; Wed, 04 Nov 2026 02:02:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx8DYq+zqLukkZFo1WSxDuZT0RRN3qwekX2oTMEErkDwGScyNdxmaDMgQ3yFiCsqPuKuHpbCWOnYHU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/f/zzbqM64/+5N+ABVS/lH75zdIQ13z67nK+QlyHaw5u1kebyP
	Le74X1eAep72lFItSeom/vKMUzIuOEYJteNJu40Sivccy1M+hWJx/90eLFQXKM/Scbl1IcCzBvh
	Sy+dJnGp7jJ6J2FYiRyM0szmmzqIrsI0=
X-Received: by 2002:a17:906:7309:b0:c41:c718:f5c5 with SMTP id
 a640c23a62f3a-c4ca7a15633mr1378905866b.13.1793786565446; Wed, 04 Nov 2026
 02:02:45 -0800 (PST)
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
In-Reply-To: <ba943ed040b1c6a04a88612c1a62c04fefe876ba.1793689461.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 4 Nov 2026 18:02:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7FL1oc0sS_Dm8kcSg0dTX5G8ZfQfQvfWEr_gXQWGAqfg@mail.gmail.com>
X-Gm-Features: AclHuK_CDla3dRoNl3MCe3qp5KneL316zHPQCTZkiJ1u0xoSfIQ3io3-O827cno
Message-ID: <CAAhV-H7FL1oc0sS_Dm8kcSg0dTX5G8ZfQfQvfWEr_gXQWGAqfg@mail.gmail.com>
Subject: Re: [PATCH 3/8] spi: loongson: Make suspend/resume registers PM-specific
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Binbin,

On Tue, Nov 3, 2026 at 3:08=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> Currently, the driver reuses fields like spcr, sper, spsr, and para
> within struct loongson_spi for multiple purposes (runtime setup,
> polling, and PM state). This state overloading makes the code fragile.
> For example, set_clk() modifies spcr/sper during normal operations,
> which can corrupt the saved state right before a suspend.
>
> To fix this, move these register caches into a dedicated struct
> loongson_spi_suspend_store (lss) so they are exclusively used by the
> PM callbacks. Other functions (set_clk, write_read_8bit, message
> handling) are updated to use local variables instead of mutating the
> global PM state.
>
> Fixes: 6c7a864007b6 ("spi: loongson: add bus driver for the loongson spi =
controller")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/spi/spi-loongson-core.c | 80 ++++++++++++++++++---------------
>  drivers/spi/spi-loongson.h      | 14 +++---
>  2 files changed, 52 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-c=
ore.c
> index deda754e214d..9f3acf583984 100644
> --- a/drivers/spi/spi-loongson-core.c
> +++ b/drivers/spi/spi-loongson-core.c
> @@ -40,22 +40,23 @@ static void loongson_spi_set_cs(struct spi_device *sp=
i, bool en)
>
>  static void loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsi=
gned int hz)
>  {
> -       unsigned char val;
> -       unsigned int div, div_tmp;
>         static const char rdiv[12] =3D {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10,=
 11};
> +       unsigned char val, spr, spre;
> +       unsigned int div, div_tmp;
>
>         div =3D clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2=
, 4096);
>         div_tmp =3D rdiv[fls(div - 1)];
> -       loongson_spi->spcr =3D (div_tmp & GENMASK(1, 0)) >> 0;
> -       loongson_spi->sper =3D (div_tmp & GENMASK(3, 2)) >> 2;
> +
> +       spr =3D (div_tmp & GENMASK(1, 0)) >> 0;
>         val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG=
);
>         val &=3D ~GENMASK(1, 0);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val |
> -                              loongson_spi->spcr);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val |=
 spr);
> +
> +       spre =3D (div_tmp & GENMASK(3, 2)) >> 2;
>         val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG=
);
>         val &=3D ~GENMASK(1, 0);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, val |
> -                              loongson_spi->sper);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, val |=
 spre);
> +
>         loongson_spi->hz =3D hz;
>  }
>
> @@ -107,8 +108,9 @@ static int loongson_spi_setup(struct spi_device *spi)
>  static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8=
 **tx_buf,
>                                         u8 **rx_buf, unsigned int num)
>  {
> -       int ret;
>         struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
spi->controller);
> +       unsigned char status;
> +       int ret;
>
>         if (tx_buf && *tx_buf)
>                 loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_RE=
G, *((*tx_buf)++));
> @@ -116,8 +118,8 @@ static int loongson_spi_write_read_8bit(struct spi_de=
vice *spi, const u8 **tx_bu
>                 loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_RE=
G, 0);
>
>         ret =3D readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR=
_REG,
> -                                loongson_spi->spsr, (loongson_spi->spsr =
&
> -                                LOONGSON_SPI_SPSR_RFEMPTY) !=3D LOONGSON=
_SPI_SPSR_RFEMPTY,
> +                                status,
> +                                !(status & LOONGSON_SPI_SPSR_RFEMPTY),
>                                  1, USEC_PER_MSEC);
>
>         if (rx_buf && *rx_buf)
> @@ -148,10 +150,11 @@ static int loongson_spi_write_read(struct spi_devic=
e *spi, struct spi_transfer *
>  static int loongson_spi_prepare_message(struct spi_controller *ctlr, str=
uct spi_message *m)
>  {
>         struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
ctlr);
> +       unsigned char para;
>
> -       loongson_spi->para =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_PARA_REG);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loong=
son_spi->para &
> -                              ~LOONGSON_SPI_PARA_MEM_EN);
> +       para =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_RE=
G);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
> +                              para & ~LOONGSON_SPI_PARA_MEM_EN);
>
>         return 0;
>  }
> @@ -171,8 +174,12 @@ static int loongson_spi_transfer_one(struct spi_cont=
roller *ctrl, struct spi_dev
>  static int loongson_spi_unprepare_message(struct spi_controller *ctrl, s=
truct spi_message *m)
>  {
>         struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
ctrl);
> +       unsigned char para;
>
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loong=
son_spi->para);
> +       /* Restore the hardware SPI Flash read path */
> +       para =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_RE=
G);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
> +                              para | LOONGSON_SPI_PARA_MEM_EN);
>
>         return 0;
>  }
> @@ -231,38 +238,37 @@ EXPORT_SYMBOL_NS_GPL(loongson_spi_init_controller, =
"SPI_LOONGSON_CORE");
>
>  static int loongson_spi_suspend(struct device *dev)
>  {
> -       struct loongson_spi *loongson_spi;
> -       struct spi_controller *controller;
> -
> -       controller =3D dev_get_drvdata(dev);
> -       spi_controller_suspend(controller);
> +       struct spi_controller *controller =3D dev_get_drvdata(dev);
> +       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
controller);
> +       int ret;
>
> -       loongson_spi =3D spi_controller_get_devdata(controller);
> +       ret =3D spi_controller_suspend(controller);
> +       if (ret)
> +               return ret;
>
> -       loongson_spi->spcr =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_SPCR_REG);
> -       loongson_spi->sper =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_SPER_REG);
> -       loongson_spi->spsr =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_SPSR_REG);
> -       loongson_spi->para =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_PARA_REG);
> -       loongson_spi->sfcs =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_SFCS_REG);
> -       loongson_spi->timi =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_TIMI_REG);
> +       loongson_spi->lss.spcr =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_SPCR_REG);
> +       loongson_spi->lss.sper =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_SPER_REG);
> +       loongson_spi->lss.spsr =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_SPSR_REG);
> +       loongson_spi->lss.para =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_PARA_REG);
> +       loongson_spi->lss.sfcs =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_SFCS_REG);
> +       loongson_spi->lss.timi =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_TIMI_REG);
>
>         return 0;
>  }
>
>  static int loongson_spi_resume(struct device *dev)
>  {
> -       struct loongson_spi *loongson_spi;
> -       struct spi_controller *controller;
> +       struct spi_controller *controller =3D dev_get_drvdata(dev);
> +       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
controller);
>
> -       controller =3D dev_get_drvdata(dev);
> -       loongson_spi =3D spi_controller_get_devdata(controller);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loong=
son_spi->lss.spcr);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loong=
son_spi->lss.sper);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loong=
son_spi->lss.para);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, loong=
son_spi->lss.sfcs);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG, loong=
son_spi->lss.timi);
>
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loong=
son_spi->spcr);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loong=
son_spi->sper);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG, loong=
son_spi->spsr);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loong=
son_spi->para);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, loong=
son_spi->sfcs);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG, loong=
son_spi->timi);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG,
> +                              LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR=
_WCOL);
>
>         spi_controller_resume(controller);
>
> diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
> index 35f95b161842..b2e73fa12420 100644
> --- a/drivers/spi/spi-loongson.h
> +++ b/drivers/spi/spi-loongson.h
> @@ -29,19 +29,23 @@
>  struct device;
>  struct spi_controller;
>
> -struct loongson_spi {
> -       struct  spi_controller  *controller;
> -       void __iomem            *base;
> -       int                     cs_active;
> -       unsigned int            hz;
> +struct loongson_spi_suspend_store {
Maybe loongson_spi_pm_state is a better name.

Huacai

>         unsigned char           spcr;
>         unsigned char           sper;
>         unsigned char           spsr;
>         unsigned char           para;
>         unsigned char           sfcs;
>         unsigned char           timi;
> +};
> +
> +struct loongson_spi {
> +       struct  spi_controller  *controller;
> +       void __iomem            *base;
> +       int                     cs_active;
> +       unsigned int            hz;
>         unsigned int            mode;
>         u64                     clk_rate;
> +       struct loongson_spi_suspend_store lss;
>  };
>
>  int loongson_spi_init_controller(struct device *dev, void __iomem *reg);
> --
> 2.52.0
>
