From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH] added
 drivers/spi/spi_board_info_cmdline for setting up an spi_board_info
 structure on commandline
Date: Sun, 31 Jan 2010 01:06:30 +0200
Message-ID: <20100130230629.GA2634@tarshish>
References: <95F51F4B902CAC40AF459205F6322F0171E8D49880@BMK019S01.emtrion.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: "Pietrek, Markus" <Markus.Pietrek-BU0Y/NROKIiELgA04lAiVw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <95F51F4B902CAC40AF459205F6322F0171E8D49880-76KB/CMpcTeJqUQdFWzYuOuPKLVQfWtC@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Pietrek,

On Fri, Jan 29, 2010 at 02:48:29PM +0100, Pietrek, Markus wrote:

[snip]

> +                               else if (!strcmp(opt, "cs"))
> +                                       info->mode |= SPI_CS_HIGH;

The name of this option should be "cs_high" in my opinion.

> +                               else if (!strcmp(opt, "lsb"))
> +                                       info->mode |= SPI_LSB_FIRST;
> +                               else if (!strcmp(opt, "3wire"))
> +                                       info->mode |= SPI_3WIRE;
> +                               else if (!strcmp(opt, "loop"))
> +                                       info->mode |= SPI_LOOP;
> +                               else if (!strcmp(opt, "no_cs"))
> +                                       info->mode |= SPI_NO_CS;
> +                               else if (!strcmp(opt, "ready"))
> +                                       info->mode |= SPI_READY;
> +                               else {
> +                                       pr_err(DRIVER_NAME ": Don't know value %s\n", opt);
> +                                       kfree(info);
> +                                       return -1;
> +                               }

For the sake of future compatibility I think we should ignore unknown options, 
and print a message along the lines of "Unknown option %s, ignoring".

baruch


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
