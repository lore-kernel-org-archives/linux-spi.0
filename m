From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 0/7] Raspberry Pi spi0 improvements
Date: Thu, 15 Nov 2018 21:11:01 -0800
Message-ID: <87r2flli8q.fsf@anholt.net>
References: <cover.1541659680.git.lukas@wunner.de>
 <7ba12f83-a78f-4827-b962-4b08cad341fa@gmail.com>
 <20181114055121.5xpwxcu6a5qsgjqv@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7982950052250171217=="
Cc: Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20181114055121.5xpwxcu6a5qsgjqv-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============7982950052250171217==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> writes:

> On Tue, Nov 13, 2018 at 09:12:01PM -0800, Florian Fainelli wrote:
>> On 11/7/2018 11:06 PM, Lukas Wunner wrote:
>> > Here's a first batch of improvements for the spi0 master on the
>> > Raspberry Pi.  The meat of the series is in its last two patches:
>> >=20
>> > * Patch [6/7] allows DMA for transfer buffers starting at an offset no=
t a
>> >   multiple of 4.  This overcomes a limitation affecting Ethernet drive=
rs
>> >   such as ks8851 which call netdev_alloc_skb_ip_align() to allocate
>> >   deliberately unaligned receive buffers.
>> >=20
>> > * Patch [7/7] speeds up PIO transfers by not polling the RX FIFO when =
it
>> >   is known to contain data, or the TX FIFO when it is known to have fr=
ee
>> >   space.
>>=20
>> Do you have some performance numbers that you could share before/after,
>> e.g: transfer latencies, number of interrupts and pure throughput?
>
> The throughput is primarily determined by the serial clock configured in
> the DT for a specific SPI slave.  There's nothing we can improve there
> in software.
>
> This series is about reducing CPU usage.  E.g. without patch [6/7],
> transfer buffers not aligned to 32-bit are transmitted with programmed I/O
> instead of DMA.  Thus, constantly receiving packets on a ks8851 Ethernet
> chip with a serial clock of 20 MHz occupies 25% of a CPU on a RasPi 3
> (for the ks8851 IRQ thread).  With the patch, it drops to a negligible
> percentage.  The spi-bcm2835.c driver currently forces PIO even for
> kmalloc'ed buffers which are always contiguous in physical memory,
> i.e. for no reason at all.

With the whole series, I got an improvement in kmscube on my hx8357d spi
panel and vc4 rendering from 5.9fps to 6.6fps.  No stats, but the
numbers seem fairly stable between runs.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvuUWUACgkQtdYpNtH8
nuiTPQ//f1mli40xsWMGIOshWzvumGqvHsUfSiF9aVrKBPTe9g12ezr0ZfbwoN0Q
VZbCWelYEuNlZ809JdcDoLWDqlO7CorbzZHhSvXHKcbNiw5qC+cyHklrWAhqKPGo
MqNJoLzbm6h3RPYwK4CzmxweSDP5s/p7d0MM0jm2cFFAbps9EeTw+bi0vSlf+zBm
iDrUMDUlkX7ekjdRDG/qc3QTAWJlScUhX8fCPt5Pr3sgl7fhEEeGEk84AmGflUls
deFdJszoLtrpI5EwMxeZ8YXtCiGYZQD8z4mjK28DsFHeSmqXxNTGZ4LOIYksMAj8
RuZNJ7wdGA5SgO0qnIzdArSau9exg89DxFJCVp0bjZ21rZ8rjfGXEzBjMYpx7GiX
h0IeSLIVxNG0ZBTUrjRaVEATfTeUfrf3KPrgimmo211icCO+3rwRzaGOFgpcpzv5
wdo1irem1FVp+Hdji6USmsHcPXvmWuTjlyo/tM61N18FJu8f4wImcwDcvQL4yu/J
+i4QTYYluGPgVBM2tmVWxnD4I7HyUnvD1pAM35alvVC6Cpz9ikoELkWuE8Pq2r/p
JLb7nPdFOlW60EzwO2jtnwzRWDa0P4bIxSZowqeopc2Okss/svfVWpc03wd6zgnz
eRlTCXkJnl2QFbwp6aQO+vrlX1aG3dTLfhACx7GTaDS6txJ7tR0=
=6c9b
-----END PGP SIGNATURE-----
--=-=-=--


--===============7982950052250171217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============7982950052250171217==--
