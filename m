From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: of: allow instantiating slaves without a driver
Date: Sun, 26 Jun 2016 12:21:33 +0100
Message-ID: <20160626112133.GJ28202@sirena.org.uk>
References: <cover.1466696079.git.hramrach@gmail.com>
 <ebe2a48124441819adab773b28cd12425ba5bda4.1466696079.git.hramrach@gmail.com>
 <20160626011500.GF28202@sirena.org.uk>
 <CAOMqctSA0G+fBKNgAizqWvEUfJLr9Fh0SsN0Pn-cQv=zeu7iFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p0aHTXLXY/BobAxh"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>,
	Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>,
	Nikolay Aleksandrov <nikolay-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>,
	Dmitry Vyukov <dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Adrien Schildknecht <adrien+dev-Yk6CzqVXkG6lnMjI0IkVqw@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctSA0G+fBKNgAizqWvEUfJLr9Fh0SsN0Pn-cQv=zeu7iFg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--p0aHTXLXY/BobAxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 26, 2016 at 04:23:41AM +0200, Michal Suchanek wrote:
> On 26 June 2016 at 03:15, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > I can't relate this hunk to the changelog and there's a coding style
> > problem, if there's { } on one side of an if statement it should be on
> > both sides.  Why are we making this change?

> The intention is that you can specify that your SPI master controller
> has a CS available without setting up the slave

This is completely unrelated to the rest of the change and needs
describing in the changelog.

> Then you can amend the slave node with an overlay or bind a driver
> that can deal with the node having no configuration.

You can just add the entire slave node in the overlay, it's not clear
that this buys us anything useful (and typically you'd want to as the
maximum speed here is more a function of the slave device than the
master), and this needs to be joined up with the work going on to allow
expansion connector overlays to be loaded in the first place.

> The check here isn't very effective anyway since slaves with zero
> speed somehow creep into the kernel. I have seen people reporting
> division by zero in SPI master driver as a result. The proper way to
> fix this is to specify the master minimum and maximum speed limit so
> the SPI core can reject transfers with speed outside of the allowed
> range.

That's a separate argument which is again unrelated to the changelog.
If the check isn't working it would be better to have an analysis of why
it's not working.

--p0aHTXLXY/BobAxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXb7q8AAoJECTWi3JdVIfQIqMH/2rbbHiHFEvUUm6EU1+dqWZO
t9kI138y6GM5n355y0fUQFHLFm3JL88wQ6k7YzCku9xAE77K2T7xqDrRLYo+Q5OF
bcMg4HTV4DSL4K2ZEmc7yabqgcGlEPtk8p3//SKjFmC4PrYiBMYOBeOmx8W2pnQX
Cx0IV3JGKngzhpSrI1NrhcCNNdjTI0CMiqQX2BYn9vVlM7yPlfMrcD7dIAvd3XdZ
x5d2wSzRXeVjIClGvkq1VATtKTPxEXw8J5MgPddFO4JIGSzLMmXFnNOUz4kar1sJ
m0GVjwRH0oArgCo2przoMbC4b0MUL9Dlq/YxyENoban+ea7lkNBI6qgGCgVz340=
=TIxm
-----END PGP SIGNATURE-----

--p0aHTXLXY/BobAxh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
