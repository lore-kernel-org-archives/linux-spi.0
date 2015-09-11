From: Mark Brown <broonie@kernel.org>
Subject: Re: [LINUX RFC v2 1/4] spi: add support of two chip selects & data
 stripe
Date: Fri, 11 Sep 2015 13:36:44 +0100
Message-ID: <20150911123644.GU12027@sirena.org.uk>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1440570367-22569-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150903121232.GW12027@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3C014B0D67@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4118145437264234143=="
Cc: "marex@denx.de" <marex@denx.de>, Harini Katakam <harinik@xilinx.com>,
 "juhosg@openwrt.org" <juhosg@openwrt.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "zajec5@gmail.com" <zajec5@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Punnaiah Choudary Kalluri <punnaia@xilinx.com>,
 "b32955@freescale.com" <b32955@freescale.com>,
 Michal Simek <michals@xilinx.com>, Soren Brinkmann <sorenb@xilinx.com>,
 "knut.wohlrab@de.bosch.com" <knut.wohlrab@de.bosch.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "ben@decadent.org.uk" <ben@decadent.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "beanhuo@micron.com" <beanhuo@micron.com>
To: Ranjit Abhimanyu Waghmode <ranjit.waghmode@xilinx.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7CFCFE83B8145347A1D424EC939F1C3C014B0D67@XAP-PVEXMBX01.xlnx.xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============4118145437264234143==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6xYB43uKmzPz9Vks"
Content-Disposition: inline


--6xYB43uKmzPz9Vks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2015 at 12:02:21PM +0000, Ranjit Abhimanyu Waghmode wrote:

Please fix your mail client to word wrap within paragraphs and to quote
text without reflowing it - your messages are very hard to read.

> > > +	/* Controller may support more than one chip.
> > > +	 * This flag will enable that feature.
> > > +	 */
> > > +#define SPI_MASTER_BOTH_CS		BIT(8)		/* enable both
> > chips */

> > This isn't saying that the controller supports more than one chip, it's saying that
> > the controller supports asserting more than one chip select at once which isn't
> > the same thing.  I'm also not entirely sure that this makes sense as a separate
> > feature to the data striping one - I'm struggling to think of a way to use this
> > sensibly separately to that.

> If the SPI controller is having more than one chip select and the data lines are distributed equally.
> And also there is requirement to activate all the chip selects in one go.

I'm not sure I understand the above, sorry.  At least not in so far as
how it relates to my concerns, especially the fact that the comment says
this enables support for more than one chip which is obviously a basic
SPI feature.

> Now we can consider following use cases:

> Suppose we need to send the same data to multiple slaves of same kind:
> Here the application need not to do individual slave access for writing, instead it can send data to all the devices in one go.

That's a *very* specific application which will only work for write only
devices - I'd be surprised if such systems actually had distinct chip
select lines at the CPU level.

> Let's take another case where application is trying to send data in such a way that first nibble of the byte will got to the one slave and the second nibble of the byte will go to the other slave:
> Here data in slave devices can be organized by taking advantage of above topology along with the support in hardware.

But do such devices actually exist?  I can imagine systems that might be
able to do that but I'd be very surprised to see anyone practically
designing them, they're going to be quite hard to use.

--6xYB43uKmzPz9Vks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8srbAAoJECTWi3JdVIfQKV0IAIYnFyMNEwRSV8ipMno8H5mV
CSLkkClaKIX1akfHdpUtAJesZQQHjDtMh7HGKM8YrTePbs++6Xo0NT9wCoIk7c/K
ussnNoOSBD3O9t2kn2jXjuCugQPntLz1lKD2H2+M9ZIG9yiaZjlaLXj8kDMN8x/K
E8CjkoC9KRRdpqhWcziTkuCFVZStWlCyceOeDRg6gPTb0+g+Y5WdwPhEzSUDepxy
G/X8aFFxDN5yojbwbUPhOp6DxU3hYFoqbBo86kwoiaNRj0GGwz8gy8bkE8BqTy1s
GV3/2aLu/rYBP46bTcED+tzY+at2tJu5D8rFM3+Xv4xoTNeImDjfMkBcd3grMj0=
=qBbK
-----END PGP SIGNATURE-----

--6xYB43uKmzPz9Vks--


--===============4118145437264234143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4118145437264234143==--
