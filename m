From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH] spi: fix m25p80 when the cs_change
	hint is honored
Date: Wed, 20 May 2009 08:25:47 +0300
Message-ID: <20090520052547.GE28870@tarshish>
References: <1242731340-12160-1-git-send-email-baruch@tkos.co.il>
	<200905192134.14316.david-b@pacbell.net>
	<20090520045506.GD28870@tarshish>
	<200905192209.19125.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200905192209.19125.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Tue, May 19, 2009 at 10:09:19PM -0700, David Brownell wrote:
> On Tuesday 19 May 2009, Baruch Siach wrote:
> > If so would a clarification of the relevant text at  
> > include/linux/spi/spi.h be accepted?
> 
> In what way is the existing language unclear?  There are
> two paragraphs in the "struct spi_transfer" kerneldoc.

I (wrongly) understood the name cs_change as saying "chip select change", that 
is, "deactivate the chip select". Then I read the following text from 
include/linux/spi/spi.h:

    "(ii) When the transfer is the last one in the message, the chip may stay 
    selected until the next transfer."

I (wrongly again) understood that this description applies to that case of
cs_change == 0. I'd rephrase the above sentence as follows:

    "(ii) When the transfer is the last one in the message, and cs_change != 
    0, the chip may stay selected until the next transfer."

Does this make sense?

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
