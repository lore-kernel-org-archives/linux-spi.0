From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] xilinx_spi: Add the platform driver to the Kconfig
Date: Wed, 11 Nov 2009 14:36:06 -0700
Message-ID: <fa686aa40911111336x28c90b3bv12de0186a6ed3087@mail.gmail.com>
References: <4AFAE870.7080308@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>, dbrownell@users.sourceforge.net,
	John Linn <John.Linn@xilinx.com>, linuxppc-dev@ozlabs.org
To: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <4AFAE870.7080308@mocean-labs.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 11, 2009 at 9:38 AM, Richard R=F6jfors
<richard.rojfors@mocean-labs.com> wrote:
> This patch adds the xilinx_spi_pltfm to the SPI Kconfig and Makefile.
>
> The xilinx_spi_pltfm was added in a previous patchset.

I assume this will just get rolled into your series when you respin
for the next version.

g.

>
> Signed-off-by: Richard R=F6jfors <richard.rojfors@mocean-labs.com>
> ---
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index b956284..d1f8ee3 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -252,6 +252,13 @@ config SPI_XILINX_OF
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This is the OF driver for the SPI controller IP from t=
he Xilinx EDK.
>
> +config SPI_XILINX_PLTFM
> + =A0 =A0 =A0 tristate "Xilinx SPI controller platform device"
> + =A0 =A0 =A0 depends on SPI_XILINX
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This is the platform driver for the SPI controller IP
> + =A0 =A0 =A0 =A0 from the Xilinx EDK.
> +
> =A0#
> =A0# Add new SPI master controllers in alphabetical order above this line
> =A0#
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 97dee8f..d8b0e4c 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_SPI_S3C24XX) =A0 =A0 =A0 =A0 =A0 =A0 +=3D =
spi_s3c24xx.o
> =A0obj-$(CONFIG_SPI_TXX9) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_txx9.o
> =A0obj-$(CONFIG_SPI_XILINX) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D xilinx_spi.o
> =A0obj-$(CONFIG_SPI_XILINX_OF) =A0 =A0 =A0 =A0 =A0 =A0+=3D xilinx_spi_of.o
> +obj-$(CONFIG_SPI_XILINX_PLTFM) =A0 =A0 =A0 =A0 +=3D xilinx_spi_pltfm.o
> =A0obj-$(CONFIG_SPI_SH_SCI) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_sh_sci.o
> =A0obj-$(CONFIG_SPI_STMP3XXX) =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_stmp.o
> =A0# =A0 =A0 =A0... add above this line ...
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
