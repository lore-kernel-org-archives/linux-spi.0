From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: i.MX SPI driver
Date: Thu, 18 Jun 2009 09:01:24 +0200
Message-ID: <20090618070124.GU31396@pengutronix.de>
References: <1245235220-23816-1-git-send-email-s.hauer@pengutronix.de>
	<4A39E2BF.8060104@swapp-eng.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: VISCOUNT - Larcher Alessandro <a.larcher-cBrwBxTNXEs1GQ1Ptb7lUw@public.gmane.org>,
	VISCOUNT - Zinato Carlo <c.zinato-cBrwBxTNXEs1GQ1Ptb7lUw@public.gmane.org>,
	VISCOUNT - Gabrielli Sandro <s.gabrielli-cBrwBxTNXEs1GQ1Ptb7lUw@public.gmane.org>,
	David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A39E2BF.8060104-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Andrea,

On Thu, Jun 18, 2009 at 08:46:23AM +0200, Andrea Paterniani wrote:
> Hi Sascha,
>
> Sorry for late replay!
> The current driver support DMA transfers.
> Surely for our design this feature is mandatory since we need to sustain  
> heavy SPI traffic.
> I suggest to not remove the driver even if it only supports iMX1 device  
> and not the entire family.
> Is it possible to have both current and new drivers?

I really wouldn't suggest that. The current driver does not work anymore
anyway since arch-imx is gone and the DMA API has changed on arch-mx1.
We have to do some work anyway, so I suggest to put the effort into DMA
support for the new driver. Since it's a bitbang driver it shouldn't be
hard.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
