From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Wed, 6 Nov 2013 08:21:41 +0000
Message-ID: <20131106082141.GA11602@sirena.org.uk>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
 <6043727.WVyVGYjJys@amdc1227>
 <CAPs=JDcVXpJJnWxRFpq7aoW98LKmHq0jo-oTVqSUasnO_1My3g@mail.gmail.com>
 <1586287.qm633XfQbK@amdc1227>
 <CAPs=JDcHVe4q7R-3f3SBu8g=Ebkz57AbPN8e2jspVTGYnZ1vqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Cc: Tomasz Figa <t.figa@samsung.com>,
	Rajeshwari S Shinde <rajeshwari.s@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	linux-spi@vger.kernel.org, Simon Glass <sjg@chromium.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Doug Anderson <dianders@google.com>
To: Rajeshwari Birje <rajeshwari.birje@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPs=JDcHVe4q7R-3f3SBu8g=Ebkz57AbPN8e2jspVTGYnZ1vqA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2013 at 10:23:07AM +0530, Rajeshwari Birje wrote:
> On Thu, Oct 31, 2013 at 6:07 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> > The driver as of today's linux-next does not seem to support word
> > transfers. Do you have some additional, out of tree patches that add
> > such support?

> Yes I set the bits_per_word to 32/16 in drivers/mtd/devices/m25p80.c
> m25p_probe function and the call spi_setup(spi).

This sound wrong.  If you just set bits per word then this should result
in data corruption on the bus since it should cause the words written to
the bus to be reordered.  Are you sure that the existing driver isn't
working correctly?

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSefwLAAoJELSic+t+oim9sB4P+wT52GwvmnhwIZbnQ01GKGK8
3XjdI2DA0AdHiYfOU49qNNGfbrgnY6zbGX9900a5dXZphYW2L6M32VEREarCnXhI
zDK8fFOdqrSXZO31RtYNMU0fFmw1EiRw98jn6Jr/8Ty496h+IE0XgUn8ncsJmbzu
C1hq5EVSzL9YLvvqgiYuhqiqlq4EHVYzhcOaLnWw7ezVh8fWk9r24pgZVU6miG0W
K0rNed9JZL888nRJuadc5vSB8CqP4c+0m/iobVL66ZJsW6RDaAOs2gNit8seefRY
Dt9QS05soMDYUNqSm+Ud5I2WxilKbUasbTBYyJNOIk7WSGI1/7Jv33wqJt7bKiLG
SYDnEPFSeJb8TcQVL8IoGR6Q8Nkjw1j72nXHfZBGbyCmuQH7DPvGhWzNemZDf40N
9qE+TsOQmhGEn+hEsoWcFLNUP9t2/fpm3/F5Yh9kyyIiJQC1rqqXdwOxxAAzlghc
3qsma5iTPkk9IsH8unlKHFkDUDjj5hZ6hxyPVVssGCr5gLEK2fhrDnF72rhQIs+6
kFZCPc2bMCnaRu3OzZDCNddXeJcZMUIb29HxNKvMnbjyz5rAWy9QJpUR/R53WJpo
HX/YlIAnDJwpMzvrwCU6j7crf6dfixIiCJ8nZsi8a3YKzXcWOYIZJlbNh6e0u3A0
Ee4jbmgmNw6j94BrkIqp
=YkId
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
