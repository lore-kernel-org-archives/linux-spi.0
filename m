From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Wed, 9 Oct 2013 20:36:47 +0100
Message-ID: <20131009193647.GA21581@sirena.org.uk>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
 <1381332284-21822-2-git-send-email-sourav.poddar@ti.com>
 <20131009160759.GQ21581@sirena.org.uk> <52558A49.5090904@ti.com>
 <20131009174027.GS21581@sirena.org.uk>
 <87hacq1d5k.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7751547304807162355=="
Cc: balbi@ti.com, linux-mtd@lists.infradead.org,
 spi-devel-general@lists.sourceforge.net, Sourav Poddar <sourav.poddar@ti.com>,
 computersforpeace@gmail.com, dwmw2@infradead.org
To: Peter Korsgaard <peter@korsgaard.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <87hacq1d5k.fsf@dell.be.48ers.dk>
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


--===============7751547304807162355==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/c0JJ5TGZ+xtmyhA"
Content-Disposition: inline


--/c0JJ5TGZ+xtmyhA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2013 at 09:01:59PM +0200, Peter Korsgaard wrote:

> Indeed. I can see how such a feature could be useful in E.G. a lowlevel
> bootloader (because of simplicity), but am less convinced about it in
> Linux where we could conceivable do something else useful while waiting
> on the spi controller.

> But if there's number to prove otherwise..

I can see it being useful if there's a DMA controller that can do the
transfer as a memory to memory DMA - the hardware can probably issue
flash read commands a bit faster than the AP can so you should be able
to get closer to saturating the bus.  The patches didn't try to do that
or make it possible for something further up the stack to do it and the
differences should end up being fairly small with optimisations like
those in the pxa2xx or pl022 drivers (which I'm currently working on
pulling out into the framework).

--/c0JJ5TGZ+xtmyhA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVbBMAAoJELSic+t+oim99HsQAI6w5/W7EjDQTZQ6+g2KadMP
Bojzk7yjH07ZRpfONeMgzzWPTdVHOHRK6i/YWVib+8IjncMNXBPoYVGMrBqau73T
Bt/os5LSVqnL7ZQ1MSjYe3i/4IFoSXmACa1RQYs3ULjxMmXMcOteCwb4P4I/Euy6
Fnn1QCaFzmAHGZ9XNuU6Mb/05doK6mCGu+89vo6EkQuhjrtJ3ZAhBfeNE/zEY6eI
JEiP/DoLmpVe8IwXoTb+NfO2oLGrISG3pX9YHGIFADdINA9uFz+0xSMt8UuoiS7P
iZ2gpPClKAj6zobtgGbrqn4SoC2npmwUsudHY05gP1H9h7/4diKFORcAZaiCosoK
AzNsnR7i8bjcYYBuc+k7CxSvqkXUTdfAWnSwnyfHgsPymc0A+FNyueDNWfNASJas
OUOyQZIafRYE7ypmdFe0Q0c1B6COaKNU2Va1ejTxKRBfUvxoUXbNgbFb2jMHRdm8
AIjNrjkaukJSi6xHickznAbm5hXeyvoXuu6lcc5xlQWvum6EtiKmrKWE1e/R+ocK
0Yer+bNlT5dVqApU4x9FBsLkrqsMWFJBsiWnESLb5tqDyCi9oejIgGmpZz+Zx7gl
TuIKYTtWPUOuax6FGqLpYPuAEfeP/FrUDbhM03m1kqaL4cuUGaJFTbHSkUyw9aQa
8o+9QKLwK2NA0FUR6vgy
=2Ny9
-----END PGP SIGNATURE-----

--/c0JJ5TGZ+xtmyhA--


--===============7751547304807162355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============7751547304807162355==--
