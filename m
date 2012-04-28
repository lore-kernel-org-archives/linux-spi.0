From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/6] spi: spi-bfin5xx: flush spi
	after each transfer
Date: Sat, 28 Apr 2012 00:04:08 -0400
Message-ID: <201204280004.10467.vapier@gentoo.org>
References: <1335219493-24184-1-git-send-email-scott.jiang.linux@gmail.com>
	<1335219493-24184-6-git-send-email-scott.jiang.linux@gmail.com>
	<20120427183501.16C8E3E171B@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2879078130461374140=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20120427183501.16C8E3E171B@localhost>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============2879078130461374140==
Content-Type: multipart/signed;
  boundary="nextPart6834147.rozTOTtPU8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6834147.rozTOTtPU8
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 27 April 2012 14:35:01 Grant Likely wrote:
> On Mon, 23 Apr 2012 18:18:13 -0400, Scott Jiang=20
<scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > This can make sure last bit has been shifted out of register.
> >=20
> > Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Okay, so I have a few issues about the way this series was
> submitted, but I've gone ahead and applied them anyway to get them off
> my plate since they look like bug fixes.
>=20
> The problem is that the commit text is far from complete.

here's the original commit messages:

commit b489d522f6445de7261f4e57a52b6abe24717450
Author: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Date:   Fri Aug 12 10:44:43 2011 +0800

    bug[#6683] spi:spi_bfin5xx: SPI SSEL deasserted too early in soft irq m=
ode.
   =20
    Should poll FIFO in last dummy pump_transfer.
   =20
    Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

commit 6201ee95d78b555b656cda6fadb91c031f90408c
Author: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Date:   Thu Aug 11 18:24:16 2011 +0800

    bug[#6683] spi:spi_bfin5xx: SPI SSEL deasserted too early in soft irq m=
ode.
   =20
    Poll the FIFO till it is empty before deassert SSEL in pump_transfers in
    soft irq mode. No polling is necessary in interrupt mode and error=20
handling.
   =20
    Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

and here's the referenced bug:
	https://blackfin.uclinux.org/gf/tracker/6683

and here's a logic analyzer showing the problem :)
	http://blackfin.uclinux.org/gf/forumthread/44481
=2Dmike

--nextPart6834147.rozTOTtPU8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPm2w6AAoJEEFjO5/oN/WBz1sP/0Qqrf21Db45T9HJaWowxmZG
LYuFw/t7FhrZ5AHzYlkRzbglzunl1rRidNKOBawiqni1YcRlBC1Z+aFmmSSH+gAP
MHXZ/kv8CYX87sm+a2fmM6DCZe0zVBV3mXA3HrigDXOhztameqWgRKulKIyEZLFn
9VlLZAyLX071bk/Gom1nhjhGpD3JKNEI5RTkQF0MkcZBVfjude5y/U1pwgkqJgUa
karfwQxblanghKE398ksLarbTbKyJP2u26mCjzQiPo51jGnwAgsUx+dc5nvjMQeX
TB/1ugVji7cNkVBIUq8kotIk+2x73RxJ+UITzfl30MyB44mu544npKQrXoHn7hmZ
gOFXJvzu03T7yEeg+9qC+aH0PUQ+vWqNHAFr/ySBx1XhMCG0wcMlWBsO9xLmoBAr
IRno2gg5Y79ZJNyb/U+cFLu6muuTMHAxQQ467YH7QhWTfrY/3t2kIKHw+Czz7aUR
xOiMHq5XqVim/KZDfSPbPLfFNneeZUhfM2zhlYYF7ilQOMGMM3bQcHbPn5VXrhha
xAOr/oGe2jeeZsJjIjfFhNkVw/Qj/K/FHs1S53Pkg0t3fEwd89GtlZrI39GpWLnm
8cdqK0aLt6zjGqkxUzxSvzYOVRTtgDaOAjcsaOoKCe40VUNjtWZP+Z6/7oCtb2fo
2rp8q/v2YMD1P68TQtAB
=JshK
-----END PGP SIGNATURE-----

--nextPart6834147.rozTOTtPU8--

--===============2879078130461374140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============2879078130461374140==--
