Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793880333;
	b=r2WqQyUagSHrKVNr2efYHEeeLwmswplm2KdRd+aBAW51X3ij8pTLNXPeUrkRMXsQZyr6
	 2iN0wh7Mu2UdcPv1Kk1l/mRT2uxx7CagWDla0TwBR+/WtYWGKkW6ovAVJ3AUvgYY6IfvQ
	 sQcvxvNf8yqvDhNvtQlqjZo+kpTgDPi5d7eB93dKZ8ra4WTTgSZ5AwLjbyWTNWFHsUN6f
	 Ax1wMurX11Jne2mk79ieVoMxOO2AF8Fdsq4XaClYXvQ7y0VLxRxQa++TeyKqzqmTqgapz
	 4wVqruopdbsvHkfRRtGxwLDhnoVQI4X/LZTbd9K/jCEZHZwRPfzdYYSp0ETu3PP3kjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xxqwL3Dda53UbBWezaEVuIeSAMM2Wm5na/CSFudsxxc=;
	b=NxTVqYF0IP2CKh2BCE/obKpMm60TjwQBZJmOa/P1Do7tOfekdEn1853YT6WvjYomeuwj
	 6T974UxqjJjZl1H69IL7iXSntzLIqH21d2Kvi7q60KdWH3ki9lXAoWGjisflZmQdwORhq
	 LP45QyoPyZuRgSVJfFvFx70/X5PrSrIVlnu/OjMB8VyE0zPYcCGJRLYx9XAxy1uHeOoXK
	 aK+lBoRc6iqb+ZAS6AywykJd91NPm+do3WkN4rKtGmxYO3OSeVnumT8SrQN4PsgL/85IB
	 bmWIyFrxe1lx9Pni46Ucq07fjx9v7VbwqcKP19tW6jomEE91sRdP2t3zESuzG15meBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YQsGqn0J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F64606A31B
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 12:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11F64606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YQsGqn0J
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eac6c5f927so722873e0c.0
        for <linux-spi@vger.kernel.org>; Thu, 05 Nov 2026 04:05:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793880331; cv=none;
        d=google.com; s=arc-20260327;
        b=guRL1gh1jmzDVQnfgKZlFSWDGDvzxKgkYt3+LQS1BvhZXhEr98cCo8V55wLDVd913D
         Pgcn6CeU+t9jAaC0pNU24h9OcQXbgM0kpoK+XXdI1uezKZzWLl7LO6rCfJaFeaq53pqX
         9kbgmOMgMyocGQ/4bTGNS8n/fgSiYU12qQaHlERzQqGghz4d5jWtHFT8j+T5XBG8UTS0
         zeYxpgrZYAm36Xks7cCAawbuDPJpqYl2AEhaSb7shQGnGtgp0hbzv/NoHW0L2s6F4u3v
         BmQKOml9ahhVwxJ9OqbcfxbcOAHDxkzQPe+NrRW7w6fgdM2NmSg43ycDapVEbCZcDI98
         wZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xxqwL3Dda53UbBWezaEVuIeSAMM2Wm5na/CSFudsxxc=;
        fh=A/SW/YQvLaq6HcpCFTVpP3PGXtwZ8vvR/V6cxuOK3oM=;
        b=RuQWkbU1kjBrz80ZcGZEsYVQ8sxJHaAbZlh0sHW46be8Tvn3kcHmj2RdVExDCYpkB8
         Z8fKXmE4H+V7zdityx4bbXg9Pt/F2wtdFnOnMVpRap/MotaO6trHH2nh1WmXUtChLr4i
         gr+V7cAmefS3XAjvy1XoyCJRKCTpJ3LR/w/QoaMaEg0VjghIuFUrQ/7D3HnJILV6Voew
         zHcpnp4CL4I4zm83eKTOkLHP0sISf5fgfZVspC7QqZhSkY2/wKa9f3JwuKMrAIuVzL7X
         fwkx3DJt3JKcUGJSHwL70yJqOBOTc3CMtSI1LIgFHjgczObQIDXOROdpHRuwTIU4bcPX
         ppHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793880331; x=1794485131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xxqwL3Dda53UbBWezaEVuIeSAMM2Wm5na/CSFudsxxc=;
        b=YQsGqn0J00Y8uIJ/xW1qjztypXsb80fBRXd1p/3XBX9QuoZLDbUDw4Jk9R5TiygyG+
         sQuYMi8mtGZ3VgHFTwp2ibB5cEulaAMIg6j8oU79YjlZmuGZ6aP14pHisGwwLyF3D0rI
         SEKjhPa2k+YA83/lVDd4gfJrAC3a8ZWM8Zyy0uZpOHAmzo7bdu6ppSiEcC0tKuGD/EqM
         7KB6FmytuHx/gFFAuwUMNEsuvwFvoe4A1lAnG7v1reD0jLP/IH9ZLWdNiZJI5dmKI8uV
         XamLYKRAKSexlPiPbvKpEvSTysZCAe/w0He8cjGjANAg4zq04JOwXWnjWqLQQa1ukzU9
         FKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793880331; x=1794485131;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xxqwL3Dda53UbBWezaEVuIeSAMM2Wm5na/CSFudsxxc=;
        b=E1Pfkaop82BBNy0JheMig/j6nk80CIluJ5/MwBFYtnBSk0lW7RRsKjIfG2ldShI+32
         PE74tWVYWlabgGWFVKXXH8OmBTOInf/5ChCaloibiE+WRETNqthpIq+RaKxmxBN2HwT1
         WDCEwcKqPv46E78RLG7isaHa/Q2z5oTLS1mzJPboaLaOp8pHUlI8TMkp1Owaly12vlxZ
         3852YODnxidln+lWdWFXN7agHRADjUYj9tZdheoWn59bpHnx5KsLQqcT5BVzNarEnVZU
         hZILB65I0jgyTWGO1YREay99kAazCqaCqdsxreS1WjtnlbZPFHmA4w5h2yKc8pAqEtS4
         tHMg==
X-Forwarded-Encrypted: i=1; AKwUvBy2aZ/8KqpIhdAt9ykKg+JmC5Ma47v5f90kvGnpV9ua9209wu4gz7QjUPaJmGsj2Yg37rK/Ke/4bBE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qtDqz9HbuNQ2RH9eMmqWX3vg7BOoBrioiQplYA5etOYmUrsrE
	zLjkXrtrD6Pw/Ck3JJ0A4w9+RIydokFUT5rtfn00ECwzXmw/lZ3vfXQ2tqhkhzwLrwYk7qpiSmP
	5D/7SdLL2LaJUypuzsuimDEBCQuJMNM4=
X-Gm-Gg: AYBFou2xBt3uN4qVBkviIBbnk2BW85uizfViBTQIcdxFmr+TluXyZHuXdqKc7S5tGxt
	qm1QlLT1sa+Kmu1qBsFNZnJmchJCZlz30T7tXoQr6hrmJmIpLYWzKUyPgcT+TSz97sn/zxB1aO3
	cCXeqoX8IBCFWgBlYus0IHy6PYgI1jZGSosN/GE31pOiRdGKa+2iIPINmFC2Iq+aqzJzqNiaehD
	24OcBYRbDKynDGsWSmPAK5llCux04Pi3PaU6QQg9HME+4gptyHHdrNQUEg9Ed7BZDYV35PFLi3K
	PJz4OMy3kDV7x+kqDVM729qy0YDT/KUNN7PhSnlUdlk8GdTF0oTSjscYtZaedTNJROd5ZvPTMj9
	5uFXj9QoB9Roib4z+WdEdS8Od3tBYqCQA/Vrz
X-Received: by 2002:a05:6123:109:b0:5ea:98fb:e9de with SMTP id
 71dfb90a1353d-5ec685210d5mr9091876e0c.3.1793880330706; Thu, 05 Nov 2026
 04:05:30 -0800 (PST)
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
 <CAAhV-H4k_GkOOus2zGA=Cmnu9oo3HAeeCK2msGB41=NvPsvb=g@mail.gmail.com>
In-Reply-To: <CAAhV-H4k_GkOOus2zGA=Cmnu9oo3HAeeCK2msGB41=NvPsvb=g@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 5 Nov 2026 20:05:16 +0800
X-Gm-Features: AclHuK9ToNv3NE6Q1nKbC9dHcVxl3FTNA8v4hp3-w7uQab45XBn-378EpEIK4o4
Message-ID: <CAMpQs4+hk+hKqYcYgvQo23x8ctkCrd8MMjedpk_3DqP9VXkV1g@mail.gmail.com>
Subject: Re: [PATCH 6/8] spi: loongson: Move private definitions into the core driver
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi:

On Wed, Nov 4, 2026 at 6:04=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> Hi, Binbin,
>
> On Tue, Nov 3, 2026 at 3:08=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.c=
n> wrote:
> >
> > The Loongson SPI register definitions and the private controller
> > structure are only used by the core driver.  Move them from the shared
> > header into spi-loongson-core.c and rename the structure to
> > loongson_spi_priv to make it clear that it is driver-private data.
> Moving is OK but renaming is unnecessary.

I agree this patch does too much and mixes the move with
unnecessary renaming and cleanups. Keeping the current structure and
naming seems better for now.

I'll drop this patch and respin the series without it.

>
> Huacai
>
> >
> > The shared header now only contains the exported init function and the
> > PM ops declaration, which reduces the surface exposed to the PCI and
> > platform glue drivers.
> >
> > While at it, update the copyright years and add MODULE_AUTHOR() entries
> > to the PCI and platform drivers.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  drivers/spi/spi-loongson-core.c | 252 +++++++++++++++++++-------------
> >  drivers/spi/spi-loongson-pci.c  |  19 +--
> >  drivers/spi/spi-loongson-plat.c |  11 +-
> >  drivers/spi/spi-loongson.h      |  53 +------
> >  4 files changed, 173 insertions(+), 162 deletions(-)
> >
> > diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson=
-core.c
> > index 91d7acbe4302..082248f29ae7 100644
> > --- a/drivers/spi/spi-loongson-core.c
> > +++ b/drivers/spi/spi-loongson-core.c
> > @@ -1,21 +1,71 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> > -// Loongson SPI Support
> > -// Copyright (C) 2023 Loongson Technology Corporation Limited
> > +//
> > +// Loongson SPI Controller driver
> > +//
> > +// Copyright (C) 2023-2026 Loongson Technology Corporation Limited
> >
> >  #include <linux/clk.h>
> > -#include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/export.h>
> >  #include <linux/init.h>
> > -#include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/iopoll.h>
> > -#include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/spi/spi.h>
> >
> >  #include "spi-loongson.h"
> >
> > +/* SPI controller register offsets */
> > +#define LOONGSON_SPI_SPCR_REG          0x00
> > +#define LOONGSON_SPI_SPSR_REG          0x01
> > +#define LOONGSON_SPI_FIFO_REG          0x02
> > +#define LOONGSON_SPI_SPER_REG          0x03
> > +#define LOONGSON_SPI_PARA_REG          0x04
> > +#define LOONGSON_SPI_SFCS_REG          0x05
> > +#define LOONGSON_SPI_TIMI_REG          0x06
> > +
> > +/* SPCR bits */
> > +#define LOONGSON_SPI_SPCR_SPR          GENMASK(1, 0)
> > +#define LOONGSON_SPI_SPCR_CPHA         BIT(2)
> > +#define LOONGSON_SPI_SPCR_CPOL         BIT(3)
> > +#define LOONGSON_SPI_SPCR_SPE          BIT(6)
> > +#define LOONGSON_SPI_SPCR_SPIE         BIT(7)
> > +
> > +/* SPSR bits */
> > +#define LOONGSON_SPI_SPSR_RFEMPTY      BIT(0)
> > +#define LOONGSON_SPI_SPSR_RFFULL       BIT(1)
> > +#define LOONGSON_SPI_SPSR_WFEMPTY      BIT(2)
> > +#define LOONGSON_SPI_SPSR_WFFULL       BIT(3)
> > +#define LOONGSON_SPI_SPSR_WCOL         BIT(6)
> > +#define LOONGSON_SPI_SPSR_SPIF         BIT(7)
> > +
> > +/* SPER bits */
> > +#define LOONGSON_SPI_SPER_SPRE         GENMASK(1, 0)
> > +
> > +/* SFC_PARAM bits */
> > +#define LOONGSON_SPI_PARA_MEM_EN       BIT(0)
> > +
> > +#define LOONGSON_SPI_DIV_MIN           2
> > +#define LOONGSON_SPI_DIV_MAX           4096
> > +
> > +struct loongson_spi_suspend_store {
> > +       unsigned char           spcr;
> > +       unsigned char           sper;
> > +       unsigned char           spsr;
> > +       unsigned char           para;
> > +       unsigned char           sfcs;
> > +       unsigned char           timi;
> > +};
> > +
> > +struct loongson_spi_priv {
> > +       struct spi_controller   *controller;
> > +       void __iomem            *base;
> > +       unsigned int            hz;
> > +       unsigned int            mode;
> > +       u64                     clk_rate;
> > +       struct loongson_spi_suspend_store lss;
> > +};
> > +
> >  static const struct {
> >         unsigned int    div;
> >         unsigned char   spr;
> > @@ -35,38 +85,38 @@ static const struct {
> >         {4096, 3, 2 },
> >  };
> >
> > -static inline void loongson_spi_write_reg(struct loongson_spi *spi, un=
signed char reg,
> > +static inline void loongson_spi_write_reg(struct loongson_spi_priv *pr=
iv, unsigned char reg,
> >                                           unsigned char data)
> >  {
> > -       writeb(data, spi->base + reg);
> > +       writeb(data, priv->base + reg);
> >  }
> >
> > -static inline char loongson_spi_read_reg(struct loongson_spi *spi, uns=
igned char reg)
> > +static inline char loongson_spi_read_reg(struct loongson_spi_priv *pri=
v, unsigned char reg)
> >  {
> > -       return readb(spi->base + reg);
> > +       return readb(priv->base + reg);
> >  }
> >
> >  static void loongson_spi_set_cs(struct spi_device *spi, bool en)
> >  {
> > -       int cs;
> > +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(s=
pi->controller);
> >         unsigned char mask =3D (BIT(4) | BIT(0)) << spi_get_chipselect(=
spi, 0);
> > -       unsigned char val =3D en ? mask :  (BIT(0) << spi_get_chipselec=
t(spi, 0));
> > -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdat=
a(spi->controller);
> > +       unsigned char val =3D en ? mask : (BIT(0) << spi_get_chipselect=
(spi, 0));
> > +       int cs;
> >
> > -       cs =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_RE=
G) & ~mask;
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, val=
 | cs);
> > +       cs =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SFCS_REG) & ~ma=
sk;
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_SFCS_REG, val | cs);
> >  }
> >
> > -static int loongson_spi_set_clk(struct loongson_spi *loongson_spi, uns=
igned int hz)
> > +static int loongson_spi_set_clk(struct loongson_spi_priv *priv, unsign=
ed int hz)
> >  {
> >         unsigned long div;
> >         unsigned char val;
> >         unsigned int i;
> >
> > -       if (!hz || !loongson_spi->clk_rate)
> > +       if (!hz || !priv->clk_rate)
> >                 return -EINVAL;
> >
> > -       div =3D DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz);
> > +       div =3D DIV_ROUND_UP_ULL(priv->clk_rate, hz);
> >         if (div < LOONGSON_SPI_DIV_MIN)
> >                 div =3D LOONGSON_SPI_DIV_MIN;
> >
> > @@ -78,106 +128,106 @@ static int loongson_spi_set_clk(struct loongson_=
spi *loongson_spi, unsigned int
> >         if (i =3D=3D ARRAY_SIZE(loongson_spi_div_table))
> >                 return -EINVAL;
> >
> > -       val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_R=
EG);
> > +       val =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
> >         val &=3D ~GENMASK(1, 0);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG,
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG,
> >                                val | loongson_spi_div_table[i].spr);
> >
> > -       val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_R=
EG);
> > +       val =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPER_REG);
> >         val &=3D ~GENMASK(1, 0);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG,
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPER_REG,
> >                                val | loongson_spi_div_table[i].spre);
> >
> > -       loongson_spi->hz =3D hz;
> > +       priv->hz =3D hz;
> >
> >         return 0;
> >  }
> >
> > -static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
> > +static void loongson_spi_set_mode(struct loongson_spi_priv *priv,
> >                                   struct spi_device *spi)
> >  {
> >         unsigned char val;
> >
> > -       val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_R=
EG);
> > +       val =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
> >         val &=3D ~(LOONGSON_SPI_SPCR_CPOL | LOONGSON_SPI_SPCR_CPHA);
> > +
> >         if (spi->mode & SPI_CPOL)
> >                 val |=3D LOONGSON_SPI_SPCR_CPOL;
> > +
> >         if (spi->mode & SPI_CPHA)
> >                 val |=3D LOONGSON_SPI_SPCR_CPHA;
> >
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val=
);
> > -       loongson_spi->mode =3D spi->mode;
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, val);
> > +       priv->mode =3D spi->mode;
> >  }
> >
> > -static int loongson_spi_update_state(struct loongson_spi *loongson_spi=
,
> > -                               struct spi_device *spi, struct spi_tran=
sfer *t)
> > +static int loongson_spi_update_state(struct loongson_spi_priv *priv, s=
truct spi_device *spi,
> > +                                    struct spi_transfer *t)
> >  {
> >         int ret;
> >
> > -       if (t && loongson_spi->hz !=3D t->speed_hz) {
> > -               ret =3D loongson_spi_set_clk(loongson_spi, t->speed_hz)=
;
> > +       if (t && priv->hz !=3D t->speed_hz) {
> > +               ret =3D loongson_spi_set_clk(priv, t->speed_hz);
> >                 if (ret)
> >                         return ret;
> >         }
> >
> > -       if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
> > -               loongson_spi_set_mode(loongson_spi, spi);
> > +       if ((spi->mode ^ priv->mode) & SPI_MODE_X_MASK)
> > +               loongson_spi_set_mode(priv, spi);
> >
> >         return 0;
> >  }
> >
> >  static int loongson_spi_setup(struct spi_device *spi)
> >  {
> > -       struct loongson_spi *loongson_spi;
> > +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(s=
pi->controller);
> >
> > -       loongson_spi =3D spi_controller_get_devdata(spi->controller);
> >         if (spi->bits_per_word % 8)
> >                 return -EINVAL;
> >
> >         if (spi_get_chipselect(spi, 0) >=3D spi->controller->num_chipse=
lect)
> >                 return -EINVAL;
> >
> > -       loongson_spi->hz =3D 0;
> > +       priv->hz =3D 0;
> >         loongson_spi_set_cs(spi, !(spi->mode & SPI_CS_HIGH));
> >
> >         return 0;
> >  }
> >
> >  static int loongson_spi_write_read_8bit(struct spi_device *spi, const =
u8 **tx_buf,
> > -                                       u8 **rx_buf, unsigned int num)
> > +                                       u8 **rx_buf)
> >  {
> > -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdat=
a(spi->controller);
> > +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(s=
pi->controller);
> >         unsigned char status;
> >         int ret;
> >
> >         if (tx_buf && *tx_buf)
> > -               loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_=
REG, *((*tx_buf)++));
> > +               loongson_spi_write_reg(priv, LOONGSON_SPI_FIFO_REG, *((=
*tx_buf)++));
> >         else
> > -               loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_=
REG, 0);
> > +               loongson_spi_write_reg(priv, LOONGSON_SPI_FIFO_REG, 0);
> >
> > -       ret =3D readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SP=
SR_REG,
> > +       ret =3D readb_poll_timeout(priv->base + LOONGSON_SPI_SPSR_REG,
> >                                  status,
> >                                  !(status & LOONGSON_SPI_SPSR_RFEMPTY),
> >                                  1, USEC_PER_MSEC);
> >
> >         if (rx_buf && *rx_buf)
> > -               *(*rx_buf)++ =3D loongson_spi_read_reg(loongson_spi, LO=
ONGSON_SPI_FIFO_REG);
> > +               *(*rx_buf)++ =3D loongson_spi_read_reg(priv, LOONGSON_S=
PI_FIFO_REG);
> >         else
> > -               loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_R=
EG);
> > +               loongson_spi_read_reg(priv, LOONGSON_SPI_FIFO_REG);
> >
> >         return ret;
> >  }
> >
> >  static int loongson_spi_write_read(struct spi_device *spi, struct spi_=
transfer *xfer)
> >  {
> > -       int ret;
> > -       unsigned int count;
> > +       unsigned int count =3D xfer->len;
> >         const u8 *tx =3D xfer->tx_buf;
> >         u8 *rx =3D xfer->rx_buf;
> > +       int ret;
> >
> > -       count =3D xfer->len;
> >         do {
> > -               ret =3D loongson_spi_write_read_8bit(spi, &tx, &rx, cou=
nt);
> > +               ret =3D loongson_spi_write_read_8bit(spi, &tx, &rx);
> >                 if (ret)
> >                         break;
> >         } while (--count);
> > @@ -185,25 +235,25 @@ static int loongson_spi_write_read(struct spi_dev=
ice *spi, struct spi_transfer *
> >         return ret;
> >  }
> >
> > -static int loongson_spi_prepare_message(struct spi_controller *ctlr, s=
truct spi_message *m)
> > +static int loongson_spi_prepare_message(struct spi_controller *host, s=
truct spi_message *m)
> >  {
> > -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdat=
a(ctlr);
> > +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(h=
ost);
> >         unsigned char para;
> >
> > -       para =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_=
REG);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
> > +       para =3D loongson_spi_read_reg(priv, LOONGSON_SPI_PARA_REG);
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_PARA_REG,
> >                                para & ~LOONGSON_SPI_PARA_MEM_EN);
> >
> >         return 0;
> >  }
> >
> > -static int loongson_spi_transfer_one(struct spi_controller *ctrl, stru=
ct spi_device *spi,
> > +static int loongson_spi_transfer_one(struct spi_controller *host, stru=
ct spi_device *spi,
> >                                      struct spi_transfer *xfer)
> >  {
> > -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdat=
a(spi->controller);
> > +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(s=
pi->controller);
> >         int ret;
> >
> > -       ret =3D loongson_spi_update_state(loongson_spi, spi, xfer);
> > +       ret =3D loongson_spi_update_state(priv, spi, xfer);
> >         if (ret)
> >                 return ret;
> >
> > @@ -213,33 +263,33 @@ static int loongson_spi_transfer_one(struct spi_c=
ontroller *ctrl, struct spi_dev
> >         return 0;
> >  }
> >
> > -static int loongson_spi_unprepare_message(struct spi_controller *ctrl,=
 struct spi_message *m)
> > +static int loongson_spi_unprepare_message(struct spi_controller *host,=
 struct spi_message *m)
> >  {
> > -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdat=
a(ctrl);
> > +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(h=
ost);
> >         unsigned char para;
> >
> >         /* Restore the hardware SPI Flash read path */
> > -       para =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_=
REG);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
> > +       para =3D loongson_spi_read_reg(priv, LOONGSON_SPI_PARA_REG);
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_PARA_REG,
> >                                para | LOONGSON_SPI_PARA_MEM_EN);
> >
> >         return 0;
> >  }
> >
> > -static void loongson_spi_reginit(struct loongson_spi *loongson_spi_dev=
)
> > +static void loongson_spi_reginit(struct loongson_spi_priv *priv)
> >  {
> >         unsigned char val;
> >
> > -       val =3D loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SP=
CR_REG);
> > +       val =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
> >         val &=3D ~LOONGSON_SPI_SPCR_SPE;
> > -       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG,=
 val);
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, val);
> >
> > -       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPSR_REG,
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPSR_REG,
> >                                (LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_S=
PSR_WCOL));
> >
> > -       val =3D loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SP=
CR_REG);
> > +       val =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
> >         val |=3D LOONGSON_SPI_SPCR_SPE;
> > -       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG,=
 val);
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, val);
> >  }
> >
> >  static int loongson_spi_get_clk_rate(struct device *dev, u64 *clk_rate=
)
> > @@ -265,74 +315,73 @@ static int loongson_spi_get_clk_rate(struct devic=
e *dev, u64 *clk_rate)
> >
> >  int loongson_spi_init_controller(struct device *dev, void __iomem *reg=
s)
> >  {
> > -       struct spi_controller *controller;
> > -       struct loongson_spi *spi;
> > +       struct loongson_spi_priv *priv;
> > +       struct spi_controller *host;
> >         int ret;
> >
> > -       controller =3D devm_spi_alloc_host(dev, sizeof(struct loongson_=
spi));
> > -       if (controller =3D=3D NULL)
> > +       host =3D devm_spi_alloc_host(dev, sizeof(*priv));
> > +       if (!host)
> >                 return -ENOMEM;
> >
> > -       controller->mode_bits =3D SPI_MODE_X_MASK | SPI_CS_HIGH;
> > -       controller->setup =3D loongson_spi_setup;
> > -       controller->prepare_message =3D loongson_spi_prepare_message;
> > -       controller->transfer_one =3D loongson_spi_transfer_one;
> > -       controller->unprepare_message =3D loongson_spi_unprepare_messag=
e;
> > -       controller->set_cs =3D loongson_spi_set_cs;
> > -       controller->num_chipselect =3D 4;
> > -       dev_set_drvdata(dev, controller);
> > +       host->mode_bits =3D SPI_MODE_X_MASK | SPI_CS_HIGH;
> > +       host->setup =3D loongson_spi_setup;
> > +       host->prepare_message =3D loongson_spi_prepare_message;
> > +       host->transfer_one =3D loongson_spi_transfer_one;
> > +       host->unprepare_message =3D loongson_spi_unprepare_message;
> > +       host->set_cs =3D loongson_spi_set_cs;
> > +       host->num_chipselect =3D 4;
> > +       dev_set_drvdata(dev, host);
> >
> > -       spi =3D spi_controller_get_devdata(controller);
> > -       spi->base =3D regs;
> > -       spi->controller =3D controller;
> > +       priv =3D spi_controller_get_devdata(host);
> > +       priv->base =3D regs;
> > +       priv->controller =3D host;
> >
> > -       ret =3D loongson_spi_get_clk_rate(dev, &spi->clk_rate);
> > +       ret =3D loongson_spi_get_clk_rate(dev, &priv->clk_rate);
> >         if (ret)
> >                 return dev_err_probe(dev, ret, "unable to get clock rat=
e");
> >
> > -       loongson_spi_reginit(spi);
> > -
> > -       spi->mode =3D 0;
> > +       loongson_spi_reginit(priv);
> > +       priv->mode =3D 0;
> >
> > -       return devm_spi_register_controller(dev, controller);
> > +       return devm_spi_register_controller(dev, host);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(loongson_spi_init_controller, "SPI_LOONGSON_CORE"=
);
> >
> >  static int loongson_spi_suspend(struct device *dev)
> >  {
> > -       struct spi_controller *controller =3D dev_get_drvdata(dev);
> > -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdat=
a(controller);
> > +       struct spi_controller *host =3D dev_get_drvdata(dev);
> > +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(h=
ost);
> >         int ret;
> >
> > -       ret =3D spi_controller_suspend(controller);
> > +       ret =3D spi_controller_suspend(host);
> >         if (ret)
> >                 return ret;
> >
> > -       loongson_spi->lss.spcr =3D loongson_spi_read_reg(loongson_spi, =
LOONGSON_SPI_SPCR_REG);
> > -       loongson_spi->lss.sper =3D loongson_spi_read_reg(loongson_spi, =
LOONGSON_SPI_SPER_REG);
> > -       loongson_spi->lss.spsr =3D loongson_spi_read_reg(loongson_spi, =
LOONGSON_SPI_SPSR_REG);
> > -       loongson_spi->lss.para =3D loongson_spi_read_reg(loongson_spi, =
LOONGSON_SPI_PARA_REG);
> > -       loongson_spi->lss.sfcs =3D loongson_spi_read_reg(loongson_spi, =
LOONGSON_SPI_SFCS_REG);
> > -       loongson_spi->lss.timi =3D loongson_spi_read_reg(loongson_spi, =
LOONGSON_SPI_TIMI_REG);
> > +       priv->lss.spcr =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPC=
R_REG);
> > +       priv->lss.sper =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPE=
R_REG);
> > +       priv->lss.spsr =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SPS=
R_REG);
> > +       priv->lss.para =3D loongson_spi_read_reg(priv, LOONGSON_SPI_PAR=
A_REG);
> > +       priv->lss.sfcs =3D loongson_spi_read_reg(priv, LOONGSON_SPI_SFC=
S_REG);
> > +       priv->lss.timi =3D loongson_spi_read_reg(priv, LOONGSON_SPI_TIM=
I_REG);
> >
> >         return 0;
> >  }
> >
> >  static int loongson_spi_resume(struct device *dev)
> >  {
> > -       struct spi_controller *controller =3D dev_get_drvdata(dev);
> > -       struct loongson_spi *loongson_spi =3D spi_controller_get_devdat=
a(controller);
> > +       struct spi_controller *host =3D dev_get_drvdata(dev);
> > +       struct loongson_spi_priv *priv =3D spi_controller_get_devdata(h=
ost);
> >
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loo=
ngson_spi->lss.spcr);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loo=
ngson_spi->lss.sper);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loo=
ngson_spi->lss.para);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, loo=
ngson_spi->lss.sfcs);
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG, loo=
ngson_spi->lss.timi);
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, priv->lss.s=
pcr);
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPER_REG, priv->lss.s=
per);
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_PARA_REG, priv->lss.p=
ara);
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_SFCS_REG, priv->lss.s=
fcs);
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_TIMI_REG, priv->lss.t=
imi);
> >
> > -       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG,
> > +       loongson_spi_write_reg(priv, LOONGSON_SPI_SPSR_REG,
> >                                LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SP=
SR_WCOL);
> >
> > -       spi_controller_resume(controller);
> > +       spi_controller_resume(host);
> >
> >         return 0;
> >  }
> > @@ -342,4 +391,5 @@ DEFINE_SIMPLE_DEV_PM_OPS(loongson_spi_dev_pm_ops, l=
oongson_spi_suspend, loongson
> >  EXPORT_SYMBOL_NS_GPL(loongson_spi_dev_pm_ops, "SPI_LOONGSON_CORE");
> >
> >  MODULE_DESCRIPTION("Loongson SPI core driver");
> > +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-=
pci.c
> > index ccc26efd88fe..ad90be956e1e 100644
> > --- a/drivers/spi/spi-loongson-pci.c
> > +++ b/drivers/spi/spi-loongson-pci.c
> > @@ -1,31 +1,31 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> > +//
> >  // PCI interface driver for Loongson SPI Support
> > -// Copyright (C) 2023 Loongson Technology Corporation Limited
> > +//
> > +// Copyright (C) 2023-2026 Loongson Technology Corporation Limited
> >
> >  #include <linux/pci.h>
> >
> >  #include "spi-loongson.h"
> >
> > -static int loongson_spi_pci_register(struct pci_dev *pdev,
> > -                       const struct pci_device_id *ent)
> > +static int loongson_spi_pci_register(struct pci_dev *pdev, const struc=
t pci_device_id *ent)
> >  {
> > -       int ret;
> > -       void __iomem *reg_base;
> >         struct device *dev =3D &pdev->dev;
> > -       int pci_bar =3D 0;
> > +       void __iomem *reg_base;
> > +       int pci_bar =3D 0, ret;
> >
> >         ret =3D pcim_enable_device(pdev);
> >         if (ret < 0)
> > -               return dev_err_probe(dev, ret, "cannot enable pci devic=
e\n");
> > +               return dev_err_probe(dev, ret, "cannot enable pci devic=
e");
> >
> >         reg_base =3D pcim_iomap_region(pdev, pci_bar, pci_name(pdev));
> >         ret =3D PTR_ERR_OR_ZERO(reg_base);
> >         if (ret)
> > -               return dev_err_probe(dev, ret, "failed to request and r=
emap memory\n");
> > +               return dev_err_probe(dev, ret, "failed to request and r=
emap memory");
> >
> >         ret =3D loongson_spi_init_controller(dev, reg_base);
> >         if (ret)
> > -               return dev_err_probe(dev, ret, "failed to initialize co=
ntroller\n");
> > +               return dev_err_probe(dev, ret, "failed to initialize co=
ntroller");
> >
> >         return 0;
> >  }
> > @@ -49,5 +49,6 @@ static struct pci_driver loongson_spi_pci_driver =3D =
{
> >  module_pci_driver(loongson_spi_pci_driver);
> >
> >  MODULE_DESCRIPTION("Loongson spi pci driver");
> > +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> >  MODULE_LICENSE("GPL");
> >  MODULE_IMPORT_NS("SPI_LOONGSON_CORE");
> > diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson=
-plat.c
> > index 6f8202264341..dcfbdd50e996 100644
> > --- a/drivers/spi/spi-loongson-plat.c
> > +++ b/drivers/spi/spi-loongson-plat.c
> > @@ -1,6 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> > +//
> >  // Platform driver for Loongson SPI Support
> > -// Copyright (C) 2023 Loongson Technology Corporation Limited
> > +//
> > +// Copyright (C) 2023-2026 Loongson Technology Corporation Limited
> >
> >  #include <linux/err.h>
> >  #include <linux/platform_device.h>
> > @@ -9,9 +11,9 @@
> >
> >  static int loongson_spi_platform_probe(struct platform_device *pdev)
> >  {
> > -       int ret;
> > -       void __iomem *reg_base;
> >         struct device *dev =3D &pdev->dev;
> > +       void __iomem *reg_base;
> > +       int ret;
> >
> >         reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> >         if (IS_ERR(reg_base))
> > @@ -19,7 +21,7 @@ static int loongson_spi_platform_probe(struct platfor=
m_device *pdev)
> >
> >         ret =3D loongson_spi_init_controller(dev, reg_base);
> >         if (ret)
> > -               return dev_err_probe(dev, ret, "failed to initialize co=
ntroller\n");
> > +               return dev_err_probe(dev, ret, "failed to initialize co=
ntroller");
> >
> >         return 0;
> >  }
> > @@ -42,5 +44,6 @@ static struct platform_driver loongson_spi_plat_drive=
r =3D {
> >  module_platform_driver(loongson_spi_plat_driver);
> >
> >  MODULE_DESCRIPTION("Loongson spi platform driver");
> > +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> >  MODULE_LICENSE("GPL");
> >  MODULE_IMPORT_NS("SPI_LOONGSON_CORE");
> > diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
> > index 89efd4ce69d8..c8b722bc5fb5 100644
> > --- a/drivers/spi/spi-loongson.h
> > +++ b/drivers/spi/spi-loongson.h
> > @@ -1,56 +1,13 @@
> >  /* SPDX-License-Identifier: GPL-2.0+ */
> > -/* Header File for Loongson SPI Driver. */
> > -/* Copyright (C) 2023 Loongson Technology Corporation Limited */
> > +//
> > +// Loongson SPI Support - common header
> > +//
> > +// Copyright (C) 2023-2026 Loongson Technology Corporation Limited
> >
> >  #ifndef __LINUX_SPI_LOONGSON_H
> >  #define __LINUX_SPI_LOONGSON_H
> >
> > -#include <linux/bits.h>
> > -#include <linux/pm.h>
> > -#include <linux/types.h>
> > -
> > -#define        LOONGSON_SPI_SPCR_REG   0x00
> > -#define        LOONGSON_SPI_SPSR_REG   0x01
> > -#define        LOONGSON_SPI_FIFO_REG   0x02
> > -#define        LOONGSON_SPI_SPER_REG   0x03
> > -#define        LOONGSON_SPI_PARA_REG   0x04
> > -#define        LOONGSON_SPI_SFCS_REG   0x05
> > -#define        LOONGSON_SPI_TIMI_REG   0x06
> > -
> > -/* Bits definition for Loongson SPI register */
> > -#define        LOONGSON_SPI_PARA_MEM_EN        BIT(0)
> > -#define        LOONGSON_SPI_SPCR_CPHA  BIT(2)
> > -#define        LOONGSON_SPI_SPCR_CPOL  BIT(3)
> > -#define        LOONGSON_SPI_SPCR_SPE   BIT(6)
> > -#define        LOONGSON_SPI_SPSR_RFEMPTY       BIT(0)
> > -#define        LOONGSON_SPI_SPSR_WCOL  BIT(6)
> > -#define        LOONGSON_SPI_SPSR_SPIF  BIT(7)
> > -
> > -#define LOONGSON_SPI_DIV_MIN           2
> > -#define LOONGSON_SPI_DIV_MAX           4096
> > -
> > -struct device;
> > -struct spi_controller;
> > -
> > -struct loongson_spi_suspend_store {
> > -       unsigned char           spcr;
> > -       unsigned char           sper;
> > -       unsigned char           spsr;
> > -       unsigned char           para;
> > -       unsigned char           sfcs;
> > -       unsigned char           timi;
> > -};
> > -
> > -struct loongson_spi {
> > -       struct  spi_controller  *controller;
> > -       void __iomem            *base;
> > -       int                     cs_active;
> > -       unsigned int            hz;
> > -       unsigned int            mode;
> > -       u64                     clk_rate;
> > -       struct loongson_spi_suspend_store lss;
> > -};
> > -
> >  int loongson_spi_init_controller(struct device *dev, void __iomem *reg=
);
> >  extern const struct dev_pm_ops loongson_spi_dev_pm_ops;
> > +
> >  #endif /* __LINUX_SPI_LOONGSON_H */
> > --
> > 2.52.0
> >
> >

--=20
Thanks.
Binbin
