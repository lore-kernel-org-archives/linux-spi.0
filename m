From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v5 1/8] mtd: spi-nor: copy the SPI NOR commands to a new header file
Date: Wed, 5 Mar 2014 04:43:19 +0100
Message-ID: <201403050443.19529.marex@denx.de>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com> <201403042313.14353.marex@denx.de> <5316932C.5040405@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	angus.clark-qxv4g6HH51o@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pekon-l0cyMroinI0@public.gmane.org, sourav.poddar-l0cyMroinI0@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5316932C.5040405-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, March 05, 2014 at 03:59:56 AM, Huang Shijie wrote:
> =E4=BA=8E 2014=E5=B9=B403=E6=9C=8805=E6=97=A5 06:13, Marek Vasut =E5=86=
=99=E9=81=93:
> > Please keep me on CC;-)
>=20
> sorry, My fault :(
>=20
> > I honestly have to wonder ... why do you not 'move' these definitio=
ns
> > instead of copying them ?
>=20
> In the first version , i did so:
> http://marc.info/?l=3Dlinux-arm-kernel&m=3D138544933522564&w=3D2
>=20
> if I need to resend the patch set again, i can change to move the
> commands to the new header.

Why didn't you keep it like that? Was there some reason for that ?

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
