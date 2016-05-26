From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Thu, 26 May 2016 11:07:53 +0100
Message-ID: <20160526100753.GB16172@sirena.org.uk>
References: <20160524172045.GN8206@sirena.org.uk>
 <57449784.4070108@weinigel.se>
 <20160524183256.GP8206@sirena.org.uk>
 <5744E51A.1040506@gmail.com>
 <20160525174932.GA10753@rob-hp-laptop>
 <5745E9B6.5090204@gmail.com>
 <20160525184442.GE8206@sirena.org.uk>
 <57464D0A.1030706@weinigel.se>
 <CAL_JsqJwQvPGtscheZjoJyhF1UPxDSqbS-QB9qm3M4HbpOicVA@mail.gmail.com>
 <574657BB.6070300@weinigel.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <574657BB.6070300-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 26, 2016 at 03:56:11AM +0200, Christer Weinigel wrote:
> On 05/26/2016 03:44 AM, Rob Herring wrote:
> > Lovely. "Here's something that's simple and useful for users. Let's
> > break it". What part of "we do not break userspace" do you not
> > understand? Because that would be a user visible change.

You'll notice I've not actually posted this patch...

> > The other saying is "if it is not upstream, it doesn't exist." That
> > said, I don't think we should remove it. Maybe some time later, but
> > first we need a suitable alternative.

My inclination is to leave it unless we think of and implement something
better to do (like using labels), except possibly for paying attention
to string based aliases too.  Or perhaps we want to just treat all
aliases as strings.

> Huh?  Commit bb29785e0d6d, which added support for assigning spi bus numbers
> via devicetree aliases, has been in the upstream Linux kernel since v3.9
> which was released over three years ago.

I think Rob's referring to the fact that there are no in tree DTs that
use this feature - all the aliases for SPI controllers in mainline are
string based.

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRsr4AAoJECTWi3JdVIfQdeYH+QHio6sSjeqGt8VvWsadkR/B
32yRz8fso0clJG0GGyzp8nwoWcm77FeJAuaMnnXXIvYzTRlfKA1oOxVPniXYvNP5
gTdmKwN5/1Ti0MoSzrRlOxHbFdXOrZ9GmNaXrKWiOjmg6fHgV0UoKqVY0euZv05E
MNirz8RkhRjE9/Zfw+sPt8D7jNYjspkwLWJdGlsDaW5CdxhNwx4QfnYlHBtmZ5gY
xYQHuhV/3HWI5EYaNfibS6zHETAtTxXh5ZocCYQhY/BV+133CyeuH/uaLwLP6/O2
Ke42klNzzQjBVxfU+bGXl9d7dZH6u7C18hMVjhhtZVkCwKqEvL2bOCeLIklbxFk=
=ZmyN
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
