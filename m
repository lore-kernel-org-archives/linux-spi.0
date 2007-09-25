From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 7/7] [POWERPC][SPI] spi_mpc83xx:
	allow use on MPC85xx
Date: Tue, 25 Sep 2007 10:04:41 -0500
Message-ID: <16E78F0E-B57B-4084-887E-5D2F9C1D0331@kernel.crashing.org>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143531.GG5323@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070925143531.GG5323-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On Sep 25, 2007, at 9:35 AM, Anton Vorontsov wrote:

> MPC85xx's QE SPI controller is almost the same comparing to MPC83xx.
> Thus lets use that driver. Tested to work in loopback mode.
>
> Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> ---
>  drivers/spi/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index b915711..14f0d0d 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -125,7 +125,7 @@ config SPI_MPC52xx_PSC
>
>  config SPI_MPC83xx
>  	tristate "Freescale MPC83xx SPI controller"
> -	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
> +	depends on SPI_MASTER && (PPC_83xx || PPC_85xx) && EXPERIMENTAL
>  	select SPI_BITBANG
>  	help
>  	  This enables using the Freescale MPC83xx SPI controller in master

Should that really be just PPC_83xx || QUICC_ENGINE?

- k

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
