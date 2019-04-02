From: Mark Brown <broonie@kernel.org>
Subject: Re: [BUG] gpiolib: spi chip select legacy support breaks modern chip
 select and whitens the GTA04 LCD panel
Date: Tue, 2 Apr 2019 12:31:43 +0700
Message-ID: <20190402053143.GZ2059@sirena.org.uk>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com>
 <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com>
 <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
 <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com>
 <CACRpkda4k_Vaoo1qEaZ3nv8bA4tcrPEN6oT-v+n9HRdA6=5Xvg@mail.gmail.com>
 <2D2D13C2-0D3E-47CD-946B-81DBBF3C43E6@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f8lmXUvqnCdFQPaI"
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        Wolfgang Ocker <weo@reccoware.de>,
        Jan Kotas <jank@cadence.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2D2D13C2-0D3E-47CD-946B-81DBBF3C43E6@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--f8lmXUvqnCdFQPaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 07:05:35AM +0200, H. Nikolaus Schaller wrote:
> > Am 02.04.2019 um 06:02 schrieb Linus Walleij <linus.walleij@linaro.org>:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> >>> This does not work because there are devices that requires spi-cs-high to be
> >>> respected and the DTS second cell GPIO flag to be ignored.

> >> Then, those should be fixed...

> > This can't be done because some old systems (mostly powerpc)
> > added between 2008-2013 do not know about GPIO flags and
> > have DTBs deployed in firmware that need to keep working.
> > They cannot be fixed.

> The question is if it is even possible to deploy a new kernel
> for such devices and if anyone wants to do...

It's relatively common, especially with older devices, for people to be
perfectly happy to update the kernel and do so frequently but unwilling
to update the bootloader as the procedure for recovering a broken
bootloader is difficult or perhaps not even possible.

> This also gives another idea: make it depend on "powerpc".

That won't fly, the code has always been architecture neutral.

> > Dunno about this, it looks fragile, I would prefer to keep all working.
> > But I will listen to reason.

> Reason why I propose a CONFIG option is:

> if someone is able to compile and deploy a v5.1 kernel for some device which
> has (old) and problematic DTB in ROM he/she must have access to the .config.
> So it is easy to modify it to enable legacy handling of spi-cs-high. And keep
> it disabled for all others.

This assumes people aren't able to run a distro kernel...

--f8lmXUvqnCdFQPaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi878ACgkQJNaLcl1U
h9Dr7gf7BfQONvr81GpZnUgSfuBnJyN72/vNn0cIcsziIvOgxrIzu9l6UlaBidZ/
Xin24wsVrTfpg4nw+cV3fEbZfWIWaymiWo6DqlMA/GF6VIzDm16a1DPVND/u9CU2
2FOFi8C5rWfmQ+GfkIjubFggPKG/VyVGteXgFb1Lqo3JB0OvzoOmThgioO6MaW6A
8F+d5eQiy/eSWg0sMobsQhkEb6z1e2M+XHK3btuQKDF8O4iwsTtoPO56yLrk0PIO
G3a7Uudgn7uN6vbSzT5Wknkjp2ksO6dvb9lydfXvSskfapkvyD/8xJ4I4dj8i/vo
8gUop6f64Uj+QE4x0kfobpnWzPMBqQ==
=Z6Hm
-----END PGP SIGNATURE-----

--f8lmXUvqnCdFQPaI--
