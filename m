From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/4] spi: Split spi message into max_dma_len size chunks
Date: Fri, 12 Apr 2019 10:47:21 +0100
Message-ID: <20190412094721.GE6909@sirena.org.uk>
References: <20190411164235.49771-1-noralf@tronnes.org>
 <20190411164235.49771-3-noralf@tronnes.org>
 <20190411181836.t2vuutqhjglsxsaz@wunner.de>
 <98571639-840a-494c-9e41-29ff89a22a8e@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0254915989=="
Cc: stefan.wahren@i2se.com, dri-devel@lists.freedesktop.org,
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 meghana.madhyastha@gmail.com, kernel@martin.sperl.org
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <98571639-840a-494c-9e41-29ff89a22a8e@tronnes.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Id: linux-spi.vger.kernel.org


--===============0254915989==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 11:02:26PM +0200, Noralf Tr=F8nnes wrote:
> Den 11.04.2019 20.18, skrev Lukas Wunner:
> > On Thu, Apr 11, 2019 at 06:42:33PM +0200, Noralf Tr=F8nnes wrote:
> >> @@ -1299,6 +1299,11 @@ static void __spi_pump_messages(struct spi_cont=
roller *ctlr, bool in_kthread)

> >>  	trace_spi_message_start(ctlr->cur_msg);

> >> +	ret =3D spi_split_transfers_maxsize(ctlr, ctlr->cur_msg, ctlr->max_d=
ma_len,
> >> +					  GFP_KERNEL | GFP_DMA);

> > Um, shouldn't this be ifdef'ed to CONFIG_HAS_DMA?

> Maybe, I don't know. Mark didn't mentioned it when he commented on a
> previous version of this. Some hate ifdef's and want to avoid them, some
> don't.

I *think* we managed to fix all the architectures to at least stub out
the DMA interfaces, it's such a pointless thing to have conditional -
it really only makes a difference for build coverage.

> >> Some drivers like spi_bcm2835 have a max size on DMA transfers. Work
> >> around this by splitting up the transfer if necessary.

> > This feels like a very expensive solution to the problem:  Large transf=
ers
> > are split into multiple smaller transfers (requiring lots of overhead to
> > allocate and populate the structures) and the split transfers seem to be
> > cached for later reuse.

> Only drivers that set ->max_dma_len will be split, and only when the
> length is bigger. I can't see any caching with a quick glance, where do
> you see it?

It *is* more expensive to post-process the transfers and have to do
allocations rather than having them set up as we want them on the way
in.

> > Even the normal case when no transfers exceed the limit is affected by
> > additional overhead, namely an iteration over the transfer list to
> > check each transfers' length. :-(

We already have the iterations in the message validation, if the code is
integrated there the overhead will be reduced.

> > Note that spi_map_buf() already splits every transfer's sglist into
> > segments that are smaller than ctlr->max_dma_len.  Now all that needs
> > to be done is to amend spi-bcm2835.c to iterate over the sglist
> > and transmit it in portions which do not exceed 65535.  Addressing the
> > problem at this lower level would drastically reduce the overhead
> > compared to the approach in the present patch and hence appears to be
> > more recommendable.

> In a previous version of this I suggested to Meghana to put this in the
> driver, but Mark wanted it in the core.

If we want to do this at a lower level the DMA code could hide this
limitation from the upper layers; presumably the SPI driver isn't the
only thing that might run into this.

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywXqkACgkQJNaLcl1U
h9AONQf/aGGY6E45d69dINbPciN+mygGwABKQAFAnFDY5SEc9wP4sF7YZd9TCGiG
8NaJcQ2QkOrywTe469T02PJs1WPOWq3yQIYnOHumt8Z1BsHy7tTh+SuLYCazdQ6r
5ZYq5nopz/4hEakSNv3DQOBhex+UeHfg48TleldTCmU/icvChIwwiwxxGFNQzihm
g40dB9cNYnHbcM7Phnbft9banG/s7xBpFBGYGgKKIzhUEBgmb1byLZNoulwzA0cJ
ZMNPgyKN47Kd3CbxdUo9prsJ9Td+QV7gfia1Z4fwUvH90LJ9pK5bPeAIbkyEZ1tO
JOXlt/lYn9ZIRMIyF2WBbk92fl+NEg==
=/TVJ
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--

--===============0254915989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0254915989==--
