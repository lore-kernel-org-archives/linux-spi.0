From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-ep93xx: Change dir type in
 ep93xx_spi_dma_{finish,prepare}
Date: Fri, 5 Oct 2018 12:15:31 +0100
Message-ID: <20181005111531.GA6266@sirena.org.uk>
References: <20181004023926.15847-1-natechancellor@gmail.com>
 <20181004103247.GC6412@sirena.org.uk>
 <20181004160432.GA7674@flashbox>
 <CAKwvOd=bZWsgggLMODN0OPSu=c=pQZsREvTtNcUn+arEEVJQjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Cc: linux-spi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hartleys@visionengravers.com, mika.westerberg@iki.fi,
        Nathan Chancellor <natechancellor@gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOd=bZWsgggLMODN0OPSu=c=pQZsREvTtNcUn+arEEVJQjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 04, 2018 at 09:41:20AM -0700, Nick Desaulniers wrote:
> On Thu, Oct 4, 2018 at 9:04 AM Nathan Chancellor
> > On Thu, Oct 04, 2018 at 11:32:47AM +0100, Mark Brown wrote:

> > > Please remember to CC driver maintainers and authors on patch
> > > submissions so they can review things, copying in Hartley and Mika.

> > Thank you for that, I usually just rely on get_maintainer.pl but I'll be

> If get_maintainer.pl doesn't cc the right person, does that signal
> that the MAINTAINERS file has some omissions?

It can do but there's always cases where it misses people - someone
working very actively on a bit of code for the short term for example.
Especially with drivers if you're only seeing subsystem maintainers then
it's worth checking.  The --git option helps a lot here.

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu3R9AACgkQJNaLcl1U
h9AHIQf9GFVHGPHQ7YZFhuWEKEWwg69MTbUwi1B9Rcct/3SJv1FTD5NQ6REoKl4Y
1zKO0GtixckrgUjZ4sBLNF6rz6p9ukgoUA0J5OSzS1zxsCp3F1I1waP/4NU4LYFR
htTf2/5n11eImDo69ZHZTxm+BjrWheOO8LQNxN1JOLHjQOqjZYPVzFVgz6mb3GlM
zTm3pgwAc+xcFUV+VLTuNysGCdmVP6pVGJwmiel2VtG0YN9kSColHjnGEJJ6518Y
7p+SUu0CVIP0lvtsPu+0lpl5QsjwSdY+S1Hzkv1+DlSkJsAHsxnij+5OSeUysBdp
U2OTdae3TSHqmEZrCAbObl4yFqP++Q==
=16fG
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
