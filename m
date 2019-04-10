From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Date: Wed, 10 Apr 2019 12:54:31 +0100
Message-ID: <20190410115431.GO6106@sirena.org.uk>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
 <20190410103250.GF6106@sirena.org.uk>
 <a7237e949bb643d5b49ccc5ae241bbb9@asem.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3snK74p7ddXn3Qrx"
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Flavio Suligoi <f.suligoi@asem.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a7237e949bb643d5b49ccc5ae241bbb9@asem.it>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--3snK74p7ddXn3Qrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 11:47:43AM +0000, Flavio Suligoi wrote:

> You have right about to avoid too many boot messages,
> but in this case, using an x86 machine and with
> the spi-pxa2xx in DMA mode, so without the message:=20

> "no DMA channels available, using PIO",

> there is absolutely no indication about the existence
> of the SPI master controller.

It's totally fine to not have a boot print for the device, the best way
to find devices if you need them is to look in sysfs anyway.

> The second reason is about the DMA/PIO mode indication.=20
> With the board I'm using, sometimes the spi-pxa2xx driver can't allocate
> a DMA channel and works in PIO mode.

> So, with the advice of Jarkko, I think that a valid solution could be:

> 1) remove the "no DMA channels available, using PIO" message
> 2) add a new message with the indications of:
> 	- controller mode (slave or master)
> 	- transfer mode (DMA or PIO)

> What do you think about this?

If the system is randomly failing to assign a DMA channel when it should
then shouldn't we just fix that?  A print which is presumably intended
to prompt the user to reboot to try to get things working doesn't seem
like a good solution.

--3snK74p7ddXn3Qrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyt2XYACgkQJNaLcl1U
h9D4swf9FQN1Ra4YLunh8c9Ja8dvSdcqUjDUKfRd3Ja7N+6V7epHSWIHnYAOirf6
UCPHczZoUJc8o5kNvW2191qGCCT6lmD4imvWsWVaO/LbpwJAgW7XEezV7nFQVSKV
IEshtWiWDpUS1AMxBQAdmMFv4iKaeNddlJqn2bIhb0K2AXOsw8xy1DOyma/zP6XT
T4hP/VO3Y5Jwn2hmGTz8hJaixRawaJ4R1ny2WC6xP+Mq20E7adpSe/R/ubRNP7A9
TKajLyvFz1E8QTAud0BtBQusL+0E9rVqbE/l3YV2S0s6Ilo+hWxglmU4jjmdUVxh
w+HyRCfALV2XF9KG06PyfzEONSoleg==
=32Ct
-----END PGP SIGNATURE-----

--3snK74p7ddXn3Qrx--
