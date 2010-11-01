From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Access the linux_2.6.36 SPI Drivers from Userspace?
Date: Mon, 1 Nov 2010 10:26:58 -0400
Message-ID: <AANLkTimhBrDjQeT6=PnKg_q0d-WSO_UX3dhxe4Fkbr46@mail.gmail.com>
References: <20101101133814.141660@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Charles Martel <SingerIsland-KK0ffGbhmjU@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101101133814.141660-KK0ffGbhmjU@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Nov 1, 2010 at 9:38 AM, Charles Martel <SingerIsland-KK0ffGbhmjU@public.gmane.org> wrote:
> Does anyone know how to access the linux_2.6.36 SPI Drivers from Userspac=
e? If so, could you explain?
>
> Also, it appears that SPI-DEV (not SPIDEV) has been removed. =A0Is there =
a replacement in the works?
> I could sure use one that lets me change the SPI Speed after I bring up t=
he SPI Device.

I'm don't know what the difference is between spi-dev and spidev, but
spidev allows the spi speed to be changed with an ioctl.
Documentation/spi/ contains information about how to use it from
userspace, and you can also look at drivers/spi/spidev.c

g.

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
