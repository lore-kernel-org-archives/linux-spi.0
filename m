From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: imx: wait_for_completion_timeout(..) for PIO
 transfers
Date: Tue, 21 Jun 2016 19:51:00 +0100
Message-ID: <20160621185100.GD28202@sirena.org.uk>
References: <1466511174-17048-1-git-send-email-christian.gmeiner@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466511174-17048-1-git-send-email-christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 21, 2016 at 02:12:54PM +0200, Christian Gmeiner wrote:

> [ 240.246067] INFO: task hexdump:1660 blocked for more than 120 seconds.
> [ 240.246089] Not tainted 4.1.17 0000001
> [ 240.246099] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXaYySAAoJECTWi3JdVIfQvMUH+QEUTKBhLCyotH+RfaziNpvg
jhRUhRW4t7TuOrGBqyKbD/YbHANR97YVpuhwRag/7xPH0XBeJ0hrygnikAnFeSMI
hSkLye8pXymQw5ufBYV9qB36A0oLqTfjyElaHD4Nlp+NwZnjL3Afzhs0C8MoeYfv
65GoiiZiNmo3ZcRUPCIxgyKol4SSlTo63u2D9kOSmNKVp8oHi0GQCwJYx2C4TPcN
jgYtoLuAEw5UIAbU/KiShOyKLg7ivl62EitANLmZrbvWqTCAKQTpzIGOfPewlWZC
IttQlFJ0P15Qloa9ppnQxQ7y6KrK/2fPDgGMPZy8a7ZrkLAQPfYg9vlgvX9JBYk=
=/qmO
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
