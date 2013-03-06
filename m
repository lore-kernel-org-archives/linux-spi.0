From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] spi: add driver for BCM2835
Date: Wed, 6 Mar 2013 12:33:43 +0800
Message-ID: <20130306043333.GB4896@opensource.wolfsonmicro.com>
References: <1362538142-19246-1-git-send-email-swarren@wwwdotorg.org>
 <20130306040520.GA4896@opensource.wolfsonmicro.com>
 <5136C5AB.7020301@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1396649026210027506=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <5136C5AB.7020301-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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


--===============1396649026210027506==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 05, 2013 at 09:27:23PM -0700, Stephen Warren wrote:
> On 03/05/2013 09:05 PM, Mark Brown wrote:
> > On Tue, Mar 05, 2013 at 07:49:02PM -0700, Stephen Warren wrote:

> >> +Optional properties: +- brcm,realtime: Boolean. Indicates the
> >> driver should operate with realtime +  priority to minimise the
> >> transfer latency on the bus.

> > This isn't obviously something that ought to be in DT, it'll depend
> > on the OS, kernel version and so on.  Indeed I don't think this is

> If that somehow accidentally snuck in, I can happily remove this feature.

Dunno, my call would be to remove it.

> >> wait_for_completion_timeout(&bs->done, +
> >> msecs_to_jiffies(BCM2835_SPI_TIMEOUT_MS)); +		if (!timeout) { +
> >> err = -ETIMEDOUT; +			goto out; +		}

> > But I wanted to transfer 10G in a single message at 1kHz!  :P

> I'm not sure what the solution is here; calculated timeout value, or
> no timeout?

Either that or just make sure that the timeout that's picked is very
high I guess.

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNscOAAoJELSic+t+oim9gq0P/AqoITx613tTPxjXV63XEpM8
xTGWon88xXwR+efy5l/BvKmgQn0x34L26FqCuJsHEyt2g3IIVghTh5P0Bm/5R1mO
YnHT2fKgMp7kA3JUE4c6T6LQKjNj8ahgL0l1tvLpzPTWTV18nDpaZpMafyxu60KP
qibQZGPKNOUP+isxOd7aImGydz/DcQcnXlk24u4CfpEMzE4yxFiZpR1lgDGKi5v/
YKjI368sg06yh4ZV7jmcg+fGEZI0+ftyjH8pjGXPEtCKb5mtcUNSg4HvYvqh4pkj
8GApu9fy91ye7422jCrGDC392QYBVNIT/gwGXS5WDzIBKgQ8Ob+aQw7b82OxeI2z
R/rz70OY0Ncx+3p4cm6TYLV4PhOLgmsKkYNOtzqDs2Hj15j4wT4czClOhpFYUZCx
JChzn1z3bg8Ll+PK30PMdzHWz59BB93T3g31OM9YkSyZ0nuE9kQG6dyquYUiuzuN
+bZ9hbCtL9ffnn/VmrC7b8pviOnqRrMRhCeGByMxXcN76etWtnQJDilx4uAcJRlq
EWeBYGksZ1PI9USIUnllA2nJn2tXZjmeOOQOrYqvj5isqn7auEWG/jS7vcoJRKlu
v0Y4mN3yuyz0H9GFzKGEqk+2TtOIK+2JQc0xIuOM/B9nPIkdS7Wv/KikRUTR1yTX
RrUgSErw5DwEvYk6uXga
=N+Qt
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--


--===============1396649026210027506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============1396649026210027506==--
