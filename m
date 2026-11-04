Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786661;
	b=xr9AibqakPxMlZvI2T86XtRiFMcu05z9j4ZcgMF0jC7baLGosm4ax/FshXuPm1A8rUS+
	 5AqxJnT+zqD5cgY0B/uhwBAGOteag6cs3s57aPxyLjDwJfsRzajEd7zEim0bNqNiYyVaX
	 rCg/u+6uGCxAplho9xDAnABvcRH5xEqIKjcjADAiz5I4j3qglELRod6GoCbI4mPIGtPzH
	 LFrrylY9N5PfVXsh65HIqcI1VgCtoVr5B6bOaqL/dFZmE1eHwIGlZ6p30CVFgOPA+/Wpt
	 FWBFHnZJs0DDUbClGrwvaRDrEbkoSYSpDGBLEQ2HaCAJ7I16kf3aRQFOI1xiUqJ2Pzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786661;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lJs0YB2NLJvek7a2sNujsnQdcsVEAIxij6HcPldyJ7g=;
	b=T6Kq/9iOjwUEK4KSpNX/aiYjAUXMxTWTHzwEdivesRzaenP1yuRSGuAFoo1uA/7U7qQ0
	 bwztvfxee7j0MN3/QWJcDWNgXh3PMOTu+aCyjdFbtlmQDzDigYhq3WL/gHsrRyFRc2RvI
	 pbCcXbjgqVrXukldSblvM1dA1OlxHLyhlII/fYRstEJ27Qg5KDJhnJeHvkr7mp58D4AFl
	 uAQwWpQRCC/qCR3ln7BGo7dlM+E02mEab+KIrt4ENJ0DyG0bclTFvgBQ6L8bM9WBX5eHb
	 Id9EUOIv+4wuJX4ty3Dm4VKc8bfgBBeU62OYnErx1RJsNHgXzsSXATwdAEcvyycV7Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R05sWg6D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ECB606A31B
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R05sWg6D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD2E1F00A15
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793786660;
	bh=lJs0YB2NLJvek7a2sNujsnQdcsVEAIxij6HcPldyJ7g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R05sWg6D1WKZla5yn15f5aFOkDqdlIsVeuFwH1jQJPUFxz04Dr//wRWB8p11FWDN6
	 0qwQpy2Sjtoyr22BFQctgGehjw9K010gwmJkdsc1l27O6GbldqKsRCBS2gOcHfSmoI
	 aqzI57VAwf0ITCumneIk+pPZqn5hcRxevmOk78CxYWn4B/e9zVF1Ovg+mQZnn8wbVY
	 IPJVuycVhLG4AyLVdRWNrBHuDdIY7Dq0YScc3UwXvoidRYiEDlCLRMj4TmGzULztko
	 9801eOvPP+y7C9EFCKKWZGn091LbVyX9vcGcXaiKHIsYJgtBGXIFBdpNvatrG3btsz
	 16iA9cDMrhCYw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso2337521a12.0
        for <linux-spi@vger.kernel.org>; Wed, 04 Nov 2026 02:04:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzsKErs/YG5G+sepeiaoR5VXQ5KU5SuAe+eBhr2f8hnsVlIeR+bWRPK4FN6NTnuiGOpBm36u8rXDPo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5gYSGgmXplPwdjpAQMpheULeas+DX9MvI1GHMCgbIzP2EutdO
	TXUCz9cxAMDx0dtsHIo4vhEJVOQ3S6JGMrnd0I8+k965j0Xiuesbs79MN81bSbMv+6hAOHF9FMV
	JGBSRS9VCz9q+5ksA2N4qVusDsz4PnIU=
X-Received: by 2002:a17:906:f598:b0:c46:9745:ac13 with SMTP id
 a640c23a62f3a-c49d14f5bf2mr1493784866b.32.1793786658636; Wed, 04 Nov 2026
 02:04:18 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793689461.git.zhoubinbin@loongson.cn> <17c0bde3ddc14f6f34eea98558f535d772e79623.1793689461.git.zhoubinbin@loongson.cn>
In-Reply-To: <17c0bde3ddc14f6f34eea98558f535d772e79623.1793689461.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 4 Nov 2026 18:04:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4k_GkOOus2zGA=Cmnu9oo3HAeeCK2msGB41=NvPsvb=g@mail.gmail.com>
X-Gm-Features: AclHuK-9lgxkbK8lk_wPT9IoOsi4rcUaCChMD_VPIKkcwYGNad9lGE3J_uy8HAE
Message-ID: <CAAhV-H4k_GkOOus2zGA=Cmnu9oo3HAeeCK2msGB41=NvPsvb=g@mail.gmail.com>
Subject: Re: [PATCH 6/8] spi: loongson: Move private definitions into the core driver
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
> The Loongson SPI register definitions and the private controller
> structure are only used by the core driver.  Move them from the shared
> header into spi-loongson-core.c and rename the structure to
> loongson_spi_priv to make it clear that it is driver-private data.
Moving is OK but renaming is unnecessary.

Huacai

>
> The shared header now only contains the exported init function and the
> PM ops declaration, which reduces the surface exposed to the PCI and
> platform glue drivers.
>
> While at it, update the copyright years and add MODULE_AUTHOR() entries
> to the PCI and platform drivers.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/spi/spi-loongson-core.c | 252 +++++++++++++++++++-------------
>  drivers/spi/spi-loongson-pci.c  |  19 +--
>  drivers/spi/spi-loongson-plat.c |  11 +-
>  drivers/spi/spi-loongson.h      |  53 +------
>  4 files changed, 173 insertions(+), 162 deletions(-)
>
> diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-c=
ore.c
> index 91d7acbe4302..082248f29ae7 100644
> --- a/drivers/spi/spi-loongson-core.c
> +++ b/drivers/spi/spi-loongson-core.c
> @@ -1,21 +1,71 @@
>  // SPDX-License-Identifier: GPL-2.0+
> -// Loongson SPI Support
> -// Copyright (C) 2023 Loongson Technology Corporation Limited
> +//
> +// Loongson SPI Controller driver
> +//
> +// Copyright (C) 2023-2026 Loongson Technology Corporation Limited
>
>  #include <linux/clk.h>
> -#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/init.h>
> -#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
>
>  #include "spi-loongson.h"
>
> +/* SPI controller register offsets */
> +#define LOONGSON_SPI_SPCR_REG          0x00
> +#define LOONGSON_SPI_SPSR_REG          0x01
> +#define LOONGSON_SPI_FIFO_REG          0x02
> +#define LOONGSON_SPI_SPER_REG          0x03
> +#define LOONGSON_SPI_PARA_REG          0x04
> +#define LOONGSON_SPI_SFCS_REG          0x05
> +#define LOONGSON_SPI_TIMI_REG          0x06
> +
> +/* SPCR bits */
> +#define LOONGSON_SPI_SPCR_SPR          GENMASK(1, 0)
> +#define LOONGSON_SPI_SPCR_CPHA         BIT(2)
> +#define LOONGSON_SPI_SPCR_CPOL         BIT(3)
> +#define LOONGSON_SPI_SPCR_SPE          BIT(6)
> +#define LOONGSON_SPI_SPCR_SPIE         BIT(7)
> +
> +/* SPSR bits */
> +#define LOONGSON_SPI_SPSR_RFEMPTY      BIT(0)
> +#define LOONGSON_SPI_SPSR_RFFULL       BIT(1)
> +#define LOONGSON_SPI_SPSR_WFEMPTY      BIT(2)
> +#define LOONGSON_SPI_SPSR_WFFULL       BIT(3)
> +#define LOONGSON_SPI_SPSR_WCOL         BIT(6)
> +#define LOONGSON_SPI_SPSR_SPIF         BIT(7)
> +
> +/* SPER bits */
> +#define LOONGSON_SPI_SPER_SPRE         GENMASK(1, 0)
> +
> +/* SFC_PARAM bits */
> +#define LOONGSON_SPI_PARA_MEM_EN       BIT(0)
> +
> +#define LOONGSON_SPI_DIV_MIN           2
> +#define LOONGSON_SPI_DIV_MAX           4096
> +
> +struct loongson_spi_suspend_store {
> +       unsigned char           spcr;
> +       unsigned char           sper;
> +       unsigned char           spsr;
> +       unsigned char           para;
> +       unsigned char           sfcs;
> +       unsigned char           timi;
> +};
> +
> +struct loongson_spi_priv {
> +       struct spi_controller   *controller;
> +       void __iomem            *base;
> +       unsigned int            hz;
> +       unsigned int            mode;
> +       u64                     clk_rate;
> +       struct loongson_spi_suspend_store lss;
> +};
> +
>  static const struct {
>         unsigned int    div;
>         unsigned char   spr;
> @@ -35,38 +85,38 @@ static const struct {
>         {4096, 3, 2 },
>  };
>
> -static inline void loongson_spi_write_reg(struct loongson_spi *spi, unsi=
gned char reg,
> +static inline void loongson_spi_write_reg(struct loongson_spi_priv *priv=
, unsigned char reg,
>                                           unsigned char data)
>  {
> -       writeb(data, spi->base + reg);
> +       writeb(data, priv->base + reg);
>  }
>
> -static inline char loongson_spi_read_reg(struct loongson_spi *spi, unsig=
ned char reg)
> +static inline char loongson_spi_read_reg(struct loongson_spi_priv *priv,=
 unsigned char reg)
>  {
> -       return readb(spi->base + reg);
> +       return readb(priv->base + reg);
>  }
>
>  static void loongson_spi_set_cs(struct spi_device *spi, bool en)
>  {
> -       int cs;
> +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(spi=
->controller);
>         unsigned char mask =3D (BIT(4) | BIT(0)) << spi_get_chipselect(sp=
i, 0);
> -       unsigned char val =3D en ? mask :  (BIT(0) << spi_get_chipselect(=
spi, 0));
> -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
spi->controller);
> +       unsigned char val =3D en ? mask : (BIT(0) << spi_get_chipselect(s=
pi, 0));
> +       int cs;
>
> -       cs =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG)=
 & ~mask;
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, val |=
 cs);
> +       cs =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SFCS_REG) & ~mask=
;
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_SFCS_REG, val | cs);
>  }
>
> -static int loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsig=
ned int hz)
> +static int loongson_spi_set_clk(struct loongson_spi_priv *priv, unsigned=
 int hz)
>  {
>         unsigned long div;
>         unsigned char val;
>         unsigned int i;
>
> -       if (!hz || !loongson_spi->clk_rate)
> +       if (!hz || !priv->clk_rate)
>                 return -EINVAL;
>
> -       div =3D DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz);
> +       div =3D DIV_ROUND_UP_ULL(priv->clk_rate, hz);
>         if (div < LOONGSON_SPI_DIV_MIN)
>                 div =3D LOONGSON_SPI_DIV_MIN;
>
> @@ -78,106 +128,106 @@ static int loongson_spi_set_clk(struct loongson_sp=
i *loongson_spi, unsigned int
>         if (i =3D=3D ARRAY_SIZE(loongson_spi_div_table))
>                 return -EINVAL;
>
> -       val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG=
);
> +       val =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
>         val &=3D ~GENMASK(1, 0);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG,
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG,
>                                val | loongson_spi_div_table[i].spr);
>
> -       val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG=
);
> +       val =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPER_REG);
>         val &=3D ~GENMASK(1, 0);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG,
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPER_REG,
>                                val | loongson_spi_div_table[i].spre);
>
> -       loongson_spi->hz =3D hz;
> +       priv->hz =3D hz;
>
>         return 0;
>  }
>
> -static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
> +static void loongson_spi_set_mode(struct loongson_spi_priv *priv,
>                                   struct spi_device *spi)
>  {
>         unsigned char val;
>
> -       val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG=
);
> +       val =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
>         val &=3D ~(LOONGSON_SPI_SPCR_CPOL | LOONGSON_SPI_SPCR_CPHA);
> +
>         if (spi->mode & SPI_CPOL)
>                 val |=3D LOONGSON_SPI_SPCR_CPOL;
> +
>         if (spi->mode & SPI_CPHA)
>                 val |=3D LOONGSON_SPI_SPCR_CPHA;
>
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val);
> -       loongson_spi->mode =3D spi->mode;
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, val);
> +       priv->mode =3D spi->mode;
>  }
>
> -static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
> -                               struct spi_device *spi, struct spi_transf=
er *t)
> +static int loongson_spi_update_state(struct loongson_spi_priv *priv, str=
uct spi_device *spi,
> +                                    struct spi_transfer *t)
>  {
>         int ret;
>
> -       if (t && loongson_spi->hz !=3D t->speed_hz) {
> -               ret =3D loongson_spi_set_clk(loongson_spi, t->speed_hz);
> +       if (t && priv->hz !=3D t->speed_hz) {
> +               ret =3D loongson_spi_set_clk(priv, t->speed_hz);
>                 if (ret)
>                         return ret;
>         }
>
> -       if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
> -               loongson_spi_set_mode(loongson_spi, spi);
> +       if ((spi->mode ^ priv->mode) & SPI_MODE_X_MASK)
> +               loongson_spi_set_mode(priv, spi);
>
>         return 0;
>  }
>
>  static int loongson_spi_setup(struct spi_device *spi)
>  {
> -       struct loongson_spi *loongson_spi;
> +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(spi=
->controller);
>
> -       loongson_spi =3D spi_controller_get_devdata(spi->controller);
>         if (spi->bits_per_word % 8)
>                 return -EINVAL;
>
>         if (spi_get_chipselect(spi, 0) >=3D spi->controller->num_chipsele=
ct)
>                 return -EINVAL;
>
> -       loongson_spi->hz =3D 0;
> +       priv->hz =3D 0;
>         loongson_spi_set_cs(spi, !(spi->mode & SPI_CS_HIGH));
>
>         return 0;
>  }
>
>  static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8=
 **tx_buf,
> -                                       u8 **rx_buf, unsigned int num)
> +                                       u8 **rx_buf)
>  {
> -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
spi->controller);
> +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(spi=
->controller);
>         unsigned char status;
>         int ret;
>
>         if (tx_buf && *tx_buf)
> -               loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_RE=
G, *((*tx_buf)++));
> +               loongson_spi_write_reg(priv, LOONGSON_SPI_FIFO_REG, *((*t=
x_buf)++));
>         else
> -               loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_RE=
G, 0);
> +               loongson_spi_write_reg(priv, LOONGSON_SPI_FIFO_REG, 0);
>
> -       ret =3D readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR=
_REG,
> +       ret =3D readb_poll_timeout(priv->base + LOONGSON_SPI_SPSR_REG,
>                                  status,
>                                  !(status & LOONGSON_SPI_SPSR_RFEMPTY),
>                                  1, USEC_PER_MSEC);
>
>         if (rx_buf && *rx_buf)
> -               *(*rx_buf)++ =3D loongson_spi_read_reg(loongson_spi, LOON=
GSON_SPI_FIFO_REG);
> +               *(*rx_buf)++ =3D loongson_spi_read_reg(priv, LOONGSON_SPI=
_FIFO_REG);
>         else
> -               loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG=
);
> +               loongson_spi_read_reg(priv, LOONGSON_SPI_FIFO_REG);
>
>         return ret;
>  }
>
>  static int loongson_spi_write_read(struct spi_device *spi, struct spi_tr=
ansfer *xfer)
>  {
> -       int ret;
> -       unsigned int count;
> +       unsigned int count =3D xfer->len;
>         const u8 *tx =3D xfer->tx_buf;
>         u8 *rx =3D xfer->rx_buf;
> +       int ret;
>
> -       count =3D xfer->len;
>         do {
> -               ret =3D loongson_spi_write_read_8bit(spi, &tx, &rx, count=
);
> +               ret =3D loongson_spi_write_read_8bit(spi, &tx, &rx);
>                 if (ret)
>                         break;
>         } while (--count);
> @@ -185,25 +235,25 @@ static int loongson_spi_write_read(struct spi_devic=
e *spi, struct spi_transfer *
>         return ret;
>  }
>
> -static int loongson_spi_prepare_message(struct spi_controller *ctlr, str=
uct spi_message *m)
> +static int loongson_spi_prepare_message(struct spi_controller *host, str=
uct spi_message *m)
>  {
> -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
ctlr);
> +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(hos=
t);
>         unsigned char para;
>
> -       para =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_RE=
G);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
> +       para =3D loongson_spi_read_reg(priv, LOONGSON_SPI_PARA_REG);
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_PARA_REG,
>                                para & ~LOONGSON_SPI_PARA_MEM_EN);
>
>         return 0;
>  }
>
> -static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct=
 spi_device *spi,
> +static int loongson_spi_transfer_one(struct spi_controller *host, struct=
 spi_device *spi,
>                                      struct spi_transfer *xfer)
>  {
> -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
spi->controller);
> +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(spi=
->controller);
>         int ret;
>
> -       ret =3D loongson_spi_update_state(loongson_spi, spi, xfer);
> +       ret =3D loongson_spi_update_state(priv, spi, xfer);
>         if (ret)
>                 return ret;
>
> @@ -213,33 +263,33 @@ static int loongson_spi_transfer_one(struct spi_con=
troller *ctrl, struct spi_dev
>         return 0;
>  }
>
> -static int loongson_spi_unprepare_message(struct spi_controller *ctrl, s=
truct spi_message *m)
> +static int loongson_spi_unprepare_message(struct spi_controller *host, s=
truct spi_message *m)
>  {
> -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
ctrl);
> +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(hos=
t);
>         unsigned char para;
>
>         /* Restore the hardware SPI Flash read path */
> -       para =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_RE=
G);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
> +       para =3D loongson_spi_read_reg(priv, LOONGSON_SPI_PARA_REG);
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_PARA_REG,
>                                para | LOONGSON_SPI_PARA_MEM_EN);
>
>         return 0;
>  }
>
> -static void loongson_spi_reginit(struct loongson_spi *loongson_spi_dev)
> +static void loongson_spi_reginit(struct loongson_spi_priv *priv)
>  {
>         unsigned char val;
>
> -       val =3D loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SPCR=
_REG);
> +       val =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
>         val &=3D ~LOONGSON_SPI_SPCR_SPE;
> -       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, v=
al);
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, val);
>
> -       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPSR_REG,
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPSR_REG,
>                                (LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPS=
R_WCOL));
>
> -       val =3D loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SPCR=
_REG);
> +       val =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
>         val |=3D LOONGSON_SPI_SPCR_SPE;
> -       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, v=
al);
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, val);
>  }
>
>  static int loongson_spi_get_clk_rate(struct device *dev, u64 *clk_rate)
> @@ -265,74 +315,73 @@ static int loongson_spi_get_clk_rate(struct device =
*dev, u64 *clk_rate)
>
>  int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
>  {
> -       struct spi_controller *controller;
> -       struct loongson_spi *spi;
> +       struct loongson_spi_priv *priv;
> +       struct spi_controller *host;
>         int ret;
>
> -       controller =3D devm_spi_alloc_host(dev, sizeof(struct loongson_sp=
i));
> -       if (controller =3D=3D NULL)
> +       host =3D devm_spi_alloc_host(dev, sizeof(*priv));
> +       if (!host)
>                 return -ENOMEM;
>
> -       controller->mode_bits =3D SPI_MODE_X_MASK | SPI_CS_HIGH;
> -       controller->setup =3D loongson_spi_setup;
> -       controller->prepare_message =3D loongson_spi_prepare_message;
> -       controller->transfer_one =3D loongson_spi_transfer_one;
> -       controller->unprepare_message =3D loongson_spi_unprepare_message;
> -       controller->set_cs =3D loongson_spi_set_cs;
> -       controller->num_chipselect =3D 4;
> -       dev_set_drvdata(dev, controller);
> +       host->mode_bits =3D SPI_MODE_X_MASK | SPI_CS_HIGH;
> +       host->setup =3D loongson_spi_setup;
> +       host->prepare_message =3D loongson_spi_prepare_message;
> +       host->transfer_one =3D loongson_spi_transfer_one;
> +       host->unprepare_message =3D loongson_spi_unprepare_message;
> +       host->set_cs =3D loongson_spi_set_cs;
> +       host->num_chipselect =3D 4;
> +       dev_set_drvdata(dev, host);
>
> -       spi =3D spi_controller_get_devdata(controller);
> -       spi->base =3D regs;
> -       spi->controller =3D controller;
> +       priv =3D spi_controller_get_devdata(host);
> +       priv->base =3D regs;
> +       priv->controller =3D host;
>
> -       ret =3D loongson_spi_get_clk_rate(dev, &spi->clk_rate);
> +       ret =3D loongson_spi_get_clk_rate(dev, &priv->clk_rate);
>         if (ret)
>                 return dev_err_probe(dev, ret, "unable to get clock rate"=
);
>
> -       loongson_spi_reginit(spi);
> -
> -       spi->mode =3D 0;
> +       loongson_spi_reginit(priv);
> +       priv->mode =3D 0;
>
> -       return devm_spi_register_controller(dev, controller);
> +       return devm_spi_register_controller(dev, host);
>  }
>  EXPORT_SYMBOL_NS_GPL(loongson_spi_init_controller, "SPI_LOONGSON_CORE");
>
>  static int loongson_spi_suspend(struct device *dev)
>  {
> -       struct spi_controller *controller =3D dev_get_drvdata(dev);
> -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
controller);
> +       struct spi_controller *host =3D dev_get_drvdata(dev);
> +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(hos=
t);
>         int ret;
>
> -       ret =3D spi_controller_suspend(controller);
> +       ret =3D spi_controller_suspend(host);
>         if (ret)
>                 return ret;
>
> -       loongson_spi->lss.spcr =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_SPCR_REG);
> -       loongson_spi->lss.sper =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_SPER_REG);
> -       loongson_spi->lss.spsr =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_SPSR_REG);
> -       loongson_spi->lss.para =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_PARA_REG);
> -       loongson_spi->lss.sfcs =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_SFCS_REG);
> -       loongson_spi->lss.timi =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_TIMI_REG);
> +       priv->lss.spcr =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_=
REG);
> +       priv->lss.sper =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPER_=
REG);
> +       priv->lss.spsr =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPSR_=
REG);
> +       priv->lss.para =3D loongson_spi_read_reg(priv, LOONGSON_SPI_PARA_=
REG);
> +       priv->lss.sfcs =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SFCS_=
REG);
> +       priv->lss.timi =3D loongson_spi_read_reg(priv, LOONGSON_SPI_TIMI_=
REG);
>
>         return 0;
>  }
>
>  static int loongson_spi_resume(struct device *dev)
>  {
> -       struct spi_controller *controller =3D dev_get_drvdata(dev);
> -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
controller);
> +       struct spi_controller *host =3D dev_get_drvdata(dev);
> +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(hos=
t);
>
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loong=
son_spi->lss.spcr);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loong=
son_spi->lss.sper);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loong=
son_spi->lss.para);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, loong=
son_spi->lss.sfcs);
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG, loong=
son_spi->lss.timi);
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, priv->lss.spc=
r);
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPER_REG, priv->lss.spe=
r);
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_PARA_REG, priv->lss.par=
a);
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_SFCS_REG, priv->lss.sfc=
s);
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_TIMI_REG, priv->lss.tim=
i);
>
> -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG,
> +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPSR_REG,
>                                LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR=
_WCOL);
>
> -       spi_controller_resume(controller);
> +       spi_controller_resume(host);
>
>         return 0;
>  }
> @@ -342,4 +391,5 @@ DEFINE_SIMPLE_DEV_PM_OPS(loongson_spi_dev_pm_ops, loo=
ngson_spi_suspend, loongson
>  EXPORT_SYMBOL_NS_GPL(loongson_spi_dev_pm_ops, "SPI_LOONGSON_CORE");
>
>  MODULE_DESCRIPTION("Loongson SPI core driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-pc=
i.c
> index ccc26efd88fe..ad90be956e1e 100644
> --- a/drivers/spi/spi-loongson-pci.c
> +++ b/drivers/spi/spi-loongson-pci.c
> @@ -1,31 +1,31 @@
>  // SPDX-License-Identifier: GPL-2.0+
> +//
>  // PCI interface driver for Loongson SPI Support
> -// Copyright (C) 2023 Loongson Technology Corporation Limited
> +//
> +// Copyright (C) 2023-2026 Loongson Technology Corporation Limited
>
>  #include <linux/pci.h>
>
>  #include "spi-loongson.h"
>
> -static int loongson_spi_pci_register(struct pci_dev *pdev,
> -                       const struct pci_device_id *ent)
> +static int loongson_spi_pci_register(struct pci_dev *pdev, const struct =
pci_device_id *ent)
>  {
> -       int ret;
> -       void __iomem *reg_base;
>         struct device *dev =3D &pdev->dev;
> -       int pci_bar =3D 0;
> +       void __iomem *reg_base;
> +       int pci_bar =3D 0, ret;
>
>         ret =3D pcim_enable_device(pdev);
>         if (ret < 0)
> -               return dev_err_probe(dev, ret, "cannot enable pci device\=
n");
> +               return dev_err_probe(dev, ret, "cannot enable pci device"=
);
>
>         reg_base =3D pcim_iomap_region(pdev, pci_bar, pci_name(pdev));
>         ret =3D PTR_ERR_OR_ZERO(reg_base);
>         if (ret)
> -               return dev_err_probe(dev, ret, "failed to request and rem=
ap memory\n");
> +               return dev_err_probe(dev, ret, "failed to request and rem=
ap memory");
>
>         ret =3D loongson_spi_init_controller(dev, reg_base);
>         if (ret)
> -               return dev_err_probe(dev, ret, "failed to initialize cont=
roller\n");
> +               return dev_err_probe(dev, ret, "failed to initialize cont=
roller");
>
>         return 0;
>  }
> @@ -49,5 +49,6 @@ static struct pci_driver loongson_spi_pci_driver =3D {
>  module_pci_driver(loongson_spi_pci_driver);
>
>  MODULE_DESCRIPTION("Loongson spi pci driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
>  MODULE_LICENSE("GPL");
>  MODULE_IMPORT_NS("SPI_LOONGSON_CORE");
> diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson-p=
lat.c
> index 6f8202264341..dcfbdd50e996 100644
> --- a/drivers/spi/spi-loongson-plat.c
> +++ b/drivers/spi/spi-loongson-plat.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0+
> +//
>  // Platform driver for Loongson SPI Support
> -// Copyright (C) 2023 Loongson Technology Corporation Limited
> +//
> +// Copyright (C) 2023-2026 Loongson Technology Corporation Limited
>
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
> @@ -9,9 +11,9 @@
>
>  static int loongson_spi_platform_probe(struct platform_device *pdev)
>  {
> -       int ret;
> -       void __iomem *reg_base;
>         struct device *dev =3D &pdev->dev;
> +       void __iomem *reg_base;
> +       int ret;
>
>         reg_base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(reg_base))
> @@ -19,7 +21,7 @@ static int loongson_spi_platform_probe(struct platform_=
device *pdev)
>
>         ret =3D loongson_spi_init_controller(dev, reg_base);
>         if (ret)
> -               return dev_err_probe(dev, ret, "failed to initialize cont=
roller\n");
> +               return dev_err_probe(dev, ret, "failed to initialize cont=
roller");
>
>         return 0;
>  }
> @@ -42,5 +44,6 @@ static struct platform_driver loongson_spi_plat_driver =
=3D {
>  module_platform_driver(loongson_spi_plat_driver);
>
>  MODULE_DESCRIPTION("Loongson spi platform driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
>  MODULE_LICENSE("GPL");
>  MODULE_IMPORT_NS("SPI_LOONGSON_CORE");
> diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
> index 89efd4ce69d8..c8b722bc5fb5 100644
> --- a/drivers/spi/spi-loongson.h
> +++ b/drivers/spi/spi-loongson.h
> @@ -1,56 +1,13 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
> -/* Header File for Loongson SPI Driver. */
> -/* Copyright (C) 2023 Loongson Technology Corporation Limited */
> +//
> +// Loongson SPI Support - common header
> +//
> +// Copyright (C) 2023-2026 Loongson Technology Corporation Limited
>
>  #ifndef __LINUX_SPI_LOONGSON_H
>  #define __LINUX_SPI_LOONGSON_H
>
> -#include <linux/bits.h>
> -#include <linux/pm.h>
> -#include <linux/types.h>
> -
> -#define        LOONGSON_SPI_SPCR_REG   0x00
> -#define        LOONGSON_SPI_SPSR_REG   0x01
> -#define        LOONGSON_SPI_FIFO_REG   0x02
> -#define        LOONGSON_SPI_SPER_REG   0x03
> -#define        LOONGSON_SPI_PARA_REG   0x04
> -#define        LOONGSON_SPI_SFCS_REG   0x05
> -#define        LOONGSON_SPI_TIMI_REG   0x06
> -
> -/* Bits definition for Loongson SPI register */
> -#define        LOONGSON_SPI_PARA_MEM_EN        BIT(0)
> -#define        LOONGSON_SPI_SPCR_CPHA  BIT(2)
> -#define        LOONGSON_SPI_SPCR_CPOL  BIT(3)
> -#define        LOONGSON_SPI_SPCR_SPE   BIT(6)
> -#define        LOONGSON_SPI_SPSR_RFEMPTY       BIT(0)
> -#define        LOONGSON_SPI_SPSR_WCOL  BIT(6)
> -#define        LOONGSON_SPI_SPSR_SPIF  BIT(7)
> -
> -#define LOONGSON_SPI_DIV_MIN           2
> -#define LOONGSON_SPI_DIV_MAX           4096
> -
> -struct device;
> -struct spi_controller;
> -
> -struct loongson_spi_suspend_store {
> -       unsigned char           spcr;
> -       unsigned char           sper;
> -       unsigned char           spsr;
> -       unsigned char           para;
> -       unsigned char           sfcs;
> -       unsigned char           timi;
> -};
> -
> -struct loongson_spi {
> -       struct  spi_controller  *controller;
> -       void __iomem            *base;
> -       int                     cs_active;
> -       unsigned int            hz;
> -       unsigned int            mode;
> -       u64                     clk_rate;
> -       struct loongson_spi_suspend_store lss;
> -};
> -
>  int loongson_spi_init_controller(struct device *dev, void __iomem *reg);
>  extern const struct dev_pm_ops loongson_spi_dev_pm_ops;
> +
>  #endif /* __LINUX_SPI_LOONGSON_H */
> --
> 2.52.0
>
>
