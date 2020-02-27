From: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] spi: dt-bindings: spi-controller: Fix #address-cells for
 slave mode
Date: Thu, 27 Feb 2020 15:16:49 +0100
Message-ID: <20200227141649.ji6js7vhlrltpn6z@gilmour.lan>
References: <20200227130323.15327-1-geert+renesas@glider.be>
 <20200227130937.qvrjyxcwim7rfum7@gilmour.lan>
 <CAMuHMdUVW_51dqMK=ziz_JVT3LuXX7vOF3-Ei-aHiiBuSepGpg@mail.gmail.com>
 <20200227135109.l2oal55nwhm5un2c@gilmour.lan>
 <CAMuHMdWYF9RrLdkuK_PxfVqocUMHVKPpjnyc4FR+N69A_htdyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ikzzwflzmxk3qkj"
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-renesas <linux-renesas-soc@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWYF9RrLdkuK_PxfVqocUMHVKPpjnyc4FR+N69A_htdyQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--4ikzzwflzmxk3qkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 03:05:56PM +0100, Geert Uytterhoeven wrote:
> Hi Maxime,
>
> On Thu, Feb 27, 2020 at 2:51 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > On Thu, Feb 27, 2020 at 02:19:08PM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Feb 27, 2020 at 2:09 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > On Thu, Feb 27, 2020 at 02:03:23PM +0100, Geert Uytterhoeven wrote:
> > > > > Currently, the DT bindings for an SPI controller specify that
> > > > > "#address-cells" must be fixed to one.  However, that applies to an SPI
> > > > > controller in master mode only.  When running in SPI slave mode,
> > > > > "#address-cells" should be zero.
> > > > >
> > > > > Fix this making the value of "#address-cells" dependent on the presence
> > > > > of "spi-slave".
> > > > >
> > > > > Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
> > > > > Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > > > --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > > > > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > >
> > > > > @@ -52,6 +53,18 @@ properties:
> > > > >      description:
> > > > >        The SPI controller acts as a slave, instead of a master.
> > > > >
> > > > > +if:
> > > > > +  required:
> > > > > +    [ spi-slave ]
> > > >
> > > > Nit: Usually, that notation is when you would do it on the same line,
> > > > if you want to go to a new line, it would make more sense to use -
> > >
> > > Sorry, being a poor yaml-by-example programmer, I don't understand what
> > > you mean.  Which part do you refer to by "that notation"?
> >
> > I meant that usually the [] notation is used over a single line.
> >
> > If you want to have a list over multiple lines, usually you would have
> >
> > required:
> >   - spi-slave
>
> IC. So I can also write:
>
>     if:
>       required: [ spi-slave ]
>     else:
>       ...
>
> which is even shorter ;-)
>
> Both seem to work fine.

The rest of the file uses the multi-line syntax, so I wouldn't do it
for consistency, but yeah, they are equivalent.

Maxime

--4ikzzwflzmxk3qkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlfPUQAKCRDj7w1vZxhR
xY1qAP9+J6ACEBSld2cNlgZ1np5JgE8toqkBz6bP/lxYW++O/gD+PkQQrYz3Ck0E
pEtc4jLlxTZ04DThtUQDRRkGaY5KMgA=
=hUDK
-----END PGP SIGNATURE-----

--4ikzzwflzmxk3qkj--
