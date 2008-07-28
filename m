From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [patch 2.6.26-git] spi_s3c24xx: really
	assign busnum
Date: Mon, 28 Jul 2008 15:39:51 +0100
Message-ID: <20080728143951.GB26938@trinity.fluff.org>
References: <200807271540.05120.david-b@pacbell.net>
	<20080727194434.35b8f980.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080727194434.35b8f980.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
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

On Sun, Jul 27, 2008 at 07:44:34PM -0700, Andrew Morton wrote:
> On Sun, 27 Jul 2008 15:40:04 -0700 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> 
> > From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > 
> > The original "Pass the bus number we expect the S3C24XX SPI driver to attach
> > to via the platform data." [1]  patch was mis-sent, and missed two important
> > parts of the diff, which was to actually set the bus_num field and add
> > the relevant field to the platform data.
> > 
> 
> um, OK.  I'd consider that changelog to be partial, because it doesn't
> describe the consequences of the bug.

It does reference the original patch which describes the original
itent of the change which unfortunately got broken when bringing
forward to submission.

> It means that people who are scratching their heads over whether this
> should be in 2.6.26.x don't have enough info to go on.

The only extra I can think of adding is:

The previous commit 50f426b55d919dd017af35bb6a08753d1f262920 promised to
add a bus_num field, but failed to include the two hunks that added this
field to include/asm-arm/arch-s3c2410/spi.h and then pass it to the
spi core when creating the new master field in drivers/spi/spi_s3c24xx.c.

This should fix any confusion when looking for the non-existant bus_num
field.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
