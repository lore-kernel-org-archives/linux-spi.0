From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Fri, 10 Jan 2020 15:12:20 +0000
Message-ID: <20200110151220.GC5889@sirena.org.uk>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4660710561426883816=="
Cc: chenxiang66@hisilicon.com, linux-kernel@vger.kernel.org,
 tudor.ambarus@microchip.com, liusimin4@huawei.com, linuxarm@huawei.com,
 linux-spi@vger.kernel.org, marek.vasut@gmail.com,
 linux-mtd@lists.infradead.org, xuejiancheng@hisilicon.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>, fengsheng5@huawei.com
To: John Garry <john.garry@huawei.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
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


--===============4660710561426883816==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 10, 2020 at 02:58:54PM +0000, John Garry wrote:
> On 10/01/2020 14:07, Mark Brown wrote:
> > On Fri, Jan 10, 2020 at 11:55:37AM +0000, John Garry wrote: >

> > OK, so that's just reusing the DT binding in which case everything
> > that's valid for the DT binding should also be valid for ACPI - I
> > thought that actually worked automatically without you having to do
> > anything in the code but ICBW.

> I thought that it would be improper as we could be mixing ACPI methods to
> describe the serial bus (SPI Serial Bus Connection Resource Descriptor) and
> also DT properties which could conflict, like CS active high.

Yes, that's one of the issues with importing bits of DT into ACPI
unfortunately - you will get conflicts, it's not clear it's a good idea
to be using PRP0001 for SPI stuff given that there's bus level bindings
for both ACPI and SPI and they don't line up exactly.

> However I do see extra properties than "compatible" being added in DSD for
> PRP0001:
> https://patchwork.ozlabs.org/patch/662813/ (see EEPROM part)

> And if we were to do this, I think that we would need to add some
> device_property_read_u32("spi-rx-bus-width", ...), etc calls in the SPI FW
> parsing for ACPI path - I couldn't see that.

You'd need parsing code, yes.

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4YlFQACgkQJNaLcl1U
h9DU0wf/cpuyMTPeqHgaoFffl4krOOM3hfXblBAMhK6+GSCaI+NHD9p+xBGAaDgh
u5+Q4+l4lI6IRJ2N5oJNKdQ/GY4B9H05yQuk2ary3bjM5qqMlWgeZq5aHVVCmti5
mgR3LyAbd93rRX17hhiA7uS04pnikKJYuaS5XHcCZq7uodBz5NZYpt6mskG9uLPA
MySZb/aJ0otKvk0VFNqD1OhEgvEUz//uxDi/WUdfxtW9salpX/iWRQdmfLGM9k0x
JIbDUSkGGygpk5mezausd0nIAhkMifXJcfxffl8l2YomnBq8pQdQtYc3rW+CfFKf
DFTps48PEHxHBrozpUOjXESU39kRpQ==
=9PoE
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--


--===============4660710561426883816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============4660710561426883816==--
