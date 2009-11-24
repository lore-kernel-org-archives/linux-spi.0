From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 32/38] don't use __exit_p to wrap plat_mpc8xxx_spi_remove
Date: Tue, 24 Nov 2009 14:42:22 -0700
Message-ID: <fa686aa40911241342we68d831n4bd6e637ff21f939@mail.gmail.com>
References: <1259096853-18909-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-24-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-25-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-26-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-27-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-28-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-29-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-30-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-31-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-32-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org,
	Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1259096853-18909-32-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2009/11/24 Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> The function plat_mpc8xxx_spi_remove is defined using __devexit, so don't
> use __exit_p but __devexit_p to wrap it.
>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Obviously correct.

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

g.

> Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> Cc: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> Cc: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> ---
> =A0drivers/spi/spi_mpc8xxx.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
> index 0fd0ec4..1d98be9 100644
> --- a/drivers/spi/spi_mpc8xxx.c
> +++ b/drivers/spi/spi_mpc8xxx.c
> @@ -900,7 +900,7 @@ static int __devexit plat_mpc8xxx_spi_remove(struct p=
latform_device *pdev)
> =A0MODULE_ALIAS("platform:mpc8xxx_spi");
> =A0static struct platform_driver mpc8xxx_spi_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D plat_mpc8xxx_spi_probe,
> - =A0 =A0 =A0 .remove =3D __exit_p(plat_mpc8xxx_spi_remove),
> + =A0 =A0 =A0 .remove =3D __devexit_p(plat_mpc8xxx_spi_remove),
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "mpc8xxx_spi",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> --
> 1.6.5.2
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
