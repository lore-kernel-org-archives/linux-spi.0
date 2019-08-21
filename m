From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH spi for-5.4 1/5] spi: Use an abbreviated pointer to
 ctlr->cur_msg in __spi_pump_messages
Date: Wed, 21 Aug 2019 12:01:26 +0100
Message-ID: <20190821110126.GB5128@sirena.co.uk>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <20190818182600.3047-2-olteanv@gmail.com>
 <20190820182128.GH4738@sirena.co.uk>
 <CA+h21hpgi7-dJ-QoRBEQorcRyEuhqhKixpFK5fGxOnZxTHi-4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Cc: Hubert Feurstein <h.feurstein@gmail.com>, mlichvar@redhat.com,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hpgi7-dJ-QoRBEQorcRyEuhqhKixpFK5fGxOnZxTHi-4g@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2019 at 10:36:43PM +0300, Vladimir Oltean wrote:
> On Tue, 20 Aug 2019 at 21:21, Mark Brown <broonie@kernel.org> wrote:

> > On Sun, Aug 18, 2019 at 09:25:56PM +0300, Vladimir Oltean wrote:

> > >       /* Extract head of queue */
> > > -     ctlr->cur_msg =
> > > -             list_first_entry(&ctlr->queue, struct spi_message, queue);
> > > +     mesg = list_first_entry(&ctlr->queue, struct spi_message, queue);
> > > +     ctlr->cur_msg = mesg;

> > Why mesg when the existing code uses msg as an abbreviation here?

> Does it matter? I took from spi_finalize_current_message which also uses mesg.

It's particularly visible when it's on the same line, flags up a
question about if things are the same.  Other things not being great
doesn't preclude making this one better.

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1dJIUACgkQJNaLcl1U
h9CzMQf9HnNPDySLqccfz5BLBVZCLMOkkVcR47jnut4j/UXE9Cl0GtNlVZGOkncP
fasOSOPlkY5bjdlscjCnI/cfWyioihIVgad/3oz6yLbjjPoVShvFkYtcDnI1pF+h
9qiT8FoZH/5fSZcMSfBsVYo0pYqAwVFxAnOLhVKlx+1Hs00Z5+VqD8Hkxx8Utwju
hfUtJ5+qWzSb9FeP8shiHTqrvEjd0BCDrx1+cEpbkXPLaGtB5wrOpCba28MUxXLn
8I4KA9kmCTDHI6dEE5FbgVcaf1o3lcunvZiwWXi8xhKht0jaCsTg/3JckTOWlNPk
ScvVb5mG5SMzHea76Z89qyYb47zccw==
=Z8rS
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
