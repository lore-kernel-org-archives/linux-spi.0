From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: Support of Micron SPI flash (size > 16MB)
Date: Fri, 16 May 2014 16:33:04 +0800
Message-ID: <5375CD40.6060903@freescale.com>
References: <92977332ffca4669b5c1987b42b0d0c5@BY2PR03MB508.namprd03.prod.outlook.com>
 <20140509104404.GK12304@sirena.org.uk>
 <20140516061856.GD2413@norris-Latitude-E6410>
 <86bc6bed6ec74c8c8fc3d0e929baee48@BY2PR03MB508.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org"
	<vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
To: "Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <86bc6bed6ec74c8c8fc3d0e929baee48-+7O3WWA3DPtW9KZzDT5qz+O6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=D3=DA 2014=C4=EA05=D4=C216=C8=D5 16:15, Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org =D0=B4=
=B5=C0:
> Another question is for erase and program command. From the datasheet=
, not only the WTITE
> ENABLE command need to be issued before the command can be executed, =
but also a special
> READ FLAG STATUS RESISTER command need to be issued after the erase/p=
rogram command which
> is not implemented in the upstream code. We implement the READ flag o=
peration and erase
> can work, but write still fail.
>
> I saw somebody has added the Micron larger SPI flash (>16Mb) support,=
 so I'd like to know
> if they run into such issue.
Yes, we have noticed this issue:

Please see this patch:
http://lists.infradead.org/pipermail/linux-mtd/2014-April/053571.html

thanks
Huang Shijie
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
