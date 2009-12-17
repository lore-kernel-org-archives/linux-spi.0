From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 6/7] spi/mpc8xxx: don't check platform_get_irq's return
 value against zero
Date: Thu, 17 Dec 2009 19:39:44 +0300
Message-ID: <20091217163944.GA6453@oksana.dev.rtsoft.ru>
References: <1260979809-24811-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-5-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-6-git-send-email-u.kleine-koenig@pengutronix.de>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, David Vrabel <dvrabel@arcom.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	Kumar Gala <galak@kernel.crashing.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	spi-devel-general@lists.sourceforge.net
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764765AbZLQQjz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1260979809-24811-6-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 16, 2009 at 05:10:08PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> platform_get_irq returns -ENXIO on failure, so !irq was probably
> always true.  Better use (int)irq <=3D 0.  Note that a return value o=
f
> zero is still handled as error even though this could mean irq0.
>=20
> This is a followup to 305b3228f9ff4d59f49e6d34a7034d44ee8ce2f0 that
> changed the return value of platform_get_irq from 0 to -ENXIO on erro=
r.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: David Vrabel <dvrabel@arcom.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: spi-devel-general@lists.sourceforge.net
> ---
>  drivers/spi/spi_mpc8xxx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
> index e9390d7..b13501a 100644
> --- a/drivers/spi/spi_mpc8xxx.c
> +++ b/drivers/spi/spi_mpc8xxx.c
> @@ -1339,7 +1339,7 @@ static int __devinit plat_mpc8xxx_spi_probe(str=
uct platform_device *pdev)
>  		return -EINVAL;
> =20
>  	irq =3D platform_get_irq(pdev, 0);
> -	if (!irq)
> +	if ((int)irq <=3D 0)

I tend to think that it's really hopeless to fix the
platform_get_irq() in its current form, so can you get rid
of this ugly cast and just make the irq signed?

And I'll be fine with it. :-(

--=20
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
