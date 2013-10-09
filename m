From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Wed, 9 Oct 2013 18:40:27 +0100
Message-ID: <20131009174027.GS21581@sirena.org.uk>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
 <1381332284-21822-2-git-send-email-sourav.poddar@ti.com>
 <20131009160759.GQ21581@sirena.org.uk> <52558A49.5090904@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7251553055786746963=="
Cc: spi-devel-general@lists.sourceforge.net, computersforpeace@gmail.com,
 dwmw2@infradead.org, balbi@ti.com, linux-mtd@lists.infradead.org
To: Sourav Poddar <sourav.poddar@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <52558A49.5090904@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============7251553055786746963==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z/sVsid6FAeSo6rY"
Content-Disposition: inline


--Z/sVsid6FAeSo6rY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2013 at 10:24:33PM +0530, Sourav Poddar wrote:

> Here is the exact feature usecase..
> TI qspi controller supports memory mapped read. These memory
> mapped read configuration depends on the set_up_register, which
> can be configured once during in setup apis based on the dt node
> specifying whether the qspi controller supports memory mapped read
> or not.

What is "set_up_register"?

> Once, the qspi controller is configured for a memory mapped read, the qspi
> controller does not depend on the flash command that comes from the
> mtd layer.
> Because, this command are already configured in QSPI set up register.

So this does depend on the flash commands for the specific chip, which
means that this has all the same problems as the Freescale chip had with
requiring the user to replicate the information about the commands that
the chip supports into the device tree.  It therefore seems like all the
same concerns should apply, though in this case it seems like it's
harder for the driver to infer things from looking at the operations
being sent to it.

Presumably this also only works for flash chips, or things that look
like them...

> Basically, its not the commands which need to be communicated from
> the mtd layer,its just
> the buffer to fill, len of buffer, offset from where to fill need to
> be communicated.

This appears to be based on an assumption that the commands would be
replicated into the device trees which seems like it's both more work
for users and harder to deploy.

> >I'm also concerned about the interface here, it looks like this is being
> >made visible to SPI devices (via a dependency on patch 3/3...) but only
> >as a flag they can set - how would devices know to enable this and why
> >would they want to avoid it?

> Set  spi->mode in qspi driver based on dt entry and use that in mtd layer to
> decide whether to use memory mapped or not.

But why would anything not want to use memory mapped mode if it can and
why is this something that should be hard coded into the device tree?
Especially with the current API...

> The idea is whenever, we call mtd_read api from mtd layer, if memory
> mapped is set
> then sending the commands does not matter, what matters is the len
> to read, buffer to fill and
> "from" offset to read. Then, the intention was to use the memory_map
> transfer parameter to
> communicate to the driver that memory mapped read is used so that we
> can just use memcopy and
> return without going through the entire SPI based xfer function.

I'm not convinced that this is the most useful API, it sounds like the
hardware can "memory map" the entire flash chip so the whole SPI
framework seems like overhead.

It also seems seems like it's going to involve the CPU being stalled
waiting for reads to complete instead of asking the SPI controller to
DMA the data to RAM and allowing the CPU to get on with other things -
replacing the explicit transmission of commands with memory to memory
DMAs might be advantageous but replacing DMA with memcpy() would need
numbers to show that it was a win.

--Z/sVsid6FAeSo6rY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVZUHAAoJELSic+t+oim9bxIQAIffxzM72hshn4rPXakakCO1
L7PP/acdt5q0meZbsFp2vrXC3ID826YinbbQ7V92CqnzDyhWsoHRwJeJCJMUZJIk
3I3qAUv8HC5iO2v7mvOygGxmrkJmbGQ8aIit9pNdGZQZfu5AXxYbWDHSvit2ST6I
oeZP8fBfP6BThfYueIbWrSF2iBTF3vPR0ZFgm7/Q3Z+Y5M9I3KLIQXnF7DCAAZXT
wGnMvWw+WnE4Bvd50mwYV+n2Bd370voEDUr1bcjORySWG1+71iN9P09RmHYJLvut
pdgCY1W4wjoEQr/g39vhT3MhWKFxEo+nFbLw0JfoSyxPsEP1I2AZdP2mUyuY8gLE
n/ZOaXKbkivKxhLvRARzkYeHdeV7YAjDQZNKO5HRO88fZ7eNac5ROwOZrOJlIhYE
ofUeIoglwBoFu4t5M+fZeZqEJzoOc3fKAnnrV8weLW0oWSbDkuRrlgFJKWzLXTMw
f70Bn8rOQKXffnFR2J8efQfX3LzvZULSjrt4347RsMgLcy+9P7gH89NHiCFsZV6R
R8v7q2KQngaUzLvsVm5jhp3o+pI3I8Yc4+HGLG4w5XS0SwjSrvkC0Z+kRmN3+2Sy
PY+IUlfqHnyGk7Tn2fT3egwpKFl5kgmbphllDo/cIepoUesQO+HuUsTluqo5iZwg
iIZWn+POrhm6eUOAlDV2
=Jfod
-----END PGP SIGNATURE-----

--Z/sVsid6FAeSo6rY--


--===============7251553055786746963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============7251553055786746963==--
