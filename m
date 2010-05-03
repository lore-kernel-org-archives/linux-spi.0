From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
Date: Mon, 3 May 2010 15:18:09 +0200
Message-ID: <o2l63386a3d1005030618q1914e04x471ce544c6be82dc@mail.gmail.com>
References: <cover.1272805161.git.mika.westerberg@iki.fi>
	<0dce0e9fdb6af35854d26d7bd0d8af5a5ea8f76a.1272805161.git.mika.westerberg@iki.fi>
	<h2r63386a3d1005021718k31125e4fz43a08025997b5c5c@mail.gmail.com>
	<20100503042123.GM26418@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org,
	martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100503042123.GM26418-WfG2TfFPcQ9S6P4I59wummXnswh1EIUO@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/5/3 Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>:

> Yeah. It looks pretty similar. Although there seems to be differences. Do=
cumentation
> of the controller can be found in:
>
> =A0 =A0 =A0 =A0http://www.cirrus.com/en/pubs/manual/EP93xx_Users_Guide_UM=
1.pdf
>
> It does not mention anything about AMBA PL022.

They have surely based the hardware on the PL022. A diff document would
surely be useful, can Cirrus answer that kind of questions for you?

Hm, it has to be *really* different to warrant a totally new driver
duplicate code is never fun...

>> Can you make a hexdump of the PrimeCell ID registers at offset
>> base+0xffe0..0xffff and post the contents?
>
> Here it is, you probably meant base + 0xfe0 .. 0xfff, right?
>
> [ =A0 =A02.410000] 0xc6070fe0: 0x0
> [ =A0 =A02.410000] 0xc6070fe4: 0x0
> [ =A0 =A02.410000] 0xc6070fe8: 0x0
> [ =A0 =A02.420000] 0xc6070fec: 0x0
> [ =A0 =A02.420000] 0xc6070ff0: 0x0
> [ =A0 =A02.420000] 0xc6070ff4: 0x0
> [ =A0 =A02.430000] 0xc6070ff8: 0x0
> [ =A0 =A02.430000] 0xc6070ffc: 0x0

Looks like it's been blanked out so atleast it is not identifying itself as
a PL022 anymore.

It could also be that PL022 and the Cirrus controller has some common
ancestor...

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
