From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: m25p80: Commit "allow arbitrary OF matching for "jedec,spi-nor""
 breaks module autoloading
Date: Sat, 3 Oct 2015 22:41:59 +0200
Message-ID: <56103D97.60906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Seems like commit 43163022927b6e7d202a7e6f939c3f392465494d
(allow arbitrary OF matching for "jedec,spi-nor") broke autoloading
of the m25p80 module.
MODALIAS is "spi:spi-nor" and removing "spi-nor" as device alias
prevents module autoloading.

Of course we could revert the removal of the "spi-nor" device alias.
However it might be better to switch to DT-based matching for
DT-configured devices.

Adding a call to of_device_uevent_modalias to spi_uevent in spi.c
solved the issue for me, drawback however is that just the first
"compatible" value is used as modalias. In case of m25p80 this means
that "jedec,spi-nor" has to be the first "compatible" value.
This constraint might be too strict ..

Having said that I'm not sure what could be a better way to fix
the issue than just re-introducing the "spi-nor" device alias.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
