From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: spi-imx: spi_imx_remove: do not disable disabled
 clocks
Date: Fri, 28 Feb 2014 12:46:20 +0900
Message-ID: <20140228034620.GH9383@sirena.org.uk>
References: <530EFE8E.5050303@freescale.com>
 <1393492575-32495-1-git-send-email-phdm@macqel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BU7+kJFeeDlNltZg"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Philippe De Muyter <phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393492575-32495-1-git-send-email-phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BU7+kJFeeDlNltZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 10:16:15AM +0100, Philippe De Muyter wrote:

> ------------[ cut here ]------------
> WARNING: at drivers/clk/clk.c:780 clk_disable+0x18/0x24()
> Modules linked in: spi_imx(-) [last unloaded: ev76c560]
> CPU: 1 PID: 16337 Comm: rmmod Tainted: G        W    3.10.17-80548-g90191eb-dirty #33
> [<80013b4c>] (unwind_backtrace+0x0/0xf8) from [<800115dc>] (show_stack+0x10/0x14)

Don't paste entire backtraces into commit logs unless they're adding
something, it makes the mail harder to read.  Especially don't do this
before the text explanation of the commit.

> Since commit 9e556dcc55774c9a1032f32baa0e5cfafede8b70, "spi: spi-imx: only
> enable the clocks when we start to transfer a message", clocks are always
> disabled except when transmitting messages.  There is thus no need to
> disable them at module removal.

>  	writel(0, spi_imx->base + MXC_CSPICTRL);
> -	clk_disable_unprepare(spi_imx->clk_ipg);
> -	clk_disable_unprepare(spi_imx->clk_per);
> +	clk_unprepare(spi_imx->clk_ipg);
> +	clk_unprepare(spi_imx->clk_per);
>  	spi_master_put(master);

Why is the fix for this not to convert the enable/disable done when
tranferring to be preparing as well?  The message transfer doesn't
get started in atomic context so I can't see any advantage to leaving
the clock prepared all the time but it's possible I'm missing something.

--BU7+kJFeeDlNltZg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEAaJAAoJELSic+t+oim9QDAP/R8HPPJmjnmHUXlbr4bg3f8T
DNPS9ySiERQJGm5jcjJHQOxbTsEv+aOmxC6ME9kX6hZ2r6fPVoSoZze0mDttv4eM
xP3zlVvdBqWC5wSIyY1agBLIt1YPY7RE2eKGvmWRI2YUSY95DvwNF0tidfzyK4ju
7kEAwAJ1DZNKBGI4clvGVzlH2L7yQGCiD4GHVkA661mz3MjHK14gSXP2f9gyxQOu
pF5IwwofEC17dEmYvxczV6PdYCHvxrDEPyUoDQQbiQnm4XWErdLdYehvmYI/PJ8S
jG8tizSbJOcXiXqs+7gUod7FjU0CoZSy0FxVJA3idxaL4U9f5TxoHNumzXHJAE6M
V6wmluBk7JP20k3mP4H8cDn1Mc9jZJ4jN0BfUhaFRsavXNmnFpkSlve71rxUrtOX
+ZgOtseRfYfAsxw4ju/12IHzWESy5rPmz9Ax6aMrB9wMA5QIP1K+DmkV3+RzSMxy
qNpRHeoQysiHLaZnXPVOpjl/07zJlkuveypBhknPYv1UlCBqiQ0/IavHk5r5+xzo
5049W3G1RQ3TkrFXqjgulyThyGgWcTz/GtWGsygtsdE6SiMgAM5xo2qXKn5HqhCU
2lY30Z/uUbA8yt5qT+Z4GdBLWsSeunM+Wz74/AlfaSZSfWh6SPDOIhgwc4dFsM+5
o6QrVcqQ059pGw1xYCRo
=iDzF
-----END PGP SIGNATURE-----

--BU7+kJFeeDlNltZg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
