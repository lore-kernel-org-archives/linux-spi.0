From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] regmap: Add regmap_pipe_read API
Date: Wed, 22 Jun 2016 11:06:51 +0100
Message-ID: <20160622100651.GH28202@sirena.org.uk>
References: <7ca3857aa8869a1e1f4709860f57f7d92abf1c6b.1466089603.git.leonard.crestez@intel.com>
 <20160621184251.GC28202@sirena.org.uk>
 <f3524d45-b266-056d-05b7-df2d4c007921@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Cc: linux-spi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	linux-i2c@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	linux-kernel@vger.kernel.org
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f3524d45-b266-056d-05b7-df2d4c007921@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 22, 2016 at 11:32:20AM +0300, Crestez Dan Leonard wrote:
> On 06/21/2016 09:42 PM, Mark Brown wrote:
> > On Thu, Jun 16, 2016 at 06:24:36PM +0300, Crestez Dan Leonard wrote:

> >> +		val = ((u8*)val) + read_len;

> > This cast looks broken, you should be able to do pointer arithmetic on
> > void pointers as though they were char *.

> Pointer arithmetic on void* is not standard C, it's a GCC extension. I
> know that GCC extensions are allowed for the kernel but is it really
> encouraged to rely on them this way?

Hrm, I thought it had been standardized in one of the more recent spec
revisions but I can't seem to find that right now.

> Anyway, are my concerns about the regmap_bus implementation for SPMI
> valid? In theory this could be submitted in it's present form and let
> regmap+spmi users

That looks unfinished...

> If this API is otherwise fine I can just resend this marked as [PATCH]
> with the cast removed and some rearranged comments.

Well, there's the naming.

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXamM5AAoJECTWi3JdVIfQkcgH/AyMgf994mp/x2GvTcIVUVLw
Q5Gx8XM6oHrTQbCEEpkZM/kKUALHsk4QaJ7Cibcp/FkLuRMoy96k6dhWp7PqId1Q
4R90QJYJxXUEehBpMETNbP25tlxyndeJE/d94iNrB1yjnZAV0XIL+Fq9aFyP85uP
rCVSWKzH0juUerS9FfTu1YmbhSzpgqSS4W3otDuDXj1Qva9tQq+Ck60PYuq1qMca
g6bjGXqAfdjDxQQ2PYnBK3AaY8TbFoY5vFFCaasE5Apc5quLGE/3lMgbQAKnoFMd
3BVGVRulN0AV2oR5AJVk/lJu63qAxQqRXgeYlakRiSyjtHjkkOa6xk/qx1eFjdQ=
=v4Yf
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
