From: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v5] spi: Add PPC4xx SPI driver
Date: Mon, 05 Jan 2009 20:31:17 +0100
Message-ID: <20090105193117.E5AD98387CDB@gemini.denx.de>
References: <1227628088-10849-1-git-send-email-sr@denx.de>
	<200812271130.12513.david-b@pacbell.net>
	<200901051912.25874.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <200901051912.25874.sr-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Stefan,

In message <200901051912.25874.sr-ynQEQJNshbs@public.gmane.org> you wrote:
>
> > > +	/* Write new configration */
> > > +	out_8(&hw->regs->mode, cs->mode);
> > > +
> > > +	/*
> > > +	 * Allow platform reduce the interrupt load on the CPU during SPI
> > > +	 * transfers. We do not target maximum performance, but rather allow
> > > +	 * platform to limit SPI bus frequency and interrupt rate.
> >
> > That comment doesn't seem even vaguely related to the
> > code it allegedly refers to ... nothing in this routine
> > affects the IRQ load.
> 
> IIRC (I didn't write the original version of this driver) then this comments 
> simply refers to the fact that the platform can select a maximum SPI 
> frequency via spi->max_speed_hz which is pretty obvious. So I'll just remove 
> this comment in the next version.

On PPC4xx systems we get one interrupt per transferred  byte,  i.  e.
there  is  a  direct relation between SPI bus frequency and interrupt
rate.

Since this is a PPC4xx SPI driver, the comment is actually helpful to
understand the operation of the driver especially in relation to  the
limitations of the hardware.

Instead of removing the  comment  (which  leaves  the  casual  reader
clueless)  it  would probably better to add a sentence explaining the
one byte / one interrupt situation?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd-ynQEQJNshbs@public.gmane.org
...when fits of creativity run strong, more than  one  programmer  or
writer  has  been  known to abandon the desktop for the more spacious
floor.                                             - Fred Brooks, Jr.

------------------------------------------------------------------------------
