From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] SPI: fix build with CONFIG_SPI_FSL_ESPI=m
Date: Thu, 24 Nov 2011 01:22:57 -0600
Message-ID: <F8B0661A-E43E-48B9-A8BB-B3D87999FD66@kernel.crashing.org>
References: <1314086345-2818-1-git-send-email-jslaby@suse.cz>
	<4E5369A0.4080701@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>,
	linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4E5369A0.4080701-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On Aug 23, 2011, at 3:49 AM, Jiri Slaby wrote:

> On 08/23/2011 09:59 AM, Jiri Slaby wrote:
>> When spi_fsl_espi is chosen to be built as a module, there is a build
>> error because we test only CONFIG_SPI_FSL_ESPI in declaration of
>> struct mpc8xxx_spi in drivers/spi/spi_fsl_lib.h.
>> 
>> We need to add a test for CONFIG_SPI_FSL_ESPI_MODULE too.
>> 
>> The error looks like:
>> drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_bufs':
>> drivers/spi/spi_fsl_espi.c:232: error: 'struct mpc8xxx_spi' has no member named 'len'
>> ...
>> 
>> Signed-off-by: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
>> ---
>> drivers/spi/spi-fsl-lib.h |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
>> index cbe881b..97968de 100644
>> --- a/drivers/spi/spi-fsl-lib.h
>> +++ b/drivers/spi/spi-fsl-lib.h
>> @@ -28,7 +28,7 @@ struct mpc8xxx_spi {
>> 	/* rx & tx bufs from the spi_transfer */
>> 	const void *tx;
>> 	void *rx;
>> -#ifdef CONFIG_SPI_FSL_ESPI
>> +#if defined(CONFIG_SPI_FSL_ESPI) || defined(CONFIG_SPI_FSL_ESPI_MODULE)
>> 	int len;
>> #endif
> 
> Oh, and there are still link errors:
> ERROR: "mpc8xxx_spi_tx_buf_u32" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_rx_buf_u32" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_tx_buf_u16" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_rx_buf_u16" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_tx_buf_u8" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_rx_buf_u8" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "of_mpc8xxx_spi_probe" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_strmode" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_probe" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_remove" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "to_of_pinfo" [drivers/spi/spi_fsl_spi.ko] undefined!
> ERROR: "mpc8xxx_spi_tx_buf_u32" [drivers/spi/spi_fsl_espi.ko] undefined!
> ERROR: "mpc8xxx_spi_rx_buf_u32" [drivers/spi/spi_fsl_espi.ko] undefined!
> ERROR: "of_mpc8xxx_spi_probe" [drivers/spi/spi_fsl_espi.ko] undefined!
> ERROR: "mpc8xxx_spi_probe" [drivers/spi/spi_fsl_espi.ko] undefined!
> ERROR: "mpc8xxx_spi_remove" [drivers/spi/spi_fsl_espi.ko] undefined!
> 
> The functions are not exported...
> 
> Should I export all those or deny CONFIG_SPI_FSL_ESPI=m?

I'd just deny CONFIG_SPI_FSL_ESPI=m, unless you have some need for it to be a module.

- k
------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
