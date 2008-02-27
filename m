From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] spi_mmc bus
	concurrency fix
Date: Wed, 27 Feb 2008 12:23:40 +0800
Message-ID: <386072610802262023t6bd22875kfeb58c797be66024@mail.gmail.com>
References: <47C42D50.7020204@rubico.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: hp-VrBV9hrLPhE@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: "Hans Eklund" <hans-9ai+6vhHfRGzQB+pC5nmwQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47C42D50.7020204-9ai+6vhHfRGzQB+pC5nmwQ@public.gmane.org>
Content-Disposition: inline
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

On Tue, Feb 26, 2008 at 11:16 PM, Hans Eklund <hans-9ai+6vhHfRGzQB+pC5nmwQ@public.gmane.org> wrote:
> Hi Bryan, i need some guidance regarding the SPI framwork here.
>
>  The spi_mmc driver i originally wrote was never tested with concurrent
>  access on the SPI bus vs. spi flash chip for example. It is not working
>  well in that case. I have a few days to fix it and im half way there i
>  believe. Core problem is that during a single sequence of commands i
>  need "atomicity" on the bus, ie. i need to hold chip select until im
>  done. And specifically, no other traffic can be allowed while a command
>  sequence is in action vs. the MMC/SD card. But as i see it, SPI messages
>  are of predetermined length? is it not? And after a message is done,
>  there is no guarantee i can use it again without interuption from other
>  protocol drivers, even if chip select is left asserted. True?
>

>From the kernel mainline mmc_spi driver, it mentioned that that
current SPI framework does not allow the MMC operation share the SPI
bus with other SPI devices.

--
/* NOTES:
 *
 * - For now, we won't try to interoperate with a real mmc/sd/sdio
 *   controller, although some of them do have hardware support for
 *   SPI protocol.  The main reason for such configs would be mmc-ish
 *   cards like DataFlash, which don't support that "native" protocol.
 *
 *   We don't have a "DataFlash/MMC/SD/SDIO card slot" abstraction to
 *   switch between driver stacks, and in any case if "native" mode
 *   is available, it will be faster and hence preferable.
 *
 * - MMC depends on a different chipselect management policy than the
 *   SPI interface currently supports for shared bus segments:  it needs
 *   to issue multiple spi_message requests with the chipselect active,
 *   using the results of one message to decide the next one to issue.
 *
 *   Pending updates to the programming interface, this driver expects
 *   that it not share the bus with other drivers (precluding conflicts).
 *
 * - We tell the controller to keep the chipselect active from the
 *   beginning of an mmc_host_ops.request until the end.  So beware
 *   of SPI controller drivers that mis-handle the cs_change flag!
 *
 *   However, many cards seem OK with chipselect flapping up/down
 *   during that time ... at least on unshared bus segments.
 */
---

So we can investigate with the SPI framework update.

>  There is one messaging scheme that i cant figure out how to create
>  correctly using spi messages and transfers that is important for the
>  MMC/SD SPI protocol.
>
>  Example of writing a single 512 byte block to SD/MMC, CS need to be
>  asserted during whole sequence, no other traffic can be allowed.
>
>  Send command:           6 Bytes
>  Poll for cmd response:  1 Byte( appears after 1-3 bytes read)
>  Send data+token:        512+1 Bytes
>  Poll for data response: 1 Byte (within a few bytes)
>     --- card is now busy for a while and it is ok to deselct chip ---
>  Poll for not busy:      coult take 30-10000 bytes at 20 Mhz to finnish
>
>  Last step can be done blockwise, 64 bytes a time by DMA for example..
>  'not busy' is just a matter of transison from busy tokens to idle tokens.
>
>  Note that 'send data+token' can only be done if a specific cmd response
>  was found. Same for data response, if not correct response another path
>  in code will be taken(ask for card status). All this needs to be done
>  "atomically" on the bus. Can this be achieved with the current state of
>  the spi driver?
>

I will copy this email to SPI mail list and mmc_spi maintainers for help.
Thanks Hans,
-Bryan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
