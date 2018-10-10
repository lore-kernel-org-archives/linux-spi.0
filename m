From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Date: Wed, 10 Oct 2018 13:27:10 +0100
Message-ID: <20181010122710.GE6294@sirena.org.uk>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <20181010101825.GA6294@sirena.org.uk>
 <dbac7f00-e9cc-ddac-5734-9763b5985ead@amazon.com>
 <20181010112753.GC6294@sirena.org.uk>
 <ba83a08073614d9244c01218da28fe3e23f3bbc2.camel@amazon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Cc: "Shenhar, Talel" <talel@amazon.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: "Woodhouse, David" <dwmw@amazon.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ba83a08073614d9244c01218da28fe3e23f3bbc2.camel@amazon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2018 at 11:58:40AM +0000, Woodhouse, David wrote:
> On Wed, 2018-10-10 at 12:27 +0100, Mark Brown wrote:

> > If this is a modified IP with additional features then it should be
> > given a new compatible string rather than having a property - it's not
> > just configuration of the existing IP, it's a new thing and we may find
> > there are other quirks that have to be taken care of for it.

> No.

> It's an extension of the existing IP which is explicitly designed to be
> compatible with existing drivers via an opt-in feature.

That's totally normal and something that there's already infrastructure
to handle, plenty of other IPs have new versions with new features - you
can just add a new compatible string and use that to decide which
features to enable, and if it's backwards compatible with old versions
of the driver supporting older hardware then you can list multiple
compatibles.  As we just discussed on IRC this is partly a policy thing
now I've been told that it's a modified version of the hardware rather
than a configuration or integration option, it's easier than having
implementations of new features trickle out from the vendor and needing
to enable them all one by one in device trees (which does happen).

> Which is exactly what we've spent the last decade or two trying to beat
> hardware designers into doing, instead of randomly breaking
> compatibility for no good reason.

That's great and we get to reuse all the driver code with a quirk (a
quirk which fixes the hardware to be more compatible with devices, this
is a really good hardware change).  Ideally we'd be able to enumerate
things like IP versions and options from hardware but that's a more
entertaining problem.

Having said all this if there are production systems using this
property, especially production systems where people other than the
system integrator can realistically deploy their own kernel separate to
the device tree, then supporting those existing DTs even if they're not
doing the ideal thing might be the best thing.  You mentioned that this
might be the case, can you check what the status is there please?

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu98B0ACgkQJNaLcl1U
h9CPmgf/QMp2J8iPAnRVpTDGziEgyOEXdplvLf6fW0m4v5MSMSHJwgyrloZCVcVf
xnb5GsQaR89mnaqqd8FRJJ+VR13+4JWkqZTe5W4ha9MrpovU3EttyeQUSa0LDpEL
CuOHEvsG5lUy9szgAc2MRlf0Vf1gnCF0JtCGLWnoVC9qCHDQxQPyruhomrFdGdI3
3rXFbStZd6RmWtlfgu7f2V66oOc2FZwcMw/4ElO5IIUM1msI5PPgR1wCzO5SOkgy
fIQeVsMPs8mD3tq25/SkrxXv+rzNthkLTCHIod3jgmorCo9X2MvdZyoL9PN4s71w
o+xEojB7gcFcnud/EsHARj/OvSnXGQ==
=vsxh
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
