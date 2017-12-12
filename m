From: Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: add SPDX identifier
Date: Tue, 12 Dec 2017 22:03:13 +0900
Message-ID: <20171212130313.GC1072@brancaleone.zhora.eu>
References: <CGME20171212075830epcas2p31afc4a2e715e857694082748fd2bbe49@epcas2p3.samsung.com>
 <20171212075815.8683-1-andi.shyti@samsung.com>
 <CAJKOXPfdKyT8-bpM7tmveb3jWCRSSXwnkifhsRw_ag8X9z0W8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPfdKyT8-bpM7tmveb3jWCRSSXwnkifhsRw_ag8X9z0W8A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Krzysztof,

> > - * Copyright (C) 2009 Samsung Electronics Ltd.
> > - *     Jaswinder Singh <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - *
> > - * This program is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - * GNU General Public License for more details.
> > - */
> > +// SPDX-License-Identifier: GPL-2.0
> 

> Existing license corresponds to GPL-2.0+, not GPL-2.0.

mmmhhh... isn't it deprecated from 2.0rc2? Current SPDX version
2.6 doesn't have GPL-2.0+ in the list of licenses.

https://spdx.org/licenses/

I can improve the commit log to state it more clearly. Would that
work?

BTW, is it really a change of license?

> Why changing the comment style?

That's SPDX, right? by adding the SPDX-License-Identifier the
GPLv2 statement becomes redundant and we can remove some lines.

Andi
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
