From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: mt7621: Move SPI driver out of staging
Date: Mon, 25 Mar 2019 12:15:26 +0000
Message-ID: <20190325121526.GG7284@sirena.org.uk>
References: <20190314115212.2396-1-sr@denx.de>
 <20190321142550.GG5684@sirena.org.uk>
 <2e3a6928-b086-920c-be6f-9f508af4dc5f@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1329886455439994686=="
Cc: devel@driverdev.osuosl.org, Rob Herring <robh@kernel.org>,
 Sankalp Negi <sankalpnegi2310@gmail.com>, John Crispin <john@phrozen.org>,
 linux-spi@vger.kernel.org, Armando Miraglia <arma2ff0@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, NeilBrown <neil@brown.name>
To: Stefan Roese <sr@denx.de>
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <2e3a6928-b086-920c-be6f-9f508af4dc5f@denx.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org


--===============1329886455439994686==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m0vRWufqUC70IDnR"
Content-Disposition: inline


--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2019 at 03:02:54PM +0100, Stefan Roese wrote:
> On 21.03.19 15:25, Mark Brown wrote:

> > > +	list_for_each_entry(t, &m->transfers, transfer_list)
> > > +		if (t->speed_hz < speed)
> > > +			speed = t->speed_hz;

> > This should be in the core if it's needed, it's going to be the same for
> > all drivers.

> I'm not sure here, other drivers might set the speed individually for
> each "spi_transfer" entry. In this driver its set only once: before
> beginning to transfer all entries. So should I really move this into
> the core and set all speed_hz values to the minimum one of the list?

Oh, I see what it's doing...  the driver should really be setting the
speed per transfer, though in practice I'm not convinced that anything
ever varies within a single message.

--m0vRWufqUC70IDnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyYxl4ACgkQJNaLcl1U
h9C2Jgf9Gzfb7OdM56Gr+AWqOX8Oa0hCbaoCU6dbBl309Y6ReEaakMWm2EQTe1QC
vsdcizApaDuL0KPu7H0VzO9COUiRsgh4YuZPzdi5HXU4WocWLycP61WHDO5oSlmc
oxnENHWQpJ8CGUYJkLPeGV/3RSOuKVzY/Y9pgz0lOSn1a/KKU/KMQRXmIm+Pvavh
IJDlGHuLiu0vALflZdLl9OHpbV4RoxeWinMD2kaKL+NvTLCUS080Fo5kBZqoeqzP
ZsZymSqmQjevnWqAtS2SluI7ReQv3jDu64URBU0jUS8IsSW0EY8tT91Mz5/8YPcX
weqP4JEhEd93gVt9AbfjkhG+duANkg==
=78U1
-----END PGP SIGNATURE-----

--m0vRWufqUC70IDnR--

--===============1329886455439994686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============1329886455439994686==--
