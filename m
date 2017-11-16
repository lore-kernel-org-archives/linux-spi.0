From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Thu, 16 Nov 2017 12:41:54 +0000
Message-ID: <20171116124154.allayndu467osija@sirena.org.uk>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <2771c4a8-ed85-86c1-a08c-5b62d177b107@caviumnetworks.com>
 <CAJ+vNU0rsabjK80zmq_QBhPQqru2A06n8+zgEPvWfHdyb-kbMQ@mail.gmail.com>
 <CAJ+vNU0qkXafz8FWjM_TCYj56dv31=ZQ306Ab2qSsePGD6E6KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wrx5em3kndhgexha"
Cc: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
        Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>,
        Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0qkXafz8FWjM_TCYj56dv31=ZQ306Ab2qSsePGD6E6KQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wrx5em3kndhgexha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2017 at 03:18:59PM -0800, Tim Harvey wrote:

> I could re-write the mcp251x driver to not use full-duplex but I'm
> assuming most SPI drivers use full-duplex transactions.

I'd not actually say that's the case - the bulk of devices do some kind
of command/response or register/value thing, full duplex is moderately
complex to work with and ends up needing a constant data stream between
the two devices.  It does happen (and some controllers always transfer
data in both directions) but most of the time only one direction has any
meaning.

--wrx5em3kndhgexha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloNh5EACgkQJNaLcl1U
h9Da2Af7BYjQ+bKMTeasW5rrEisjhoFUMwCiEoATF1yBBna4VS/o5JFTOTA5k0Uo
8GmUDGbRB5j08bfir7MHQMPz55O+JE8YlNoqcXGaQpSDEhz2VuGz21YJlTngmiRN
n4FgnpUzdSWW0sP9BioBKhNZdyyCI05TynaULrkjT5rgxG7eD5pu5Yl6NN9E+mw5
5Ndn65yYVrDCuJvVT6DfyetdeGp+F1xXdQu8uN+RrDrrSgPyVDSYHJoV0dYbuEWT
yaZSGq4ubD3dH1c4M1aoZRl5/ap08on5gJ5SpDq2M0JD1ipGsLPx+1NueJA6U90w
tzPFe8c9AlwJxFzp9lkWVciqPMSmoA==
=a7pv
-----END PGP SIGNATURE-----

--wrx5em3kndhgexha--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
