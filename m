From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/pxa2xx-pci: Pass host clock rate info from PCI
 glue layer
Date: Tue, 22 Apr 2014 19:21:49 +0100
Message-ID: <20140422182149.GB12304@sirena.org.uk>
References: <1397751967-20250-1-git-send-email-chiau.ee.chew@intel.com>
 <1397751967-20250-3-git-send-email-chiau.ee.chew@intel.com>
 <20140418163054.GH12304@sirena.org.uk>
 <20140422115716.GP30677@intel.com>
 <20140422120948.GT12304@sirena.org.uk>
 <20140422152723.7542a3bc@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LGhQbn2N+4fvG9BK"
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140422152723.7542a3bc-mUKnrFFms3BCCTY1wZZT65JpZx93mCW/@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LGhQbn2N+4fvG9BK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 03:27:23PM +0100, One Thousand Gnomes wrote:
> > Why is this conditional?  It's really unhelpful for writing generic code
> > handling clocks that the API isn't available as standard.  Allowing the
> > user to disable it if it's not required makes sense but not making it
> > available at all is just unhelpful.

> KConfig allows drivers to select features they need - this seems to be a
> non issue ?

No, not for the clock API - the platform has to provide a clock API
since currently platforms still have the option of providing their own
implementation.  We should fix that (just making the common clock API
available on all platforms which don't have a custom one would help a
lot) but getting anyone to take any interest has been hard.

--LGhQbn2N+4fvG9BK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVrM6AAoJELSic+t+oim9tlIP+wTQiBb23vhbQ1z/wik1Ie9v
V90ZWVPF6B21b5nITnaofbt+YhKlJbDGebDQXFpfn4Ch70pqSoYXSFQNG749yWQE
t0EoUnuaNsAoSLeUmdR6e3EiXU3U44gxXMz4dyRWo8QbAlfic1ka0Z62nbwXPRei
/+Ay9gU1QyymsgswLoIw8UAQ1gKv/5jwXqhTTFyXEez5XOaQmtVFdnVAVgSKUdEP
yc/SAUsGiNtkeReKLQECL60WN4cF1Zpqw3MSlH5Ix1ZLutZu9NGSjw33YB+04ARl
RhxovI6jWCllve+YYdGyCjHt4tNC8zYk9D5Cnf6A14MrnRMtwnoKoMEUGJAUgH8D
rgNT9gee+j/gq1mbb1Pmd/2IQyYabEU4cjg9eX6KwjqssuajjFY2eukPzmaQDUYv
f/nJ8BmkAQkP+d52eea0djJRpje+59Gt16WUNkPhHfgsc9yU4RUR/SUtlnRoUhnY
g92coY2m9a0NdXgIvk4MJHjsyN5WqC7pAtLGHd86vXoGoV5xufrPshXgsABHL/7c
wQ0cDVeAAfOwEBPIlVtlzAeYMaaezKHkjhP0XxXFQAaw6qgjYfjxc8Y+0buFXg1O
r0wfjb4i22atqaUDLCrR0gqgoTd6Kyyiuu+ubJRigjAlXgqv4/u69YW7dZOJCael
NTZ7yORBJ6A0FLwzp4Hv
=6JU5
-----END PGP SIGNATURE-----

--LGhQbn2N+4fvG9BK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
