From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH] coldfire-qspi: Add support for the
	Coldfire 5251/5253.
Date: Thu, 7 Jun 2012 13:26:56 +1000
Message-ID: <4FD01F80.1050600@snapgear.com>
References: <201206050924.59579.sfking@fdwdc.com>
Reply-To: uClinux development list <uclinux-dev@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net,
 uClinux development list <uclinux-dev@uclinux.org>
To: Steven King <sfking@fdwdc.com>
Return-path: <uclinux-dev-bounces@uclinux.org>
In-Reply-To: <201206050924.59579.sfking@fdwdc.com>
List-Unsubscribe: <http://mailman.uclinux.org/mailman/options/uclinux-dev>,
 <mailto:uclinux-dev-request@uclinux.org?subject=unsubscribe>
List-Archive: <http://mailman.uclinux.org/pipermail/uclinux-dev>
List-Post: <mailto:uclinux-dev@uclinux.org>
List-Help: <mailto:uclinux-dev-request@uclinux.org?subject=help>
List-Subscribe: <http://mailman.uclinux.org/mailman/listinfo/uclinux-dev>,
 <mailto:uclinux-dev-request@uclinux.org?subject=subscribe>
Errors-To: uclinux-dev-bounces@uclinux.org
Sender: uclinux-dev-bounces@uclinux.org
List-Id: linux-spi.vger.kernel.org

On 06/06/12 02:24, Steven King wrote:
> The Coldfire 5251/5253 have a QSPI controller.  Enable selection of the
> coldfire-qspi driver if the M525x is selected.
>
> Signed-off-by: Steven King<sfking@fdwdc.com>
> ---
>   drivers/spi/Kconfig |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next branch of m68knommu git tree.

Regards
Greg



> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index cd2fe35..cb90bc6 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -125,7 +125,7 @@ config SPI_BUTTERFLY
>
>   config SPI_COLDFIRE_QSPI
>   	tristate "Freescale Coldfire QSPI controller"
> -	depends on (M520x || M523x || M5249 || M527x || M528x || M532x)
> +	depends on (M520x || M523x || M5249 || M525x || M527x || M528x || M532x)
>   	help
>   	  This enables support for the Coldfire QSPI controller in master
>   	  mode.
>
>
>


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
_______________________________________________
uClinux-dev mailing list
uClinux-dev@uclinux.org
http://mailman.uclinux.org/mailman/listinfo/uclinux-dev
This message was resent by uclinux-dev@uclinux.org
To unsubscribe see:
http://mailman.uclinux.org/mailman/options/uclinux-dev
