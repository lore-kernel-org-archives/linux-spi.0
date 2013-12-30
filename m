From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 6/8] [RFC] Documentation: dt: Add Renesas RSPI/QSPI
 bindings
Date: Mon, 30 Dec 2013 13:50:58 +0000
Message-ID: <20131230135058.GD31886@sirena.org.uk>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
 <1388175362-17132-7-git-send-email-geert@linux-m68k.org>
 <20131230125845.GX31886@sirena.org.uk>
 <CAMuHMdXYH6KmH3ZstAvhqUpqXWEbg6sjdUTDRZUrUthdPg-6aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tfudkhBUqbdcU4Ca"
Cc: Linux-sh list <linux-sh@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-spi@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXYH6KmH3ZstAvhqUpqXWEbg6sjdUTDRZUrUthdPg-6aQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--tfudkhBUqbdcU4Ca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 30, 2013 at 02:43:53PM +0100, Geert Uytterhoeven wrote:
> On Mon, Dec 30, 2013 at 1:58 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Dec 27, 2013 at 09:16:00PM +0100, Geert Uytterhoeven wrote:

> >> +- num-cs        : Number of chip selects

> > Why is this variable and how does this map onto hardware?

> It's my understanding that legacy RSPi on SH7757 has 2 chip selects,
> while other RSPI implementations have 1 chip select.

So this should be documented in the binding document in a way that
allows someone reading the document and looking at the datasheet to
figure out how to pick the value (for example, refer to how the chip
selects are controlled in the hardware).

--tfudkhBUqbdcU4Ca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwXo/AAoJELSic+t+oim9U74QAJ4yFd/D46wdueLLu8rZBOB3
JKajbFJwM7NOUwUTI9XJzNZe0ec6Z8YICx1gUqZ8PicW22Rqz89c5VaVx0jwoQrj
e10zzjLsuLdmxppabFZU+7vFvp6M2CP1ETGY8t+Q4ZJa6KQg/aThC84BwoEo2rmA
9iKbtw1EbANxTDcwGw25IGYpy+8YwBTGxpS2bGXP8+ziK+xP5oN/YDj6lvPJPoR6
+jB2j+BUj1QHkQq4VBZHoPIiohBAOz0zNDP2VJCsTjCFzWobQ9O4tQfKBUFpE+xW
vZjQqva8LcnU/eJ2zJGZxFmeihRDK2RiJ0S2G5v+OF1cJR2ErinbNBPkVGos98Sb
H9zQ+gvPU0A9bnabvoMSm4l6OLZHO8hAPzjlNVcbBwJOrtjvcIzqeZ8CuVtroZRn
D25XZmG7yEKfJGdH6TcAN7D16tMvvwghjd7wCrsiTG9m+qUW1E50Sff9d09kEY37
zADeD47Nucjr6xszRXW74Uac8MoGrYznJkwllOE28oWJxBHVP/kQhXhQJ0F48LN5
8VT7JENjIzvzN6EwBa75LVaiQ1nyOa7mIi+sSm3EumMiOHtw3jc2rtlWhgJrIFZX
eKWVJTPcE+MUWzki8xnCTAl8X+Z0O7j4VQolN4UM184mf7oyNArRw4Od00N8FI2S
/HZO+d+Hh0gy4eXahDXd
=Kcqt
-----END PGP SIGNATURE-----

--tfudkhBUqbdcU4Ca--
