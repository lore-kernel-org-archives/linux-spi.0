From: =?iso-8859-15?Q?Lothar_Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH 2/6] i.MX5/clock: add eCSPI and CSPI clock definitions
Date: Fri, 10 Sep 2010 12:04:33 +0200
Message-ID: <19594.689.326396.859751@ipc1.ka-ro>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-3-git-send-email-jason77.wang@gmail.com>
	<20100902150112.GM14214@pengutronix.de>
	<4C809410.9090602@gmail.com>
	<20100910094714.GF30558@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Jason Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	amit.kucheria-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100910094714.GF30558-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

Uwe Kleine-K=F6nig writes:
> >>> +static struct clk ecspi2_ipg_clk =3D {
> >>> +	.parent =3D &ipg_clk,
> >>> +	.secondary =3D &aips_tz2_clk,
> >>> +	.enable_reg =3D MXC_CCM_CCGR4,
> >>> +	.enable_shift =3D MXC_CCM_CCGRx_CG11_OFFSET,
> >>> +	.enable =3D _clk_ccgr_enable_inrun,
> >>> +	.disable =3D _clk_ccgr_disable,
> >>> +};
> aips_tz2_clk is wrong here, no?  Sascha used spba_clk here, too.  I
> didn't found out yet how to read that out of the reference manual.
> =

The Freescale BSP used aips_tz2_clk (and spba for cspi1). They should
know what's right. Maybe a copy/paste error from Sascha?


Lothar Wa=DFmann
-- =

___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=E4ftsf=FChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________

---------------------------------------------------------------------------=
---
Automate Storage Tiering Simply
Optimize IT performance and efficiency through flexible, powerful, =

automated storage tiering capabilities. View this brief to learn how
you can reduce costs and improve performance. =

http://p.sf.net/sfu/dell-sfdev2dev
