From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
Date: Wed, 18 Jan 2017 12:46:45 +0000
Message-ID: <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zn67lalbyxvvoroh"
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--zn67lalbyxvvoroh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 18, 2017 at 10:33:07AM +0100, Jan Kiszka wrote:
> On 2017-01-18 09:21, Robert Jarzmik wrote:

> >>>> +	while (1) {

> >>> This bit worries me a bit, as this can be either :
> >>>  - hogging the SoC's CPU, endlessly running
> >>>  - or even worse, blocking the CPU for ever

> >>> The question behind is, should this be done in a top-half, or moved to a irq
> >>> thread ?

> >> Every device with a broken interrupt source can hog CPUs, nothing
> >> special with this one. If you don't close the loop in the handler
> >> itself, you close it over the hardware retriggering the interrupt over
> >> and over again.

> > I'm not speaking of a broken interrupt source, I'm speaking of a broken code,
> > such as in the handler, or broken status readback, or lack of understanding on
> > the status register which may imply the while(1) to loop forever.

> >> So, I don't see a point in offloading to a thread. The normal case is
> >> some TX done (FIFO available) event followed by an RX event, then the
> >> transfer is complete, isn't it?

> > The point is if you stay forever in the while(1) loop, you can at least have a
> > print a backtrace (LOCKUP_DETECTOR).

> I won't consider "debugability" as a good reason to move interrupt
> handlers into threads. There should be real workload that requires
> offloading or specific prioritization.

It's failure mitigation - you're translating a hard lockup into
something that will potentially allow the system to soldier on which is
likely to be less severe for the user as well as making things easier to
figure out.  If we're doing something like this I'd at least have a
limit on how long we allow the interrupt to scream.

--zn67lalbyxvvoroh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh/Y7EACgkQJNaLcl1U
h9BA2Qf+L0/D8ywl1ZGSGJidEJg/IzsCQ4gFiHmvcmQsbzLywA5nhdLY15YdNDlf
nZCdoDEPFel6q2oRRUQ/D9Hnxt5vIZARWSXl1RJogeBHtgk6M3xJEPVVETO8Enge
4L8PP6dFeCZiZ72x4OWm3qYxs89ZHU+CneU2LKtDOlHUMI5sUiJ1U84gURdnejDK
A7A+tV1aXBirCpdK/1dBsBmfAcsuoBgpdvVPRhdw/BCTY+PaDBv/HZvf5IAmGuKg
rhxQHrqJLv5KIXEsg3XccB/S8exq854/bK8YmXS2tz/WC9/p0t+50Vz2mmVlJNGP
DywiLdrKem0VG0SBMdOsA5KcJ5C2UQ==
=qqTD
-----END PGP SIGNATURE-----

--zn67lalbyxvvoroh--
