From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sc18is602: Don't be that restrictive with the
 maximum transfer speed
Date: Mon, 17 Mar 2014 11:52:56 +0000
Message-ID: <20140317115256.GC11706@sirena.org.uk>
References: <1395020870-18107-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395020870-18107-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 16, 2014 at 06:47:50PM -0700, Guenter Roeck wrote:
> Commit 09e99bca8 (spi: sc18is602: Convert to let spi core validate
> transfer speed) made the maximum transfer speed much more restrictive
> than before. The transfer speed used to be adjusted to 1/4 of the chip
> clock rate if a higher transfer speed was requested. Now such transfers are
> simply rejected. With default settings, this causes, for example, a transfer
> request at 2 mbps to be rejected because the maximum speed with the default
> chip clock is 1.843 mbps.

> This is unnecessarily restrictive and causes unnecessary failures. Loosen
> the limit to accept transfers up to 50% of the clock rate and adjust
> the speed as needed when setting up the actualt transfer.

Given this description I'd expect to see a change in the core not a
driver - like the other fork of the thread said I'd expect to deal with
the issue by improving the constraint handling code.

>  	master->transfer_one_message = sc18is602_transfer_one;
>  	master->dev.of_node = np;
>  	master->min_speed_hz = hw->freq / 128;
> -	master->max_speed_hz = hw->freq / 4;
> +	master->max_speed_hz = hw->freq / 2;

That said, if this is something that the hardware can support it makes
sense to do it anyway - is there an actual spec constraint available?

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJuIVAAoJELSic+t+oim9NmgP/iSqEEw5BlfMya7U/vtrzeO0
7wrgMod4lTw6LyEY+Z9J9hqBYsM3iVmQGmblNWXckTauIz528tBivU/IorOC7Sp9
bMgcFTXpgn3HpPNaNUdnW0Qpq7TSNz+uBlvjGZnPipLUBQtAZfLSrOslVLj6eapd
f1DLxHi6QvWRDVDzGRtv5/j2oJvwfdZ+vELEUrJIhRcy07q4W6Pqg0Gz2ooJbvGf
6681tniptkjcUGKlMd7iBSYAgg5mCorYHkJLgaPNi4WRGce7Qjce9egrY+ZZj/di
FB/nAFyxI2nsxlpl/ojpUQx6BfYbPyIUzmxaUUhwLMzGFQjxoLnXEXFcJPGOhET9
ByqU8Nnyt8IqKV0BwRs0rW/nD9sdqW47suMh8ks6EWG6Upn7tLzYSbEqS/uEbISV
Z7p3qEQNs/e0Sjydyg8+lArxEq8JKaTv9le9Fzxg6VBF4mxA1kJilyexumiMrrLj
VOwrxmHHAMfAl2GSabmvuGSbAQyOidcykL3fsKooBRHfHMdaRg3mSfnroBuei8RT
RMWdcVDYA1VuNCEhipotBwB2ytjeAD6jcLb2Nkb+UVvZkZZdTBgkpV0ffmr9/Hoc
UV8gK/qLBkDkQ5m5EhZy5GpdjTo2D8/9+79wLWGIOiMSAQQ0cURb/ysMF3Kn2yUJ
m19XbJvZrf0uFM274xHQ
=InpE
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
