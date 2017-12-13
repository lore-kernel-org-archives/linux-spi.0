From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v2] spi: s3c64xx: add SPDX identifier
Date: Wed, 13 Dec 2017 10:20:20 +0100
Message-ID: <CAOFm3uHP-4UN+gzXzZc1ptptFm5f9uhafKyE963+DiamzdRTdw@mail.gmail.com>
References: <CGME20171213080544epcas2p29731b6c65f760ab1b9ac71d530fcaf77@epcas2p2.samsung.com>
 <20171213080530.12724-1-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi@etezian.org>
To: Andi Shyti <andi.shyti@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171213080530.12724-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Andi,

On Wed, Dec 13, 2017 at 9:05 AM, Andi Shyti <andi.shyti@samsung.com> wrote:
> Replace the original license statement with the SPDX identifier.
>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
> Hi,
>
> this second version unlike v1, where I tried to move the license
> from GPLv2+ to GPLv2, preserves the original licese while adding
> the SPDX identifier.
>
> Andi
>
>  drivers/spi/spi-s3c64xx.c                 | 18 ++++--------------
>  include/linux/platform_data/spi-s3c64xx.h |  4 +---
>  2 files changed, 5 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index de7df20f8712..baa3a9fa2638 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1,17 +1,7 @@
> -/*
> - * Copyright (C) 2009 Samsung Electronics Ltd.
> - *     Jaswinder Singh <jassi.brar@samsung.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright (c) 2009 Samsung Electronics Co., Ltd.
> +//      Jaswinder Singh <jassi.brar@samsung.com>
>
>  #include <linux/init.h>
>  #include <linux/module.h>
> diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
> index da79774078a7..8917f38c97c5 100644
> --- a/include/linux/platform_data/spi-s3c64xx.h
> +++ b/include/linux/platform_data/spi-s3c64xx.h
> @@ -2,9 +2,7 @@
>   * Copyright (C) 2009 Samsung Electronics Ltd.
>   *     Jaswinder Singh <jassi.brar@samsung.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> + * SPDX-License-Identifier: GPL-2.0
>   */
>
>  #ifndef __SPI_S3C64XX_H
> --
> 2.15.1
>


You still need to put this line at the very top of the file, first
line. That's the convention for the SPDX tags as documented by Thomas
Gleixner.

> + * SPDX-License-Identifier: GPL-2.0


-- 
Cordially
Philippe Ombredanne
