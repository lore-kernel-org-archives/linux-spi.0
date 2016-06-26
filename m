From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: spidev: fix the check for spidev in dt
Date: Sun, 26 Jun 2016 02:13:15 +0100
Message-ID: <20160626011315.GE28202@sirena.org.uk>
References: <cover.1466696079.git.hramrach@gmail.com>
 <8b66102e44829c5dc445c17f7bfad1050840b9f0.1466696079.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lBPdJKrYqo3eKYSb"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>,
	Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>,
	Nikolay Aleksandrov <nikolay-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>,
	Dmitry Vyukov <dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Adrien Schildknecht <adrien+dev-Yk6CzqVXkG6lnMjI0IkVqw@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8b66102e44829c5dc445c17f7bfad1050840b9f0.1466696079.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lBPdJKrYqo3eKYSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2016 at 05:41:19PM -0000, Michal Suchanek wrote:

> The check is supposed to warn about spidev specified directly in
> devicetree as compatible. This just does not work. I have a devicetree
> with no compatible whatsoever and hacked my kernel so I can manually
> bind spidev. This still triggers.

Well, a DT device won't instantiate without a compatible string...
could you please explain exactly what makes you say this won't work?

> Also I have no idea how this could have build with ! CONFIG_OF since the
> id table which the code checks is not compiled then.

of_match_device() compiles out when !OF.

> +static const struct of_device_id spidev_check[] = {
> +			{ .compatible = "spidev" },
> +			{}
> +};

The indentation here is completely non-standard.

> -	if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
> +	if (spi->dev.of_node && of_match_device(spidev_check, &spi->dev)) {

I think what you intend to say in the commit message is that you want to
change from a whitelist to a blacklist since that is what the code says,
but like I say we also need an explanation of the logic behind such a
change.

--lBPdJKrYqo3eKYSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXbywqAAoJECTWi3JdVIfQWdsH/AlbCfIJrqO1BtTQWXQd08jS
KsXx6D+OvuzjrSzYDpSTb2fngMoCzEzfyuNmE6uIh2N61JuwXIygEUti6lkbI2aG
HuYkrf4G157xefc1NPtXCs7JJI9eC0nXDV/wXrz/78jOrUpJsPj81KDXWZpQtvCi
UtYLDquFDFvwjjurbyx8JPORVjGh1zdvtNRodgjshxMK2G+FpbSoRK62iY64gaqM
xcC7zuvX2l5GvGWJoSncGOHPe0ykV51Ai7HvF4IhRxNev1JTHkSwp0l06n0KKDGQ
SO9wvWOjJjkekAOonul4MO13u19gi91hDEuXGG1iwF8o4PwQQb3Abi9YPKgQHus=
=AUG4
-----END PGP SIGNATURE-----

--lBPdJKrYqo3eKYSb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
