From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: spidev: fix the check for spidev in dt
Date: Sun, 26 Jun 2016 12:05:14 +0100
Message-ID: <20160626110514.GI28202@sirena.org.uk>
References: <cover.1466696079.git.hramrach@gmail.com>
 <8b66102e44829c5dc445c17f7bfad1050840b9f0.1466696079.git.hramrach@gmail.com>
 <20160626011315.GE28202@sirena.org.uk>
 <CAOMqctR3MDijTSr0=7tiHK+exygrGLbLQQ=GF_KAH-Y2xvb1Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y4/B1uKDHmWlpzsz"
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
In-Reply-To: <CAOMqctR3MDijTSr0=7tiHK+exygrGLbLQQ=GF_KAH-Y2xvb1Nw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Y4/B1uKDHmWlpzsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 26, 2016 at 04:12:10AM +0200, Michal Suchanek wrote:
> On 26 June 2016 at 03:13, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Thu, Jun 23, 2016 at 05:41:19PM -0000, Michal Suchanek wrote:

> >> The check is supposed to warn about spidev specified directly in
> >> devicetree as compatible. This just does not work. I have a devicetree
> >> with no compatible whatsoever and hacked my kernel so I can manually
> >> bind spidev. This still triggers.

> > Well, a DT device won't instantiate without a compatible string...
> > could you please explain exactly what makes you say this won't work?

> That's because the whitelist concept for this check is completely broken.

> Without any patches whatsoever I should be able to specify m25p80
> binding in the DT, let the kernel create the device, unbind the
> driver, and bind spidev.

> Then I have the jedec,spi-nor compatible which is not on the whitelist.

So, none of that is in the changelog where it needs to be and it only
makes sense if we adopt the very specific solution you are proposing.
You need to describe this change properly and you need to put it at the
end of the patch series were it makes sense.

--Y4/B1uKDHmWlpzsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXb7bpAAoJECTWi3JdVIfQQHcH/2783gp4lSO6PeFdWJnMqoXz
pD3ZKnvAyfIkuF54PKjesGjBUR6pkuuLSSB/bYNtyccZh0XZ6RR0Bjv/8ZDeRsyV
77YjjuemmMB6Qnv3PIDv0uqc6OkcdMBgynGWDf9AvGqjM5bd0POxmQYBVjeLwoyE
+evaBzJZeJq47uoZX7U/WAeXpBve6P6L1VF5QAUh5ezEEAheXhbAPP7X8IA3wFgt
JMjqmESwdZWCX32bH5qxgxPNAdGJxG/fflvTaEdDnupAFm/EbukFKWaIww61ERDG
0Sl+KzJ+JUEPF4bbGjpgQJG4e7uqoStQ53AYFF0U/tBuvIiYW6oUvcr8t2A2N6M=
=Ntf4
-----END PGP SIGNATURE-----

--Y4/B1uKDHmWlpzsz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
