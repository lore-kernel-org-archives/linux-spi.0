From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spidev: fix hang when transfer_one_message fails
Date: Mon, 6 Jan 2014 12:53:44 +0000
Message-ID: <20140106125344.GR31886@sirena.org.uk>
References: <1388965166-27334-1-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2m+IWTtMCMjzK22K"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Daniel Santos <daniel.santos-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388965166-27334-1-git-send-email-daniel.santos-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2m+IWTtMCMjzK22K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 05, 2014 at 05:39:26PM -0600, danielfsantos-fOdFMYwuEsI@public.gmane.org wrote:
> This corrects a problem in spi_pump_messages() that leads to an spi
> message hanging forever when a call to transfer_one_message() fails.
> This failure occurs in my MCP2210 driver when the cs_change bit is set
> on the last transfer in a message, an operation which the hardware does
> not support.

Applied, thanks.

--2m+IWTtMCMjzK22K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyqdUAAoJELSic+t+oim9ulgP/RL2cdeIakKKkM1ZzW/lTpI8
uTNIu/xa8hLXytBql2o9BirYs/2+4Q5LTkfCAZowYAPYcZHMLIva9JMBbT4n4hLr
9rpIMrdO3MM5NV3GlvvGXjfXoLK7FFS0yWt0RdhFXMr9ND0b4UZOKKL2r0NwE11V
yweJp2s96j52UVWGRFY1zmaooZ0HmRoD4AtZAuUjSrozaRPG+UDpzBtG9MF/CGTe
1d+n6iEFL4ml1LcQ+EOAluZqObpcookNYkhNjxegEhkLfJ40tJoGjtyeXf45W7S9
84WyX2WfUJuGvNgzMQvXyoQzUIIZ8elzAtPtdV0uQd/fePm+7mPxfaHOtlOLqbTU
kfFUvQiwdGzxo9CEafdUp2hMmqWDVa2MTzqfaJ8iVil4X4UtxCqMMMoLiT5JK+Ps
U69f+TqI0FZ0WG5bnbD9OD8BRuYfq82LpZ8s+uXV4beh/K0CpVX8bHkVodNsOZwr
qeNhXrl6blNMB8y7mhjljVqGTtB+64d8JmYIDOR8jsrHBHOcUD2lJIVeiPbxl2wc
oVg5ZXFPbg0mlCK31Ps8OdvqnrQZjtJ/Qcv/jYvZ5Uiz/WfDfysDzYz0DemkhTk0
3vuDnMRya7QVA/2PIy7e4NbT2MhhXEhNNI2hSZp6caHZvRGVKSyjbwtcwfGKd7xU
fO/aVuZnI/NMK2G9SgHy
=D+4I
-----END PGP SIGNATURE-----

--2m+IWTtMCMjzK22K--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
