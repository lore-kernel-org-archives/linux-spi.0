From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/5] spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE
 when it's not ours
Date: Fri, 23 Aug 2019 11:50:44 +0100
Message-ID: <20190823105044.GO23391@sirena.co.uk>
References: <20190822211514.19288-1-olteanv@gmail.com>
 <20190822211514.19288-3-olteanv@gmail.com>
 <20190823102816.GN23391@sirena.co.uk>
 <CA+h21hoUfbW8Gpyfa+a-vqVp_qARYoq1_eyFfZFh-5USNGNE2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hl1kWnBARzJiTscN"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hoUfbW8Gpyfa+a-vqVp_qARYoq1_eyFfZFh-5USNGNE2g@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--hl1kWnBARzJiTscN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2019 at 01:30:27PM +0300, Vladimir Oltean wrote:
> On Fri, 23 Aug 2019 at 13:28, Mark Brown <broonie@kernel.org> wrote:

> > It would be better to have done this as the first patch before
> > the restructuring, that way we could send this as a fix - the
> > refactoring while good doesn't really fit with stable.

> Did you see this?
> https://lkml.org/lkml/2019/8/22/1542

I'm not online enough to readily follow that link right now, I
did apply another patch for a similar issue though.  If that's
a different version of the same change please don't do that,
sending multiple conflicting versions of the same thing creates
conflicts and makes everything harder to work with.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--hl1kWnBARzJiTscN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1fxQMACgkQJNaLcl1U
h9AOHgf8CAS5RBRoxTFZUsrmCEnLyMFYb7aueuSKLUE+iKi+G3NldiLt7pzFIU9d
svVlmYRKAks8vzJMW/BxQgaB+YfMGd8dUWEqCs2XORYRDLRd8MM5OIXZ89kda74l
SOBsfcmjetVLeO9Ws85HuXjl+zSyl3Rxa4AjW5B9hgIjw6gDZqCuA8bkUFq3xmTN
GMB3B+QB+friWpL3FuMcJiv6+PQU5Ing/NzphvWj18U6o5pzfxwQkv0iYVdhxsbN
2CtENUmGQ7A9IffnFv1FrRykxq16/VWEUjYblhuiTS5sYNRKiOmywWILnghWEGZZ
betTGkaDXFODaV43fus34BO8Ynd/7g==
=/HjI
-----END PGP SIGNATURE-----

--hl1kWnBARzJiTscN--
