From: Mark Brown <broonie@kernel.org>
Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Date: Wed, 28 Aug 2019 22:20:34 +0100
Message-ID: <20190828212034.GL4298@sirena.co.uk>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <VI1PR04MB4015474B3086AE99354FE65395A50@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822184927.GH23391@sirena.co.uk>
 <20190827155005.GA18581@bogus>
 <20190827195606.GA28879@sirena.org.uk>
 <CAL_JsqKnY1ucejpaSUYu_dGZ=uHMybsW4ryJAtEgimUXB+ozbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V3eawNQxI9TAjvgi"
Cc: Ashish Kumar <ashish.kumar@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKnY1ucejpaSUYu_dGZ=uHMybsW4ryJAtEgimUXB+ozbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--V3eawNQxI9TAjvgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2019 at 03:01:15PM -0500, Rob Herring wrote:
> On Tue, Aug 27, 2019 at 2:56 PM Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Aug 27, 2019 at 10:50:05AM -0500, Rob Herring wrote:

> > Well, you have been pushing people to change over to using
> > dt-bindings: so I guess you do care :(

> Well, yes. In the absence of any sort of pattern, I have pushed for
> some consistency. And to get rid of subjects like this:

> Documentation/devicetree/bindings: Add the DT binding documentation for foo-bar

> If subsystems are consistent with their own standard as you are, then
> as a maintainer I don't really care. My point was in regard to what
> submitters need to know and follow.

I agree that things should be more consistent.

> > It really does cause me
> > to miss stuff, especially where people don't even include the
> > subsystem name in the header.  I get quite a lot of CCs for

> I can't imagine filtering on subjects will ever be that reliable
> unless we add subject prefixes to MAINTAINERS and have checkpatch
> check commits against those. Filtering on the diffstat is the only
> thing that's kept things to a sane list for me (MAINTAINERS for DT
> used to tag of_* functions which just meant getting copied on *every*
> driver). This is done on the patchwork server side for me, but I
> imagine one could do it on the client side too.

Part of the problem for me here is that stuff that's flagged as just a
binding has a very high chance of being misdirected, I'm unlikely to
have much input unless it's for a driver or subsystem I maintain and I
get a lot of bindings docs for things like other bits of MFDs that have
a regulator on them or where there was some interesting interaction with
one of my subsystems that hasn't yet filtered out of get_maintainers'
view.

The other trick here is that sometimes I am actually being asked about
the thing that I'm getting CCed on so I don't want to actually filter
stuff out of my inbox, it's more of a scoring system thing with lots of
guessing going on.  I say filtering but it's more a strong signal than
strictly a filter.

--V3eawNQxI9TAjvgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1m8CEACgkQJNaLcl1U
h9CrLwf/X5MQzBfb7KpPjUp6dJEyGZqPZF7kgvsPjAMXkY9IjIBIuCqeYj1aNCdU
iRKUACgqSXfN6cFrlsx4tINlbMoQA7I9QrDjEULrM92Q+ScjIlbBVfNc0tPNjNXW
jWoXqK0qjVkHC7A1IppMEU3Z8VtLCIe0pE51MSWl/IcLh0PlMNZBpnvOFz+M9LA+
dUnF9/4/oA4smOQ9rSH0iLi9ceXsag2Hva5dSDkbwmYC7+QavIK5fGWxvM7sCMgF
NMhlBwLZBjD1NWix97vbA2laF1unnRFEdxswTym4bmo/yMwSdgPUbryI0mtgiKtj
AEcGfuhWCTX9uZEBJOhs9d8+oA8RQw==
=uj8w
-----END PGP SIGNATURE-----

--V3eawNQxI9TAjvgi--
