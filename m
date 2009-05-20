From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH] spi: fix m25p80 when the cs_change
	hint is honored
Date: Wed, 20 May 2009 07:55:07 +0300
Message-ID: <20090520045506.GD28870@tarshish>
References: <1242731340-12160-1-git-send-email-baruch@tkos.co.il>
	<200905192134.14316.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200905192134.14316.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi David,

On Tue, May 19, 2009 at 09:34:14PM -0700, David Brownell wrote:
> Normal behavior of a spi_message is to keep the chipselect active
> during the entire message, then deactivate it after the last transfer.
> Setting the cs_change flag *changes* that behavior ... allowing either
> (a) brief mid-message deselection, usually to make a message hold a
> composite transaction, or else (b) hinting that immediate deselection
> isn't neccessary, as a possible performance tweak for some drivers.
> 
> Note that while (a) is mandatory -- drivers that can't do it must
> reject the messages using it -- (b) is optional.  When the next
> message goes to a different device, obviously the chip selection
> lines will need to change.

Thanks for the clarification.

If I understood correctly then, cs_change has two opposite meanings:

1. If cs_change != 0 in spi_transfer that is not the last in the current 
   spi_message, then deactivate the chip select between this spi_transfer and 
   the next.

2. If cs_change != 0 in spi_transfer that is that last in the current 
   spi_message, then the SPI controller is allowed to NOT deactivate the chip 
   select after the current spi_message.

Is this correct? If so would a clarification of the relevant text at 
include/linux/spi/spi.h be accepted?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
