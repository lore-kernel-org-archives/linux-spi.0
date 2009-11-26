From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] spi: SuperH MSIOF SPI Master driver
Date: Wed, 25 Nov 2009 23:07:48 -0800
Message-ID: <20091125230748.dbb7cf09.akpm@linux-foundation.org>
References: <20091124125531.14957.41264.sendpatchset@rxone.opensource.se>
	<20091125121152.4ccf03dc.akpm@linux-foundation.org>
	<20091126064315.GA6580@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20091126064315.GA6580-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 26 Nov 2009 15:43:16 +0900 Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org> wrote:

> > > +static void sh_msiof_modify_ctr_wait(struct sh_msiof_spi_priv *p,
> > > +				     unsigned long clr, unsigned long set)
> > > +{
> > > +	unsigned long mask = clr | set;
> > > +	unsigned long data;
> > > +
> > > +	data = sh_msiof_read(p, CTR);
> > > +	data &= ~clr;
> > > +	data |= set;
> > > +	sh_msiof_write(p, CTR, data);
> > > +
> > > +	while ((sh_msiof_read(p, CTR) & mask) != set)
> > > +		;
> > 
> > hm, confidence.  No timeout needed here?
> > 
> This definitely needs a timeout, nothing involving SPI inspires
> confidence. A cpu_relax() to prevent the compiler from optimizing the
> loop out would help, too.

We generally don't bother with the relax in an IO polling loop
like this.  It involves an IO read/write which the compiler cannot fiddle
with and I believe that CPUs will generally take the opportunity to have
a little snooze while the slow IO operation is happening.

Can't hurt though ;)

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
