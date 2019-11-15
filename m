From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Date: Fri, 15 Nov 2019 15:22:21 +0000
Message-ID: <20191115152221.GA4210@sirena.co.uk>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
 <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws>
 <20191112191547.GK5195@sirena.co.uk>
 <20191112193653.GB13374@dtor-ws>
 <20191114222652.GA7517@bogus>
 <CAKdAkRQBrKOUTW8puakA26ODYW9=0H4VhwFhGQAqMs-cMmj3CQ@mail.gmail.com>
 <CAL_JsqKUXPTC-fmUowpaHQpuKTfgfQ6D2n7kOZgkYt+MS7OfaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKUXPTC-fmUowpaHQpuKTfgfQ6D2n7kOZgkYt+MS7OfaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 15, 2019 at 07:52:22AM -0600, Rob Herring wrote:

> if:
>   properties:
>     interrupt-names:
>       contains:
>         const: wakeup
>   required:
>     - interrupt-names
> then:
>   required:
>     - wakeup-source

That seems to say that if we have a device that has an interrupt called
"wakeup" then it must be a wakeup source.  Is that desirable?  Being
able to wake the system is partly a property of the system as a whole
(the wakeup signal needs to be wired somewhere where it can wake things)
and a device might have a signal that could be used to wake the system,
may even be called "wakeup" by the device but for some reason isn't
wired suitably in a given system.

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3OwqoACgkQJNaLcl1U
h9AJgQf+JcZQhkga1MGvTU7f3pEsnMjZ9MRBtcDpMdDLrz4o3Vo5OUCODs2E6W0h
T6j+P2IInqE4J74dF0jwwkNyOPuDwezdBKKUsZp+ERNYwF3aP4JeMJusN3AiAaCL
h4KrVXnaiIi3eJoqhmDU3pq8soeITSYSaZ/pSeKlsRw5j5g/NBzkP6GfjlkBuV6p
X1NzocN46iXcB1NRLVVkrbtxx3et1bPGWs0ZJBkVMU07GXY6i4znWUHB5SvEG4mJ
6qWYeNJOCXxsiSLMOYByRSub+xb4c5HvgtMiRMK8nH9x6dzZl0s51tWisJim6O2q
8RSmewbDkUOuvz1SQEVvd/lEqpyAvA==
=GLB9
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
