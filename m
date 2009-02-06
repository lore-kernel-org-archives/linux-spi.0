From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 1/5] Blackfin SPI Driver: use
 bfin_spi_ prefix on all functions
Date: Thu, 5 Feb 2009 18:47:35 -0800
Message-ID: <20090205184735.f82c8bc3.akpm@linux-foundation.org>
References: <1233828453-13311-1-git-send-email-cooloney@kernel.org>
	<1233828453-13311-2-git-send-email-cooloney@kernel.org>
	<20090205141245.2945141e.akpm@linux-foundation.org>
	<20090206133436.199d9282.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090206133436.199d9282.sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 6 Feb 2009 13:34:36 +1100 Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org> wrote:

> Hi Andrew,
> 
> On Thu, 5 Feb 2009 14:12:45 -0800 Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:
> >
> > As usual, the driver core guys have gone trompling all over other people's code
> > and your patch doesn't apply to linux-next.
> > 
> > 11 out of 61 hunks FAILED -- saving rejects to file drivers/spi/spi_bfin5xx.c.rej
> 
> To be fair

no, they don't deserve it!  They just got lucky this time ;)

>, next-20090206 has one patch to that file it is a single hunk
> and only affects 2 lines and the patch was cc'd to the spi folks (I can't
> easily tell when as the driver-core stuff (being a quilt tree) gets
> rebased often).

yup.

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
