From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] spi/spi_altera: fix build error
Date: Tue, 22 Feb 2011 13:37:39 -0800
Message-ID: <20110222133739.d3e8da25.randy.dunlap@oracle.com>
References: <20110222132303.6a78b8e0@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
To: Andres Salomon <dilinger@queued.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110222132303.6a78b8e0@queued.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 22 Feb 2011 13:23:03 -0800 Andres Salomon wrote:

> I ran into a build error while attempting to build the Feb 22nd
> linux-next tree.
>=20
>=20
>=20
> From: Andres Salomon <dilinger@queued.net>
>=20
> Fix the following build error due to a missing semicolon:
>=20
>  CC [M]  drivers/spi/spi_altera.o
> drivers/spi/spi_altera.c:308: error: expected =E2=80=98,=E2=80=99 or =
=E2=80=98;=E2=80=99 before =E2=80=98extern=E2=80=99
> make[2]: *** [drivers/spi/spi_altera.o] Error 1
>=20
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

so ignore my combined patch.  Thanks.


> ---
>  drivers/spi/spi_altera.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/spi/spi_altera.c b/drivers/spi/spi_altera.c
> index 5e001f3..4813a63 100644
> --- a/drivers/spi/spi_altera.c
> +++ b/drivers/spi/spi_altera.c
> @@ -304,7 +304,7 @@ static int __devexit altera_spi_remove(struct pla=
tform_device *dev)
>  static const struct of_device_id altera_spi_match[] =3D {
>  	{ .compatible =3D "ALTR,spi-1.0", },
>  	{},
> -}
> +};
>  MODULE_DEVICE_TABLE(of, altera_spi_match);
>  #else /* CONFIG_OF */
>  #define altera_spi_match NULL
> --=20

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your cod=
e ***
