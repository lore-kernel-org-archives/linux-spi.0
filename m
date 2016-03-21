From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
 structure.
Date: Mon, 21 Mar 2016 13:07:34 +0000
Message-ID: <20160321130734.GS2566@sirena.org.uk>
References: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jt7EHN8kmSCh+bhe"
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Anirudha Sarangi <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	P L Sai Krishna <lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: P L Sai Krishna <lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458562809-36114-1-git-send-email-lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jt7EHN8kmSCh+bhe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 21, 2016 at 05:50:08PM +0530, P L Sai Krishna wrote:
> This patch does following things.
> 1. Added dummy entry in the spi_transfer structure.
> 2. Assigned dummy cycles to dummy member in the transfer
> structure during read operation.

Please try to follow the patch submission process covered in
SubmittingPatches, in particular please use subject lines reflecting the
style for the subsystem (which helps people identify relevant changes to
review) and...

>  drivers/mtd/devices/m25p80.c | 1 +
>  include/linux/spi/spi.h      | 2 ++
>  2 files changed, 3 insertions(+)

=2E..split things up into individual patches, for example here you're
both adding a new feature and adding a user of that feature in a single
patch.

> + * @dummy: number of dummy cycles.

This needs to be clearer about what a dummy cycle is and where it gets
inserted.  We probably also want a better name, just "dummy" makes it
look like a padding field in the structure.  How about dummy_cycles?

> @@ -752,6 +753,7 @@ struct spi_transfer {
>  	u8		bits_per_word;
>  	u16		delay_usecs;
>  	u32		speed_hz;
> +	u32		dummy;
> =20
>  	struct list_head transfer_list;
>  };

This isn't enough to add the feature - a client driver trying to make
use of this needs to be able to tell if the cycles are actually going to
be inserted.  I'd expect to see a capability flag that can be checked
and some error checking so that if we try to do a transfer with dummy
cycles and can't support it we don't silently ignore the dummy cycles,
ideally also something that'll handle multiples of 8 bits with SPI
controllers that don't otherwise support this feature.

--jt7EHN8kmSCh+bhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW7/IUAAoJECTWi3JdVIfQZnQH/i7FHKVIOkFtymIUz9NRek6N
joT894mrU+y/6WJ+WilaLomxB/Wbh/Gkybhds69GmSREhu0lSJmWbRdm9XIhZeCk
50w309+ExCzzXb6TBSebuXOYXR9j8JIyNjrpgrU199ZtkUFlge8oqDqimKwM2tz/
WkD99CwQmd34TS5rgo2LnpqYq+nrbXYqcYGqJv3jXWrPYAJM/U4J/rTIkHPwXjrs
1dVRlXHHQnD9pvulc07exHfYH4Js4cNdir6MMyrCyA8K7jTHc165TQvJqFBnppVw
K8/DAY3z0/zBT1MlMcig2Nea0aX8Ct91xwng8LFRQ7P3edyEsjtp0kj5ZnHXyrk=
=XwVw
-----END PGP SIGNATURE-----

--jt7EHN8kmSCh+bhe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
