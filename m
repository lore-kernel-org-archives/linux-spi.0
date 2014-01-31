From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 3/5] spi: sunxi: Add Allwinner A31 SPI
 controller driver
Date: Fri, 31 Jan 2014 23:47:04 +0100
Message-ID: <20140131224704.GI2950@lukather>
References: <1391165752-1819-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391165752-1819-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140131124809.GE22609@sirena.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RHdRtM27np9fZUoh"
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBG6RWCLQKGQEDLBIBWQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140131124809.GE22609-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--RHdRtM27np9fZUoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2014 at 12:48:09PM +0000, Mark Brown wrote:
> On Fri, Jan 31, 2014 at 11:55:50AM +0100, Maxime Ripard wrote:
>=20
> > +	master =3D devm_spi_alloc_master(&pdev->dev, sizeof(struct sun6i_spi)=
);
> > +	if (!master) {
> > +		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
> > +		return -ENOMEM;
> > +	}
>=20
> This now depends on your other series which as I said doesn't look like
> the best approach.

Indeed, I forgot to mention it in the cover letter. My bad.

>=20
> > +	pm_runtime_enable(&pdev->dev);
> > +	if (!pm_runtime_enabled(&pdev->dev)) {
> > +		ret =3D sun6i_spi_runtime_resume(&pdev->dev);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Couldn't resume the device\n");
> > +			return ret;
> > +		}
> > +	}
>=20
> No, as discussed don't do this - notice how other drivers aren't written
> this way either.  Like I said leave the device powered on startup and
> then let it be idled by runtime PM.

Well, some SPI drivers are actually written like that (all the tegra
SPI drivers for example). It's not an excuse, but waking up the device
only to put it back in suspend right away seems kind of
inefficient. Plus, the pm_runtime_idle callback you suggested are
actually calling runtime_idle, while we want to call runtime_suspend.


--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--RHdRtM27np9fZUoh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS7CfoAAoJEBx+YmzsjxAg0tcQAIsQCJpG97ymE6ms+cNXMBnA
dYPjkpfZ0YbI4PoiFc1PLfaR+wiWbFeJaPn4apMAfoRZ6FFgM1jN5qDLfmui6my3
fUnIxeU5f4VExsphF/7MRdbfASzIGRJ9o33bZn1UqcWX4+54/pVB40nSXRoX2pQn
eepkHylLuO4NZhJApXzrB9eOOrzJxtoai7HGSNyiAT/T+HgA3BbPpN+7gGzb81q3
qi9wHA9lryOhQQMmuGdeVWJTgbLMwtxBkbmYhK9OFk5QXKuPcnzpU+0XaRhYSVdO
77hyafL3dX+06NRM0sKwIZEB17gIyQpV1q2RdeV7o3JdxCu1VDMw7VjF0G8TBlXI
JoBbh+XRP9Bx4yxZrnQzI+0vwUOsL0QVYDXX1N7uJ7pkJgUSvn4vaYRGEwyQsz2R
4vDlZJYSZZyMvQoEbqbJIFstMCuegVgfHSUmDjX9j8oM1EAkMSaf7FUN/bWbae3C
uryCMzHElW5AG7LXFdAHk6h0V1GuJtmhN0lin3d61aBOaWMI7PqJbOOqzB/tpFdA
hT/p800S/Jn7Ao1pX8ShM6s2EIM8HgtweeKUiQA/MznUSVg7ol2cE27ojfeDcoJM
Vp7NTIQaohtiBo/CTpu42C8sHa2JcmrNJGNWRxDONEh19byl4iuZtXniU243wrsI
KztbtMoaJNLDBPoIaSQI
=FmH2
-----END PGP SIGNATURE-----

--RHdRtM27np9fZUoh--
