From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Date: Tue, 7 May 2019 12:02:41 +0900
Message-ID: <20190507030241.GC14916@sirena.org.uk>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sAD49wDt4u2G8n56"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190507021853.GY14916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--sAD49wDt4u2G8n56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 11:18:53AM +0900, Mark Brown wrote:

> Possibly it's not actually anything to do with the DKIM and it's just
> upset that I'm travelling and so the mail was injected from a mobile
> broadband IP in Japan which doesn't match up with the .uk domain.

I've tried sending equivalent mail to one of my own Google accounts and
it gets delivered, though I do see the dmarc=fail bit in the headers.
The full header there is for a newer spec called ARC that builds even
more stuff on top of DKIM and SPF.

ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=gYHUGKmm;
       spf=pass (google.com: best guess record for domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org

which suggests it's adding some guesswork in there on top of what's
explicitly in there for SPF (though that's not causing trouble as it
worked out that the mail is OK).  The fact that this got through OK and
all the NONEs there suggest that they are to at least some extent doing
the right thing with the lack of any advertised policies for kernel.org,
either something else about the message or your incoming mail is causing
the spam filtering.

Unfortunately I can't immediately see any exim stuff for ARC (and I
don't know that there's anything there that could really help) and I
can't do DKIM for kernel.org (for good reasons), the only thing I can
think of is to disable signing of the From: and hope Google just stop
trying to validate it but that doesn't seem ideal.  Everything I'm
seeing is saying that Google just isn't enthusiastic about domains like
kernel.org which is going an issue.

Not really sure what I can do here...

--sAD49wDt4u2G8n56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQ9VAACgkQJNaLcl1U
h9BOEQf/XUeAJbQXmzLfhaLbUCZgEuFkUF7T9cjQr+zWPMTXqNgX3iOEJ4IXeHYL
YvFV9hTskDTB7ARMObAWb0cLtsVrHLs57xNabk9kAb096s3T7YhGede479XCa92M
6aBWrfTlg//NeRIRKSoQWaGO14CAlSaK9/R/zzoOS5gdehx67fjQmGGP0wHTprdK
8NxYWNQP2+Cu/u49mNTdfcz3mcAm6HcVO4Ir6ta2EWW+ZwvcytwWuoZ7LYQWtJHz
RanYDzDCqUs+preuymnOWIpyM9RLdi6AWv6CH8wx6Luw/HhPcOq+tik1vKWK2B7U
CTKgkKREbUWPj+FDW/VfaX/CBeut/A==
=VDXp
-----END PGP SIGNATURE-----

--sAD49wDt4u2G8n56--
