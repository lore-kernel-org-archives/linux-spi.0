From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/1] SPI: dw_spi, fix PPC build
Date: Fri, 18 Mar 2011 09:51:02 -0600
Message-ID: <20110318155102.GA22790@angua.secretlab.ca>
References: <1300441277-23961-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	jirislaby@gmail.com,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
To: Jiri Slaby <jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1300441277-23961-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Mar 18, 2011 at 10:41:17AM +0100, Jiri Slaby wrote:
> Currently, build on PPC dies with:
> In file included from drivers/spi/dw_spi_mmio.c:16:
> include/linux/spi/dw_spi.h:147: error: field =E2=80=98tx_sgl=E2=80=99=
 has incomplete type
> include/linux/spi/dw_spi.h:149: error: field =E2=80=98rx_sgl=E2=80=99=
 has incomplete type
>=20
> Add linux/scatterlist.h include to dw_spi.h, because we need to know
> the contents of the structure.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>

Applied, thanks.

g.

> ---
>  include/linux/spi/dw_spi.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/include/linux/spi/dw_spi.h b/include/linux/spi/dw_spi.h
> index 6cd10f6..fb0bce5 100644
> --- a/include/linux/spi/dw_spi.h
> +++ b/include/linux/spi/dw_spi.h
> @@ -2,6 +2,7 @@
>  #define DW_SPI_HEADER_H
> =20
>  #include <linux/io.h>
> +#include <linux/scatterlist.h>
> =20
>  /* Bit fields in CTRLR0 */
>  #define SPI_DFS_OFFSET			0
> --=20
> 1.7.4.1
>=20
>=20
