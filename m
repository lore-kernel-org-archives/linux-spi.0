From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi/spi_oc_tiny and spi_altera.c: fix build errors
Date: Tue, 22 Feb 2011 15:02:11 -0700
Message-ID: <AANLkTikBhnQkjd1-5XX=fnFDGcJ+eQT4SUZkV6Rp2rJN@mail.gmail.com>
References: <20110222132438.02d310e0@queued.net> <20110222133529.56b02ebb.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andres Salomon <dilinger@queued.net>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
To: Randy Dunlap <randy.dunlap@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110222133529.56b02ebb.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 22, 2011 at 2:35 PM, Randy Dunlap <randy.dunlap@oracle.com>=
 wrote:
> On Tue, 22 Feb 2011 13:24:38 -0800 Andres Salomon wrote:
>
>> Fix the following build error due to a missing semicolon:
>>
>> =A0CC [M] =A0drivers/spi/spi_oc_tiny.o
>> drivers/spi/spi_oc_tiny.c:394: error: expected =91,=92 or =91;=92 be=
fore =91extern=92
>> make[2]: *** [drivers/spi/spi_oc_tiny.o] Error 1
>>
>> Signed-off-by: Andres Salomon <dilinger@queued.net>
>
> Acked-by: Randy Dunlap <randy.dunlap@oracle.com>
>
> Same fix is needed for drivers/spi/spi_altera.c.
> I already had this patch ready to send. =A0Grant, can you extract
> the spi_altera.c patch...?

done.  Will be pushed out when I finish testing.

g.


>
>
> ---
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> Fix build error due to missing semi-colon:
>
> drivers/spi/spi_altera.c:308: error: expected ',' or ';' before 'exte=
rn'
> drivers/spi/spi_oc_tiny.c:394: error: expected ',' or ';' before 'ext=
ern'
>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
> =A0drivers/spi/spi_altera.c =A0| =A0 =A02 +-
> =A0drivers/spi/spi_oc_tiny.c | =A0 =A02 +-
> =A02 files changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20110222.orig/drivers/spi/spi_oc_tiny.c
> +++ linux-next-20110222/drivers/spi/spi_oc_tiny.c
> @@ -390,7 +390,7 @@ static int __devexit tiny_spi_remove(str
> =A0static const struct of_device_id tiny_spi_match[] =3D {
> =A0 =A0 =A0 =A0{ .compatible =3D "opencores,tiny-spi-rtlsvn2", },
> =A0 =A0 =A0 =A0{},
> -}
> +};
> =A0MODULE_DEVICE_TABLE(of, tiny_spi_match);
> =A0#else /* CONFIG_OF */
> =A0#define tiny_spi_match NULL
> --- linux-next-20110222.orig/drivers/spi/spi_altera.c
> +++ linux-next-20110222/drivers/spi/spi_altera.c
> @@ -304,7 +304,7 @@ static int __devexit altera_spi_remove(s
> =A0static const struct of_device_id altera_spi_match[] =3D {
> =A0 =A0 =A0 =A0{ .compatible =3D "ALTR,spi-1.0", },
> =A0 =A0 =A0 =A0{},
> -}
> +};
> =A0MODULE_DEVICE_TABLE(of, altera_spi_match);
> =A0#else /* CONFIG_OF */
> =A0#define altera_spi_match NULL
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
