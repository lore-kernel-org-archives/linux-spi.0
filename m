From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v6] spi: Add PPC4xx SPI driver
Date: Wed, 22 Apr 2009 01:56:02 -0700
Message-ID: <200904220156.02440.david-b@pacbell.net>
References: <1231411250-25380-1-git-send-email-sr@denx.de>
	<200904212236.12904.david-b@pacbell.net>
	<200904221029.38454.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200904221029.38454.sr-ynQEQJNshbs@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 22 April 2009, Stefan Roese wrote:
> On Wednesday 22 April 2009, David Brownell wrote:
> > On Thursday 08 January 2009, Stefan Roese wrote:
> > > This adds a SPI driver for the SPI controller found in the IBM/AMCC
> > > 4xx PowerPC's.
> >
> > Note that given some patches now in the mm tree, this needs
> > something like the appended fixup.  Some common code has now
> > moved into the spi core.
> 
> So would you accept the driver for 2.6.31 merge with your suggested change 
> below? If yes, I'll generate a 7th version.

Hold on until I send the rest of my review comments; almost done.
Sorry for the delay.  Yes, I think a 2.6.31 merge should be doable.

- Dave


> 
> Thanks.
> 
> Best regards,
> Stefan
> 
> 




------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
