From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH 0/2] spi: add driver for
	SPI	controller of Intel Moorestown platform
Date: Mon, 15 Jun 2009 13:18:15 +0300
Message-ID: <20090615101815.GB21428@tarshish>
References: <20090615173845.59f3437b@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090615173845.59f3437b@feng-desktop>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Feng,

On Mon, Jun 15, 2009 at 05:38:45PM +0800, Feng Tang wrote:
> This patch series adds driver for SPI controller of Intel Moorestown 
> platform.
> 
> This driver has been tested with Maxim's Max3110 UART device and
> Option's 3G modem GTM501L, both PIO and DMA works fine, and these
> 2 slave devcies can work simultaneously
> 
> User can use "dw_apb_ssi_db.pdf" from Synopsys as HW datasheet

Wow. This is a big surprise for me. I was working on a driver of the Synopsys 
Designware SPI controller myself during the last year. I posted my work on 
this list and got reviews from Linus Walleij. No word from David Brownell yet.  
I'll look into your work and see whether we can merge the drivers.

My first comment is regarding the name of the driver. This should be 
designware_spi, as this IP block appears in other chips as well, and is not 
Intel Moorestown specific.

> please help to review them.
> 
> I haven't seen your mail on this list for a while, so I cc' Andrew and Alan
> for their reviews as well.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
