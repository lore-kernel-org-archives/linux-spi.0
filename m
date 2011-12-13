From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [GIT PULL] PL022 patches for 3.3
Date: Tue, 13 Dec 2011 16:00:23 -0700
Message-ID: <CACxGe6tQirUZ1N8CCRFj=dvqF0+3p+B0PyjUk-OmOONFQojpyQ@mail.gmail.com>
References: <1323813960-5519-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1323813960-5519-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 13, 2011 at 3:06 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> w=
rote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi Grant,
>
> can you please pull in my PL022 patch stack that has been floated
> on the list recently into your SPI for-next branch?
>
> Thanks!
> Linus Walleij

Merged, thanks.

g.


>
> The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d1=
39:
>
> =A0Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)
>
> are available in the git repository at:
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.=
git pl022
>
> Chris Blair (3):
> =A0 =A0 =A0spi/pl022: only enable RX interrupts when TX is complete
> =A0 =A0 =A0spi/pl022: move device disable to workqueue thread
> =A0 =A0 =A0spi/pl022: add support for pm_runtime autosuspend
>
> Jonas Aaberg (1):
> =A0 =A0 =A0spi/pl022: fix build warnings
>
> Virupax Sadashivpetimath (3):
> =A0 =A0 =A0spi/pl022: skip default configuration before suspending
> =A0 =A0 =A0spi/pl022: disable the PL022 block when unused
> =A0 =A0 =A0spi/pl022: make the chip deselect handling thread safe
>
> =A0drivers/spi/spi-pl022.c =A0 =A0| =A0141 ++++++++++++++++++++++++++----=
-------------
> =A0include/linux/amba/pl022.h | =A0 =A04 +
> =A02 files changed, 89 insertions(+), 56 deletions(-)
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
>
> iQIcBAEBAgAGBQJO58s0AAoJEEEQszewGV1zb00P/3XkQJ9J/JEzTxkL9Q0YPNsD
> PA0BzF/tJgSGEYN/uFgpJAMFRQrVgQKDOuanIVrx8q6M+R9eeBzhmnu79A1v99c7
> gXELHbPCPLxtQy763w2+TkNxenw9V5yRqxE52+j5xV9lfWx5/EtZtTKw0nJhFYc/
> UV7nqVKL6eOC+qZSZcDohJPWlIB1uYpvuzVOERArwvCtLAGWle67S+MsIDW6vbLa
> d8SnTmFTsrRPFoyUnLSqNN7bOyX7NapRQWnCIIwl+JYa6VmJajIx4RiJmdWN0xse
> WNFU/DaHsohIPE5/m43u1DMQNcmDmvWPbCPuaV2GvjKPmv/PTemGlQOYEKH06v3T
> zPEwKlg6CkQfOIjSnV2tlJmChQQ5QKDccs+a7AuZbJfN/0ag4JXMg5UvwAQmkTVJ
> w/SlLFuYGwpssGhnCoUESjtSbKq3tzu1/Lq3uaewyGwFZDSuLTHJl8T2Xscs5r7j
> l9sAvfy7bhAJU4whAmLVcwmyDJjE2st/yjrXycTv3XiNEZ+H8IpiOkEgWiWufmMx
> CnnbqbzImlvQC+lClSx6xV0xb3GObqF2gvuP/oXuWNIip1pLih62oOFX5ysWdtBU
> fn98HilUDcslKIRo+9gGxRsO5cGE7/jo22mxuzBL1MfF1OBe9855n+cwieHs4eK5
> 89nDCCRE7Q9+BUTjQ/Zq
> =3D0eI4
> -----END PGP SIGNATURE-----



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Systems Optimization Self Assessment
Improve efficiency and utilization of IT resources. Drive out cost and =

improve service delivery. Take 5 minutes to use this Systems Optimization =

Self Assessment. http://www.accelacomm.com/jaw/sdnl/114/51450054/
