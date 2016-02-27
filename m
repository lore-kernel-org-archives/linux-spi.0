From: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: lp-8841: return correct error code from probe
Date: Sat, 27 Feb 2016 22:32:57 +0300
Message-ID: <1456601577.23036.60.camel@gmail.com>
References: <1456400265-3068525-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456400265-3068525-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi=C2=A0Arnd,

On Thu, 2016-02-25 at 12:37 +0100, Arnd Bergmann wrote:
> The spi_lp8841_rtc_probe() function misses an initialization of the
> return code when it fails to get its memory resource, as gcc notices:
>=20
> drivers/spi/spi-lp8841-rtc.c: In function 'spi_lp8841_rtc_probe':
> drivers/spi/spi-lp8841-rtc.c:239:9: error: 'ret' may be used
> uninitialized in this function [-Werror=3Dmaybe-uninitialized]

I wasn't getting this warning when I was building the driver. This
happened because -Wmaybe-uninitialized is suppressed when
CONFIG_CC_OPTIMIZE_FOR_SIZE is selected
(Commit=C2=A0e74fc973b6e531fef1fce8b101ffff05ecfb774c "Turn off -Wmaybe=
-
uninitialized when building with -Os").

A recent gcc version like 5.3.1 doesn't seem to produce much false
positives. May it make sense to revert that commit?

The gcc-5.3.1 log for reference.

---8<---
$ arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
$ make -j 4 -s KCFLAGS=3D-Wmaybe-uninitialized
ipc/shm.c: In function 'SyS_shmdt':
ipc/shm.c:1344:59: warning: 'file' may be used uninitialized in this fu=
nction [-Wmaybe-uninitialized]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0((vma->vm_start - addr)/PAGE_=
SIZE =3D=3D vma->vm_pgoff) &&
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
ipc/shm.c:1267:15: note: 'file' was declared here
=C2=A0 struct file *file;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0^
mm/vmscan.c: In function 'shrink_zone':
mm/vmscan.c:2418:18: warning: 'lru_pages' may be used uninitialized in =
this function [-Wmaybe-uninitialized]
=C2=A0=C2=A0=C2=A0=C2=A0unsigned long lru_pages;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
drivers/gpio/gpiolib-of.c: In function 'of_gpiochip_add':
drivers/gpio/gpiolib-of.c:221:7: warning: 'dflags' may be used uninitia=
lized in this function [-Wmaybe-uninitialized]
=C2=A0=C2=A0=C2=A0if (gpiod_hog(desc, name, lflags, dflags))
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
drivers/gpio/gpiolib-of.c:211:19: note: 'dflags' was declared here
=C2=A0 enum gpiod_flags dflags;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
drivers/gpio/gpiolib-of.c:221:7: warning: 'lflags' may be used uninitia=
lized in this function [-Wmaybe-uninitialized]
=C2=A0=C2=A0=C2=A0if (gpiod_hog(desc, name, lflags, dflags))
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
drivers/gpio/gpiolib-of.c:210:25: note: 'lflags' was declared here
=C2=A0 enum gpio_lookup_flags lflags;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0^
net/core/dev.c: In function 'validate_xmit_skb_list':
net/core/dev.c:2984:15: warning: 'tail' may be used uninitialized in th=
is function [-Wmaybe-uninitialized]
=C2=A0=C2=A0=C2=A0=C2=A0tail->next =3D skb;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0^
drivers/spi/spi-lp8841-rtc.c: In function 'spi_lp8841_rtc_probe':
drivers/spi/spi-lp8841-rtc.c:239:9: warning: 'ret' may be used uninitia=
lized in this function [-Wmaybe-uninitialized]
=C2=A0 return ret;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
net/sunrpc/svcauth_unix.c: In function 'unix_gid_parse':
net/sunrpc/svcauth_unix.c:510:2: warning: 'gids' may be used uninitiali=
zed in this function [-Wmaybe-uninitialized]
=C2=A0 for (i =3D 0 ; i < gids ; i++) {
=C2=A0 ^
In file included from include/linux/sunrpc/svcauth.h:16:0,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from include/linux/sunrpc/svc.h:18,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from include/linux/sunrpc/svcsock.h:12,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from net/sunrpc/svcauth_unix.c:6:
include/linux/sunrpc/cache.h:306:9: warning: 'rv' may be used uninitial=
ized in this function [-Wmaybe-uninitialized]
=C2=A0 return rv - boot.tv_sec;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
include/linux/sunrpc/cache.h:298:9: note: 'rv' was declared here
=C2=A0 time_t rv;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
net/sunrpc/svcauth_unix.c: In function 'ip_map_parse':
include/linux/sunrpc/cache.h:306:9: warning: 'rv' may be used uninitial=
ized in this function [-Wmaybe-uninitialized]
=C2=A0 return rv - boot.tv_sec;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
include/linux/sunrpc/cache.h:298:9: note: 'rv' was declared here
=C2=A0 time_t rv;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
In file included from net/sunrpc/cache.c:34:0:
net/sunrpc/cache.c: In function 'write_flush':
include/linux/sunrpc/cache.h:306:9: warning: 'rv' may be used uninitial=
ized in this function [-Wmaybe-uninitialized]
=C2=A0 return rv - boot.tv_sec;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
include/linux/sunrpc/cache.h:298:9: note: 'rv' was declared here
=C2=A0 time_t rv;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
net/sunrpc/auth_gss/svcauth_gss.c: In function 'rsc_parse':
net/sunrpc/auth_gss/svcauth_gss.c:456:22: warning: 'id' may be used uni=
nitialized in this function [-Wmaybe-uninitialized]
=C2=A0=C2=A0=C2=A0rsci.cred.cr_uid =3D make_kuid(&init_user_ns, id);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
In file included from include/linux/sunrpc/svcauth.h:16:0,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from include/linux/sunrpc/svc.h:18,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from include/linux/sunrpc/auth_gss.h:17,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from net/sunrpc/auth_gss/svcauth_gss.c:46=
:
include/linux/sunrpc/cache.h:306:9: warning: 'rv' may be used uninitial=
ized in this function [-Wmaybe-uninitialized]
=C2=A0 return rv - boot.tv_sec;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
include/linux/sunrpc/cache.h:298:9: note: 'rv' was declared here
=C2=A0 time_t rv;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
net/sunrpc/auth_gss/svcauth_gss.c: In function 'rsi_parse':
include/linux/sunrpc/cache.h:306:9: warning: 'rv' may be used uninitial=
ized in this function [-Wmaybe-uninitialized]
=C2=A0 return rv - boot.tv_sec;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
include/linux/sunrpc/cache.h:298:9: note: 'rv' was declared here
=C2=A0 time_t rv;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
---8<---
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
