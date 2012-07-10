From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 5/6] spi: s3c64xx: Remove the 'set_level' callback
 from controller data
Date: Tue, 10 Jul 2012 17:57:17 +0100
Message-ID: <20120710165716.GJ10022@opensource.wolfsonmicro.com>
References: <1341930459-25223-1-git-send-email-thomas.abraham@linaro.org>
 <1341930459-25223-6-git-send-email-thomas.abraham@linaro.org>
 <20120710143844.GB11698@sirena.org.uk>
 <CAJuYYwQ4wio0CxPAVaNBoD7=vMgUS0CCZB45aSst-DW2zOTn1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, jaswinder.singh@linaro.org,
	kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwQ4wio0CxPAVaNBoD7=vMgUS0CCZB45aSst-DW2zOTn1w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 10, 2012 at 10:22:31PM +0530, Thomas Abraham wrote:

> In non-dt case, the platform code supplying the gpio number (slave
> select line) is responsible for requesting the gpio during the
> machine_init call. So the gpio request is not called in the driver for
> that gpio. In dt case, the 6th patch adds dt support and that patch
> includes a gpio request call. Hence, this looks okay to me. Please
> suggest if you still feel that there are changes required.

That's not really particularly sensible given that the changes remove
the option to use anything except GPIOs, the GPIO request should be done
unconditionally in the driver now.

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/F6jAAoJEBus8iNuMP3dQn8P/jBYPIlJEpTyMG5hgjaP3WMk
owScmDXwLG4aCfg86WtaarzHWp/N3OiBJIfcGwTfzz/TWhdnHch4kS/Z6b/NqLxZ
EFCpaSb8eMeBE6QBC+5+iQyYaZQA93p3KmHr8dmlqfCsRj7MMC85eSus+30bAlzA
QZp4qj+hrfeAcazXdbuIIp26nW4HoOcSuFcVqaFbSLGSWjGXWnt/KfO+11EyYGz8
u6MqXGiEt00taQyd0bqdFL/dLG54TCCzFb9p1AFNqYUFmX9GSivLvycl1DkEKIky
eO0wjQDrON33CfJ1MJAqSy299kUbGOKigGdXg/dt0GwZc9iB9v40LnWY7PbCD8+Y
T/0Y99s0MXutstpxPi40dWCCfu9I6NrTF1XsWL53oUDmNTaAsHe0OllhG7/sN3kG
nvIvrDxESYlR5sKQFIlc0OxfGQHGD+9f1AI9VdTff84AsDGP5vkYp3frpnRF4FFX
wPTdGpCfhhnX5hmtdPmTpbxQ4M5ctp1/+Wc68a+OIcJasOVVbRV8Fc1/7muDPvQp
H+5SybPNnIbI1LcpRQjhoCtE3HiaFbkVNMLPZEql/Y3MMTx1ewX/ii7hEqfUwPjg
yT/d6DKA+zOZJw9T6jlO5hJeaN9qXHDEfFcWTOElszV/ZvHxUm+r0wl/uCu2bLrz
pJOeWDFKZP3pjYzqyJu6
=f3cR
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--
