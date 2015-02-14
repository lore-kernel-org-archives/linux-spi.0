From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: only use up TX/RX bounce buffer space when
 needed
Date: Sat, 14 Feb 2015 13:49:10 +0900
Message-ID: <20150214044910.GF9110@finisterre.sirena.org.uk>
References: <1423743188-1821-1-git-send-email-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423743188-1821-1-git-send-email-abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 12, 2015 at 12:13:08PM +0000, Ian Abbott wrote:
> Devices have separate, pre-allocated TX and RX bounce buffers of fixed
> size.  Currently, each transfer uses up space in both buffers even if
> the user-supplied no TX data or no RX space.  Change it to only use up
> space in the TX and RX bounce buffers as required.

This is a bit hard to parse.  I think you're talking about buffers in
spidev here but it's unclear and you've not described in what way you're
changing the code and we do currently only seem to copy data when the
user has asked for it.

> Since dummy transfers with no user-supplied TX data and no user-supplied
> RX space will no longer use up space in the bounce buffers, limit the
> overall SPI message length to INT_MAX instead of the buffer size.

That doesn't seem to follow at all.  No mention has been made of
eliminating the buffers entirely or otherwise ensuring that we can
handle transfers of any length - not using the buffer for transmit isn't
going to make the receive buffer any bigger and indeed...

>  		if (u_tmp->rx_buf) {
> +			rx_total += k_tmp->len;
> +			if (rx_total > bufsiz) {
> +				status = -EMSGSIZE;
> +				goto done;
> +			}

...we do still seem to be limited to the buffer size here as one would
expect?

Basically I'm not entirely clear what this change is supposed to be
doing or what the expected benefit is.  I *think* the goal is to allow
multi-transfer messages with a mix of unidirectional transfers to be
larger but the changelog needs to be clearer and it's not 100% clear why
we'd bother to check for INT_MAX.

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU3tPGAAoJECTWi3JdVIfQa64H/1uG+nOv41cLWy7HKDUFUY3S
qjATuh0EkPU+OycqZDEdkqT+EYp6XMXyTWfF+YETDQVPAx1QwCU3H/8bY+XkP654
tYFUeDgpmxAcCKAUp8a+LZrymFRRljTAiR29xTX/p2YtW/X0K8raHiicJZHxtl11
VFO2PY6UKxmkBG3MpUL4MifXGisPRinnSAwHyfIGxnHEdD7P1Hw4GmdVXQFNLLzM
TlVydExsm1FPvMJRcUX+XcCsn3rLZAMI4Xvo8zf+5b3W6xIUZuf+hAeFlyW448D6
AvYILWzepTMPSFBkmjSooTDY1D08jM+2WPzEHsJPjEa/gHrgAJ4Z84uwiap07bc=
=Fzrj
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
