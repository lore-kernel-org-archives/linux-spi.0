From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: i.MX: GPIO based SPI chip selects question
Date: Sat, 29 Oct 2011 22:44:51 +0200
Message-ID: <20111029204450.GA31910@tarshish>
References: <CAN=k24kKWd9TPDbkWTCOSn48FNOi9DUALGd9XmeQ_xOJ=Kxd9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wayne Tams <wayne.tams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAN=k24kKWd9TPDbkWTCOSn48FNOi9DUALGd9XmeQ_xOJ=Kxd9g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Wayne,

On Fri, Oct 28, 2011 at 02:06:16PM +0100, Wayne Tams wrote:
> Can I use GPIO pins on my i.mx53 for SPI chip select, I have found little
> on the web that can help me, I am hoping that it is straight-forward enough
> for me to implement it? Perhaps there is a macro that I can use in the
> spi_board_info structure that will let me declare the GPIO?

If you are using the mainline kernel then the SPI driver 
(drivers/spi/spi-imx.c) supports the use of GPIO lines for chip-select 
exclusively. You can find an i.MX53 specific example in 
arch/arm/mach-mx5/board-mx53_evk.c (look for the mx53_evk_spi_data struct).  
This example demonstrate the use of two GPIOs for chip-select, but the list of 
chip-selects can be longer.

Since you appear to be using the Freescale supplied kernel (as I infer from 
your previous question on this list), you are probably using different driver.  
This driver (likely 
http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=blob;f=drivers/spi/mxc_spi.c;h=8c722686a0e1a419b417c0e2f98a4d6f028cf02e;hb=a1cd8a787a18da69ac4e48cfc876623bd7323799) 
does not support GPIOs for chip-select.

Freescale seem to have abandoned their in-house non mainlined SPI driver in a 
later version of their kernel (rel_imx_2.6.38_11.09.01 tag in 
http://opensource.freescale.com/git) so you may want to update your kernel.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -

------------------------------------------------------------------------------
Get your Android app more play: Bring it to the BlackBerry PlayBook 
in minutes. BlackBerry App World&#153; now supports Android&#153; Apps 
for the BlackBerry&reg; PlayBook&#153;. Discover just how easy and simple 
it is! http://p.sf.net/sfu/android-dev2dev
