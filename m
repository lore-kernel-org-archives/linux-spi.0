From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: of: allow instantiating slaves without a driver
Date: Sun, 26 Jun 2016 18:25:40 +0100
Message-ID: <20160626172540.GR28202@sirena.org.uk>
References: <20160626011500.GF28202@sirena.org.uk>
 <CAOMqctSA0G+fBKNgAizqWvEUfJLr9Fh0SsN0Pn-cQv=zeu7iFg@mail.gmail.com>
 <20160626112133.GJ28202@sirena.org.uk>
 <CAOMqctQernycZkc0Wia9EierT1PhfcYAPWc=89LgTC-DBgkg5A@mail.gmail.com>
 <20160626115815.GN28202@sirena.org.uk>
 <CAOMqctTf16DDs1j+pL47xBJt2BVdCdHPFUEwaZ6ak_vFtrKBOQ@mail.gmail.com>
 <20160626124550.GO28202@sirena.org.uk>
 <CAOMqctRrz7KZ0RFFnE4kW=Kst9ha6QAj2ZVkirSjuDXpZHqSDg@mail.gmail.com>
 <20160626125717.GQ28202@sirena.org.uk>
 <CAOMqctQpr4A6_bS_+G9DQdcxcYkPHxntX_vUPBCoZN8FxHOxzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="opXR4bS/BgjGcxUR"
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
In-Reply-To: <CAOMqctQpr4A6_bS_+G9DQdcxcYkPHxntX_vUPBCoZN8FxHOxzg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--opXR4bS/BgjGcxUR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 26, 2016 at 05:19:54PM +0200, Michal Suchanek wrote:
> On 26 June 2016 at 14:57, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > That would be a binding for the connector which is the big missing bit
> > here - it's not clear that such a limited connector description would be
> > a good idea.

> It would work for a limited number of devices. Anyway, connectors are
> supposed to be transparent so if binding devices has issues now it
> will supposedly have same issues once connectors allow renaming
> several devices at once from board-specific name to connector-specific
> name rather than one at a time as this limited connector binding
> allows.

It's not entirely clear to me that connectors are going to end up
transparent, at least to the host system - there's things like pinmuxing
in there.  They're a definite thing and some work needs to go into
hiding them from the plugin modules, work which might mean that these
dummy nodes don't need to be created.

In any case this series needs a bunch of restructuring, some of it needs
replacing and the whole thing needs to be presented a lot more clearly.

--opXR4bS/BgjGcxUR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcBATAAoJECTWi3JdVIfQWbMIAIJ8cqANcG6kgOaJOoEYEDRQ
g2++NfXziNH9ChKJCoNb6MuO5CAYywW3cRDSa3D7DSC/Fm55kCK+kqpcUAcKQluo
nqS62i5E99PGqwXivIvht1jZDo6NSyyLONhCF7bfvoIJe308d2JE1bs32RAxknKO
NyxN/C6j/PaVPJVFxYjYgRypXyOXQObTK/9WVvLyfJ1Bwi/ws0khWfHvIdBy7Yca
gvtIWZYX4ab9KBhmLvAYWEgKsGYqkmGNQvcLk8qaqIM8fnzpx9HVcMSf4YFENxBR
Nhj/JxS+42G+f+Mg1cvD8O+iFOLY7yfyt2PmdPhLCjHZ5bxDWQKdz616ikPl3GU=
=0yqN
-----END PGP SIGNATURE-----

--opXR4bS/BgjGcxUR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
