From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v5] spi: Add PPC4xx SPI driver
Date: Tue, 6 Jan 2009 09:26:34 +0100
Message-ID: <200901060926.34287.sr__31386.0377799303$1231230532$gmane$org@denx.de>
References: <1227628088-10849-1-git-send-email-sr@denx.de>
	<200901051912.25874.sr@denx.de>
	<20090105193117.E5AD98387CDB@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090105193117.E5AD98387CDB-C2Gvrrd9BC/j/ljBK/0BTg@public.gmane.org>
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

Hi Wolfgang,

On Monday 05 January 2009, Wolfgang Denk wrote:
> > IIRC (I didn't write the original version of this driver) then this
> > comments simply refers to the fact that the platform can select a maximum
> > SPI frequency via spi->max_speed_hz which is pretty obvious. So I'll just
> > remove this comment in the next version.
>
> On PPC4xx systems we get one interrupt per transferred  byte,  i.  e.
> there  is  a  direct relation between SPI bus frequency and interrupt
> rate.
>
> Since this is a PPC4xx SPI driver, the comment is actually helpful to
> understand the operation of the driver especially in relation to  the
> limitations of the hardware.
>
> Instead of removing the  comment  (which  leaves  the  casual  reader
> clueless)  it  would probably better to add a sentence explaining the
> one byte / one interrupt situation?

OK, I'll this explanation instead.

Thanks.

Best regards,
Stefan

------------------------------------------------------------------------------
