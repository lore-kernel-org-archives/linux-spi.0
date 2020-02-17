From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Mon, 17 Feb 2020 17:09:01 +0000
Message-ID: <20200217170901.GS9304@sirena.org.uk>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214114618.29704-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214130952.GI4827@sirena.org.uk>
 <3530edcd-eb67-8ea5-0fce-89c83400441c@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D+M1YvVlDncl3vD5"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        vigneshr-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3530edcd-eb67-8ea5-0fce-89c83400441c-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--D+M1YvVlDncl3vD5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 05:18:10PM +0800, Ramuthevar, Vadivel MuruganX wrote:
> On 14/2/2020 9:09 PM, Mark Brown wrote:

> > This will unconditionally handle the interrupt regardless of if the
> > hardware was actually flagging an interrupt which will break shared
> > interrupts and the fault handling code in genirq.

> Yes, you're correct, it doesn't check unconditionally, will update the
> INT flag in the INT_STATUS register after successful completion of
> read/write operation.
> but in this case it is dedicated to qspi-interrupt,not shared with any other
> HW/SW interrupts.

Currently, on the system you're looking at.  Given that this is already
a widely reused IP there's no guarantee that this will always be the
case, and like I say even without sharing it also defeats the fault
handling code.

--D+M1YvVlDncl3vD5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KyKwACgkQJNaLcl1U
h9BRpQf7BBpw3svFemJ2cWh6h1EFnHHkZ/ZLCnfay3PkV8NcIfAhsFPqR7cppyO+
fd1j9FJjXESo+VN3avFmvA6owvPQOQ/nSxaW+i1a1/w8lx3hLfOaPfk7srq86rmE
wCWC6/JPdc3pGsez/Eps2ToT36hUWQQPKI5Af2hIbVJyC0BdbM4o6tA1HP0yzP5m
+ORv/DNeldo4WO2Vg6kQeSwOp8KPFNc8rwMYszVKuLMP35B+1yBS1/wqOibqd7D0
TtxA4X9VwLAN4uxa8QHrjyXKUZBH5w9WCebCV4OdjWlBYiwM8jK3hWqYQ1DeQqjM
/0Eg90UbfBNrqThe8eoiX1tuUwgT0w==
=xyLf
-----END PGP SIGNATURE-----

--D+M1YvVlDncl3vD5--
