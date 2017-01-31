From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/3] spi: acpi: Initialize modalias from of_compatible
Date: Tue, 31 Jan 2017 20:17:36 +0000
Message-ID: <20170131201736.cmiyq2obzrhgdsck@sirena.org.uk>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1485187737-22414-1-git-send-email-dan@emutex.com>
 <1485187737-22414-4-git-send-email-dan@emutex.com>
 <CAJZ5v0hAoOQN+d4iBSgSkkYHBOy-Pt9HLrKG4SjcQUB6Ya1bgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uqhxt2ivtecyaxbk"
Cc: Dan O'Donovan <dan@emutex.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hAoOQN+d4iBSgSkkYHBOy-Pt9HLrKG4SjcQUB6Ya1bgA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--uqhxt2ivtecyaxbk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 30, 2017 at 10:41:33AM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 23, 2017 at 5:08 PM, Dan O'Donovan <dan@emutex.com> wrote:

> Mark, any objections here?

I've not looked yet, please allow a reasonable time for review (there
still seemed to be ongoing discussion at the ACPI level).  I continue to
be concerned about the amount of duplication and special casing that the
various firmware paths seem to entail.

--uqhxt2ivtecyaxbk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliQ8N8ACgkQJNaLcl1U
h9Ae4gf+ODDmrMgXV0WdYVGzvVZy6F5RxZfi+DMinN1EPlWkN15P8SdpTtTK0ybg
QNOhnn5VEF716LK+AIGnhiAehYCd9MX9nd5NxqbrI2eZpYYHBK6P1eUxtyzJp1Et
QmcgCz/T63d0I9s2gSPIKnsQxwjRA2db6uiU8xy2DLAMZUcEJZgtOZxPoDvViZ/B
/1/uNP/lfaOUEWO759N36dNYSROzX0JW3k66aB/xzGzGSU7Pd/tiuF+pnrjjoalV
n+jYNzdzrfiTH6ZYDqzt4SSG1xu6f3cIYSx8r3ZYYmZBhMrRmVHP5x9c4Ya7WXHQ
4YfuKff++dPCUBiVvcCGaMPFEzL2bA==
=mvD9
-----END PGP SIGNATURE-----

--uqhxt2ivtecyaxbk--
