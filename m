From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH V5 16/17] SPI: MIPS: lantiq: add FALCON spi driver
Date: Fri, 25 May 2012 17:38:45 -0600
Message-ID: <20120525233845.BD93C3E0BD2@localhost>
References: <1337521579-1597-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1337521579-1597-1-git-send-email-blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, 20 May 2012 15:46:19 +0200, John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:
> From: Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
> 
> The external bus unit (EBU) found on the FALCON SoC has spi emulation that is
> designed for serial flash access. This driver has only been tested with m25p80
> type chips. The hardware has no support for other types of spi peripherals.
> 
> Signed-off-by: Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> ---
> This patch is part of a series moving the mips/lantiq target to OF and clkdev
> support. The patch, once Acked, should go upstream via Ralf's MIPS tree.
> 
> Changes in V5
> * drop duplicate busnum assignment
> 
> Changes in V4
> * drop busnum property
> 
> Changes in V3
> * rephrase spi->SPI
> * fix rate detection
> * adds support for transfer_one & co
> * adds of support
> 
> Changes in V2
> * remove several superflous calls to dev_dbg
> * make use of module_platform_driver
> * remove falcon_spi_cleanup as it was an empty function
> * return real error codes instead of -1
> * fixes operator spacing errors
> * split arch and driver specific patches
> * squash some lines to make use of the full 80 available chars
> * Kconfig is now alphabetic again
> * replace BUG() with WARN_ON()
> ---
>  drivers/spi/Kconfig      |    9 +
>  drivers/spi/Makefile     |    1 +
>  drivers/spi/spi-falcon.c |  469 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 479 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/spi-falcon.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 00c0240..62b2b5e 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -144,6 +144,15 @@ config SPI_EP93XX
>  	  This enables using the Cirrus EP93xx SPI controller in master
>  	  mode.
>  
> +config SPI_FALCON
> +	tristate "Falcon SPI controller support"
> +	depends on SOC_FALCON
> +	help
> +	  The external bus unit (EBU) found on the FALC-ON SoC has SPI
> +	  emulation that is designed for serial flash access. This driver
> +	  has only been tested with m25p80 type chips. The hardware has no
> +	  support for other types of SPI peripherals.

What exactly does this mean?  How does it not support any other type
of SPI peripheral?  SPI is a really simple protocol, so what is it
about this hardware that prevents it being used with other SPI
hardware?

I see a big state machine that appears to interpret the messages and
pretend to be an SPI slave instead of telling linux about the real
device.  /me wonders if it should this instead be a block device
driver?

> +static int falcon_sflash_prepare_xfer(struct spi_master *master)
> +{
> +	return 0;
> +}
> +
> +static int falcon_sflash_unprepare_xfer(struct spi_master *master)
> +{
> +	return 0;
> +}

Don't use empty hooks.  Just leave them uninitialized.  The core will
do the right thing.


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
