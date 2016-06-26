From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] drivers core: allow id match override when manually
 binding driver
Date: Sun, 26 Jun 2016 02:17:37 +0100
Message-ID: <20160626011737.GG28202@sirena.org.uk>
References: <cover.1466696079.git.hramrach@gmail.com>
 <5e0397742f887f656d67bb0d61c8e10782c0e5af.1466696079.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YYM4jLJxzFJ63wjS"
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
In-Reply-To: <5e0397742f887f656d67bb0d61c8e10782c0e5af.1466696079.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YYM4jLJxzFJ63wjS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2016 at 05:41:20PM -0000, Michal Suchanek wrote:

> This allows binding spidev on any slave device by hand using sysfs
> without adding superfluous compatibles or any other needless
> complication.

This says "spidev" but it's a change to the driver core, not something
that is specific to spidev.  It needs to be explained in terms ofn the
driver core, especially given that other runtime ID setting is done in a
particular bus.

> +menuconfig DRIVER_MATCH_OVERRIDE
> +	bool "Allow manual driver binding to override id match (DANGEROUS)"
> +	default n
> +	help
> +	  When binding a driver manually bypass the check of driver id table
> +	  against device id in driver core. This can be useful for development
> +	  or on buses that don't provide reliable device identification.
> +
> +config DRIVER_MATCH_OVERRIDE_BUSES
> +	string "Specify buses for which id matching will be overridden"
> +	default "spi"
> +	depends on DRIVER_MATCH_OVERRIDE
> +	help
> +	  space separated bus names

This doesn't seem at all idomatic for how I'd expect bus features to be
implemented, or Linux configuration in general.  If we're going to allow
a feature like this at the core level we should just allow it, if we're
going to opt buses into any such feature I'd expect it to be done
unconditionally.

--YYM4jLJxzFJ63wjS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXby0wAAoJECTWi3JdVIfQHjsH/0eDFofwg5HVyVflW6kQqEhJ
ug8L7HEejtT8tW0Tg6w5ExNWVN0/5w7XmB1PyOMbUz1rGm7VYS6hITDL0iiV95bO
jNfEhvCJyuZhdTmCO7zcVO/xu4Hq3Z9ht4oc6/doR5USSAyfqFh9gYCrPxETJ11W
wx+i09sXrfxQjE78MNTtgSQYzRULQyjaqxxlRJ5fRkbEGCi+ksIrkqIX2nFwqL9G
1iBr2oAf0o/2ArKpe18lg5TTjcf8ZOU4xSEFnWsB8iu0VuoASPp0opOsZqbGXr0J
QEDa2wz8KKveEN+8NYgaGsYAB3rBU28zbBwUMKoGjOvSFZC7invrTmTVLKfxNUs=
=EaEQ
-----END PGP SIGNATURE-----

--YYM4jLJxzFJ63wjS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
