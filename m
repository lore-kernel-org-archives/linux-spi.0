From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: RE: resend: [PATCH] amba_pl022: Setup SPI configuration based on
	spi->mode
Date: Mon, 13 Sep 2010 18:51:57 +0200
Message-ID: <083DF309106F364B939360100EC290F80AD49D5230@eu1rdcrdc1wx030.exi.nxp.com>
References: <AANLkTikbKwo9=xLWo1qEcc2E5aa2iN2F_KCokJPpnWOk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "Lukasz.Baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org" <Lukasz.Baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
To: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org"
	<sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org"
	<rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org"
	<linus
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTikbKwo9=xLWo1qEcc2E5aa2iN2F_KCokJPpnWOk-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> + =A0 =A0 =A0 if (spi->mode & SPI_CPOL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D SSP_CLK_POL_IDLE_HIGH;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D SSP_CLK_POL_IDLE_LOW;
> + =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr0, tmp, SSP_CR0_MASK_SPO, 6);
> +
> + =A0 =A0 =A0 if (spi->mode & SPI_CPHA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D SSP_CLK_SECOND_EDGE;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D SSP_CLK_FIRST_EDGE;
> + =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr0, tmp, SSP_CR0_MASK_SPH, 6);

SSP_CR0_MASK_SPH (SPHA) should use bit 7, not bit 6.
Should be:
       SSP_WRITE_BITS(chip->cr0, tmp, SSP_CR0_MASK_SPH, 7);

> +
> =A0 =A0 =A0 =A0SSP_WRITE_BITS(chip->cr0, chip_info->clk_freq.scr, SSP_CR0=
_MASK_SCR,
> 8);
> =A0 =A0 =A0 =A0/* Loopback is available on all versions except PL023 */


---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev
