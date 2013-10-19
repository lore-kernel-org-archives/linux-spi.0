From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Sat, 19 Oct 2013 21:04:47 +0100
Message-ID: <20131019200447.GF2443@sirena.org.uk>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
 <20131019162504.GA1863@sirena.org.uk>
 <CAPnjgZ1A335KstnpTRwpxEbBArtqh1sYSPQJBw6LX5zUeptpfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FxX07ZGw9of/ANg3"
Cc: Rajeshwari S Shinde <rajeshwari.s@samsung.com>,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	ALIM AKHTAR <alim.akhtar@samsung.com>,
	Doug Anderson <dianders@google.com>, t.figa@samsung.com
To: Simon Glass <sjg@chromium.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1A335KstnpTRwpxEbBArtqh1sYSPQJBw6LX5zUeptpfA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--FxX07ZGw9of/ANg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 19, 2013 at 10:58:47AM -0600, Simon Glass wrote:

> If it helps, patman (tools/patman in U-Boot tree) will strip this
> automatically (along with other Gerrit and Chrome OS stuff), run checkpatch
> and Doug has added features to automatically cc the relevant maintainers
> for Linux. I got sick of trying to remember to do all these steps.

Watch out for the automatic identification of MAINTAINERS though - you
do need to pay attention to what gets set and check it, get_maintainers
isn't 100% reliable.  You should check what it does and make sure you
understand why each person there is getting CCed.

--FxX07ZGw9of/ANg3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYuXcAAoJELSic+t+oim9qnYP/3G9u/iv38TCTyvJ2rKeGftG
dd9NRvZwVOK9Q06rcPVOSH2ct37VU/yiNJ0ULiMo7H43k9OinJSQsBQaNU7u+7Tf
4fkg9l9fb+m+o7Uq8wUcsRflGt8hIZEACg/gBWIFgDnsR8lvYAIYsyGgpipapUmT
Y2uIr6HVhy1NrHZSgjTdtQCkQKKXpSc0QCaUjcu+e7xWwlB/cGQVQ0DBgGRKo5bp
X/JdLW2vz8gDI8k+ywcErl6Fk+Rfmcwbs+M/djDay2NjGKALYH029Fnt/wIbXz0d
XJGfTxv26o5f40i5UKgcSt8tX6yz/60Z9dC/QRNuqNZbtD9jGxh+uB5TIxNdqYVY
hHmt6JRDhyQdfWIROj2Q14jFN5RZqEAHxam5s68AVbtQ0pDa2wzb2W03zq2zH0cL
3fRGV1s324S/Wd+TP1fuLKlYKN5RZgtcW7JDggrksu2Y+v8hrDLywfOSQFD3ujjC
/5xRrbhLVg/7iBUEpGK6hRQnR8+3szW9xxgShKpBtgLlLZ1dLm/+AXjHkZqSKeqm
pB4p+NKAYdmJjD2YK66efMneBMa3Np66j+prjJhLFMqgNGlnylkwrNonA/k5daDE
WmbJRlAEzrW6Ju/r41Hdj8TEcihxx5KzubXhxQ6RyeVKo3LKTzsyb9Xxa3P9c8DZ
CY5XaSh9YTEJqrOk/Kjx
=zrgN
-----END PGP SIGNATURE-----

--FxX07ZGw9of/ANg3--
