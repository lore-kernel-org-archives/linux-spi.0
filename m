From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Mon, 13 Jan 2020 14:06:27 +0000
Message-ID: <20200113140627.GJ3897@sirena.org.uk>
References: <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110193119.GI32742@smile.fi.intel.com>
 <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
 <20200113114256.GH3897@sirena.org.uk>
 <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cN519qCC4CN1mUcX"
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tudor.ambarus@microchip.com, linux-kernel@vger.kernel.org,
        chenxiang66@hisilicon.com, linuxarm@huawei.com,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, xuejiancheng@hisilicon.com,
        fengsheng5@huawei.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, liusimin4@huawei.com
To: John Garry <john.garry@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--cN519qCC4CN1mUcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 01:01:06PM +0000, John Garry wrote:
> On 13/01/2020 11:42, Mark Brown wrote:

> > The idiomatic approach appears to be for individual board vendors
> > to allocate IDs, you do end up with multiple IDs from multiple
> > vendors for the same thing.

> But I am not sure how appropriate that same approach would be for some 3rd
> party memory part which we're simply wiring up on our board. Maybe it is.

It seems to be quite common for Intel reference designs to assign
Intel IDs to non-Intel parts on the board (which is where I
became aware of this practice). =20

> > In general there's not really much standardizaiton for devices,
> > the bindings that do exist aren't really centrally documented and
> > the Windows standard is just to have the basic device
> > registration in the firmware and do all properties based on
> > quirking based on DMI information.

> OK, so there is always DMI. I hoped to avoid this sort of thing in the li=
nux
> driver :)

Yes, there are some merits to an approach like that.

--cN519qCC4CN1mUcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4ceWIACgkQJNaLcl1U
h9BaSQgAhHJyOShaR9eNX0h/1w/gPwom3WJq37NV0iDGPxwM7bufN6CmYlEn2VT5
14DC0ypUzhgmLxSy/+4YjpVoqHfK24ubjJmdQOaYHBDXtUv7C/R+Yg5Rs+SVwwNb
dAL9mO11neDUCRVlJP4Lw3tx8feN0SZeUjX6P0pdx3NQSa/pQSww3ZSwG+PoBgWF
cdwu0JWwvx5k2X5O27NehGYxWXo+alYY3AcVcEsEStyhwpQHYcy8jmE6tP14UI/P
26/o3Nmt4G8zM605sRu9AIJb5eFWtIPOzrisnK0KLkxtbHJfrd/cRrJ2ANSCjVAX
L7YeVR4vNDZ98Wz0z/eg21M6wsb8Vg==
=Mq70
-----END PGP SIGNATURE-----

--cN519qCC4CN1mUcX--
