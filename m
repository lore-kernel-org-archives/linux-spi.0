From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7] spi: sun4i: Allow transfers larger than FIFO size
Date: Thu, 27 Oct 2016 12:14:19 +0100
Message-ID: <20161027111419.GK25322@sirena.org.uk>
References: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
 <20161026085528.vjjypbfmfbhvileb@lukather>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8161123457528038119=="
Cc: linux-kernel@vger.kernel.org, wens@csie.org,
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161026085528.vjjypbfmfbhvileb@lukather>
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


--===============8161123457528038119==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VJJoKLVEFXdmHQwR"
Content-Disposition: inline


--VJJoKLVEFXdmHQwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 26, 2016 at 10:55:28AM +0200, Maxime Ripard wrote:
> On Wed, Oct 26, 2016 at 12:00:30AM -0700, Alexandru Gagniuc wrote:

> > When DMA finally takes over, this fallback path is not mutually exclusive.

> I definitely agree, and we had this patch in the CHIP kernel for quite
> some time, working like a charm.

> I was planning to respin it in the next few days, glad to see you took
> care of it :)

> Mark, any comments on this? For the record, it already has my Acked-by.

Without knowing what the previous discussion was it's hard to comment,
it sounds like some prior review comments are just being ignored here
but since I'm not turning up anything with this subject line I've no
idea what that might have been (and that's very concerning in itself
given that this is apparently v7...).  I'm also concerned that there
isn't a version of this for sun6i, it's going to make all the
cut'n'pasting between the two drivers harder if we make changes in one
and not the other.

If the concern from the previous reviews to do with not using DMA is
there some reason it's hard to do DMA?

--VJJoKLVEFXdmHQwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEeGJAAoJECTWi3JdVIfQSyEH/3k3GzjIYMnn0hdDfwRaqDHM
RxJmHIFDd4k1HhOtoAXwiYKntHPkpY/Mw9c/VWp041QcLnXhranQW1tEZ2HyjNQJ
sWrpfPy6RwCetsF3sjMF/89qFSjrSTdyJd5y9b38qUuw5IjYcUr660yFjrQtj6w1
0wsC9MXRP5ffBa74qdSljz01f49OOnIvxj8pWPGrQu95BtpSQz1TW3BYfLGdJF1o
jEtTddHiWwLEi5/qPcVCHWxmLPbsxuUAvjAx2Im87FGaPDFaQtJmf6ud+vrdGi/z
eY4nl8jK40ZUtWpyy/AJQP3Kcyamv3gXJSkwl89B3xIGR0+cLOXvvKBxtJuudrY=
=xfxp
-----END PGP SIGNATURE-----

--VJJoKLVEFXdmHQwR--


--===============8161123457528038119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8161123457528038119==--
