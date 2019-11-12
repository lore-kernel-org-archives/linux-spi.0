From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Date: Tue, 12 Nov 2019 12:03:07 +0000
Message-ID: <20191112120307.GB5195@sirena.co.uk>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112055412.192675-2-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2019 at 09:54:10PM -0800, Dmitry Torokhov wrote:

> +      interrupts:
> +        items:
> +          - description: main interrupt (attention) line.
> +          - description: dedicated wakeup interrupt.
> +        minItems: 1 # The wakeup interrupt is optional.
> +        description:
> +          Specifies interrupt lines a device is connected to. Typically a
> +          device is wired to a single interrupt line that is used as
> +          "attention" signal and also to wake up system when device is
> +          set up as wakeup source. However on some systems a dedicated
> +          wakeup line might be used.

> +      interrupt-names:
> +        items:
> +          - const: irq
> +          - const: wakeup
> +        minItems: 1

How will this interact with a SPI device that defines interrupts at the
device level, possibly more than one of them?  Especially if the device
has its own idea what the interrupts should be called.

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3Kn3oACgkQJNaLcl1U
h9BxwQf9ECv4xZZXn5i2YxaBGMMCIQQ7dBHBaf+RX9PyyxRVwrhqaJb0Bn/Q2jfX
SUx5ocQAvXxWnQfWzcG/i6CsMSbwO5sRJhofRLcU2picVhHROMiYrjNcuXJD77SE
/te7BqRLAXWPCjR3Hi1KGnDLFa347byoeW2WV3txN7SWSKssa43NooJ2E/ahyeKY
nRiz2uivJ6utzuXNjwK6PdQtX+KboYNp3AgwbTBL0kDhLtwNPLoPUb76im4lYqvt
UVj3XRXlLxL1sVpy7Z6IUKezWxiCOUMl3winPd7gxZNgvyCz6dKnIFqtDc//cikO
GWsgGR1j7SZ92kVg0pEvgUNrr8X/iA==
=kE98
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
