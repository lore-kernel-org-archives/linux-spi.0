From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v5 3/8] mtd: spi-nor: add the framework for SPI NOR
Date: Thu, 10 Apr 2014 15:27:12 +0800
Message-ID: <20140410072711.GB24100@localhost>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
 <1393238262-8622-4-git-send-email-b32955@freescale.com>
 <20140409174837.GE32070@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, <angus.clark-qxv4g6HH51o@public.gmane.org>,
	<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <pekon-l0cyMroinI0@public.gmane.org>, <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	<broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	<b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140409174837.GE32070@ld-irv-0074>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Apr 09, 2014 at 10:48:37AM -0700, Brian Norris wrote:
> On Mon, Feb 24, 2014 at 06:37:37PM +0800, Huang Shijie wrote:
> > This patch cloned most of the m25p80.c. In theory, it adds a new sp=
i-nor layer.
> ...
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/sp=
i-nor.c
> > new file mode 100644
> > index 0000000..a840e88
> > --- /dev/null
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -0,0 +1,1087 @@
> > +/*
> > + * Cloned most of the code from the m25p80.c
>=20
> Please include a copyright notice here. This should carry both the
> original m25p80.c copyright notice, as well as your own additional
> copyright if you choose. For instance:
>=20
>  * Based on m25p80.c, by Mike Lavender (mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org), with
>  * influence from lart.c (Abraham Van Der Merwe) and mtd_dataflash.c
>  *
>  * Copyright =A9 2005, Intec Automation Inc.
>  * Copyright =A9 2014, Freescale Semiconductor, Inc.
>=20
I will send a patch to add the copyright info which will based on your =
patch
set.

thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
