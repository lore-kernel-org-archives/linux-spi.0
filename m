From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
Subject: RE: [patch 2.6.25-git] spi_mpc83xx much improved driver
Date: Thu, 1 May 2008 12:42:01 +0200
Message-ID: <1924.82319330356$1209638659@news.gmane.org>
References: <200804301537.07965.david-b@pacbell.net>
	<20080430154631.b86797de.akpm@linux-foundation.org>
	<200804301555.34110.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net, 12o3l@tiscali.nl,
	linuxppc-dev@ozlabs.org
To: "'David Brownell'" <david-b@pacbell.net>,
	"'Andrew Morton'" <akpm@linux-foundation.org>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <200804301555.34110.david-b@pacbell.net>
Content-Language: sv
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
List-Id: linux-spi.vger.kernel.org

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: den 1 maj 2008 00:56
> To: Andrew Morton
> Cc: spi-devel-general@lists.sourceforge.net; joakim.tjernlund@transmode.s=
e; linuxppc-dev@ozlabs.org;
> 12o3l@tiscali.nl
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
