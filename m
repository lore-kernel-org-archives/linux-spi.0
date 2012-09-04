From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Revert "spi/doc: spi_master_put must be followed up by
 kfree"
Date: Tue, 4 Sep 2012 09:25:23 +0200
Message-ID: <20120904072523.GB28643@pengutronix.de>
References: <1346703986-7849-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	kernel@pengutronix.de
To: Guenter Roeck <linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1346703986-7849-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 03, 2012 at 01:26:26PM -0700, Guenter Roeck wrote:
> Actually, spi_master_put() after spi_alloc_master() must _not_ be fol=
lowed
> by kfree(). The memory is already freed with the call to spi_master_p=
ut()
> through spi_master_class, which registers a release function. Calling=
 both
> spi_master_put() and kfree() results in often nasty (and delayed) cra=
shes
> elsewhere in the kernel, often in the networking stack.
>=20
> This reverts commit eb4af0f5349235df2e4a5057a72fc8962d00308a.
>=20
> Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
I didn't check the callback, but I introduced
eb4af0f5349235df2e4a5057a72fc8962d00308a because I saw the kfree in
drivers/spi/spi-imx.c. So I guess this needs fixing, too?!

Best regards
Uwe

> ---
>  drivers/spi/spi.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 2d9b5bb..6470750 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1082,8 +1082,7 @@ static struct class spi_master_class =3D {
>   *
>   * The caller is responsible for assigning the bus number and initia=
lizing
>   * the master's methods before calling spi_register_master(); and (a=
fter errors
> - * adding the device) calling spi_master_put() and kfree() to preven=
t a memory
> - * leak.
> + * adding the device) calling spi_master_put() to prevent a memory l=
eak.
>   */
>  struct spi_master *spi_alloc_master(struct device *dev, unsigned siz=
e)
>  {

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
