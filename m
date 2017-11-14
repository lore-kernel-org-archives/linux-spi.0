From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Tue, 14 Nov 2017 12:02:07 +0000
Message-ID: <20171114120207.xbee2cgsai4qka46@sirena.org.uk>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e4xxopltkrz4zvbu"
Cc: Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>,
        Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--e4xxopltkrz4zvbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 13, 2017 at 01:17:42PM -0800, Tim Harvey wrote:

> When a register is read from the mcp251x driver the
> octeon_spi_do_transfer() gets a spi_message with a single spi_xfer of
> len=3, a tx_buf, and an rx_buf which I believe is supposed to shift
> out 3 bytes out MOSI and shift in 3 bytes from MISO where the last
> byte shifted in would be the response.

No, that will simultaneously transmit and recieve three bytes.  If you
want to transmit two bytes and then recieve one byte you need two xfers,
one with a len of 2 and a tx_buf, the other with a len of 1 and a rx_buf.

--e4xxopltkrz4zvbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloK2z4ACgkQJNaLcl1U
h9CCvgf/QzTbKo9PUto0ftJpgRcHYPszjJFYWDP56teG68kzEVo3giNAsEsRIPif
Hmwc0/JkFErxFwok9N7KB4n8+oK4DTofLd8bphNNP0GR3tfYE5O1hnahn0sSzOp9
fcoQflAbt3b+/qt54DTkL7Pzo4srhyrtHOEk6nHoCHChTK7klcV0C2PCBlvHAa8B
uurozNzTiFIpsMaUFWFO7UGwsXc9yGDxd71ADFGrAS9Z6tcTZY8qyXp4AXIbYAnD
7z7Zh0lRdvU9kpC1CzHL4goRj4XzAnLW2V6iaVuibt57GvcNvr5oCYqQDxv2J0vt
NtpCOpnchYirLbEz6DCBsgiUW6Zh8g==
=N4XA
-----END PGP SIGNATURE-----

--e4xxopltkrz4zvbu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
