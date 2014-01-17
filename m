From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: sunxi: Add Allwinner A31 SPI
 controller driver
Date: Fri, 17 Jan 2014 19:05:16 +0000
Message-ID: <20140117190516.GJ17314@sirena.org.uk>
References: <1389892285-11745-1-git-send-email-maxime.ripard@free-electrons.com>
 <1389892285-11745-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140116194003.GN17314@sirena.org.uk>
 <20140116211201.GC3351@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4N29bJelYIMOTi0e"
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBAP64WLAKGQE5VQZS7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140116211201.GC3351@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--4N29bJelYIMOTi0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2014 at 10:12:01PM +0100, Maxime Ripard wrote:
> On Thu, Jan 16, 2014 at 07:40:03PM +0000, Mark Brown wrote:

> > > +	if (status & SUN6I_INT_CTL_RF_OVF) {
> > > +		sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);
> > > +		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_RF_OVF);
> > > +		return IRQ_HANDLED;
> > > +	}

> > This looks like an overflow - a log message would be helpful for users
> > and you should possibly be flagging an error on the current transfer.

> Hmmm, that was an attempt at receiving more bytes than the FIFO can
> handle, but I guess the FIFO full interrupt would be more appropriate
> for this.

If you've got an overflow interrupt that suggests that the data is
already corrupted, assuming the interrupt isn't misnamed.

> > > +	ret = clk_set_rate(sspi->mclk, 100000000);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Couldn't change module clock rate\n");
> > > +		goto err2;
> > > +	}

> > Does this really need to be fatal (or done at all)?  There seems to be
> > another reasonably flexible divider in the IP and it's more common to
> > either set this per transfer to something that rounds nicely or just use
> > the default and rely on the dividers.

> The default parent of the module clock runs at 24MHz, that means that
> we won't be able to reach a spi clock higher than 12MHz, which seems
> quite low. We can always change the rate in the transfer setup code
> though, if needs be.

12MHz is actually quite a common limit for SPI interfaces (half of a
24MHz master clock like the IP itself has) but yeah, you want to go
higher if you can.  Doing it on transfer setup is going to mean that
you save a little power when you don't need the extra speed too.

--4N29bJelYIMOTi0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2X7pAAoJELSic+t+oim9jRAP/0aRl2O0zF6/x7jwr3likhWJ
MFxiMJrtox4TRyRqzYYjDVHaLgCsbwbE1TTdRma9ilBzA2U0+iZ2L5AorgpxxOSh
VrEbWqQdCHp3d9wm49uDBEY7Oni1fvG+1XDj8nPgUdJrF/1o8uptsHsT8hg1nYH+
wAHwYrfhiiaPSvw/dhzAsjatm9H1mYb69JCYxYy4mJvXDtLgxbUX2Xd3zHavTrCY
4dgxA1GANwqwCFaV5BXER6H7SS3mTU17VwMROsv8JlpCkaRebf/CC2roSyLI8yYk
suhUm8Po7jt3P0ubGZJVkGwvBK/jCNmVhTHiA7s1lePcUSZCUgwQgJtzBQaEK3fE
6ZwSKCW1T6F3DMGF98oVGx5+lzzocSN2OBl1jimzrvx4Bd+wKimSSgmdw4GojFEW
WZrXydFadlV24AvLaQBTQqO81UdMx9FxmQRRuji11uK+weygO9usPKBt63MrxbIp
Q3+79RazWmA4e7N/7iFDpGseEBuo5nFhIhQ1XX/q1nGQqvkVlmlqP09YZURi6qIO
TMMSHIKBjanymk1z6l6XllIzhE6w9bvimUuAF6BHDrwuWx/4IvMfxz0pwaUZUsmy
B4RUmLwOxZfjLuI1RdFKA1YURDfjX2jZf6NYlW3cjh1YFK/oQA8arRSd+pb9EILU
1ViQ+KN5ukoJWnQlptAZ
=Mbhr
-----END PGP SIGNATURE-----

--4N29bJelYIMOTi0e--
