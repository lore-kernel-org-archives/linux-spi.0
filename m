From: leroy christophe <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-spi: use of_iomap() to map parameter ram on
 CPM1
Date: Thu, 12 Mar 2015 07:52:53 +0100
Message-ID: <550137C5.1020109@c-s.fr>
References: <20150226161142.D08681A2360@localhost.localdomain> <20150303184403.GE21293@sirena.org.uk> <54F6BBA7.8040008@c-s.fr> <20150306114413.GM21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150306114413.GM21293-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Le 06/03/2015 12:44, Mark Brown a =E9crit :
> On Wed, Mar 04, 2015 at 09:00:39AM +0100, leroy christophe wrote:
>> Le 03/03/2015 19:44, Mark Brown a =E9crit :
>>> Why are we using of_iomap() rather than a generic I/O mapping funct=
ion
>>> here?
>> because all drivers for powerpc seems to be using of_iomap(), as on =
powerpc
>> the HW is described by the bootloader in a OF device tree.
>> Today, of_iomap() is at least used in FSL SPI, FSL UART, SPI mpc52xx=
, UART
>> mpc52xx, i2c-mpc, i2c-cpm, freescale ethernet drivers, etc ....
>> Is it not correct ?
> It's legacy, all that code is really old.  Modern code is written in =
as
> architecture and firmware neutral a fashion as possible to make thing=
s
> more consistent and maintainable.
This patch is only a small bug fix.
That driver already contains calls to of_iomap() and other related of_=20
functions.
Is it worth rewriting the driver for just a small bug fix ?

Christophe
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
