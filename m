From: Wayne Tams <wayne.tams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i.MX: GPIO based SPI chip selects question
Date: Mon, 31 Oct 2011 09:26:25 +0000
Message-ID: <CAN=k24nenVPG=V6mvhaRajTL2BORdN7KYmP2R16P72rkkLx6Eg@mail.gmail.com>
References: <CAN=k24kKWd9TPDbkWTCOSn48FNOi9DUALGd9XmeQ_xOJ=Kxd9g@mail.gmail.com>
	<20111029204450.GA31910@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20111029204450.GA31910@tarshish>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Oct 29, 2011 at 9:44 PM, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:
> Hi Wayne,
>
> On Fri, Oct 28, 2011 at 02:06:16PM +0100, Wayne Tams wrote:
>> Can I use GPIO pins on my i.mx53 for SPI chip select, I have found little
>> on the web that can help me, I am hoping that it is straight-forward eno=
ugh
>> for me to implement it? Perhaps there is a macro that I can use in the
>> spi_board_info structure that will let me declare the GPIO?
>
> If you are using the mainline kernel then the SPI driver
> (drivers/spi/spi-imx.c) supports the use of GPIO lines for chip-select
> exclusively. You can find an i.MX53 specific example in
> arch/arm/mach-mx5/board-mx53_evk.c (look for the mx53_evk_spi_data struct=
).
> This example demonstrate the use of two GPIOs for chip-select, but the li=
st of
> chip-selects can be longer.

That looks promising, I assume you mean that your quoted example makes
use of the driver spi-imx?
>
> Since you appear to be using the Freescale supplied kernel (as I infer fr=
om
> your previous question on this list), you are probably using different dr=
iver.
> This driver (likely
> http://opensource.freescale.com/git?p=3Dimx/linux-2.6-imx.git;a=3Dblob;f=
=3Ddrivers/spi/mxc_spi.c;h=3D8c722686a0e1a419b417c0e2f98a4d6f028cf02e;hb=3D=
a1cd8a787a18da69ac4e48cfc876623bd7323799)
> does not support GPIOs for chip-select.

I should of added that I am using a kernel from a BSP supplied by
Emtrion, as you guessed correctly, it based on the Freescale kernel
which uses the mxc_spi driver.
>
> Freescale seem to have abandoned their in-house non mainlined SPI driver =
in a
> later version of their kernel (rel_imx_2.6.38_11.09.01 tag in
> http://opensource.freescale.com/git) so you may want to update your kerne=
l.

I will have a look at how much of an impact using the mainlined kernel
will have on the operation of my SoM. A little off topic, bearing in
mind my inexperience with Linux, can I upgrade the kernel using git
and will the differences between the mainlined and Emtrion kernel be
highlighted? It is just that there could be some Emtrion kernel adds
that I could miss which may impact my board operation, memory mapping
etc.

Just to summarise, are these the options available to me? If so I will
figure out which method will be best for me to do:

1) Hack the existing mxc_spi driver and add support for GPIO chip-select
2) Upgrade the kernel to the latest mainlined version and use the
spi-imx driver included in that
3) Hack the kernel to use the spi_imx driver already included in the
BSP which has GPIO chip-select support
4) Update my BSP SPI driver to the mainlined version

Thank you for your help Baruch (and Grant) much appreciated,
>
> baruch
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~. .~ =A0 Tk Open Systems
> =3D}------------------------------------------------ooO--U--Ooo----------=
--{=3D
> =A0 - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
>

---------------------------------------------------------------------------=
---
Get your Android app more play: Bring it to the BlackBerry PlayBook =

in minutes. BlackBerry App World&#153; now supports Android&#153; Apps =

for the BlackBerry&reg; PlayBook&#153;. Discover just how easy and simple =

it is! http://p.sf.net/sfu/android-dev2dev
