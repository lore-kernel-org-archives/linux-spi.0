From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Mon, 13 Jan 2020 11:42:56 +0000
Message-ID: <20200113114256.GH3897@sirena.org.uk>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110193119.GI32742@smile.fi.intel.com>
 <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4614124441640753303=="
Cc: chenxiang66@hisilicon.com, linux-kernel@vger.kernel.org,
 tudor.ambarus@microchip.com, liusimin4@huawei.com, linuxarm@huawei.com,
 linux-spi@vger.kernel.org, marek.vasut@gmail.com,
 linux-mtd@lists.infradead.org, xuejiancheng@hisilicon.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>, fengsheng5@huawei.com
To: John Garry <john.garry@huawei.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============4614124441640753303==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X+8siUETKMkW99st"
Content-Disposition: inline


--X+8siUETKMkW99st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 13, 2020 at 10:09:27AM +0000, John Garry wrote:
> On 10/01/2020 19:31, Andy Shevchenko wrote:

> > PRP method is only for vendors to *test* the hardware in ACPI environment.
> > The proper method is to allocate correct ACPI ID.

> Yes, that would seem the proper thing to do. So the SPI NOR driver is based
> on micron m25p80 and compatible string is "jedec,spi-nor", so I don't know
> who should or would do this registration.

The idiomatic approach appears to be for individual board vendors
to allocate IDs, you do end up with multiple IDs from multiple
vendors for the same thing.

> BTW, Do any of these sensors you mention have any ACPI standardization?

In general there's not really much standardizaiton for devices,
the bindings that do exist aren't really centrally documented and
the Windows standard is just to have the basic device
registration in the firmware and do all properties based on
quirking based on DMI information.

--X+8siUETKMkW99st
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4cV8AACgkQJNaLcl1U
h9C/cAf/f3KqQoM3kgbWl0MgRMi2T0mY02dvLgcINSfWU08s8WPRzo3zWZ+2Bnwy
EtoOy7yu9z4hC9RVNYaA3/FibeE10MJHizzwRnxzzxmu3MjPDixmON8GO+hsKPd6
DYhpptH+23ceLUX3O7l8v34vvslFYKaUeSJkTlCR0OxxEkTCxwnWnWo/wKBYTRer
T58Cj6e/WnAl2qZ4Yl4qJF2TpNTC7T5tHki/I72eEZfiaNylIKxERV27zddbrgHE
dyOKFqftALoJvu2cf/ddKpXKNt1ceMDNGhu3bIBJuoSdYAedtvWRs9TPRigY5bvZ
IiypAujroXyiqSqmQq+3FBBNH9tTXw==
=w5W/
-----END PGP SIGNATURE-----

--X+8siUETKMkW99st--


--===============4614124441640753303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============4614124441640753303==--
