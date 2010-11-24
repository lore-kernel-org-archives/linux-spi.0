From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 1/9] spi/pxa2xx: don't use subys initcall for driver init
Date: Wed, 24 Nov 2010 14:18:57 +0100
Message-ID: <20101124141857.694e52ef.ospite@studenti.unina.it>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1228182812=="
Cc: David Brownell <dbrownell@users.sourceforge.net>, eric.y.miao@gmail.com,
	linux@arm.linux.org.uk, sodaville@linutronix.de,
	Daniel Ribeiro <drwyrm@gmail.com>,
	Dirk Brandewie <dirk.brandewie@gmail.com>,
	spi-devel-general@lists.sourceforge.net, tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

--===============1228182812==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__24_Nov_2010_14_18_57_+0100_7+RuibhNIAU=w0U2"

--Signature=_Wed__24_Nov_2010_14_18_57_+0100_7+RuibhNIAU=w0U2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Nov 2010 12:13:19 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> It is a simple driver and there is no need to call its init function
> at the level of a subsystem.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---

Please take a look at commit 5b61a749e8fd0a45a5e37c267d20a43ef0590d68
there are some situations where the spi driver needs to be loaded before
the others, IIRC the change in the commit above was needed for the EZX
phones, where the PMIC is on the spi bus and cpufreq operates on some
regulator controlled by the PMIC; added Daniel Ribeiro on CC who maybe
can give more details.

Regards,
   Antonio

>  drivers/spi/pxa2xx_spi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index e76b1af..6f2f061 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -1731,7 +1731,7 @@ static int __init pxa2xx_spi_init(void)
>  {
>  	return platform_driver_probe(&driver, pxa2xx_spi_probe);
>  }
> -subsys_initcall(pxa2xx_spi_init);
> +module_init(pxa2xx_spi_init);
> =20
>  static void __exit pxa2xx_spi_exit(void)
>  {
> --=20
> 1.7.3.2
>=20
>=20

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__24_Nov_2010_14_18_57_+0100_7+RuibhNIAU=w0U2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkztEMEACgkQ5xr2akVTsAHXaACdG68JZ2nJYHGHvnTSH+C/NtIJ
I+cAnAsyLx30LB7BJup2G04rme/loDzl
=SsuL
-----END PGP SIGNATURE-----

--Signature=_Wed__24_Nov_2010_14_18_57_+0100_7+RuibhNIAU=w0U2--


--===============1228182812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1228182812==--
