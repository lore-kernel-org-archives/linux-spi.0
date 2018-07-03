From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Date: Tue, 3 Jul 2018 16:31:37 +0100
Message-ID: <20180703153137.GB13744@sirena.org.uk>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2710504223641520439=="
Cc: Steve deRosier <derosier@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Jiri Pirko <jiri@resnulli.us>, Ben Whitten <ben.whitten@lairdtech.com>,
 netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Dollar Chen <dollar.chen@wtmec.com>, linux-kernel@vger.kernel.org,
 Michael =?iso-8859-1?Q?R=F6der?= <michael.roeder@avnet.eu>,
 Janus Piwek <jpiwek@arroweurope.com>, linux-spi@vger.kernel.org,
 LoRa_Community_Support@semtech.com, Jian-Hong Pan <starnight@g.ncu.edu.tw>,
 Ken Yu <ken.yu@rakwireless.com>, "David S . Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
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


--===============2710504223641520439==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 05:09:38PM +0200, Andreas F=E4rber wrote:
> Am 03.07.2018 um 16:50 schrieb Mark Brown:

> >> 2) This SPI device is in turn exposing the two SPI masters that you
> >> already found below, and I didn't see a sane way to split that code out
> >> into drivers/spi/, so it's in drivers/net/lora/ here - has there been
> >> any precedence either way?

> > A MFD?

> I know of mfd, but how would the the the net vs. spi pieces interact
> then? Some functions would need to be exported then or is there an
> easier way without needing to set a cross-module API in stone?

It's an in-kernel ABI it's not exactly set in stone but yeah, you'll
need some interface.  A lot of devices work by having the children know
that they're part of a MFD and fish things out of the parent device,
either the pdata or (in the common case where the MFD bit mostly just
instantiates subdevices and holds a regmap) with dev_get_regmap().

> > A register map would work just as well here, we already have plenty of
> > devices that abstract at this level (most obviously the I2C/SPI devices
> > that use it to offer both interfaces with a single core driver).

> The address and data registers together form a two-byte SPI message!

> It is transmitted by writing to the CS register.

> The received data is afterwards available in another register.

Right, but it seems from the code that the hardware understands that
it's formatting register I/O and not just shifting in and out a byte
stream which is what a SPI controller does.  I'd not be surprised to
learn that the register you're calling a chip select register is a
strobe that initiates the transfer (and that this may be some of the
difficulty you're having with handling it in the way the framework
expects), the pattern with writing 1 followed immediately by 0 is a bit
of a flag here.

I've seen such before hardware where I know it was intentionally
designed that way so it wouldn't be totally surprising.

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls7ltkACgkQJNaLcl1U
h9A+lwf+M8MTt6KWaR4J9ViDILdK0W8JxGgJ2Glb/wXPZ7TDowwt6N0oQs8Cg8cZ
ch1D/dW0vBuW/NmvFtarbcfqAEJCIlL9oFovgMTao6RLZTc1L2unzKifbtTzUhHo
bqUXZA5ubjQuwESRbbd5C9PM2HSMfXKn2BrvvLYz9FyYMRlGVJf9oom8vGzYBo/t
DbMe/c4o+Tw7golyzKKraTTV61DAtXeaT0wgYLKR5iB/sPtViqn9LombTM7tyQxi
Oi3SLV/Q838Bpk+fwQEXfRzSVO073z9+46kpG4lg11xzf9WT9lOq6e2qrtOgsCVy
FEW068wwEBTdALjHWYCx3DUkN4prIQ==
=Dyei
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--


--===============2710504223641520439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2710504223641520439==--
