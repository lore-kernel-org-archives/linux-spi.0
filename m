From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] spi: of: allow instantiating slaves without a driver
Date: Sun, 26 Jun 2016 12:58:15 +0100
Message-ID: <20160626115815.GN28202@sirena.org.uk>
References: <cover.1466696079.git.hramrach@gmail.com>
 <ebe2a48124441819adab773b28cd12425ba5bda4.1466696079.git.hramrach@gmail.com>
 <20160626011500.GF28202@sirena.org.uk>
 <CAOMqctSA0G+fBKNgAizqWvEUfJLr9Fh0SsN0Pn-cQv=zeu7iFg@mail.gmail.com>
 <20160626112133.GJ28202@sirena.org.uk>
 <CAOMqctQernycZkc0Wia9EierT1PhfcYAPWc=89LgTC-DBgkg5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CeC2K4acttR/mmFn"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Adrien Schildknecht <adrien+dev@schischi.me>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQernycZkc0Wia9EierT1PhfcYAPWc=89LgTC-DBgkg5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--CeC2K4acttR/mmFn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 26, 2016 at 01:35:46PM +0200, Michal Suchanek wrote:
> On 26 June 2016 at 13:21, Mark Brown <broonie@kernel.org> wrote:

> > You can just add the entire slave node in the overlay, it's not clear
> > that this buys us anything useful

> You have to target the master node and specify the CS in the overlay
> if you create the whole node. If you target the slave node you have
> the CS specified in the board devicetree and the overlay can apply to
> multiple boards without change.

No, there's a lot more to having overlays to board-neutral connectors...

> > and this needs to be joined up with the work going on to allow
> > expansion connector overlays to be loaded in the first place.

> The overlays work equally well before and after this patch. I don't
> see any problem with them other than part of the infrastructure
> missing in mainline kernel.

...you're missing all this stuff here - currently the active work on
this is being done by Patelis.  It's not at all clear to me that
referring to a slave rather than a master would be any easier in a board
neutral overlay.

--CeC2K4acttR/mmFn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXb8NWAAoJECTWi3JdVIfQ+WgH/1v7Y5uCQ5c9rCndAQfVY2js
+oOtH8golvNuQpohNrC3vHhsaCaEXCeH8rQXmiAukjbLXOdUsUNLQE+PfhdtGvjV
fEC6rK/kRNz1UGQek+f8NKYYDDEXOMGziRV7xyoxAQrHb46hw24OR14M828E+ZKF
dxKICyCYJ7agGigkHaJOMig5n3ZAMXCLzrL3+wt/AIVwdECRyCxbG+6jb7f2H9a7
pl+7n9vB/6y6fUnKN8fzvAtCQ99qS0VcN1IYsyjc4fjPV8EOp0tQt0Y66cQrv1in
TjsGFbhO3QXFf3c97slhcYVw55EcjAcKtdDyt90GMTNF2HHIuX7V/bEMKbgGiDA=
=BNc/
-----END PGP SIGNATURE-----

--CeC2K4acttR/mmFn--
