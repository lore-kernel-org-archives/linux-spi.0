From: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [patch 2.6.25-git] spi_mpc83xx much
	improved driver
Date: Thu, 1 May 2008 12:42:01 +0200
Message-ID: <5149.69274304367$1209638739@news.gmane.org>
References: <200804301537.07965.david-b@pacbell.net>
	<20080430154631.b86797de.akpm@linux-foundation.org>
	<200804301555.34110.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, 12o3l-IWqWACnzNjzz+pZb47iToQ@public.gmane.org,
	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: "'David Brownell'" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	"'Andrew Morton'" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200804301555.34110.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Language: sv
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

> -----Original Message-----
> From: David Brownell [mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org]
> Sent: den 1 maj 2008 00:56
> To: Andrew Morton
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; joakim.tjernlund@transmode.s=
e; linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org;
> 12o3l-IWqWACnzNjzz+pZb47iToQ@public.gmane.org
> Subject: Re: [patch 2.6.25-git] spi_mpc83xx much improved driver
> =

> On Wednesday 30 April 2008, Andrew Morton wrote:
> > > +=A0=A0=A0=A0=A0spin_lock_irq(&mpc83xx_spi->lock);
> >
> > irq-safe.
> >
> > > ...
> > >
> > > +=A0=A0=A0=A0=A0spin_lock(&mpc83xx_spi->lock);
> >
> > not irq-safe.
> >
> > Deliberate?
> =

> That latter one is inside an #if 0/#endif block, so it won't matter.
> The #if 0 block bothered me.  Maybe Joakim can remove it.

The non irq-safe spin_lock was there before my patch and now it is
removed with the #if 0/#endif block. I don't need this code but
I left it there disabled to make it clear for everyone else
that it was removed. I can remove it but I rather leave it
there for one release so everyone will have a chance to see
it and object if they feel differently.

> =

> (By the way, I'd feel safer about this patch if there were an
> ack or two from more PPC folk...)

 Yeah, that would be good.

 Jocke



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
