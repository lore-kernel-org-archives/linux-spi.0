From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 3/4] spi/xilinx: Simplify irq allocation
Date: Mon, 8 Jul 2013 17:26:42 +0100
Message-ID: <20130708162642.GM27646@sirena.org.uk>
References: <ff70173bee5f9223ffea2b92b903b4e46ef8b323.1373290150.git.michal.simek@xilinx.com>
 <b4458c93742bd9dfe69e3553cf377a703c945f81.1373290150.git.michal.simek@xilinx.com>
 <20130708144930.GG27646@sirena.org.uk>
 <51DADF3E.1000802@monstr.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hx9R4F7eQNhw7Y0Z"
Cc: Michal Simek <michal.simek@xilinx.com>,
	linux-kernel@vger.kernel.org,
	linux-spi <linux-spi@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	spi-devel-general@lists.sourceforge.net
To: Michal Simek <monstr@monstr.eu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51DADF3E.1000802@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Hx9R4F7eQNhw7Y0Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2013 at 05:48:14PM +0200, Michal Simek wrote:
> On 07/08/2013 04:49 PM, Mark Brown wrote:

> > Is it definitely safe to leave the IRQ hanging around after the master
> > has been freed - there's no possibility of a late error interrupt or
> > something?

> I think it is more generic question if this race condition is fine
> for all drivers which are using devres groups.

Well, it's mainly an issue for IRQs - the other resources don't initiate
events by themselves which is what causes the issue.  It just needs a
bit of extra care so I wanted to check that this has been thought of.

> I have just looked at it and devres_release_all() is called where
> driver is unload and irq are disabled there.

The problem is the gap between the resources used to handle the IRQ
being freed and the IRQ itself being freed - if the hardware can be
guaranteed to be idle then that's fine but we need to be sure that is
OK.  Otherwise the interrupt handler may get run and be looking at a
resource which was freed which would be unfortunate.

> btw: What's the proper way for spi driver unregistration?

> spi_unregistered_master() (which also free private structure)
> and
> spi_master_put()?

Yes.

--Hx9R4F7eQNhw7Y0Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR2ug6AAoJELSic+t+oim9sSsP/iTf8C79MeNgA9J0J6U/ylSj
y5DS61VGjF9p34TlPpGoFRacgPDd1ghtiPo5KtaK6SUoS+lCcSGWOR/Xxo9uxJ/5
TIR48FIm6Y9mBx0IBJ7i2CNymn0duVpbIJM+VywVEtSGCX3+qSWvQGGGcGx3ZGAn
A3tLuwN6GT6bhd/ClqpR/dv/YQj0dppbTjAZhf39QrrvMCFSnANg944yTDTFrn/t
UN/BFaLcXEF+n9txLspH5bYzpKQ1fMXg3QyfV0KTFX4hNtqnEfGEPpsK1QC5kFNX
XZadqgnf+zepl1RzTM3isBElA4yCMwp3p4xqW+TZt3u6XfcisDe62FJig2rRFn4h
jWCjG7Tjsr15wGSZ4GARdze5maGSq6UZVaVBC26sfzBlyhHkkLpncDTo9I4nOsDP
eb2cUJn7uAq7YpjEbF8AQXnlXW8AmTUSHLW83PaR7Msy3E3z3CXACBJMd5yhXsez
Tix+bQQQBiW/s+S7MLcev5fLCs12dcnwfm6oI1b7gEp5NP4lRDnjHAwZQ3bhy+py
j3wTSERMhDDsFEgA+9d58aFzw/Qcbs0yIdBfSkm0HNTob03Ba3qRpJztFkEke2ZG
OJK/VTPgL0tDBW7yKQ/ypCYqTGuwVFoTh3L9FHXybLZa8MT6B4tb2VDcY0kuS9Ny
JysYW+H31XrmVu6MqtbZ
=kyd8
-----END PGP SIGNATURE-----

--Hx9R4F7eQNhw7Y0Z--
