From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Fri, 11 Oct 2013 11:08:39 +0100
Message-ID: <20131011100839.GA21581@sirena.org.uk>
References: <52566ACC.1080100@ti.com> <20131010101410.GG21581@sirena.org.uk>
 <52568AA3.9080203@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8633416594184508479=="
Cc: Peter Korsgaard <peter@korsgaard.com>, Trent Piepho <tpiepho@gmail.com>,
 balbi@ti.com, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, computersforpeace@gmail.com,
 dwmw2@infradead.org
To: Sourav Poddar <sourav.poddar@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <52568AA3.9080203@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============8633416594184508479==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N4K9zxasQOfRkoaJ"
Content-Disposition: inline


--N4K9zxasQOfRkoaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2013 at 04:38:19PM +0530, Sourav Poddar wrote:
> On Thursday 10 October 2013 03:44 PM, Mark Brown wrote:

> >Essentially what it looks like this hardware is trying to do is adapt a
> >serial flash so it looks more like a parallel flash.  It's not clear
> >that this is a good idea if we are already able to understand serial
> >flash though.

> Do you have any idea of how to go about implementing it in a more
> cleaner way?(taking care of all what the spi controller hardware needs to
> do for the memory mapped mode.). I understand doing a memcpy in the caller
> itself, but how to tackle the spi controller configuration at that
> point of time.

You'd need to lock the bus and return the address for the caller to use
until it released the lock.  Like I say I'd want to see numbers on this
helping though.

> Memory mapped is  a spi controller feature rather than a flash.

The way it appears to be implemented is pretty flash specific isn't it?

--N4K9zxasQOfRkoaJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSV84jAAoJELSic+t+oim9+5YQAIbxl192Qfu87y91X5yrh64z
goZDk+b9jgVmCHOpNQxA67QHUUDdJtyanuuyuEH+em0hce4rTfILzqDPU00eyyNq
wPROwBc9vHrfCKqN0ZjUhLiIxesYRvgBoMc7r72/fKMVZxjqKQ51nlTuXQAcHfb0
RmBoQiI4doFgSTfjbQLYbrO/DIDXwhi9XrHx3T2MjVg19hd9GogMRSz9VQVXZPhq
uUGCoS7Rf8UJKjWGKM/x78h51LeoBToZx4vSjCuGo98Cc/8aq/C6C5k0VMM4GmuD
H6KRg1Kz55GL8uRSnqrat0YrnjCgcSiOtvgVs221BCNahAbdTTaJS4nGekqHnghI
xlWcK7jFXo/fFuNrzyeZsUCdMRIIW+LNHooITxBPMDAMqhRlrz/iBOYc/3irFLiC
3+jXHVMR5dv9oh0pvCkXD33QF+rCLpEWew53ODzsg97/d9AjD0srJjnPuQxo8PPV
Phh+Ut6+uMdY4YfA9LY9VrPQRfRPcmU4RD7shdMbCdLzonfj3QHjNYAoaLIP9M7O
zZAcAi5LmieK0GBKZ5xHD8OucxYzA0rv7nV8oWrqG89UHFus6MDA89qXCUM+9Ifr
9AHP3ZDevtPg6yACVu1w4KgjTMQLVgx4j0SWn166xfEhavnd+qiQGqwJVyZx5WXX
ITWpBHIduk3a7U+I18oK
=XYWn
-----END PGP SIGNATURE-----

--N4K9zxasQOfRkoaJ--


--===============8633416594184508479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============8633416594184508479==--
