From: Greg KH <gregkh@suse.de>
Subject: Re: [spi-devel-general] [PATCH] spi: driver for the Synopsys
	DesignWare SPI controller
Date: Wed, 3 Jun 2009 14:13:13 -0700
Message-ID: <20090603211312.GA5123@suse.de>
References: <1243338914-7811-1-git-send-email-baruch@tkos.co.il> <63386a3d0905271416u4b2cee48k40c12e91e1796f83@mail.gmail.com> <20090531080434.GA16463@jasper.tkos.co.il> <63386a3d0905311227v5bb5c278r306e8ae429e77691@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Baruch Siach <baruch@tkos.co.il>,
	spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756314AbZFCVX3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <63386a3d0905311227v5bb5c278r306e8ae429e77691@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, May 31, 2009 at 09:27:56PM +0200, Linus Walleij wrote:
> 2009/5/31 Baruch Siach <baruch@tkos.co.il>:
>=20
> >> > + =A0 =A0 =A0 r =3D platform_get_resource(dev, IORESOURCE_MEM, 0=
);
> >> > + =A0 =A0 =A0 if (r =3D=3D NULL) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> >>
> >> -ENOENT
> >
> > A quick search in the drivers tree showed no -ENOENT in this situat=
ion. Of the
> > 10 first results of grep -ENODEV is the most popular as follows:
> [The other: 3x -EINVAL one -ENXIO]
>=20
> Wowsers! And I felt -ENOENT was so intuitive, well if I'm going again=
st
> common practice, no good. So let's ask the maintainer of the platform=
 bus
> what shall be returned in this situation:
>=20
> Greg (or some other wise person from linux-kernel) what would you ret=
urn if
> platform_get_resource() returns NULL for an expected resource?

I really have no idea, sorry.

Pick something :)

thanks,

greg k-h
