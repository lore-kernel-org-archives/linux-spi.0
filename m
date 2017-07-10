From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
Date: Mon, 10 Jul 2017 19:31:24 +0200
Message-ID: <cb21c69b-6f22-4c06-b308-16bd6895f1a9@web.de>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ@mail.gmail.com>
 <20170710120913.g35ftcbs7pngrtsm@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7347265260974226208=="
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
To: Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170710120913.g35ftcbs7pngrtsm@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7347265260974226208==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CwuGboeE3PACFF32XlGmIQ8KNID3HT9hA"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CwuGboeE3PACFF32XlGmIQ8KNID3HT9hA
Content-Type: multipart/mixed; boundary="xPr0vVIInS9p2DJ7mMcD0a75jK7O4CNGS";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka@web.de>
To: Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang
 <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-spi <linux-spi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <cb21c69b-6f22-4c06-b308-16bd6895f1a9@web.de>
Subject: Re: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ@mail.gmail.com>
 <20170710120913.g35ftcbs7pngrtsm@sirena.org.uk>
In-Reply-To: <20170710120913.g35ftcbs7pngrtsm@sirena.org.uk>

--xPr0vVIInS9p2DJ7mMcD0a75jK7O4CNGS
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2017-07-10 14:09, Mark Brown wrote:
> On Sun, Jul 09, 2017 at 12:48:10AM +0300, Andy Shevchenko wrote:
>> On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka@web.de> wrote:=

>=20
>>> Tested on the IOT2000 where the second SPI bus is connected to an
>>> Arduino-compatible connector and multiplexed between SPI, GPIO and PW=
M
>>> usage.
>=20
>> Can we first switch the driver to use GPIO descriptors instead of
>> plain integers?
>=20
> Only if you also convert the SPI core to use descriptors, Chris Packham=

> was looking at that but he needed update the ep93xx drivers among other=
s
> and getting reviewers was hard.
>=20

IIUC, we can't convert completely due to some legacy boards providing
their CS lines as integers. But even then, a few more API usages can be
converted.

While looking into this, I noticed that this patch violated the formal
rule to never release a GPIO with the old API when it was requested with
the new one. That's at least stated in the docs, even though gpio_free
is equivalent to gpiod_put. Fixed that already, but I need to find some
time to retest.

Jan


--xPr0vVIInS9p2DJ7mMcD0a75jK7O4CNGS--

--CwuGboeE3PACFF32XlGmIQ8KNID3HT9hA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlljufEACgkQitSsb3rl5xT2GgCg69FfU53V1W2p9VcahSFmy9Ni
TW4AoIkL7HGviaPOX2l8i7qUZuc06oY9
=XznT
-----END PGP SIGNATURE-----

--CwuGboeE3PACFF32XlGmIQ8KNID3HT9hA--


--===============7347265260974226208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7347265260974226208==--
