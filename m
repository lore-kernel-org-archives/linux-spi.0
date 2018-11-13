From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] spi: add driver for the SiFive SPI controller
Date: Tue, 13 Nov 2018 14:38:22 -0800
Message-ID: <20181113223822.GN2089@sirena.org.uk>
References: <20181112142736.15009-1-kernel@esmil.dk>
 <20181113183527.GG2089@sirena.org.uk>
 <CANBLGcxF-WgsBVFHf4jGRR+Ox2vz=ewzhwGP1CZX-R5HpDAVBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HxQt9wRz9wbL5Edg"
Cc: linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Emil Renner Berthing <kernel@esmil.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANBLGcxF-WgsBVFHf4jGRR+Ox2vz=ewzhwGP1CZX-R5HpDAVBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--HxQt9wRz9wbL5Edg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2018 at 08:48:43PM +0100, Emil Renner Berthing wrote:
> On Tue, 13 Nov 2018 at 19:35, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Nov 12, 2018 at 03:27:36PM +0100, Emil Renner Berthing wrote:

> > > I know the discussions about the sifive devicetree compatible
> > > strings haven't come to a conclusion, so I'm sending this as
> > > an RFC to get some feedback on the rest of the code.

> > I've not seen any of these discussions or earlier versions of this
> > driver so I've no idea what's going on here :(

> No, sorry. This has been discussed on linux-riscv for other drivers
> like the uart. See my last answer.

> > > +Optional properties:
> > > +- sifive,fifo-depth          : Depth of hardware queues; defaults to 8
> > > +- sifive,max-bits-per-word   : Maximum bits per word; defaults to 8

> > If the hardware isn't fixed yet making these enumerable from the
> > hardware would be good...

> Agreed, but unfortunately this is already in the FU540-C000 chip on
> the HiFive Unleashed board sold by SiFive.

Pick an unused register you can read safely and define that value to the
default :)

> > > +/* for consistency we need this symbol */
> > > +#ifdef REG_FMT
> > > +#undef REG_FMT
> > > +#endif

> > We do?  For consistency with what?

> Below all the register offsets are defined as
> REG_<register name>. This is is a pattern I
> copied from other drivers, but here we have a
> register called "fmt" - hence REG_FMT.
> If you have a better pattern that doesn't clash
> with REG_FMT please let me know.

You shouldn't be using such generic names for your internal identifiers,
add a prefix to everything.

--HxQt9wRz9wbL5Edg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrUlsACgkQJNaLcl1U
h9Dh5Qf/VUw8Ra+KYUjDwFvhBTQ/WLhdXFh/koVtPuDeo/mLnyehCCyuEv/oSrll
0udob665plGSH3CYnEz4V9b5tmNdSJxp07aKox6x89MFVLEX7uvGcKBn3H5fWEs2
DVuySHjWrLqii2wO0CMIfOl36cv98tXKrY266JrfjDcOf8hCb/anRAo3kVpWjWb4
Xsu1swOFX21MIYzQvoSveObgSveQq6uKuvBZMlcBFvCMUVY3Nmz7txmmJybH/2Dt
1i2G85fW+vNQCnQMziZGIEcrZHimx+xUeW3gofnpedoiYMAFcJ90il6N2tGal4HV
791AgaI0CuowfiED5NUNrWxpANZX9A==
=XS6h
-----END PGP SIGNATURE-----

--HxQt9wRz9wbL5Edg--
